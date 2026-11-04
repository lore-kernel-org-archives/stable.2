Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793755842;
	b=qxQGv7aAdJ8aqHezu5AGvytcv/p81XPwRQa1tAIWVMomwYwYO5/Akq90au5F4pRfPi1t
	 sA6pbACv84kgCqk4bK6qdEoppkUGu5en3F5lvmnXr5GiadHHZ2Kz+L6X8YcEQitsfHcf5
	 2Vf9yg+1VPoqaxwxMHfL+FtNQLA/2QmaHu5ezSittb4uYXA6jxrEqJHbJ/UnZXTjGaroS
	 SVogpp/TcEmtpKMIGF+WI/xcglGIUqHVR1eZIfWQarCVIjczrSJYeeC3DuwofaWDwJOWW
	 vLg0yVjehCiTy6ptW+/c++bti577uTCswiamKLv6Vrupyt3QaOgg1oNjZYweuA+k6rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755842;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/4KkTE7RABblzwjhCGZMtm25YJM2v5qVGKmwGQAa0Hk=;
	b=iTbDpOJ1EGpB9tP6YWviYRmu4vrT9mzoaiRf7Bh2gLlF4PgnoUIF8qumNW+hs4sJ9zeg
	 C9KQiFA/HkX/pUSaO3sH9nNRb/RWxAjzg4Ow+dn9GG2ExPAY8w1VFaiWXmRIkLW64GpNw
	 tdGzSmBbCtkzELdJ0aUtDPmvtDTvbOpYuLHfZm3UZI46H9gdOawYLfm//tbsUJ8b++v0C
	 bSAH4O53SOc3GPkaSZf8BvISSPvk7moab1D9lBk94OldsS8HRILhB7Sy25dYFZZvm+8Zu
	 Bnk0MWugOdIM9wbjYf+NR2Af06HXYbOscCbRSPtsEDCltI+vj/3rpgmJdrJ8ElkIerA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L6hvkqOu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.40
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA04606A326;
	Wed,  4 Nov 2026 01:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA04606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L6hvkqOu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgJJvbUANbTAy4+TSZzaKbVBdTGvE/9DLfak1GD6iKQ6vx1tJwx3/NnYUT4tlHO8bgtu4lSBlRa/R97+HQ+/0b5fU1IzJ163g2bO8+/le+F7Alz6gCMVVWYKi7Ie0Go4PxYsmfupsO3y8cmjguwPpD/CbLkjEURas1C5DpgKUMqrQUVIpQPEmtoe6drV0B1O0Zk9vC2CmJPAycc3ZNUNj6/shxCSQnX5dXrS0AGpKDUgxSplDMz22qEop9yEvBS7bdQ6epao1PLVSLyc1PYf0x1cBmICzBuQ+S64uzXUUSx5c9VteyQHthjigpHHTWpFk+uAjClaUN+QKMX+TsdOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4KkTE7RABblzwjhCGZMtm25YJM2v5qVGKmwGQAa0Hk=;
 b=uvdp2/sXe7D4iirwyUcbNVuBam0bz+m9e1nfIBp4PePCTlhnIinMvQhnF+be+CywYaN2wtr3V/cdO9i/yWeflyPUtahABpFjilsCm8gtPSldC06l6YXaGkDNh6PufTVxYJ0W8KXzhexGNeiMl4D7a9VRQseo1cCV0vW4yY0iUbUzCzvXaIfZ2it6YUfElLQuSaVosNLeZfS/z5ywjYQn55QgoKKRQ+c1P2vz9JA7etNdWVGOblxZJ2CgFU8MX/Or/bK7CMq0Z4JrY5YsSFEnMefVOGuCgINpYCw3TJMMWB3LJqaH28n47Sorw2MychJoR+M0yZI+sJYn7krRmvU2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4KkTE7RABblzwjhCGZMtm25YJM2v5qVGKmwGQAa0Hk=;
 b=L6hvkqOujIbeHLqnz5TrQTkpnW23XDvGS3MmCgON+ckYs1LYVqB9MiXqZI6sI3pxwstXqp4B51Ac2h0J2B6CbKkQWHy2XpJhAUJeusCPqKOFhjCzxx226Hz3YfmFbFs3fXSLFLWdw5kq/4Exy7xkbw6QEWVXFB4qmQPNDIUm1ss=
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 01:30:35 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a2) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 01:30:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 01:30:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 19:30:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 19:30:34 -0600
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 3 Nov 2026 19:30:33 -0600
From: Jason Andryuk <jason.andryuk@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: <xen-devel@lists.xenproject.org>, Ariadne Conill <ariadne@ariadne.space>,
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>,
	Jason Andryuk <jason.andryuk@amd.com>, <stable@vger.kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Don't print reset reason in VMs
