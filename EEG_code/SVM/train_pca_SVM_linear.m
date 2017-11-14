function [pca_SVM_lin_model, pca_SVM_lin_accuracy] = train_pca_SVM_linear(trainingData)
%% linear SVM, dim = 200
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: a matrix with the same number of columns and data type
%       as imported into the app.
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationAccuracy: a double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a matrix containing only the predictor columns used for
% training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 14-Nov-2017 09:40:17


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
% Convert input to table
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200', 'column_201', 'column_202'});

predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_202;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationSVM = fitcsvm(...
    predictors, ...
    response, ...
    'KernelFunction', 'linear', ...
    'PolynomialOrder', [], ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);

% Create the result struct with predict function
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', predictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
pca_SVM_lin_model.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
pca_SVM_lin_model.ClassificationSVM = classificationSVM;
pca_SVM_lin_model.About = 'This struct is a trained model exported from Classification Learner R2017b.';
pca_SVM_lin_model.HowToPredict = sprintf('To make predictions on a new predictor column matrix, X, use: \n  yfit = c.predictFcn(X) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nX must contain exactly 200 columns because this model was trained using 200 predictors. \nX must contain only predictor columns in exactly the same order and format as your training \ndata. Do not include the response column or any columns you did not import into the app. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
% Convert input to table
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200', 'column_201', 'column_202'});

predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_202;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(pca_SVM_lin_model.ClassificationSVM, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
pca_SVM_lin_accuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
