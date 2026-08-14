Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFD3E9584;
	Fri, 14 Aug 2026 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708021; cv=fail; b=Xc41l9mdyXt0NEv9eIJGIggdL7gfbKVkGpX7A7dXae2eZ4ck+fKdO0s+juCLuYD+5HlWLmPNGP7DhDRqKKax5FME7DESmNN4eU9q+cCiOa+bXC7EBrdEOf2jNtJGonsZO5sM3I9xVvJqGIErIEEaEihz9P/qmFxZHxBZbgbSXEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708021; c=relaxed/simple;
	bh=vZwYHa1gPLL+SXKPS+VODEsjs1uLlrAhM2GlpXY6oX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTfZEj2W2Z24Z1PTus8y8uNgiTARUVbVbLMetOEHm8kGgaIn15hArZwuq+ku7+4le8toRh51m1l41YfRmV/Lc/eemct+/8YFBtJWyRf1gcKo32lzyPaJC+is3oDBZfie2K4kkqp9/KqrqSShArYzjDh3FAZonF0niMa6SIKplpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x5D6oJGr; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x5D6oJGr"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAdldf1274444;
	Fri, 14 Aug 2026 07:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gFY5/
	h/1FCS6sDow5oZr8vojCbUAqcK19kokeiYraEQ=; b=x5D6oJGrIjSVM2eJpAhVi
	121QolWbIReiUSffPPBNsLrD2WoB7LW8agzo1XvelTB6haQ/Jds5lFgKn7jZt7d+
	4EZAnpViv69S6Qmd+yYeO1lvYHtodrNnG4EF9v8Zxm87wOYCe1rphs4SrHNQwzmS
	MG0k8f+zcRvvNQ1yWc986L1c6nJZdlY7i1yH/SKKxUqUCePskwXoOSueT34DveAC
	k1LVZZq+4G0BDgByvWSBYnXRKRMhXI+Wj0R/VCmakl49ctGnwFeOQ1/7kG/MCZ/z
	YLsQ3lh3+7nKnv/s+kBEJMxUmI6LoWpju4Cqzc37LFno56YhMYcyrgqQA2fnJCsN
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1v9bhcwd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:46:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyXyqITvYlTknNfgmO2vowSNNKwPb9B9ohg9w5qiQ3e/XJyBstCUPl+U/Cgv1vWC9NbsnZgWZWDLSqWNVsRfnAqgtYYL8WvIa+/pV8hSxef++aj1yq1oxdDz5pMCoFQx5T9HMHlSgK8VH3Ky5ukEg/pvOo5XvbNJ8YRwF7KTqnlEWoTVGwJk6eEsYfLcV1GLAg2W6Lo3e/2/m2W0+/C78HsbZWbKRynqpNNaUI4EGUtjTICv9tdP0I9CvbyJZTgV+oNfnO2XG979Xt25wLg8mnPDQDa7cp91VbjlHaWsI8sePvXJpyJqUofEuRQmtQKei+w0LTuHN7Hr0m4oxWf2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFY5/h/1FCS6sDow5oZr8vojCbUAqcK19kokeiYraEQ=;
 b=TUP9Tnqtgqe0wYl680GPuoJnFPs3QprO7ElTmHtnxG5j7rj0yyNm1QUDydVegS76Ls1/zPamZAU+PvTZ0Fr9Bgd3r5ny19YcZUVxA3x1hV0yrTolKvrVctDEXJhykdHNcBIank/g15DaoWgMQshPsutOD4vcRfWQ/dNDejuIHKcKDxVOBf43pGDyQZ1JrpOBu30uhk77KsH8aw1/RQ/fEKpJ0vt6VcXtma3CUbIT0MpswyBXyWDC7aCZHT7XQ9ofdJFAKJCHidWW9OyRN7wd6RuzoIFZmkvVNgX5vQ6TeR6RCA7ucUGc/2nB/0ICZreqHVthRLQYTuGeTRSE7hhsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by CH5PR03MB7959.namprd03.prod.outlook.com (2603:10b6:610:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 11:46:34 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:46:34 +0000
Date: Fri, 14 Aug 2026 13:46:30 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, stable@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use
 gpiod_set_value_cansleep for reset GPIO
Message-ID: <an7_9DQob7qnKkzX@analog.com>
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814110102.2362246-1-o.rempel@pengutronix.de>
X-ClientProxiedBy: CPCP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::14)
 To BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|CH5PR03MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eec4049-ce31-4830-38c7-08def9f9b0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	bNQlk5ixytZKZteeizsEU8xZCgsHmj6obzr3XQae6PZVij4gTkyx5zzTl3aLx/Pek8PlRd9KwVvjVle1qPcSMPBefX7bVABeWlyyDsuwyVtm1RdQ6FV5svBPQd6HDdn8ao04WftwY592n7SEuVkLMWLdXmCLcB1g7L+q5fwsIUY17JRRSOePoL3DHM+xCPHkNuv0v4PZiNpCZX5ex458plakdej9CHc64TW4pQh2RNWTh7X/NGjFwu6lqTuTdUUySAAlGD7RfqmOII1XVymXzRiECpqS44kXaV0mWTToqt9zKtYl7C5s6EzIG//yqiy07iKYw0tE5ij+xX3UwxlCFPGJVEPbTIFXZusiyX+7Ason4BbcRMFI7T17MTyQvl6I6W/ykTyNjueWSBDNrqtOXwR3ZmGeLygp1hnMF1SZDEyqKPOFOo803laKDYQDxhd9ajXXJrpSgXoSg3zCliAtgs6PQPigGbKPmHIJuhFwKgTuhzuM//Tg5CDCPB7SHh50r9dQjbMZeeHQPSXfLGq51XAdXST/En8m7FJldjN25zCOIRY9oq2DERpDopx8Wq0mZHHUy6n6GJ7/9Jp0lAvVW+5rBMR02JERGPay/ValqOrUMoherN+82nssU9juyV1fMiTnZtdGWbriJSBH8EaW4sCW1EF9G7T2ZmR3DFRJ2Q4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkYvd1c3aThCdWMyNXMvdGJmVzg4NmZ0YzIrdUF4dVNFOEx2bzcvaWlRSVkr?=
 =?utf-8?B?L3oxSEVubWJ2MVBtY1Q3RjdYYVF6dXJHcTA5aGo3QnJ3d25aVXhaVmRDY0Zk?=
 =?utf-8?B?bUtWRGNhSWp3azFTUzJxOUNkQVgzdDBsM28ycVp4Ulk4djJyd3IwOUFZMTNM?=
 =?utf-8?B?QTRTdERFNnRzRnJEQTZJVHBkUmtrSXc4UDBrbU5GN3RoMFpCb0M1VkM4WUhk?=
 =?utf-8?B?THN2Uk1ORlFZTExic0NrcXhITWZpMXFLR0ZJdENONDdQZUhCbHJuaHJOQk5W?=
 =?utf-8?B?d0dieExrQXVxRzJRUEJtWXhlczJvZUFidytwazYyUjExZmdUdjFiNGFVdUJa?=
 =?utf-8?B?cTU5UllGRXJSQVhJeHFMVEwyZHJzYVRFUzZyQkhQM3Z4ZGRKeHBoN1J1VXdk?=
 =?utf-8?B?UVFCWVVrMWNXK2dzY254bUdyRDU3aU5wYUV6bjdFRjRDNWx5aS93dUQwb05F?=
 =?utf-8?B?YWF4WFhMUFhlNU16Z2F3VWkwSjlSZm1SSjRIMDVEOThiYkhCNjBoZkRGMENn?=
 =?utf-8?B?UlJYRTJLSjlYQWtGUUdoSmVLQ1NHL0xXSXlNaE4wdmF0WmdkYk1JUkQ1cm1M?=
 =?utf-8?B?a2xLTThtOTFILyttL2ZRNnlLK3E1VXQ4YmNOa0J5a0pGSFpWNUFRUjByQlMx?=
 =?utf-8?B?aUxwMnp2T3JLYWNDbWNlUEcxTEtXYUR3TGRDeXc0TlYwOFNrZWJDTFFEZFV6?=
 =?utf-8?B?QkNhUXJ6RzFDalNWU0l0aDNvT0hYMDRNaXZqMFNTSFVaM1RRVFJDTEdNcU9S?=
 =?utf-8?B?TVRHUzZyZ0k0UzZMWWx3MHdOTWVhMWpZVzhXYVU4UzF3V3lKTXA5M0FDVjhE?=
 =?utf-8?B?OVp0UnJwSjlJbHFUYTV4dHh1L2JZVTBCSDhPeGw1SUdIaFZXZXVreGFJLzVm?=
 =?utf-8?B?cjR4dnljQkMrcGpNK0tRTVpQdXdIUHZxd0wwajg2OGliK2hWK05Vd3djMW5F?=
 =?utf-8?B?UktPamNWd3kxUWtoRWQrM1JCb0lqaFZ5Ri83d2VSRVA1N3hRRm05L0RmUDVQ?=
 =?utf-8?B?bXc0UzU2bWxzNXVITmpyY3Y3REMvZWtWaVcydE9BRlZWMm1ZOUo1OU5sWXZN?=
 =?utf-8?B?REJYMjRYd29EZjlHN3U2YlpNMjcxYXphRGJ3QkhRSUJaeWU2azlMSUE1Zmp6?=
 =?utf-8?B?YlBtWCtiN0N4bDZObk9PSjVLVkFpVEordm5TTDVZZFVENGZ1aUl3TlBQOTFK?=
 =?utf-8?B?RjFjUG1SeTgzRTR0Tkw4am1VQmU3UU5OdFF2eVBreldxbTRKa3FXbDZWdlhX?=
 =?utf-8?B?MzZUOGVpY3htai9hbjRnMUFBZDJxT0Zlc2JPSUpDVXk2enBVUTFKWStacnhI?=
 =?utf-8?B?NFR6QXpUTktCL2U1a0NpSVpFWUVueHd0cXRsMkNsMGlVVkVESW1SV1M4TmVG?=
 =?utf-8?B?RWNsaWdRUGYyMUMyaml2blZMeDBoUDN0WXRhZU40YS9wd2NxOHVSR2pMblMx?=
 =?utf-8?B?UjJ0SXMzYkYxVDBzK0xpOEU4emZCOXgvbXFacCtKQ3hOaEx4ODROeVYxNWNh?=
 =?utf-8?B?TysyRzNUUGVhbkRsRUg0eFBmbmt6OG40SUFwOFF2MU1kTVJVdlNTaUduK01p?=
 =?utf-8?B?SmdSVjZhRGRxSU55YXFzbFBzcEJpZTYvMWlhcHN4NHRIT2Zub2xia2hzWDBv?=
 =?utf-8?B?azlyQUM5Zzc2eC9ZM1ZUQmx6NElCYWw4TTl4OG5Qa1ZtWGI3TmticnR6UmNa?=
 =?utf-8?B?MlcxN3VBc25RUFYyaEF4VHY4RjlSL3NiZ2JFZ2I4cnBiZkt4bUduZVFqaSt6?=
 =?utf-8?B?RnlCSVJlZEg2Y3JhN2FPcEhqbUVUUXVvTFJ5ZEdmdFRpcDlId0FDQlM3NzZl?=
 =?utf-8?B?SlJoSXd2NXhDOVlzRlRPdEtyQTMwNkMwcTlucGM1QnhlSnRGOWFTL1Q0ckhr?=
 =?utf-8?B?YkZacEJEL29QQnpYd3JIS3lJaXN1U0hiejZtUFpST3BaZzArVEx2N2ZSa1h0?=
 =?utf-8?B?Z0Z5a2x0aWVSQlNNRTlvdFhUL0Jkd2hiRVVmZlE4dlN1bDF4cmFXeGhIVmJX?=
 =?utf-8?B?WUtGajJmRXFzNXBzUDR6M1labjFKNG8wYngvdzc4elJTZjV3N2dOVEYyUk0w?=
 =?utf-8?B?dGhHY0FVYVZyT2hMYTRRSlkxSHNiUEFxQk5IeHVJaWo4c25vZEQyUEhGK25U?=
 =?utf-8?B?QThPZ3RHWXdPRGJ0U1F2MWh5MGhWd3U3VjUvM2pWS2FVNCtZNGYvdnVHSjlj?=
 =?utf-8?B?WWpIcUZsRituRFVNTUcxcm4xNE5veTgrQVZpbzJ2RElobEY1TVVHOUF4REZo?=
 =?utf-8?B?bjBDVjg1WTFPNVRkZk5uaFd5Z0c1cDJRUmlOQ2tXazNJVmdjTHN5OFVINU5j?=
 =?utf-8?B?cW52U2dsVUF2M3A5MFR1MmNrcWpFYmNIR0NwSlNyLzBpbjNYV0RQakFlMUpG?=
 =?utf-8?Q?VMPUHrQKPoCu7fFI=3D?=
