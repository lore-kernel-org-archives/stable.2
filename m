Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DF3C3F64;
	Tue, 22 Sep 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087258; cv=fail; b=PHrnmKiNwgcTRrMKMjycIYcxu8Zwt+yBOmqI7uYhNWkSjTEWUUk6+W+ZRACViujWIjtQ/1xDP42+TPueLG3Z0c7yTjSrVgunfokG+juLdTAcIwWJFAIfHSFAydSQ9nvoTTnQWDOpiWS1K8GGmnZj6S7ojtFyp8aaK4qinTpwoto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087258; c=relaxed/simple;
	bh=87kNzUQuNHebvtcodds2uJQLOYcLSixurCf9YZuXfrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/ejXUph11iXrPyVDbmCHW2SRyvEALYGZEpVwoTTE/UvDPZqIJbQOLprAqmto5YnVBe7VcVw+sj+dfNISBSSwbtRmfYIanhsyXJ+Li37fEL8dj/CEBrW+KobryKccQLdH7zhbuoYQhhPpVhsSo7V51CYPOUv1of/OyNx+OOIgB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NERde0CS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XfaeoZCH; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NERde0CS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XfaeoZCH"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPeQk2560601;
	Tue, 22 Sep 2026 09:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=7omeVbrx1NmcHJnQhDDB7/1HIIHGhSeB/l+mrQmiZ
	Fw=; b=NERde0CSgxqLcj8mQ2vN6ic+6hFy+JdaxVrjaKqfSf+XEnB1Bo8siZkW8
	6GlFqkt4xqaduoPB3p77p82c8hSahHAr6SHYVNRlAykeMX5C526FUyNLqVevgqGO
	9yJoXr/s6ECmj+bsaHjt4LvvX8crx0yNUZtGLII7hlVWL3AEfe3PWK5nKqnRShTv
	VFecedc0h8twSOWOsDNV5JRzWPG4z5GDptN/6pWNMdntiYK+1ikdJs8xgOdjCRJ9
	XovP21m3rOxcMoWtRTDwEGqfHMWvW/93uOWPYFFZ/F6oUfpgcixIYshC6TAIbMSv
	wQpmDzVjt/6IMalJZa3Lbn0oQwFmw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gugcsus9m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:27:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yROityvnxGmupLZdfdWJ+oQhwj8IKWd72uIcJhabF7UMez0+d271p7pNuaHdFyuhLfxOHNY35Ws/EfhhxcG1PBmt9bmUZCPw0z9jMpy8WPksf612PVTD7RKnCQMTpOul7YA+Orq0+lulyKZurmqEyQ0qVqtEW0oN0qKOmjldAItg8XANA7DozpM+DtP8CogVrcO/9PnYHJNljJsAtF2zteC8JQpVBwS1UU9I168/rxqWKJCNoFB5jRsKHmspG0uBccHJBpW9ksI0Xa2fhygAREVIO7ZPK0x6Q6+2Rcg9cQISqyYgtA8h7jIp149kNiFNkam8zxj5lqh1Q57IAhiH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7omeVbrx1NmcHJnQhDDB7/1HIIHGhSeB/l+mrQmiZFw=;
 b=BiJBWpQuXyjrRfuW6xt/edgb6vAO9+aLZPv1iLyd905CDxLQ8UOZoKlz3TxFisbrDOqDYfl1Fe0jayn/aQsCQdu/ZXFH+rYYVFf7g4uMUPwL88sGHhW4A+85OBWd604V1Ye3m23ecVgqtm1W/HnjFoknIwvVRjxkoCGTSLWRIgBKGjImqIJaaXHWe8bALV0Q/kZbV1sYAIQ62yCR5UeQb1TzAyUcks/7YKlDbWJG1MiUGsuM5SI8wwcUKbx1YveQh2SceXS0wRLkGrgq76VN5v12djs+eiMNntOWET5cGHxDpew5RPhlEN+YsM3whDJGIwGB5tjdMieUFUOyucvm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7omeVbrx1NmcHJnQhDDB7/1HIIHGhSeB/l+mrQmiZFw=;
 b=XfaeoZCHY9IArTJUaWxLLiAojVhpXzkecJ0gWVtgowN6IEQR8V45ijziU4Vm2xPTXY90F9XoO2K3/t6p1YPe37zhiKCxOkGHpmrqldlZo7WG3+ExTQh/P9gLzHagET7LPwZNUU/XchU7USA2CSc6FlexkNr7c+f5ngyUn07ixPk=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by LVTPR10MB997865.namprd10.prod.outlook.com (2603:10b6:408:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Tue, 22 Sep
 2026 14:27:20 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::7d) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 14:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 14:27:19 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 09:26:55 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 09:26:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 09:26:54 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68MEQskd131476;
	Tue, 22 Sep 2026 09:26:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62p5-verdin: build zinnia dtbs
