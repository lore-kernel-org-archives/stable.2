Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C34E1C89;
	Fri, 16 Oct 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164519; cv=none; b=WfDb9fQJ1J7Y+BlJnevO0OXYhUxO1a2X9AMOKA8/IQD11gDBo3CXTdBd7nFnxVRg2n6riU8JWBFpbE4UjdtXvVQDwWHxotNR0Tdq2d5Li+uvCc3o9DLbX/OPRwWh2FOYoHbGGz84VfzGv0ib084zUhxkPsRbnAqm3GNaJH5ysq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164519; c=relaxed/simple;
	bh=oUr328+wrLsDB7p1D8YTU+V8feFz/hxnfpeop3ZBkfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf5pAj6Cei4MrTkKwQlkNUKLYvIP+FopNeQq617p2lm0RDjSjXNjHNgbzuxJFEHzuFwN3M+hx4Wwwi7oP/wgcqG6e2KCrZgAskefjR9xSSd3YrfQbFGmnzhrN8KyXMACpbyNFwuLn75hIDHRQYy1ZIZyMJtidiLKhyKogYoRqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5/bFlj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5/bFlj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944131F000CB;
	Fri, 16 Oct 2026 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164517;
	bh=z5s/NUsEKFHp41RPjYZPkC9gzO3vi+WdUTitqPwbQGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5/bFlj9ksSWtNT21Fia8jk5hnWc6RO4OBvFKv8s7D8wLVqOcCink+Kp67kMqlR/h
	 bvI/3nMaMyTz3+zYa7Iwg2+kD6/XfmNtcXzcKIfw64EVwvWX9qBQCjNV2kROW41hiO
	 fKjBG1xHZYoRbIzNje44Bmg/+Eqgz24UUEd+1OKJiTruuzeyx7zykiz39IGEOw8b0A
	 +78/evQsnLA3O2lVE5PtuT2L7QITvUgxjcUC5kJg+0tSotKSpGy1cS0r6UWxo/Nb9i
	 D4TV7AtlBXCp9Bra0zWSLKC5NX7KDixQSq5fik8RMX7Et/P4yGhH5dbqT8sQ/OGL1J
	 IDAPWkbnoE3Bw==
From: Sasha Levin <sashal@kernel.org>
To: workflows@vger.kernel.org,
	ksummit@lists.linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/7] docs: stable-kernel-rules: drop rules the stable trees do not apply
Date: Fri, 16 Oct 2026 11:28:23 -0400
Message-ID: <20261016152828.3765695-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016152828.3765695-1-sashal@kernel.org>
References: <20261016152828.3765695-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stable trees do not apply the 100 line limit or the exclusion of
theoretical issues, and they require a fix to be correct and tested
rather than obviously correct. Drop those rules.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
 
-- 
2.53.0

