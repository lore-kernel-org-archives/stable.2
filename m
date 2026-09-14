Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404823D6CC5;
	Mon, 14 Sep 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392194; cv=fail; b=dO/Q3PN0P4TJhNSEoZDC39TJMXh8zNVjJiz0iprmie3xQ67KoIPBOzecKDncJDZK4AHwp/e3yVmVx2HhGCed3zmnPPUZfnQexhl6gWQecHYgPij0y+UvamAoyNedYGZPOItr8pSGVH7XMphRVHgcyJNy3vxjs8opvI8IzWlguCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392194; c=relaxed/simple;
	bh=QlKH3ig2xEe2rHVud8RsDxv7DU2o7GK1kttwZI2ebhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eb4ih5EoRc9kPsu20tPPH/VHzcenFy2iPdotjfLIPkTMcMALRTpcaMcYW4FWEXsVWRzcpVqJQstS0Wmo5FlcEeq8H5ie401P0JBWPpipiNGvG5WOk0zOrSjmQnggEdRUtrZbxH02TBPeQ6r03Y7NeAAtO0ifgCKvbZcT9xLPo48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=dBgaGrFS; arc=fail smtp.client-ip=40.107.130.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="dBgaGrFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZQmXI4pGl3ZoNAzQJgcoha/izscX9L2TbTpTL5DlBw4YdRBzYn76E7qzUuBjhtKqc7sFBHxLhzJiMzcEcmslFlEVRnzJCvwBBSaCUTWpl99Y5tAbFsCqKaAJ1MvktEHkDgF2vv/R/eBX+H1FdcOc5ndQipWowaop1/MO1EeKwjCh509X8Wr+1J34zhUqYJ8yBxOTQCO90AyRvWbchu1yQKHVjZMS0zJ4bnQRVxm2f7dPyRUernDezMrUWdgrcR7VH8KWwWqyBbDVa+c01TVdjfu5dRagf/wzFzki91TJlpKLD8i39cpDa3gEGaumf/GYf55Dl59zHuYqrRMTCjoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjgWr7uZ1VzY+GJ+kPcCxeZzKHG6O5Ovw68puuG5eas=;
 b=V3H7dBfu1X8Xmn9sGF2t0qCpawAH6PDqo+LVIq6Xgx8zz4y3Tk7dTho5972bmRVWjtykqP6MNogYQ41QFOjIgFstDDqD/9cjR2nKqyz09mOdYmZoAZYp1B+PnkAJk6qwyQM1lf5Q8NgLrjfmND+0rhvHHGNsmYHDR87SP1L1YXJVw2bci21+9XniCJ3Bv81iULitTlF5Sg/+U7Kx/6TjWBt58CEBGXA9PLRyFBWaz+Dtyy2EcoVh1zIU1Cn2x9O0nD097t0xP6MHN836yatDDhUNB37kUvhC77wmICZIrCGkqQ+jaDx/AO2GgIr9dyOiOqOg6js5x5nNeY5+sndpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=animalcreek.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjgWr7uZ1VzY+GJ+kPcCxeZzKHG6O5Ovw68puuG5eas=;
 b=dBgaGrFSxaR1fdzZMcEL3HV+pepSUxFWUXt/6sdVUxvkzb3ixRbZ5qKplXnIOHWbiKL3/ofswj32I51uAaKEdQwUHZBmakZtlhNUlV0tcAMQDNe9520NtIyc6aswyu/GyU1YPR0k/h867nSAGde2Wu1QIuJ2OH0Cs9Czxih4rhA=
