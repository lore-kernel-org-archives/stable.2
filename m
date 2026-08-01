Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEF23D7F4
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626532; cv=none; b=EVKM5+ecoXGonVq+q5yLAaw6DVmvHkr13L6HMV83TOp4d5vZKbC8LF/qGpm18S8lDIOH+IpFyAAXLKIR5FKKx0xGIdNETs1B9ZJU7C7XAHJDnfyq58bdOMgbKWzw0aaqb1pN7kksyNIvbTcUiY+LlFUV4p+DagFh7oTtfZXxFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626532; c=relaxed/simple;
	bh=An5RoleomqWqsFfjW58fPSUvVDnSq5Kg50X6HCb7C6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEAR0Sdg9BFErYjWVahFF3osagayTWt5pcEUgr4FImBrvxE3yvzzxc+dWF6aonIq6UfiHv9CJOJHuV8/LLrCI9438gBNoTIbjVwsPKSUAzcFLthJ/y+ljPY82mEDCkpR7aVux5it7Yq4AAZvDN4CWAXD6vFyrCyRZlgla4JNXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePcxnzuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePcxnzuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7807D1F00AC4;
	Sat,  1 Aug 2026 23:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785626531;
	bh=fuLlBgs7RSvRmkTlQJXVyYfr5SlpT99vIlml65yQphg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ePcxnzuyDMCsItsM5InKrjPDP6AmJN4Oz0tQiQ0JBo39pziOijYFiEbC+izZeTvGJ
	 2+8etxofHXa4mvthp90Z8vLgAYHDbaNcVyqJLM6WjFGYfCl53Q1K2RE8XScF1cOW+A
	 02laqfyz6lCetfJYL+iutloCf3rB0oMoD3GsUvWhmn4hLsbaT0oAYK+aYrvV8uVFie
	 ESFu0u+DUIEye7/opRdEMwqJofZneV6oajb6+sW+/99X6SVqyXzkPdTApSQc/0i1LK
	 wbyq7TCqlijVE5eEvfw41KWReKWvwX/vlNWrDyVRawam6pD0W2OFUuPKHtbUrgAsYB
	 YWEf4VnQ4TOJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/virtio: Return proper error codes instead of -1
Date: Sat,  1 Aug 2026 19:22:07 -0400
Message-ID: <20260801232208.1620056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072943-browse-aviator-abf1@gregkh>
References: <2026072943-browse-aviator-abf1@gregkh>
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
index 19a196b48a38..65c31fc4e7d3 100644
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
@@ -728,7 +728,7 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	size_t start = block * EDID_LENGTH;
 
 	if (start + len > le32_to_cpu(resp->size))
-		return -1;
+		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;
 }
-- 
2.53.0

