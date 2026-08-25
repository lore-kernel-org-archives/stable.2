Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C37485CD9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670585; cv=none; b=M9uMPgxJHujasHL3/VgayZYCwRR+0yWbxDHSWVDK+2p9iAsFOdryGT3/w2UhEFDOnkYXBf4SW8BZXqDEbXqBE6ckpphODOr3WC4AgGpSsGVBZ0dD8evy0RhbcQFTNFYcQwkfWAok+HnA6JCnS73P+JeLONxb+MpGrNjHgOIVd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670585; c=relaxed/simple;
	bh=SgH4cRUaajW97LW4DVu6lG2C3p0i5wvBrzADtRkng4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHmU+YM4i2ePzaX9zCathN/CIySAXMBewBcj95JMWjEpKmVBTZdbY3JCDTfm80WTVDtMWMiPVHfOs4a2nlOhLwE4iRkTj0BFOMbbipnsVdV09FE8GuN8kd5W0TUhTJALDbIVNYkri8iAFQtxf2ozpIVNNcaE/ZIKyfrRwPAajVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKNpJqfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKNpJqfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C69C1F000E9;
	Tue, 25 Aug 2026 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787670581;
	bh=X2XXOhRGoT+163dalXBqwu0qhy1X5lF3xW1EWIepZWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKNpJqfR5l0vSqcVLpSI9hgWQQKKzSc+w/r814Cla5eEcVToLB5gTX3lCPMK6DRHw
	 DiOma+xzb9MwSVxvLPQUqf2CqLRwtaCot+x9YbxW7/HIauRYw2vZq5DkW2UjsBEFGl
	 B66+XOSqk1A9TweNNlVwZy2XRXUMHKEfTbYKsezY/1BvGJI/TdmCJkxBjVVF8byw66
	 aAQKzrhLpyt/ST5KDXVR6MOThWPlUBv9wIJcYom1XzyO2CN6XmQKdOiGO3dNEaGHZW
	 k75CumSD1VpRPG2PEwZW+Vm9EXpw6LfHH4v64fAMfOTmrN26A0WVvpjOrrLNjtlR2Q
	 ibLU58zQW7RGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] selinux: reject a permission value exceeding the class permission count
Date: Tue, 25 Aug 2026 11:09:36 -0400
Message-ID: <20260825150937.4024395-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825150937.4024395-1-sashal@kernel.org>
References: <2026082022-lyrically-condiment-ea5e@gregkh>
 <20260825150937.4024395-1-sashal@kernel.org>
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
 security/selinux/ss/policydb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8d37adf8608f3..20a9b7a3c204c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1126,6 +1126,12 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
+		goto bad;
+	/* indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
-- 
2.53.0

