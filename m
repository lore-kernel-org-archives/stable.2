Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506340;
	b=EaIvjx/9sXpyhdDrH2QB8ZxP6/3DhZj2daH6V0xUAQIoRoNxvQvY2yVIaC/0quQRU9gT
	 u1VziTBS84xXN3CXJ/Te54Mw1tsiCz0We20hhN3U0O0Rt4CW9oDWjZLf7nKL9z/oFk7mm
	 1xcTQKTqxw+Bp2tBVlqBy22e+zU9ETp9IK+ym5pmhGkXNUYJhXNaTm5wFRh0TZupZOp/M
	 A3y/HV4WQC9wR6QCeaqQb6XLmKi663/Zux6IgdVjTEq9C8yhQCxZVa2Jr0cLK3xLW14+g
	 dckAqadk0if5V2NL2TR921PN9IHNVgCj7k/1wWRrrfRKHRb12S2NMc4jNXrTYwzqvhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8h82BZn/dr8JnZ5jrgrsVJGvd09onNJ58+84IX1QMR4=;
	b=jHvhDKMXFEy5vwRESJtsZsX4ZUDffS4xL38ZhWNjmTCRM019l9tXQ53WuXF5dBAheEWq
	 5djHr4KRtTLDJRXrsdXV2WRmpI7WgH0uvhfaSS2nxt+Rwci+/CxodhLAif0kr89RAZDzl
	 qk425XAdwtFZ/nF/GduYMKkQN947ZqzwnTudPPm6H4UjyFl8VqDU4gjKw+GmwrTGfS4mN
	 T5WrDo0ovvOrtuGnCbkJAECA1JP3gJyEzsUQtHzI7fyNdtxrKZlI0Xocry4fBxKCR2jdU
	 t/+EHw3qtDvAgxknOzFFVGCyg/YxsN5YQqjqb3+9LTqX5EjK8RWjJmjuTRZfQGPtMoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgrgAwt7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426D606A32C;
	Tue, 20 Oct 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgrgAwt7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAFA1F000C4;
	Tue, 20 Oct 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792506339;
	bh=8h82BZn/dr8JnZ5jrgrsVJGvd09onNJ58+84IX1QMR4=;
	h=From:To:Cc:Subject:Date;
	b=DgrgAwt7Zcvj8WpF2TAf/dkFE1xWtR0+uAzzYbs6UPdda03mSB73vc0DLuPhR2XcM
	 3mLtt+7uOgvvU5l2yM584x1htDJWZRQg3qqzC7zBY8ME7PqQTZLZwCEe9ZlAUAJo/7
	 LiRQLDzqCU/rwwgW4ZzjcwlCH1NWVkZJ63IXNG6p6oBq03BmvgFedd6njfr+Z3ZQXy
	 42BlWomZFQTwiCduGsxvQhTsXSM/UhoSIXbPHI6Vi9Pr0lJ2qutvmiT95QjkbuGXL3
	 1fEsGNnilMxHSZVj7sm8ArjeY+Mqo8UYY9U9wjk0aEf6jTuiEU0ncSlAF3+AsCiRG/
	 oH8zEnJHjz0Ig==
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>,
	SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4] docs: stable-kernel-rules: drop rules the stable trees do not apply
Date: Tue, 20 Oct 2026 10:25:37 -0400
Message-ID: <20261020142537.3533510-1-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

The stable trees do not apply the 100 line limit or the exclusion of
theoretical issues, and they require a fix to be correct and tested
rather than obviously correct. Drop those rules.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: SJ Park <sj@kernel.org>
---
v4:
 - Split out of the agents skills series, where this was patch 3/7 of v3:
   https://lore.kernel.org/r/20261016152828.3765695-4-sashal@kernel.org
 - No other changes.

 Documentation/process/stable-kernel-rules.rst | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index edf90bbe30f43..625c1b5b0e16b 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -7,8 +7,7 @@ Rules on what kind of patches are accepted, and which ones are not, into the
 "-stable" tree:
 
 - It or an equivalent fix must already exist in Linux mainline (upstream).
-- It must be obviously correct and tested.
-- It cannot be bigger than 100 lines, with context.
+- It must be correct and tested.
 - It must follow the
   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
   rules.
@@ -24,9 +23,6 @@ Rules on what kind of patches are accepted, and which ones are not, into the
     regression they should only be submitted by a distribution kernel
     maintainer and include an addendum linking to a bugzilla entry if it
     exists and additional information on the user-visible impact.
-  - No "This could be a problem..." type of things like a "theoretical race
-    condition", unless an explanation of how the bug can be exploited is also
-    provided.
   - No "trivial" fixes without benefit for users (spelling changes, whitespace
     cleanups, etc).
 

base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
-- 
2.53.0

