Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048383;
	b=cCAceUQ5IGqO9tHr9iW4oPPsAGtDSvd+iGMHI0PRpIpT5QcT+DerZmeO4sR5RHuzrOrn
	 3mSYFTN2JSAtLuSAL1uqQzmIDEY2GejWtHhKuG2l/9Vs7kGvypuoS0KBTtu+ChgDEe5Ct
	 WGBfrDbwvC/cPCZsxowQI/EymbeCv91lKtIvhyge2b13k7VOfbauUaWK/CUDJDKaocHH0
	 EBFjykOZ3IpUFkSJGjkAXPuAHkogEFHDSpBoHIhMKt5eah2fNSYPLejS5YHqyzwqKnbwP
	 F1yaLfdubFiKs6GwLUsWTRCILTWP0FaeY2q1ODSj4LGVY3xrmKw8bk8/Kovky/hw57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oh3G9cs+mjPUeQutabidoaalZ4hjH45izJW/B6oEVmE=;
	b=teGO5lAGtgc0K8jFl1DxB6qx5m+jJQwoWIk0KwSJ2w+yf5zL1WoTfnh0xpgbgYzDP7jp
	 fIIEtHt7UcdDykQbu7rHKku67bf50b3MrMxCOyjg2HgxxNcsqHuUg5NwZXGMT9aPLwhTi
	 GI3SVWPlKRgVO2SnoxYUVZ/u2dI67Mjsz1Gud57HrDNW7p6K/LJ7ihorKUG03NFXotirb
	 VmfGt7+4dwB1JgrfZ0JV7AUiQp0nbgirTrXhVBoqyy40HWpEVZUlsE703Z/8C9z4ZgJVt
	 typobL0pJIABqZyv3qJ1g5/3efaL4pU2MwpgaoYA4qPYMmesWlOM7Rl/VOQRq5ZqxdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHyH5ySX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E835606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHyH5ySX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805C51F0089F;
	Sat,  7 Nov 2026 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048382;
	bh=oh3G9cs+mjPUeQutabidoaalZ4hjH45izJW/B6oEVmE=;
	h=From:To:Cc:Subject:Date;
	b=LHyH5ySXhfdsYT+4FEknY7aA74xAM+YbKFsH7Ol/HqdPYSi5lFssDjZ7N1xjST4yY
	 migOeKip98J1pKdSnm8ScwDtNOsHosdTCjZ5mC0UkuMtsSnlTTvemKQXm0CeB3Czj1
	 i01CIMUSJoSk1V+CdUw+MBy8ktkqWqpOVO6Xb8RMsaZavDd5LKuF32js7IE9y/vx9V
	 6UeG9B/wNnUj+w0G284JyYZAFieFc02kv3se2mnEhfpD/TDS7DrDkkJOH1HEm0cpx+
	 DLZO0I14inKno+JZVSPwksxwk+VVUwoh8psR2eo2OREqJ8JzASAD1oGmB+3jab6ZWV
	 6v5+9CwxUROwQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:21 -0500
Message-ID: <20261107054621-failed-6.1-6f165abe2b40@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6f165abe2b40ede71c98956cd74cd17c18505e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054621-failed-6.1-6f165abe2b40@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




