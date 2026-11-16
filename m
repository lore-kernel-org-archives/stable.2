Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847722;
	b=Gy4CrAQUte1jN3nolYUQ/su6I0XUWaaJ5Kaq6lWuLMRT13hYmyJlxXa9V81ocI775zqD
	 Bqpt4ewh8v7EN7n3OTRHdXWamfVZubB+8QrgXj6MgTMFbmCuCv5l2mgECinj5lnEPRg23
	 4k1buhr5WYme9NHR+W20I6iyL6gY2bYYR4CL7z0/CrHjQt+iS6fuqpqvw4SsOGZJc/bmN
	 sy+NFrZQrMhtGE+igYlGPwVgykl0l6MKsOu8lwaMcC7YekmkDC6kNnJIVglqczIEOL7w3
	 omZjxEcdeGCEFFoal0mtrnve+HY7yWCGusg67iC7zAHmvH+HzQRn1Y3Ybgk8ZzzXD7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847722;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:STX-Internal-Secure-Mailhost:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:STX-Hosted-IronPort-Oubound:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=u2WFDN+QVvViSTo0Dei9PGJ3KkJv3PAuLWZ2MDr0g00=;
	b=PPp8y928FG8TxZThwr4WY0i/zEl+T9NHJpo1ozWj6jmsuyNwUWNSOTR2g429jheJmaJ5
	 mQE0b2dX6FYeizDSUrE7E1Xf4MgCYLt4hhxJBU3CiT4FvgXZwvug9MfBorGvS4HmaSjk3
	 VTjgZbO32BGyVWLn1at7iwY5Hl/jIhtjj4WBFvGzeHibmIWzJflCe1vNSNdZI6ehnBoiY
	 D0i3vvq8KH1NYGzrkPtcKEhAklfb+id790lat1kTHgwwwXQZu/LApgNe8FtR2rQ/gwi2o
	 J+rnJMqPs0hACA4Z84kANWk16z2pR/HVFxz9zTSBxqxkv/WMluyudtcshixWFFCV+Iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seagate.com;
	spf=pass smtp.mailfrom=seagate.com;
	dkim=pass header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=stxiport header.b=DgPKi3l2;
	dkim=pass header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=selector1 header.b=M78zgUFe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.94
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99605606A323;
	Mon, 16 Nov 2026 16:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99605606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=stxiport header.b=DgPKi3l2;
	dkim=pass (1024-bit key, unprotected) header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=selector1 header.b=M78zgUFe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1794847721; x=1826383721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u2WFDN+QVvViSTo0Dei9PGJ3KkJv3PAuLWZ2MDr0g00=;
  b=DgPKi3l2SqTp6GPIyrq5mmjReX/WY50pLZeMTpcI479yK9eDWenYHZvY
   PC4h0m98f7ZQZoLwysN/4OMkPmOXsG0Ml5bKZ1GeZSWLAx52/QmDw9Tpn
   IlyE6Pmc8HODUAt8fc+MWl1qq2aiTu4him1oi+T9VAD3wMtZS10UVVvEV
   8=;
