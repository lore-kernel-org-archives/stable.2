Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794583249;
	b=1xtFdHFIgPMtKlxx7sl+6TUBfECiFqUziGDkQwVjGBU4qeTS8CXuzh4Sttz+RQOYGtzL
	 jKU7dRgXk4dU1h5rOi6wRO2cE7+C+jOE74AU73axRdSfBVxn/4TJXBUZl8RiEnqC96ArG
	 XyU0iGu1l/806rkvPuayCJE272dFOPBYgCKq7LG0jyOzDz3bo0pQL6ZmT5UDu+mlOC+fD
	 w/kvU9xqcQDDOKlCLQpd4gegnKLzKmcen/XzIQAtx+cMOl9XTp6fQM5t4VG2pqLuOnvpt
	 H+WklIPfcK6pt/g4YL7z4K1O6BPD4d2npZ86Jl5DTVLz98w7q9+emAnP3oys6Ma3xeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583249;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:STX-Internal-Secure-Mailhost:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
	bh=P31GI8Rd9YwKPSH9MBGWs7JI7KY4jcaLaVawrdE5J2E=;
	b=lWENCzz5dPagOcYNK3DasqqCHl0rsxRxfV0z5WVgq1RUaAqS1nG2uE8Wqiw3YBTWjWM/
	 vJeedFmVqzka7xpO/D1O/ZsDO9jIglpvP3j5XrORCNswU1td9isF7hKCY4xMg6dFw2j0x
	 kmUHAea75wJBZB1r6RUcWOV5eM2MoaHhnJtpIUO/H5G1Svfid+VIPSNcMLDQs8c6yFeuY
	 8sOFqNH/10uOBI9lrkybYMcpRCpM2noaBrWw/aJMzQZfSoNHFA9ulicH5S2TBMn94VJqa
	 kK3GEdGEaq4Pt9/cGMRJaZ8WL+JId+IAvx+ab/YChcjcPpbcK3bB3XT4J1zdW02Z1zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seagate.com;
	spf=pass smtp.mailfrom=seagate.com;
	dkim=pass header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=stxiport header.b=Zq2wzmNY;
	dkim=pass header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=selector1 header.b=g+dfRP8h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.94
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937DD606A331;
	Fri, 13 Nov 2026 15:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937DD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=stxiport header.b=Zq2wzmNY;
	dkim=pass (1024-bit key, unprotected) header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=selector1 header.b=g+dfRP8h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1794583248; x=1826119248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P31GI8Rd9YwKPSH9MBGWs7JI7KY4jcaLaVawrdE5J2E=;
  b=Zq2wzmNYIMv61jRnINnaqsjJAFe1aFn5WYWjdNUn7XnF2kwUWTeqCjM3
   TSeFDSR2GwMcmDUkrRV3bXRGEoU7C52pF4aYdJXQwGM18pUqc4uqDw2Wi
   1RGeMgBI2LmqyRL8V3cFsG8c12NdDjIynb9T//ckCFimE/FU5+z3RGQvg
   Q=;