Date: Tue, 3 Nov 2026 20:30:25 -0500
Message-ID: <20261104013026.185392-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ef121e-7884-49d3-90fd-08df3a13394f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|260925022911599003|18002099003|260925021311599003|260925021911599003|261102123227099003|56012099006|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|5023799004|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	jswD/zhYDvaAX6T7oc88dlTbW69uUHve8rVrdA/duX9Rk8HzotcVPQ/2mztIehNEJykfecovpzNMNm66evQX2RqYDz5v70ekyhu0tvs7n77rhaK5b+uK+PSJci5PFL7x6K+5tD+abqAk+SVnP6FqKOCbkD1LsnQxO09R3/5nCnkb3gzISrJdhsMxNDFU71XalucSirXoYdVBcGWrIun4/PyUKbXhQRjtQ3PfJeGQ8pw5sAUIRpVY7hBh0q67WTCiyEPNQUf7ektlhIjrusKytZ0DvqbyiVJEYDszQ+A/0zK/Can112A8+vK/gFoiMt3+8gUwIJH6omYsRd1gIO+mhMFEkkef+BTZKseQAR8mJcqn6x42atOK5B4W6z4zIe31LY7s4JtMK6XlnvAQEpdpX6ducO7f+g9g/jrxfNY/ctuwgKO32NZNAfdfWxDaIaJllkOBjS+054yBauFRQ3cWQGuRDKuvVkqxVm5lAwXYblBFhbvW/NVfp3r4QbT1vfIC8pC4Hcgg8lIXQMq1ySQKmXwVhWsQXsFAcnXQBSUvq2/r68qH3kWOj/oOsUUob1wdaUBxaN3XDhmBov9Lce6q/M4NSqFyNVIBvGHiT5ybFyMLUmbJkTN1V3XsIMuASIcNMGFRxgr8zc9Cy0FEETAJiIO9ggH4jMMYgZ9Aui1IWRe1U06mfe1WtAqJWBO/xvYt3q56rsoklb2+w1GPig7K1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(260925022911599003)(18002099003)(260925021311599003)(260925021911599003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(5023799004)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OjS/bccuQx9CI8q/cnb9g62Faud4TSmnaxBwSmUzvSC1q/TMf1wZ4OkFAnyn72KPYCJHVArTRUm+RMzjqvgjkvyIpnuYMggmWPOhHB0JhVk6NwzpB/3zNGu2A9Ev/x6DF6JGUQRJ/VAiFrmXFu7UquRlE//OMbPGBlnP3Xox25x7rl6jLowngiIIyZnXq53zWUIZwOsKyTCuxHWz8JXzEsBfL63gGCNX6MYHvDcQO45MR31O0ppGlIhi+RDfLer6n3sZsfJ8vX9czrQXOoRd7lbJcbUMEoRVtBjkjrsMsqjkng77m5OKocDUzhqjQxkEVv9qck0XKJGcIgvMMnb4AO+1e9hwu977rk7jJwud3rlZAbM8XZvShvJHZgwkv2r2kU/tWYIE0lVP6SeemlVwVTJU5XvlZScZg+ea9VR/PoYpVDbL5pNhfHsL7PCMxWZ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 01:30:34.9625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ef121e-7884-49d3-90fd-08df3a13394f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600

print_s5_reset_status_mmio() expects to read FCH MMIO on baremetal.  VMs
don't have emulated FCH registers, so there is nothing to check.  Add an
early exit when running on a hypervisor.

The real motivation is Xen PV domUs can't boot on Zen CPUs.  PV domUs
PTE contain system physical addresses - they don't have concept of guest
physical addresses.  domUs can only map physical addresses they are
assigned, so a domU fails to map the FCH MMIO addresses.  However
set_pte() does not return failure, so ioremap() returns a pointer while
the PTEs are unpopulated.  print_s5_reset_status_mmio() faults when
reading through the pointer, breaking the boot.  This change fixes Xen
PV domUs booting on Zen CPUs.

dom0 can map the FCH MMIO, but it has X86_FEATURE_HYPERVISOR set.  With
this change, it no longer prints the reset reason.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Cc: stable@vger.kernel.org
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
dom0 could work, but that would require a xen_initial_domain() check.

I've wondered about a different approach:  We can't directly check for a
device for the FCH_PM_BASE memory, but maybe we could check for a PCI
ISA Bridge with PCI_VENDOR_ID_AMD.  That might be close enough to
indicate real hardware?  But it would still be a heuristic, so I'm not
sure how much better that would be.
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 40463bad1078..580ccc2ce5fc 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1357,7 +1357,8 @@ static __init int print_s5_reset_status_mmio(void)
 	u32 value;
 	int i;
 
-	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN) ||
+	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
 		return 0;
 
 	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
-- 
2.34.1

