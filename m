Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2478376469
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236889; cv=none; b=RTZZOafBRk+IYbhSJprOTPkqn+Ps+0ilzT48pq9+ZGUOtP8cIaVMQOY0e+5vZxcP0c9x3oq7yJsL3fDN9v3mRVm9MLTjDqu42Mm5QmM3Lc8I/1qavPpdbPCAPPeMSyrHyOiMf30ZwGUyCH1mm9DgHkdSn2SSYYkTEPlb4t7d4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236889; c=relaxed/simple;
	bh=dV+uC884kSprOFCdChGfR5OYmUzEDISEVLzPumt80u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia0BHbkOLNdqPK9k/tHPOrljI/P2Y8V6N2JQDQOHPAlfYcUxlfQzrKFiwHJwwmVDoWCsxwlMsg7a3ivfOwfNefGWmm6urAJhLTcB4OeN71O0EuMrh2eEng+l7EUDe7ahXBYgJTaIU+1DxhX7B4EnubLptUg6MePL9yXnc7B91zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThAWDTDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThAWDTDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0811F00893;
	Mon,  5 Oct 2026 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236887;
	bh=c7F2xd6Fuo47AyUTd8hykHOlFcbycEAJDowAhEpt13A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ThAWDTDgCqd/6z1TOyJ5xUK0NmrSiKNKB5tEw/YNoiXcw6nY6DUX9hrqvUilbVPaU
	 cBKwDu7QcbIr2F+4QsDickqc5ZmtX7GfKADjQBjpOaXRk5g8QYxyJdzWhY3GJXICtQ
	 bs89enJ1AQDMJ90CjTs9WHX0b+dpv6BQf1SCiBa0TKPaBtE8NV2iuwdtF2a1AsxF4d
	 4Bvr6FMWo1CsDGCUou9ICqmEl8plY+LWRTAUpS/EwYfHkmjq9VGZR5bMCoSR3JaIyc
	 lUcEsooJzVmxtTnDSa5CXPFfnR8Hs6G4TJQoa5FllXoCEJHlDc1PbLfKnsZpN65kDR
	 MFfzj55M9y0Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tty: vt: fix memory leak in vc_allocate()
Date: Mon,  5 Oct 2026 17:48:03 -0400
Message-ID: <20261005214659.3376947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100541-capacity-sliced-a54b@gregkh>
References: <2026100541-capacity-sliced-a54b@gregkh>
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
[ sashal: Replaced uni_pagedict_loc with the existing vc_uni_pagedir_loc field name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 30be40d3dcffa..474f6abc900b0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1161,6 +1161,8 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
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

