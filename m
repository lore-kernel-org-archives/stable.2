Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530658;
	b=lo5Yd/qnpxKwdq/F5k1xEtXqJPiewdZ4Ziyp51Iw7PGWFn0kIG0pabvve5hBTCOaUO+V
	 IAvkECku5rd8lOwAR/9ITncWE1nV3MrzOF0qA+c4N3UH3DZl+JIwmVf3p8QIvDTTMThvO
	 Nw/YKm4CCvKbQYTlCXT/FtAgFbumLP3eQWUpj5gruIOmkCHI14WHSctVkDd6t6x2IfkE1
	 XiSSV6slgzojMEQsx3MNN+VIemXW8Zo2zAj1HfOzXL5d9LVmrBybQeymOhD7Qp5/fMZOn
	 RC0zREJT9M9lJZfZ3bm8htHhcqeg55jTKw7N8mG+fmh854zCRxo6gDgunzCWPnov9bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530658;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Sg22FFzQle62bHhfMwPNo5Hy5ytXL6aSon5hd35zBMM=;
	b=NB1veJr7jyPIVUAUaZ+qD41P5EGpl4k+wLiY7KIAGCSKZjcYi1qWjAonax48bnjdhAD6
	 OcrOj5vZsGe8NviIhMUJv+m7ZTTs1xgWkgmqyTw4m6c+hsfMDSeIWjrxM3gS1xlxPGvyB
	 60DH3vtghn4nchwJVSQcSLx1kT3r+5lQ7Fes2+Hf6tAHv22j1X7J3Lx3zDpjUUXuFSI7k
	 OrXt4p2QIK6v6IxdR3uODEMsDiLjNunZ3Jy6I9vPYy7ZrMgkaprqSn+wNDJns999fFHbL
	 K4wQx7aQJ3dvfiDx3WZXV00qaK0MmnT/etOHhyIhsoWF17Lv8+EdUhkfh09yCCndT+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbPd7j05;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6A606A325;
	Sun,  1 Nov 2026 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbPd7j05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9891F000C1;
	Sun,  1 Nov 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530657;
	bh=Sg22FFzQle62bHhfMwPNo5Hy5ytXL6aSon5hd35zBMM=;
	h=From:Subject:Date:To:Cc;
	b=BbPd7j05qv9DXwXTyXLKH5d+RigaVxQHQMQ0bv9xYERLvTQQSg+bme+ny8/CLC/Y9
	 d2AJWOOUTNfAnMCUewG7n1WpXY3iviLVYCioRlqmHNYEIJ0lMrrG0y+D50HKtGU45E
	 pNhC4MHldg3qJspBn+xJ7JIGm9w5wvSPIEvQgbmosxAGvSn8gF84vTJ0ZI9f9jq3Ck
	 t5u1J8OON6rO+3H54gH26CBzXpVt2SsKTJOpEhHivZ/cIm9aMURS+sikvsVTWzr9kk
	 TFLigsWRajfKMSEyH9jVbdP4T8AQCKBNakSdK4leiH4NpszSvQxt40sJLNmGLnr46f
	 Gegyem1OJWIcA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/3] libfs: fix readdir of offset directories
Date: Sun, 01 Nov 2026 11:57:19 +0100
Message-Id: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OWw6CMBBFt0L6bUkfBNQv92GIoXQKFdOaGUQNY
 e9S2ICfZ+bekzszAvRA7JzNDGHy5GNYQR0y1vZN6IB7uzJTQpVSaMHfEQf+8MYRj84RjDeExlq
 P/Cgqq01VFaoUbO0/EZz/bO5rvTO9zB3aMQlTwjQE3GAT2j6dJkf53lh/vacx4ncbNsnk+GfDJ
 LnkYCutW1kodYLLABjgkUfsWL0syw8BigNB8QAAAA==
X-Change-ID: 20261030-work-libfs-offset_readdir-807d3b774260
To: Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2/A8ggTd1QAYPPBcgoigIM2jvlPvMi9eZnCLEoLzb9I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9l5YNKHtzRDD7zLSaiucrr8Y78v3fuUfv0fbY8pkre
 KODtHWWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkvADD/7qEqRdm1NwK55q4
 2rksutggpMBgmYzLys7+es1nya/DeRkZDqs7b29eYBj7bq1uv4fcww8CnmfO+TxdyL5g5evNGaU
 ZXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

readdir on tmpfs walks d_children and only uses the offset tree to map
the file position back to a dentry. d_children and offset order
disagree after a rename over a name, an exchange or a wrap of the
offset allocator. An unlink between two getdents64() calls then makes
the walk skip entries or return the whole directory again. So walk the
offset tree itself in descending offset order.

v1 did that with a full tree descent and a reference for every entry
and was quite a bit slower. Now the walk keeps one ma_state for the
whole call and takes no references at all. That relies on all writers
holding i_rwsem exclusive while readdir holds it shared, and the maple
tree only allows that if i_rwsem is the lock of the tree. The first
patch makes it so, and lockdep now checks the writers. The last patch
stops an lseek() past the end from returning the whole directory again.

1M entries on tmpfs, getdents64() with a 32k buffer: 146ms before,
about 230ms with v1, 114ms now. Four processes listing the directory at
the same time: 470ms per listing before, 113ms now.

Tested with Nickolai's reproducer, generic/736 and a seek-after-closedir
test, on tmpfs and on tmpfs exported over NFSv3 and NFSv4.2, on KASAN
and lockdep kernels. I also wrote a TLA+ model of the walk (cf. [1]).

[1]: https://github.com/brauner/linux-formal/tree/main/kernel/libfs/offset-readdir

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Make i_rwsem the lock of the offset tree.
- Keep one ma_state across the walk and take no references (Chuck).
- Don't return the whole directory again after an lseek() past
  DIR_OFFSET_EOD.
- Link to v1: https://patch.msgid.link/20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org

---
Christian Brauner (3):
      libfs: make i_rwsem the lock of the offset tree
      libfs: walk offset directories in offset order
      libfs: end offset readdir at positions past DIR_OFFSET_EOD

 fs/libfs.c         | 133 +++++++++++++++++++++--------------------------------
 include/linux/fs.h |   2 +-
 mm/shmem.c         |   2 +-
 3 files changed, 54 insertions(+), 83 deletions(-)
---
base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
change-id: 20261030-work-libfs-offset_readdir-807d3b774260

