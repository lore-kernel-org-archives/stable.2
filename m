Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066282FD7B1;
	Sun, 27 Sep 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520977; cv=none; b=NQ2DiTxLkujRZRuFcZSOgB+NosGiNPCpX6LaaNj09cN30CKeKo8sNeLslPOZYr7UBydKhSRMDrRXYNn2n+pzAzjyXAVGVeZ5AfuHnDkgIDi97QLaWLxzO3YcuHlDKO42GQXn1lJcYExGkc55ujsfjamrys81VhQWXnJx8pGJpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520977; c=relaxed/simple;
	bh=TIexbawRrjBvcMBwQFMDCA6x81r5yBaqzgAOaIgzfkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqZR1tFGBHcuEffPUdKCUYRb3SwYc8Y48bSiLglmXIl5nvXIzQHo34wn326C78CCgCSbxeqX8DfKu9AQreG21s/wU9jz6DMXY1bsnXjjyJ9+bKP2sAXMAmo1cUBgCdOugbJ1l9kK+WaUd5NPMFKBzQODp0Ps2TqaEW9S9nNOIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA0eYk+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA0eYk+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F5F1F000FF;
	Sun, 27 Sep 2026 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790520971;
	bh=Ewo/kFhfNF9BUM9+V8oV0ndAio75zzFZWkSpzJ/6QFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JA0eYk+icdXbhoC+ApA3bVeLwziBW0BHyQlLJ6143opdiBvujXIYGQpLW4IER7Zc1
	 Y2U2jUjj4CXZCrfKzhltklUF43dkaYe8nSBhOz5ZHsWUDdy2+TgMA4hAKnlZKUHnfa
	 lRY19NIiMIdg94oPVpaYm1k0XqyoMTyQNTvN6YEKgkw6meAOCN7XFgN0ud9GoyMa8t
	 I8CGa3uh82SUi3hVqV2tsqNCGjF9O/xCjywAmEj51p4GXqfA8/LToN4lHCHmfDNYsk
	 Hwt06RYisTcjRr8U7awX4jbblleX74vF9T5jI2TWd1Ps65hDkbzfwz4Xzc/xNXdZNv
	 uID1lemqulIqg==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/radeon: Read the VRAM VBIOS signature with readb()
Date: Sun, 27 Sep 2026 16:55:04 +0200
Message-ID: <20260927145505.16883-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927145505.16883-1-kaloz@kernel.org>
References: <20260927145505.16883-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igp_read_bios_from_vram() checked bios[0]/bios[1] with a plain
__iomem load, which faults on sparc64 before the copy runs at all.
radeon_read_bios() already reads its two signature bytes with
readb() ahead of its own copy; use the same accessor here, keeping
the check before the allocation.

Fixes: b442962a9e82 ("drm/radeon/kms: add support for "Surround View"")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Changes in v2:
- Read the signature with readb() before the allocation instead of
  checking the RAM copy, as radeon_read_bios() does.

 drivers/gpu/drm/radeon/radeon_bios.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 8595f4c6e2e5..1da6bf1c17ff 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -49,6 +49,7 @@
 static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 {
 	uint8_t __iomem *bios;
+	uint8_t val1, val2;
 	resource_size_t vram_base;
 	resource_size_t size = 256 * 1024; /* ??? */
 
@@ -63,7 +64,10 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
+	val1 = readb(&bios[0]);
+	val2 = readb(&bios[1]);
+
+	if (size == 0 || val1 != 0x55 || val2 != 0xaa) {
 		iounmap(bios);
 		return false;
 	}
-- 
2.47.3

