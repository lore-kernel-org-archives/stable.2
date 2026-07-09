Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143D3B5306;
	Thu,  9 Jul 2026 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597514; cv=none; b=nHhX/QExKfRurancBgpcgz5TrOlREywLOS3Mrjsq8zpYbfR9LQTZRkNYiao3S2pLY3htnINBVvfvI9lY5+5YYmAn0l+0PbKWzpegjECEBzFm6afVXjB5ZxWtYjdHW2xER7X24OVMICFj5C4TL/qohPds8aHSGhenAz7UUxX0zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597514; c=relaxed/simple;
	bh=0KDZiaZVZAXpVc7F5zji7D3nRwQNJdLeKoH5O3io19I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiZt/EyVLgsBE2+iwQgSwxZWmQ5C6GbVTBFMPXUCuyAEhznQW446jFBCcAb78KiOXjSHhxbHxZCB3RsywWGd6DzLCCbd/mTCeSAhX/MLRF9qbV34qt1VcKWjM3UnHRo95IA9c8sKprmfgZfGOUvvx5ZhsEkKRo6Tm8JjrPqUvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JJnxkTph; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JJnxkTph"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8912:0:640:42ab:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 636D7813A0;
	Thu, 09 Jul 2026 14:45:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id XiINBd2oAW20-NotBx8gv;
	Thu, 09 Jul 2026 14:45:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783597500; bh=Sn4PDwvqECVmn5QwC9xACIgixKNG02XVFvorw97wcag=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JJnxkTphY1wk1F4GdglB+oVxK6nm6kat67MZhXzU92v1HXvTMkB89MzWaByUEMk+b
	 u5aJTsnbq1+5/10mSOWSLrCzHl1x2OVQUEsXzLJbOy2xbccr43Dx/mB3Vtm8skyJrg
	 0phQWfe2l5xRr6kFZvbxXEQyK2yFtdlr+BT3yBIg=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sashal@kernel.org,
	michael.chen@amd.com,
	Jack.Xiao@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.12] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
Date: Thu,  9 Jul 2026 14:44:26 +0300
Message-ID: <20260709114427.41013-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with scnprintf() to prevent a potential buffer overflow
when writing to ring->name. The buffer size is 16 bytes. For compute rings,
the string format "compute_%d.%d.%d" can exceed this limit when the total
number of digits in the three numbers is greater than 5 (e.g., pasid=1234,
gang_id=0, queue_id=0). This can lead to memory corruption.

Using scnprintf() guarantees that the buffer is not overflowed, even if the
string is truncated. This is a minimal fix for the issue; the BUG() for
unknown queue types is left unchanged to avoid additional risk.

This code is only present in LTS kernels v6.12, v6.6, and v6.1, as it was
completely refactored in upstream. Therefore, this patch is specifically
intended for stable trees.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue submission")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 41b88e0ea98b..746cb0c71fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1236,13 +1236,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	ring->doorbell_index = qprops.doorbell_off;
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
-		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "gfx_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
-		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
-			queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "compute_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
-		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
-			queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "sdma_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else
 		BUG();
 
-- 
2.43.0

