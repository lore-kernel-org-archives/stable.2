Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461446;
	b=3CvXmPM17mpXBlFLp5He0TUzrD31+H4OJYRX+QPP6yyhWB91FgiIvN+cTuVM802QTkMX
	 SuUoAcbSx8PFEi6Gv7h9sN1I0B/88qVOESPl5ZuavcV7kiIt7NZOr6AwabwHrOQbbfLXl
	 pFOU262hWkxoIVi5TyqJdOqovFpaqUnitlWT21feEPWpsogLeWXs9m8xHYMY0o/hREEJA
	 Cj8oWR4wEL+B/6mf0+fzRqCnfApsfOCd2HICNRvlEuqymFQDpCNUlroc5CdOUJaecC4ge
	 ku6VqJvbplm+FUcv90M331aycYearQCuYCnN6742WQsJJ2lQnSO6bL9mg3k/tG1j3Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461446;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1unP6yGfeR9Ry6d9NpxryqbDKz3nnIiIvne4N6p9eYI=;
	b=CwXa95ysswFE5cW9c/5WzqiK2ioxTzUyE7cUg5jge2WpGangCQvj/B/zD7J1yX2V+rI8
	 K+8UsDdTjV3bxqNT1uvDDuhDjPhTh2LNXKUg3wk8WRDlD/mWoWPpd27LiGT8imu3IApdw
	 r4owhge804tgzlb1P7XVFediTiRfVMeEyOElw2+XUE1uoJZiXF/DpQmVyaJkAQ3ELcstH
	 UDiZgc8XxsjmmJmQGjyWDXMeyX2y3ge4dCxJPHz5h3wYZECsQFJX/eutBITkbgcbbdUpB
	 r7Y0IMmg0xYAaQUCLb7KcAmP//CKlXJDF7DTO+TNAAPW0UjShpa4MYqYxT2VsqxKrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QAAc/cna";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CFC606A31E;
	Mon, 23 Nov 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAAc/cna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150041F000F2;
	Mon, 23 Nov 2026 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461445;
	bh=1unP6yGfeR9Ry6d9NpxryqbDKz3nnIiIvne4N6p9eYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAAc/cnaCfWSVuI8epwQ7W55sG8z3g29OHlH+iB8U2aJXGS9hN6Gs2oUYBUKSUIJT
	 1hJVbgwIdfTJG5p0tNKDXodoeXApePVYpheUeQOSEmJFr5KW7LP5+EvGEGeNIB/fPo
	 1D+1TesudsgviqDNHX1C0kWCPI7h/kFsXVOyPs7y+3IV5Uyeg91Y5H5Lu2nMj0pCrg
	 8Iafh3gHt36+Nn2Xj9HwANhowuK2OLxRH40f9+UzWLkmYG6Wk/dhtolaiErXlxnftb
	 BeGA0V+KCXTKpD1hqpCt19vu6D/SnUBVE/JmKbfaY8gsu5gaQ5kwZA6m59jg8i99A7
	 XNTxPbQzfJZ2g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Cavium Inc <support@cavium.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/13] mmc: cavium: Remove MMC slots before destroying slot platform devices
Date: Mon, 23 Nov 2026 19:15:45 +0000
Message-ID: <20261123191703.179283-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cvm_mmc_of_slot_probe() allocates each slot and its struct mmc_host via
devm_mmc_alloc_host() bound to the dummy slot platform device created in
octeon_mmc_probe() and thunder_mmc_probe(), and indexes host->slot[] by
the Device Tree reg property while host->slot_pdev[] is indexed by the
child iteration counter.

When a slot reg index is greater than its child iteration index (for
example when only slot 1 is populated or enabled), the single teardown
loop in probe error handling and driver removal calls
of_platform_device_destroy() on the slot platform device before calling
cvm_mmc_of_slot_remove() on its corresponding host->slot[] entry.
Unregistering the unbound platform device immediately releases its
managed resources, freeing slot regulators and dropping the initial
struct mmc_host reference via mmc_free_host() while the MMC host is
still registered.  The subsequent cvm_mmc_of_slot_remove() call then
accesses freed regulator state and frees struct mmc_host and private
slot memory mid-way through mmc_remove_host(), resulting in a
use-after-free.

Remove all populated MMC slots in a first pass before destroying the
child slot platform devices in a second pass across both probe error and
driver removal paths.

Fixes: f32b90e6887f ("mmc: cavium: Use devm_mmc_alloc_host() helper")
Fixes: 0f4d4424fc1d ("mmc: cavium-octeon: destroy slot platform devices on remove")
Fixes: 29ee8cf18a21 ("mmc: cavium-thunderx: destroy slot platform devices on remove")
Closes: https://sashiko.dev/#/bug/linux-f5f8989d-5e08-46d1-91a1-69841c36692b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/cavium-octeon.c   | 4 ++++
 drivers/mmc/host/cavium-thunderx.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index dd62b96712c8..7b75b3dfd3e6 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -283,6 +283,8 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+	}
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot_pdev[i])
 			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
 	}
@@ -298,6 +300,8 @@ static void octeon_mmc_remove(struct platform_device *pdev)
 	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+	}
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot_pdev[i])
 			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
 	}
diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 526ae9019b2f..b8296b2de127 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -157,6 +157,8 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+	}
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot_pdev[i])
 			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
 	}
@@ -173,6 +175,8 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+	}
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot_pdev[i])
 			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
 	}
-- 
2.56.1.750.gf70dc682cf-goog

