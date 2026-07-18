Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022137.outbound.protection.outlook.com [52.101.48.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6A846F;
	Sat, 18 Jul 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386268; cv=fail; b=bk0HLgi/rqf5ydaVTmEbyskBjg67MmmSS2A6SFmbB02RpVFbtO8bzsFFXeE4pqs0tB0bLn1ZCUerbzh1+y1uMmYZkmGhp7Y+L7pgfm1jHym8ImFyR2BanMKCZOG/d5/njFRJ2W1ySgaf9SevA0adxOR+gHw8+wXGFt6Odijq5vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386268; c=relaxed/simple;
	bh=0JX7e9vriADyFLVNACIBBBP3zaWDuNmV4aXjvT9eg5o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HzEFljE+PT5cbtjZ/LcbEXWU2yd5oX+RPbRwpQn/yR/vsTWOGXpNhJEmybA9jm2mxumQPEuAFBKSDre5PlWTxXaSmt5mp5hBOIUKjFE2zM+B93IZPl29TeWrzfgIzH2Zkeh/MRdHQa6NxQzI3J74A2/3OwX4wh3HbUdSav24jfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs; spf=pass smtp.mailfrom=phil.gs; dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b=EmeIgohf; arc=fail smtp.client-ip=52.101.48.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phil.gs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b="EmeIgohf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJkrgkbTunGf5vlMqjQAmijrbXspquiApQKJQ00uTOXuI5U6Xt9e+n3ROZw/O/5MhNlwzfEOJBfi66/DXXMjhJFVdR/p4vJvgwns+nMMejxHdR/JNjHY2fVuux7j4jkzRIeeklV7MSQPVtFTnQso4S6E/A4UvJ177FPeZKfVguEuPjSHMUdrCKjDGuIvby0M6KJXtjTT+0HsUTMXmZA9bKS8k3G1hODEXNsUzwtyhfdMP5tVcz8ocKw3Q1QEduSZGDJKEHFYngn6LEmJTdgYWcaYf5SfLrkeE8ibN9NTrj6bHZNLRhRPH/7vVljDb7Q3k85i+a7/JICh9sU0Sjm41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TshDQSqwfUeoh76kL2yRowUMH3kCT2eh82+8Uvc+5Og=;
 b=WAgbRICVmPjm+6IS9I4pucbcqUQC3/a5mCfmfLo8O2dd1nQwReDnw69z0zWHhnJN+Y/KbIvEMFH6bjFhvm9n4OSXjD8Ur5bp08UXTaQJVtfV/FKv8ukYXkrZb9BmhQzpjsLrD+JaOAaH1DOqe6fWd3j0R/0fbmty9VLzfhiwhM7IbE4GlHm2Zo7iaTwQOJgo8WbQQlnvU0/t+kEnUbpdCXMILH4TylvAQoo27A0g9ZT+keuR4W1HIB9s9E1pYjku7zx9Jk6c/DayJZvl4ZRzs0LJhTGJ3Kc4C6XEkO3T9NhmlkFTDYlCPFN5pE4fN1o8Xq7Je+cf7h8et/8Ga3hyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TshDQSqwfUeoh76kL2yRowUMH3kCT2eh82+8Uvc+5Og=;
 b=EmeIgohf0NVmm4dsxpX7Zpqbd2oDSn+DigjlZG2V7WxWJUj9o3pRXTI+DWCR3JOeMdcKygouUBLlFFpHd2Uj6fMp9840r1COllZiu6bTjTK1iNCqbjT+JfY6UJ0e9s5/AASmIaT0F2tIAjMp5HLdNBV/Gs02vfJZUbjaKk4f2Bc=
Received: from MN2PR04MB6480.namprd04.prod.outlook.com (2603:10b6:208:1ae::10)
 by PH0PR04MB8387.namprd04.prod.outlook.com (2603:10b6:510:f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 14:51:04 +0000
Received: from MN2PR04MB6480.namprd04.prod.outlook.com
 ([fe80::6e8e:5c12:2765:b3d5]) by MN2PR04MB6480.namprd04.prod.outlook.com
 ([fe80::6e8e:5c12:2765:b3d5%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 14:51:03 +0000
From: Phil Rosenthal <phil@phil.gs>
To: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] KVM: x86/mmu: Fix double-free of mmu_page_header_cache on
 vendor module reload
Thread-Topic: [PATCH v2] KVM: x86/mmu: Fix double-free of
 mmu_page_header_cache on vendor module reload
Thread-Index: AQHdFsTa4Hi5lrTB3kyJ0Dsv4esuCQ==
Date: Sat, 18 Jul 2026 14:51:03 +0000
Message-ID: <8292444A-CE2C-4E1C-AE13-5B21D4D1A884@phil.gs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6480:EE_|PH0PR04MB8387:EE_
x-ms-office365-filtering-correlation-id: 51856ea1-e71e-4801-0c95-08dee4dbfd57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|366016|7055299009|10067099003|6133799003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 lKX7DuJXN7mFZLkfwfnRhPeKbYyzM5yOc8qFdkldQAn+QcTvwPuVbnqrbQWcR118Boz9eFbQ+34vBUqoK02tf2t95qD6VDVu+rb72o8hjlUM6oJJKe1NqfxK8UIjuPr8gc/MpQsoC8ygXHimgjTn9SwfuSA6ZVJ1egrm2T4vAOLbYwhHDI3FzBaMFtxtxH0Vvc57+7Nn4slUveWOFTohPBCi6Wg0CJRnFJ7GvR4UVwiX/On7XohDS3o3mjlv2jdwK5bgnLeGnXc9J5ygc4Pi26BdOGblfc0AcG8CK8AuCPBCCurnFV3/AN+ku0vPETdn0thX/+LbMPsz4+hkMTlVG7IxSe16JQFSZ8SzLmD7CCjXM9AdbDhQJbh2BwqbW2Eroxv2OFeaxHg6koG2+uqIe+fE/0lCSqGl/BNkvuW5IXzZTWGmYDRvwdHb2CCBnec0cNeVtWK7/AqcCByjK4wmrYxxdNdpGHg2wROi1RHW/pTl8/YPE//eURf/zzDx9nacuAMH3z77TA+pS+0pfY5mJYkeDdi8rS6+1PmvAhD91v2924Z9Jj9zaXzpLDmSTi5LYcvoHGUYuA2DNSYg+Im30rPpGFIK5lntlUaWzmmgmXxUqyXzSqiIb/YpZAaryvArRATHVMgRwUqGwBiDkhA3mcjmGESzwP78ZTtIrxuDX+WrRcZRy2Fdraag4aNwVPemRG5tyiGXMZFePDOLs4EG1mjl7A+/wssEJjkLBtcaIwbgRvDbhBJx/4lwGa/oaMpt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6480.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(366016)(7055299009)(10067099003)(6133799003)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j/4mv8jdp4h32wAGzpp1Butn7OTvC+kqc53pmZb8f9nhvgvAs97BynzuppuW?=
 =?us-ascii?Q?6qPopLd7BUyJMv83RZYz4g0DnvrfKa3hSjwE6aN++mbscOlTCoXdH4AHz8m8?=
 =?us-ascii?Q?oGo8TvLkh+5aVNHZGjR5KQ2sGc+A49Sdzf6HzzxU2t2ehJO8AgvnIJODPHS5?=
 =?us-ascii?Q?t2MJdj9LI2veEFnCnloREy2RQsrX7dpDLA40esvEE6gJhJ3PcEKwvA1gN9Qx?=
 =?us-ascii?Q?vmCIHAwYXPcr+a3pMQ5J1VCl4wz9Cxfrt+6K2DTYgBuiD3Ek7kyJ6eAQD4uI?=
 =?us-ascii?Q?K6yjOvSuGubrYw78D2E/rx5TWmtIAHOeNkCv4D9hBmoc8RPhNTXGkvgZ/mDH?=
 =?us-ascii?Q?fuXy8TbpxhPL+2mVZkR/wDTwE3T43C0Xx1TQS6a1uT0xiGWhyrgM1g09mydV?=
 =?us-ascii?Q?LfCuSBvTWkYt4qr+J2aN3yhL4F6dvebmxBKGzvFqvOlwG0WOoh4nzy7GMLrX?=
 =?us-ascii?Q?YLKshpT3PGMaCyQWA8AOxJ4kRbbqksVyXp+gHcnnMpxzi7rEI1XodsEtqEmb?=
 =?us-ascii?Q?3CP8fd0nllvh6li+1xY/9Xbg/lEhZvHy+rfspj2xBY4hYBMDqZ1Ofw5A0bkc?=
 =?us-ascii?Q?synDmgn1BsAYQ36OaMvaQE//4p/nAb3rB2Jjn35b8tI0EyJAjBA4ton/npvV?=
 =?us-ascii?Q?kv8+uhPZOi4ffVKFHzsrLM4atW1MzX1FAHWlrQRq30nTWcS4irkKsCxCjZhr?=
 =?us-ascii?Q?37Mb+H5Sxs0I6a7ZldKw1I/CRjcowhjkxHZdNy7c+JTxpXCTfUs+2l+lUkjG?=
 =?us-ascii?Q?58W8vGrBKDGC6mf4R19+DDQzZggTP/THz2hTrwhBXUFhD76hYJislddEIVZs?=
 =?us-ascii?Q?j7vlru8jqDn5+mJenydTDMtj+gqt2w0Z2pBEIFSpZ/41LLINFIxpARSmAySJ?=
 =?us-ascii?Q?CsAR32W18ojfhvlwy48bhEzZCb9zn0oJcF3f+h0IcvOKLx2OQaPUm50ynYX6?=
 =?us-ascii?Q?oPVKzQQKy2YA7wQi9gHRpPokXtcgILLCW0lXaRoIXlL1cMQ79KEoaS1IajHS?=
 =?us-ascii?Q?rarjjZ8YLDLgfmDYoSDz9Q0CCxD/yJV8IPLkltpMyHSUXTkdzQFkq0hlyqxV?=
 =?us-ascii?Q?3HZVMka1XS8stX0gu6kXXposhrWfVhhS1TA2lwRF6UzVzb3ak7TJqHDhXIgr?=
 =?us-ascii?Q?lSJpPmZK8vS156q3aKT84e5rSfmJ4+OutMqpcGoeI1XN1cZvUUaF/9TKArng?=
 =?us-ascii?Q?+AYSlmCZcXR/wgdVL+GiZcWDn2MZoMEVsM022mHpFbuJc6uqlIjNsvo5eeV3?=
 =?us-ascii?Q?Bvg8xswMegyc+5O0z56GiKx82SWfbd5xtrwpuFgpwdV9TJpvShx6HnfqZyyT?=
 =?us-ascii?Q?7Ds/e5Apta9nSnZigg/Zfe7w8l0vRYo4vFPwxtRKprhqVNMN2iAL5w/0lPLW?=
 =?us-ascii?Q?Age5OCnDYB2W8ekAzx44nrDxKsjp1WMhNXCBSI21xMYw2hU8iKPM4092ukez?=
 =?us-ascii?Q?JBFNFmxsRGY4utQ/EqSRVcAjnkAuz+xkwZlzkAWyO3rPpY+myGy9PJUrBH0w?=
 =?us-ascii?Q?KVnzRpiGA+DH+yzgKqI1LlHwUIQEk8GZuhx9I4kwE0gnec4/jiLTbPYuoNnp?=
 =?us-ascii?Q?/huB4/Dfkpf0fk+qk6Ols0jikOAZWKQ5j3GbGPqYyvnj2pfaak1Oyy/tl0cl?=
 =?us-ascii?Q?cgJbhff8ag0FLeIgH4MNAywko31vuWVYGKvhosv5E8Fp/f54m2KwcJJn/l5g?=
 =?us-ascii?Q?DnwSwG+BLJMAyt26cqlhMbEd9SiIrmKadAxbwYjM4kYFE2n2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E355B424EC290B498EAA4DDE5F082F78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6480.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51856ea1-e71e-4801-0c95-08dee4dbfd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2026 14:51:03.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtyb16ahCwQtQ5UsnZGAcKGDOCAHzdNl7LMK3xkNPTnBmGSINqb3eulYGy9LVfq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8387

mmu_destroy_caches() destroys pte_list_desc_cache and
mmu_page_header_cache, but leaves both pointers unchanged.  The pointer
variables live in kvm.ko, so their stale values survive when a vendor
module is unloaded while kvm.ko remains loaded.

If creation of pte_list_desc_cache fails during a subsequent vendor
module load, the assignment sets pte_list_desc_cache to NULL and the
error path calls mmu_destroy_caches().  mmu_page_header_cache still
points to the cache destroyed during the preceding vendor module
unload.  Passing that stale pointer to kmem_cache_destroy() causes a
slab use-after-free.

A concrete trigger is:

1. Load kvm.ko and a vendor module, creating both caches.
2. Unload only the vendor module, leaving kvm.ko loaded.  Both caches
   are destroyed, but their pointers remain dangling.
3. Reload the vendor module and fail creation of pte_list_desc_cache.
   The error path attempts to destroy the stale mmu_page_header_cache.

Clear both pointers immediately after destroying their caches so that
the stored state reflects the destruction and repeated cleanup is safe.

Reproduce the issue on a KASAN-enabled v7.1.3 kernel by forcing the
second vendor module load through the cache-initialization error path.
Without the fix, KASAN reports a slab use-after-free in
kmem_cache_destroy() called from kvm_mmu_vendor_module_init().  The
allocation stack points to the initial vendor module load, while the
free stack points to kvm_mmu_vendor_module_exit() during the intervening
unload.

With the fix applied, the same injected vendor module load fails with
-ENOMEM as expected and produces no KASAN report.

Fixes: cb498ea2ce1d ("KVM: Portability: Combine kvm_init and kvm_init_x86")
Cc: stable@vger.kernel.org
Tested-by: Phil Rosenthal <phil@phil.gs>
Signed-off-by: Phil Rosenthal <phil@phil.gs>
---
v2:
  - Add Fixes and Cc stable trailers.
  - Describe the failure as a use-after-free during repeated cache
    destruction.
  - Document the KASAN reproduction and fixed-kernel validation.

v1: https://lore.kernel.org/r/3FD1B35F-ECF8-476D-B2F1-6A43E6E0B641@phil.gs/

 arch/x86/kvm/mmu/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 234d0a95abf5..ec49ce98a449 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7574,7 +7574,9 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u=
64 gen)
 static void mmu_destroy_caches(void)
 {
  kmem_cache_destroy(pte_list_desc_cache);
+ pte_list_desc_cache =3D NULL;
  kmem_cache_destroy(mmu_page_header_cache);
+ mmu_page_header_cache =3D NULL;
 }
   static void kvm_wake_nx_recovery_thread(struct kvm *kvm)
--  2.47.3

