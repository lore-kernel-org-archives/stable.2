Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A79363C60
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626533; cv=none; b=gySLwIxkRLufybQ38pCIMv9PSqjr69C4fDe6CB1vy/P4y8ZByU2SNJCNP+BWOCSqYdRVXwanAPhLhX6URgfjuYtkterKp2+eETOdC3IJ++HbOhOmI0bClVe69Xke4TQ/ZyXGRixqmVTsh/LV+RN2SjpCsS5TkmdS+6lGC8buCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626533; c=relaxed/simple;
	bh=WfT/QhtvDlh498663O0Y2xMEiIe9n5Y6JWFoqWkZvpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SborH4tWepbazoj5AZ1QjEXfwEvImVP2th6P8gRvlv9ySyHiZH9P0GCUJ0hGcr15y6fOevlj5A/X23ODEfUxAQIeCs0uUpJ3JFsFXk2Q+nUc+cwU9+QRmzs5Wev85bGTC7yx9P3C7GpURVmA1OgPRBWlVeKSdFUxPCLmtWXhmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/JzS/Hi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/JzS/Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431D31F00ACA;
	Sat,  1 Aug 2026 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785626532;
	bh=ZDEjJBUkcskXXlG66xpBZPv9EEvVbXxs7J1zOjHr/ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/JzS/HiZgkA2GKFzYkp3thAAb85idA8hfliCzhmpmXSMNNm0mrtdWm/mb9eCgbW9
	 GHGXkmGrPiR4EyqP9E4tU1+QhhuKtpsTLtUvcEm3OxFvrkRk1+S/tYaa5PBUCIqJOm
	 OUUXoqVcqxTvPZAyDvFZelk8y2YbgTYMcpxgmRLYjMKqHRo6TQBdrR8+4CVDeTJdrY
	 UZp2BitGIGI/8N3j+yJ8Dq/tj0Gdd1W+BQYWpUNc05TOkPTh6dZKqT13H1u2m3EmUw
	 8OsTuqUTzYv7D3OKk5OswGA7q7Z/HBfrV5KCMUmVKoeRE720JQmzSzklQTO574kg7n
	 4haM8g8SOR2aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/virtio: bound EDID block reads to the response buffer
Date: Sat,  1 Aug 2026 19:22:08 -0400
Message-ID: <20260801232208.1620056-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801232208.1620056-1-sashal@kernel.org>
References: <2026072943-browse-aviator-abf1@gregkh>
 <20260801232208.1620056-1-sashal@kernel.org>
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
index 65c31fc4e7d3..5383632569b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -727,7 +727,8 @@ static int virtio_get_edid_block(void *data, u8 *buf,
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