X-CSE-ConnectionGUID: nxsJe5S1Qd6oZYVlHjPoiA==
X-CSE-MsgGUID: c4SaKgCzT6amqlQ6AmPXEg==
Received: from mail-ch4pr07cu00100.outbound.protection.outlook.com (HELO CH4PR07CU001.outbound.protection.outlook.com) ([40.93.20.96])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2026 07:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoz2VrSb4CeXmWhePplhFRNP63h30R8TCVZtX085x3WgUYSsn/1fBY5hWxZHxCZn63ioLMUEPJa7+vFoRir/zTu5JmhPnheBW9vz8/P3IOs/ttAh0V9n5vB4RYnG7KCtWzvM3Nbg21kWVFamQrxfhmLWZ5vwbmvLRZ/sigiL4jaDeATmken5X0gFrQksloaHZfI7w87yC7NQBKr5eu595olYWG1oM/VEaTLKT1PUu4/BLGGz0TLc7+rW6XAtIWW/JHE8SJPB7gO8DKNBHjH0Q64Fr6HLwhZMOHSvaNknnaxnaPdmTMtDAW9kcLXAVAUwAkeg9zJxQiAHGYx2FNA//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P31GI8Rd9YwKPSH9MBGWs7JI7KY4jcaLaVawrdE5J2E=;
 b=B08AInWQIgohAQP1sjfPlk8nT1z60i+5oSOLDgHhQ295YmdpLWJhBP+Y0MHB6pG8aLgSPttn8bAADr7Q7/rrjEjwW3P0gUv5VKhBfEFFI0vuFBqfKxmX1pRS4oYjy1I7H5fCWtJ2Clo6jnUgKiLNI9UNbJr03qh7yYabEjmHVrPWbBBnPDYfDhS6m2uYX5f1+EXMq44Qv62y/IetA3SIk9Vb2hUg5ZIR9vrBj+OmkmcZl+lpsJGVcHvB/JewHVTt28/MuQqMWyPFGf+e/mWYjxrGVNdOitGlWq4KyWHboSZuY/0ARd6QSWCo1y8AJzvbBcgK7iNKgmhB6EKZuPEY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.52) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P31GI8Rd9YwKPSH9MBGWs7JI7KY4jcaLaVawrdE5J2E=;
 b=g+dfRP8h4Qap7Ui5/ZLgydAl6S0sFND6mtkhXzzsSLCrUbhiEGZkU4Yot8qquwSvpqHY+8Rkb38WnpkI0SVKAAnYi1QFNksJB47GAg9L63AIl4hTMncfjjOiRnJDZJcaPilMVTm8daFVf2A94Zd2Efemn23Gr4X7n0UyNNxltTQ=
Received: from SJ0PR13CA0126.namprd13.prod.outlook.com (2603:10b6:a03:2c6::11)
 by BY1PR20MB7197.namprd20.prod.outlook.com (2603:10b6:a03:4b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 15:19:23 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::98) by SJ0PR13CA0126.outlook.office365.com
 (2603:10b6:a03:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Fri, 13
 Nov 2026 15:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.52) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa001.seagate.com (134.204.222.52) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 15:19:22 +0000
X-CSE-ConnectionGUID: hlOSTrVnSlKoW3gySTgwKQ==
X-CSE-MsgGUID: O+Os3WZMTYK5Dc4BsWeXbQ==
Received: from lcopiesaa01a.seagate.com ([10.230.120.56])
  by lcopzesaa001.seagate.com with ESMTP; 13 Nov 2026 07:21:58 -0800
X-CSE-ConnectionGUID: DJHip6J7Qpu3wGsjRngKcQ==
X-CSE-MsgGUID: A+tcctkNQMWBFZch0iefng==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="2156235"
STX-Internal-Secure-Mailhost: TRUE
Received: from nick-desk-ubuntu24.colo.seagate.com ([10.230.88.152])
  by lcopiesaa01a.seagate.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:19:21 -0800
