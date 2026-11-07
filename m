Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049419;
	b=yf2P3OlEMpWVYIRTGvlEVGB7jbveWtPOdi5zHhGHHtQ3s4tWzo6knXbXIKXtdUmhFzXO
	 9YgQj1LeSu9iGJiTGmOIv7yxnAYd5JeZNyBCeVxsr1vUdj33x9VJWquSzh/SwaJKHtW+W
	 tLhK16FOQ8n83bzx9SgN/VwdRWqrDnTWMgYV4lPKzjFbOHfFKe1g2b+lwtY8Kc5cABZhY
	 lJ4TOD5nGypN4onW2jFr06kzF9nQN76qj5OrdDmPXzr3dzyylKK+vlN+OugD9Ghm8U5U5
	 L8lUdQ13zk0TK6TBb2XHeHhuX8ECTaWs2Rd23+jRUaMZEUgSwtrgLCexJPCT0fXt6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RmLD5LW+UaGqRU4x8fpwjLPUjPCLhp4bMHDeKsiU5fc=;
	b=HODK1x8g8B4+rjvDFewP2A2r15NBg7yH+aLBlnQqHhzrPf3S0KszMVRBnKC9QzCSqhie
	 Apx4sVu1sTtOwLshOLGEOGfSC4xrU2vDbCjmHYE3IpL/lbfRtbyT15mcghu94D1bPCzwX
	 nxGD6gXejuLo2v3+C5sN/EN8BoVBq5PWaRUoDXaAbbgyl1Ai6CMwF9SEs36nrkswwN84J
	 gc/wZVRmKCLbzy95T7rEocNWl672jiHEFMUbOVTXNJ+fPgcVZ3mBEwVGn9f9GfDDPTUlL
	 ge2IY6c8QRcYMS95QweRz2JFoCW8NKCKvDYPsUImH2mqJerB9HCAjn2Tb/kp54rs2Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuNWOxUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC49606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuNWOxUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CACD1F0089F;
	Sat,  7 Nov 2026 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049418;
	bh=RmLD5LW+UaGqRU4x8fpwjLPUjPCLhp4bMHDeKsiU5fc=;
	h=From:To:Cc:Subject:Date;
	b=ZuNWOxUz+tJXg/Hpo0mbZPBg6UyUGPP6PSBHdJ37OdkOoYbmML94oVadv6G2e0afG
	 tK3ops8EZ5s/x5mnelCnKDCmSVagkzY5YwCEjMa4wqMOqG7IadYeVSvETK4BaAvPL0
	 Q7DAqDs8oLhn2TTqjWh56BuQs+Ka0rlMnu5jGhNDmy/vFklJLq6Gak4AJFfuYnoeMz
	 J6s4M8ORPV1+E1jxuOzjYA7TzT7wGOCeGt/ZbXXfgjr5TxZFSNZ2y7hNUBXleyrYsF
	 cJgNm7HwhkZ1/wvGbSCio+zCpIi2l0eDXxcVyzff+9gF0c/3BvuhziyL9JAFitxr+g
	 q7PwyhzjpJ6aQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:37 -0500
Message-ID: <20261107060336-failed-5.15-6f165abe2b40@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6f165abe2b40ede71c98956cd74cd17c18505e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060336-failed-5.15-6f165abe2b40@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




