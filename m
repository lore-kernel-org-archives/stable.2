Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239482;
	b=jDjEvFmRKhvt4rhwy4K/bxnjyHkxRns2iOSZ8RH7tFYpIoXMO5XRqQhitbULNWWwFqgl
	 jhoETaiW5wEgx4PR4uO5hQwB3TuxKvpcUbA4p0s/HU8XTkNSqpSMEurvFfPCyiByv6Tp7
	 RkH3YtTWOLg7FUIpopdTvTGI1V/H0vCvPpMEIjEpfK7gZTorbfprJL6/tkTpxcwGdDMon
	 gI/Z0JOPZl9lkZ1WsRkUccrUAGzmfgzByLmfrZria4/Sda/+LtbXPqz60vpKKJmXoKpDx
	 tZjDCCXlDWCI79cthRK7s/jjlK7/pz2iqt3z7KC1TotD4CP/b5xRX+M1PIFRs9jmD7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239482;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3SXOqZQW8TFzB7HBF7y4nHtxEVOWLOpgecyDfs2gPXM=;
	b=Dv/U8/y+NEVG3qYB7dMUbS0/dLKPuHEFmyXqOoMbyPhk4NRkPRQ+k4bnRo7yLgJ51IRm
	 BoN5y0gN6AAN7dUoGa3v4VerXATr6a8qBxyJg6XXh4895ZLDKSXXpqNmkrQqYKNPEgg8s
	 8X6T8x5zEUgQwm2qGJO2rHbKTU3I0NaZvn7Vi67RiaX3q82jhDH1qGnp3UeEvl/GuPIJ0
	 aPPtDrMb64jrWOw+TwuVOUuSJnnMpVwjL6Fxt0r77IVZo78bhzxKuySL58OzTm3r4eHve
	 IvCOrXhWMWxqMCF7crZQwFOE/wSTvFKlPJZEiGANgz2WPE8FT5HAWjrOfAeyHPERhUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Rjonf9eZ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=yKR0nIx1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D4606A321;
	Mon,  9 Nov 2026 15:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Rjonf9eZ;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=yKR0nIx1
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9FZVSn3038065;
	Mon, 9 Nov 2026 10:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=3SXOqZQW8TFzB7HBF7y4nHtxEVOWLOpgecyDfs2gPXM=; b=Rjonf9e
	ZkJw/psCtIBuiOcBOBTS+zhwfRYezs0WZ1w3vH2j6hL8jxdoi0Mjto7QfdhqC0DH
	sFSZP3cqA1omTqLYjT3FRz1M4Zj3ALfxfqfAw9M0L/iYv5jACEUiSiXQDNVsqIBg
	pnpmEetK003gVGcIBS+yjfo4ubBsk3GSVVBvXXGvxG3Y6lhDqHiYuXiwZSqsOwkv
	r5MB+ilhHep6Y74+eXMZIwUVuliKycqk9G4ZHJpLlZvIZD68m/kKM2Y3nXVU8NS/
	2FasteMFx9siWGV0ZJ6Fawgs2jq4khkIi8S2IXxjJ88luk0RNDgrJb6H7jIba5Gm
	l4r5GDp+UqD8H8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3SXOq
	ZQW8TFzB7HBF7y4nHtxEVOWLOpgecyDfs2gPXM=; b=yKR0nIx10V57MiHb6iVot
	dB1pIcxUr/hwX+Ln5ewtADFchy/Rd383Ba88vWuDXWy7BXRuw4LlRTqCuYVxIB0q
	zwr9nATGhtAlRkWRBY7w6l1NUZ2SP3cngxejTo9TJ+f2FNYy6n0wbrENXJEReH1Q
	6KotzlnpD012vVSNwGZQk+DVTiXA3q3ObLw0GWuZN1Sq1zsUFuCpuDDWFkpOnlAk
	Ekc/jKDBX7ml2v/VwJvB4R8vRFZofL3ZRdojeTrbXch/Vr/w8/d798hu3GGgI3wQ
	V/aV0ie0WVD74yMSfWxlNRSdvoeW9jFYwwRfteSM2x/wmBtmRsJ1rbWO0Eg97iv+
	A==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hugxy038b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 10:51:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duGf/1dX3lGOEAZIYq0T74AfHHPreXasU7g8zrPDNTKGSf9y/RbyWOfX27J0MNDFtPonXW2dTawHD0avnxdtrZIBI94nIXixONMc5d9sBOG1rj5YuS4gwwrbrcAjuHb1mMGPHvyempR1bizJMTz9VV09/IO2wCCEETt3MAWDldWC8NH4VRiqhaLgFEj7pKeW+GauS2o96k1BlttWJv7fL/JT8qLs5LxL1+bUitQZ352Lj8Ue8atqqD0YUE1BLOCd3EtSpnqWo69Tx2oefwF8kckN7P6ePukNcgH+l6w/mey7cDA9fRzjtSOOGC6RUdmd0feMrxmR1isXNctvyLs24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SXOqZQW8TFzB7HBF7y4nHtxEVOWLOpgecyDfs2gPXM=;
 b=yeY70jhpnEPgpfKF0Xw8DhkWWJ5/47Ir7rmFbfU/IqwgdKq8iLC7nAOT1q+H1irZXsElc/x7iA2aiS9fzd1Oc5dsHdRwuWjgYmryBkx/EMKncraYH09xSyK0966OFJnBhfcv8pT0qB0rHqbYnU7twzu2h/hxMiYONUlxt2qO/ZIXuJhVimHmECEUZ5a/4EWCGj9CRWkPUWsXhEWb+vAYiPkR18rDgvQrjLC/6ZnqwmbOgtOJFb6c3zmy0mlwJ7vyO0uCeNYM3ZU6mUoR3JpgpwYGEmdvqVqfMchHtPahbFlD+TcNZl/lzqHSyfdOwWhfo2emfKrzy/dpkRpmoys++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by AT6PR03MB049534.namprd03.prod.outlook.com (2603:10b6:170:10a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:51:06 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:51:06 +0000
Date: Mon, 9 Nov 2026 15:52:31 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: iio@vger.kernel.org, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
        Kurt Borja <kuurtb@gmail.com>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt4060: fix inverted own trigger check
Message-ID: <avHsKUE4xJ0vdu6P@nsa>
References: <20261109024746.1253593-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109024746.1253593-1-jic23@kernel.org>
X-ClientProxiedBy: PA7P264CA0253.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|AT6PR03MB049534:EE_
X-MS-Office365-Filtering-Correlation-Id: b7835a62-d0e4-4d3f-7483-08df3e7943b4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 ruOmO7RDKx++lPgBLW6QKWe+JjRhR0Zcklug3c8m6eNevPV+wIvrWLlC2/5+3zml5n9sxaVljRjVFWUnowWJoidHVWuO/mz7odZycwMY++cwKJu3sPJx0ZcAzLbcVSxUpmVbg4xYnN6e8nYmBCVss9d5AzdEsUwTQcT7uFG4SB595OKnzkWWFhOV8tHJtwWDa1PJRcjcRaP/rEpBsgKgiUHR1oxzLbo9/GiYRRLUNNY2q/y8tB1dS3qcA1ys6a+8KbQdJ4QqB3oYgd3RsEXWhEmvb18414nqTJ/t0hnT3sjSsVQKKo7jmF0tb3VaCCBF94nFSEUZvak5s1w35ZKRafYw3+/aP/BSVz8BCI/bcSfCjIFP74DAiBjAiY5My6hh3voinvP0RHMoNrTc46sJE5wpBBumivIW1mV+4GvbqWInnIpnwY5YDGJEdLtsBcqKWo8jXNLnbzTljzvvRF8T2x+ttOj1u5QPr9/KZoz0k+Ien4w1kGeH4Eemu5BVVnPg8UPSU+SBONkGLP1zcBZUqaZSH/Rnm226RHxrhrpNnUCVSRSOMUQEsYaJyDmvaShiIhlOgJOnpHqarcYYZ30KnkDKmteWJO8RV1FfzDaGpbxoZWVYjgre/v0aWXt8n2B1xQQVaN7jqZFdUQBzbPqCWB6J0N91CodmLv7Al7fMHtY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TS8ydWtZaTFFajNWcU5hdWgvUUg0MHhVOTh1b2ljc01OOGNGVFNobWVEVVdh?=
 =?utf-8?B?MXRnRWxtZUFrU2FkckhqWEJqU3hDbnREUTEzVG9vckVLdjZXaGY3ei9sM2R5?=
 =?utf-8?B?NExyVG9IM1BkcU1EcnpFeEhvMzBzOXg3amJ3YzJxQmdyZFBrWWZtckxNM2lS?=
 =?utf-8?B?Z1IrWUdMa3FmbmtZQlpyaFRnSzJYOENUTXltZGIwVHpBdFc1Y3N2dHFzSTVZ?=
 =?utf-8?B?ZXFOSTNQUUhLdVhFYS9tRWIyR2FXZWxhRUx0YldFOHJHVDhJOUk5Y3RIWFhq?=
 =?utf-8?B?d1hRV0JzSTV4QVVpZDl4ZkF2WGdsN2pGS0xxMDc1MEpzcU1VN09PakV4NE5W?=
 =?utf-8?B?TFVqNUltRWRCQmN3cGVVZTErd2lFYWFkZXZ6aVRRNUdHUlRLZ1JLRnpiUG5Y?=
 =?utf-8?B?RXI2SHNxdldXcGhLSnRmcjFtOGRHZnI0ZnI0RE9lTkxUcFA4dFpSYnhiRkVp?=
 =?utf-8?B?Mm5XbDZOYzVoRFlHTVF3OHp0NkM5R2NqRjQ5Qk85am5Fb2wzbUxNRUQzNXlO?=
 =?utf-8?B?WlN6blMwMDRnRnYxdFRBZzJpZEp6SGY2Q3ZScDJQNkhjT1hOZE00ajU2aHpO?=
 =?utf-8?B?ZHNIMjZnRHVjdGl5NmQ1aGlWd2FuYk1ON3VDNy9WTUw5OWlqbVdTRVVCV1VF?=
 =?utf-8?B?cXhnZFE2cGxsSmJtbDh0aFBUTStJQjQyb2p4a3dYbnQxd1lucjJrV3VxTDRa?=
 =?utf-8?B?dTFKbXUrdkN3aFJ3Ui9YOGZOTHdwbTcyTU9hazA3aUUyYzQ0WGNVd2pxb0g2?=
 =?utf-8?B?RkR1aWpGVzMwUDJVYzJiRmdQcytic25yNDNONDNocHV2d21OU3FKS1FidmtS?=
 =?utf-8?B?cnVvejc0c1lEUGtIalZzNkpzM1VRUW55V0hRc0J1NlVoQ25XUGNoM1Flb3lE?=
 =?utf-8?B?eUJ0YkZZR3FWUUZOQ3hBSTN3NXRIQTcrR3Nyb2hGRm5yOEk5bXdwTnJHR1dG?=
 =?utf-8?B?eVdQMTdBZUQzZU1vY0dCOW1YQWVrVmlWS0o0ckljakU2REJXM1BEd3BQbUtv?=
 =?utf-8?B?MG9nemdaVW5UR256dFIyYnJLaVQ1V1ZldnBhS2g2UmgrNE41eXJqVExQTnNQ?=
 =?utf-8?B?a0tzdzBOU2NTRmdJS2txYzZlbjlMWmp3VmR0R2ZzK0M3SXY5WHZaRE52MTYx?=
 =?utf-8?B?aUlBYURxOHZ5elZCZ2kxRGk5S1BWdVZ5MmxNeE9QSkVjbG9PMVVEUzgzU1pO?=
 =?utf-8?B?QzZwTmd1a0dqRmJpNWpwY3lsNS9WYklUQ2lTQ3FTMU9CdmNuQ0toRVRQQkpr?=
 =?utf-8?B?c1lKZTlPT1BmcUV4M3NScnlLcEN0WXc2amRTb1ZENllWRnIrbmJWQ29vYUxx?=
 =?utf-8?B?N0U3VXdsZUZkbkxNbFpWZDZlemlXUkRCWFYyL0pRemQ2RVhGOSs5Sm9XM0RP?=
 =?utf-8?B?cnlteUR2VC9Oc3FpRVdSODE2L0dyYlg0c2R5dVpFOFgyL2hGSGZHTmhYY002?=
 =?utf-8?B?OGFucmFEVEpkWHdERE4vZ29sSTUrOEE1NUZyN24wSzBjOWwrVjF3VkZOWHhs?=
 =?utf-8?B?THpDb2EwUC9BZmF4YVFkNWRDSDFVMkVHSEVDWGxqeUtFUnhLb25GWHdBZjdJ?=
 =?utf-8?B?c2JuSjY1ZEN6a3B4bHdoSVZjcWErSjdrcWtQU3dJUTd6WUNWOTU5YmZ5Z3JP?=
 =?utf-8?B?dEphUThOOEI3QnFwd0ZHSnczQ2QraFlIR096ZGNVUWV5aEhaVlhQRkZHY0ZR?=
 =?utf-8?B?cWdab3pTY0M4bUlJMlZuLzdoejRkOGwwVmN2TkVBRkQxSXVwZ0JmZFBKYnhn?=
 =?utf-8?B?ZjhIeDkyeGo2am82QThVa2ZBSThKOWxDNHord1RpRXRDODNDRURacjFhSmJm?=
 =?utf-8?B?TUI3KzhEekRmNjF6MnBiMEJIRUQvRUdLRHdCZlRSNERGbHdkWG9acjF6dTlK?=
 =?utf-8?B?R1hGSUFRbEZDNjByVjNRM1Y5RGxYSjZ0dmV3UUhkTnRSWXhtZWwrckIrb1c4?=
 =?utf-8?B?V0huOENSL3RUNGlKbFF3Vk00RFlIaDFlWjI5cmZlRlhrc1AxcjE5bXN2QTRS?=
 =?utf-8?B?N0VUT3YydW5DQkhxMEdEc0pUUjNOUXFhNHBXSjJhY2s4a1RpT3dQaFd3eGgx?=
 =?utf-8?B?NU9PRTN1a29ucDk0enk5T1JmRlFlcTkrNEZXOGFueXdiUTdzRk5HUE5vNmJX?=
 =?utf-8?B?TjFPRTN1QW01c1JSK2xMVHNBTVBTK0JUYVpmdWFyK055ZE54K0hldldYZXg2?=
 =?utf-8?B?cUNob2didDJqMXkwUkNwVUQzcHpCcVBaeTd2MU9KUEpWaE43Y21pRG9BSGNJ?=
 =?utf-8?B?eThJY3Nub0MweERnZUxpQlpGaUVjZlBXMk5rQ3Q5ZTgwa05WazlTNTJnMDhE?=
 =?utf-8?B?ZWtHMHFXS3RGMDNLZWRCUGFPL2V0cUQ4Z0pYQmlrK1BHRW1zenQrdz09?=
X-Exchange-RoutingPolicyChecked:
	c87pONKbvq0SHCd6CoQ+8rI4ItUY/Qjb9RGc1nALRI4/W90QcQ8YFUXIMSuxioREEFOQF9KdwXYV3zuQBH88/uI3Up1q3zsjpWqduZZAtESk3GNq1u6IOSLP8NFVc/HGbbnBOBgct7wgmJb8DO0e2OTvW/2x0HYA/FFJP9yNytLBdxsxfZenXevNvYteXks/R9+zxcjBJ19F9t3uow5PLjnzQw8CrcgjGuGtgmOUq7aiTAlt/yhdBH7Op63gqnDHX4k3SR9qhXGxgGoJDqSe8nEZ+hN25zNNUhLv7uEdTBbkogxfjev6FKfiUFABbsdX48EFhp6sAadEecvoEUXmXQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7835a62-d0e4-4d3f-7483-08df3e7943b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:51:06.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhO1PrwSViCVUI/Jz85NbF0aX7woy/YsiBai2RCiL8aoHKsgcovNbkxggJhA1XX6KpqAcM9Gc9IiqHdGZ+RQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR03MB049534
X-Authority-Analysis: v=2.4 cv=FrSQbGrq c=1 sm=1 tr=0 ts=6af1ebed cx=c_pps
 a=QB7twk+TLgGFyKEw3r1QfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=vbazt5XzS-KF67XQGuQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MSBTYWx0ZWRfX4aAp2p1BkdVT
 FTRRKzzyanSurh9hLaq1GY5b70je8hLKZStZiF6/fhRuM6NYrZ+uI/c3bodmhcJM9FaBP8L6qPy
 +sjaWnI+5N7ddW3cN/Ox/S8oxmLCIpIkQXitErismt7zeLacfXLsWMu+6H+6SWUD6tCokcDmwj2
 3HRjqTIQevwojU7yLnSvxL6DDQdiZox5+sWviRDph7J7kWZ847sSy7My15rlUp1d4Gsqcv4eMIm
 9X/RzvtFhPYen68ujyX9rfYsSt9XRu6PIDJHIrCRJjPaaeFQZHREwiwDXOb+B/vsS6a9+hVXoke
 67bfWS4VDPBzXe1qtapLfmYZLrzIyiQFNsuSGlwp/NeBQ6UbiEFFb2fI5BfcBSF58W8OxemcwM6
 IVNVX2xjLEvoDyoKViRLNFeAq6aDjyh8M8Nv9UVu70WKypp7Z0YJDKUyAvlGFB1qI0kgqpaYeMi
 L2q8DL6rV4opLSFwAYw==
X-Proofpoint-GUID: Io3uAt31JkIHLKAzKvZR7ZAaERXbRH5G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MSBTYWx0ZWRfX1PL+GtpaGH9h
 BA6wIHnM5Ua38Ih0Jo6sIOb/suN8VUez7TSWZYrI0Ktb4TCrZj2fRixqAQ/rRKTnn2eUrqnoqOy
 hgydjYDgCypxxzmfU58mmrkmDZSD404XTrwATLWhc52DSfDbL2+Q
X-Proofpoint-ORIG-GUID: Io3uAt31JkIHLKAzKvZR7ZAaERXbRH5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090061

On Mon, Nov 09, 2026 at 02:47:45AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> opt4060_set_driver_state() is meant to keep sampling and the interrupt
> on every conversion enabled while the buffer is in use with the
> driver's own trigger, as that interrupt is what fires the trigger.
> 
> When converted to use IIO_DEV_GUARD_CURRENT_MODE() the negation of
> iio_trigger_validate_own_device(), which returns 0 for the device's own
> trigger, was lost. As a result, with the driver's own trigger in use,
> enabling or disabling a threshold event switches the interrupt to
> thresholds only and buffered capture stops. With another trigger in
> use, the one shot conversions requested by opt4060_trigger_new_samples()
> are instead forced to continuous mode.
> 
> Restore the negation so the code matches the comment above it.
> 
> Fixes: 8284a4985416 ("iio: light: opt4060: Use IIO cleanup helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> This was found by an LLM whilst doing a refactor of related code.
> Indeed seems there was a change of behavior in the sited patch that
> wasn't as intended.
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/light/opt4060.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> index 8253a6a8bee4..1a7d429453be 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -310,7 +310,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
>  	 * IRQ and sampling must go to or remain continuous.
>  	 */
>  	if (iio_buffer_enabled(indio_dev) &&
> -	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> +	    !iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
>  		return opt4060_set_state_common(chip, true, true);
>  
>  	/*
> -- 
> 2.56.0
> 