Date: Tue, 22 Sep 2026 09:26:53 -0500
Message-ID: <179008715552.4044405.320502785549001210.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260914174651.6195-1-francesco@dolcini.it>
References: <20260914174651.6195-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|LVTPR10MB997865:EE_
X-MS-Office365-Filtering-Correlation-Id: 18de5f57-e036-49ba-4ae9-08df18b59c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	isJ7zQDtwBzO3YwBYusmed4JL/5WKBD6f/isYk2RMknLW67a0YdXv5FZ4EG1lOWLzGJqfDRKvzwTSvBwUT0M/MZy4HHA9gwky8/CuFjXzuKl5s8yOm6hIsLwgSJhFJ/Zp+8ClXnWu4qAHg4QhnFMDtt00gb/9tjFFyDmWNEQnV1QUkLOmj40DI4k1SxRC7DnOtA16qw2MMo506C8ZIj2yPVGEHyDgXaBgl+jPjqTU1LwARz0yu1N92atvoGTc/dbtS02QaHGaiDz1K3UXJuHiYyOyMW5qmPINCKKB6ISwfrbCly6g1EuaxoWyJJm8eEbo1BLwXpbbxto/VfJ8FAXVL4W4tqJICBJqzEgjB1CT9PLE/V5gAVOi+QFo1mj2z4f1czdw20GJ3/YmrXvif2qm4x6Iic9gKpjQFsHgEMCyXPbLgE56RF98LuX6R6RyjECNvrHTqGOogifyCSk0TJQ+cbt3q9WKhQ1uL9WjNSjegkjd5KT08WeRtSzZmFuxzn9DibvgcoPMteg9H2HPPNoJeb7JRaTNTFTk4oT9Q8LTNcJlaiRz1FY4xdiEB4CqtoTvCOXEiaN3euDDtTnuerH8aF95HUCnObArSxXr847RrYjVpX8vPX+qlpGZYYAkPgUsLUYn1ejKnvD37iccjEfaXoTHJxb5S3Q2hO73HiK+WKy826Gqx53t4kxTnSH48hR4joN5xhtOK3g7iecsUGyJw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Egar2T73EzGvg1HSx40l/IVsjGc2ysFvjt1lzofa4TrRJzU9RPOhH0TimZjFXKcctKqyh0DBBonjUx7cwhuv13B8EMs+iPUpYXegLUSgXZqF1b++F9Maclx9437JI4xQVBeGmW9gkZmuGvspFUpOA4tbR2zS5R4ksyDnLiBiY7+reDIfJEGIDxAxRTzYOEmd5+GDYRdXASzG/kDm1N4mabEoFeBNa8y+dZwGbMp8YWfN9Civ6psrREFphK97q7TfoPTD6TfZVYEcFD0HNnboktbyy0Egl4TXZ10xEMSjQvr14gkxtvm0wZ2iAVV434pR6N41fKlqcR27fggMbNsaibJEIR70DbUDefav05IwI5YF5Nnv5UPDBkBQjju4T2TNPCHqnNszqcwKiuoZ1v4w+fTjoMQzqk1Upo5H7zJAZhMJTaXEb6XS7L3KqoRZPA4C
X-Exchange-RoutingPolicyChecked:
	Tb3p8oki2LJmganCUnhIQV8F335+Jf5aaP1ko+FrgVwHW6qF7TK9MRCuZwJOlclcuC1aUsbkY8FDcl5GdPmS4+LNu2mRBo7KRBzw0liPNC0k1gyAoX+P77A5eOEFyveFvU8qCuVxuH+04i+x9e9oyRU9SrdMOIUHkY4R+Dln7/sb9sHzoqBbnmY4Lppq0IBRfv/d4yQcZxM6Qoo7EBxB+5VRMS4YMTslrgw4mydEt4b6Ews8eUaGerMAv9YWZwbIAd88mOYCtih/WD006mqiQNeJrjtS/2myNQxLUwOcBFJm00tHNBPxU9k4hlLAa8UJmUZ5oiVODDEqTw8x/CRKrQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:27:19.8221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18de5f57-e036-49ba-4ae9-08df18b59c3e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR10MB997865
X-Proofpoint-GUID: 2Sw4S7_FABmPaikhQZHxKTcExpG1lu7y
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab2904a cx=c_pps
 a=Ye3bCMmY4P27VUsoh7mwQQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=o1kACPpZKAZCWsj7fAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMCBTYWx0ZWRfX7VcXteMchtP9
 N70YafVrqYYmDSE/IcfdxKr7rmONwrfgrfqGSM2PTsPAiCePT4sbo+FrQmzoBXd3wkzq9cwOydh
 61iahADJFrQXyrZ+8QgM+OHQTCr7pOM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMCBTYWx0ZWRfX0e7+FHK4QzZ8
 Ar02NDjK7UAnyIrpBXjEnGzEON2AJdxaAhgvJ8/7STX4cIb1zGM+N7CD0T4a3UPg/raWLRvX1gX
 QmLvVhfURrz14PUlfUfcCFQ2EqPPfQGZPbGfb0xzq94DVyM46sLyNYfH3XAN5yJf89QoXpzrq4y
 RN66ckjQQEcGLKHwFZWTCm4MTI65vT+qYfns4NLDpd1zAtQevnyLgilzlFy68v0aXSdyozbPgjX
 SAKWjTXnXH79qSrLW8WmwgA/LMsuRZifPEE34Fmu1cZbxTKt2BvyNVRDCPnKo7Yj/4LrOOEX6A6
 kuxx4AGRmlX8OX3X8+LlXm2dpfD7AFm+2kX+etUrytrcy/ehoJT5alpZEBlLlTz+LnVPDdAcpnC
 B5mwrJJ+PI5cEOHDS540ia5xSDD7+xVQfrijLvlN7ZoEhZBDs7YutF0SORS3HnomDcyUA9n58GH
 zxLMp0kqlB0BejrSkCw==
X-Proofpoint-ORIG-GUID: 2Sw4S7_FABmPaikhQZHxKTcExpG1lu7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220210

Hi Francesco Dolcini,

On Mon, 14 Sep 2026 19:46:50 +0200, Francesco Dolcini wrote:
> Add the zinnia dtbs to the Makefile, they were forgotten when zinnia
> support was added and were therefore never built.

I have applied the following to branch ti-k3-dts-next on [1].

Sidenote: I will buy the argument to have fixes ;) .. but, if Greg or
Sascha or others complain, will need to drop.

Thank you!

[1/1] arm64: dts: ti: k3-am62p5-verdin: build zinnia dtbs
      commit: 237fda81c2b4984c2212f0d3f510405aad8b25db

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

