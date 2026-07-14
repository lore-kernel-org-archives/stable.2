Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B746AEC5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036591; cv=none; b=uzTQA8Vzu06v2q8XiEm+etQY/3MQFB8DnO91ay0sFaKhkkliYkLqSTI0fVOBWA6yCt5UPZFfCx+k/YkVgj1+Rpnbq87BqdRTJ6QMObRqgnz6N860CBibifLDgURuzUaqyMSi3BtEWp1AjrWCsiIfitGgh504K32ptb4ENEn61n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036591; c=relaxed/simple;
	bh=TOEpKyEXKeA3waEMJHMBGvi1wp3iihviD9J/HpBFlr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZvhe1nE+Rh9+Z2Tqkwf8NehevHXBgiLSP+gN1hPXdpsIb7L4W8M3qOA5JSVdWoDn+Ow5P20YxIgI1PmC90/eR4Mn1vzgEXgCkzdtcynC+sMYxcTAaf/m10cNgy753j32F0rdRx/LScAdzLClPpa8UzOfOzPTvg7OiTrh5PQ5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkwFBJp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkwFBJp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118EB1F000E9;
	Tue, 14 Jul 2026 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036589;
	bh=8t/SCQ+DKs7U/c23zkuQi2ke1p+ei/Z94AUjOop79gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nkwFBJp0ROo1G9+iAioCfAfhPT89mE1xJe3dojgWU7Pr3l0FZDCY1KByhMnmTqA75
	 xm5ovPe5XI+Whf/HdU+Im7IHnJBPGkgZ1d6woOabLWZ63GL2KsbPKF/uWZlXu5788i
	 ubjvuXe3UGDdUg6kxzvGU5/BD4POYoGjSWWK5oD3HCf8LxtAigTP2O18Lh07Q+Rmxu
	 UaX598uJay+1xy/3gM5s/7KAD2j2hbuuycBDx5yj530I7eOR85IMauWnjkNQRDGV+c
	 rRdixLLCDVRYVAqqYLDb0E122aRu0RUPxhy59E1638CCzYNoYLkHGT7uxuElMMIc9E
	 sQ0XLRN098zGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] binder: Use LIST_HEAD() to initialize on stack list head
Date: Tue, 14 Jul 2026 09:43:06 -0400
Message-ID: <20260714134307.2675829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071307-outdated-speed-452e@gregkh>
References: <2026071307-outdated-speed-452e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 91f818b184b44b105b1c92859ea8d2d6f47912a9 ]

Use LIST_HEAD to initialize on stack list head. No intentional
functional impact.

Change generated with below coccinelle script:

@@
identifier name;
@@
- struct list_head name;
+ LIST_HEAD(name);
... when != name
- INIT_LIST_HEAD(&name);

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://patch.msgid.link/20260519055623.13142-1-jszhang@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b34826e55aad ("binder: cache secctx size before release zeroes it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a6b3bfe0d9b81f..81ebc5762fb422 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3080,12 +3080,10 @@ static void binder_transaction(struct binder_proc *proc,
 	int t_debug_id = atomic_inc_return(&binder_last_id);
 	ktime_t t_start_time = ktime_get();
 	struct lsm_context lsmctx = { };
-	struct list_head sgc_head;
-	struct list_head pf_head;
+	LIST_HEAD(sgc_head);
+	LIST_HEAD(pf_head);
 	const void __user *user_buffer = (const void __user *)
 				(uintptr_t)tr->data.ptr.buffer;
-	INIT_LIST_HEAD(&sgc_head);
-	INIT_LIST_HEAD(&pf_head);
 
 	e = binder_transaction_log_add(&binder_transaction_log);
 	e->debug_id = t_debug_id;
-- 
2.53.0

