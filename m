Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7946A61C;
	Wed, 26 Aug 2026 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766678; cv=fail; b=YQLkXPxynoTjDFuq9idyQwUeaoumhtvJkeCYVUW7MS+gKsq3o+NOEGvT3iSWYNR6vrxk9sl2VBQBlGcPKzY6KTNVSvqpyRYln+4xBAbYo0wTdXDDPFzmSGwlTd7HYMacL0gO2XzRmNAOPld52VCEfgk75rdrSnm7Zzv4tTEzf8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766678; c=relaxed/simple;
	bh=zYUfBhAdKGjlPC5eakc9RcWhK9KWxvMKFYs7RP3I75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FU5E6VmzKzzCs8u5eyWjFExqwO1U5rayrSDyhYpWddjmlm1y/N80CVY/dW6imKW/9MOzIPPTBbl9Sf3k8F1+0YksPQijg45RWw2nbszyMSxE+JKDHEUNVy8bHJ/nua7hciLohGxFz75QZ1l8BtFV34Q5QZKtDJge9VtTaEnJ5lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DG7W8D3w; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DG7W8D3w"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGw7hM280327;
	Wed, 26 Aug 2026 10:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=8jcasMAjOnbGXwCmfyg8XPO5aozlx4CAzn4AbIr0mqE=; b=
	DG7W8D3wtvnDhNEbT2+KkMyXPuN6SNb3NRN6135HR1L93gdfGoMEKqLtLUbVOU3+
	thNY114ASAUDPiYBEKph035GTIRJMQamdQRsKyg260RLM0K2oPklRlLaoAhZUrXr
	7NxRsradwPRzeFb4+Q/VN/2pIhNrJfb73crH63HslSMgZAsRbgBWSfzRgw0QPJry
	+Q9wUXzOd5evMjSdd9Wo8dF4AIELiq2PjmyK/olCVK/huCUmF+iY2fvjrhBg7Ojh
	fLmn4QpgmBRwdx9I/k3V/G9IbJN/eq9RnOWAz5BtxR3gABwUuiAmUXoUvQUVi5EU
	9UOpjIs3dVX81xRxKDtf9g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020082.outbound.protection.outlook.com [52.101.46.82])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7b9gpym9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 10:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KziSw2+ep+gwMuMv6PMDFqbrBZLLkPyaKi37RGkXlLWaUMfKm8n49RDxlFyuzxx1qLLEcD/wSQFPFZvIyRcO0YxHtrJ5aNxLnZzZ/5TwIsRwyICMqsM8aY9mc0GydYNauGHymuu6tQq73UL4aqOv6pn1JDl3lCSv/aqiU6hVPxPQfdXn9YuGRQJYHKfuOF/Etfsx5k3KrqwWhXdTLPUSnowZFArxRPCK82gLXFWG4FscsRceyMmTB+fYmOotvZeuaqdr835bRuteq7yEoOoHoOf2p8nT9QIzI+IFT7BnBuaCErHJpEhUTQ8xwArslEQS3mIoUERPKr+A3GNd4vR5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jcasMAjOnbGXwCmfyg8XPO5aozlx4CAzn4AbIr0mqE=;
 b=b8v7JSrgZi62Ud5HjJ+WzQuX7LvoT67t40vEimFMzHt+fPm6wHWDlpBYM1JGn9ff823Bn9s6sfNw66g4n1VZuSaGLxPC1PzexSHpr3Dqw9+Z/fHQbAJ7fm9/E6SHbLOP3Uc93DGz0CQY/eQu/60yUq7A73YV2mtoOkJA9vW3sKb2zfnEMwx8+G7fTmsUNNfx2xikAEyDh5LiVTrERa8HjsfxIldsn5S/etPz1YT/CIkkeFYDmusRg6PrbL732SU1OGtfCa8Y/zcmQsZie9SL6mu0G+8O12tXYOzKlr9blLE1sqUqwXh5LMCTW/2c1J5ofuUPRz/VGw2Jtzdw49sODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 17:50:31 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 17:50:31 +0000
