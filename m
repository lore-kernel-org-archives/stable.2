Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357117;
	b=Bex9rRBRt217UppazJLrJs5PSxBrq2ORp4j9r5YJ/dmB4DdB6AB7/Krj8ibwNaNAbGJp
	 7/N8I5u5vrQa48iCGd7y2fDbXCm9LAesKddk/QkxIE1ajwToA1SXzltrQZaFxyhecDIKl
	 hmFpHAe6Q3Usn1I0/8JWrmB6vDaTNBXikIVkLHrVajF8BHtyUTxuDDAczHUacybg3JO35
	 poYECgrdUAzk33SgDbCI0p9//Mjj7YohRsqKCXrtlkFCRaWc9rSN6/ni3g29vP7+sj2j1
	 n7QRqPs65ZG/I1Npc4QO5tVA0fzRsMsivQtT4uByhwQyP36gwjy0Km1konEXkcwUjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KDmh8Imz8T5vvb2XEs+LBDWXLdMHf2oKPSQugeLKxG0=;
	b=TC7rdhDBDh3O9K8qPnl5/NVlxsPGwsIb/rUm7fGPYHCoJY4n5KQeOPvzhB+ZYUu4zfrl
	 Mcf7WOUAqrfHj8+cD6pX7x2EIeewHit6kcnA0qy27Azlsni5hjSw9Fjwcw0Djj4ECcX6a
	 lC8Ty3LYKl2KyvsmRJeIe1Ppo1Cvb3U+98FiFYzdeDzkBi0zKzVKvtfWdF8p3Cn1HOUcv
	 3/V52v+FBfkzCYg0kthH84IgnFwL3u8VM+GP9IBjku9AezDzK/O7DZeaUhqNmEwC8VDas
	 Sq9WkHuMTBMMzDw4DWTFnzxx9Yxbdj6HitVG6MyZo04JV/LzYhWOuxGEErmq3Kc7IEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2G8HTbC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACB606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2G8HTbC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435561F0089F;
	Wed, 11 Nov 2026 00:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357116;
	bh=KDmh8Imz8T5vvb2XEs+LBDWXLdMHf2oKPSQugeLKxG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2G8HTbCkLSKDX7g6juygCRxB0fREV7XLhSet5ulwdnSj7cgYtcuUF5/s3Ch0HvjF
	 Ow3adNEuOGMPfub3BB4Zd0sC6hraapdg1TiT8lYZ2TdR1voG5LEBrGoKHZhdsmMTPR
	 HydpZjp71KZoat0/Z4Uu/n3iPTB33th212Am0X/QkwKVu71/JMYA77aaG1o0WHJ3sj
	 RgmSGwS8dVB6h3mGjcv7cCIW1oJJiDTNP2vAnqvwEZ2g4+6agjjNXYblsrQfkicK6+
	 yMg4UHFYzA/YlqIjoUVHWGLCurEk5RxfLGSNDH5j4Ahxn7NHZW8ZMq52ROh+n/bLIe
	 51llt7ENiLBDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
Date: Tue, 10 Nov 2026 19:31:55 -0500
Message-ID: <20261111003120.274148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052046-failed-6.12-6f165abe2b40@kernel.org>
References: <20261107052046-failed-6.12-6f165abe2b40@kernel.org>
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
[ sashal: adjusted allocation context from kzalloc_obj(*obj) to kzalloc(sizeof(*obj), GFP_KERNEL) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 5ab973627d183..1072e781f12ee 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -96,8 +96,10 @@ dmabuf_exp_wait_obj_new(struct gntdev_dmabuf_priv *priv,
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

