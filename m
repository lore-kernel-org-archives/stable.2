Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371588;
	b=OuLCWKlThyWg8RV8siI6ak4SIr7FMdneHutB/0F3vJTLG6yff523Idhno50QQYeUCmkc
	 iOMJTdArTGzQtTC3c3EnqmFsI1je4jk2Y+kURh4zsCjB4Zr9jG/xrSKSuMO7X5B3CHbki
	 6mgcmjahvWHFuYQr6bGOxvism1vD4r1OYrCElLEat0uCs2gmpIUhZy8wIrh0kVmUUqCf2
	 M4++FwpnTw+3YgV3cabIVAKX5P5QpVpY/mVNaSXZpvrd6vTsPFSxbB0eEty0XKdePKh53
	 3jehdPqORclZyIsCkQzJYZDVK6u3Ppb4v3KWp7G9Gx48KvhDJpC/PUewZ4lbv8jr+9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371588;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WVTO+ZFIbXEfR3uu7xu/MItF4Atk3JimOaKBTi8fWX4=;
	b=RWiA93nLPfkCtrp6Fmb53eUQ0ksjyHAWX4xWEh8mrk7g1ovUqG9tMCXIjf47BA21dwI6
	 P+92Zv2koi93/6F8ICpDXETcesGm5cgO73BaK22D329Jh4dWIXP9x3mJOVVqru0Pq4olm
	 Brnpjl8YytY7nR1JwQIiCSR1QpgfX22C5vUPbYJYOVTOftIg2UWaYGbDYutCcDxB/n/bi
	 Z3sEks6cnSOEd6fs+oAvXc4LF2+iklFfAK+wfbd/7VGIBubprAnF/mRx5Q2jRyWmoOCeS
	 hqZXufFaA7zzF0gPIw8NA4ePiN5qwjfDqXtJDzE/skndaqcTSmjhjcW7AB4ViWzxYEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqtXpeaY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AA606A32C;
	Sun, 22 Nov 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqtXpeaY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795371588;
	b=OYd4wnWv4ISbojtK97AE+4uyuilvlC5ozcmct6tCQy73MpdCpYsdr4G+yrHMC1ACRDeJ
	 abkx0VpNhR7sx4PV3TSHyJED5uujV25FPv+vfQoTCZsI3YFfqNEIux3zRrXEONe5fM31G
	 rY4JohxnYm3plscE7zjwWio7VBOMw6kDGtJQ5yBV64D7WjuV6K8GeYWVwSRTeNUVckl6F
	 A/5vVZNhSDLkNtD3kL1mWh0CD2WPUdNM3PLzqTEav7yxR9pEoilnURkYrvPVG+u+qhSRu
	 tLicCkNMHi3XuiyoGqtU954rfA31GiO6HE1mUJXJyO53KOsu7fp8hgGbz+eaNGHD7qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795371588;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WVTO+ZFIbXEfR3uu7xu/MItF4Atk3JimOaKBTi8fWX4=;
	b=NLGOU50qAhnPzMPD8W2QVydB72WgObayk3huBJfMehLO4+PluYmetsBteaUWyWVVJlI9
	 pZWtNzDeRFG/XECNJ1REmFasusCE0FwTTirt9746oumIX6VT+8Ebga2PydBw3/Zhcu8DR
	 /wlp3R/t9ftGXPACET5N/Q1XAdSwC5vA72dYrQzB5sLmRMYolsgJe3v7RQ12S2t/e3dAw
	 LFZyqN2x7E2qQsx8L8IqCPK+VkHZwr7KhVRqKpML3ujs410aKbjXb0D6Iljmf/qo7UKuI
	 VNatSldJueyg+QmQU99jNEEea+E3yMxGken/MDZnsDn0UVzh86ISVLa2JWsx31kcH1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 18A911F000C0;
	Sun, 22 Nov 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371588;
	bh=WVTO+ZFIbXEfR3uu7xu/MItF4Atk3JimOaKBTi8fWX4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=eqtXpeaYNqpz9er90/US3aoKlWJ+ulHQ4UIftsVO4Vr9jEr/gOISF3EnSmVGWHWek
	 7j+xtWJg1/s7Y6l4CA0ov1iWZY0Kk/bMIP+COEVFxF7WuM31daaUF/YGM4qlM+SQhA
	 50IqkgSNdMwqA6KgkjYaxbD7JZeI5AF0WalzNAfLTMQmEkWoJCtYAVBMzwPxwJUZZX
	 DGI/srBHUDVYwRJqBW58fiXg7jQ+Y1NkzqV0UD6Es6TSHq7tbQ1ggjw5ST+xznGjPl
	 eyV3/msHstkQ4948PBSg6Ej5D1oHddpigRuUxtJIGChp9wjizlUE4cuNOWGS3+30Ke
	 Aa4BL3twPhXSA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E87C4C178;
	Sun, 22 Nov 2026 18:19:38 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Subject: [PATCH 0/7] ntfs: delayed allocation accounting and stale data
 fixes, part 1
