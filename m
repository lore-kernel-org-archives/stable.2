Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD1456E10;
	Tue,  1 Sep 2026 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247260; cv=fail; b=n0obM9GdsecBuAh9wEaHA3WXOrIPsGRikq8Qp/V+38WoIgAjmactW1QSXsJewVOYXPUdftwtoAXim4GJcJEKxElJ080gtj+LxMA/8zI4dnDcf/FiP9PlOvlJqLS5ygrhHhxw2wPNwdRnr4cHu2CksyON6AUXOJQqkpJj+ahb+vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247260; c=relaxed/simple;
	bh=FDSAN+UP1CF3i2XAhJlCaOayrzOhhyCAXMstHrZxMOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nPKeCgFxPjZC/lWDkxpabm0q8Cu7+Rb34h3ATcKwdG5gDCF8DI2ujXvRncqfdYFcSfzDKwTaiLorT+6QuDqFerSvxFzNRVkQ2Gz8ccMhprQQTYs1mIoUxUPP3s2t7EeHS6eADhK42CNBhwzZLznJWNbEWT10uwdxM3WLGe/3j1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zl+IySuY; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zl+IySuY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/+Z65hOQUTLKLnpZyudYbG3+TC4e8XcIjh9vkpsmaFGNcB4HN46vkSztHBFEVm2vP4jf9swAtSY/NZn7kQOefMwfa7msWDSeFAQcg49l625Z8L51CGZK8mgvkaMY87LuOvkjPkqiCKwzbs1aLeFxe/A4d8XtXpucfRLo4Ko0BEF2EwRQa9Q/wNVQ3VUqICh3xVpT+7dnQPe4XPfWu3bNuE6ny6Wkk/dAWby+MaH/w/QI8VqW/6Y1716teSrzoYOx7+01vkRZISBuRpDSf0EVA1tb2YsJTBEhvaLG5bZtwexSK5GAp8isOMyC/s1hdomZCiv0ddAWuDCJp/bkI1tSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+Qtew44XAaPPNjwYU668mU2cEUDpCCQX/nf0gtvles=;
 b=DHx/du9GkNT6g7UQ6uViv17YQOoh8HtrxIgLCt/laKaokmtl+ewa90UueCPKrzjOiNkTegK3QSyBDHvl+RsAngemjokpYIl1DNhkNV2r1MdvDpsfnexVeCk1znVxQuvPZcEVoFvlSvCjIQSyimVl3Rv1H3uwmliOkl3DEhB503AgMMVLx5aQ1lo3LlWB6Fm9EDifa8JcN0ttjWAbM5dex3vb4Vg6+h/pywG6Kw+NSrnEn0t/eDxyTtEQbqHIl5gPJZJ2AjBsYEcYtebRfail7e7BU3PRe0NgJVHXTSGJD/1q6NAgHBPMWnnmO8/FmrKKJVnN5/spjDWEc0w/6sL+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Qtew44XAaPPNjwYU668mU2cEUDpCCQX/nf0gtvles=;
 b=zl+IySuY5cblS/qJ+oiQAQ+/Isx8xmYCXNTstfpJ2y4bVVSlwlPMYkR4MLynD+Kq9aSVs2ySeszT/3AiG5hHbYoNB7TlYdSsh2BdiC4k9qEIpBeEZVM6K+0QKhx6W7unr46rXvVTYYcKgAkv09cXK8/8LmKFtgx4WyeaKxfNC6o=
