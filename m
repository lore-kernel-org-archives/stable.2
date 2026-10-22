Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792696561;
	b=wLXMKYqPByDRDYP212onSZpBcIMBY++Aa/2+x3jZsyUNPqCT3sPiIu62ubhV+ujbwHyb
	 Tj4NTe7+4k2MdT211OX1yuLRC3sQ236FRjIL4Xdt9eE+Y0UEXqfvLBzs6zDR5cJctB0FI
	 2fvEi+lOFIWW80BjINXPH2Ev86TsxojK/QvoeQxmqaijmopRIRfMeAkv6QzysPZdEWfv7
	 ZFuiPAVmKzBsLBbn8rjc/0x4BblO0OnGIRDut5tDVV+3ud46g/oQvk3azunLHbc5hTweK
	 OiVShW/1Hdx8ka24D2GJ+xEb5KAS57gdy+UCDVtvf8On7aKUHxZ6SUnwyZ1ZMJXjrJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696561;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/LbOo=;
	b=bVVF/28uIhHWj1XhtGPIz7/9WdK2piHhpfq6bED/Jnatg3GGp8LBZM3cEi3L/VWQyD4h
	 L5EprlR3ODhsnODEAWM6f/B2b2Cgs5akRdH4/Z1l6Emd1FC9vzncsq8+Fy4Y/lPYebL2Q
	 L2lHUfqe1gFmOwrxqyYB5sabUFavmxoaAmoEOZ7dYrqFW81x3NVyoekuHPzJo+vAB8YYm
	 aMbHvHDQaAmOVMF4F6e9ixPKAM3cb6aPgZF3aPNvNU3CUpAtdvcfYXHJhLdWCtwLgnU0Q
	 uDyhsQNQrkhVZ0l18hy+qMyY8Ju9taEbrRv4r96eaSvBwQfqqZ9xJTwmX5Bf0yGA+lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YeccHUNG;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j7fd3YfR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0A606A319;
	Thu, 22 Oct 2026 19:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D0A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YeccHUNG;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j7fd3YfR
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69MHsUZO3652497;
	Thu, 22 Oct 2026 14:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/Lb
	Oo=; b=YeccHUNGO/guGxvx2TIKKz2GFBZqU7Lhd4sPxlOFz9QZCaMi3wPYj0fVp
	vSSKnArFqWmx3qs+SeZUYLeZ4DJSNvEG4qTRfno4179QX03FEC0gob38XuuFj7l5
	XYfJV/W2kIL1GZ5hJNtnF5ArInEM4+b0K1o0OWreKuiDP42Ki6lp2/bOOwo6DC6S
	dOXB4wC3rLCZEONg20iQK6e29RroodZiC01KWa4D07gQUkRIPyEmqi5zK3OtzUsE
	2ebtdbc+M7yZU3xIV6IW6O2e0uzeOm+n9i0LxkZVfVodr6gubRi5xfBs3/KIcsAT
	6D3Z2NyV/tElUnryz/0U8/M3Jjkpg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hfmg81qvu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:15:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YomMtlwwrnthW2vWBrJIn8VywtIx8R9SZR1QxSZaJ2bKWD4xSPlJARY147UEmDCX3Py5TSAHzIv5XwLDpq+gsq2NP0C3qo+VAlgbGq4tf5O7N3mHeI6ZoLYEPRrDSwNRhAtu36RRqJxtcp7Qo+2UUEIZPZEU2Mb0bjeUq8lsdF58Gka9TdMJ1HX6XzUPdOIcdOpUjZ/4VjT7KwsWi/vFyTBfdWLO16qTDIWJTlTfpW97ikfyCP7nNRFBRFsXaOZEPsdijJ/l5lq9B3aG3w9IzZh00hjgrXD3YGTF7RJnCp7+xt8PO2URKR2W/hdvP34y8rt4ic9sX5ulaH9toOGIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/LbOo=;
 b=HdSdO9yZq5b6ebLBDpZBwkoCe3hbDWVKPMogJyJaue6mWwFWRaqN1Ub9V2FJxjF1GvQwYkcLrjQCOM69LtEZFGv01vY1UFzdL/fbSdif6JqBFB+wwC+2R+1aQbmxH+QX8HqtnnEdHeYJgZ8xamP4n1kaDqg+4Vjho20YkWYSWsQ5A5uyzEaHAM9KH9ACKK5B56SfrGZ9o+H2lO7Mjy6XdxCDBP7qSy7uiEw9tr6XWENuzzV4QurC4XrB+lvRkeiWLVTYV30sRqktS2aPvT3OEs0SMB7v6v0OCt+lCLDCn7q0blrYiffUrnwdZas2lrj7dyKikpuSk8eBkCiFUhqvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/LbOo=;
 b=j7fd3YfRB+tHwGlZ/a8TIIkmwpdmriqrJzZ9b3EYvtoLFlTTpqpIJ+RzwbrRQ75DcjtjTkskp4igkTeMRE0Tm2bBew0vbcra+FA0G4BcK5fp5eI8ERZWopM+fBZaTILzxclZjXjMJBTab2docWJrpW3VYXIFL1wqGKMzcb37cpw=
