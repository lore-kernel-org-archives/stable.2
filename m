Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365007;
	b=Su6uTLcLOmeNXW9WcT6eZoAJaZ/RUIBpR9ZojyYSM+p9Y4K9Dd/LKcGxfcZQ/fik3lVY
	 NPqy9uknk9rTcrKlHMnqtlXST0SazTKJ2Yy4JoBK5HYwL3Evawkqu3x9U4SLyx7jffvu3
	 MgnctADtkz3yRSnJwxtfdKL6noOFQbJYmnz+xIHUz804hf3d72aktZp7q3jYdoMOt+Cpi
	 gzxxsOX5xOUoNw0mWIxIVF2SVjT0edV30iqq3T2rNPodZnzLDpas8kp9DyaUi0Pe+KBPP
	 mf1UNbBxdjSDk75vy6/wOBbfu8ynnKxJFsi0LuJPviK/vZnrw9po+58l1wZS+zqK05g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iqexURt2gdYvXDlmAvTKLAhUDpgkyU0PctS4kbXx2t0=;
	b=nlTZDoCnYy8nqhjbavSN6fTE07cX4oeVTKFPnVY4lSWUug5DXDjSJThtRAZZnwH1IiF9
	 tEZ9wwESUT8qOt4mQDvbuGgRRhFTvAalpBJVWnl57OgaibxkcCa34NAtfW3Z7ejEb8vTz
	 5r9Rx+DFO/i6/WYyUa1O0zs04CvYk2u1aR8SuTvGybSUlftWWQcqDlGB7n3SszTjOoZko
	 4FM/jlwenM8Z1Ok4UpXgT5+CszlqgfbM+qW8KCJtDqRRco9T9zr/0cWh27BKHnr+w3rTI
	 E5nhY3fusClK9rOMDbjqHbbS35wX4RuKPiPuRM0sUdx271Kx+tV20YmCo+k0mUJHqZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOE+BBLi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C5606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOE+BBLi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C51F00A05;
	Wed, 11 Nov 2026 02:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365007;
	bh=iqexURt2gdYvXDlmAvTKLAhUDpgkyU0PctS4kbXx2t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOE+BBLiqVTGxTk2X8lcDIACyR4YUBEZldBqBEHVG4QRzbx6GkMxr2dMySZeBTtSE
	 HnWbarJr8Pb8frXyzJ8Z82VA80cMB8dAKoypTfa4ZTKNCH/GdH1WVcMVIKC3AzAF4l
	 Q7qSuUK0fa7Urq27rWzBkMCp3gwBCuewUeyHTB33/jae5c+Lvu3wZDC0x5DyccOBr9
	 w5HiSbH6f5FulBpftFGDeUzKmEBg9McVWPHktcVyJSqw6+kZUcJwLSb4Mh7QKTP2Qu
	 bGqGao69Ykj2LjKFOiu65TYc1YJQehZHWIuKdSNn8t2HF8RvZkr/PF+F48nEYZsUqJ
	 vC276+NtIFOaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] fs: provide accessors for ->i_state
Date: Tue, 10 Nov 2026 21:43:21 -0500
Message-ID: <20261111024017.675599-4-sashal@kernel.org>
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

[ Upstream commit d8753f788ab4916341d9fab81795be9f2f49c264 ]

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled.

If ->i_lock is held, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state  	=> state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.

Finally, if you want to atomically clear flags and set new ones, the
following:

state = inode->i_state;
state &= ~I_A;
state |= I_B;
inode->i_state = state;

turns into:

inode_state_replace(inode, I_A, I_B);

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 8ee09f597763 ("fs: rotate inodes whose page cache could not be dropped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 349b7fc57db36..09cbcfbf295f6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -759,7 +759,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -843,7 +843,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -904,6 +904,80 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	return inode->i_state;
+}
+
+static inline void inode_state_set_raw(struct inode *inode,
+				       enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_set_raw(inode, flags);
+}
+
+static inline void inode_state_clear_raw(struct inode *inode,
+					 enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+}
+
+static inline void inode_state_clear(struct inode *inode,
+				     enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_clear_raw(inode, flags);
+}
+
+static inline void inode_state_assign_raw(struct inode *inode,
+					  enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, flags);
+}
+
+static inline void inode_state_assign(struct inode *inode,
+				      enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace_raw(struct inode *inode,
+					   enum inode_state_flags_enum clearflags,
+					   enum inode_state_flags_enum setflags)
+{
+	enum inode_state_flags_enum flags;
+	flags = inode->i_state;
+	flags &= ~clearflags;
+	flags |= setflags;
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace(struct inode *inode,
+				       enum inode_state_flags_enum clearflags,
+				       enum inode_state_flags_enum setflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_replace_raw(inode, clearflags, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.53.0

