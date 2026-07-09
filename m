Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AB2701D9;
	Thu,  9 Jul 2026 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571636; cv=none; b=Z+Wtj7FFpL1/sRga87LMoh8Q4vE3JEqkwC+W6IS1MFAzRHEB8C6HiNG2bkzd5OcZIDfTGRubps2plXKMmnUhi1VBQO0cokCaO251cwpYHLx7pIn+qhagrMm3VxrZYmN96ED0NPyc7iRB6G4Yb/fDHNBP2icJ9xBXGAYJV6+0r9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571636; c=relaxed/simple;
	bh=Fas1b13nnVIQkYCq0E3IRstIGlX4bARpJwkw54JiFoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db9Uux2ABFvwKjBB5rTF6+JVMYPmnStcHryb3MI6wsC1PlLpaMzZlO8+5iI4FKMaZzwfI7RUMT6i0LGpXd43W3/5njgdz6Qzl99wd6KN3Zd6dInrO3gV2QzJ3Vk1wTbjv0spID43Mo7/JcWwKb+j5WS1Qb+QnlYzpBtVyeAN+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaPJAkW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaPJAkW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505CD1F000E9;
	Thu,  9 Jul 2026 04:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783571634;
	bh=y2WHAtBaatjfsi5telGPC1FZz6xh8mijsU27GNez8Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BaPJAkW5H+gdzPNMfjTrildmnYmY94TnHG85imdoVi6ro7DlpHHw9Xa1favbbYNoC
	 7Ksr4wd4jDs7xBz8gwwpncJpUnKjC9fShccZU8FwtDXEaZxatXKQE9ZLYeTONwivvI
	 tWGxm1fIQA057g0KIeHfiLS4AqsV2djnRchzvLNFjYCUFHe1RW+0afk80eB7nBQXJL
	 4xWLxgy0825xs4+3OgFa3Ghls7LlwsHhuDefTe3f+kmM95K7poh3GkNnDsYFFnM1/u
	 oyxCMtrOpasFuBloX9lDT1N2vvihGoBBK2fODzLqsRqUtbJ757+Yqn0RHDIYN8WWTx
	 on4b0G+lPd09g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 3/4] default_gfp(): avoid using the "newfangled" __VA_OPT__ trick
Date: Thu,  9 Jul 2026 00:33:00 -0400
Message-ID: <20260709043301.142931-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709043301.142931-1-ebiggers@kernel.org>
References: <20260709043301.142931-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 551d44200152cb26f75d2ef990aeb6185b7e37fd upstream.

The default_gfp() helper that I added is not wrong, but it turns out
that it causes unnecessary headaches for 'sparse' which doesn't support
the use of __VA_OPT__ (introduced in C++20 and C23, and supported by gcc
and clang for a long time).

We do already use __VA_OPT__ in some other cases in the kernel (drm/xe
and btrfs), but it has been fairly limited.  Now it triggers for pretty
much everything, and sparse ends up not working at all.

We can use the traditional gcc ',##__VA_ARGS__' syntax instead: it may
not be the "C standard" way and is slightly less natural in this
context, but it is the traditional model for this and avoids the sparse
problem.

Reported-and-tested-by: Ricardo Ribalda <ribalda@chromium.org>
Reported-and-tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/gfp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 09559f7126ac..647b3db8a757 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -14,8 +14,8 @@ struct vm_area_struct;
 struct mempolicy;
 
 /* Helper macro to avoid gfp flags if they are the default one */
-#define __default_gfp(a,...) a
-#define default_gfp(...) __default_gfp(__VA_ARGS__ __VA_OPT__(,) GFP_KERNEL)
+#define __default_gfp(a,b,...) b
+#define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
 
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
-- 
2.55.0

