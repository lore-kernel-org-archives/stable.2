Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047595;
	b=zXtmHZB23uf6del+tCfsS+rt1SceFC5WBjpixSPo4xvXsV3tUXk/2SPu0M8nYCbjYE5L
	 mLgXieDAB5M2jCWDBLHCWWkDXWKqhN8KLtQUM+8CQq9aei31P06x+tPWwg1ImNtmc3rZ+
	 jf9OXYrXISCUefXCK50Z+xAYzydt3neNCFiBOugEL5lKGiCIBWjhKw18D9ujXS/1ZWmbf
	 OHRM4kzJHAcqQqv1MWOqpwxxXnXETZS8V9YAA+RFzZ2qzBIEh2fwVd2AHYjfzfw48YxMp
	 Sq+Ok6aC/iflTB6uuyRhhkmiY8ckIkkl773M4keE5qgk7lKp2ckWKqg3rQZvqXf9Aow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T0t/8Wq/vrRm+YIuBUO3CcjWRs0pKCVtmxYogO0N+A8=;
	b=Ray9CwtpQbvjFk/A4XLZFodxwLLrJ2laAoNESHmN9mFlRYqqqdadNtOjsSI8OHnzYCCA
	 5Od93T+GdpijIFzYqLjs+QNFJkmGx90A0oOsrKosZglFwxwGNTvA6TPhXqqHTMags1jcb
	 d1v+FzuVQq6Ih1Hlb5P1qhPB+a+hbs6Zhvc7WlkSnw4qtsS+K7BeHQ8z6bbXbX2qoDbbF
	 c49GEf5hLD1o5edoKdxzQu8n67l0glb8e8UB03NTFLBfeY6p52GQDNw1u0E7TzpANQpwQ
	 06+zmkZhyH5k/LHgsMR4FNwjsUSal25g9Ys6j9LSuBEH3VmO1OM7nlN3SSW3r0vCPpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRL3JAg4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRL3JAg4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429411F0089F;
	Sat,  7 Nov 2026 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047594;
	bh=T0t/8Wq/vrRm+YIuBUO3CcjWRs0pKCVtmxYogO0N+A8=;
	h=From:To:Cc:Subject:Date;
	b=PRL3JAg4oRSk0Nm8++5PDXaErh0i1KzLw3y20TEDUO+ddKXWTUOeeD8cMoWvH0U3r
	 a3uI5Xu0FobbPWzDYGXotH5rPUBIcNNq9YQ+whbnXEWFXs5/hrqzUYAAQFLBH7ara7
	 LiryUwcveyHzulVFR/IPetHCrFZ9lVxXEn33VB6VkD5ia23tTlr27roR0HJrevbJ1W
	 7rc3kpXUpWGRAgP7LGA2v0cqT34pRrz2JymbRPTmQcHgEPoruw16eiHq3rZ2WrneMS
	 xbTbSasD+EEHMDEVrsvh1AwOZA2xDwnVHtZX8Czfwl0u67uUveZLJXeylHQ57IzNQk
	 Sd5vo/GnLAkoQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:13 -0500
Message-ID: <20261107053313-failed-6.6-6f165abe2b40@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6f165abe2b40ede71c98956cd74cd17c18505e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053313-failed-6.6-6f165abe2b40@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6f165abe2b40ede71c98956cd74cd17c18505e75 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 17:09:56 +0000
Subject: [PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in
 dmabuf_exp_wait_released()

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
---
 drivers/xen/gntdev-dmabuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 83b0df4608941..df1883aca850e 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -96,8 +96,10 @@ dmabuf_exp_wait_obj_new(struct gntdev_dmabuf_priv *priv,
 	struct gntdev_dmabuf_wait_obj *obj;
 
 	obj = kzalloc_obj(*obj);
-	if (!obj)
+	if (!obj) {
+		kref_put(&gntdev_dmabuf->u.exp.refcount, dmabuf_exp_release);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	init_completion(&obj->completion);
 	obj->gntdev_dmabuf = gntdev_dmabuf;
-- 
2.53.0




