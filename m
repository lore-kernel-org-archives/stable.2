Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B23FE65F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657087; cv=none; b=MvWuw7qdW9WVTn5Jmau8BbR9y3LJwM7xlNdCfcdMysZhv5r20nuVUADY1I3+g/JKtkNbltDIBae1BxOCM5xLrzNCWd1A01vO54GOTaao83bmvBeu/EkpNadYxAhhoBgKCd2d+uO6mopieunrxyd8TiZay9LTcFLVmwCrMoNCh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657087; c=relaxed/simple;
	bh=I35jJlAaQBwjWIINqmBRPv+Qn698tFuBCjDXBhzvKCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1hkH7YNEOJGl0bYRK8zKe/EGwDAyykGPpPPOGa0dXVhLScLjQ+WlfHETZhHaWlYDbHfeucQirD/AhyMVO7VUrGYGqb+eK3XFu3kaOyK24+MxMupvNxxc7c4GypC8l1ZNl8BTgeR3Hm4AZfBzKHeQtA60/D/+w0d+OR+EPkSTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkbVZcdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkbVZcdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FF1F00A3E;
	Tue, 25 Aug 2026 11:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657085;
	bh=MW+Ydw+OjMSlhnn9jIeC0ASRx6uEJ2wBzcf2joli24Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkbVZcdJP20Av0+Ni3RuIZ1uY0hGn3UZXvH+Z48Li75Wtvf3C7dFbUpXYlF8x3n8+
	 DzKtorbVQtKb+CPVMW+lLi//jM4HHOpLWmStM6JSB+ajiNcoxLZuQTKRDJv1nXsA+S
	 HoEabeQsTiIq3Dkni0Y+Tjh1+6PGsBXLDs1/o6yokPvvqpCcgU8yXdvV+71+X4i8n+
	 +2olINVUTRMCGOTTbgcnF1P2cUsirk/CNYZNUsNQgXNbeqTmlszVNj26lRySqkv9BK
	 qzdoF90URzKl7jQUAp/JFzpE8J04+zKIqxX2W3whbJt1BjV3zaxLOMiM3KoilsSeqf
	 sqbRyoXzbofTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/9] selinux: make more use of str_read() when loading the policy
Date: Tue, 25 Aug 2026 07:24:36 -0400
Message-ID: <20260825112440.3543785-5-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 01c2253a0fbdccb58cd79d4ff9ab39964bfb4474 ]

Simplify the call sites, and enable future string validation in a single
place.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: subject tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/conditional.c | 10 ++--------
 security/selinux/ss/policydb.c    | 22 ++++++++--------------
 security/selinux/ss/policydb.h    |  2 ++
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 69839eeadc38b..4525627c28e6b 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -229,17 +229,11 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
-	if (((len == 0) || (len == (u32)-1)))
-		goto err;
 
-	rc = -ENOMEM;
-	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key)
-		goto err;
-	rc = next_entry(key, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto err;
-	key[len] = '\0';
+
 	rc = symtab_insert(s, key, booldatum);
 	if (rc)
 		goto err;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8e0c368e5f4d0..6cc865e3fdfcc 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1079,7 +1079,7 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -2466,24 +2466,18 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	rc = -ENOMEM;
-	policydb_str = kmalloc(len + 1, GFP_KERNEL);
-	if (!policydb_str) {
-		pr_err("SELinux:  unable to allocate memory for policydb "
-		       "string of length %d\n",
-		       len);
-		goto bad;
-	}
-
-	rc = next_entry(policydb_str, fp, len);
+	rc = str_read(&policydb_str, GFP_KERNEL, fp, len);
 	if (rc) {
-		pr_err("SELinux:  truncated policydb string identifier\n");
-		kfree(policydb_str);
+		if (rc == -ENOMEM) {
+			pr_err("SELinux:  unable to allocate memory for policydb string of length %d\n",
+			       len);
+		} else {
+			pr_err("SELinux:  truncated policydb string identifier\n");
+		}
 		goto bad;
 	}
 
 	rc = -EINVAL;
-	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		pr_err("SELinux:  policydb string %s does not match "
 		       "my string %s\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index e7a6f1a6c1461..d95a3941f327c 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -386,6 +386,8 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num,
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
-- 
2.53.0

