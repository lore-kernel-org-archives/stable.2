Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363924;
	b=pwAVhuKtaccIhwc0p64B9VjKDKLYOVjhBPgFbPyHr++ZFraehsDNbrWi0u16SIc00VhW
	 sB0IkWEdadWsGsyorNliIT4GfJ6/YynH5zCZx1NgerB1N06j4JRavgnlNDCqx4YYUiMkV
	 7x4mx59jpPX1MQ72ZE55wHLO0Ot4de5kjbYZskPHUqNM+7DI7NhYKPBEHvv7CjBJ73ox6
	 gQmg3qvfAbaXfqXmmi/NF+YB4QjjcX06EkeQhzTBeMnfNhJfB+DfE2EPepQOMpddRjB0P
	 i1CPrX5N7pZ3i4ePiCA37doRxrhWO771NqK4REFt+/TvoJXNHirYdNiOTJEB3SvlCGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363924;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EveTgauBKukpDZW+Dz1ddOxtSk6q8JCAmZ75KYsbri4=;
	b=zN/8r/0FAVTMJNgEu8d67KaeLUqbtvxIJKwpnZh7RIoKKWpTGNsvRrJfN3OkSo7ivnq5
	 0BtrLvzwErCa4lC1Cxk8GzDkvq1dDg2UcBn2evZPWYctNS7wa1CEngExibuzri+XgYjID
	 +DS02TFpVEW3RZVBZf9RdScksSQq7OUjEsrQQOcEsvFxgsdX7XNRx5JooI7n9kEl1QM9j
	 +Tl1yNSn2KkuxbPFqQtVsX+3UbInJM+vnoyO4vwuKeLKAPy/1Spb7B/wtltcaXrGHauqS
	 zotnZ/yCWrgrVrPSCYtdiXCqfzLtleKdawTpMXR9d7KlLzsrw9E6V7eIjNWrPyzrxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGI6TE6t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C6606A31A;
	Fri, 30 Oct 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGI6TE6t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554751F000C1;
	Fri, 30 Oct 2026 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363923;
	bh=EveTgauBKukpDZW+Dz1ddOxtSk6q8JCAmZ75KYsbri4=;
	h=From:Subject:Date:To:Cc;
	b=cGI6TE6tyrqkZlDLAqhBB5vOOEcF97X2AJ0QASUcFzWPOpzKJHg0A4NULm1B0K5gN
	 lZiPKd5HRB2ZRXIuuoqcNlk3Sc96ws85QIVl4l2R1K7/T1i5iNl+y7HwPbW/O8SDOA
	 w6uqlgu45JvNdzgjj+8PHUJJw/em8Xf+tMQJ2F+FAgwMBBrye/Bn4NO6YjZQVJy0/3
	 Hu8utMsmRS1a0bKxRAQVE3KRkgZ/FBt58pWjWkTShYl+7+NC5rw8ZqwYhIoKLe6POQ
	 g/ag1vZe55ldmFzl8zn1Rpfd1XKA45NE3NdKpPp1wFiqBXDj235TOX4pn4qPvQ6iBJ
	 yCAUpVTjcqxXg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] dcache: fixes for mountpoints racing d_invalidate()
 and umount
Date: Fri, 30 Oct 2026 13:38:21 +0100
Message-Id: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2chWdEN/RXxI08xGoZNGpzD27
 7bu8VzuOQuYZBWDc7NAlllNp1Sg2zXAkdJNUENhcK3ru9ad8DPlBwYmjoKk2MtA4SjuMLBAkZ5
 ZRv3+g5frxvb2d+FXrdSHJxP0mRLHOs2j7TdjXX/CaVxnjgAAAA==
X-Change-ID: 20261029-work-dcache-ai-6e7ad5e247ce
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wzIdJyLdAb9Oqp1TbNk8YrAEQRUm+AaS0bEEP3YYEYQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ96T9XX+XssD0l931wo6ppv/p7uc9vs8MWvfnxnonXv
 Vjwgs3ZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInENzL8T7JnlnhzZf3fvdHZ
 dW9O5+n8WZqjl7altnT1m+lr5a/MEGX4H2H39frzqQrPDri+uqR5rTtdu734D1e6+d7l71V3/Xn
 QywoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

d_set_mounted() hasn't bumped the seqcount of rename_lock since v6.17
and the lockless walk in d_invalidate() neither waits for nor retries
against a concurrent mount anymore.

So a mount below a directory that is being invalidated can end up below
the unhashed directory. Nobody can reach it anymore and it pins the
subtree until the mount namespace goes away. Giving d_set_mounted() a
seqlock of its own that d_invalidate() waits on after its unhash closes
that without going back to bumping the seqcount.

The second one is from v7.3 and was backported to 7.2.6. do_one_tree()
now takes every secondary root off ->s_roots before its dput(). If
another thread is evicting the root at the same time umount loses the
eviction to it and doesn't wait for it. That ends in busy inodes after
unmount and an iput() on a dead superblock.

The third one is old. With CAP_DAC_READ_SEARCH a disconnected dentry
can be mounted on via open_by_handle_at() and move_mount(). When that
mount goes away while the filesystem of the dentry is unmounted, umount
never sees the dentry. Same result as the second one. The fix makes such
a dentry a secondary root until it's evicted. So it needs the second
patch and it only goes back to v7.2.

I reproduced all three in a VM. With a FUSE directory 3000 levels deep
151 of 200 bind mounts racing FUSE_NOTIFY_INVAL_ENTRY ended up below the
invalidated directory and none did with the fix. The other two need
delays in the right places to trigger. With them both reliably end in
busy inodes and a GPF in iput() and with the fixes they don't.

This goes into vfs.fixes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (1):
      dcache: let d_invalidate() wait for a d_set_mounted() in flight

Josef Bacik (2):
      dcache: wait for a racing eviction of a secondary root
      dcache: let umount find a disconnected ex-mountpoint

 fs/dcache.c                    | 44 ++++++++++++++++++++++++++++++++++--------
 include/linux/fs/super_types.h |  2 +-
 2 files changed, 37 insertions(+), 9 deletions(-)
---
base-commit: 172658cf600904ff6121e240f69a0ccb36e65d6b
change-id: 20261029-work-dcache-ai-6e7ad5e247ce

