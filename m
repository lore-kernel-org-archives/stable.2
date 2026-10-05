Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C938228A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234252; cv=none; b=scsTL0Cx1n3UGW4/ag9gxlv+z6bp49Okvg8zgByuGnJ5sm7tCwFtKKdTipsaEvEPgHLH6YflOwEtvjpvl/rn2/BiWFxZxJlcXZymZ4w8qg45KH7XSBp7A1hZjp/jj0YICbZwi5zKjHpt3gX3FPnJnnss4/LnOLw2JXUVt2y9luU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234252; c=relaxed/simple;
	bh=GqENyHzUgMbXKlINYnRobWBPCuWfQb3DXxBVjcrad28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZFZUwyvqJ9+7qzWxwNxuDx7F3dwC6LzOUxUHYlCj+5DGIi0wNmsf9hvVi4afMsZMXoYZgkt+rwSK3oosA7VjCC6+aGTZ8p3FDLDFqDdni57T3FodIe90tQP4EA1N6YMyvDtRJBa63WdvnL1lxs7T6L5rTImLA9lx4U8Y1/JN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBHYaFyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBHYaFyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF3C1F000FF;
	Mon,  5 Oct 2026 21:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234251;
	bh=IECixjPv27gG4PzL5lvjm6gcgiW9+nqGZj9g7L9BPik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBHYaFyUeyoai5Tg0uMd3VsXvCGsmGGptCsu0oas2v3mP8zANFIfGY2aKXcjjlN+g
	 Ct7+j7vmTTY3G0sUanLk5XOldOTVZGGyK+rfDEq8xf3i0XU1iEWKCUQrdLq3rRXbMn
	 rKJ/7Uhjh07wzZ6kw3p68XaasW6z3kcuLbYxe0rtocz6VU526D2jA2FnovX++2L39F
	 iuqM317jJ2ORGdSdFyNggq+KYsCqziIwhGoJEmtCUxsK6WayfmR3FT1/YPcmMIO+il
	 wNSDuuFZjAq+fyuJGPnZ3DWiVM6Gwag4pM2K8r1J7/psHy4l2WXqY7jsuF2dNhrjWv
	 H424lOO8nwnVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tty: vt: fix memory leak in vc_allocate()
Date: Mon,  5 Oct 2026 17:04:06 -0400
Message-ID: <20261005210231.3279008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100540-disbelief-sphinx-4c6a@gregkh>
References: <2026100540-disbelief-sphinx-4c6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[ Upstream commit 5b114bfc1dfd88f9d50822d532f7f1fce0f7388a ]

If the screen buffer allocation fails in vc_allocate(), the error handling
path jumps to `err_free`. However, this path fails to release the unicode
screen map attached to `vc->uni_pagedict_loc`.

During the early stages of vc_allocate(), the unicode screen map is either
newly allocated via con_set_default_unimap() or shares the default unicode
map from a previously initialized console (which increments its refcount).
If the subsequent kzalloc() for the screen buffer fails, the err_free path
frees the vc structure but leaves the attached uni_pagedict with an
elevated refcount. This results in an unreferenced object memory leak, as
the reference to the dictionary is lost and its refcount can never reach
zero.

This issue was discovered by DevGen (an automated virtual device modeling
fuzzer based on Syzkaller). During fuzzing with kernel fault injection
(failslab) enabled, the fuzzer forcefully failed the kzalloc() for the
screen buffer, exposing this error-handling path leak.

Fix this by checking *vc->uni_pagedict_loc and calling con_free_unimap(vc)
in the err_free path before kfree(vc). This safely decrements the refcount
and releases the dictionary memory if this was the last reference. The
explicit check is added to maintain consistency with other callers.

Fixes: 34902b7f2754 ("tty: vt, get rid of weird source code flow")
Cc: stable <stable@kernel.org>
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20260803144556.163856-1-25181214217@stu.xidian.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Replaced the upstream uni_pagedict_loc field with the existing vc_uni_pagedir_loc field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 124c1e5875629..187d42f61426e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1160,6 +1160,8 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	return 0;
 err_free:
 	visual_deinit(vc);
+	if (*vc->vc_uni_pagedir_loc)
+		con_free_unimap(vc);
 	kfree(vc);
 	vc_cons[currcons].d = NULL;
 	return err;
-- 
2.53.0

