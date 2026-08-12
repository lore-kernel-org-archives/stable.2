Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE02264A8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493377; cv=none; b=uyeUsLkTZKDG/cNwTay6i2l6Zmtv8kuUnrhfN4ZrSAz6Dsi6hR+yj0LB0Kc77thx3IUEMmeSVilaQyxAoD3ur5pgOcN6th9cR4KxpSulDiV2j/QUGEo5UIQnNrFqa8+TQ2MQ2XIcdQ1asR3WuW1Z9t4ZH4Sx/nIRMaAEKmelri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493377; c=relaxed/simple;
	bh=x/Bjn1R4RC9Qik5D+KGh0LIz/R5g1hc/Yyz2faFL12E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMfHPYfmwyE/kisRhyrQHIl3tJOdPZ+gRuigDRWCaG+lXRpSEn0BcUEclmZQpyAkqoF0C2NGxV5qv86iN//lMGbkFYZDtKSGpdD8J9dt8FlINzEhvnBy6NQvowFC0L+RAzkaTBQwxF4BDnqrJMX60JrB7KzikZiNIBYbJv2sDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU27XSRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU27XSRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A51F000E9;
	Wed, 12 Aug 2026 00:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493376;
	bh=Ui2VTlxes18pW08LMNne5iTBXsEajD80XZHsqR80gE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OU27XSRnwJVRWlHmYdV4nAF+6RKJd1qq/Seupe+1+fXy908xDqZgvZs4BkU0GgOVq
	 Cv7DhHhbeXt5Nsm8ypcHEKCbvnvKjiEuj91yfHXfmmegQSru2PIoAByLW5l0+W9FDN
	 z7/LS+mDaPncKXIgaCfWRQnzhBfNBecNSi7YGii0LoVNVqej4fnfxSq8huQ3kdi++r
	 5gkVnVhUlCgPVGZQkS1GY7hGbOJokphz6gSadl7VdBrEWsUsP8BaQx6nPte+lHjPHC
	 jyGJUo9yHnzvzDDMWkM1agtpH2pzQbeyzmQxVyTJ+pBOoU1hXQtqMB8uN78UPmzP/e
	 J9R7FmBDSTG1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] include/linux/fs.h: add inode_lock_killable()
Date: Tue, 11 Aug 2026 20:09:31 -0400
Message-ID: <20260812000933.4158055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080558-upstream-wooing-96aa@gregkh>
References: <2026080558-upstream-wooing-96aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit d8c5507cd140d9471472ece673e70250b957c595 ]

Prepare for making inode operations killable while they're waiting for
the lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/20250513150327.1373061-1-max.kellermann@ionos.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 466a76771b0a1..9d0968ed2344a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -815,6 +815,11 @@ static inline void inode_lock(struct inode *inode)
 	down_write(&inode->i_rwsem);
 }
 
+static inline __must_check int inode_lock_killable(struct inode *inode)
+{
+	return down_write_killable(&inode->i_rwsem);
+}
+
 static inline void inode_unlock(struct inode *inode)
 {
 	up_write(&inode->i_rwsem);
@@ -825,6 +830,11 @@ static inline void inode_lock_shared(struct inode *inode)
 	down_read(&inode->i_rwsem);
 }
 
+static inline __must_check int inode_lock_shared_killable(struct inode *inode)
+{
+	return down_read_killable(&inode->i_rwsem);
+}
+
 static inline void inode_unlock_shared(struct inode *inode)
 {
 	up_read(&inode->i_rwsem);
-- 
2.53.0

