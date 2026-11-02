Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605640;
	b=DZDnnq/AlYW8tJHhqHdywFK3x1P2zf8ZA2yBJ5lSPWAVH6zJXkld8DfFjIdFIhKZwVFw
	 mi0aIasViPhJFnNFeYSHbfdtMOM8l93mx5HsykccVWzpujc29U79scVKFXyMIoBfUE/pv
	 Gxxv2OydEnE8rkXklGHRINO+MzwtlC6Msx7BMmeNNheT6jGOIYhmNwXijFq75co1NToHu
	 8R6kiMz0FZ0YpVWcVJSOoFNCKENbk6KFJugwzLXrZbJaYcTt0N70Fdn0Ec3LeOurW7R9g
	 wu5cxS7q1TeOM+BD9VnxLg+mMGeHaZ/o7OhlkqhX74ruwypAOyKzGhSQw6+9w7mBkHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605640;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y3zIi+MkEynnuftfIaqkVqcl50RFP9HMpILDlebDlbs=;
	b=MndyQcQsFMkuQ7kTUMCiINdOmRrLUssEbqU2Lisu102FNIfOmGO6i87Td5t++E4VYS16
	 TklpBnmJtgMYYUkxN9OftOi3mLdOsHL3+sbZvn7eaZTYmfuLYeE9THHMmYFUpx6f2ihtt
	 xy92icFmhr7pTObHTSvEuDCg2vBiVnCTRl+pfqah7HOtzXNH9PK1zeqMUwjhcLXcTRjuq
	 1J5LbAB7gE7ltDKvCgb7BoPb2LjJ442wRmbcjMMPUqLCIT0tMUr7+tWfuXYEC2iGpRyJe
	 c7/GXjmd02w1RSboauxfsgK/bnVcO53hIT1xTUVCSj3GjMuP2HRdr6oQtbEXeLa3Ggw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="rhA/2mYP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.53
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B360A2601;
	Mon,  2 Nov 2026 07:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C24B360A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rhA/2mYP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wok3pdVx58n5DZ97MZSPFQGCeZN79mstsFHzl2bzmYg+h6vQwKA2E2L0WIycEMv+8c5Qbb7zzqtO+AUeK5XWWJf1gWwDa5QKzrcdhBj297PUuWLwu+yrdaobpbX9O+vGJLhmEGe2PWmSOO9JXf2H+7it0/hHjPyGNpC3YCcZJ+1UsP2CK/ho+dR2w3QLxqXB8Srjp3dTqx+Fh0baTCLKD5xQP2FsdF78+qxk4/Yoft6hCOUSc6gd8PCWg+b+rnPYYhnffJQ310eORtBLYgzK6r+zew7ueBmncmeNyZMY/JELVrHO9nESWxlq4Vg7iMLdDkMOAC4SC9i//l9JSH7prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3zIi+MkEynnuftfIaqkVqcl50RFP9HMpILDlebDlbs=;
 b=pn6wc4Ujln5TzKidnGGWJfOWfhPFI7n5hkFlfpSeOVuMW1hML24caqrWIWgjpR19Y815BqG01z2MtxspvdXLD4YGpj0fJf2cvaEM3FezBG5Ow17qXl2d4cr4qu56Rcc3gitnP+U3ch3zmsXlpWLj59+Wwa5NKOxZg83VqNb3ZFHeW+vQeIPeXJJgcJnMo0D6D4925qqP2u1YLyuiaf2T8xoyq5ZFLiIiTjjcvVAlMsf/PRU2gJffTJKaxXqDCVERfUra0hT6Th6f3QQ9eNknyh8a4elzYHBt7HyAGJXlyfcBCN60hWxs2bhVAMSzEwiitSWt7e6sTw0HDLYOR4d1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3zIi+MkEynnuftfIaqkVqcl50RFP9HMpILDlebDlbs=;
 b=rhA/2mYPJ0FviA/5TbelM9Eh3Ewn66GdhUud+anDuT5txmQWRssZf3IiDwq69I4/1DwW8aoRSHgJmc4w8U4sx4PV2RUe6yGmiXWW5TceDHUwk0QSrdElBDTFxNG+wmsm6wkzjdckzvkHzq/XWL4g+gkFAFhNpjDRvTi02/62B+2PL0dwX2D6Ye45xnxdzR+xqIb+gbqOdFwBnVGOn8D0KOfNv5qchRppN5ZDtxctpA1Tv8m0a6m2h86Fyuo3PzN2WU5V87LZgEkXSgF1DgN2qB/SCxV1yE5Yc6rYA1IA5wSlA61E6YiTyfC5tdPD6Iifn+GdxRZ2GsF6wY+qfL7oTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH9PR12MB389485.namprd12.prod.outlook.com (2603:10b6:610:312::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:47:16 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:47:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH 2/3] soc/tegra: fuse: Store Tegra114 CPU and SoC speedo values
