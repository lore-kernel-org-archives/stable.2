Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823058;
	b=eQgMTyMiYyv8AcdexvsIaIBGZ1q30vTmMNLx/+K1Y9jNARkvsLCv+UhKF6B4JBNfbf57
	 fFK8ds97O38gOGqn76K7rurnJ2Qc6bqiWIa5LKsagtYW9p6dPZZd/0pJRLiD7/hiTlukN
	 8ZmtxNmydKSyiCux59VcfBVN3yvRqWuUWrCFEuW44rgNLvx0cNrpCDLbsTskl3EBAK4BJ
	 yh+ecb+WN4ik09OuhEwtnVd49BtR4zJRrcGhAaHQliXuKdeTUrBluDUvxCkt7kVQPWKgu
	 4gtuuJLN5/icsFwHuvBnxusPt7zS1Eooy7JJhwVuEYvUIgGgtTL87aFEdF8f0FyUIPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823058;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OMJR01tGfR6XPKYp+X5lr64RnT2A0RVc996lQeEafak=;
	b=kf8a8eJeZCbBHcEnv2XkiCFeznnHbPazpVwWIYZS6eyQV0S77POLfM3FKLiZY0bRMqZD
	 +0pJ42ssRDrpBDM/RTxfJzFaFoxy/VRq9qD3aruWTXkOFFdq/o5Pgk85mFN97mWOBHUXx
	 /3ShGdinbD4ZhQezJ4lwCdcfu5a2dtNc6FnnGKfh5U9rShbYYbaEeU7/H8l+siyX51yN9
	 ulyemeCRdkWEWlmPRlHA35mljvgjIvHfZrnDWX725cdIVr1jTdXhvyQ1OBNM8CJBGlIjG
	 v4+JifO0D6+YmrFoBFImGsFNifljJtYaA2nhfERDByoSaay8P+aeTKVYNs4UrnDw2fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=o63iVVb4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021103.outbound.protection.outlook.com [52.101.70.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEA606A333;
	Mon, 16 Nov 2026 09:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34DEA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=o63iVVb4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaxRjJZAB4/LOyb/ZWf6nzKLLdA/TMqZjSfCfEEpMKfuIGTQ89YR8HpLDznJKoQAZPL30KRGJp9aq95wh+3VoqLELEORWe4VfLtDbVkHDiaYHcFJ5jsp8R+5FIwZ0R8XJyHlSTLhMiZ+q7UHaDy5Ucwod2pfHrUe+aL5p9XFro0kB57J5WAAMs+COaf5nt6H8e7iL+wwgK3dpY2ntWRyEfylo0wvMeOAiW4LPeEE4g3bDIgoiiVbRNSLSLXXFf+POwOaqsq0l1bUOQc0Qcwqw8JuNfylGWpowIkC+iWiDBfTgPZll1zbohUVySxF676KYf8ZfRSWeYt3SY2ObS98bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMJR01tGfR6XPKYp+X5lr64RnT2A0RVc996lQeEafak=;
 b=zSTk1XaDvbaJOLch8DhE5LCirozvN6GadHa7FCi9nmRT6XzVUaviAfGjH9PT44VzINgftRo3+mA0F30uMZAa/LS1ILQkHRv+y35tvCgfGbRgo+CiWdbbCr1Hm+HBQQdR1AG5HlAhlOvMwrC9AVjD2c6CMXuyiLrLWgkAupEIexgxfQjvHpHzNXiwKZbqT3XpWkruVsKgIc1DYY74yivNInKFoUFEmPYjlzdWE6seIxDkZMcwUK5Q4GcY7cfZgMxBYSuegPx73Lp5ueOR+APsdowzgBtlr0tFa9onE9Q2FDVi4Kj1HNu/d822PH1d8CV1o1TLeVyvZcEeSvbJyWBRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMJR01tGfR6XPKYp+X5lr64RnT2A0RVc996lQeEafak=;
 b=o63iVVb4L4FDnH6fgLpW28ussChJlI6Wx09SoI07FUH1LfGOe6U6KcrA+wB3EvKi0HVZStBas6PJrcv5QFRGENSyaXJpd5aL3jmu43xeeVwzZ+S2/UQz48r0MaICezJ1HQk+sKLimzJrXh2y0hvRsvc3/3F+4a2fkYwX0umSvAfXOPA/Z3pjzsn7V7txiqvO/a6i445JIcC5NZsRzL29a893DxA13I6zIRwEHTNEzpTmMEdtKewVlB+P08sz2UFyo6dkxAdxui5VJuOyFyFiaqin7D7AC09tS2fmruov6rPX8cCm4naPec6KF2nHKqCthP4N/DfW423J9X1VpyKk/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7541.eurprd06.prod.outlook.com (2603:10a6:20b:33d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:57:32 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:57:32 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 16 Nov 2026 09:57:22 +0000
Subject: [PATCH 1/3] serial: max310x: do not advance the TX fifo past a
 flush
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-max310x-tx-fixes-v1-1-61c01f180911@vaisala.com>
References: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
In-Reply-To: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823050; l=5719;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=fZvX3tyRBXdZROy9Iqb6+M2b+LC3HTxFI7tN1ikb5ME=;
 b=gvRMcurCA1/tws32jwijEM6afD4EFPktGTalHf1RJRY0ZqGC3polhrPw7rdaczyKbqR5JZ7rx
 crgpiJI15LYDdEvVqf9KRDQ2M86pg8dAgr8egxMzCCEllzZYI/P74PH
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::10) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f200ab-9837-4aa7-8a46-08df43c80823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|261022113327099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|11063799006|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	jYlBW1sZUVuFt+8kilD1Bn8G1CRyVdIP9KLTh/vC+M2XGFmAHKFcnunBuJnoFSD2rP8yWGJFCAsmif9aaPKHH2DTwA8saOLrFa3+icN5XGewsYW/+z7oHq41AHsb0H9xuvAB9sa87f8JYAr6TDTttSfVo0+TH5cjYEc44mkigen/ReK+ygC1MMPV44cEVTcZ61iWIdwgKVUecV1DOdJFTV5okL8sVwhsDrnXsm3KFA8m6LXh32Y8CXrN104LczCrpshJKhQbMzf5yPe4BA5CpPVrYKV2fWfb+aeqxo26/4MdsGAFJLd844mtPD4+dBAtmPJWZEzxC6PPpWv3+e3c89XSJjiOvIMAHJgLG3YFkI22H+RiT8VjjNNlusuwDV9NaZQCNqS+nNBSpJgGFzorS6pVvdWoLF0bUGiKON01Etm9Rw15OwHk6bXU6FeulEbm4wn9zQaZg5x7tJ1pLFESb7j9Ys+pqo1mM3WnWHhx2RSnOYWjB6PycDJFIWPcDdx5Oxrp3Cx/u0wY9mF/TMtm4FBh8/DVh3/3C7O53IaZYblhplMR7+ws2eUjiu2gQz42oLxMJZLIaZbmmcxRWP15JILrs6/6dASznK95FDhtsNm6iQX2O54Mm4FYXP6Lc+Vz705Ad+f6RAfmOj85IkinkRlXM7xyrednsnTzIrHlk8Irsiv1ISQUim7ECz5mVC1ShciZlIEvXCjTw6lL+w8lg3feNZ39eAZCFHJvEl+GlE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(261022113327099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVVteFJFcXNGdTJGVENyWEdPNEFJUWZlZE9YQkcvQkg1ZjdlOFNDR3oxMDF4?=
 =?utf-8?B?NXpjS09YMkMvcXFONzVyOExOMG9qN0RRd3dnOWp3RWtHcWNyN2N6UGpYUEVo?=
 =?utf-8?B?eklkem1XVmJsSXFqWmtsQTZKQkI5cFRXblBVTjJ3ODJ1aVQ1eHpsYTFPMmN4?=
 =?utf-8?B?R3pOYVlmMlF0cHU2TEg5b1poYjdCNUVFQnA0UkhlQXJIL3p1NFlueDZXVi9P?=
 =?utf-8?B?blZtam5qamJLVXFKTWhoQnBrWXkwUXZ1RnhEMXJ6dSs4aTBwODBxR1hEdFhk?=
 =?utf-8?B?QU1yUXpDeVJLSTdoRXFvZlZEc3VVbjN4dEdxQWJDV1VheDE4UU8zcTlwSVBk?=
 =?utf-8?B?NXBGQlY1Ky9MWFFrOHVYNFk3SmdOWEk2NzJpRGtPK3dwdW1wQ0VJODRVR2R1?=
 =?utf-8?B?c1AwWHlmT0ZIRDVRR0xKZ3o2U3BuUzJkeTF2VTRteEJqY2dZREY0UGhSa1di?=
 =?utf-8?B?Wko0RFJxZGdaTDFNVEJXYkZlVndFU3o1emxhdGV3bWxEcFBDUUo4Zk1aNG45?=
 =?utf-8?B?UEpLaEhVd0d1UnREMS9GbkdHUVZhemN6NTNDK0N5c0t6UGZjODNGVUpwZFVr?=
 =?utf-8?B?WFkrN3VXR0NPemtPenhyVTlMeU9TWFVsRmM4OHAyZzdVd0ZlK1RzK28xaVQ2?=
 =?utf-8?B?YUc5QVcrUjZYeFlVUWV1c2d6ckxraTJXY201alVPUGRyVkc0ZFdGWU5GZ1N0?=
 =?utf-8?B?cGVYcStrYnV3VitadFUrQ3V6dGRpbVM4Y0QwdTk5Q1V2dGd3K3pjdDczS0xX?=
 =?utf-8?B?Mm45MHJ2ZjZhMStDRWUyVE1MU1NIOFlQa256MmxhRXVkZmlVTmpJbWt4b0FY?=
 =?utf-8?B?R0g3bTNkdkpOYi9kUklUS1NHcVJvNzk2dDVIUVU5TitnVXIxYTducWVMUEww?=
 =?utf-8?B?OWxKdjRReWRFQ2ZqNG80VDdETUhHWDVYUm1hM3RrYklzY04xMmRUVmtQTXJ6?=
 =?utf-8?B?bWFCTGN5ZWtTajVBRnNjUTkvcGt1c0o3RXFYcFJsMlkvR3pSN2VweW1RVVBh?=
 =?utf-8?B?SS9KUVR5YWtWMElIQ3A4TXlVdEZ6UkV3NjQ5S1gzdC9TT0VaZiszSG85UGoy?=
 =?utf-8?B?SlZOSlVxVnRyeGJMZ2w1SWVlaDk3NGkwTGpLdWRTbVl5bGk3K3E1SlFETmdT?=
 =?utf-8?B?VEI1WlhEK09IYWZteVJxYThSSlBwWUVzWHllL0s1V21DNDdWYzQ1Nll4RlR3?=
 =?utf-8?B?VEVHODlyV2UyNXgyVUh5TVNoQTVDSCsrNlhXNGxRSXNvV2VXdWE0NUY1ZXN6?=
 =?utf-8?B?eS9CbzFyMHJLeW9oMWlZQm0vaG9DbXU3OUNTaGNUQ1YzSWJFVEVBTWJ4V1Rj?=
 =?utf-8?B?bElxWnJXbEFxZnNMYnVnck9PQnd5RXpWS2hpalowNjlFaXRML044ZjBwMHBl?=
 =?utf-8?B?d2RWYklIbHBvV04xVVMyblhPTFdzMkFyMFpZVjZmQXJjVnNGZm0vYW5JM2Zs?=
 =?utf-8?B?TzBOZS9QOFNmck5lbUNTVm5UelFLbytKT2ZwWHlKcWpWMk5Ucm84S3ZtYXJ6?=
 =?utf-8?B?MGZjdVdraUswTDAySEhrZEJxcmJGQ042eEJZSlBUQkZwWVBVcmoxeHc4YkVp?=
 =?utf-8?B?cXR6UHhUMkw1cnB3elhGcTkyQ2xGZ1hrQjhXRE9RcEN4eUErT2kwN1pKWTlk?=
 =?utf-8?B?b0hxcW9HRmRQQW5wdVZwTnM3THExbkdpNU9HYlNibHJFcjB1YjJmbGJwRmJF?=
 =?utf-8?B?cHhmdk9WOTBOdnpsSXBoNXFHN3Q3RTVHdjE4NVg2QXp3RWFXYTBIaXlBQjd5?=
 =?utf-8?B?ZnJ1ckhobVpaZXhYOVVLVGliYzcrSXYzbE1Yc3dOdGVVaUF3NHlHbWhjL0N6?=
 =?utf-8?B?dHFBQjRXUW1hczdVcWkzUXQvSEFhR3oxT1c0alRJV2FLREtUMFQzMHZtMVo0?=
 =?utf-8?B?Qk5lZ0sxOWJrWUZuLzhFcy9JWnRGeU1UeE5adDkyQndpaDYraDZrUTlMUUdw?=
 =?utf-8?B?TWd0RUNMSVhDK2QzRjR2MHA0WmgrVDdEN1VpclNpdG5sN2hlZjhOcmdUWmNP?=
 =?utf-8?B?RHErVWNFend5aGpYOFJBQTVhTExQeUg1d3BWRm9ORHZLenlkS1FDWlh1dXdr?=
 =?utf-8?B?SU9UdFdsMDJhRzJiOGUwMm91VzVaSTlhVjFoN0huSVhlMys2Z0ZtSm9GRGxq?=
 =?utf-8?B?VUhURlpUSWUzTVg4eWo1M0xPQTR5d1VRTzlYQmZDaXhGRDlGdUJQNjliUXQ1?=
 =?utf-8?B?NFZ1alplRktiRzRFVGpYT2Y0b2RScFZ2M0wxRnE2OWNPY3lvc1NKUEVBQUNa?=
 =?utf-8?B?Tkl4YUxadlFPb2tCSnZLbUJtVWd6NStuSXFtTGNqVjFTVzlYYmFtSWZCMEty?=
 =?utf-8?B?eGtoOWwyMXA1c2YvaFZUN2xETmswM2kvT0M4aEJQZkZRSCtGdmZtNjQ2WlpQ?=
 =?utf-8?Q?5xxIckIPg8wrbaFk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f200ab-9837-4aa7-8a46-08df43c80823
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:57:32.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DQxu/TBY99YvK4N17bb9OwKQviSIomrt6EB3jqKzH9OG3aWy951LED4XGexuYQzgwgunQ/EHBGLGA/WvlMQYuJQIcGX47YujcrTOfdstI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7541

max310x_handle_tx() runs from a work item. It peeks at the transmit
fifo with kfifo_out_linear_ptr(), writes the bytes to the chip over
SPI, which sleeps, and advances the fifo afterwards with
uart_xmit_advance(), all without the port lock. uart_flush_buffer()
resets the fifo under the port lock. When the reset lands between the
peek and the advance, the advance adds the chunk length to a read
index that is already zero, the index ends up ahead of the write
index, and kfifo_len() wraps to a value near 4G.

From then on the fifo never reads as empty: tcdrain() sleeps forever
in tty_wait_until_sent(), and while the port stays open the work item
keeps sending stale bytes from the buffer. Observed with a tcdrain()
in flight at 300 baud when the port was hung up by an unbind, which
flushes twice: the first flush left 498 bytes, the second found
4294967217, the draining task read 4294967276 and never woke again.
Before the kfifo conversion the same race left the circular buffer
with up to 4 KiB of stale data to resend, after which it recovered.

Copy the bytes into a per-port buffer under the port lock, send them
from there, and take the lock again for the advance. A flush_buffer()
callback records a reset of the fifo, and the advance is skipped when
one happened during the transfer. kfifo_reset() is documented to
require that no other thread accesses the fifo, so the consumer has to
hold the same lock as the flush.

The bytes stay in the fifo until the chip has them. tx_empty() reads
only the chip FIFO level, so taking them out before the transfer would
make tcdrain() and close() see an idle transmitter with up to one FIFO
load still to be sent.

The lock is not held over the SPI transfer. regmap hands that to the
controller straight from the buffer, which is why the buffer is per
port and not on the stack. The copy is limited to the buffer size: its
length is derived from port->fifosize, which TIOCSSERIAL can change,
and from a FIFO level read from the chip.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 46 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0ed70185555eed745d905b36c8b8f162468dd6f..e6a740295b96653281a92f8d94999f06c2c74685 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -317,11 +317,13 @@ struct max310x_one {
 	bool			sw_rts_during_tx;
 	bool			cancel_tx_delay_tmr;
 	bool			tx_teardown;	/* envelope being torn down */
+	bool			tx_flushed;	/* fifo reset under a transfer */
 	bool			rs485_pending;	/* rs_work not yet applied */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 	enum max310x_tx_state	tx_state;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
+	u8 tx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
 	container_of(_port, struct max310x_one, port)
@@ -911,6 +913,7 @@ static void max310x_delayed_stop_tx(struct uart_port *port)
 
 static void max310x_handle_tx(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	struct tty_port *tport = &port->state->port;
 
 	if (unlikely(port->x_char)) {
@@ -931,23 +934,41 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	/*
-	 * It's a circ buffer -- wrap around.
-	 * We could do that in one SPI transaction, but meh.
-	 */
 	while (!kfifo_is_empty(&tport->xmit_fifo)) {
 		unsigned int txlen, to_send;
-		unsigned char *tail;
+		unsigned long flags;
 
 		/* Limit to space available in TX FIFO */
 		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
 		txlen = port->fifosize - txlen;
+		txlen = min(txlen, sizeof(one->tx_buf));
 		if (!txlen)
 			break;
 
-		to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
-		max310x_batch_write(port, tail, to_send);
-		uart_xmit_advance(port, to_send);
+		/*
+		 * Copy the bytes under the port lock, but leave them in the
+		 * fifo until the chip has them: an empty fifo with an empty
+		 * chip FIFO reads as an idle transmitter.
+		 */
+		uart_port_lock_irqsave(port, &flags);
+		to_send = kfifo_out_peek(&tport->xmit_fifo, one->tx_buf, txlen);
+		one->tx_flushed = false;
+		uart_port_unlock_irqrestore(port, flags);
+		if (!to_send)
+			break;
+
+		max310x_batch_write(port, one->tx_buf, to_send);
+
+		/*
+		 * uart_flush_buffer() reset the fifo during the transfer:
+		 * advancing now would move the read index past that reset.
+		 */
+		uart_port_lock_irqsave(port, &flags);
+		if (one->tx_flushed)
+			port->icount.tx += to_send;
+		else
+			uart_xmit_advance(port, to_send);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
@@ -1094,6 +1115,14 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
+/* called with port.lock taken and irqs off */
+static void max310x_flush_buffer(struct uart_port *port)
+{
+	struct max310x_one *one = to_max310x_port(port);
+
+	one->tx_flushed = true;
+}
+
 static void max310x_tx_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, tx_work);
@@ -1732,6 +1761,7 @@ static const struct uart_ops max310x_ops = {
 	.break_ctl	= max310x_break_ctl,
 	.startup	= max310x_startup,
 	.shutdown	= max310x_shutdown,
+	.flush_buffer	= max310x_flush_buffer,
 	.set_termios	= max310x_set_termios,
 	.type		= max310x_type,
 	.request_port	= max310x_request_port,

-- 
2.47.3

