Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608290;
	b=DariqowEXvSBQWaHup+z5rbur0/dJE4jd2RHKT19D3F8gvcVaP61v5AfxW9moVjqyqCD
	 timjWgRHnaJwwbv48nJhi50L2+kmjrOqAorh5EdKkYJObaaNd3gpDKxO5HvW/NG+09UuP
	 KAh6MOilvpu8/pVPQc5rxlVx/yYUrE6oUsMYoGBKvcBxBlELqJVVGv1Q1RX7iXY1BNygi
	 XegP5z3NiWwak3MAoqWuPK94jEoII3b/40qQuSfbOIO/Jkc/Dg5S59XzyPc9oVNk02SWW
	 bAMkE7wVisyjj4WGDc+1S9ZiIgH04oBsyJ+kAQJKBWOWdoSALCfwgZrjczuIjDS+ISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608290;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CPo50qO2PRidUlCI48Oz0XpVeY7AnksU4RM+i2sI4Q4=;
	b=abebisz/BlzGgH6k04BIWkC99Skcqlm9/qcZKpZ2jTf9YmL3qiv3X2kVr+vEB/8YUjUQ
	 tCIA/sKwpHTLQCm1K1vJ/tdUeS2V9to3jx8/Ca/CRy2vqemogyj2sxd5uUGzMwgMaO/ut
	 RO/0zcHmOrJSSBt/m6shG7Y5leoHDLAT2r5uvQT+iXgbCO57jNgqWgLvRihKu4pUUrwcj
	 XR8f/sCTxLlUsoQc5KE4yWk5cg7Eqjeh6z8Y07wB2c22ReLcG/LxJMyFQl/YAsU4HEXXP
	 9kD94GwtWNNduz2hbUBkccvfEqZGFQSYTfgb9krrZg7jyUXj6H6nOdHhl/TJ3ZHiqEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9VBq4B9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF793606A31E;
	Wed, 25 Nov 2026 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9VBq4B9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8231F000D2;
	Wed, 25 Nov 2026 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608289;
	bh=CPo50qO2PRidUlCI48Oz0XpVeY7AnksU4RM+i2sI4Q4=;
	h=From:Subject:Date:To:Cc;
	b=b9VBq4B9N23N8o8Rz3rJwWdSB7leqeSGFQecFMcAcxD+oRpjnWNoQEGd2g9OAFZek
	 +KVXXkNQnVFc1Vrm4hvQoocf2/SCfwn8IJX/pK4l50U4Mri77OimcmQBnIX/1uRDJ9
	 igWKXzMrjJ0yr6FhAqpzRyu0m+TsyQ+WinkV9//GYwhgKmPxQL16eM1sia3fk+W+Ef
	 t0f2qG4MZG1QPFblPwuvfXb3UP30HOL0OnJRo38JTK7uHSNQyPOQw48gLAIZ6n0+Pn
	 8r/ZShEwWf1wHOt2dEh+vVv5kYLc6LKtH7ZiJPV3pON0VNKWt6/Bam1teuDH67+5wu
	 qbhShPYJqlgtQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] libfs: fix multigrain timestamps of tmpfs directories
Date: Wed, 25 Nov 2026 13:04:26 +0100
Message-Id: <20261125-work-libfs-mgtime-v1-0-8022a81d0b9e@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6DIBCG4auYWRciEJrQqzRdAA46bcWGsT+J8
 e4VXb6Tb54FGAshw6VZoOCHmKa8hTo1EAefexTUbQ261WeltBXfqTzEk0JiMfYzjSisMs4a17p
 kOtj+XgUT/Xbzejua3+GOca5QXQTPKELxOQ71VEm5k/IgZR3Auv4BxEz4XZ4AAAA=
X-Change-ID: 20261125-work-libfs-mgtime-513953909f3d
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hyRI8f8EzBB1XjIl344P4Wx37/LDhzauX0S0ElTo+n4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSznbuZf6JIUer/IZ9O/07N86/ttlYJv25y5Ordfpvpa
 +L5N5O/d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk4jdGhoeX9wSVX/DSFJl8
 4SvP810hWSe3iUX1GLZOufDRLV5uYzIjw9Fo53cpDpMlRA24I5w+nmq6tyLvmfK3f59j/xx4cbY
 /lxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

simple_link() and __simple_unlink() copy the child's new ctime into the
parent directory. That doesn't work with multigrain timestamps. The
child's ctime is only fine-grained if the child itself was queried and
copying it clears the I_CTIME_QUERIED flag of the directory.

tmpfs is the only multigrain filesystem that uses these helpers. So
since v6.13 a tmpfs directory whose timestamps were queried can come out
of link(), unlink(), rmdir() or a rename over an existing entry with the
same ctime and mtime as before. If the renamed entry comes from another
directory size and link count stay the same as well and userspace has
no way to tell that the directory changed at all. In a VM that happened
in 1738 of 2000 tries.

Give the directory its own inode_set_ctime_current() call like the other
multigrain filesystems do and add a selftest that checks the timestamps
of the parent directory after each directory operation.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      libfs: don't copy the child's ctime to the parent directory
      selftests/filesystems: test multigrain timestamps of tmpfs directories

 fs/libfs.c                                        |   8 +-
 tools/testing/selftests/filesystems/.gitignore    |   1 +
 tools/testing/selftests/filesystems/Makefile      |   1 +
 tools/testing/selftests/filesystems/mgtime_test.c | 244 ++++++++++++++++++++++
 4 files changed, 250 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261125-work-libfs-mgtime-513953909f3d

