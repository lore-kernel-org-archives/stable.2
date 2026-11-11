Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365005;
	b=yyLKKsI0bPExFqgsZiiiy+0uSsVsc+sZyAopyDsIVCtMqIcJlOXZ9BpHCDRIOJ5qYnLM
	 x2F/YGthWj+XcuUvTUEedkgmHC2cLxr4RWQPOiDucHET0Z/8+ODSj2+D/B0y3NzB7NK8t
	 PGtFDgk5uSTxcZDll7XVmWz57O2eDHAZuGbgqAQbKSVFrNsZsaM1VA5i2XnDmbSaTpZ/W
	 4xxoPwnJh61pON5/O8plG4ft9O7VNJ2+om5u88ZYMvGC6TU9HT1FKQScNcf5zF6CFGB67
	 RPipivDPK5jp/CSLOku9dutc3iQlaOnqPCFLmdgStQ6fYa1Fo94ph4G6P+Z9XqvHlKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xDgKxlBM5QkUQr7tTRzrpKWXntALm77dyG/Re/ya30E=;
	b=ugXW/BTX+f5cpj4NLzntSWt9I89hJHSzyyqXO6Tu1auImeHtYWD9UIsMEw9UPiif3yvB
	 tNjssTbZAbM1LSif9Pl1UpWiTJCQeLIDDfsjsJ9FSsqq8NjDGE6f3EVrn3CfiIKwRCfB1
	 HKkFtvhaNqzeUkQDayCboHiueLCX7TnfdpksEmgzHugiHZNIV0/eeDAoPGd4FBMFfqXu0
	 L5vNSnJSJlsZ0bx6JAPEbbFAVeYwyHFqDHY/Houtp+PoBurRSrYp7Esg7MEwkj/Zm93SR
	 V3tAnmcz4WGIRvXp9wTIWj3HFmVZHNEAxBryVktSbxpxvIbLwBU0xBz+ifDC9pTafgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu2e6xbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD1606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu2e6xbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148A61F00A05;
	Wed, 11 Nov 2026 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365005;
	bh=xDgKxlBM5QkUQr7tTRzrpKWXntALm77dyG/Re/ya30E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vu2e6xbZNo1ZBW7VVsuQ1jlvhlbnLysLFf446vr73gbSQHZnVWMgnBe2aYRVmH2Fk
	 Wtp4slLJPioEVliGPO6qY4kQgBiiTMFveunOeDsdb3pchTPGH4mFjDTKxum9a9NFIy
	 EZO+H+rSTbvX9nbrutxKPjWLFL6VyKgsJlU6hjW5L1axTRG4m9UDywg4NPO1ygkPo+
	 GJm22PeDehi81wWbfEFMR+GIXw6B5VyclF40EdmfBbBseE9UzI/wiCgD2McDz+c2Lm
	 dxv+dTWRWZhl3SaUaSWaJ+bpKPur221P+qJ9+yHHUtJhzEtw/iHHLs5i1mHzU5HWJl
	 GlgNWvSddrB2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] fs: add missing fences to I_NEW handling
Date: Tue, 10 Nov 2026 21:43:19 -0500
Message-ID: <20261111024017.675599-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111024017.675599-1-sashal@kernel.org>
References: <20261107051338-failed-6.18-8ee09f597763@kernel.org>
 <20261111024017.675599-1-sashal@kernel.org>
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

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit 31e332b911fca54df467d264d7e2a2ef9317f3ca ]

Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
and unlock_new_inode().

In principle the latter can clear the I_NEW flag before prior stores
into the inode were made visible.

The former can in turn observe I_NEW is cleared and proceed to use the
inode, while possibly reading from not-yet-published areas.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 8ee09f597763 ("fs: rotate inodes whose page cache could not be dropped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c               | 4 ++++
 fs/inode.c                | 8 ++++++++
 include/linux/writeback.h | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3ad74a3abf9ad..84952f6bbf406 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1995,6 +1995,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/fs/inode.c b/fs/inode.c
index acf09822535ed..7adfc787e934a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1177,6 +1177,10 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
@@ -1194,6 +1198,10 @@ void discard_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 22dd4adc5667d..e1e1231a68303 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *inode)
 {
 	wait_var_event(inode_state_wait_address(inode, __I_NEW),
 		       !(READ_ONCE(inode->i_state) & I_NEW));
+	/*
+	 * Pairs with routines clearing I_NEW.
+	 */
+	smp_rmb();
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-- 
2.53.0

