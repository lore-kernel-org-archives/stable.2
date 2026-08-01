Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24F3CDBD3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627644; cv=none; b=RX7ZFnFpaHwSEqshK4AeFmDln4Wagf7IMit4ObF7SEXpRKmSqgJ2aBD0yLL2+1Xx7gX3S0ClTB1viZsWeXk/YYsCM81+VdJI85g9+IrLxg5UM6ed3s5+m8GbbnZ77QzGBEGIQMX/pbHaQZZGxkTnJXQdJr9rwPHkGF0+niwI+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627644; c=relaxed/simple;
	bh=Zkx2KtWbjMuyY78k/wureizdDvxVtV6NdKMu+WA2JcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IktTC67dZYRD15WzrJjADs13/iF4zGzuNuhOnBn2w039WVLUDemgP7Sf4KnA+3iutCI80euWIsozAAb0scXCqGQPn15a8JwXIzcowWGo//lAh7y0U8yGXI8n3f2O5hCB8ZdVVbIszidoZZG+HLwsKvF3w7PlWpy0dYQLeH+pmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/f7Cp9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/f7Cp9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05131F00AC4;
	Sat,  1 Aug 2026 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627642;
	bh=iutTwDcfUZcHWEcywuTExat4hfJQ3VqAkTGeY2GrIw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/f7Cp9kv9VwKw5XBGhDf2yqlHRCJIZih3oGOYUSO2RAcs8usDckMvFJ46Az6eF39
	 o3Mine+IPAOogY7nLdBZcBpNLmF5Yd+P8epzD2HhBS0MoJxV1ooju5cDQ0hLkWe8Vt
	 alxXjs5ZA2VUX4s+4sRv+qBB4/2UrdR0rRbWamqGn/ri7+PCdPRrKCpJUauZQRKz9C
	 jLdqrBpydxMYpCmgpnvxQKUEC3Zmb3v39MUuBtQXIpR4i/D6ArtL4z4L5STY718coE
	 /5Wi0wtDknXcjjf2+p9+cZIHMhtOL0toqhUxNWsb+F3BvTv7CmH2dRYUI+0WqrZd6M
	 rYSnJ3yE/zMZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] drm/virtio: Return proper error codes instead of -1
Date: Sat,  1 Aug 2026 19:40:38 -0400
Message-ID: <20260801234039.1832430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072943-outpost-ladle-390c@gregkh>
References: <2026072943-outpost-ladle-390c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

[ Upstream commit 4c703f5d6f776eaa6a98611c9b5dfe800fbeb0c8 ]

Don't return -1 in error cases, return proper error code. The returned
error codes propagate to error messages and to userspace and it's always
good to have a meaningful error number for debugging purposes.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20220630200726.1884320-10-dmitry.osipenko@collabora.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Stable-dep-of: 4e1a53892ba7 ("drm/virtio: bound EDID block reads to the response buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e98a29d243c0..4de413057fde 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -329,7 +329,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		if (fence && vbuf->objs)
 			virtio_gpu_array_unlock_resv(vbuf->objs);
 		free_vbuf(vgdev, vbuf);
-		return -1;
+		return -ENODEV;
 	}
 
 	if (vgdev->has_indirect)
@@ -393,7 +393,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
-				return -1;
+				return -ENOMEM;
 			}
 
 			elemcnt += sg_ents;
@@ -725,7 +725,7 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	size_t start = block * EDID_LENGTH;
 
 	if (start + len > le32_to_cpu(resp->size))
-		return -1;
+		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;
 }
-- 
2.53.0

