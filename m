Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421671;
	b=Qkg/+d1o7P6U8/UM9fmJ0DajaiLTkKt/EIjDsrmI3oVHkYP1bcbPSphOOTPKEOZyh+PC
	 bW14PPp3bxQpeUN56EaUSGbJLHQVpPl467MPk50ATRjC5jq3BeKT/0bdNLRp6U027wi1S
	 IhSTuZnxIWVddKUpkAEALJFxevZ27z/cUKfL7mcH0EVFiYD3+uauVrvWRMLyFUdxMmjwI
	 fVm39r198SzQNeQb6CtSR7mNLS4e5nY/FzSINhERM5076eF6sG3cP3bNTuusaHAAUJ0bp
	 lzS/M71bdA7MBeZTxIOMVdilGd4kV0tFVJ605UYWWXCDGJgCiyIhF8cCXp3quaGqlmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EYKMUd5h7eySF60EdGp0XwKF4LWItycTEg4BIQ4Sb8Y=;
	b=mWksfjoWk94Zcf1hb4EhZpsiBJb2JHvNXvNTkFBOeGoWFsims4xmU8TxjVXAnyrprmXk
	 S/lAgbCMzjw3G1zh0oL+dIWC5lwBk73bqdLV6aU30yYVRQkgXcIIDMP75oeqN+aTOcxIC
	 ZLPsSLkNqdOBxjyaIAk3rs4lMhuVaQtkceRtenaiW2r0FCqU16q2HqvE8BLdS9TRqB/hs
	 Ct42WQo7wKU4qQ80krQgjB2IIK+blxJnFABpbEhN4x4+LQ+cMCubbzs8R+yCWCGCCHQZN
	 TRJ2Lw8i9JNamrsPJ7y2vrqSW+crjY9TPYV+yXrmSQvpTxCgMEN5O2VKTHbg74hU2mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edDaeo4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D072606A33F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edDaeo4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6A1F00A05;
	Wed, 11 Nov 2026 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421670;
	bh=EYKMUd5h7eySF60EdGp0XwKF4LWItycTEg4BIQ4Sb8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edDaeo4rhTWv/6sryFXXms4SxHFdKIbLsZ9fcEuPP9WU86x80CGZXlv7PxM4LzeQQ
	 N07/aCx9XcvXKGnHCNwV0oblLbUNg1X3XmQs94gLC6zD+QbhdMDHNavhXoubWaPMKH
	 FIXVOyywPoWTmKop+N4WTFdBlxBSldsoBglBxpeusNkiCbBbEUOnCFQJni7JmeO2Ei
	 p68O32EVj+aYOJWYLz0vUMwXL9pyHmkxv3s7bqobN/hOGJkjtxYfGcPuFCEmGoUEh+
	 YwhKSOuMhoQyAp/WB6kP9JJA0ZQGrg8ILhpyFkcSbSfqBE6BFA9SvzkT7dNxVgL5Io
	 hWIbq1nSErMMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Priyank Rathod <rathodpriyank@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
Date: Wed, 11 Nov 2026 13:27:48 -0500
Message-ID: <20261111182741.3833868-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050408-failed-7.3-d4c842c3af5b@kernel.org>
References: <20261107050408-failed-7.3-d4c842c3af5b@kernel.org>
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

From: Priyank Rathod <rathodpriyank@google.com>

[ Upstream commit d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44 ]

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues the
entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is no
longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com
[ sashal: Combined the upstream pdev recovery guard with the existing err check to preserve false-alarm filtering. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index be332d3f106cb..490f096cfe91c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1369,14 +1369,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		regs = entry.regs;
 		if (entry.severity == AER_CORRECTABLE)
@@ -1394,7 +1393,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (err) {
+		if (pdev && err) {
 			if (entry.severity == AER_NONFATAL)
 				pcie_do_recovery(pdev, pci_channel_io_normal,
 						 aer_root_reset);
-- 
2.53.0

