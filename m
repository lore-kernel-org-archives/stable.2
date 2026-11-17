Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929246;
	b=33YPMON9040Z2Uuc3GkiwZ5eyJtvvzUupygArm8NTEkjHvu2bolAPusBsfj5VKwOU02A
	 vhz2cfeOnNs8cYdWklEhkrmxrZdL1mW4oXwjdUXMZyoHlii45JLbqGu1+o6+cpSiYrxwo
	 HfSbaQRxBqHh2dkHgvPX2/BW29yyKmZEPRS3dd81oTswId3W1zygahz0ybwnBS+XIqTPD
	 0hPJvyVwx5NWlTHcg+fH5n5+I++TvbX8DKcMFoDogDfhaBNFZgmCNmKiwGPm76ELdyhdU
	 Y9251nwY8/Zk+kJNVXX0r78ooWTgGyltuFEJTLUvA+4NicheZXWgWmgrxZPYPfT9mtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929246;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mH6goqM3VpE8drlwy+oqVCvHYic+ibrcKyOKfv9dkgg=;
	b=IZF4Ys4/Qi4zmULQJVgbAu8iE1AM8gRrJEfmnDWJsYcrQtlkyufYoxaCJvCQQp0SZ0Q9
	 T4XvHdAakeqc0EJBeiT3zhrkCggr5DgC+PFWPktdgo+VscSHHh9DKv4dcqhEvWEKXHR9r
	 IUtHMsO2J9h1/OrW/UVhJU570MS9y3ZHlN/442ySI3bhTD2MQPmVj7P5S5dQjnsLtJlsZ
	 mO8w2L81Mx3phvoIUlvsNebnhVvPOaIJJR/h81spYlPcTjPht3xwCUdlQ5rADr3ccWaSk
	 8uhHWV0JIw5STXDk2uy5LX6a/eENUZ4kVQsmqUo1/U8SFvKJZbAzqhR9O0Tp8gMxK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHCn5ZsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43305606A31C;
	Tue, 17 Nov 2026 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHCn5ZsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB621F000C5;
	Tue, 17 Nov 2026 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929246;
	bh=mH6goqM3VpE8drlwy+oqVCvHYic+ibrcKyOKfv9dkgg=;
	h=From:Date:Subject:To:Cc;
	b=jHCn5ZsDg03dSYcum20de+TC4euGpUJ3KEDeWpRU1SvqmSZE0IyJLEoPo4Qd11eS9
	 k3RpEbo7E2BVLUFXRtvmVMFUFvl6Ul6u+WLch1TQVPaaDVvaRRGPpDMrLHiKtCSBou
	 4aSTf5JXtphCly2J67jwgnNmX/p80PiCA3ZFkFBJmj7HJBP8jtu4r7In6bOFK4aAGB
	 89chHX7YnvY/GqTTE0WPC11E3bkMdVzVPs175nRf6Qr9z/U7jps2GdDiDBHhx0prN+
	 VL4sxMZhOw8O5W5vgg8NXTrqURGhZ2mik16u1Jh58no0d4MmrX6eByTxY+mBxugul4
	 0dGswvVmetpXg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Nov 2026 16:27:15 +0100
Subject: [PATCH] devpts: create pty nodes under the parent lock
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-work-devpts-pty_new_locking-v1-1-9ad92fc3bd93@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13Myw6CMBCF4Vchs7YNpQajr2IM6WWEiilNp4KG8
 O62snP5n5x8KxBGhwSXaoWIsyM3+RziUIEZlO+ROZsbmrpphRAntkxxZBbnkIiF9Ok8Lt1zMqP
 zPTtraWuB7VEaCVkIEe/u/dOvt73ppR9oUiHLQytCpqPyZihTwfmO8z+clyts2xfvT02SsgAAA
 A==
X-Change-ID: 20261117-work-devpts-pty_new_locking-9b3d01e643c3
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Cheng Yongkang <teel4res@gmail.com>, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qa4zEKoyVCPDC6obAu/jxfzSeA7qD8Kh5EDR3p+d/xw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9KYqou3hB6vj/bSdFli5Nerd7J59MiAejVdDBmal/j
 b6WWIXxd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkRxXD/8Tk9tDZv5/dbjKa
 d+XCo5yNm7zfTmdnd5p/vviBjory0XaGv/JrZufv//4nl3Uzw6et+mLRy3e2hG45mvvJVtBY/WT
 /YU4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

devpts_pty_new() creates /dev/pts/N with d_alloc_name() and
d_make_persistent() without holding the inode lock of the devpts root.
A lookup of /dev/pts/N that misses the dcache holds that lock shared,
gets an in-lookup dentry from d_alloc_parallel() and calls
simple_lookup(), which hashes it as a negative dentry. Nothing
serializes the two, so the pty can be created and hashed after the
lookup missed it, and simple_lookup() then hashes its negative dentry
for the same name right in front of it:

  lookup                           devpts_pty_new()
  inode_lock_shared(root)
  d_alloc_parallel(root, "N")
    miss
                                   d_alloc_name(root, "N")
                                   d_make_persistent()
  simple_lookup()
    d_splice_alias(NULL)
  inode_unlock_shared(root)

Both dentries are now hashed under the same name and the negative one
is found first. So stat() or open() of a freshly allocated pty fails
with ENOENT until the negative dentry goes away. Cheng measured about
26k bogus ENOENTs in 6.5 million lookups while ptys were being created
in a loop.

The parent lock used to be held here but was dropped in 8ead9dd54716
("devpts: more pty driver interface cleanups"). b4a76faf9d96 ("convert
devpts") then switched mknod_ptmx() over to simple_start_creating() but
left devpts_pty_new() alone.

Do what mknod_ptmx() does and create the pty node with
simple_start_creating() and simple_done_creating(). That takes the
parent lock exclusive, so creation waits for lookups in flight, and it
reuses the negative dentry a finished lookup might have left behind
instead of hashing a second dentry next to it.

devpts_pty_kill() doesn't need the same treatment. It only unhashes the
dentry and a lookup racing with it either still finds the pty or misses
and correctly reports ENOENT. The index of a pty is only freed in
->remove() after the master was closed and devpts_pty_kill() ran, so
devpts_pty_new() never finds a positive dentry for the name it creates.

Note that ptmx_open() calls devpts_pty_new() with the tty locked. We
never take the tty lock under the inode lock of the devpts root:
lookup_open() drops the parent lock before do_open() calls ->open() and
devpts has no ->atomic_open().

Reported-by: Cheng Yongkang <teel4res@gmail.com>
Closes: https://lore.kernel.org/20261115163620.225761-1-teel4res@gmail.com
Fixes: 8ead9dd54716 ("devpts: more pty driver interface cleanups")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/devpts/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index bd1e8eb26edb7..65f6aee74fa45 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -521,15 +521,15 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 
 	sprintf(s, "%d", index);
 
-	dentry = d_alloc_name(root, s);
-	if (!dentry) {
+	dentry = simple_start_creating(root, s);
+	if (IS_ERR(dentry)) {
 		iput(inode);
-		return ERR_PTR(-ENOMEM);
+		return dentry;
 	}
 	dentry->d_fsdata = priv;
 	d_make_persistent(dentry, inode);
 	fsnotify_create(d_inode(root), dentry);
-	dput(dentry);
+	simple_done_creating(dentry);
 	return dentry; // borrowed
 }
 

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261117-work-devpts-pty_new_locking-9b3d01e643c3

