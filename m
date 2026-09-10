Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC63264E7
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003052; cv=none; b=a7tUdTphPSpZj3XbxyBgHUEF60LL+YVoxDknP7KVUbUU7CS+2hwNqp3j1M2URyJgxVwGIC+FIvnIM/9Y/QEyDxbcjFuArOrsmM8nYWw0zq0DSCp7tpvg+6wr7DhTM80EPjh074Cp6oJQDLLb7dnFi3y2qWB0LiTiv/3hy28sFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003052; c=relaxed/simple;
	bh=Im69e6wD/UB9J8ZBVz0I6X033hK5Lv2anifvHaqDKnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6ATCyiGbmOCvNMkV1J0Gd/8NWfd6HmisMbGrqZv58iPT+a9N+2G3vQcGtHtLEQOqYFjFun4ihGy+ift8yfIoimMjFfjeO7ZEU/8fhPYLnMNBhA4mLkmDoE7qW7Cu/K5P0ZEiH3Kp9BjnXMKQyXIscFn0UJiZxeICnbEwB3CEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr1pbyO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr1pbyO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD711F00893;
	Thu, 10 Sep 2026 01:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003044;
	bh=Sx9rKqsgh4CrTDc/xYPcFOPE6KivZxrHOuBBVrtjWiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lr1pbyO1s9Ky9HOOQ+VgU9+FG9yxxEr2Y2MGNrskEu0M1fcU7fXaY5EYUNu5ibDZr
	 DG7aKHqPdxgpUpwpRYbX3UUGB8bNcg1vUIn3HkujxwbAvrZ/os07romRvgTqLFyEZn
	 uFxVvj+NskiSp+BdMpuvWLJGUadGQkAwBYqnHpkgs7Vr8T7kXzCcwS/6f943bzkeNN
	 g3iwWBN36zKLWjTK3ncuw3gWHbUoGxzytfJqwk0EbFgWlY7Ok7nxYXG6nu58xBfuCK
	 fd4D1f4c3IlmeqeE988Po1pYPaFvVcHCi8hZcb7VxBqSNbeR5cYdQz6wLfzYaAiQdT
	 /rVeaKeYouxyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francis Laniel <laniel_francis@privacyrequired.com>,
	Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] Fix unefficient call to memset before memcpu in nla_strlcpy.
Date: Wed,  9 Sep 2026 21:17:19 -0400
Message-ID: <20260910011720.3832737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090426-survival-bush-ee14@gregkh>
References: <2026090426-survival-bush-ee14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francis Laniel <laniel_francis@privacyrequired.com>

[ Upstream commit 8eeb99bc81bc1cb3d5e5323d9a82d8392e3a27b4 ]

Before this commit, nla_strlcpy first memseted dst to 0 then wrote src into it.
This is inefficient because bytes whom number is less than src length are written
twice.

This patch solves this issue by first writing src into dst then fill dst with
0's.
Note that, in the case where src length is higher than dst, only 0 is written.
Otherwise there are as many 0's written to fill dst.

For example, if src is "foo\0" and dst is 5 bytes long, the result will be:
1. "fooGG" after memcpy (G means garbage).
2. "foo\0\0" after memset.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 1f58a5335cdd ("taskstats: fix cpumask parsing cutting off the last character")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/nlattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/nlattr.c b/lib/nlattr.c
index 247426c0af0dc..e08c4b12510b4 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -756,8 +756,9 @@ size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
 	if (dstsize > 0) {
 		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
 
-		memset(dst, 0, dstsize);
 		memcpy(dst, src, len);
+		/* Zero pad end of dst. */
+		memset(dst + len, 0, dstsize - len);
 	}
 
 	return srclen;
-- 
2.53.0