Date: Sun, 22 Nov 2026 19:19:36 +0100
Message-Id: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CMBBFf4XM2om2gAZ/hbjoY5CaZjCdakgI/
 26Ly3MfZwOhFEjg3myQ6BskLFxAnRpws+EnYfCFQV/0VSmt0XbIeRL0FE2Mi8MprCTYWzP4joZ
 b27dQzu9ER1G+4+PP8rEvcrna6sIaIbTJsJtrVKXnw8y0Ztj3Hy8DsfKbAAAA
X-Change-ID: 20261122-b4-ntfs-delalloc-fixes-5ba9d4e97353
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Baolin Liu <liubaolin12138@163.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=62L5IEaL6xTQEPQ1PHctIEz6ZdEKiJuiiUA0TYgGuLE=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmxmIwt+xWzZn1GWdV8u/23Tcnu/wUuo8a+L0q7Yozm3+
 AX/tFp0lLIwiHExyIopsnT8vxHiE/Lt07I4rT6YOaxMIEMYuDgFYCIXFjMyzAwKyOavd1zdUWN8
 /NqvQ292759aUnJH943Cz/tZB1InfWFkeFacz13psOJyR+ixudtqrF8vyrWvWVWW8OLiP4ldPac
 6OQA=
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me

A write/truncate/punch-hole stress test on a 128 MiB volume showed the
free space reported by statfs() falling from 79 MB to zero within 80
seconds, after which writes failed with ENOSPC or came back short, while
$Bitmap stayed correct.  The reservations that delayed allocation keeps
in vol->dirty_clusters were not given back on several paths.  The short
writes then exposed a second bug, the file keeping the full size of the
write, which Zhan Xusheng's "ntfs: trim the sizes after a short write"
[1] fixes.

Patches 1, 2, 3 and 5 fix the reservation accounting: truncate of dirty
delalloc data, hole filling by fallocate()/direct I/O/page_mkwrite()
that consumed other files' reservations, removal of named streams and
eviction, and buffered writes that fail after ->iomap_begin() reserved
space.  Patch 4 fixes the runlist split helpers, which turned a delalloc
run into a run of real clusters when a punch, collapse or insert split
it (reachable through the stale runs patch 5 removes; it corrupted
$Bitmap).

Patches 6 and 7 fix stale data exposure in buffered writes into holes.
The page cache zeroing of the partial first and last cluster gave up as
soon as writeback (the flusher, or FIEMAP_FLAG_SYNC) allocated the new
delalloc run, and a copy that stops inside a new cluster left the rest
of it unzeroed; in both cases the reallocated clusters showed what they
held before, below initialized_size.  Patch 7 also covers a writer
killed by SIGKILL in the middle of the copy: iomap_zero_range() refuses
to run for a task with a fatal signal pending, so the zeroing then runs
from a worker.  [1] needs the same for its own zeroing after a short
write; I suggested the change in reply to it, and whichever lands second
can share one copy of the helper.

Six more patches of the same work (a failed cluster allocation that
drops every file's reservation, st_blocks of delalloc data, and the
remaining stale data windows of write faults, writeback and direct I/O
into holes) follow as part 2: they need rebasing onto the current
ntfs-next first.

Each patch has a reproducer that fails before and passes after it.  The
reproducers run in QEMU on a kernel with KASAN, lockdep and UBSAN, at
512 B, 4 KiB, 16 KiB and 64 KiB clusters, with ntfsck -n after every
case.  On ntfs-next f674e4b6c315 this series makes short_copy_stale,
delalloc_accounting, delalloc_failed_write, delalloc_zero_race and
stale_wb_race pass, and every test that passed before still passes; the
same holds with [1] and the change suggested for it applied as well.
The tests and the runs, on Ubuntu 26.04 and Arch Linux:

  tests:                    https://github.com/xerrni/linux-ntfs
  ntfs-next:                https://github.com/xerrni/linux-ntfs/actions/runs/45032649068
  ntfs-next + this series:  https://github.com/xerrni/linux-ntfs/actions/runs/45029297643
  ntfs-next + [1] + the suggested change + this series:
                            https://github.com/xerrni/linux-ntfs/actions/runs/45029305849

[1] https://lore.kernel.org/all/20261120023504.4134966-1-zhanxusheng1024@gmail.com/

---
Ernest Borowski (7):
      ntfs: release delalloc reservations cut off by truncate
      ntfs: do not consume delalloc reservations when filling holes
      ntfs: release the delalloc reservations of an evicted inode
      ntfs: do not shift the cluster number of a delalloc run on split
      ntfs: punch out the delalloc reservation of a failed buffered write
      ntfs: zero new delalloc clusters even when writeback allocates them
      ntfs: zero the rest of a new cluster after a short buffered write

 fs/ntfs/attrib.c  | 106 +++++++++++++++++-
 fs/ntfs/attrib.h  |   2 +
 fs/ntfs/inode.c   |  12 ++-
 fs/ntfs/iomap.c   | 316 +++++++++++++++++++++++++++++++++++++++++++-----------
 fs/ntfs/runlist.c |  13 +--
 5 files changed, 378 insertions(+), 71 deletions(-)
---
base-commit: f674e4b6c315ebe742d08af80659386992d58ce9
change-id: 20261122-b4-ntfs-delalloc-fixes-5ba9d4e97353

Best regards,
--  
Ernest Borowski <ernest.borowski.git@proton.me>


