Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807642;
	b=ZIvIqHtOCTXNV0BgP3hCaSEtbDPabEHS5ryuYWee1bwOPS7LgG17O3fZ+hNfwdap7Zws
	 CGwFEOd9H+THJFP48jnUbj0ORv0e2tpEHb1Og0gFxB3yqjZY3I/Cu6Gh5onWd2mife3mD
	 N5IIT0J4NTNU+jWqaEFNUboPM/+FvUMMcjsXkrbwFhbXl49PCqHmiJz/rxoIfRCFu8ecH
	 YYEyL4WgeH+bDf+WMoubyXx/m+2qdpD4NWf8xReDFKZJhuk5Rv+jNl58kQ20lQMUUZHGy
	 wYw5uNfP9yjclGTE+2CMgsb+kYzaPkbHcSGu8XDcTg5l6dbHDdM2iOhEGeGOQyhjUgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807642;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r6DQFXeHjqW+2tsb+xhYIZQOOEeLrYslZi5hX5XnJp8=;
	b=GPXBZnIlFgSRKUtJ0RxbJv/UfxCbUiWaKFwr+K56SpAZylPYZmVwguPPYCDKe/sKYB0x
	 0+s5CsNcPT+XmGpbNz5vXcfK3HjfcooRgstJfFgI5EyNkEi2OLN2KPiPnUfbccC3tFQ+V
	 AWYs9m2ELz+nv3ivqAyvluu5gZgKI+2YTR4CD6c2zeqh6uTb9MqnxebDxCSnb+cuipRir
	 BCWJaL1gphHwzZ0tPBf3n80jEqM+JnSblpnXfp7hXUyU1lsqXqv6k3RfrBfepUOG86NTf
	 EpK7B+6ngL5Hu5K1HawmqvdAHr/vIEqsBkI7fZAGfClMiu8C6EySfj+63lSTJDHmdow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Y7NhNDrl;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZAA7ryym;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E73606A326;
	Wed,  4 Nov 2026 15:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E73606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Y7NhNDrl;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZAA7ryym
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A4FhKln133697;
	Wed, 4 Nov 2026 09:53:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=r6DQFXeHjqW+2tsb+xhYIZQOOEeLrYslZi5hX5XnJ
	p8=; b=Y7NhNDrleEDtTxqhs+aYm//RuyCsaGPU35AZjzHViHaJxjaph5/Lqwpfy
	VC0cqWOrH2uXlfZiD+IrlnqJju3B/NFu3k1dYZAv/fx2wAh4ZprntaQ9oUgmTZW5
	UsqrNIYth+qahQ9In3P53FhDxXHf53gzuTuyDbObnT4YkWkk+LTlrgQbBmOcrO5K
	xQJawWMplJsLvJUzfuUTvNkz+4zetkuTtxzN6DSszawdeexnkVRnkilchL5OXVsR
	KtTX5FroqJo2MXxVghJj15P5aOP0faZMf31twOr8LTKsEDsVb0FSOwIZdJ7Z/OSb
	cHNe2Ie/D8yV6ub6sk7bxoCsfuPsg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hr252a0pt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:53:24 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7tsSEZARcf/mj4nqygoBpU7B1i/6lAtDfVdXkxJWL2lsim80WnD1b4AZpPscgwyUTtsLKsunZ+x8i58dcC2zsBDlkkesuHNNQq1zpGGLOxQt41ytmvx9+VKy23y0K0rw4mNgWFL56xh795WiWiKjTVN2LIq2gEarDivZQjS43Axo+OKR+KehaR0muq5t9mkdn72Ok8yQ5d0TRbtVnHfaqWSbmavRv1wD6oGz7JFEWuoL0O48+U9BNiSGe1GN+2MwWhBYlx9CUTKrRinvA5WndgDcLS4cCHnB9PHmAKzgeSr6MLK8FOoP91F4/CDAQHiilSgggi09CriltjTCupk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6DQFXeHjqW+2tsb+xhYIZQOOEeLrYslZi5hX5XnJp8=;
 b=mUN6zCsRWkRREY59cQVC3W/CqSJ++q2f4sMFZYQb0uFYt8CujFmwI+ILx0s1NdaQFr6/Tm1yMm8muqJOizwcftXyX6OY2rdFNJSDBEWmASxTuPI4H0hO4tk1rVfukIIUHHN4I6D55FQeghNWkNZjHZOoaGVOtqZeaF7f26ahBm7JN+FiiUILyBks7Z6nnCQ8uxXO92ssjD1XB2GwY2mB2iIroR102yhvJ0R6QDW0hsiil/nmy4ZPptnLZrorwdd/62VnLp0OM87HZkquKzKdUim90AFEyetf7p4jOfln/+ipzyYCqwOVTcRS/8SNo1xdzh6OQoCT2dWA5UOAC8pvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6DQFXeHjqW+2tsb+xhYIZQOOEeLrYslZi5hX5XnJp8=;
 b=ZAA7ryymeUWMFp1h6mwKqQPunBZR+v90oNN1yXNU2C8sTnLMMRLk3cXRVtWa9oS6UyCVXtOVr4l/Sp+fKKGnd1Ntu0NCJKogHr7IVwn5xES90XiSX8XhUKJJPVWbv1p5ttQPIda8looI6H1EdoTa7VwM0v/kfE0IzggVKgmJBS4=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by BL3PR10MB6092.namprd10.prod.outlook.com (2603:10b6:208:3b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:53:22 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::15) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 15:53:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 15:53:22 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 09:53:10 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 09:53:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 09:53:10 -0600
