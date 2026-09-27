Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7E283FC4;
	Sun, 27 Sep 2026 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506622; cv=none; b=Rcm5nZuJveEvI9eUtrXyPk9rUL+UzRYpqu0Qf9Emi5oOHn3ztn5Q2i0BXkekASt8K4xnZuFf6nO/tVAgCbga5OQagVoWlQGnMDtgD3pn6awF1Uf5nH3jYtv+qM1c9ZdvI4ayrxFOH4vBowuevkifn1ivp8vKf3O7C6CPnsXDGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506622; c=relaxed/simple;
	bh=oUx02XbGljNjw77nl9Gkgq1I6b3LdixOYecjijGSLIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az402qoeBA4UPdN3NkDG+lteqS1MYxJkZbDdZKJhM7H9evZIbcdm+qrpe1xNuYW+Kw0Yb4uGlWHQpgT0/WJ0xct9FzEQ8BeoTdpkIYL6l9uFaJh5mqlCPa11lcmW/gTis6OOp4M+XM2cTqNKH6fwGrd+IEEZ2ttWRXxlmlbZdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+f4gLSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+f4gLSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61121F00893;
	Sun, 27 Sep 2026 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506620;
	bh=o+ilA+uiXo3fEvOMt/RW1tqOfV75NJRUJnmzfGk27BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I+f4gLSsGPgtaHDq/bsXRsOy/6uaJW0CJ/N532wUt+z2DU2ZUlDARz5+s1/P3ACGs
	 f1pVVjkUq5Z5fZDx1YMGHnBSk1t+YsILrD822jJ2t2PdD3d7+3GlKfynJLiSx7+PTs
	 /MlfZP5AZQAmckRquaLBi0a7FesVnjK/lUdEvdO5zNBBQ2cXLEUqKOFctaFu8y2TuO
	 MmVRpEGc47V+3mJL6ixSR2vvW0QPF7BdMZOdiHUE4F7S9s397qHb+VaDOXTb6AOF/9
	 b4Nh/wguDQER1rYEcSLkPU2Hgx4LnQEy8iI1vbeLxG0rqvT+keCU5U0HypKxVJQRby
	 gn9w6TYdWVXKw==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/radeon: Check the VBIOS signature after copying it from VRAM
Date: Sun, 27 Sep 2026 12:55:54 +0200
Message-ID: <20260927105555.8771-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927105555.8771-1-kaloz@kernel.org>
References: <20260927105555.8771-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On sparc64 a plain load through an ioremap() cookie is not a valid
access and faults; igp_read_bios_from_vram() does exactly that to check
the VBIOS signature, so radeon KMS never gets past this BIOS-fetch
attempt. Check the memcpy_fromio() copy instead, matching the file's
other paths.

Fixes: b442962a9e82 ("drm/radeon/kms: add support for "Surround View"")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 8595f4c6e2e5..a8367e481182 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -63,10 +63,6 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
-		iounmap(bios);
-		return false;
-	}
 	rdev->bios = kmalloc(size, GFP_KERNEL);
 	if (rdev->bios == NULL) {
 		iounmap(bios);
@@ -74,6 +70,12 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 	}
 	memcpy_fromio(rdev->bios, bios, size);
 	iounmap(bios);
+
+	if (size == 0 || rdev->bios[0] != 0x55 || rdev->bios[1] != 0xaa) {
+		kfree(rdev->bios);
+		rdev->bios = NULL;
+		return false;
+	}
 	return true;
 }
 
-- 
2.47.3

