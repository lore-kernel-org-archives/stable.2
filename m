Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633A4DA9C6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591026; cv=none; b=OrlJhXlZCmTdMjxu3MCms5kJCVSC7bRJzyXgEbPfWWqq+sjy7J/D6dJ9GykOiAXSsPlPES6l6SknKitOjiRTHp+A0XLV9bXcMUpqEjDpTl45xdY+mJ4lKUqZ+IjC/hgMSEJfYhk46rLOrvISHTMXrrDWBPcfMOf+UBAjlVANNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591026; c=relaxed/simple;
	bh=P2QX1dsD5PzsfLufuw3FYRTARxHLHRrb5v6p87XPkjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWkCvfR9hSt8XDsNKVyYI5Cm9P2hXQlktCv4ji09tqrwdb9QbU95TVLwI4ETDNkwDHwLsXviwkFgm+bE3xBNXO+wKHPhCLCbHP80z7gBcTsX0lvn5bIIAZ26rW0HrBWLwvouYJdO/xz5LJ0nBNjXzydLSixf90ZTFCmhutSDsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw9FztmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw9FztmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3A91F000FF;
	Wed, 16 Sep 2026 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591018;
	bh=jvBOCPXt44Cm3J8yvjalOFPoF0ummkhN/cUociWTXBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kw9FztmKwRk8BGiAossWJQ5XCP5EjqZBO1ChaMUE7E15weeEeGc9GhgrJd6ZCr8ou
	 OIJTK2wEzcq8dQBd3bMV1/q83x7qOxa69zyd1pxJ0E32BJrKXsM/roBjnvWwXmneLZ
	 RkWmqHvOwV+D8x84S9vZIxh4PNORXAg6BPZBBhdvF3Z0Py5nltDgY6CanT8O00111M
	 t1wuOMgBEaJYQggSvbMEQmmIcNDytC9gBa2zCUGGrNA1Kib/M3KAfSGuj2Id4rgl9U
	 /SgP/K/vnJZNogSLvmmLMQk4jbb1W0yozAOHCu1qA1kqMS6e/2E6Bp6QPGS3Wl9//n
	 eSAg9rtZO/lXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot@syzkaller.appspotmail.com,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] ns: add __ns_ref_read()
Date: Wed, 16 Sep 2026 16:36:54 -0400
Message-ID: <20260916203656.2689289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091657-curry-myself-be92@gregkh>
References: <2026091657-curry-myself-be92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 6b053576edb12c7739ea9c7c9900031361922631 ]

Implement ns_ref_read() the same way as ns_ref_{get,put}().
No point in making that any more special or different from the other
helpers.

Link: https://patch.msgid.link/20251029-work-namespace-nstree-listns-v4-9-2e6f823ebdc0@kernel.org
Tested-by: syzbot@syzkaller.appspotmail.com
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: cdd812d0683d ("exit: hold a reference to thread_pid across proc_flush_pid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ns_common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index f3c52904343e7..08ff44e631456 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -156,7 +156,12 @@ static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 	return refcount_inc_not_zero(&ns->__ns_ref);
 }
 
-#define ns_ref_read(__ns) refcount_read(&to_ns_common((__ns))->__ns_ref)
+static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns)
+{
+	return refcount_read(&ns->__ns_ref);
+}
+
+#define ns_ref_read(__ns) __ns_ref_read(to_ns_common((__ns)))
 #define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->__ns_ref)
 #define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
 #define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
-- 
2.53.0

