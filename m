Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795164729;
	b=XHnWhE+IOiDPfnY+oyMg4HDt64suoaiGGeEZeJzcFmBwMnxh1xMQ05BXNozOggGttpBQ
	 Zd+hVXPyeBYWU8LELcqmcMLA7JzqzX7EJgm+Et8MgbEcbgKs3mWKjoyROLGYkHdJfid3i
	 bA68B1RoTREFb6yv9VZO/w74x1BYIPfLxfyKzxJzFx7X48ye6VR2lObQIK+VlI9UEFgLF
	 c5NcVMVXaXO0/yHe9tNejGO/1suA4uaCntfXRJqVv9RmxEJfeYNAfGm3mKATm7xJpsWVv
	 E6BDZDZmJSgT36pbKunkEyrFvt6Bw4SGMEkztVcfWMeDy2Ia4lLKJdu22kVFfaRpZPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164729;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HjuYf/810FDDFyzTkhob3VZdUefJitkre2MiYMjRhh4=;
	b=viYar8Sh3HXb/K+u3Gbr8AVhQYQPEjZZbulvmWM4QnOyK6aHHF6LnSVyRJ8LlFcQ6d9F
	 9WKtSGygP8GLiagRodRX43vZ8DV9WyXKe6jhM7kxHXe/fI2V/XGzaBzLsBrNoZpDJqCtV
	 uI0c/Uu3h6EIPEDuGTJwsLwD9OVjDw/mVSAs5HY1dfyGyDLC08ENgjhQHBj7VX6HV1jZz
	 o/sOipuYAsft9xNKzsiuU+SwVHkKspD79lPc7rNqRgpZWDtKDvHm3bcmjhqJ7LdHbsLOF
	 o+BDvJHgZM01XeZD97ieQ/Oh+TxGSIBb8lPglTBlO+72vV7UYdUa0GMfV3Nvo1J5bzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=nykD+PV3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C54606A326;
	Fri, 20 Nov 2026 08:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C54606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=nykD+PV3
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7g3Ce3991206;
	Fri, 20 Nov 2026 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=HjuYf/810FDDFyzTkhob3VZdUefJitkre2MiYMjRhh4=; b=
	nykD+PV3s8dlCfvSI2wQdxG+dO73Yj5SjnfIy6HIr39gPeN4skPtXEIxxALlPrI9
	KQAPrZ0QPKXLV0GtEaLdCbdLhUO6791luIo2AmgMcSY4Luy1UYHytg2ndJTmSuw8
	qIK1JXTy38rfG5e+41FSBytl3zXSO5wEPrSUqzDELtCbpj56yf2vJsU8snCKwp59
	aGwaQYNOy5/N94JwVVwyrzlq4plz0MKB+3OO4zDIwQrlZk5PdyHREZ2cvhYRrEhr
	lMtSB0eNyMuxdF/LiHWWm3BSeycVNn2Yr/N8zLcI9BLR1xh8NMrDeLrweV+WBdkR
	q/+gFNO2wsRoN8wzmTRvGw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020124.outbound.protection.outlook.com [52.101.193.124])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvkgabe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:51:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCN6r3BFCl3OgXu8BI0p41hH3afWSTRvya+bhJSojZE+uEEYB4wtYBouPx9XL12kvmT5mlJfPoraFxzk68FX5SI0Ivke6dzoeXchSTTCJ699n7L+1l5YWlChMNdMPQfn145ReykINlSqDSEkDb98oQfoBCgJIYe8Lrd5PlSuE+cuod8F/TPnAiBP/uYmUzvwx9Dd8jaN/1AjuWbgQtR7Dc6xEDQ4ZsTXuMrQFQTwXa7H+3K5bYitRLkRn1zC9DQishwN1zb0puj6EeMMrh/KINw1RFO2Y6dsd+usd4m8K5TGO9IBscMeCIjMHDsvgKfA/NIXOhV7w5ej+aNLvugKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjuYf/810FDDFyzTkhob3VZdUefJitkre2MiYMjRhh4=;
 b=Vv7j6K6yFUXJT3I59h9FW6s5tX1D8NGLTl0J3N7NNXKYTbQzKt+bB/Yo2Evh9S1U2Wa8vVChl7pClmGk7nN9+pcumTw2JhtM/aVzETeCmG0MA82IbJeXAByHfJJMth6LF0aUlirVn1X3tQXOZVk6MSL4LJfs1/31fnFtcEoHoqFMvYBp1MGcxK5QwfQeULoWn4WcCUjn8SiHXRhk1LSpSkSl0DqjSoCjgHNzZ9M7UMzlFK2J8B1cpjLXM4vByvK9vWCBjx663av7XzuRiDrpSNOgqnTADvFwiTCzS333vd3+mlJXe0/bakub/k/n84M+9nRRHBlUcFigIEkiTjzT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH3PPFE1E3F709D.namprd11.prod.outlook.com (2603:10b6:518:1::d56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:51:28 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 08:51:27 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
        Samiullah Khawaja <skhawaja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Anthony Pighin <anthony.pighin@nokia.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may need it
Date: Fri, 20 Nov 2026 10:51:07 +0200
Message-ID: <20261120085109.84155-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119143237.4bf54796@shazbot.org>
References: <20261118163706.7138d246@shazbot.org> <20261119143237.4bf54796@shazbot.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0046.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH3PPFE1E3F709D:EE_
X-MS-Office365-Filtering-Correlation-Id: 648c6904-dfb4-4042-081b-08df46e376f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|52116014|1800799024|23010399003|366016|4143699003|11063799006|261009223027099003|10067099003|261022105027099003|56012099006|261028144727099003|261022075727099003|261026140227099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QiMWbTpnVkYs9l1o+YQchnexYtLKj29wIfcYQnokBY8jV00+sTOPT65TCc4UNh81f0KDDGbH+tGosSdMK2oFnMmyyellPn0GadJPbiU9S0Hbqa4GkwjLHz+VX6kRrxUPNrusYD5GCYLPAcUWrqleiWlRtCqJMzqhaiKwPt0UHtan8M6xNmPReB5tYh+foaqJN5WXgnKb5ugRZnpTKY/ydIE4mZ4tKrIPAWWY1H4JyKoOpbYuQ8XA96+sShLH/e2GBl8UaT9Zf5TE4EFSnQTS05ku9ndqrzZ6qGhXz9MUtGDcUnVF6MCfGzIKHgzCS/02TirstfMremdvz0JS+UosMSa0mmhNebchcxGEpxj786C75LMhW5CbrQy31fcy4K7wwM/6e9u2D2ehn1SjNMaBn65AkGYbw0gNEekVpJ0ERXmeZTxQaXaHtiN0FM3bchYJG94gApMYFFCGnNnnoFmKqpG72StXi0T4VvoVubolFUkVK/7NwoeW7e6sxTVsAx2XF7ic/qTjg1qthBjk86Zj7VYiHHTgj3lcqVYUa3D7QFdpV/MXD9WXh7S5iYTsoKQX+4quMF08t7mSwp/WK0WjCmNR1QWLklNjPhBTjzDqGA88cSi826A1PYLrxi9vRe/yR5uEfYjwQFUJBbHSTuDkIskDpLh9bp9K5b2Wj2y69X4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(261009223027099003)(10067099003)(261022105027099003)(56012099006)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVTz/ZaLBDbDfOx6wy/xyHrkOvcrSNI9gRytWflXT7kdraUM5b3+DfpL1HLk?=
 =?us-ascii?Q?5XKHncALvY6NwYS6NNYj75WRlfEYvYFqn8molk/Sxu52u6Apmh5kUCxn1Vqs?=
 =?us-ascii?Q?cZph0uFdGI/BlwGACWyR4IsI3UOHrtwxHQFgDR+b4vSAAjnXiDkTlTQJVARP?=
 =?us-ascii?Q?1qcES1nMhdQ/9q6x1WpKNB6pRjzoETaMmlt0xBvGOZYYzavhFbP7Nimj9Pv2?=
 =?us-ascii?Q?p3tBX3hQ07o/axXb9ka8YNZB+nRJjk0yKGJyqqygFbi1/XjVBnkSy2dzq/qJ?=
 =?us-ascii?Q?c7/okogSMiLmcOL78kj3Sst0WlUyFD4WfDf4G/6h1PWtKNAjaH920BXuiiu0?=
 =?us-ascii?Q?SK9Q8PLnDfLudQD9vfEyqvXLNlngCoBZAJzybHYfjm2Ig8R5QHVOVufHBdh/?=
 =?us-ascii?Q?oDod5QrONkbSO9jxifkr0I5qiWyoo2H6Jg/OlWd1Fl3GvL1F//JoeTEaUWEn?=
 =?us-ascii?Q?XUDV5kUjYvO5cb6SI9/BgRj6sFidUD6ewezDrtkJ3OoUEqsZ4MeoeFNzUEDG?=
 =?us-ascii?Q?3gf4y8HVyKPtVLBYCGLlqZZ5crYICQekB3Yx9kJ+OlyYGZxYNvlxKhpuXd9Z?=
 =?us-ascii?Q?cywnPbpkNf/w88FAmykRwx+rQR+GwQHZJGkPpdaFk53r2nijk+CqrfwH1Utb?=
 =?us-ascii?Q?hTwP1H6p9Fvhcz40MpI9fc8SZ1q9/PtW7fH/0dWNb8P2zP4nSlqQDt4Q5nxH?=
 =?us-ascii?Q?ZJ8TcQXRikNFwI/QBfABy0DghrUDputbULArhWX01r1jY8pEqWATB4Ux5nB9?=
 =?us-ascii?Q?Ua09ke/6jjLvdnXTTbJc+ci985fB9coVBrd65hADIyH4DKeQpfNhVgwPT0ib?=
 =?us-ascii?Q?Cm2EGINrp5nniFbgJoe17j2mHgFraRvOZC8XHdwC7n/A6wlbLJ0h0p7+cS9N?=
 =?us-ascii?Q?d023H9Zv4V2LpAMorSNvcgPkI4JVm2mN/gizjwGGtQD8hw/RLCwy5UwgdJO0?=
 =?us-ascii?Q?XDYlgo3HysVsVYeapOdGvWDCIHyYl8wFsRoV47Xl03jSX8IPx7JM25b39YjM?=
 =?us-ascii?Q?Q0hZCpKwIZoPCGvY5Dd2LTpYicqILxyaenN0DZqkgG4y/iT5YWK2nGVx92EM?=
 =?us-ascii?Q?PjCgD/g9Qx8t6ir8jEYamFfG/JH56IRVV4lWfvu4picYO/ZlHJrXcjx8YxHT?=
 =?us-ascii?Q?kzqoVazu3iCBN8GgQ68AD9S8ZE4K6U4Q9dwY7JTTTcclA2dXqQymizAVFdaj?=
 =?us-ascii?Q?yX72zCHKM+YoubYy/Dn9S5LyZ4KRS8wX3P4B/lBF9XTVPqKfPhE1VPz+EbOf?=
 =?us-ascii?Q?pCT6skKdV0hPw5ZLBqMmMtOfNxttsYKqoOUb4yvkAnB9gkkSlbZZaH3HVAHR?=
 =?us-ascii?Q?buu5td3dp3rygTHFuKStGUxGh64gHwpB32fePRgmoNMk7iMN99ZyXWvbQ7Ls?=
 =?us-ascii?Q?PWcJdZcD2iH68p/rboceX3YwEa0p/5iupeQPUdBOsokF4BGNwL48aE8Djhsr?=
 =?us-ascii?Q?Q78T2y3yc8U0bZPCi464HTx+jFvrvCm8NEGaMqKcSgkZlspaDQRvJcg0LDF8?=
 =?us-ascii?Q?S/qkXhXFbRsWALfLEGWwk9Sj7W4LTwoeoSY+ROJGP29ae2l+nTT5sE83Wa/R?=
 =?us-ascii?Q?KkyJ9dv8mvrg7l8XNfV0XpWS0aNZS4jTYAvUJd0JNc9FofM/auFRUdhUdpY+?=
 =?us-ascii?Q?p3K1yZTxK6tk13yEIovRYBw4vpo2vqAkPpNSsgB9qS2/c61YPRC6i3zZr29H?=
 =?us-ascii?Q?93Q4po99x1q/WdXZps1rCWt2jsmxAUqoF1tY8M2VtgES5x0M5bzuvWELmRW+?=
 =?us-ascii?Q?bVStBtTPBgKgPyxg69cV/0du6QBA3g10+OTJX+wVtMUmj/kFVcJ+CtM0yNdY?=
X-MS-Exchange-AntiSpam-MessageData-1: naMuQc2aoV3aP7qpU5V6TbP7XoXTuxKACO0=
X-Exchange-RoutingPolicyChecked:
	Vzs8rUeHAJGbGzZg10NZyjYv0bxc84pRQ46tX/aCwyX94HbLwqbdYzzV4rx+YjMZMjZjmpGeADvK0DjghwcKSvzxFVlNQ+CCmIG9Ze9AQO3kcZY4eAUDfR3ejFhxOlvT2LEeCkkyO7IwBtDbYE+QuvQYR6hwLMPIqbtl1sDCpR7QTF4FsSXS9IUQosELAWiRfhruIV1Nj2HFcJ98xQOhohoIqmP2bviA+jX+a8hwy1XJ/+dGVc5zdWqUebfjT85sU1JZlecWhMs8A5k8FCX+fXFDKy/YbIsv+rXw/tZRpHn2AWYp0IkOVDebTlGVFAr2D78X0jd3RsCvwt2YDIf/ig==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648c6904-dfb4-4042-081b-08df46e376f3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:51:27.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JujsGmooWZn7e2Bs3PJAF3xqMvHDbXgioc0Sf2g0Xl4a7yXjOPi1JFDJ73c+yoVUfM/yCAqUus9v2Q/li6R9rOl1tyJIdE3LCoErOnE7lhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE1E3F709D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNSBTYWx0ZWRfX1V+t6cZAyKtl
 s/sr1U6Q9wkiUpGwwG96XWr3DisDJBXP4Qk6aUVPGfi0QZxNjB8ez5gj3DJWbJGpqk0dn8k9W7i
 rVMAYOmtEoKcXk9fERA+RvgRB9JBOjiqxDHh6MiWzv+R1D51qMFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNSBTYWx0ZWRfX61fK5I+D48TS
 7SpK3NUgZlyXsCXplyBzRHvYGaXHL9/fWB7+hP8nLRdH3XY+1ujpZYVTqRY36eF/UfUy+heWjJw
 63ms23QxmSzMbDBeeAe6lOODIL7ePBhUK9ABHFP3R6SfXqtTEZEKKAYDjraAk8rh+4s8IJQ+XBF
 mWwQkaLidWiFYFsP8iJEOySEwgTQwvyGv4asr/wwhqNpqKXvh6Ev8P3o06zlCNWQUJHEWxCOS0Z
 CPAus7NBGVJXHv+8tJFjoStbgoV4GABKbvVve8Oy3nPFzP7SavRQJiUFqHAWPzfjmreNG0ABsPx
 aZA4VXgzg0yMhA7eOMQI/27pbnkMrRYbTOTminJd9cEdc11FYKFTpc/G5NcN13nJChPkDFcgJDD
 EdO6J/r87v1D7CJC4e7aOnMjfjtgNvIuBQS+2q6ia4v2RLgAb1kNYEUPSAzKKOIgD5Ry6K99ZUa
 AdXkpC1qCUkjvAmlgnw==
X-Authority-Analysis: v=2.4 cv=OdYNnRTY c=1 sm=1 tr=0 ts=6b000a13 cx=c_pps
 a=gCYXggIpC+w3u2dojYR5Vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=sqItZrViZ-P-nLusS-gA:9 a=O8hF6Hzn-FEA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 8R0KefBIUD2sxoG3ho_VNcHTWhT37_l0
X-Proofpoint-GUID: 8R0KefBIUD2sxoG3ho_VNcHTWhT37_l0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200035

From: Ionut Nechita <ionut.nechita@windriver.com>

On Thu, 19 Nov 2026 14:32:37 -0800, Alex Williamson wrote:
> After exploring Ionut's patch[1], what I propose above is probably
> wrong.  We don't have any guarantees that the sibling topology is
> static and this bus-reset-possible function presents it as immutable.

Hi Alex,

Thanks for looking at it. The reproducer hits exactly that case. On
the N3000 the FEC PF and its VFs share a bus, behind the PEX 8747
switch on the card:

  0000:b0:11.0  [10b5:8747]  upstream bridge
  0000:b8:00.0  [8086:0d8f]  PF, vfio-pci, reset_method: flr bus
  0000:b8:00.1  [8086:0d90]  VF, vfio-pci
  0000:b8:00.2  [8086:0d90]  VF, vfio-pci

"bus" is listed because it was probed when the PF was alone on the
bus. While the VFs exist pci_parent_bus_reset() returns -ENOTTY for
the PF; the sriov_numvfs=0 write that is queued ahead of the PF reset
on the PF device lock removes them, and by the time the reset gets
the lock a bus reset is possible again.

> bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
> {
>     return pci_upstream_bridge(dev) &&
>         !(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
> }

This looks right to me for the VF side, but it doesn't change this
case: the reset is on the PF, which is not a VF and has no
PCI_DEV_FLAGS_NO_BUS_RESET, so the bridge is still locked, even
though the PF has FLR and the reset will most likely be an FLR. My
patch is about what happens when the bridge is locked: today
pci_reset_function() blocks config access to the bridge before it
waits for the device lock of @dev, and that wait can last until the
vfio user releases the VF. Taking both device locks first and
blocking config access only around the reset keeps lspci working
meanwhile.

So I think the two are complementary, and I'm happy to rebase on top
of the helper if it goes in first. I've sent the follow-up for
__pci_bus_lock(), which has the same pattern for bus and slot resets,
separately.

For completeness, the same scenario on a Granite Rapids-D vRAN Boost
(VRB2) accelerator, an RCiEP on a root bus, has no bridge to lock at
all. There the visible symptom was reads of sriov_numvfs on the PF
sleeping behind the SR-IOV disable, which I've also sent a separate
patch for.

Thanks,
Ionut