From: Nick Spooner <nicholas.spooner@seagate.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Nick Spooner <nicholas.spooner@seagate.com>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: fix REQUESTED MAX LBA field for REMOVE ELEMENT AND TRUNCATE
Date: Fri, 13 Nov 2026 08:19:29 -0700
Message-ID: <20261113151929.9586-1-nicholas.spooner@seagate.com>
X-Mailer: git-send-email 2.56.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|BY1PR20MB7197:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 921131b0-b345-4afe-09df-08df41997f40
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|261009223027099003|56012099006|11063799006|261021121427099003|261021135927099003|261102123227099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LLEFE2d2m7smn8dRuOnRqDXaCFG5eH0lOFgAboE8yfHkWO5OJARvdCsk2zIz7Oy+8GbP/97uqQCdEZOHOGty1BZFtBBQ4IpTxmARGSUeIpAjCqxcyINReGpmWiY7NJapVlP7pCt8SmHdn41aXBJoKZfOxvNeDa2teXBDsst+AflHiljdMGGfxKX27+fGwRPXkruhtROqnZ6HGS/svTVav7mx318x3AMfTioh/DOZ1AWnPinLQX7J9Pu6LPU2w21j7TSHjC7iowGuDujSpUyPVfaGs7eRD3l4tApDfBkRtS8J7UHATfH5PnlMeoCKuHHX6ru34wreZN2aoPjVqm6taEl7o13BKSm0qqWqT8yrQ0fjcpMmdN04pMUC/vwFmfzM/mUd89gR2M0lHzIv0+yV/bAia1KXNV0TTekYwV3e2Lg/G0a+nffaX8st72e4TgsV1jxz3LlIdzSVVJVtZXLWOswp8i+kI0E0cdL3B5UjaZpdc3sWaQQ51xQGq8m3ebEsGpAD4YLH91/Um5MGVyGZLv3Y421rgnKSmuXY+mL5VtFyr2/5+CxMEtVhCTOZKJ3Pk5hGkObiLfsB/6LigbgBJATssTuxwrQwzcViq2wODBppD0LZJ8X03Zfoo0lWnlSMlnOjagFr6QFsiUAJvZMilIxWyKBT4RtgwbzHPG+lWHlPuNhZcDgdNw5JtgOSkQdSZeXb7aH6al/cP0UOeji6Gw==
X-Forefront-Antispam-Report:
	CIP:134.204.222.52;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa001.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(261009223027099003)(56012099006)(11063799006)(261021121427099003)(261021135927099003)(261102123227099003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1+PZqafigm7Thb7JAoKf5PwyzGniGf725DgFMIooZuE6kiOc3xtpKrvevGe17KTFXG9pVjFh/gxpEC72mPLIxCwgzbQkh0fsJv8dND4lSGv7jfiF8n5G9/HygAvtXar4QIwh9z5tmNpKl4StjVaKaxC/t3YOR+5Jh2j9ShRQsG2L2UhjV6NlAHh4/EurWESpWfWEcuPE2yC9yFl1/IZaa75hi3lUMmIrFB2a0FZBZTk6PPkz9OV2M0znaE+e6X/WyYbQB4KyE4IZrIpa9GciCGCPAbhzcErNmeGossMV9s6AAUFx9IkES4Kg1uMM5rmIz4UrXyaCGMETUoImZew2GT2Dgx2zW0Qe5uG0Ma52+RGqHReTGDzEWVXwA+mls6syzh1wbbWK4qJXhEtSQibLCwGf8zeMfHqMTI1NiUZTa3UNI+jE0LNEyRrs8I/l1iNr
X-Exchange-RoutingPolicyChecked:
	WuZp2+LqB1XaFL1suU6bBtukJRb4zO9RZ1sB770C99TN/VO/zq3Po2d4Vu3cclepMyVixxp7uJedWMv23hvXf5aWCeJ06De1LhHhNecETYPJwMfvkkBw1g/gvhTasGZazdNTW8hqYn2XCeZwwBbZvlRkY6XmyUDOJAo45lB/AxTFi4w0/eWtTAZFS+jFqfQ0PhXNQCohBN46UxQqqHYxOhawjn5TXopt4xbBGbB/XFxuL9JdQiOfn9K1LwLSMRGEAf2rPNeFQ0LOW1MC5RTcFuO+lXOiedH+wZDSQlXEVZxN6RWUUdP9QcQjY5JgQg8n7pHtHxyjvs5KC6mYcz2scA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ruibuuj5fxbIqYgW+veoG1JdoLMj5Fwzk0UK1oUbU7BKNP6KwerEhGTzX+cpaKprzZsLGr4kYgCKM3tZHu6g2hgfjl0hYTtVcgCochgj+SJuBwhkkX+2F8+h59q6jWu+xH6/Jv54OGF7G2+pls+d+0KUNlEiphBLDpTvBo9cHIS08yiiGirs1EXBXrgodwUcfGx/hLJdiaZ00R8kvEc6wx1eEKfnVBp8UPelnmfm1Xh6rS+4cxYzyUkYAOvqVB5ieC2k4j40FtuiTunimXlPTBpi/RbygkLAHjT2sBhgU7o563oHucL1v/PwmOD7Zd1iPFSuR6LKF21Nnzg5dW0LnNJtgy4O8In1OriI9MAWqeMA8xnJNB9f/yOvoelQdBKVjEbt5rt7YqfqPnxCuxkJdEHcYKoTz76hxtIcQrkqcqwK4rOV09BVfg+w5wdm5Nvd8Hm4G8toPagx8q3Aee2XUBKEgcKGc3b7SRFvjC9TfD0IRSmKKtqCOse6gwnfOWk9Ns6cAm3Ko7z7opoH8+ir0/bbf5e5VpnPgY8wvvz6OvR96LVnCiN/Iy3VkYVzbstkvD2R6zY2t3Y2a6v3r/CX+aV4o5r8egHtXPWUdBAkL4dxn81OYgni3IV2zrimwXT8
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:19:22.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921131b0-b345-4afe-09df-08df41997f40
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.52];Helo=[lcopzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7197

ata_scsi_remove_element_and_truncate_xlat() copies the REQUESTED CAPACITY
field, req_capacity, to REQUESTED MAX LBA for every block count except 1.

However, SAT-6 specifies that if REQUESTED CAPACITY is greater than one,
the REQUESTED MAX LBA shall be set to REQUESTED CAPACITY minus one, since
the max LBA = count - 1 (see SAT-6 rev2, 9.16.1, Table 74). For example, if
a capacity C > 1 is requested, the capacity ends up one block larger if the
drive can provide C + 1. If the drive can provide C but not C + 1, a
request that should be valid is instead rejected with INVALID FIELD IN CDB
(see ACS-5 rev10, 7.33.3.3).

Modify ata_scsi_remove_element_and_truncate_xlat() to decrement
req_capacity, except when equal to 1 or 0 (rejected if 1, let the device
choose if 0).

Tested by issuing sg_rem_rest_elem on a Seagate drive ST32000NM001F,
firmware db02 and checking the taskfile.

Fixes: db496721cb0d ("ata: libata-scsi: add support for the REMOVE ELEMENT AND TRUNCATE command")
Cc: stable@vger.kernel.org
Signed-off-by: Nick Spooner <nicholas.spooner@seagate.com>
---
Tested on libata/for-7.4-fixes by capturing the trace of what libata sends to the drive.

  sg_rem_rest_elem --remove --element=0x30 --capacity=<C> /dev/sda

  Unpatched, C=1000000:
    ata_qc_issue: ata_port=2 ata_dev=0 tag=12 proto=ATA_PROT_NODATA cmd=0x7c  tf=(7c/00:30:40:42:0f/00:00:00:00:00/40)

  Patched, C=1000000, 0, 2:
    ata_qc_issue: ata_port=2 ata_dev=0 tag=0 proto=ATA_PROT_NODATA cmd=0x7c  tf=(7c/00:30:3f:42:0f/00:00:00:00:00/40)
    ... tf=(7c/00:30:00:00:00/00:00:00:00:00/40)
    ... tf=(7c/00:30:01:00:00/00:00:00:00:00/40)

 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 87a57495d2e4..20ea1c997d56 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4991,6 +4991,9 @@ ata_scsi_remove_element_and_truncate_xlat(struct ata_queued_cmd *qc)
 		return 1;
 	}
 
+	if (req_capacity > 1)
+		req_capacity--;
+
 	id = get_unaligned_be32(&cdb[10]);
 
 	tf->protocol = ATA_PROT_NODATA;
-- 
2.56.0

