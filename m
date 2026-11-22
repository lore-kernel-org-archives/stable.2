Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363518;
	b=oxhwuJaPndadIHP4V9qPz0XbKz9Rb40ZSxL7IwYkSWDbQAxWkUizZ/yGQ+q8y9XIAGWW
	 RjZz61Zo7hXMhGv47On9RZtrfrpAa9TJys1OrsxvpkEUFyPlb6fEsZjzHtxAxyBgTRcaq
	 e+XDiEyGuljFPaB2wvU6yBnAvqbWw9GTd/u0VFBQkWBlL3iL4oRMH3fP0TXrxQONxXoHq
	 XbKd8gZbxu++lVFQ9RTYD8nwo9l+eJ8+E7r9xR6ClYeIODREgbk9yryXHyEIapVU0u8A3
	 4zIL8wV3S4Y2cT6VwCCuT9ULdOJAUUPnQu1oqJSwx5WuccM7dMVaDS3Pxt5aXuf+n1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363518;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=PDC1fhjsa3QM5vrQwmV+yrc+0aimt45h5AKiKFkWU8Q=;
	b=x8Sh+TupRtJ/DBhEJf5iTT3+ZVzhNLiZAEnPEp3rXShLW2ixTbxbHmjUpI2BQEk/HARa
	 xMPN3Ri/pb1eNiGcWo5lytg4wCO/LpO6jpPtlSvA9G1hH0f827WWN6utLGsTF8DZ/ZmsL
	 UnDN5y1YcdcMX39gJyEGAxoojyBoybdPy+D/ehy5gOtvztxI0l4BmfWREW1Xf5Hp9DQS2
	 QwaUDg9t1lxK6P6hUXqxwh2QX0vM9122hk6WCJGZj7D55ug1XT4EI3OQ3CjUZHfW5CkIs
	 a78oRIfsv9oNq21omO+ASQsmW/mmvb/gnGqlNA9hK9RngxUVl+e+TsXPthon140oCBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=U0beiFXg;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735F606A320;
	Sun, 22 Nov 2026 16:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9735F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=U0beiFXg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PD
	C1fhjsa3QM5vrQwmV+yrc+0aimt45h5AKiKFkWU8Q=; b=U0beiFXg5dtSbq4xwO
	FeX0Dr4wshH106OW8dCmMftUxWSNuCARKZGZFjwi5sPo5oeKR4GSiaN1++OepKQk
	mAQb2a+lB3Aw0FVP/PLchxuEfCvZwLUttydXnSeEv2QS8QTBR1FVg7VyDC4ozdG5
	R4NgOs7kB2xehGwIqK3z7EtNk=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3_0KZEgNrPMaTJA--.51615S2;
	Mon, 23 Nov 2026 00:04:41 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: handle request allocation failure
Date: Mon, 23 Nov 2026 00:04:40 +0800
Message-ID: <20261122160440.519843-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD3_0KZEgNrPMaTJA--.51615S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Cw4DCFW8KFWrJF4rAFb_yoW8Gw17pr
	ZrKw4jkrW5t3WqyF18A3WUua45C3yfZFy8G342vw13Zr98XFs2qr1qya4FqFZ3AFWvga45
	XFnIv3sxZw4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jG-eOUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7RpGlmsDEpqdyQAA3T

fops_media_request_alloc() returns &req->req even when allocation fails.
Since req follows struct kref in struct mtk_vcodec_dec_request, this is a
non-NULL offset pointer. media_request_alloc() misses its NULL check and
dereferences it.

Return NULL on allocation failure so the caller reports -ENOMEM.

Found by LLM-assisted static analysis. Build tested with allmodconfig;
no runtime fault-injection test.

Fixes: 1b78aae6313f ("media: mediatek: vcodec: Implement manual request completion")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index ab1894fba..626c8368b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -736,6 +736,8 @@ static struct media_request *fops_media_request_alloc(struct media_device *mdev)
 	struct mtk_vcodec_dec_request *req;
 
 	req = kzalloc_obj(*req);
+	if (!req)
+		return NULL;
 
 	return &req->req;
 }

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

