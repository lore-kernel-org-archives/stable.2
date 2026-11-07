Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050418;
	b=K6EhaPZV7qlW6d4yBhnqgoo2LDg7nRVmFubtuu5XgsltGwx62T1FPzF/heqwugEbI8EO
	 UDp2wivdmtIx+hN8k88kgvnFycWxT3z93SRwA8pgU99KvP5+S2LUigJ9BSHIbCMKBouNu
	 0FFdG+xDfaPoGCAnbMqOZkFle8kDaDO6jL/sh2+Ff+6hxXZY6xBWmGDKT4w0QrtfwWZC/
	 TagejEJBLK2nU8bjuF/x7Hwf5oQPAo9xNb3DgAyMiQWKavKVnLgXFb0VyBtrPGseI9VLB
	 cXEmyoVbawf5Kmny5da5oLREXQ4XaE5m55/NBCdzWQ8oIhPPhDG+9C2CIASR9M7Im9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050418;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FRZ1m3OmQdGyagoD5B+YW9RWOXK/qmt6OoIpSriBSV4=;
	b=M5b82IM6XANQf2yPQ6ALbtc0/Rn3BN351bWbq1sYZLCSiMQxnlzdF8IO9w8VEx1h9tjf
	 EY95akZufjKdc1m6GsY5ff6PwTvp97qgiL1XR5brFq4XHkk+RKRDZE1FsmYGlBzRw9GHe
	 aNylKwejzBUIr/h4wV3rhOJKp/1KbdNlNoDJ2SPhUD1RtLFPw6AZCe8b742EwULEYnwT2
	 4f3YDBEu+I8kdqTzDYfDQ55G9Bl0SHJhQzvD7+HgSW9wEfJ9x7rlhDINLIlN7LfPNV/tw
	 msRWtYkI1SP9p00tpfYDV08RBShOkJb4uMPttH2CjIVNkRGaKfDBTzjUaO4SdhamV1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjWyE57b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F1606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjWyE57b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0EA1F0089F;
	Sat,  7 Nov 2026 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050418;
	bh=FRZ1m3OmQdGyagoD5B+YW9RWOXK/qmt6OoIpSriBSV4=;
	h=From:To:Cc:Subject:Date;
	b=CjWyE57badduhu1kAf1b+WvojAwBMAY5CEow9Qcq2e+cj2ArtRjr12TA307hxu3/G
	 Ych4p7ji+P76J1GtRHfIpQftjgjCM/o8evNqZ92F744aHbTtA8Rs2oOkU3cZMMyacb
	 oHuD7kVTnIb55GvCDEA/cUQ7zGPhFAIXusef8hgS908+4c5hcOCKeyilExH8HbZ5EH
	 kpsZ5f2cd6BQHY0Sts6LotyqmTpxSKojgykS+qMdt1s2kf2LfNsaS8P86YFRK0cVIb
	 plLn2FWs6aEf5pamW5b3b+rA0WTPIGSwUgWNW5rAJ+qXW/oS0f/gSFYzC6VAaPG2y0
	 xiglaCOWd83Vw==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:16 -0500
Message-ID: <20261107062016-failed-5.10-6f165abe2b40@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6f165abe2b40ede71c98956cd74cd17c18505e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062016-failed-5.10-6f165abe2b40@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




