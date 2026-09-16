Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84484D7961
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576393; cv=none; b=XTpj+3jmfaYFdrWb16vsrUmeLX9nB9K1bB3JT/D5vEDyLxfi9BHeiH7tqb51XIRURI2S4F5PuBxGimiTeKYO53QcM1p+qpB1+u9aO1NWdsiRX38ONGDo74sumR9JeD/S7Zf//aCXVwsYv9qFvCXB3B0rIJTq387J9SMzbOXUFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576393; c=relaxed/simple;
	bh=M2XQ9Qd1HbzFpfwpUuAmaIICBnudDtoWl0qNHdCiP4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trxiDxIIsCvluJFVUSAao+hHNTqCfG/6tN/xlnwrXQ/SKfwsL8ZGxEDbxSfB37VHrJ4BhCIk9Mf4eotxVhfYPQSUvsj80vPGkUAlLNeAiattV4MQE0FZpWSJLeZmD8zDNyw3yVk5ICnJZaP21yBIrF50MxJDbCHIO55wytw9h6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZRlSPTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZRlSPTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCAA1F00898;
	Wed, 16 Sep 2026 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576390;
	bh=lrtP921aOTypS4pzFCGLV8UapwJ/1X2idD+kWFOCDs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZRlSPTW3BcdLGwAMkeAh7+fgA7DbSl2XGA2ou7dmS2i0cvkw04Ov7taZ1oP83Cv0
	 clJlCrGEZuzBgkQIfUys4JDuSVqkcy9Axa3SaltqgB1itiyFocAwEZCrtU4rsQwNI1
	 ffcd7qU4Uladvo+1JW7EGoYSKy0QDwbP4fQW7BhllfkyVayldM25JWg+KMuQKlXPRA
	 mwx4QiJTNLBMDK2W9BWha2SXTcdi+z7+A7fzFQX8slmUlpfQKZewaB3Y+9PWAuAqVM
	 boDlcYCnv92Fjp8tVGhJx2FszoMHRtOdwAAz72uWpnYXsX5YYDgP03lB/r63seyjGn
	 gl/L4sAXvV5wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"
Date: Wed, 16 Sep 2026 12:33:07 -0400
Message-ID: <20260916163307.415632-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916163307.415632-1-sashal@kernel.org>
References: <2026091651-justifier-ramrod-f274@gregkh>
 <20260916163307.415632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit 829157e762ed043e28ecb2e9f3c7d22b54e5989e ]

This reverts commit c119d05a36a884482decc67e55944648f8cba97e.

It removes the newline even when there are no fences attached to a
struct dma_resv, leading to multiple BOs being output on the same line,
making the debug file less readable, not more as the commit intended.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a2aafaeb2be13ed3c893e6a44a3a5d26b251ae6a)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4a9d5e8fb429..718937777e532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1699,9 +1699,8 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		dma_resv_describe(bo->tbo.base.resv, m);
 		dma_resv_unlock(bo->tbo.base.resv);
-	} else {
-		seq_puts(m, "\n");
 	}
+	seq_puts(m, "\n");
 
 	return size;
 }
-- 
2.53.0

