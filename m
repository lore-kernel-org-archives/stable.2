Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357862;
	b=PTBs6jLVBeGu1xLrq5am4GqZ8dyH1YzW7YJnvVQEiSx149rUg4W6CS7NKQ+w/Yiv0+Bx
	 8bTZEHk5srJsMZJE4JKZmyX+VvOZMDrpkj+WAlgiEBSEHD6+VGhI3nLwnWdX1kF8tYlLJ
	 D7isIi2pMUyXjf4DDpfu/U5+ObMxCfbY/vLCv9+yNQorVhJtQd3brv+63zlldvW/Tov/W
	 l5Ph217nXuEe/pNSt7fOuMiX3NMJsFLpIiz23oWm0CdkTwMHxtgPp4X4oz1cNtnn7oJ2M
	 fUvBicUbIY8+ANlukC+D7NOkfnWExezprx+hejz0JufwUKZk9kNS/zpZAPCbLpc/OKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357862;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cSR/TBey1iclnNGalSJzQTp/6lAl0LrfHGJZWIj5asA=;
	b=l8Roj2VPy6+Mtw/GZebOzjCERNOM0Dfks8B2Udf3MyFP+JzlyM9Elb0OO1gC56y258Cx
	 bB1kEf1waaHtZoxL+jNhM9A1pTGrdWiOc32pDopd7/O6LRPuUohcy66hQ7GzysRUnS1NU
	 49YBhRtmY6ElDiu28CZDPtfm+Ybt7yVkYOX3B1bTn/G71E36lvcPM3fVnxDgja1zmctlW
	 NuoN6sN8ivgP+sy8S2fvtTDOe74S0J8GumJXcW8l+mw4E8N7/f2mGkJlZym+gv9tfHM+i
	 UQ1qvfRf+0yd1+2N1bfZVxHgGOugxPU6REPQ7olnISvPRhYweW+f6cfOyIM3/7IgRWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUF0MT3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAA606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUF0MT3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC80D1F0089F;
	Wed, 11 Nov 2026 00:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357862;
	bh=cSR/TBey1iclnNGalSJzQTp/6lAl0LrfHGJZWIj5asA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUF0MT3pK7Hinse9tTEwHUbv2usvhT/wBOgYIKqbzkW/5jXkHiDZzt8dME5QRLmRJ
	 KewzgZ33ZYPlQNHbNJWE9oh7Z7gmLWcAJffSXmO3cgAKO7QCwnJjZzrw/MHXkOx4DX
	 s1ioqQ4mBbY13TlxaCXFbYsPxosrBDFxD8PkeCH/sjn0GsaPaYqyRYUbn8SnuyTTG+
	 Ik58DKyPrgfd8DSqFNW8Zuvw3i4w7pA0+OlReoWsP7dhpqxthe2y+qxT/w5kcJ8Y78
	 ZYTggVG2BKGKuzrmpJlHKVJQSB1fCKCemdwZFCKUok0N3SSqCm4aTuVmxADMrXyOlv
	 xj/fQHy0SywGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
Date: Tue, 10 Nov 2026 19:44:20 -0500
Message-ID: <20261111004341.313788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060336-failed-5.15-6f165abe2b40@kernel.org>
References: <20261107060336-failed-5.15-6f165abe2b40@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 6f165abe2b40ede71c98956cd74cd17c18505e75 ]

dmabuf_exp_wait_released() takes a reference on the exported
gntdev_dmabuf with dmabuf_exp_wait_obj_get_dmabuf() and passes it to
dmabuf_exp_wait_obj_new(), which drops that reference after adding the
wait object to the wait list.  When the wait object allocation fails,
dmabuf_exp_wait_obj_new() returns ERR_PTR(-ENOMEM) early and the
reference is never dropped, leaking a reference to the exported
gntdev_dmabuf.

Drop the reference on the allocation failure path so the reference is
consumed whether the wait object is created or not.

Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260916170956.2086505-1-vulab@iscas.ac.cn>
[ sashal: adjusted allocation context for kzalloc(sizeof(*obj), GFP_KERNEL) instead of kzalloc_obj(*obj) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 398ea69c176c1..8ed7aba6a6734 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -102,8 +102,10 @@ dmabuf_exp_wait_obj_new(struct gntdev_dmabuf_priv *priv,
 	struct gntdev_dmabuf_wait_obj *obj;
 
 	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
-	if (!obj)
+	if (!obj) {
+		kref_put(&gntdev_dmabuf->u.exp.refcount, dmabuf_exp_release);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	init_completion(&obj->completion);
 	obj->gntdev_dmabuf = gntdev_dmabuf;
-- 
2.53.0