X-CSE-ConnectionGUID: 9X8k5BilTfWjT5oG2KRmXw==
X-CSE-MsgGUID: l6laOcZHR6uW3WXsRKvc5A==
Received: from mail-bl2pr08cu00101.outbound.protection.outlook.com (HELO BL2PR08CU001.outbound.protection.outlook.com) ([40.93.4.9])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Nov 2026 08:48:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzRsKyaHfaFFFUGqx9YD9pmGSybOk7PVHht632JXdTYxDYRtAaIfPipCaXUWwoeWWdlsij+NYPo3qwACe0gRXmuOCNwEeuazqrwKZwvy1OhP3R1wVb+r1wj/jG4bPmW+JAoV1HrtY/fGB2iRwEBSFECWYxkPm4UYijDbqi0K1LLYt9cSets5M5kzvgiPT4E+bfBJQY0tBXg1I4F7LW3I47/v/E5306HxiLNPH0ICZvB7S1quL8i5Bs6K3en6zRWVm2NIS3DtWVdsFGAhZUOJY/eFalZ/SieM43m6goR94D7pfLektN9TIDN/b5d0XeDTxEGUgRtFllkiuzI4tzPGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2WFDN+QVvViSTo0Dei9PGJ3KkJv3PAuLWZ2MDr0g00=;
 b=Q7MNy9NxNqKY01PIqLDo4x+VJ/UbTTlAP6uR2TgVVfm6K3jj/32REwckgMAXTR8Lg2dj3C97vI0VeEq//V0gU/M1EGJReO1Fb93hrvGR1e8zw8RIZZ8lRoKjhoKvooURfpJENpdo1OlViI5KsyJfiIA4CCon7ZaCTlSHqe4V5tUSaB5vZBSLn5aZJEnj2GCVljEIR8/iupZSw/7YUweWB2kkSsM9DS16j0xaCECyxR2OUMbnYOXL9k63Ffhx5M3ApTjxrMTuK2HGKZQwUGSjXtgJoTWYPNRWGLs0lbd2V/nie4JVxGKAmiOMEJhHdsiGtOwz2ZqZJQqa41ixzFcwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.52) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2WFDN+QVvViSTo0Dei9PGJ3KkJv3PAuLWZ2MDr0g00=;
 b=M78zgUFePgYEFHpl0zhDHesYP3+XYts3NkeMaT1nlq7Mc5QHG7fuWQYOxOnppUeDBbEvObOzIG5dX/sJRFsL3XwrOB5TJqlH05zV2qJsDt6Bo0ps0LoVfQx2pNNXVPDOzAoWsvJ6D5qHSd14r9MA/qKz7LLksbATQLuumBtVUwA=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by SA1PR20MB5431.namprd20.prod.outlook.com (2603:10b6:806:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:47:30 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::a9) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Mon, 16
 Nov 2026 16:47:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 134.204.222.52) smtp.mailfrom=seagate.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa001.seagate.com (134.204.222.52) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:47:29 +0000
X-CSE-ConnectionGUID: ObNWyh26SwO67lHSOh1sRw==
X-CSE-MsgGUID: 6Ur8E1MHRG+DLBKVscowOA==
Received: from lcopiesaa01a.seagate.com ([10.230.120.56])
  by lcopzesaa001.seagate.com with ESMTP; 16 Nov 2026 08:50:05 -0800
X-CSE-ConnectionGUID: OkYVFcS/SWCJWa4abE3ecw==
X-CSE-MsgGUID: sra6OglAQGWIwFtCvC95iw==
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="2178875"
STX-Internal-Secure-Mailhost: TRUE
Received: from nick-desk-ubuntu24.colo.seagate.com ([10.230.88.152])
  by lcopiesaa01a.seagate.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:47:28 -0800
From: Nick Spooner <nicholas.spooner@seagate.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linux-ide@vger.kernel.org,
	stable@vger.kernel.org,
	hare@kernel.org,
	mkp@kernel.org
Subject: Re: [PATCH] ata: libata-scsi: fix REQUESTED MAX LBA field for REMOVE ELEMENT AND TRUNCATE
Date: Mon, 16 Nov 2026 09:47:09 -0700
Message-ID: <20261116164709.25064-1-nicholas.spooner@seagate.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <f72e653e-2cef-4920-89c3-f32ebc68de95@kernel.org>
References: <f72e653e-2cef-4920-89c3-f32ebc68de95@kernel.org>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR20MB5431:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3583c481-5d98-4acf-a020-08df44014dda
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	zpv/glOYVlzbu2MmmVeCnQ/0AC/P4xxLniVHCE8+yaDX5aEY5cbjKCkSQ+jmw0YsP+cH/K189vMz7Wf23DdWijMK0+1AmcJgsbh3iwpngL1anafRnLT4kB8jxV6/yJGOQj53qDEHQJzpVs9Mtu28QDpIf78Lf03Qtyfuwi8hwTXSuwMLBKGNQqocaWVLIDRqOnydc+W+qg5M3B96O5WJiPMBMExDyGtt+MmV+QUq6uvjjcO6f5yUnRaWxjtZE6bQwMopdB4+/KV4lUCedfHfYJwCLL+hjP/Z4CA8uAowA/3mlDj7Te9tziSiB7A0y1v5aMM/k2gGx9/BvKE0g4ah9IHw1vRnytDYU9c4wETjwf4WYxalrXZucyY1J+UsTnj4Zw6wX9NjetWNuNR/YFzmUDNl/sC4IDk7bVabsYD4oLc5IRecxYzPblNag+htbkyMgVfEbe8a4Ie9cUVhrNWZkytgCu+4MOIaSJ5rnM98YDPkI2RdFfEratJHsVQUIJNZdr9bF0omEPWYo5GZ9h9HDIZUKiopsAfM9PgDKinczXSxE2OkKQmWhp+VxAKCeGu9vZIfJT1GQxFNHF5a+Bxv76EyMlolXNodergPqJiICRQYm1qQp/RJkTSMj6Ka/kq70n04pQQgxCApCcRv5fJxQDDS9B7TwupKqssd+in3ZHMHLXtJ0edOZgQac/QM+LAD7q/6G00RT7Qis32cTSRl7A==
X-Forefront-Antispam-Report:
	CIP:134.204.222.52;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa001.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cd36gkCN+Tjddda9VGCmXAafpDG7E7bCq2yYAZI6WIh9Dq2LfxvmHa37AmPfcLifSfP/O2ufYn882KrzmTCaLDsHAJXvpD549x90kT/9oDaceanQhLDJKDvuMPEn87lvBL3NzSZchTNEkWepdVhU2Ujkn26BjTQghmo9mtcZagxX/lEC5oPYMAsV3H+is2UyVTWxZWfy4Gt+xRjIpa1nxDamZpF6q+OtrhN5+mXJduRx/qfZFzvp1iWiPsSN23s2XX4lajIXXVYDWBN05GLeV3PpwaHzAL99u4o0uiJPu/DSYHoMd+iPOK3ndSHeECId++uHxHx5XpWxDGIT/EWDxveMconGpOkdJ1VCszQsV65RyqSXcdWiWshlNb32/bGpnjgt+5dPbVEBXZhkzDZxLwjK4kXy1bIdSTQ4Y6JnvaZzfvUncp09dsl9hkY6IMa6
