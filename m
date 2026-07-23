Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11A37189B;
	Thu, 23 Jul 2026 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835704; cv=none; b=iu2Jy+yRSbFVB1s9vkPW+h0zFOEQAq6oV0IJcYMC7rfV83jIEOooqnWqeGbVIiPmhW4I5FA2ZeDr4TN0P/m5dH7Aq/1r1sMk6HaKDmy61W/S+RwJdO2xZYhZSxkbpZHz5rqSqGt5UQnjIsDm6N0StrW9AGO+sw3Pf8gaIk9tPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835704; c=relaxed/simple;
	bh=QGkr6kMYxTIOGLgPwf9kKss/butys9/PHDAItokYYcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YH5+WxcCb7rPr2dgksiCc1r7oM6KJ6U2O32Bh4wxUgHbXHEW0VkzeaTQKJYHEPaGLWcVLwgVWo27UJPQ6DPrHG5AsbfUvTVMa0vBOEaAun4qSv1SCeendZ8eeNVWEs4iBVZWhBJcxeTc87siYx4BfUbiwMRleIhKUDarKKrQKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZpC1tMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZpC1tMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1C1F00A3A;
	Thu, 23 Jul 2026 19:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835696;
	bh=HuPV/HvdnWZhkNJmLIUMIUrFXjwDSzBAyxtVSe9Qpz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jZpC1tMvdr5yaSy2s51PhAnH3vNv5O0Z7T7NiBnIg77y0LRrwkJP5FIuoXmp/JOtv
	 c9GYpA2j4Q6pSA+TNwpHa6ytP0Dg0Y+DZfPfXzDZCopBevbiXbOI3B3c5oNSkDUDwu
	 fbOxki2+gQPT9t9kzU2e3WFPS6N1FoAHUqRtLt8XMlYz8En3toNr31iLM3ZKqA+JrP
	 UqJ62gZ01Q6t6ucOU2+pNd09pEBDLGmI6v4V/FDCBQk0PxP7G/acdr3Afcy6kCPI6Z
	 C6ixtu2qyvbWsyG2ZXmC65KNVy4pMWqgTIUnY2L24baK4GVinsBdrhanODLoe12Wcw
	 a5IHaVu0WHr+g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 23 Jul 2026 21:40:31 +0200
Subject: [PATCH v2 1/2] lib/ucs2_string.c: fix out-of-bounds read in
 ucs2_strnlen()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-fix-ucs2_strnlen-v2-1-9ea94e32a358@kernel.org>
References: <20260723-fix-ucs2_strnlen-v2-0-9ea94e32a358@kernel.org>
In-Reply-To: <20260723-fix-ucs2_strnlen-v2-0-9ea94e32a358@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
 stable@vger.kernel.org, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=QGkr6kMYxTIOGLgPwf9kKss/butys9/PHDAItokYYcM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlJeTmTa468Trbed/q8jfjGsuJam4iLnTuZAxO+sHz87
 +sZ+3Z/x0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBM9cV+hj88sjzvGr+6VZvtunX2slVLe9RFRZ6NR28vvrPNZqX4wswORobfZ75zMj7
 vXe8w7a/w1DUeZTtOzOW4emST0Ca7VLe/4jMYAQ==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

ucs2_strnlen() checks the current character before checking whether the
caller-provided maximum length has been reached. If the input is not
NUL-terminated within that bound, the loop can read one ucs2_char_t past
the limit.

Test the length before dereferencing to prevent an off-by-one
out-of-bounds read.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Cc: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>

Concerning the Fixes: tag, the ucs2_strnlen() function can be traced as
follow:

  - commit 0635eb8a54cf ("Move utf16 functions to kernel core and
    rename") renames it from utf16_strnlen() to ucs2_strnlen() as we
    know it today.

  - commit a2940908391f ("efivars: String functions") renames
    utf8_strlen() to utf16_strnlen().

  - utf8_strlen() is present since the begining of the git history in
    commit 1da177e4c3f4 ("Linux-2.6.12-rc2")

And that of-by-one issue was present since the beginning and survived
all the renamings. This is why I picked 1da177e4c3f4 in the Fixes tag.
---
 lib/ucs2_string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ucs2_string.c b/lib/ucs2_string.c
index dfb4f2358cab..ca5c615d5bef 100644
--- a/lib/ucs2_string.c
+++ b/lib/ucs2_string.c
@@ -8,7 +8,7 @@ ucs2_strnlen(const ucs2_char_t *s, size_t maxlength)
 {
         unsigned long length = 0;
 
-        while (*s++ != 0 && length < maxlength)
+	while (length < maxlength && *s++ != 0)
                 length++;
         return length;
 }

-- 
2.54.0

