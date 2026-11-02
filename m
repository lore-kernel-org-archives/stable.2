Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793613185;
	b=Mpxg/C5S/rzX5zn4TFrM7bUYdXYONE5niTNL8yJEBH3aT2AY+uJgSHRxliTkF8qDvFbS
	 dH7BnJHh+UFDmhRhj0aozbKGL/oThIEs46wWy0jqqMFLNg7SYmIRcmK+QROIvTKn7Zb83
	 EAgW53xa2aMsEUZefF2i/Rvo+ysvhpRRwUuxDWaMitEU8hK2EOqsGb5I0Aaq3mnFhuYRp
	 gZ0125rgbSNZzQf/FqtE9ZBGP6+fevp5t4ipX92G5Clgv3vo+xsCkz/gYLWLicHGekGz3
	 OS7HLDAOB1zAdH92Txhe06N2aEFhvTG2nlAq6q2u8b1fs3IUwDo1U6A/+A4WclDgBhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613185;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Reason;
	bh=kOe15KtPqzjg2S+jA8JO9mtpUzObAiqXV9FuTcsjnKE=;
	b=VIMpAkZ53hPKIevXuFQMCJ39lJ3hTQd0T3MVvjkZnEh1VUb4lIebXIPmQpz9+tD4SHSE
	 cBgVs5KkI/il2RM0DZvKjQGZ392UPsOpvgJWQ+5GDnN8DpZbEr938SaYNyvr6b9+kziuI
	 gqa3GDXAkwGnGHR7herf5y5pePtnhu4WgMRiXljDfLZ+/8N9XMAHVAg5CG/sMma6Yx8dq
	 r+B7LVNsbk8l9JpSzmd2v33AAEhAzRJlwq3s1jkTK7MjZto99XvTmKTGBsA20Drb8KWpt
	 3VBhbd6nCAZkgZHEiEJy5vp/4OHLsD4U5g6DJgcvBBelMJeMS/Z/j2dQbOwXQfzvWaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b="p0/yZJIy";
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=WFtK3mHT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB6606A324;
	Mon,  2 Nov 2026 09:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFB6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=p0/yZJIy;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=WFtK3mHT
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AZ7q2549770;
	Mon, 2 Nov 2026 03:51:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=kOe15KtPqzjg2S+jA8
	JO9mtpUzObAiqXV9FuTcsjnKE=; b=p0/yZJIy8l+cBo9gDUqoBAc3OrupBHq//C
	Yt+kU3aiZG6IqwNHKOCHPZMgaIFy01wQp2tvJPyuVN5ZzfPcL2ly9HJ6pOg4l2W2
	Vl3pFnjv1PZfqPfL2GeLaAdOvX2jUDtaKM+mk87d+Pfe/ZfC/hVCeoXB0H1r2ngI
	PXQJes8kdX4Qli4BtLQ2L5q5r4BL0FaRPT/vTVqb9ipwp/a4M+V4kqghmdd0Gdrs
	Zgbra2vZjN3Q4F8UTgh3hsGI3OnhcapKWqtFbF92YH37FQE6eY59eea37dskamnC
	BZHbNZ4N/6XHUCPaU8fZQrFUshL6yV5JceuoJLS9Pb2zpCMyr3CA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023095.outbound.protection.outlook.com [40.93.201.95])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4hndrf9n4v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 03:51:39 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCQvwAnzIEfwKvk4vkjnoqmyTmRBDObi5lx1ZFJGcFPuJJLotHhT6zxEtUwBw+p2ZCvLHZl2+SUhn8ZTCp5Bqo4+4zmRSUoXSH1Ve8doE5hjx89q1z4VJFd8M446K83ofwnlwwuNbD/DkSk+kaM8ggKpb7BamcH5O/XOtObWRUGRr2j1lhZLS1DbWsj9xcjbHqbHZbcrDYZu90gof4fl+/cj62HMQIz1PwavX65lYfJEETYgSJ5PbVnjA5+TmQcs8sj/OlvMgmLYz2hXBQ/p+ecbvX5S+2qRXh7bvQksD79h6Uuj1gdew4H72/DQ59YD9i0RrShjQg9gGhNoMg6Rbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOe15KtPqzjg2S+jA8JO9mtpUzObAiqXV9FuTcsjnKE=;
 b=ygvKoZn3xXS4EL7s8cAvvSghOo1mJgy/EDOyOMfkvvlPAEU6L1OCt/8CvGVl7mobKdktXD7PoznoRP2JXznDxzE4Z6D6yhoIsMEMwDoaOT+oCBzX3/777Zv9FGeIhYvUAO5oaaLKQIkejqyt8Y8rUudO9dNZbHUVeTdnZ0JhfU3BF/6+zHYsEYuncjugCzO+E5XMk/aBvzuQBuCpfr0MCfCGtNc/nB82sGqeeBdgrgqNIBEcGjw8v7l9Ivo1ioW/QwHY0QKyENP1FTf3iiXnx9z+9O1BVvg367gVexNZtJ5lY41dWJ1TME8Ftx7QuBj6c/3BEERMYoLQa5LM65BZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOe15KtPqzjg2S+jA8JO9mtpUzObAiqXV9FuTcsjnKE=;
 b=WFtK3mHT3HXwEGxTIMwI9TE3+ooAtypewocbj8gXx4yp19jajvuonYzFmxig5KDGhqV3IRUu/kREFc815a6BcvD6NAeFbI9w+yOiTaxkXDGZan27OzPaLQN4U02OfXL0MPxbr+RJ0/txbK78NoBxWpxqG2D37jhH6GosapqV6Hs=