Date: Mon, 02 Nov 2026 16:47:13 +0900
Message-ID: <9hOyUQJpQg-PaQkToACCxw@nvidia.com>
In-Reply-To:
 <20261029-upstream-speedo-t114-v1-2-81457cc9d94c@tsv-stahl-riesa.de>
References:
 <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
 <20261029-upstream-speedo-t114-v1-2-81457cc9d94c@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0235.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH9PR12MB389485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec80104-50e7-406d-31a0-08df38b583d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|261021121427099003|261026121527099003|261022113327099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	uTJvURPkkQyXbQCsCjCpWqzxqkjBGlv7yI2T5Tdvtr3xdx090tT+lWOXyB7TbFXD4DySbGy8QufE3AjuhP6t13Hmtf5XEfiuwCLbfAyi4hl8b/BubygVHrFY6gqNdoqb0lWLHGRClyb+B0k18J9eTkxn2yak/NzXTiLCJ3BXVCO8f3NodQSP+Y4+L6hmQ6No+kSqh7BKe+pxKYLZCUSoIwRBCjOIBX0q8e9LcIXSOIkPgliRuQ3jlRbvbGxNxmKv3a0PYUx59CKNvfjsS1G4v5ng0oiPZBMyZyM13EVyrJOxvToXtgd+70EXvu24LK9eMtWXlAPQi+Z+WykFMwygWofSQ8xVrhYXWalQ9+ONv84dpr9CY+zumg+QakYNfmokXjjeR8KMiKRnEzfCdnsuET8SCeh514HwsoA0Kk3uMytQuFsa4gDO6LpuXPjiKyNXc7fzrVLBmIcOM0D5wFwf9/BYw7rjUD1CNUdDxp4dagtEbIVSpGC8XWtbSH8Kz3s+PgtKhfhl6zRl7j9VON1vaVkLUqDjpjV5i0MfuCBRH5/lJCK3wl8BwduPafEghAhHcITohZzprXQ6+oci4tOMK+HHuG0AUI6mLGNwFO6r3GVONNBsk6gbsGNnc4gBeKxLKEpry0YmyOYnBiwP5VQSTeD3HqRgst0MvBASoqUk06U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(261021121427099003)(261026121527099003)(261022113327099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTVuWmNDVWM3YTkwVUdUVVdEZElDalRhL2g3YTErN0h5c01HTUdFN3JrSHFQ?=
 =?utf-8?B?THUzRCtjUktZU2sxN09ad0hXUExINGVjNk0wTkFrTnZUQzZGa0FFbm03Vi9S?=
 =?utf-8?B?WnpYQ3lKZnk2L0V5SGZrOERsUzVDZFBaN3VyTTBtTHlaWDhZTEJQK3o0bm5j?=
 =?utf-8?B?MW1qMlJLUHhobERlVDR6SVB2ejZNUTVFYVZDTXRUZlRGSXd4YXh1R0FKa1pU?=
 =?utf-8?B?QytZckV3Qkk2YmhnYlBWR0JCRUtsb3EwUnQyRTJSb2w0N2pkU2I0WU5sY2NM?=
 =?utf-8?B?L2ZUWGUxMzFGTnczTnYvVEFyNkxaR3A5Mnk0ak9uV3RBay9ERGRYQkswNy9R?=
 =?utf-8?B?WThNK2MwU1JoNHhiUDZBNVN1ZHFkbXV2R3lTSThtR0hMeFpWNHpRK09xMVVm?=
 =?utf-8?B?VkpQY3lqMHFYWnBZc3lsV1ErRCtvTTEyU3VYNXFzeW5tYkplckJTYTdBM0dv?=
 =?utf-8?B?NTBLRjYwSW1UdE5oZlJzdzV3TCs2c1hDUkxFSmpnazJFS29PREkxd1ZGSVQ3?=
 =?utf-8?B?MXRyaGZycmNMazVOVkhzWWVRek90TTZCUlpxUTZtQUdSM0pZYzNVVElZUUhJ?=
 =?utf-8?B?ci81aXRQdU9DN0FLMWhISkRhTC9NSzViWFordk9Hd3NFY1M5bW9IUVU1MllO?=
 =?utf-8?B?ZHZESUh5ekZ0a0s4WkI4cW1XMFBOT0R4eFJUTUN4Y0VOWldJMEtrSTdKZUhz?=
 =?utf-8?B?RkU3aFVhUEZjamJCcWk2MEpDdTJldnBkZnpvdkZGNUVMdFNIVFF2TG5JWXQ4?=
 =?utf-8?B?Z3FrSjVBZDlXRHdXaEFFTjEvdUlTeEluam50K3lJc1dVK3EwN2FXK2cva1A0?=
 =?utf-8?B?Tlpnc3JTa2s2MkdtNVpQWlBaNXpsZFNYTnlCNXhuRnZIWWJETXZ4VEtZa043?=
 =?utf-8?B?R2RrRjZaTWI5eHVzam5ZMHJkbVE2U2VoQ1NPellOQUpPa0pUcGdvRXJGRXBr?=
 =?utf-8?B?Y09oYUk4b3g0bUtIdk4xSG1IbTFoemZrNHhiZzQwVEl4emhGemg1UzJwYW4r?=
 =?utf-8?B?NEdLTkN4VkN6TkFVTmxudlhzN280a0pDYlhJRHh0dW1WZnZiLzFtc3RmcWN2?=
 =?utf-8?B?NzQrUDFNRElhckVaSDVqN1lYVk5yS1dHZnh6eWF0VGJJY1dGUkZYSWF0dnc4?=
 =?utf-8?B?ZDEvWXgwRXRmVXFNL3NOQVFkR2VnMFlRcGVSM1luYVp6R0FqbDZPckJVejNh?=
 =?utf-8?B?VFRBMXdNYkpaS3pRbjZWUDBwUU9INERkVlpWckNXNjh0T0ZyYVB4eG02Nmpj?=
 =?utf-8?B?VnNnUjdacFhaNjA3QzZmUWRGTzZwK3U0anVUZkVZRkxyT3RtUWMxY2phNTNC?=
 =?utf-8?B?UkFGb21QZndVWTBEZ0lubmEzZXJsQ1Fpdi9NS3YxN2VyK2NNQzNDRTFLRTlX?=
 =?utf-8?B?Wm1qM1ovVEpXYUFhOFh4UnFLUDhUNG1Cb0ozcVF6YUZZQkRhM1NVYkZhM0Nz?=
 =?utf-8?B?ejJkV1ZxS1lkSlpXMi9JZFV4RzQ4MW41WnRVaDNkY2lmSllodE1KNXVBY0ZN?=
 =?utf-8?B?YXlBNjNpRjl5VUpJd1dtbEtxZUhPejdwYjJlQnVTcCtjWVVxTEJnK0R3ckpI?=
 =?utf-8?B?MzREMmhpZGlOTDJxSEtHSWlBdDl4OUVpbTBMc282L2RPckd3cUgwc3l5bFlN?=
 =?utf-8?B?TlVXVW1Db3pqQ2RUS0RqSHJWQjRXbUpxUDNPMGdMOURuM2V1d2hqa3JYT0FU?=
 =?utf-8?B?bDNhdVR4TTljM1dMa1U5Si9sVytSTzMvU29mOFhWbHNnUzNENkxrWkl2VzFN?=
 =?utf-8?B?WFR6M2RYMzJacTBORkVGYm9aN2VVNEMzejlpVDVhVTBYM3JrMktkMVpNV3Mr?=
 =?utf-8?B?U0wyUm5tdC9tNUJYbUVxZVpQRWlvYkxlb0p6WUtaVTFIdE5uaGdaMDhIMkg0?=
 =?utf-8?B?VUtjQS9RcDh2eFJzUmVLNGhMaWUwUC82dStFQmZBRmJzRHB0ZmFjNG9Yakhw?=
 =?utf-8?B?Ri9pZkRuRW9yYjcxR2dDYnpKMnp0NFBEdjhGb0NaSHZlTlVvdE95R3N3U1pF?=
 =?utf-8?B?YW4rbS9CWTUvdEZDVUpSenRNTm1HMm1Gb1NvRDd2MWJCNTVOaUY1RG5SSXNM?=
 =?utf-8?B?RmpRNlR2MnQzU20zTFZ5UnU5UC9heXU0K0lMRmRVSEx5Y0RwR253c2VUdzJk?=
 =?utf-8?B?V3hBeDdqNnMvelVPVitIdkVnY1dxWmdQZVdpb0dTTWMvQzQ0dUZMcGhjVVFO?=
 =?utf-8?B?ZXlqOWhZenhqNFZVeWQvUDlGWmhPNkdtT3ptc045RGN6d0YzRk1JTTUrdE56?=
 =?utf-8?B?dXM1cm5BaGEvL2h0N2pQK24rOHhvaWp1L2V3NnV3QnRFWWRmUVV2YzVIOElK?=
 =?utf-8?B?U3Rla1dwa0pvSXpzNytYRmlNcENkSk1SUVdXRTc0SWZyKy82emdDY0IrSDBm?=
 =?utf-8?Q?QlFSPIsttEJbDZkkHJOBNzo3JqX/Z19JYcOdU9ZnaXusP?=
X-MS-Exchange-AntiSpam-MessageData-1: BOKaKMebcBsL+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec80104-50e7-406d-31a0-08df38b583d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:47:16.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOKPrYhXEMKc0CEgY32+3T7lImIe4lOcqeQAshkJsN6LS0HqBJFVgvS9gCNFoSlxCQeVE/QpFYc52wqeMCALHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB389485

On Thursday, October 29, 2026 6:33=E2=80=AFPM Patrick Fischer via B4 Relay =
wrote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> The Tegra114 CPU DFLL computes its OPP voltages from the CVB tables
> added in commit 5aba939e80f4 ("clk: tegra: dfll: Add CVB tables for
> Tegra114"), using tegra_sku_info.cpu_speedo_value. The Tegra114 speedo
> code computes this value but never stores it, so the DFLL uses speedo
> 0 and only the c0 coefficient remains. For CPU speedo IDs 1 to 3 c0 is
> 2190643 to 3395401, so "mv * 1000" in round_cvb_voltage() overflows and
> the OPP voltages are wrong.
>=20
> This is currently hidden by a zero voltage step with Palmas regulators,
> fixed in the next patch. With both fixes the CPU OPPs range from 1000 mV
> to 1270 mV on a device with CPU speedo 1742, which matches the vendor
> kernel.
>=20
> Store the SoC speedo value as well, as Tegra124 and Tegra210 do.
>=20
> Fixes: 5aba939e80f4 ("clk: tegra: dfll: Add CVB tables for Tegra114")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/soc/tegra/fuse/speedo-tegra114.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra=
/fuse/speedo-tegra114.c
> index 1e6c2b5be759..8bf1a1b1287a 100644
> --- a/drivers/soc/tegra/fuse/speedo-tegra114.c
> +++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
> @@ -92,6 +92,9 @@ void __init tegra114_init_speedo_data(struct tegra_sku_=
info *sku_info)
>  	cpu_speedo_val =3D tegra_fuse_read_early(FUSE_CPU_SPEEDO_1) + 1024;
>  	soc_speedo_val =3D tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
> =20
> +	sku_info->cpu_speedo_value =3D cpu_speedo_val;
> +	sku_info->soc_speedo_value =3D soc_speedo_val;
> +
>  	for (i =3D 0; i < CPU_PROCESS_CORNERS; i++)
>  		if (cpu_speedo_val < cpu_process_speedos[threshold][i])
>  			break;
>=20
> --=20
> 2.56.0
>=20
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com> # Dalmore