X-Exchange-RoutingPolicyChecked:
	BCBKsSHxnJJsYXe1uo1kC6qeqBzMfftX9kS6EH6ZvaqXTjhhl6yK+BE5eDFrnSd1K1oTBXWh9fAmoGER+6Uui2xyuhNtk0uBXmfZlaffEMMN4RVauaMjCxVlis3agFvJpl+xlktkl5QVl1Nqru207g5rSPsZMNIY80kMrKVWBQBg1/u+H69REg59kEsyyw3Vc63ReHKjEqC0K07dH0/QaSn2fhhRYEkolsTpP+u6roSdbMtxiy5rEzAKjPjCiOkjKuuo0gVyp2NObLace3D/S51tznELke+7gW/yKr336uEnTGS4zw21deGlKdWj+1AoIBLhkgLkwqFuYBbnJp8aEg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eec4049-ce31-4830-38c7-08def9f9b0a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:46:33.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5ubfpngmkbhOS1mnfJhsQg8GYcy+5Lfg6NF/oC+6gxmyBSKIeTlFHLME2U1rpYUoRdTFAmhGVyCEXBNQByc16cR+snWJZ3v3MHEndQJNaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7959
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4OSBTYWx0ZWRfX2jLDAK13W64H
 1+JSuM8kBYXkclPbWWwhvIfI9CvXPWTPJ3LXjM5KCc+5Y2w1q8ck4jeW8gplXa7L23wSsMoIrfR
 LARpMJmkhF5AaN1NLqo6SIvdWEQMupmgDMZjxNQzkXy9RW95yLWUGxRQdc1ivWGNr94D6fHtZp/
 KsBkXhPh3nYWdW0EikSodiw30UZSR+pQ6KwN7+B+B/NTTfE5penUVlICwXwiDJsuO7wGTjtRMVq
 zXVdQNonKWrmjlwjh+cqMl4Zf7XFH8hrqvpKwfydZ1IDCsS7RWDLPhDCxZlIP8kSXZwrOTiJb0Y
 UsiDQD0WxS/beW73G3v4DMYnhA3TkUH1uyBsMPSQT/2AUP5tCchCV0HxJcB/Pl5GQoAxlVteS0F
 82PEiPpPg9LTEx5JKZBXcBPzeVWSRgbjkyYWCJdUn1RgDjt/6x0XxEdJIVpkIqfifD5U/PNhjHK
 Yfq3Ds5uq3a9xfqiBqw==
