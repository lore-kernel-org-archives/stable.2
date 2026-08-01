Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AB33FE33
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627645; cv=none; b=gROFJHkx+uV/1noKy7SoE9EXgn6FYGxt7JQ5ohjnfYr9Lx5dctMWB7/Fk8Je8a4CPRMR4F8Ewghmhen8zBqv6qYgZoxFmgQHiaMdv+apJCa5BclBkPjkt1/qkTi6BOvTvITZ7rgmMAGCZdfmBWAuBSKkFh958BoNQZhSZVdnShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627645; c=relaxed/simple;
	bh=rMgpOkkS4694362wRHTpIRM9K3tb4hsp3rhkkWBAezg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAPfjLLme4/33/k1PKoBRUJZCsSXvOP4z+9PawJcm5STNDweg5S3kfDLi8zMd9XsjDjS3vYyB5BmTSEQe5NkEREOjwznRaoGbTcvxE4diTknF3v1WFugxioe6kUmDz9l9yYY7tJ+1bnck8B1zHYi+vVzpOkhHNC7+GnBqW7D6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE77QRqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE77QRqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18701F00ACF;
	Sat,  1 Aug 2026 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627643;
	bh=u78EMhLtpFuvG57ei2hriOBTVAuRohnmd6208sLxF3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AE77QRqt1PDJZ25yKB89OoHgkICArG3gwAsdvzN6Y0NqCUf8wuGytiycGR2GNDCnK
	 gbf1WpKImwpcVhHKosZvZbV+Z151eeXyTKw1qH8Bn4yMeWGWeMRPlTpQGKiH3l/8Q2
	 KqbpQrbnqcbLjAr/b/uY/cciVBXxt01yb68UW4tWXL4/ZFSD8ej2yT+qUZLOA0+pqP
	 ea28wmMSpo8wWzlESC36EouGCzw/oVElAgDtUuJODtWKnGEHozuPXdBZaf2fC14+Nl
	 CCJ1Up5e5zi8hk3HSq+cLJr5IuU7RdlUiWa9er4g6CTfbOxQMRHTfiUiMi/HSkfHel
	 crzRnJC+dXzTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/virtio: bound EDID block reads to the response buffer
Date: Sat,  1 Aug 2026 19:40:39 -0400
Message-ID: <20260801234039.1832430-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801234039.1832430-1-sashal@kernel.org>
References: <2026072943-outpost-ladle-390c@gregkh>
 <20260801234039.1832430-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 4e1a53892ba7f8a3e1da6bfc53c83ae7c812dccd ]

virtio_get_edid_block() validates the read offset only against the
device-supplied resp->size field, never against the fixed-size resp->edid
array. The EDID block index is driven by the device-supplied extension
count, so a malicious virtio-gpu backend can advertise a large size
together with a high block count and read far past the array into adjacent
kernel memory, which is then surfaced in the parsed EDID (an out-of-bounds
read / info leak).

Also reject any read whose end exceeds the size of the edid array.
Conforming EDID responses stay within the array and are unaffected.

Fixes: b4b01b4995fb ("drm/virtio: add edid support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 4de413057fde..d20ffb314d89 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -724,7 +724,8 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	struct virtio_gpu_resp_edid *resp = data;
 	size_t start = block * EDID_LENGTH;
 
-	if (start + len > le32_to_cpu(resp->size))
+	if (start + len > le32_to_cpu(resp->size) ||
+	    start + len > sizeof(resp->edid))
 		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;
-- 
2.53.0