Received: from PH8PR05CA0017.namprd05.prod.outlook.com (2603:10b6:510:2cc::29)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 19:15:52 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::76) by PH8PR05CA0017.outlook.office365.com
 (2603:10b6:510:2cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Thu, 22
 Oct 2026 19:15:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 19:15:50 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 14:15:08 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 14:15:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 22 Oct 2026 14:15:08 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69MJF5iX989659;
	Thu, 22 Oct 2026 14:15:08 -0500
From: <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <nicolas.dufresne@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <b-brnich@ti.com>, <stable@vger.kernel.org>,
        Jai Luthra
	<jai.luthra@ideasonboard.com>,
        Kendall Willis <k-willis@ti.com>
Subject: [PATCH v5 3/4] media: imagination: e5010: Move e5010_init_device to Runtime Resume Hook
Date: Thu, 22 Oct 2026 14:15:02 -0500
Message-ID: <20261022191503.1025072-4-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022191503.1025072-1-b-brnich@ti.com>
References: <20261022191503.1025072-1-b-brnich@ti.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 88987842-d525-4ad1-cf6c-08df3070e28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261009223027099003|261022105027099003|261022075727099003|56012099006|261021135927099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	8zO3jukZPvyRDWbd3iDxL38JeEZWAs2QQQ0q4/e1hchv6Y28xcPQ7tWB4F0ZE/DA0UtfBRQmDK/CiaIPchOU7bwFxvdDFoXgkt7hQHPYgMYerz2kUn2z7AFeiQB6qHLLKp9o+RTqptZ8M9afFeeDja9WJmE6c8zEJ/NHMjbW/1KIgWbLnKzjGqnfkmXh16h7v/wxyNm8L+tO5KoujgvySWDQnOOV1VYnr/nY2NgG4riWpoaFzGFVdsSnecUyW5YirpI254tW6psk2Dd/meqU0aGA68Ch1/F5EjqcuRzZytKZwis77Jr264dKA5uPGmFY7l8+naBd6SUa5erTM5e7gDC6sUlSyn2txB4QcMr/3hSSeodmSx/ikHRQQ2i2T2idSPf2wT25LI+YmlRjCgJW9xWSWXk8Ba2Tm4FpuHL3DL475XaZzD0QtnWtJzTv13HuyOkdSO24JaVPlXG1y2565g1LSiV3HXRjzBwRDzcIgXIbLUfE7kMC6vRUbPos9eCMIbjuwmkJtaCzxtaSKgWVo6o9Y0vIB6vj+bjgLQRvCmnMbnmgiJ7r8dJwKx+yfx4tf9925TmkLZaDM605nog7DyLjSAYPmjK8uPNlnWfS0zDpf8vqYiIspkK23+I0WOi4RZF+sVoAqebfjOOpVVihh7A4gU8+qGyws11vuEQDN6CzHadeo0estrR4tYatERpa437J7d4+q0Ne9M6walifIw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261009223027099003)(261022105027099003)(261022075727099003)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VTi9EUdNxAq2QWHDTjxboztvU9cKpoQm5rqI16MY8U/rAku/ezUDLfcSUd8cGkO0MG8M7HisCpFGsYqBPBTFWgLhFcYKQEFS+51aqSte1p9Pxg1ejPIcE6R7qFvNgNeyWteXHS9IWZ2g9u7haT5XTxuGCQ+8U1y4Yz60j53RLXLg4IlyABcTKoot5NmQti3vW5ba8AEYLw0EuL4ing8bIwdYZJ4oDiU62YyEFwRmzHzayDCLsXY3Y+XcRP8rDVGrF57W1BbuspN+ls+OWUzcYYbVbT9qvwb2C2dGqlmtZT4yM37f13DBlBkgV2TSylhIn9LMkrowQPjK/MxtSVT/Wa/9+GncVCpBIGASQGB61gvDxcRjtd0X8xGg1MRLyuYmz6KRDC5rCQcyX8nvh0oELX42ehIl/lDS5DcI+6gXQEysUK2Ks84rJaJNYlmIbTtd
X-Exchange-RoutingPolicyChecked:
	aA/RF7f/Eb4Up0eCl/2u+Jx1f1o3eoONakix06sb50p51op0RZLDas9FanFkg3SmyDEmLjsH0OMTnYybNH7WOGooBRvN98Eo9nAd0fgVcin3OW23VWh2baFctR6pQ4oPe6faGCHrGIAmy3SKA4ltL+otxckrCPJj8uf/PHY+HpfeWa0FNMFvKxekSKYMCgf4XVL8qph2RInt5ywe3cWKA6zyrhoAFWdn+kW8o5HucU/ahy7ruZWiweAk3WH1Gsrn6075oGnvnJ2WNKePu+4Cfw7slRPfj0pKR9Qet6lX8IANG2Cb4CrbbFHX8h5XHXEafwxT/QaoD9F6ZKt75Wuudg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:15:50.4021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88987842-d525-4ad1-cf6c-08df3070e28a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX3gJpsx2o9KFZ
 BhxZ/Fc3K6EHMlAJWJqjzPURMfQ9Ue1AeYDVdCHVRxaRWfkwBI4Bofx2t9LKFyx8gsTui0A3Qet
 eo9TKZyCjFanUfw5h0Hm5nWs7+akRBM=