X-Proofpoint-GUID: 7CIwcR-FwmO8slMNXVNxYWtdOpHf7aS7
X-Authority-Analysis: v=2.4 cv=TpDWQjXh c=1 sm=1 tr=0 ts=6a7f001c cx=c_pps
 a=EsAf7Oic3mfDXMJ3krB2BA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=DkcpRQWZFk7ib1E7x-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4OSBTYWx0ZWRfXwzi7y60TqSdM
 X6i6c71hhbpY5MA0POrEuUURFw33q1mqXtdmsTNEB36L7+AOsGfaOAyXPGazduRaw/OSTBdAJhv
 Q8lOpkOlpgukmb5kINoWY4wmEsbvRI/K2AdkV6c1uhzEjATE0oUf
X-Proofpoint-ORIG-GUID: 7CIwcR-FwmO8slMNXVNxYWtdOpHf7aS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140089

On Fri, Aug 14, 2026 at 01:01:02PM +0200, Oleksij Rempel wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> the probe path, which may sleep and is not timing-critical.  When the
> reset GPIO is provided by a sleeping controller such as an I2C I/O
> expander, gpiod_set_value() warns:
> 
>   WARNING: drivers/gpio/gpiolib.c:4030 at gpiod_set_value+0x44/0x80, CPU#1: kworker/u16:4/61
>   Hardware name: B&O MAP CA33 Rev f (UNKNOWN) (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pc : gpiod_set_value+0x44/0x80
>   lr : rtl83xx_probe+0x1d8/0x3a0
>   Call trace:
>    gpiod_set_value+0x44/0x80 (P)
>    rtl83xx_probe+0x1d8/0x3a0
>    realtek_mdio_probe+0x24/0xa0
>    mdio_probe+0x38/0x78
>    really_probe+0xc4/0x3e0
>    __driver_probe_device+0x15c/0x1b8
>    driver_probe_device+0xb4/0x120
>    __device_attach_driver+0xb8/0x1a0
>    bus_for_each_drv+0x88/0xf0
>    __device_attach+0xa0/0x1d8
>    device_initial_probe+0x54/0x68
>    bus_probe_device+0x38/0xa0
>    deferred_probe_work_func+0xb8/0x120
>    process_one_work+0x184/0x4e8
>    worker_thread+0x188/0x308
>    kthread+0x130/0x150
>    ret_from_fork+0x10/0x20
> 
> Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
> be used without triggering the warning.
> 
> The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> since the driver was added in v4.19.  The call has since been refactored
> across several files - from realtek-smi.c / realtek-mdio.c into the common
> rtl83xx.c module and then into the rtl83xx_reset_assert() and
> rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
> applies as-is only to kernels that carry those helpers (v6.9+); older
> stable kernels need the same gpiod_set_value_cansleep() conversion at the
> corresponding open-coded call sites.
> 
> Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/realtek/rtl83xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
