Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38E3F58CA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657090; cv=none; b=iWOIY2WpQRQzHSLdOxsU6C5lz49CGtb4byk0GrZXOMWg7v48Ob+HxSY0se0OZIGnxLIL9iVWmCJ6DMnJR4QTLVXTJlh6b5+nd7VfegHa4vvPk7TzKZRMlFsnR7F2hfFhDDh/8TY1pCyZbSV0hZaKwKk5uy0MJhv6ztMOT2cuYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657090; c=relaxed/simple;
	bh=zPhuH//KVykV8keARhOG/Wvrp0/Ji7UM2p/9YetX9ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qypzby3JGDLtlWbJ0V9yW2eRlfFx5IM5ZaoVsZwiqaZehkn8Ah0dlwrH0ETxargYUiBvRFB0y2/MLgKCOEBTBoaHz5zPlrQVPc1GyZ/559bwTGjeCgZ5sYDVsYaZOgN8l3Fy/JoWh6SjGkAhJoQQ+4zu6XaSVq5RqQ+VXL+DfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLhc3a4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLhc3a4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7081F00A3E;
	Tue, 25 Aug 2026 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657088;
	bh=cACnaovBIB+g9+lXmfN+h0clyleZ/vMdBlfq5bi9Rb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLhc3a4qMsk+ZLcR3+a4TmexBneJKr1ASiGQp7w6IYfsEqBZ/3AtFzA8QZyKiIbpG
	 vZGSslEyyuh37juoP2mrau0pm2Md98w4Tnwcjku/qS4A47HfN8LbjSjGvQj+z3xUGL
	 OxZgDzrNvykz26qgUin6tALK6qcKYSAwor7kr6n/p2nkzzwi7zI3qQNYia+FB/Sb2o
	 CNRapZrVmlGhsMeW25dITv54PXwlJtLkpmrocx1RPGtECa17Ueo61pEStLoGOGBreI
	 n52z9dfev4I12crqXbr/m0+MtvE4QhVO46/yEPLWfg4yieTS40aM57TUMIrUjqmODS
	 70tsKUe4BQY4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 8/9] selinux: reject a permission value exceeding the class permission count
Date: Tue, 25 Aug 2026 07:24:39 -0400
Message-ID: <20260825112440.3543785-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825112440.3543785-1-sashal@kernel.org>
References: <2026082022-circle-gooey-f888@gregkh>
 <20260825112440.3543785-1-sashal@kernel.org>
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
index 6f27c0ccb3468..9bf9327fae365 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1120,6 +1120,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
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

