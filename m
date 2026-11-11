Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358379;
	b=i7fTYOO1nwQoseDvOcxyh12FmjiikCI3SD9y41HajqZFOAOvqUKLdpWOtXxuqF2L6kCA
	 49AueS45HIcANa9jmQNwpi9/JkoMVO3qYzmXdI60FpsZdENWvM8Ip0Mj6QXu7VuweJK2C
	 jdKNuyD9srEQbphRNs8RpeS5y1de2f1np9+9mUwp1zteU2GwKfb331fTcXRD7LobXiYt5
	 3b6UNmc/2hUQ8XeePdXVntz1UqKrkTqKijIRWAjRra6w1djFvLlS8olvq2bbD8xFtcLKL
	 yJDwYswClsYy5bTufCdB9kuwPgPSWFJZtb3Rn0aj1Pp/Yt25hIQgYnQ4Q3lAiIDk7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cSR/TBey1iclnNGalSJzQTp/6lAl0LrfHGJZWIj5asA=;
	b=qIOY6A58/K0tz2gfNevqjlrECtNn1lpoAEXUM0w2+cxjAdMQa8wCgbjm9zuOrm7G5Zxl
	 P9BksFiTvuLdizLr8oHcnSck3COFbD28xKh+osEqDnqfRBljcU5nlbEOz23e8yYDMwT8u
	 5W/Potw8flSb684EvhhLM6iHXAIGmF7A/LQHEn1LFHvZa40eUU/Gg2luS9eh5+FZb9s/X
	 6Kf6vsyq2gq1xcM3G4rBTIBBM2pnlX1JpJ06+VOTEVaz0Vye2Y6vHFrYXOcmAp5tgK8a6
	 kpVVU0yf/Y8h1ddBYwfrFuBBIvRGkzVcjoUpQJbDit3H30wz9M/lgBe+4h4yd3RHTZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6vhzjrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B5606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6vhzjrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E925D1F0093D;
	Wed, 11 Nov 2026 00:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358379;
	bh=cSR/TBey1iclnNGalSJzQTp/6lAl0LrfHGJZWIj5asA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6vhzjrtsqQEHt31xEijSkx2ZZSg7ThsEzWDaa9E7S8M85q6J+EjpocQlMN8DAglm
	 aPhB08HNMkvo6/vuMAx2yLHFaCkFiU2XXm7cWXmomNmgnsm/nWXQDyrLcaRP9B5VGi
	 ZGQu5m+oBGI1NzMloK4zFCHc9J0GyIChPGaY185ehLf/t5FckEE4h/gyjy51kaHF0V
	 O4TLXAVjT0IZpfxDQMuwDUugsyUUmumpuMBvhLANqGDiCiNzSTddLiKQmw4LME5XO1
	 +RspYaMqX1rghfNhNauFoBbEfILJw4oWAr+bCzwkV17ZYXef2C4TSG5h+Zt0afh0f3
	 EWOlZzgmM4qcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
Date: Tue, 10 Nov 2026 19:52:57 -0500
Message-ID: <20261111005027.324382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062016-failed-5.10-6f165abe2b40@kernel.org>
References: <20261107062016-failed-5.10-6f165abe2b40@kernel.org>
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