Received: from CH5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:1f4::24)
 by FT1PR19MB911619.namprd19.prod.outlook.com (2603:10b6:170:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:51:35 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::39) by CH5PR04CA0016.outlook.office365.com
 (2603:10b6:610:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 09:51:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 09:51:35 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E1CFE406544;
	Mon,  2 Nov 2026 09:51:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C3BA182026C;
	Mon,  2 Nov 2026 09:51:33 +0000 (UTC)
Date: Mon, 2 Nov 2026 09:51:32 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, stable@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v4 4/4] ASoC: wm8994: drain delayed works on remove and
 probe error
Message-ID: <auhdJGbYnY95tJBS@opensource.cirrus.com>
References: <20261030170416.3561618-1-tristan@talencesecurity.com>
 <20261030170416.3561618-5-tristan@talencesecurity.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030170416.3561618-5-tristan@talencesecurity.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|FT1PR19MB911619:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a56e2a-682c-4f32-851e-08df38c6e1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|61400799027|36860700016|82310400026|4143699003|11063799006|56012099006|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261022075727099003|10067099003|18002099003|22082099003|16102099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oYirb0MZhQ7HCGMgDzDzK6VIwWeK4UH4S0iJXHnvDXNdbgEOgyunm3b0o0V1nTUiWVslhdSTJkN2geSed1LEgNKgb02q7WenA8wMMLhNFgUjGXz/gEAadHuZkhbr9A4ki7QikFicCkVdpZxiOaMIYWx/FH1ioEcCmasLGlTnzBEwvqnPWRzqxMInJy09hvzIZN011X+qSzhX3FYs+fmo1TVaW3z8+27Es8PsvOzsTcI4KoPHu31AQEjWuEYNCGkXpBKalfyqJrXQz4EjB21BhLMfSy4oue48h2Yiswza5DCqPxrIuaEfq3YQZqp9epxhT+3f7Lza8UKprtypYtF27ZQeGFZoLieS4WgjlUStSvy5mrpOvBxdbjw6SHUbpa0fmn225YMQwyh6l3YT8Alc3A4M1dEECv7uapCHV0UoHxoqL0yTsoYmhHm76y7g2IzKHB9vnOqMhwzKmeirfCMgyFppsBsGeRn11MYhc5tfFA5M4TO2o0iRz4VFCsamllIIrkfqDGsLFIVqtU4sfcFTiE5XH/9+dWlo9JOj7dsWoewqNZmthQueRjH99pEL9r7sY+gkro5QZdpI6uZbUd9j9SLZPPNauOATl3CNNOcCYkqMGab92o3Ergtx+zrCpD6LgNlBC/hgwGCFvoCjhMohXo3y0LNiDqDTgarPJgsEQrJuNJ1vRMwpkl1CuoAH/2XKLMpr04uKeGFRGNqyC6oPuA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(61400799027)(36860700016)(82310400026)(4143699003)(11063799006)(56012099006)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(16102099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VVHCDow7tsG7jEh8SdMzWqZSVb5EbGWR6i+R1tXFBtnBBdUL9IvPUnvg62EBwaa5fDXUPT2v+D6sfp0D79Fpcyen43sqCsHkn9Fa9qfRspWiQs9u1juloZIkRd/5e1r4HLOGzqycBTJHNaXORPpHbrN66yiOWJ68VKFL4TI5iYtN1IuyI84mLD8b7FuqwktUb5qP9v1VCtyoCkwNpeY+pQwyk1bBAPWaWT9NOXaRjJHBTjh+cq8LJTYvgUUkoL9xIqoCxuwkDS9JRH8hATR43HQkZRvMLyw5ZmvOvQ5Xx6IkNH8d+mvuihoAkGU1ZXV3JSg0M4295sVWwGPXCpYPuIjCRsmd4PXU/oJ2YtiNGc/VAhljKtXEt1kg3sjvQ/bU8+MPF/WOuCpP9J9ZAg432m31/PSEZTLEeaqTLphMuejq5bu1MGDDqxk9NXW6w+h6
X-Exchange-RoutingPolicyChecked:
	CT6Z2+ouyPi1HGqxQUZIK+BieUHpMVlc5exgiSXXnmcvFB6TFTIVV5aLQ3bEoXwswrzSoVmXUxyYAnSABsQmXAnICBhrTKTW67Hmivlob/+NUBKUfGmPhfHUS1HYckfhnYodzfV2yJ5Vh+aZ5RhnGzKgpl7+gPafy7oC65HVRB70DOX+oAelx4gXcxpHT4CpanRkqV1iolbTqqKGns3+JtrLjSf6lBQX17mq4P9vD9vwm7CUZ2+IMW6Hs6wImpIuhtSJsBiW16Mwldaxs0J6WBMpBJrTpVSYWTwZHxVZRV3zZNHsinCm287akwC56SWoWfD7aP25ypOUL9TfvDPfPw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:51:35.0095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a56e2a-682c-4f32-851e-08df38c6e1c6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR19MB911619
X-Proofpoint-GUID: vYru2zKhvX9mpdijAucllXcKAUBaZrOb
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6ae85d2b cx=c_pps
 a=ughbxRIXrQd+RLe3kEOXVA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=J_-Nd1mkAAAA:8 a=X033ZKIOL0tLcV38r-IA:9 a=CjuIK1q_8ugA:10
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: vYru2zKhvX9mpdijAucllXcKAUBaZrOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX0kitriGiG666
 vy8Rh8umEp3kD4ZPjqoHrWuAxmutcboblzVO+mmYGX+S+gcS4AoCr8VKcuM2n15B3XId1Ib+0KV
 O9kmt8Oxy1n5C5IrzY4bUXZjWvyli8/6GOyYDZNFa98HyYTiiSJMgWxooM+9rAl6YaFUl8Wz+f5
 Lo+lMcyTT+Yle4AWp0TowxkWAObswH3HQXs4wPRwMhxM31ZK8YfjsUXDj02t2hE7rNSKlhMeBIj
 eAkWn/7TdRsLd26Kf6n8vzY658CMIyCrKzemrb2eYYhfJomRhIhH546++QIOv8+TiIrfLGgcGSU
 sX9MzkH3WFrrERvcFicx94/konLL3Ew36c/qNgrk7TN4mQpST8vtC0pbHmXEABGPFGPlWD5907w
 n1LCaYGTwvMQPyzZmrwgZVD5KFaThuoG+aRY9Lrdy+5IBFV955ow4KO0wal+/Uz2zN73Sisxz1u
 zV+MEQPZ7VJMRVOUI3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXynb2Zd/R+1fP
 Jj2zl4tW3T1CAPEMWcQvXm7xFg1HSCSk1s7HBo1KAmlEvxGhPXCGVlU7aS1l94rnb4ujX6k9f/e
 jv73z/Dr2CqHY+wmjTWpp6iEhdXYzP0=
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 30, 2026 at 05:04:16PM +0000, Tristan Madani wrote:
> wm8994_component_probe() schedules several delayed works to handle jack
> detection and microphone status polling.  If the component is removed or
> probe fails after these works are scheduled, they can execute after
> resources are freed.
> 
> Cancel all pending delayed works in the error and removal paths.  Guard
> cancel_delayed_work_sync(&wm8994->mic_work) with a type check because
> INIT_DELAYED_WORK for mic_work only runs in the WM8994 and WM1811 code
> paths.
> 
> Cancel mic_work before and after jackdet_bootstrap because the two can
> re-arm each other: wm1811_mic_work() can re-arm jackdet_bootstrap
> through the DAPM power-up chain (force-enabling MICBIAS2 triggers
> clk_sys_event which queues jackdet_bootstrap), and
> wm1811_jackdet_bootstrap() detects a jack and ultimately queues
> mic_work.  The second mic_work cancel catches any re-arm from a
> jackdet_bootstrap handler that was in flight during the first cancel.
> 
> Fixes: 99af79dff5a6 ("ASoC: wm8994: Ensure we get a notification on startup for jackdet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  sound/soc/codecs/wm8994.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 8bf58a6a8af7c..b9e0df83b9bfe 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -4551,6 +4551,13 @@ static int wm8994_component_probe(struct snd_soc_component *component)
>  	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
>  	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
>  	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
> +	if (control->type == WM8994 || control->type == WM1811)
> +		cancel_delayed_work_sync(&wm8994->mic_work);
> +	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
> +	if (control->type == WM8994 || control->type == WM1811)
> +		cancel_delayed_work_sync(&wm8994->mic_work);
> +	cancel_delayed_work_sync(&wm8994->mic_complete_work);
> +	cancel_delayed_work_sync(&wm8994->open_circuit_work);
>  
>  	return ret;
>  }
> @@ -4592,6 +4599,13 @@ static void wm8994_component_remove(struct snd_soc_component *component)
>  			free_irq(wm8994->micdet_irq, wm8994);
>  		break;
>  	}
> +	if (control->type == WM8994 || control->type == WM1811)
> +		cancel_delayed_work_sync(&wm8994->mic_work);
> +	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
> +	if (control->type == WM8994 || control->type == WM1811)
> +		cancel_delayed_work_sync(&wm8994->mic_work);

Both paths appears to cancel the mic_work twice?

Thanks,
Charles

> +	cancel_delayed_work_sync(&wm8994->mic_complete_work);
> +	cancel_delayed_work_sync(&wm8994->open_circuit_work);
>  	release_firmware(wm8994->mbc);
>  	release_firmware(wm8994->mbc_vss);
>  	release_firmware(wm8994->enh_eq);
> -- 
> 2.47.3
> 
