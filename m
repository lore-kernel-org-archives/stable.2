Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EFF25F98B;
	Fri,  3 Jul 2026 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057595; cv=none; b=rfzcR8A45kGFkvXB6F0k2qmHM6djIl6iqu8liA6uFzuL2rltwTtrp97iqcBLasz4lKc2Y3CtNxN4yEihvo7LVZLYBjdneDmV5efx756+rVjhJwCkQBIhCQVOAjM8lebe0P/EgsfpaJrPLjFxhzYjUCridfFNKy5VGpGqBk7aAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057595; c=relaxed/simple;
	bh=sh/5zGlA0WUuN495BdKCGL/BODmybOL2yKAHhGA20Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoWbnh/e92alnRnGEJSb98PVVYHmyMPNyA+OZjK+jK1tHOmkLyZBfEzyZ8kKtcRTvZnYIMutmQ1JeIXqBHKFLHdt61RcjMyKvbyCBdEk17x8iXQFnNc82AtNUAXUwzlq8qYW0oYzJb5jAcNey+xOIjjvPwCpQkK7Njp07D+6Wf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=k/drh9h6; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="k/drh9h6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783057558;
	bh=zV8c5o7N6sk+alFXIO5QGl/mhvkJ/DUwwXa8p6aGS8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k/drh9h6W2n4zly2HaTYCknONfAKo37JWIjTiF7giTATbTYaRWoM9O15dz+qzs0Oi
	 aAHDwc0878LN0DiBy7CKB9/z/lK0mQH7wyAcWztT3B/vMEx2ApLzPCKVzp3xhByJLj
	 Qy3SzWgroyJQtL3eqkT5HG3qNUuDs7DwxFmWB5bs=
X-QQ-mid: esmtpgz15t1783057553t98765132
X-QQ-Originating-IP: 1PWfI3hS0W7mTEdiiBJ8js4PKfbceMoLQg7PlUrbeR0=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.72])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jul 2026 13:45:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2075363408098552017
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fail attrlist updates when the superblock is inactive
Date: Fri,  3 Jul 2026 13:45:28 +0800
Message-ID: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MzpxdqdVeN4RfsEjPdAwmN6ZEIEUE5bUrr7rygLNs1eAo3EWoqWM3QF2
	9yO43GFFzgQQ8O0+Hf1t04ia4oixFHZ8QSEQfKHJ6MEiZzEzXiH2nrskAbOPymSAQYpiEDb
	Y9y+k7J65vz45di3MPTS6Aea1DGBS0pNClvzqrfxAZ8zm9H6DdJqllJaJm2+WG5sbOe6ZvZ
	EoVV8zTk5fAOK+75tGzGSuLado+MGqabGVYgCYX5JY7XPlrXlJLkI28M77eyVb/NSd0L0p7
	Rj6d2J7GQeQtqRzGlcDDdtGlhQCPBvBg+3OF0vroVs4jGQAYPD7odNX88gS1R6K/goJTswP
	0aHT4w39MlHqbdsT9cNyBVTiwG0qrBLATITJtjBOjly7fIspGhVVbhbMe1wObElFi7M7pj2
	8N9CUr5mwUgcqc7pCuPmoNbzm3BYh69k0XWmY9flKVplqWSIqXlNBdD9pYvgoUsTzi2tTem
	xSk2C8L3ooiQfOtt9nqkkqJTQg7Kz5FnCLns7vgSGnO88xqRA+lRe8ktxbWdVo35KgLHkQs
	ITGhMbhRdzjDZBtdYkTcLCEIZupMUSSlAV5ZCMlBT9mL8vtIBaGy4wz5iAwnK0pFsR1rLX8
	ZPM7esVk6NN1d4GJed0OhKU+zRXXbuPaVG2AUOPW4vt2YtKMM/N1msv7m2wckcyoIVDdEvB
	p+UBO8Vg+tJQkMGflKmUV8BScDfvYtYNpka2bgs+D8G7yf7wPoLjfYqKusQf1NFQ140jZu1
	34tpgrl+WnWyo7nMDnkq+drrbuNtvmRJq8z/rR4Mtwk+NedXADPQ/WNYtcFGUbZ+rqBNDki
	z0oYxrtNXC1FatpBqxw57Of0tfvI0KC41IJNZHMgqrzquwxlAfF3/IyMCdjQph0d2dGLLxj
	RzXiq5/EQPG/GcHKahTQdOM0MWgsnDDFCZ2DHrdb+5R5Dw10d4fUzDQtigngENa2p2HHfKB
	WN7ZZa8x+1+FgqPfUHnoOSSQt9JV+U9tf1RXaKLucxQgI4Wu4PaAP2OUl35CT/9cwrlsEbd
	dxZiotrD7AoTrXBqYf3n2y9DtBKK0MdmNOVEtbVFeeaMiA1aUT+VFjDu20HMYdmuBhiv/4t
	0jnpzQUTTEv
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

generic_shutdown_super() clears SB_ACTIVE before evicting cached inodes.
If eviction selects the fake inode for a base inode's unnamed
$ATTRIBUTE_LIST attribute, ntfs_evict_big_inode() drops the fake inode's
reference on the base inode while the fake inode is still hashed and marked
I_FREEING.

That iput can synchronously write back the base inode. The writeback path
may update mapping pairs and call ntfs_attrlist_update(), which
unconditionally calls ntfs_attr_iget() for the same $ATTRIBUTE_LIST fake
inode. VFS then finds the I_FREEING inode and waits for eviction to finish,
but the current task is still inside that eviction path, causing a
self-deadlock in find_inode().

Fix this by mirroring the teardown guard used by __ntfs_write_inode():
once SB_ACTIVE has been cleared, do not try to iget the attribute-list fake inode. 
Return -EIO so teardown aborts the update instead of waiting on the inode it is evicting.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/AB8D5E603E6EA856+ae5f622a-dd3a-4e38-bdd2-42276ae0e1a8@smail.nju.edu.cn/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
 fs/ntfs/attrlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index afb13038ba42..1658cbe1fa59 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -57,6 +57,9 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
 	struct ntfs_inode *attr_ni;
 	int err;
 
+	if (!(VFS_I(base_ni)->i_sb->s_flags & SB_ACTIVE))
+		return -EIO;
+
 	attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
 	if (IS_ERR(attr_vi)) {
 		err = PTR_ERR(attr_vi);

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0