From: =?UTF-8?q?Juhandr=C3=A9=20Knoetze?= <juhandre.knoetze@windriver.com>
To: stable@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
        Dmitiry Korovkin <dmitriy.korovkin@windriver.com>,
        netdev@vger.kernel.org
Subject: [PATCH linux-6.1.y 1/1] inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
Date: Wed, 26 Aug 2026 13:50:09 -0400
Message-ID: <20260826175018.131474-2-juhandre.knoetze@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826175018.131474-1-juhandre.knoetze@windriver.com>
References: <20260826175018.131474-1-juhandre.knoetze@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787766292; l=3027; i=juhandre.knoetze@windriver.com; s=20260821; h=from:subject; bh=7YRRgoM3/XxENZb4jyQyU2zWU6dcyPdFTlc9nYILwYM=; b=PB0oevKATttnHxwVgJJLVrCmLp6RL41mUHbnulNfG7xlK2KySghUXej+2CC1LyJfwjVdJC7xn two8nO3gSOgAlfReT6suG+nGmQazvNBjEvykls0WJlrBkOSTYWj6IJw
X-Developer-Key: i=juhandre.knoetze@windriver.com; a=ed25519; pk=C2rmFq2p61pIoyBkOTAC8McUtyOS6pLmoNnXTPuDe7M=
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fbaa7a-3595-45b8-6246-08df039a85e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|10067099003|3023799007|5023799004|22082099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	4AYhhE9107U1a+Ldu9E5mZrbGGAbIsLTcmUVys67hHfFDSx1odsLiQEljyNQnAlAs82lb8S8ytpM0mQrLbkcKsVT5g5nG+DFGOBipFFn2/UBFIvlLmkh8W6tDONT7nv17i3G3X5WksoHrNfLuWsR2gxjre0+TYpMcUzPbLuHcE1FAtJAZPlV/Oon8tNq66QnQ7+nYuKDBhbk+I3RQG91+uk2/8OLzCbCX9KNjCXw10EkxC4ovKi+7DhqIF3+TK1Z1nxPN8ufCgPf0u7/O2+HFR0d2QFsko2HW8fKO3JpQZeuNHvJZFjdtSHpcNe3an7le+OqFeLkqsna7KoUAMLAA3fI0k0QOq7VBGrnu9FSEo9FwGZQvo/KXZY+8ufkNnvXed86yn4/8m6nGZkOa9fj4SutAP/WDv/swUZ2BV9ncAiT4+rq9u4sQ/QhjgQWBXcXSjI5BmiZKqsXbF+j1IeUjO0jPSt/Kjbci42UXdtBx2Swmt41k74PtIXckdjt0RcS90GhjpTLUPWsctv/FulNMUUG/yZdqbA0b59HZY7w1eFgWu+dnMC/yapmOKsbTEcsMMDvpYWGV7dpE5beIjyWeHHMY3BJ1ZljIg8PMDV25oWHlP1smkMZOhLb88cSsFubJSuv/X5nwQ+HoTXiVmwbquN0fysQawxg2tVDZB6vva0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(10067099003)(3023799007)(5023799004)(22082099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElaL3YrazZ6MGFCUDJ1NUhUWENsc0h2NWN4ekwwbkRKNXdNdW1OMDJPYlVV?=
 =?utf-8?B?Z2xKY1NsNHkzT1pkNlVmRXFBWUJVdXVia3Vya1h1aFdnVVFEcTFoZmFOMHJa?=
 =?utf-8?B?L241Z3pKSHA5L0hHem5IdldkSDN2bXBVS0JpdkhPMUxqa25jUmpxTFVGczIr?=
 =?utf-8?B?b21uWXpZaHpCd3JKRlhubVdnK09mL1A5bTRCWEdyMHFGcDRsdi9pTDJNYkFY?=
 =?utf-8?B?UXpEeDlxeUF4aFcrOXI5aTZ0UGRtTDk0ekdNR04yWTZsZ25zbitCQlo5RFBm?=
 =?utf-8?B?cXdvOTdhekZyUU5UNnNjeW9iQlRMMll1NFRGczNMQnF6b0xsUEppdEZ4OFdP?=
 =?utf-8?B?MlAwUnJ6L0dKdXgzYUJQRzg2M0hSbmJrdW9nUU5uUXZyYklwZGJWQytIU002?=
 =?utf-8?B?emFOT1BkZENyR01mcENDVVh3WG43Vng0alBUT3BXamlXWjdNNjNYMjNCS0xW?=
 =?utf-8?B?UkJWMkdZSDJ6b0F0Z3BLNGY2Sk5jd3ZGWFd5ZGExVHBXTWd6Y05aRVRIU0xG?=
 =?utf-8?B?YXYxZVRRMG9XY1JPYVBiQ1IrS0ttUXJPMGtpeVcvYVdrTk1nRFFUQ2UrSHZL?=
 =?utf-8?B?eUhUQndYNW1mR2preFJ2UUVvVmlmSUo2ZW9BNzhQcXNGdFIrS1JDSHdvSktv?=
 =?utf-8?B?Q2VTZ3F5akx4Z3liL1RmQlpaeEhIZ0xiQU04b21PRlI2QzMrakRscmFBL0JD?=
 =?utf-8?B?N1pxVEdpMzdLaGc4ZXk2NGhJNmFJK25jcmxiODljMFZxSXZJN2V3SEZYR09h?=
 =?utf-8?B?WWVqZG1RMDU0WnRtYTRINVRYMFRKSVQ4WWxBS1hONEcvdnllZzBRVFlHTGN6?=
 =?utf-8?B?OG1QcjRoNWJOT0psRmNkQ2RpWEhyRUNwcFF0eEdOaHg0OGhLWjR2S25tMUph?=
 =?utf-8?B?S2NvYlB5TmVLUDlUZEZlME85emxlb1djcHpPZ0JxRDZCZ0VpaUN5NTZwZFc5?=
 =?utf-8?B?N1EzNkozOHVneHNEZXN3ZlB5SXNaK3k3U25zL2xrV0t0NTBFTHhCc1pxMGxC?=
 =?utf-8?B?bXJscXlnenRZUS9uSTBCT0VOS1paR2twdXhaaHN6SlgvQVVyQjZjZ2kra1pR?=
 =?utf-8?B?NGlqZXNnR1Jnc29mZVhTTzdpUFBRN1ArOUJiZHhCZWpxd1d1TGVqRHQ3cllw?=
 =?utf-8?B?U09BVm1oYllOd21jZ1c2OGE4SnVUV1lpaVVvQTlBQTYveUY2VDJNeWNrVFFB?=
 =?utf-8?B?VWc0am9VQVowSVUvckE0aWEzajFKdytyRDhhRmx3OXJRNUtuTkJuS1Y0OVpv?=
 =?utf-8?B?SEc3WjMranFGQ3hsUk15STQ3aVpCbVphRGlBejlFbE5KS2tzUDZyUHZMTVgx?=
 =?utf-8?B?alQ3cU5IcTZ1QW4vejBjclV4S3EwQ01DN1kwRHZjaUdkL3g2cmVtWTZCdnRa?=
 =?utf-8?B?d0lEb2h2YXRFRkpteUxYZ0VxQ2FSRDdncnFtbEZFRXcvNVZBM2VzQ0hFNGZk?=
 =?utf-8?B?cjBtand1cGlPQU9MKzVWMFF1YjBnRWUrcnJxN0ZMbkw2MFFNUmJaNVR0U0RO?=
 =?utf-8?B?dFVxdnJ1aDVWUW9FWHBuOG1sR29KZE5jM2tBYjVrdUUwMnRXUldDRitYb0Qx?=
 =?utf-8?B?UVgxOFJwRlh0ZDBCU29TdGhDeFhjNlJUckZMeEgydlBTQk5SUkxOeDRFdm5h?=
 =?utf-8?B?czdLKzNEamZyemljb2t2WnFmZ0kvUThERFlvTk5HMngvWHdnaGJKL0ZvMUhr?=
 =?utf-8?B?Q0NPN3RwTStZbU1LWVp0VU5VeVJvd1RqcFhBTW96M1VMV1BSdVltaXhQc1dI?=
 =?utf-8?B?ejNabUg4QVk4aTl3M0JkamNObTI2c200a0pHWkcyRDduNDNJeHN1RitBSlJi?=
 =?utf-8?B?bGVWL2h6S0dMR29yVS9jOXpVNHRJbk1WdHBDb0U2Syt0ZFBKUmVvVFBnV0Zo?=
 =?utf-8?B?WHc5NFVpUVJRTm9KelVtTHA4M0RscXcrUlhKbnQ3U2FGbElEL01oclB3OGRF?=
 =?utf-8?B?QWFmYkg2WGMxRVFjM1A2cmdUL2RhcE9qLzV3aWVXWHRSc093b3Yyb0pld1la?=
 =?utf-8?B?aUg5dnhYVU1WLzIvK0hTZVZiQWRqSmFQdjY5QVdNK1A3aktGUDZCTUlIWG01?=
 =?utf-8?B?NHJsUGVIbGxicjlyV0x3MW1jUDFMSVB2STFiaXVTRHhKa2FNdm5KL3RrZTFM?=
 =?utf-8?B?dU03YnMvaDRMNUpaOFozcWFucEpTVVRvVDhyOVdoeHhBQldXUlFsR1pwa0pW?=
 =?utf-8?B?NGRXT1lzUVVWZWFsQmZ0UGpEa0U2OUFNVHJYQXIybWt0UldMNy9WSDBpVWsz?=
 =?utf-8?B?cU9LbHZjaEw4OWhjek9wK2w0MVptTEU4YWRwa3BUS29hRVlQZE5JSUQwMG5i?=
 =?utf-8?B?L2Rsd3VQYWNhczZpcU9lUUJIdEF6RDlGOVo4OWtzTXZsRFVkYnk3RG9JeHJv?=
 =?utf-8?Q?LXJxFZs+r+2IyVaa1EKMN22/1LHmNso8PNl23?=
X-Exchange-RoutingPolicyChecked:
	aq8J+aFDtjwikg36qEYI80UeZh/84Q6krVWkwKuiKIP2db8aoQayOW7AXjVFd0NMNlWt2GZtKEy49Gdu7kRl82lV569qlxpZ53ZAujvWTgf5iTwTxTQOjgdvhD5bZ2x4AfoNZJXtIMTsnVK944G0INNPDhHjlR3tgBg4o6K9zMUWPvvvz2eBjVEIMfJlHD5sGkSvyXrJneeK5LHcHqCWavOmIxLzKiVJUgPCLJGNslSHCq2SEYa3utAYIBGjxAQqBdhbLLrQaE60JmhjHA8to+NLEqesf26hQ5TMYQW4qVhoKvkQzhgtkZRX6Ul3u4z86VyrHnOzwCcbEhlJvXCPjg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fbaa7a-3595-45b8-6246-08df039a85e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:50:31.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjAPmJ286gerFSxVhaALGnRo/6W3P9rTO2DYj5meRJK2R58ucq8q5NTNFRqC6ITWC8mgQm0HHpYIRTOhdIgoHFdp79dAvIeigg/1RoLlYXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-ORIG-GUID: nTCCb0ElQ6jHu6CnblloZ7mYAIiXH4zo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX3gwoZ6C5kX/M
 SC0vMbeOvx8wIH0ee25LPtMgmVUEGrt10bNIbXLQnmknQf10mZdidkbyCONMxuYFlR8Ih6jmqFR
 2RP1KyXaY1W1aKt1hIu444MtxE0uhMAwATgqrOkSxL4C6gy7EsVaQWtxXam8R2VW2VZUUldhsOk
 IeyvaSMRaiHdC4zlF071rW4EncaX/v4loxSy9K45PTg98VGGxxAQhCdWy0FEd1VAGw8bs/Nptit
 T20LBIX91pJLlMXXdF3PuJ5LQIHAZ0X4ZRbUfjV45THc3ZxgCzg6B4lFkr9XLeupnAS2n1Q1jQf
 ZTS5FOe+iFuSuJtpV7D6UQHDJ7JLYa5V/WMoDfqFimB4RGTH+wKg7WNuI6xmzYJDh4jkzbBzwyH
 xu+Rgg6u3+oOUREyaBy/wyBZ9yN/uIbS8uaW4Mjz6Vu/EQFm9pnr6o8PzN1J/UkhqbUS6sPca6u
 9VufKFafPXGGCJQ9FPA==
X-Authority-Analysis: v=2.4 cv=LtaiDHdc c=1 sm=1 tr=0 ts=6a8f276a cx=c_pps
 a=SBNZrs1CJjyqcQ6ja0jd9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8
 a=t7CeM3EgAAAA:8 a=HVhD2hLSRDU8YtGcwusA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: nTCCb0ElQ6jHu6CnblloZ7mYAIiXH4zo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfXxV3JeucadCiy
 IsohdOZ8fYV41hL4QcsNj+/3iCCzDfqSAyzm4Mmmp2yAvB8YGJcwhCsguuC7ou5KXX79vpQo68K
 Xs1MTJthyOZgpG/OS/QIe532fCtB1kMLA2T2vExX+JiWNFjku5lQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260149

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c89477ad79446867394360b29bb801010fc3ff22 ]

