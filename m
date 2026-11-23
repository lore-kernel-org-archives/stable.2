Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396943;
	b=GopmGnkCgDMe5mMP9qyzJJkuvDsPE9P9NDJUQijFegM6cAUFnzBT/jkuPDROmfBhsMwR
	 HI/PyyjzUL+5m/w2y3dK2NaBAEg0R8m/JEQk7A8JTjY5xPEMvNAomq/y+nUJAkrvdJDs7
	 5UqtH+dXFOjsBu3TtlloT/CErImZcL72GuJvmPAcGu4pnNij0Ui0kh5g8xdPr2UGlq2yL
	 R1Ol4BUNWelZPjUqqKAYV1HLvYoYK+8PcbJMKmBmTCoNwGfY43iRKNqurg8ZvfD1lSQDg
	 FjzyW4LqJe23jHV+BQmKfE3dAUaAoeKOUyBBbaBu0iWXIZmUhWCFb+MZaXLGckBtkQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396943;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=hTSrzLpFQ4K6bpwZbZ08NkeidSei6B/cgppw/fPpF58=;
	b=dY8YxROAlejU1QqSKA7BZmYcKvJ6xn8oaOGwScMOQO1i007jI93P+rHSha28qTNiKjtQ
	 MGH5qs0GhFHi42f4RAlFBQpr6nCo+6R4Ys6iNakcPgTUzFdn4QW1BvJo8rhTIuHLz8fko
	 1AB8UtDus3USv7Nm99AnBHq7xcBb+oqhdQwDyahCfnwE1pw/Y1JEuxZa02rCBjPCQCG/2
	 cMF47m5Wr1JmXdzTCOqzYGp1omV0jOJ+xwePta93PrSB97wrGbdn6OFRwK+DYFodNQcaQ
	 3xLVWHJ1LPdKyK54cOIcatncXEDsXVgGuO3Zgxi4nph0ShEowNpoa9+BXEdNYvBTf2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10A606A333;
	Mon, 23 Nov 2026 01:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF10A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jXp835gJkz40Rf;
	Mon, 23 Nov 2026 09:22:11 +0800 (CST)
From: Daolong Zhang <dlzhangak@isoftstone.com>
To: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daolong Zhang <dlzhangak@isoftstone.com>
Subject: [PATCH v2] ceph: fix inode and i_filelock_ref leak on file lock rollback
Date: Mon, 23 Nov 2026 09:22:11 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261122193828.1324376-1-amarkuze@redhat.com>
References: <20261122193828.1324376-1-amarkuze@redhat.com>
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 23 Nov 2026 09:22:12 +0800
X-FangMail-Miltered: at fangwg01 with ID 6B039543.003 by FangMail milter!
X-FangMail-Envelope: 1795396932/4jXp835gJkz40Rf/6B039543.003/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1795396932.6B039543.003
X-FangMail-Outinfo: 1795396932/6B039543.003/4jXp835gJkz40Rf/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1795396934.6B039543.003.4jXp835gJkz40Rf@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B039543.003/4jXp835gJkz40Rf

When ceph_lock() or ceph_flock() succeeds in acquiring a file lock on
the MDS via ceph_lock_message() but fails to install the lock locally in
VFS (for example when posix_lock_file() returns -EAGAIN or -EDEADLK, or
locks_lock_file_wait() is interrupted), it sends a CEPH_LOCK_UNLOCK
rollback request to the MDS reusing the same struct file_lock instance.

Because ceph_lock_message() invokes fl->fl_ops->fl_copy_lock(fl, NULL)
for every CEPH_MDS_OP_SETFILELOCK operation, the rollback call
increments ci->i_filelock_ref a second time and overwrites
fl->fl_u.ceph.inode with a second igrab(inode) reference. When the
caller subsequently frees or releases the request file_lock,
ceph_fl_release_lock() only runs once, permanently leaking one
i_filelock_ref count and one inode reference per rollback and causing
'VFS: Busy inodes after unmount of ceph' on unmount.

Fix this by guarding ceph_fl_copy_lock() against being called when
dst->fl_u.ceph.inode is already set, ensuring a single file_lock never
acquires multiple inode references across retries or rollbacks while
preserving the temporary reference held during ordinary unlocks.

Fixes: 89aa59301013 ("ceph: keep auth cap when inode has flocks or posix locks")
Fixes: 8e1858710d9a ("ceph: avoid use-after-free in ceph_fl_release_lock()")
Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/81372
Signed-off-by: Daolong Zhang <dlzhangak@isoftstone.com>
---
v2:
- Keep fl_copy_lock() for ordinary CEPH_LOCK_UNLOCK in ceph_lock_message()
  so i_filelock_ref prevents auth cap trimming while the unlock request
  is in flight after try_unlock_file() (Alex Markuze).
- Keep only the dst->fl_u.ceph.inode guard in ceph_fl_copy_lock().

 fs/ceph/locks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221bd64e0..4d70a0e8381c 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -34,6 +34,10 @@ void __init ceph_flock_init(void)
 static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
 {
 	struct inode *inode = file_inode(dst->c.flc_file);
+
+	if (dst->fl_u.ceph.inode)
+		return;
+
 	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
 	dst->fl_u.ceph.inode = igrab(inode);
 }
-- 
2.48.1

