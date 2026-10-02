Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2A3EFFA9
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970260; cv=none; b=S13C05/Bpx5IkecSDsbHTSIp+N+/lmPOwCpMQ3891BSAsXywxbvn27L5jr22WUlhLeOH8tco8CS9Z0HgOYp39KEmDi5nlkzbo4PvCP39VppWAtrdsEB1E1p1j8h+hhaApARp3sg7KO4YlmfkE4DwlOJGMVZdyam9/62Izm/RawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970260; c=relaxed/simple;
	bh=t0hrpueYkVfKYyh59jcz88z6nZEgP0q8WK73YH6TaaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnQpeLSQEAPuhdRiUPo1fyXe6Bt03/+hSTLxTj3E0Lro+1DQUPOBH649xZqPm1KSzuaqETuZnRvqg00rczKRjnaLgxSoicu5U1HmmZeE0Hkei+NFidUJqcpvBz8RdKBlCN/WODSvVCbNlfEhgTIx8p4tN4pRQCORwB4aW2Yy3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=I2yaIzFa; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="I2yaIzFa"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso9839339eec.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970258; x=1791575058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rko1U6OoJC3n7W8qpIuhWiCDlnVmuYaiccHeKEGfF6U=;
        b=I2yaIzFalF3ya3kIw8l/P2zhDT5cL8dvSeacUIC6QolQr9lHq5jzvdm7cAcWoSNeqT
         99mnfZZmmZMUe6iRbzqPz4piUZk0LYfZGvbPjeHoPMWxU3u47WqlO6CN5KAA4N343Dz+
         bWZxd5Y2YySIjYSO87rIppolohGm7tgbwkNi5auafowVhdqQirZmFu3Fr+y49smsHt7L
         43HZS+xyoXYWbZs6VXS5KLZQzNBzGN7Uf7PjJ1sBMmzQDsllr4fAlkNyT0pGteMoHMZO
         J4sk4xquAvWiko1q/e43ywz4HrN97UJi2ZT7wQEK/q1cklO+69cepoqRj3Kof4NI1MeJ
         AI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970258; x=1791575058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rko1U6OoJC3n7W8qpIuhWiCDlnVmuYaiccHeKEGfF6U=;
        b=n7h3qgZ5K3dNLrlBwdIA06RBEv6dIHRDm9CyqU4UAocR+k/vowNj+AZjnABNpcdFXn
         WGMqNKHhxp7lpnxKGPTlAoczi+vlrP192U8byX0LyJ3XpZkemTOcgQlBD9EKKEtdhUV4
         7VzSjOj1IBiFT4U9htsQ0uVB0pVMd8sPODUMwHVcGtlrMol8tvrx/eGcCRi4CSu+Gjqi
         iMP0vMx+vt697QJI9z+i6Apbk7ABeYtz55slFHXr8GmCCCd5oV47VhSF9Yk0rAyuG8H3
         IH5K3UY71jhysunBYrW3+2MmFvjnqY3rMkE+3KKIVy8YAWsYQu3Si2NLl6cCjDKPpkUm
         iiWA==
X-Gm-Message-State: AFuF++kQcyTjTM5Epo5QW3OMkHR7Emef5btqBALnlz1zowds4rxbtnW0
	rJTQhn7CGWY05ixu7nJoIBESsB9N+zLjBc3n0aCpSHH/KhTGHCLahpEm4ap5mOkmzdRsYoCLa8a
	RwBm70VUFEQ==
X-Gm-Gg: AYBFou1BzTApTT2CMhd/8I3ZHGLpCwhQ/F2BD8AK+0MF8HFPbkWllSDUfW6NG6NJh4i
	e83qpqhV3zisWkVgn05MXMZNb+iXxt6vBBBLX2VhBnT/ccSu3djK1bzIGar2eU2t+SJQRMEAnsL
	YVUVjHZ0Jh+mt0NzE+ggRBWc074z3mNLjrJlQwfion9eZfunez1yr09gisc2JrWbZPrDMh6GPTR
	WZHmn9MO9xNzWhGQql8d52QENzJaV+c2jMzPCI5OiQ4NUjISwhszq80G1wJOYDm1MtcrdhoXiXw
	RSvUh0NzsBIsjiKmU3Ro8ELpEXbX+suov6iaPw/4Q4onAscZUzYel79g+oLP/upLx94os8xBK2B
	RMW87wZN/rLQDDn6XQV9DGc02SrsQCb7FgOyugbgy/ChmSK+7emOLhPuUL5N84Kro5Hde8qEGFo
	TC3Ss57/jPpau0svHJKEkTN+Wat2Wzv/nCg2vw4dncUj+zF4RFgx15OYF9EYCso78vs2WgUvuCo
	QkSc2b0TIZ4GPR5ffJ+GH1ar1uNSlzbKgkyAZxLjWnDv+6GrXNErjXHq4GKpEVOAr6SBcE=
X-Received: by 2002:a05:7301:4545:b0:342:94b:aa28 with SMTP id 5a478bee46e88-34f219610a0mr4295623eec.27.1790970257502;
        Fri, 02 Oct 2026 12:44:17 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fcd065sm7236803eec.19.2026.10.02.12.44.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:44:17 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	jason-jh.lin@mediatek.com
Subject: [PATCH 6.1.y] drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
Date: Fri,  2 Oct 2026 15:44:12 -0400
Message-ID: <20261002194413.20810-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 4018651ba5c409034149f297d3dd3328b91561fd ]

In mtk_crtc_create(), if the call to mbox_request_channel() fails then we
set the "mtk_crtc->cmdq_client.chan" pointer to NULL.  In that situation,
we do not call cmdq_pkt_create().

During the cleanup, we need to check if the "mtk_crtc->cmdq_client.chan"
is NULL first before calling cmdq_pkt_destroy().  Calling
cmdq_pkt_destroy() is unnecessary if we didn't call cmdq_pkt_create() and
it will result in a NULL pointer dereference.

[ Backport to 6.1.y: used the older Mediatek CRTC file and helper names. ]

Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/cc537bd6-837f-4c85-a37b-1a007e268310@stanley.mountain/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm mediatek maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-53056. It skips command-packet destruction when
channel setup failed before packet creation.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-53056
Upstream: 4018651ba5c409034149f297d3dd3328b91561fd

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 59b310f7327c86..8e72b3bb51eb94 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -161,9 +161,8 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
 
 	mtk_mutex_put(mtk_crtc->mutex);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
-
 	if (mtk_crtc->cmdq_client.chan) {
+		mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
 		mbox_free_channel(mtk_crtc->cmdq_client.chan);
 		mtk_crtc->cmdq_client.chan = NULL;
 	}
-- 
2.39.5

