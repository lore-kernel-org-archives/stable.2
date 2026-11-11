Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357644;
	b=PqJAXGLv7l7ZzZrIfaW/mMDNctwNvgFa6T2oG8CkDoymL5TuYfdFqSklGmmQLSWQfsOX
	 iWUnP4nfTIINe5k8lSKpan9recJxuqqE4CSKq2Oa6pzPZPegZQaxijR3s9e5Xlh3B97OD
	 HcrFPdVbrKSYoNC75+keDLXZKFagoXshkFGWmlyN7hZy4EiIEqY+g2rCU77XcVgMs4lpK
	 lGuY0UiRQ3Tds7PjGwZEoH1f7eImR7KQipEcgPFtp/zN3qwhOhVHHDxgHCuKf3GqMNkrh
	 OqpmlhEeNYjly6J68Ht2TzzoDX3iS1I8l74A2VmkwJbzhzcHn5k6PHL5kwZAqYahQzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1M5ZgFz6KcfVMsA0N5dQFTgZxJVszqvfsrrFeCjl2UM=;
	b=4UGod7DIQeYNi+I1/aPV8+XVZK79aKTR8wrwni91jWcRr0YXWTLei/IVmG4ChC6horat
	 ENY/ERayO/YcnUpomGDCD7yfBH6lc23zcyU3rZsb2LGwbQkvd+fv/XQfjFKaLivHxv5Ue
	 6jS+8cUPUHx9fe1zM2YgdsD5c8vMIIfKSH8HwGs9PyVGqAT/Ts8xW0NrxdwAA8Qu9Vo2q
	 yVqrYAH8cZXaHCy0QvM5Zj7f8LUYhT9GcZa1cU7+tlizurQlBHmq3sZH8DekhATq7+JY0
	 +5b7fKAd6VK5k8Qu8VvDXftlBM8B8kbHAdQEr2AXd9pb/X4zZPgc9b6H2WLhauVpO1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbsfAd2V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbsfAd2V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C3C1F0089F;
	Wed, 11 Nov 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357644;
	bh=1M5ZgFz6KcfVMsA0N5dQFTgZxJVszqvfsrrFeCjl2UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lbsfAd2VM2+siJvb9Gr/s/D4cGO3JLjafqWR9w5Z8jgG12fV/aYjUZpJrpnUfQSaT
	 oHS5sOki5VEJHlvyj6aBgw5o+swqGRCVtGzls160INYqt/RNRJXMlcWycBsXVms4DR
	 iv1NE6XZ4G11Ex3+zUnO6pQxF6ILWh8RsrO4C0BYTVpGO8Zvj4fbBNSdfIVQVNXJNY
	 EOaX9xsVlTXsOmfA5hnf7M/0hjzttsiY+8CGIBGKLxBvITo7utFRTLoxX1R0hvS/U+
	 XTOZzvKoIu+BlEMw77WPfAOdFkqxfDMrKPF71D33+2xVkq6MKJtEA8C3+JuS4bSmBk
	 zEUb/BWs41M0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
Date: Tue, 10 Nov 2026 19:40:42 -0500
Message-ID: <20261111003822.292437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054621-failed-6.1-6f165abe2b40@kernel.org>
References: <20261107054621-failed-6.1-6f165abe2b40@kernel.org>
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
index 7df26330af424..8dd95385d3e46 100644
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

