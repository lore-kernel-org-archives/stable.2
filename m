Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046848;
	b=tB04hRFDylk68AkH2BzBeQfZaTsW1x/TW5qG3LPR583+lOi4Bn/Kdfnb89b40LcIhiO4
	 tQDGmajR9ioYpGaMqGaUboX8Xm5Wk6axNJeDcFfEAYsYRqpalH+HlJPqJv83EBct4SHvL
	 hwl++0DIgESxrqHuOIoiFeKPXMsKZutwJRI1xSWLL/1vEGcUs0J2NTw4uUbpIFOcDpGgE
	 riQOTw1Ti2gE1OuEaZJdmTbSejbqdkGGgWPRK4ZzaunEjiHt7lcin8W24CmRuwGhyLnaT
	 RXBn3aHwvU9aTO0vsdsekF+qMxO5QvnYSlqfwb4G9DKfH0EjfHK/fAj9jBOdtlCe7qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4Kbi9p1kmhyB9/CPi/HkvhOIsUl1lx/iZOGEW8X67M0=;
	b=ZSXo4bKSLsFEeSruYawGvnKmaO9oIV+MSa/qdvDWUOCJQoSZZrgF2hLgmvWKhNZuNQt1
	 5k1+yT4Xvdyht/qRIt4EDuXgOWzpCPZkMdu6fRB0frPmYonSNi1Mt25bjjhFZh6lnh1DH
	 PsdaJWaRPgW2XI1W65/25MhSPTcOemA9xSem5+aDHAXrIiaaBfohpIcFOOCGv3SCLhQl/
	 F4y7nShQBHaW9LNdp/edZty1xU0qru4LN9RHZVZIdXEsW5yVkPVDCArrtJMf9eS1qaQHy
	 n5oKaTFycXJc2HS8kE71f80OsbiETCFKFrTdJC5j63WSWwGfLgEyvAa4lP1Wg8MnAsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gosfayl0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86693606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gosfayl0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FD81F0089F;
	Sat,  7 Nov 2026 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046848;
	bh=4Kbi9p1kmhyB9/CPi/HkvhOIsUl1lx/iZOGEW8X67M0=;
	h=From:To:Cc:Subject:Date;
	b=Gosfayl0Y0cmIDLejqMZKB/7GA7edGcu54GHHhDBplLVsrk1xxvOssseLqPZKeKLg
	 2Nj19kPzD9akzu4/EBuYnQUIKOXZurrXpR6RpHa0C5f+qbIlVlIDZFKgxd0W+g/rGD
	 VqUGODaPGrdwaPiV90pgrduymIJJ0Jp05YaAguBU6YjB2H4vMX+2iXltHHzvoLMw6s
	 4Ey2dvmwMDPerR3r8R2y02tXV6vMHwaNGRvugjuYVui4zW8NPqSNCcVXHJJGzFhQDa
	 juxqP+NoS52Vg1OHe2E24B5O5Asn5yjBov1h1lH/eBHPf5eDixM6ux57Njjp6Y+agg
	 Fmm96fKFONdMw==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:46 -0500
Message-ID: <20261107052046-failed-6.12-6f165abe2b40@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6f165abe2b40ede71c98956cd74cd17c18505e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052046-failed-6.12-6f165abe2b40@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




