Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033A582BA3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971238; cv=none; b=LQL1tCvdcRlGFYnXyJnlichgFQiydva5JKGGpAVeRp9VyG/bd5jdtRm//6LxK/19BIth/mDKuoU51aTH5U4Sr6dQje0vnr0LxmKtrZdGEycy2pRklyCosWvcBYxcgrD8h+/X24dOImX87c+4V8EjOPHNmqAtjFdU0wjtUz0dwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971238; c=relaxed/simple;
	bh=wz9d9ADXQ4WcErXmk0K7FYuyJ6a1Zk4TMAh0cqLbk78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+BY0GmvocuCQTdlMuXkM3a44I33GrrNZR9IPcff6noGVCJS1mMjY9QLzbbE0/w5cKKCWaiL7h9QdqwuAV0EQySzfAGZmof2tF+dGYOak5QBOALVtIKgqX3+bBlQ0326w61bLEKf+94ZQ2T15j217JHzfCNl5DNeCxusA68BVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbz5qaq1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbz5qaq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFC81F000FF;
	Wed,  9 Sep 2026 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971237;
	bh=aFrLuBGGLkOc2tZTWkJOWE8D+LOojQfZWbRkBiZvPpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hbz5qaq19GeT3Q4Ct/38ZOiYryDM5Jkr5D0B8Q3BN4gxnnDfVB9CvmtwURg5315zy
	 LwCKGrtcXyd92/8wnxQ4qOs6V9LnnTzf0LZzaIiPRjLQlD7VCg8Lkf2sdcpj+NweEy
	 EeELlfNf7eoeHTtzUU2+JfEspIxk13kaF/r6LFhbGI10eRkk8+DGdlmJK6+4azcitX
	 uVjwOFW3wO1aJpLUjIxVCZhl1gPHDtFwMvQStZotsLkOwoTW2PtjAKLYqhqw1rfOQv
	 QCNn3cNzG4Dk/gLdCfkYdGC/ma+17KFNDnQMpl5SQHQvvL5vB9lhtRL4dZvuDOkKKB
	 VN0yrdVsUsAqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] lib/string_helpers: Add kstrdup_and_replace() helper
Date: Wed,  9 Sep 2026 12:27:11 -0400
Message-ID: <20260909162714.2984324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-duct-salutary-5524@gregkh>
References: <2026090342-duct-salutary-5524@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 045ad46441a1cf2ff358af0126f8c57f337804fa ]

Duplicate a NULL-terminated string and replace all occurrences of
the old character with a new one. In other words, provide functionality
of kstrdup() + strreplace().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230804143910.15504-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 54745d563114 ("platform/x86: think-lmi: Fix current password length check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 8530c73282692..7a1304f71f644 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -103,6 +103,8 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
+char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
+
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index df3ecc167ccf4..2f975395b49e5 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -719,6 +719,21 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
 
+/*
+ * Returns duplicate string in which the @old characters are replaced by @new.
+ */
+char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp)
+{
+	char *dst;
+
+	dst = kstrdup(src, gfp);
+	if (!dst)
+		return NULL;
+
+	return strreplace(dst, old, new);
+}
+EXPORT_SYMBOL_GPL(kstrdup_and_replace);
+
 /**
  * kasprintf_strarray - allocate and fill array of sequential strings
  * @gfp: flags for the slab allocator
-- 
2.53.0