X-Proofpoint-ORIG-GUID: RF0y2Idrh_qHF6gUiTtxGMSbrfQwDzvk
X-Proofpoint-GUID: RF0y2Idrh_qHF6gUiTtxGMSbrfQwDzvk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX2uGlgnY6nb3g
 OKlYJP/iG8ZpqKuof3hNnXtEXpyLT3qy/78Z6U2JMXM7JTBvyRH+0cw2CycJg0bXih+h/XFJXnr
 Uzjq70NqPyUiaYwa8btKpL+O7tCOuSpzbx1QiGzZe4oHTHebnHZ33gkqUErvNcsLeYAHfXsHYB6
 v4vcxRCNRYdsxGTHuNDa5jVi3Y93MvS8Az4BwNyXORNjXAGE6xBHnIobPQy+CaHiD6n9tMvGvZD
 aQgzH9A4xaa63AdV+Y84ltLv11yKkl+16kQv2zKqf5T9/RCWwBobYqipe8q53dA8IjvJg34X+VF
 Wn7s9J3p86rhy1FtCsj65H30ZeI/fuh1R0OGzR4NG4jSL58VzRn6Pm7G+B5KUZT1cN3yu7d87ay
 yZ5qIt1aHXUNZdUIhwROnsPU19ZDaC8gTq1fFyLXcxVQkbAiqpFp4fzSXjJMhb4GE29DHU1L++W
 zdBGDlkSlocLAksbZFg==
X-Authority-Analysis: v=2.4 cv=H/1OUOYi c=1 sm=1 tr=0 ts=6ada60eb cx=c_pps
 a=G+edI3GLQse3gACT8XNfSw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8 a=UlmMjaRoNFhtWZaF8JoA:9
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220076

From: Brandon Brnich <b-brnich@ti.com>

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device attempts a write to a powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index b8e24f816648d..c25ab9627518e 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1516,6 +1516,13 @@ static int e5010_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = e5010_init_device(e5010);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable e5010 device\n");
+		clk_disable_unprepare(e5010->clk);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1548,12 +1555,6 @@ static int e5010_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = e5010_init_device(e5010);
-	if (ret) {
-		dev_err(dev, "Failed to re-enable e5010 device\n");
-		return ret;
-	}
-
 	v4l2_m2m_resume(e5010->m2m_dev);
 
 	return ret;
-- 
2.43.0