Yizhou Zhao reported that simply having one RAW socket on protocol
IPPROTO_RAW (255) was dangerous.

  socket(AF_INET, SOCK_RAW, 255);

A malicious incoming ICMP packet can set the protocol field to 255
and match this socket, leading to FNHE cache changes.

inner = IP(src="192.168.2.1", dst="8.8.8.8", proto=255)/Raw("TEST")
pkt = IP(src="192.168.1.1", dst="192.168.2.1")/ICMP(type=3, code=4, nexthopmtu=576)/inner

"man 7 raw" states:

  A protocol of IPPROTO_RAW implies enabled IP_HDRINCL and is able
  to send any IP protocol that is specified in the passed header.
  Receiving of all IP protocols via IPPROTO_RAW is not possible
  using raw sockets.

Make sure we drop these malicious packets.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Link: https://lore.kernel.org/netdev/20251109134600.292125-1-zhaoyz24@mails.tsinghua.edu.cn/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260203192509.682208-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ in 6.1.y kernel icmpv6_notify returns void, not skb_drop_reason ]
Signed-off-by: Juhandré Knoetze <juhandre.knoetze@windriver.com>
Signed-off-by: Dmitriy Korovkin <dmitriy.korovkin@windriver.com>
---
 net/ipv4/icmp.c | 14 ++++++++++----
 net/ipv6/icmp.c |  3 +++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e8c59c2051c2..7c4c7b7fe384 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -868,16 +868,22 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	/* Checkin full IP header plus 8 bytes of protocol to
 	 * avoid additional coding at protocol handlers.
 	 */
-	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
-		return;
-	}
+	if (!pskb_may_pull(skb, iph->ihl * 4 + 8))
+		goto out;
+
+	/* IPPROTO_RAW sockets are not supposed to receive anything. */
+	if (protocol == IPPROTO_RAW)
+		goto out;
 
 	raw_icmp_error(skb, protocol, info);
 
 	ipprot = rcu_dereference(inet_protos[protocol]);
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, info);
+	return;
+
+out:
+	__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 }
 
 static bool icmp_tag_validation(int proto)
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index f8f7c1246f43..e984f03b0b41 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -861,6 +861,9 @@ void icmpv6_notify(struct sk_buff *skb, u8 type, u8 code, __be32 info)
 	if (!pskb_may_pull(skb, inner_offset+8))
 		goto out;
 
+	if (nexthdr == IPPROTO_RAW)
+		goto out;
+
 	/* BUGGG_FUTURE: we should try to parse exthdrs in this packet.
 	   Without this we will not able f.e. to make source routed
 	   pmtu discovery.
-- 
2.43.0

