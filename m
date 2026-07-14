Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476646AEC5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036409; cv=none; b=cxNByPH33jdrtzAqZ/oCjek6wi+drpfo32fMmNo5tvG9sGRJofwdpmeLDcAjkN7Bya465DAKJ1YSa06VL5IdGhIODshfBKUNvLfKZ+ERd9qmnrFokrpDzrP3T+Mbp9f+MFVp6EDYOGSBS624FInR+5L+xr985X6ei0z04eN6EWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036409; c=relaxed/simple;
	bh=dk8+sxzVrKZnC3pdjINjc3ADHlhhIfgLWSjY2CADzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBNzlDw6YDnmlG4j6IOo8egICN6DBRQCFTZ84s7HCphcY1FF2oiVSLvMvNp+9u79g0Ku8+ouv3V9HiwSRUAq2OBMaaBZSEWgjfBj/GSHHb0YN8W2kstWLhGGmTE4OTiHuEUJ5+T3yQ9HiWiRlAb/KS+r3sAOV03KKXBKtirWIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izgRZWzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izgRZWzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7B51F000E9;
	Tue, 14 Jul 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036408;
	bh=sPDbkxHxgEKKVcB027/gn33SgyACm9HEB0VRRiNhrOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izgRZWzXN/pvklS97uBHkTF9ISuN8gCXNl2xiLToTnhGwYGP+AYIlowIFijc+Mqb5
	 dLcAL8+A5i/p9g05Tf9GWKMH1P6thngNKaSzV7YK5v210zsdhqVsExqYS2EiHWW/eU
	 K5jB2GHtr/fdgD5c3fv+dpa2aC4/IZufUghK5sl78HKm5a3GLw2JLhRs41zoH+DJLm
	 uU8UNxUCTqExnrxgkqK7Q4nDpxZ2ryqNga2noPa0lVtZbT3u93rPg+ZuHVIq+ay5r+
	 kxDHJxP3ex8/eAtv7w0OIQVtY95Z35PYM5fYIS+o2pcSumrtV+F42PfgVoydw0Uxrw
	 +7LpWzIDIQdtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] binder: Use LIST_HEAD() to initialize on stack list head
Date: Tue, 14 Jul 2026 09:40:05 -0400
Message-ID: <20260714134006.2674552-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071306-applaud-quail-8690@gregkh>
References: <2026071306-applaud-quail-8690@gregkh>
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
index 9e619422459368..ec0ab4f2853014 100644
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

