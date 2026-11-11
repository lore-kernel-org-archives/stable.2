Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356767;
	b=qXcCIpbKl+Ze2y8+pfgf15+9eSH//ZcS7Z/VgaZYaYgmKawsEIj46vDs9GjVzEAWazpg
	 FC2WqZoDwPTenm3q+eGH2sPSWxKIKKCUboObTBWbf/QT/HX8uvrZLGn15QnUhNo98yV7E
	 UtUxM7S/Cr+b8l2iaWDAApzIMMB7Lu6Scx3Vm3O3ZIr8c+Bzr2EYOn2SXlFZKHymWV8tS
	 yIsVc+mZOqW57ZaqmjxklxKCe1t+BOwj9RqFZt/XAopHCasDbsFwyqNKkPFecfeI7DINb
	 goZ+X5QQl8t6z4pKwH0hEigDAf6xQevzFoCWmpJX4tkhOdl3DewFduTrR/fF+wgoRHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PCjIWuc0VWpQkw6vOx/bUK+eJ+5cygz7dQMaILfWO/Q=;
	b=2CYyWv9w6HNco0JorjntqPGq35fQvku6K3yJs9FxmaokFHum7igZmh0raNjqAeq8023Q
	 q5nZ+ZUDgPLsyNY9GVP0EM2nsAv5FQoTWZ68eRAJupuhkhvG4V39Yy9o9PHLRAOgiDMEp
	 spZNa+gBeZWf+mGCJ5u6JecABlLCmkA4DzplX9agwexRoPtLEb3KSWX6G11hwQIqVqucL
	 IlIYO6CL8VeelE1RNeIUp2kPLpDTYOMSU+UBX30U54bZa+AWhNr+IoL0SkOiOdDmT0kzl
	 UQv95VaDBeLDBxHaPAlkGvJAtw2MmBDZh2zZeDR2o2fcK+pE65ehqODtmGlqO0xGcjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzqPKv0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BE606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzqPKv0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0B81F0089F;
	Wed, 11 Nov 2026 00:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356766;
	bh=PCjIWuc0VWpQkw6vOx/bUK+eJ+5cygz7dQMaILfWO/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzqPKv0yEw+YKWKrCfz+vxCbz+MKK+MHGu0/jZAFJWdeQ6XEetEhYPWT3j541LulK
	 OvHt9Cy8EqPJcXh7r523LIh/nQsvkanWMYybKNUi2/Bs3125PqJ3kWZ31hQ4+36LJZ
	 xie6eGZMQNproNMO1LgQ1S14pFto8e9oG8H0iz0UoF9KBVfr/9ANgUe86yCEBA6fLd
	 soqIZy2fuSdeumSPjSY/Boj6wY3xIUSkpVGpJLSeg8m5xabBu+/mwkUrBA0QLVGQfd
	 T3Ll037zMx2r3n8i2bDvahFYmBi/j00oIZEz9sI4HIR4PLfeUwAgeoaROHLObNtjZN
	 bIX8cT73jEiZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
Date: Tue, 10 Nov 2026 19:26:05 -0500
Message-ID: <20261111002104.251573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050950-failed-6.18-6f165abe2b40@kernel.org>
References: <20261107050950-failed-6.18-6f165abe2b40@kernel.org>
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
[ sashal: Retained kzalloc(sizeof(*obj), GFP_KERNEL) allocation context instead of kzalloc_obj(*obj). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 550980dd3b0bc..5d38506a14f44 100644
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