X-Exchange-RoutingPolicyChecked:
	S0JsaRfL9SbzNac9zJI7u4KEeRzjaORYf2RnHK4baOdHJ7tcHz146QIVs+fVMyHMvGJJO6tHpbrCVqSBVRmlSfkNEpoNPuwS/UtZE90ZpF/tHlJmkHti8KtVXkvBaYA4FSvNmPum+1nR+5iUm32GA2RleVCXblh8NxZU2osiID29C4xRPSvei6/8IEH27hqD3fug9bIu7k90M1KzHp79CkyfY7x8jjQQ2GsIJ8I45qDDdCCpid2k/RXIQmu7eqfdgTTbKYVUXDgZ8x+3yB/B1tOeeSUgN9eTJXugiYKohejuyu+f/iDjwMMgIww/gRoM9heiWVIJuMUvA3ksn04NXQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IQyK4dRNNIskrXh/+DItdj+rwlcPWkL9u4BfCEnXQ9mjcAr077vTlM2ZH66ZpLQ3XPutdTdYIKy9hzHnX3AMj8tqQp5d8EcWrPjtlnAgxzyxwNvP+BAQjvNAUKnDucEvlsHD0zRikxAkbvGeogTFi0IftCGqd5G0utp8ppC55zgFKwvHQfLLj3lnQg+39OQyfj5yndkCP6Pb/bJm+LWnO9HPHUi0KmUWZpeQROq4xMKXmW/Gxfm4KzH/j5k69OZ+2DA8Z6MjrzTZHIFD7RFHSrpGMPp9SarPAU8bjBMNy7L8vphfP/zP17YBnTnnHzEaZIkifNjde/a8QlKbchojB3HZQYPlTLjfVygsXKyPFZgXTil2lEGcLwZ5pHy3nxJaLvzBEwSFz9G3IgktI467B73oCOJpu/vGG/6+3nKq720pVQWijm3DNTYYODoiW96RThEG6JLQmq26h05eV2IzmFAW2aPdM/3HyHBFbEQwwP3CT0n7MXh06VchQzLzi1ixoxy96GyXj56d68SssHQ/wB3cGvLc9eJawvhXoIwls964rTJhUC4QgImGG/lUyd/4sOpXqI9XwmoJHmE2wlVbGBfh6BDQDs5ZOdVyneN9mOE3quvMEAtbk/d/gHRlnolA
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:47:29.7920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3583c481-5d98-4acf-a020-08df44014dda
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.52];Helo=[lcopzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5431

On 11/15/26 01:58 UTC, Damien Le Moal wrote:
> So we should not silently ignore the 1 case and fail it.
> Can you send a v2 with that failure added?

The 1 case should already fail. The check was in the existing code just
above where I patched, but the diff context cut it off:

	req_capacity = get_unaligned_be64(&cdb[2]);
	if (req_capacity == 1) {
		ata_scsi_set_invalid_field(dev, scmd, 2, 0);
		return 1;
	}

	if (req_capacity > 1)
		req_capacity--;

I believe that should cover all three cases in SAT-6.