Received: from AM8P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::7)
 by DB9PR02MB9945.eurprd02.prod.outlook.com (2603:10a6:10:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:22:56 +0000
Received: from CPH1EPF00000522.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::24) by AM8P191CA0002.outlook.office365.com
 (2603:10a6:20b:21a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 CPH1EPF00000522.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:22:55 +0000
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 14 Sep
 2026 15:22:54 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 14 Sep 2026 15:22:54 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1x66e6-00AVQD-1x;
	Mon, 14 Sep 2026 15:22:54 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mhun512@gmail.com>, <mgreer@animalcreek.com>, <david@ixit.cz>
CC: <linux-wireless@vger.kernel.org>, <oe-linux-nfc@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<ae878000@gmail.com>, Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: Re: [PATCH] nfc: trf7970a: power down on startup RX gain failure
Date: Mon, 14 Sep 2026 15:22:51 +0200
Message-ID: <20260914132251.2503507-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260913042625.31296-1-mhun512@gmail.com>
References: <20260913042625.31296-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000522:EE_|DB9PR02MB9945:EE_
X-MS-Office365-Filtering-Correlation-Id: 80413bf5-c8e9-4917-ab89-08df126349c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8hu6AzDRWMj4SuY1gunJcr59oY8U8ghyHPHcQ7mBPyIklEatP/PwN5gq13jDy24vxRRqmkLvZ/DTdzk0Fu1mOZtACPfB9V+H95vMkmIVVxgowdGxOuFy0vdelSSAgnpJOc5+Btt/c//ouq+WVr1MFhwg3ZJKsEiIYB4eNHjdwzbKHL8egv/zvz0kLEYrLZa9ljP6vdkT1Mue+/DioX2pQUgoqVCenr1daAeZLwgdS9I7lxJkHjroYFNBSSqSxjcs80ptsM4H5Ru3ARK7bh7b3gxLUXWWz42WIEWzqf8Zg4SZljaovPW2ozZApvAh6SCxxOGP25jUB2mJMSJ5ZYuVjvs3FixDjNUF1vcXrCK4Fh1say3IPOcmgpIVLU27sEadbQj4hrlA8UXNzPGE6wCACiccuckgsXjivWdWke+ALczdU+rnHtMYwDRyOVdqac2qB1KCJxgRPZCLsUKzvwIGxsJ616IR4ahouHd82BAOwC+S8UxZkxZWOeHSRpMQB8zs4YrkoBb9whyOmCCwBldqOjGDwG5Prti55JVTddr7Cmw2kw/ImeZcDY5LDAyULzQRwYtrGaxji3Z1okJvV1S4lolvu83921/noQcBwYfLbtxU0jpxmLppJPVilIQnJfz9abL1ECk1Eu6pkdOu2+waeKyS4clkizrhVmwxfiJS7CI2z3A0p/wqRttJngcgL+KNFVObSihbHsRMnR5LbidwMg==
X-Forefront-Antispam-Report:
	CIP:109.94.150.189;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3oJXxaQkPgG6uyaDIkX+RzqrC8RTLszWOd+MgQLZ6OQlzq99+rZgyxP8EZCN8lZhoXmwrIOIzmdJ7D+iBrzsP7YAOsLZNaZWQvnuKDJ/uGD0nj2EQsu3878FmHc1WjaJIymY/fukIUIMs01erT/Lcnr3CsP74dUR873eT+LTF2CtIldYdNecNsZ16aT+IyNpFi71BnzgvDleUtHh+dQ/HMfgrA7DCeGeoeTArSgQQDRgyCGwcUQ5RC6ApKg+9HVZLEepaEb6O7lw/Mr965bxZwfscvpkkt/fMcThSdby+M6AOqRmJh/QYhY6MN6KS4YSIlNqL1RNSUrIu+LnyW5rL7U8wdAy2IMkxl0VA0VTfCx8wMJRbBkEgmjaLUANeHNwQp073E+0j95crnu8km1ZXKUXFLII/u0fJl1Gyft7pDmcUPbtgA/vkfCb1bwgf58K
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:22:55.7899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80413bf5-c8e9-4917-ab89-08df126349c1
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[109.94.150.189];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9945

> trf7970a_startup() powers up the device before applying the optional RX
> gain reduction. If the register read or write fails, it returns without
> undoing that power-up. Probe's unwind only drops the separate regulator
> references acquired by probe, leaving the additional VIN enable from
> startup unbalanced. The system resume caller also has no power-down on
> this error.
> 
> Call trf7970a_power_down() before returning the RX gain error to deassert
> the enable GPIOs, release the startup VIN reference and restore the
> powered-off state. Runtime PM has not been enabled yet, so the full
> shutdown helper is not appropriate here. Preserve the original SPI error.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.

Yes, we should do power_down here indeed.
Thanks!

Reviewed-by: Paul Geurts <paul.geurts@prodrive-technologies.com>

br,
Paul
