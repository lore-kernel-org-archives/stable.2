Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164366;
	b=OxikEV7YNMpp7axB+SiCvAEEdW9rHeoCttP4mtbLlIroIHbqidN1IN0Bwgq0/LBCCTku
	 B7pKLiTcZ/i2bvI7RUTlKmz5XifTxzs90A7QWTWhtjaUbUTmc0NxciPVdDiVNql+/Bb2h
	 3NkfF/e17iiahoAuyMWFe84r7Eal27Ou8UWvsIowNFkVl3oScBMusNMh8veTL8Dkf8o0b
	 MmGc9DkUxRgUlo/mDfeNuiCU3tkF9XHCZOqvNIagHpqxCVk+VyOU80Gc8bVUk66Y2Sh3s
	 7OHGPv/bzMJbkiawZ6btMiLjxVQ5v3s1tjsWOFQ08D2SpFAEq15070KQWdY/MMcD3Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164366;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zK/8EaKyaT5Xh/Ltv8W2wQPpiIYKogvmCnmRwlJkLmE=;
	b=FStHnqo72h0tiAPd7J3QI8JqRBpOIJPSGHFhwJwtm7e2x8KwUwqs0zXq3wcTFSJ/fvkE
	 ivYt4sbkOAGAG+Q6KGTncECXUs2BQqAGTu/v1K+7v1iyBk9Pdtzrw2F6X1HWNRHBBnlJ1
	 BfklZdD9ex9g/KW4SEpMCABdcuamdEgk0CP1dpNbBgcHVhadwHcBw3QX6LiVN858haWSI
	 p/zAGBd7+FRueXMXmeoIEEWU86PZzlka4FXdMWLa5D0UEvbG55sylQ70XWKXrm1sO7Xjo
	 se2KzxQJIH05ld/mfnFxuuvgU/lVfgIurxkdF9VHkdyyDU1UNlgfzEIjEEAJr1/qQAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=URsPyFGp;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA191606A31D;
	Wed, 28 Oct 2026 05:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA191606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=URsPyFGp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zK
	/8EaKyaT5Xh/Ltv8W2wQPpiIYKogvmCnmRwlJkLmE=; b=URsPyFGpD9ZLpusRUq
	4BEWPP8w6QEBe8x+OEoMR1wNsTKKVJt7JHN0rVXBa4bODN0FNUm2DTIZBMXrFHKr
	iQh/w49G/55xrfnEV9dCkc/BhtSou3pveYGS+Z9c3WG6NgP+/PapAw3JtcMfoY0l
	pG/lJawDp0/yqY/97eKV5rqQg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3X9g6hOFqRUNZDA--.45421S2;
	Wed, 28 Oct 2026 13:12:27 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Alexander Graf <graf@amazon.com>,
	Sudan Landge <sudanl@amazon.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] virt: vmgenid: check ACPI companion before use
Date: Wed, 28 Oct 2026 13:12:25 +0800
Message-Id: <20261028051225.146560-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3X9g6hOFqRUNZDA--.45421S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4UKF1fKrWkWryfJr13urg_yoW8Xr15pF
	97tFZ0k3yUWF4fW3Wqgr12ga45Zw1kCry3WFWkJw1j9w18Zr95uFy7ua45W3WYkry8XayI
	vF1jy3WrGa10kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULyCXUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xtCfGrhhDsNrgAA3d

vmgenid_add() selects the ACPI path for every device without an OF node.
A platform device force-bound to the driver can have neither firmware
representation, leaving ACPI_COMPANION() NULL and causing a NULL pointer
dereference when vmgenid_add_acpi() evaluates ADDR.

Reject a missing ACPI companion before accessing its handle.

Fixes: e07606713a90 ("virt: vmgenid: change implementation to use a platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/virt/vmgenid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index ce957f5b1c31..cbcbb36eb6c6 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -51,14 +51,18 @@ static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
 
 static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 {
-	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
+	struct acpi_device *device;
 	union acpi_object *obj;
 	phys_addr_t phys_addr;
 	acpi_status status;
 	void *virt_addr;
 	int ret = 0;
 
+	device = ACPI_COMPANION(dev);
+	if (!device)
+		return -ENODEV;
+
 	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
-- 
2.34.1

