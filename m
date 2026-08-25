Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261C3B3880
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687289; cv=none; b=IsRoAEZc2GbsCZTXDv/YwE2i07D7WCVmRhPKw5INODYCusHMglgx+8YTjEkLGJalgknZzAub/9YEd/x34Rl+HROQrcOdu/Ykj/k6w1nnSBgIWLBpvu/Cyf3007Sm+RjaRqdR+t1y9Jl595DVK9WVgZg/Gv1eZB1ot8mtDYxlICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687289; c=relaxed/simple;
	bh=MloGKXSTUlsDhMEaxvM3uO6n0LJBIw/NNd34k4WWh2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx6BFWu0KzX0uyjyFyyzVJXMeoAfrtgL6kBPuFCSI0jEn/ePbjWubGX2T2MBHzw/GwRnk7K59phe6CHAL+NJ/4vo97kFprmUDG+mAxLTawbu4qUy7EpeQ5EPFz/aBSdWAXwOFD1uNgjkSFYBbgZCA9o0gXggc0oUck3mn7xPN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzkc544d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzkc544d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D981F00A3D;
	Tue, 25 Aug 2026 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687288;
	bh=LiZ8QvJTNub9vzfc3kU4B2U7KwKVMTTq6MvZK/17EKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lzkc544dNokVYethcI1dGOQdO4xjNsl0gisj0Ugq9Ioc9Xa0kLZnvdgIsANnWvL6U
	 QfGjEDerwn4/dssJU+e7KQgnagJr90hkdAqJ+MTCHrsjnb1clTl7OjJA0leVMCyGNM
	 Egtfx1uADjkZ9q3xR/BuMzbPXyBl9/29C/bxihlvY/0N+UIvLeAlOv+X08MIvh3q7a
	 dG+d/+VB8BbYfk+17BqwyxCotEhx+vkyujsOWKKJvF8XR++Z0ZsrTV4eA1mF2mt9q1
	 qb7Hhjq0PIqF9WK0fxPPcuX23pQh+v1Snw0og8z4D6HOZ/iPxQnr5Z7UjPMzQ0tK8R
	 mGou0nBdpwtOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] selinux: reject a permission value exceeding the class permission count
Date: Tue, 25 Aug 2026 15:48:03 -0400
Message-ID: <20260825194804.376152-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825194804.376152-1-sashal@kernel.org>
References: <2026082023-agreeing-overbook-66d4@gregkh>
 <20260825194804.376152-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit d14b5d0e97fccd27974fedc03b903408872907fd ]

perm_read() bounds a permission value by SEL_VEC_MAX but never by the
nprim of the owning class or common, which is taken verbatim from the
policy image.  security_get_permissions() then writes perms[value - 1]
into an nprim-sized kcalloc() array, so a class declaring fewer
permissions than its largest permission value drives an out-of-bounds
heap write.  The top-level symbol tables are validated this way; the
nested per-class permission table is not.

Reject a permission whose value exceeds nprim, which is already set when
perm_read() runs.  Well-formed policies are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: tweak comment for line length]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 952a9656ead9c..2a73aa201ca5e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1135,6 +1135,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = -EINVAL;
 	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
 		goto bad;
+	/* indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
-- 
2.53.0

