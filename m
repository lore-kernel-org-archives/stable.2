Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357340;
	b=T15Ts2KfgMbc6LgvLzsHSLbcKyAaphG2lFPEJLyShAT51waBFDBYwtJ17+K/byZklGT9
	 tLMtWc49u0rhBw+PXxRJ08SlsDNGlWcju8ypcplZb9oK3pBE5Trd1aETRo0ryKikEqnmY
	 Gfke10yTac0YBSgn9rFIEDS2tRZrvF3sqaFblX+T0gdGPXLM8Xj919OR/ixLLrqWiS49l
	 ZEZoBdWJlLwcv7M7kbkLOE204n7qzj0x/FTpjX5b3gJy8+D2n2oSgOIqlp7INmUse7hmE
	 CikpCsM3PrOIsXDZP7dtfPMq/lZBg331koztIyuHrLKKx028oYSyssJ1dHoSV70/H1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3JuYNeajO97zVr0inSSrXivQOJQaH3UNRM80JX2yDK8=;
	b=F33ZYwQUJ18QTalBjaV77v7aNhylZlTkAo11hxJcI6c0ebqg4bfrRBmHY0z+ifPzFJly
	 wKyKxHryAcZ92TPkMulYYDhxTdVjDgl0mWv2rJ6ml8+ZsAK+jILyKc935T1nUUeKuvdVb
	 QBa0dtnIRgRVK37rd9Vi3BOkh79/+aHyIgA0ab43R/030wjiv4VSIVb+znjvNaqriuruF
	 fxR1CtMl6pn7HT/rt0UMMD5H4GJKIvP/7YEtkWnGcQyQxnFmAR2TyiMq4WfoycafmZ3pm
	 48R6HwrBKV7ItYRJlhydbbQq0yhlbk5lTuxM6sruA+p4Bux9ovd0sxCGsACGppI2uiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhB1nbRk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334C606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhB1nbRk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F41F0093C;
	Wed, 11 Nov 2026 00:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357340;
	bh=3JuYNeajO97zVr0inSSrXivQOJQaH3UNRM80JX2yDK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IhB1nbRkjlelspqSCMh41kaIFz3h5dvj4DYEvmfoF6LC5ehOYFatkYNw+EUF3cA6x
	 w3ShuaK67p22E2Yl7ihsVm0bwQyHcZ4bcbiZyKFF7XpW67AWeMgfBQQTZY+3g9I+in
	 U3uTZX/TroAsyDP6M0/6wnw0Cm3VOkpNj5IJSydeSWQ0JMOH15BboPd+L38IbBrP6/
	 a6voAxDpoZP/zRp+lwTnzPUUHCgV+RzpXctYUrYTbnw+dNSqfag2u4SWcwpbq+iPmM
	 8++OX6TkZ/gGRMkJzUs7KKwlFf2IA5vvztb3zLe04q3XQAyMS1Ax/Mh0ZyKUjkR6z/
	 XRVKawgUPHGUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
Date: Tue, 10 Nov 2026 19:35:38 -0500
Message-ID: <20261111003448.284562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053313-failed-6.6-6f165abe2b40@kernel.org>
References: <20261107053313-failed-6.6-6f165abe2b40@kernel.org>
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
[ sashal: adjusted context for kzalloc(sizeof(*obj), GFP_KERNEL) instead of kzalloc_obj(*obj) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index d7b56466bec5d..cf82ab2e3aa6a 100644
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