Received: from DS1PR03CA0024.namprd03.prod.outlook.com (2603:10b6:8:233::19)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:20:53 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::9e) by DS1PR03CA0024.outlook.office365.com
 (2603:10b6:8:233::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 07:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 07:20:53 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:20:49 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 1 Sep 2026 07:20:38 +0000
Subject: [PATCH v2] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-gmem-unbind-fix-v2-1-12febe1d2216@amd.com>
X-B4-Tracking: v=1; b=H4sIAMV8lmoC/x2MQQqAIBAAvxJ7bsE2iOwr0SFztT1ooRSB9Pek4
 wzMFMichDNMTYHEt2Q5YgVqG9j2NXpGsZWBFA1Kqw594IBXNBItOnlQO92RMb3tzQi1OhNX/R/
 n5X0/j1OzBmEAAAA=
X-Change-ID: 20260901-gmem-unbind-fix-9f912bb3d3b8
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>, Shivank Garg
	<shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788247249; l=5438;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=FDSAN+UP1CF3i2XAhJlCaOayrzOhhyCAXMstHrZxMOw=;
 b=UPLrst+biY8OyuoTY2MzcI60ZpOACGFVs4qrgEvAyFYLre9gDHMo0y5Dg64MQvmFT/mNr5icL
 zlLUkXljREqDAqurwIe+b6z14+QAIS8TzO2qh93P3zIZApGgQykdOhB
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ddabc1-de82-4ee5-5752-08df07f98edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|5023799004|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	xcTE1W9SRczi/bCs4Y6Uw96vheCNKRJhFU8LahtebqFfH0Jzn+T/N+eygS5hlh4FhcSXA6apDRgv3DXM9Cz8SuohyZ0nB3ub7qZIvmkZ7s7C470fy+gI3o0XZwk1AF3xVtoMD4kficbcSWc0QqAgzE8UHDVmV4aXrWAMa5YjF2AYv8B2p2e9A4I1HrvkjHnFpydG0ncDcsbvYgE+sRGXxsXFcDwU4JVrjQcNIv6Y2rxjQAZ3ERMsgCzz4ZC7is4UI8KWNraE0Qq2mHZOxjj4kwSx+AFGGbas+RnteN7F9yn7sCl9bYSIIEeAjlXULEl7BaFYejvLO21mimJ8oWx2w2ShlLm1P8u8B8cZQTM2d+W58/kNt0uwtJnJPKXsuVKqjNcX88K+rCm3ttnm1PVkxiHZ1iGhjjuIvPH+itE0sZ4fchHjibILLOiza8SLx/KcgfE6Js3Ilv2BvYVONignhQ4kVeg87tJzGTbiZp25LxTORAMCq82ymG88ntSa/mHL/kr6de3Zyzh2Iye6NFWqTb4Em7jJ/vasiYU+MwI9tzduuXgxujwJu5E9deNPfa1TN/ipE+CfJIYYl1/qUTyA1Nb8Hetms30Y6Z9k/uUEMR++jgGxaEy1VYoBIqmf7ZdnZHA97wYDIUn/VZ734riwoHP8Sjf/btXrisfed9SwxpaHrQvswq5myTxhrvxS11g2DtVih+ENPOoK6Mh2aQU9fQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(5023799004)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bXsKFlCJSahyu/kRMLJpqzZ9SN3TqTyH45Qa3HVTO4HUlnc4yrtsYI3hWf/Npo11dJk1fa5QffQTvWWnxt+fTDtRX9omfdKxQ87mGQwaPgiH294OO2vXgEtq+T6NctHKDWu9oopEh9BqGBT8zAg8nq6RtIT8ZsejrXT6r3ateFW3Jcx1xt0MXysl0Dwbtp9TlcAnQO2wSeZGiqvy2bD2IE+4Qyo0RJD7F6DWuqBD4jzdJ5BQJlsvy1ji0e6VnYHNEvJunpnj/1h/b83sOyWYw5cmV5V9YoKrv1cvGPsSlFVhD8jZmRMajDFqkRfP1O5GGNEl1gFH40n92Ce07E8VLFnrTMXMcDeAvthgAOATc1klT0eZX0p2S2GA5zO7WgUa/f0sB+rM831ZjV6ZFvy0YDne2++lFCV3kQW/pUz9Y3/em0pEoVj4bSsuikkunJNE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:20:53.4166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ddabc1-de82-4ee5-5752-08df07f98edb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

kvm_gmem_unbind() takes mapping->invalidate_lock only if the
get_file_active() succeeds. When the guest_memfd file is dying, its
reference count is already zero so get_file_active fails and the binding
is removed without holding the invalidate lock.

kvm_gmem_invalidate_{start,end}() checks f->bindings independently to
decide whether to begin or end KVM MMU invalidation. So, the bindings
must therefore remain stable between the two calls. Otherwise, unbind
can remove a binding after start increments mmu_invalidate_in_progress,
but before end finds the binding and decrements it.
Example, unbind race with memory failure:

  CPU 0: memory failure               CPU 1: memslot delete
  ----------------------------------  ---------------------------
                                      (guest_memfd file is dying)
  kvm_gmem_error_folio()
    kvm_gmem_invalidate_start()
      finds binding
      mmu_invalidate_in_progress++
                                      kvm_gmem_unbind()
                                        get_file_active() fails
                                        removes binding
    kvm_gmem_invalidate_end()
      no binding found
      counter stays elevated

mmu_invalidate_retry() then returns 1 forever, so guest page faults
retry without ever installing a mapping and the guest hangs.

Remove the distinction between live and dying files in the unbind path.
Always use slot->gmem.file and take the invalidate lock when it's non-NULL.
Normal unbind callers hold slots_lock, which prevents release from clearing
the pointer or freeing the file state until unbind completes. Final VM
teardown can only see a NULL pointer because guest_memfd pins the KVM until
release has cleared all bindings.

Fixes: ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Tested on a 7.3-rc1, AMD EPYC 7713.

Changes in V2:
- Treat a dying file as the normal case: always use slot->gmem.file and
  take invalidate lock, drop use of gmem_get_file for unbind and fold
  __kvm_gmem_unbind() into caller. (Sean) 
- Drop NUMA selftests changes from this series, and will be sent separately. (Sean)
- Link to V1: https://lore.kernel.org/kvm/20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com
---
 virt/kvm/guest_memfd.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a031..21bb3710edfe 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -668,48 +668,40 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
-static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 {
+	struct file *file = slot->gmem.file;
 	unsigned long start = slot->gmem.pgoff;
 	unsigned long end = start + slot->npages;
+	struct gmem_file *f;
 
-	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
-
-	/*
-	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
-	 * cannot see this memslot.
-	 */
-	WRITE_ONCE(slot->gmem.file, NULL);
-}
-
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
-{
 	/*
 	 * Nothing to do if the underlying file was _already_ closed, as
 	 * kvm_gmem_release() invalidates and nullifies all bindings.
 	 */
-	if (!slot->gmem.file)
+	if (!file)
 		return;
 
-	CLASS(gmem_get_file, file)(slot);
-
 	/*
 	 * However, if the file is _being_ closed, then the bindings need to be
 	 * removed as kvm_gmem_release() might not run until after the memslot
-	 * is freed.  Note, modifying the bindings is safe even though the file
-	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
-	 * slots_lock, and only puts its reference to KVM after destroying all
-	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
-	 * yet destroyed the bindings or freed the gmem_file, and can't do so
-	 * until the caller drops slots_lock.
+	 * is freed.  Modifying the bindings is safe even if the file is dying
+	 * as kvm_gmem_release() nullifies slot->gmem.file under slots_lock,
+	 * and only puts its reference to KVM after destroying all bindings.
+	 * I.e. reaching this point means kvm_gmem_release() hasn't destroyed
+	 * the bindings or freed the gmem_file and can't do so until the caller
+	 * drops slots_lock, so there's no need to verify the file is live.
 	 */
-	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
-		return;
-	}
+	f = file->private_data;
 
 	filemap_invalidate_lock(file->f_mapping);
-	__kvm_gmem_unbind(slot, file->private_data);
+	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+
+	/*
+	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
+	 * cannot see this memslot.
+	 */
+	WRITE_ONCE(slot->gmem.file, NULL);
 	filemap_invalidate_unlock(file->f_mapping);
 }
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-gmem-unbind-fix-9f912bb3d3b8

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

