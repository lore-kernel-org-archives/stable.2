Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046193;
	b=3jGiJ/LMIuGfrP7gXpf8BZCJnxGn+hyxcSUSWlphbIP4pdEnV5RYoWraUmZwJPotUfG9
	 NzMWExSXtf4b0xIbVwKkDv0IENi3VSAx0nmiOBBDCm71OFwEiMVXzAd5qV9zsAKIKfr91
	 u2Ap4UtJ9j+JTGOr9a5/ORQzoeWbHClL97Wvlfcribk3yvRLvQ1tFzuVrtaOpY4PM1fzD
	 werBgaIlcaJjiHj0scCjjF/BAiyj5hhZ8lakOmxTKi635WJBaZQi4G/MzzifcX4eDBU4a
	 2zpuzgnHjREIvo1x608lnm1skuKHSxs+noSCSU13u2eB/2x+cv0pc0hl5R4bSEKtejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IQrRChSq1iao58pmH7qetjL2NCx6dvkA5n950ka6amk=;
	b=bh92ldfXQrsJGDOzhVQ/qBwux5p/G07NSicQ1j46G2DoDVLES6DIkqPiZ/NXHRqnQM0T
	 qVaxYudGayRI3bR/3gutWZkKWYqCmQJaSvdc9un5C7lO+rDI2ghXXFi97o/uMk3MGYY26
	 yvGsw0AxIvC6IK6r+AusWVZkKBf9eTBjHDMJI+yneMYGobJy4zvUfSHKsgB44u9Ti05M7
	 3wbrnWPFk/0kl8yeUBE/uDy+9e75low92Y595V+bx/SbxPhnSq7h6JTW/KOOXhBrjZUVn
	 mQOCHXyGZTUmDv0E3rpLGTNPPJ8IUrkwvGaXAhbgQvLJG4BY9EDeIyzC9/kTa4Fy4Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE8dNRBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE8dNRBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA251F0089F;
	Sat,  7 Nov 2026 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046192;
	bh=IQrRChSq1iao58pmH7qetjL2NCx6dvkA5n950ka6amk=;
	h=From:To:Cc:Subject:Date;
	b=UE8dNRBM3HhI58/Juv0xygAhxhd0x9rBG/fT1OWzFBcXoBNGh4dGBKCLpKqLow5Lv
	 9Mt4VPdtlqB4BMb4Z9ja149UP+B0p/rKaAD4BWGfgQ4veotqlJzX3DpkN5wudgt4WL
	 ubjtnaeI8n61qOCWNerv9sZAmTC4mEDGfrWjKOPLQ13CU8HWokyuDDDIPDkbkZTibZ
	 sWONe086ckvHLgmKE3jZgUHiwtY5CJLb/cbqNWgeRnCuUmOZeTBPyvCT/qLMy8LasL
	 8tuvHnciLx09EmNvRu2pe5+aWxr2oIRIJ9XazzTQ2j2B9zgvQA4q9CUIsM3T3NJtzL
	 3KK9bWQTmiDGQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:50 -0500
Message-ID: <20261107050950-failed-6.18-6f165abe2b40@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6f165abe2b40ede71c98956cd74cd17c18505e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050950-failed-6.18-6f165abe2b40@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