Received: from [128.247.81.105] (hpz2.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4FrA9e2446630;
	Wed, 4 Nov 2026 09:53:10 -0600
Message-ID: <bbe7c601-88df-4162-83bc-047b810430a9@ti.com>
Date: Wed, 4 Nov 2026 09:53:10 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: ti-sysc: Don't reserve the system timers on AM33xx
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
        Aaro Koskinen
	<aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien Panis
	<jpanis@baylibre.com>,
        "Francis, Sebin" <sebin.francis@ti.com>, <stable@vger.kernel.org>
References: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BL3PR10MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b135ab-9d3d-41f0-40a7-08df3a8bc162
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|261022105027099003|56012099006|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261009223027099003|260925022911599003|261022075727099003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	kMADOsmJuZBp/3mdQJUkUAa0vnqlle3vt8e1FCSfaFjnroQslnU9jhlA6cYic/oEMSGaakOVxH1A0NWRAvjDma4/rqei5QT4Tb0bY+EzHuEadvYet+K+hyIprpqgayNl31DgeIjGs6TfOcRlgRrLL4ZPQya2s2mgsBVCkKwlwect3HoRQuqrxPAahqDiu8jpmH9Uzvxlug8YF+JOCsgnmF71Oqpj9kiiNcR3ib8Xlvd+cy14BLp6DqMMSf74Da5Avzaz2XezaE8nU86AvGrvwN+bGTPZSAv9IxV4ql5TA2kVGwd6PNfJ5Jnr8lNwWghPxDdrIXk7jtO42g1P1FoJk0ti2iq4/gf+aqYBTFuKJNjD9++GB5F+TAetr0KAqni/yUpwWS1T1CzhuExTMxfoXA6lyQG18BeyZfVxsIa0VB07jKhVCF7B6gQmfou8Tqhaf+Aeduhj/Ql3cDUGIg95gTKzrkg6115QWnDKlucGY5FhneIf3KDhFl6UEJf60pqG8ECiLL1O5r07EYN9T8ARnZJHNftGIYiTt5V2cMk4DHSXQ+KoCuErbVbDFa/kJVPBrl2oBN15Q4hGdKQ4bCNCmzmHYi4sacizDf55CFFjvUtJa1ZpSXU3W7q6sNiww30Ynrx8zskiq+h++lOl4yWTepVIdq0FI3N6Pk32hayZK/RUjATjEmYk4vSynHF6xOPqMba+8pxEojHrheAAZBmS6g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(261022105027099003)(56012099006)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261009223027099003)(260925022911599003)(261022075727099003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	syrKNkQvAftt9NNIkp9GL011COcPmk3L7n6aujsjPuyY3kI0QppV2gyJJZBk0ETSb6G+x2w+QrkUAKUgkUvMd84gdHaec2cLgBN/qkWB+JT+6Tmw8SbQarcMGSPp8c4nW7IkuRE9cnRjvfRFn6AlVwHZHd/hMyM/269CRfK2dze0KmqIOxx2lhrb7HEblQ7VnNjTG2zph3RFcGzf/FxJmQq2OIHbHDxh+3KzeAFZZkUKE82cZseynYhnk+Sln8TN2rHL7MbPZ7nlxS4M0nbz9RZhHMo3BjcIJ81VdtNuGZRJR4lDwcHp0CD+yLRYU9Q0bnmYCHj8QAosrWURfodQF5W2ljg9R7bdloYRzPV2KcgZmeMklw0nMmvSRiI9bU0SY4ZdBMTiQK7/b4rTOq0v9MF2cqwtjtfA2LZrKuVMQmlX88EQG6oqFAc8ZpFVLc6x
X-Exchange-RoutingPolicyChecked:
	h9Wd+xZYiTVpfcYvroBZL52l9aWmBNiR11WQvXOBcsIMPtVRv6HY1rdnow2GvI88Q9o7QzVchjanmvh7lkqIlYTt73lG7sPS2KLxVf0PMo/yNm7odOcli0Bqt6Qwp5xVwAcex4T77L4pjxvm/0ml8WDink8CQzSDs5P5w2M3XJn3y5P/OoN7RSHHxL2GO8698KJ4uHYG34VLemILSe6zTfaM+8OhqZAy9VBrkt60cEWPgaJY8oODqNp9dJh8E2iIFgwfbBbWe1KcRHu8DeffQPD17uHAd9iAkQF0Ti4OiTkXsH+xl2zJ31t7VswGyQRKOfrDObZRkP5O4POuvQrbIQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:53:22.8559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b135ab-9d3d-41f0-40a7-08df3a8bc162
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6092
X-Authority-Analysis: v=2.4 cv=DMsacCNb c=1 sm=1 tr=0 ts=6aeb54f4 cx=c_pps
 a=Ess5LnjAiV6zB+80YbJDlg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=OljndnyuHCFsZmmXbKsA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: zSz6VfjKcOU4O2C5p_zkeWqprQcj73aL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfXzBQ0BVHcr3M4
 WMiltMSDY57t5Niaa6beSME/t/XQcane+Y0RVXJqzLtqN2GAXJ8/TOt7QPYP+nHt+jHAJ4hWyOd
 6dKXXGxNQU+oH3aqinenZF06dD5OZooR0bC8/395FiSdc8VlNUeohy04hH3dZW3jKiXTUwfB/+J
 BZUP3W/tu2iSTZiTaq5D8Jm67mGcip1BvtNDhagFYl+olCt9huYPi3aNSvjcjywVRFtwF6MrmW0
 ZBpPfJPEQPz+2k/GFP3DcMWmrSejwBlF2S3MgOBziHfvWw7JBjD4bidl4V74mfCbD2mBbfEOt65
 OThQ1Dfm6v01W0RL8taKsg9+4hApCJBazWoHo07XXoZvyyfg/jGpctN3H/1PGfA9WnIBDyHcxIp
 A3AHFz1BsfSHOniSkc8RlG6/0pf9v0RstIFYIDywS6/mhNl12Bz1mbn9g5r5bg0MJM7847m7SOg
 GbPmQOf607zyIuYEzZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX4PZ5ef1Imr6+
 6jG/bAGub0Ot2hJIXNsW/iZjwzQQnVjd0t1jckuQxVBFy+N8DkLh3dVosNH2BDEaNHlwS5OMttN
 2ogSp1m5MQh7ZZMNfrmyMAfIDdm5zag=
X-Proofpoint-ORIG-GUID: zSz6VfjKcOU4O2C5p_zkeWqprQcj73aL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040063

Hi Markus

On 11/3/26 7:24 AM, Markus Schneider-Pargmann (TI) wrote:
> Commit
>      3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
> introduced handling of am33 SoC timers that are already active as
> reserved. During probe this means the clocks are enabled and a reference
> is kept.
> 
> On AM33xx deep sleep is entered by the PM coprocessor which
> requires the PER power domain to be idle. The system timer driver
> disables the clock during suspend but the additional reference held by
> ti-sysc leads to the PER power domain not being idle:
> 
>      pm33xx pm33xx: PM: Could not transition all powerdomains to target state
> 
> The reserved status is only needed where the
> gpt12 system timer must be kept from idling, see commit
>      3ff340e24c9d ("bus: ti-sysc: Fix gpt12 system timer issue with reserved status")
> 
> The timer configuration in the devicetree is the same on all SoCs, so
> there is no reason to reserve the timers on AM33xx.
> 
> Return -ENODEV for the system timers on all other SoCs. Like -EBUSY it
> stops the probe but the driver core doesn't report it as failure.
> 
> Fixes: 3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Thanks for the patch, tested on various AM3* boards.

Tested-by: Judith Mendez <jm@ti.com>

> ---
>   drivers/bus/ti-sysc.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index e118b900c9ac..922a90d4c5a3 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -48,7 +48,6 @@ enum sysc_soc {
>   	SOC_UNKNOWN,
>   	SOC_2420,
>   	SOC_2430,
> -	SOC_AM33,
>   	SOC_3430,
>   	SOC_AM35,
>   	SOC_3630,
> @@ -2917,7 +2916,6 @@ static void ti_sysc_idle(struct work_struct *work)
>   static const struct soc_device_attribute sysc_soc_match[] = {
>   	SOC_FLAG("OMAP242*", SOC_2420),
>   	SOC_FLAG("OMAP243*", SOC_2430),
> -	SOC_FLAG("AM33*", SOC_AM33),
>   	SOC_FLAG("AM35*", SOC_AM35),
>   	SOC_FLAG("OMAP3[45]*", SOC_3430),
>   	SOC_FLAG("OMAP3[67]*", SOC_3630),
> @@ -3124,13 +3122,12 @@ static int sysc_check_active_timer(struct sysc *ddata)
>   	 * A to B4 at some point.
>   	 */
>   	switch (sysc_soc->soc) {
> -	case SOC_AM33:
>   	case SOC_3430:
>   	case SOC_AM35:
>   		error = -ENXIO;
>   		break;
>   	default:
> -		error = -EBUSY;
> +		error = -ENODEV;
>   	}
>   
>   	if ((ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261030-v7-3-topic-am335lpm-ti-sysc-13f0219c9d67
> 
> Best regards,
> --
> Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> 

