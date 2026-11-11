Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437023;
	b=PDO6IYf7ML/CjTBrKdjLd1PUje6BhYCo76bg9mPrrGoO7VGJVKDT+q93TXd+8531/NHq
	 1h1EUxDmcCBF6o7xNTdRz+pVOE0qR/cYQ1uBFliCg1JnxxYjUkV08ZvxpPy2E3KFy2Nyy
	 DbFcMBe/on0dHJLq5Tvp1B18l3wHAU00m/9solOPPI9ImJrA8oRQtbMekdORLttFqNtwQ
	 qlUfoxMQizoB3QBncMnd46p0E7S1ccjHri8OCdC1nqSFAcVYZ00zxGMemPXjyvy4hcAvx
	 OZBAsgvJkFesdjZYOWxdGQ+vfEiE+2aH9yWogJqAc6iB1LBJW3hCurz7NaPnZQP/SJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B0A0m0f4aU6W9cFO2fuQeLOjLXsdMm9mUbsKPBMWDpI=;
	b=gS6YQMDEix6vaiDnyZKE582InrwbhciCM5yP7Lqdl1Ge7KqNdDppg1fytjN5bNmAaGlD
	 nYiMLFzztQap3Fw4t3n7kkoDnWsD1QOrIr4t4hUx5WAfHSj//TRFvKJklAzf+FebTurIh
	 pf0140HgCvz+nVecmpVmu0XB4XqALjtW1CEE2fiiCQVk4hEDQb7z/5C679Ms3Z3g4OZzw
	 DCMXjrVfhJDdBtsKordg89Zqo9HLNtM0hQHWYwWrAe3pTR3a26NDq3k7UlcNxx2Wuuv3y
	 eFwEXmw1/brfaSxWLeGBYKqnhc2uHwDAskXcfgCQh+2ZBPPJqPTabVsMWGetUkiJ/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLFF0rRg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED3606A8B6
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLFF0rRg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A391F00A05;
	Wed, 11 Nov 2026 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437022;
	bh=B0A0m0f4aU6W9cFO2fuQeLOjLXsdMm9mUbsKPBMWDpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLFF0rRgVDsDl1l693ia8eC7+1btSSDvIdRtw8Z4Paq76qYGTh+vehgCViYN6e56G
	 OQpJRlbWK7xB68LmSlZ5iSxFCi6rcwr0V8v1F+5pG+CTaPjQSTv1kNmtlAIS2ojKGD
	 X9S5XkAPe2km49V1qXMAXaC1g5XP1C5kVY/K68MTJXcMNscOsHVMl8KFKYFA/e/6TS
	 2r6my8MnB4YqljMGOoZyTHxsZ2dcHjsR18KUCNG8i2n8FNTTH6SwI97ugLb3mPTEil
	 y6J57f2TQov04EF21Z2EbBCjQE6crlP22sUt2AQ7fqxyM48lqt4Irqiw5nk7dhIorH
	 gsRrEoTadsA/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] /proc/sys: use d_splice_alias() calling conventions to simplify failure exits
Date: Wed, 11 Nov 2026 17:43:36 -0500
Message-ID: <20261111224250.73064-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061331-failed-5.15-eeecea75ece2@kernel.org>
References: <20261107061331-failed-5.15-eeecea75ece2@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 1eae9a47835ed4703055afbb3c52fef6d07a8a4c ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: eeecea75ece2 ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/proc_sysctl.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1a22aa43e740d..7f7ffbc9276c5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -522,13 +522,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	if (IS_ERR(inode)) {
-		err = ERR_CAST(inode);
-		goto out;
-	}
-
 	d_set_d_op(dentry, &proc_sys_dentry_operations);
+	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
 	err = d_splice_alias(inode, dentry);
 
 out:
@@ -686,13 +681,8 @@ static bool proc_sys_fill_cache(struct file *file,
 			return false;
 		if (d_in_lookup(child)) {
 			struct dentry *res;
-			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			if (IS_ERR(inode)) {
-				d_lookup_done(child);
-				dput(child);
-				return false;
-			}
 			d_set_d_op(child, &proc_sys_dentry_operations);
+			inode = proc_sys_make_inode(dir->d_sb, head, table);
 			res = d_splice_alias(inode, child);
 			d_lookup_done(child);
 			if (unlikely(res)) {
-- 
2.53.0

