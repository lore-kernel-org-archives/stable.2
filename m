Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207914;
	b=jPIIhADfKLpi8LZzKwg3K1ANoYFWzIZyW+NT869MgVAQIy2RMEiEBzJ5V3jkr5YDxk8Y
	 tUM8MfskM+CIr6M8qGhmBwtHLBmOI6UaX68YLY2/bgCQfSAC5IrCSYwnaIoTsBzFHmr+F
	 BZtW9rof9kTnF9xvoOwT447hSThodPPbLSaR6VxjrFZfnKdCQ0naNv6Xi2VHAUxg/DQbK
	 81SLD9vyMMovezhwn/VawJ9h6nFQtGbVuHzig9t98w9n/ollq6ySWHf98sbNkrluKHRdW
	 7Yum45oJJpxRSM560VlWZFx08q0sIzwKglKqvaqgTRj7fe2DW8xKHjUdYT/RAD/jygw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=i08pkuEXfpe6Y5JQCUxVj9oMxeG4uLiSFjkD/0yi0a8=;
	b=OqlLFzwl+Koan5sXha5ylspa4W0LqP7VoPT3dzPeBY9x2JVm8FYiFPS3woU/MfnkVfSe
	 BJqVFtbaxdPrbkB2AsrxDchGmN2ksn6LrTmYE9D0I6o9ZU6Lx06OKYN+Mi1aBUMfFo4gI
	 w6peo8Qf4TM9nfAuCl/5nHZLX4GaAWG7T35+CUAcF75kdq21+MjuC54lOYj9CGeY3/T0q
	 7zyyIyLRjV6gUY0PTKTTWBagN9/YTUff1UUulw2yQyiofKIy3IcetJeKPGK4QOiUA6tNN
	 rSkyFJ/KPiwREo9FHDSaf+bZyVQjc3JAoM2q+yUYeeNly+WOi5OKjg2XojRrq0DuhIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=i+QJjDOS;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FD606A6AB
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50FD606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=i+QJjDOS
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f20c3aaa5so124318585a.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795207905; x=1795812705; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i08pkuEXfpe6Y5JQCUxVj9oMxeG4uLiSFjkD/0yi0a8=;
        b=i+QJjDOSdexfW1O8Wf7U+kYpXPZ91CdX1B+TxKTvtlq72/PX9dAqCiVvtrjtaTF1iT
         5zzzmW5YvPYWgY/NBmEmq17PK9FZ6pP2uegLy3fiqcxXAM6HYil8aPPz0S+EH4CMlOqx
         Yqwhyezskr0ZxFWonzcLOE2L3qJT5jh35asEl4KB6LHzjdUAZW14APCDQe6hTQxW6r2b
         FxSdLlhBXu7Zrpw8+qdwouGsxWuSWEmRXQKoPnd+aG4VYuvi3ncmd1hV0195PO2pB4h9
         wM/2AkeyrZWrLb4tahDFDIFUuGQShWwG5dOTBH9ZHvSP2rePpnrO9pDVNyyc9lptn+W3
         3KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207905; x=1795812705;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i08pkuEXfpe6Y5JQCUxVj9oMxeG4uLiSFjkD/0yi0a8=;
        b=tvwWxGWH/kfQTxh1p97rl9inNtZ7+M7W8qTCaLuu+oQ8Zb7WEXHh6JqgG2S86Y9lwC
         g/5m2qT3aEJSpX3QX2jC2Ts0W+8QcBmAfXY72UIWyP+F3WocQ+zYHUckg+p56mR28ppw
         DMUux+PWslpOfXlQ5sC4as/R9j8jRb2aO1lomr0y0xnIBOh0+dirQtmMNEXstrG5eXCF
         Ez6CO2vOSma4Nguv2UnW4ou+U9/1eZ1TkT1fpC8ZBcQhIuBrM6taEMTZTcjAaUuDMYl6
         USZIgQwO+UW9E+JeeDzH2x41VK9Ier4ND+w3s+ieSZ7jsg+9WmtIRQqQNyZ4a20WXNNN
         ZhJw==
X-Forwarded-Encrypted: i=1; AL+hErFWymtA/lQ21GErWLjiOkYzvRNg/MPlLFlViP+b32M9EawVrNnSVlkdcRKHVOch88gqEM/xSJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BEiX1/rXhMg0n6dS2+iweliCWtmVW2H5c+1+p0PZgFteQLC8h
	vJ6aXR+p38GNJNaqPcq7J2SUfZL46E2T2n9dDHLDyTbIDOgXLZaae4mvqsb/9MN4X+Y=
X-Gm-Gg: AYBFou1pj+E4VJn+Zou76mH4z9DYoM5HNvexFWnZjegTfBXXmOY+O7e7o4w9JCDqwYe
	/vOoyIlP1LJou0z2wICx1NPWUkzUfPEOUFVOGlKdy2MIxVFYazlN4W9rdY+3rbGtp6r9N+AmvwC
	Wdd2ZfPBl2DUR4wZRX0erlhHEV3mL4t+9Ya5zAnFs/p4ee+zuXCelfu2B1j5c0rRvYzWOSL2aUc
	HdH0IDq5oHbnwDPuqi4wnlY0w9pIpnfg5wnexi8UfN7RviY6jUk8nHXqo66w7Doh2FKFkU94ubA
	gBDRyq3s4WhemgopzIHuRQ8FFpWuHhbmwEDbBeP1C8GIEngePHKHCbSZ6hypoDq6T3YXQODfjbJ
	B9hpfi56uKx4JUSOMfD42Z02eYa4ggieV4BiD7hSJYyjO/61KVfYWYGKTaqyQ9P2xtT1kMpxt63
	hJucHgPnSe6yXFgTC3nyFOFt2cNie4mVYcII9iNrbdlYUvVcH09fy6H4dMOgTE/3+fPKCetKA42
	VyxnxwrlBlXch4yZwIKmp+z7EcJqGZCUMIyHa5bbFaoPRJi65Vto0PbEPcJboTjT38hCj4J5kfH
	L/0vtZ/qQFN5Hi1IAjxABvyIaFxsJUUAvoaE2cYTpOt9uA==
X-Received: by 2002:a05:620a:4397:b0:93c:8e3f:3036 with SMTP id af79cd13be357-949ba827abemr681554985a.4.1795207905523;
        Fri, 20 Nov 2026 12:51:45 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb397b4bsm282157985a.21.2026.11.20.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 0/6] btrfs: data integrity fixes
Date: Fri, 20 Nov 2026 20:51:28 +0000
Message-Id: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIANCyAGsC/3XOzU4DIRQF4FdpWHuVnxnIuPI9TBf8XDpohAaQT
 NPMuxeqiQvT5bk598u5koI5YCGvhyvJ2EIJKfYgng7ErjqeEILrmXDKJaN8ATOBqdkXcLpqCLH
 iKYd6ATRqFmZWglJP+vc5ow/bXX4//uTybT7Q1sGNhtEFwWQd7TpOn043fPEpQ8StjsIaSk35c
 t/W2IB+Zwj6cEZjQMFPbmKLVIKhfKtpC/aso9PPNn2RsaXxP6xrjzHesVkpZ7lcKJXsH7bv+w3
 K+BUAQwEAAA==
X-Change-ID: 20261029-b4-btrfs-data-integrity-eb753b57300f
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795207902; l=5593;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=anVFp57BSGnp41DgrPKjML35KX9vG0TIKRZWERnyGts=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCABDZneooLIeuMHi7gGpLp8BmWPUFaVbNubq6Su6vBSVD4ltjW4NXzcA8DKr08XIFEKfm6z/+W
 iiAOXifm8mws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com/
v2: https://lore.kernel.org/all/20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com/

v2->v3:
- Rebase onto for-next-20261109.  Encoded writes now always get a full
  fsync (900bbc210986 "btrfs: skip fast sync for inodes with encoded
  writes"), so the fsync fix no longer handles them.
- Patch 3 of v2 is now two patches, and goes back to an inode flag
  instead of checking the collected ordered extents for errors, which
  missed truncated ordered extents (Sashiko, Filipe):
  - Patch 3 renames BTRFS_INODE_COW_WRITE_ERROR to
    BTRFS_INODE_INCOMPLETE_COW_WRITE and also sets it for a write that
    fails before a bio is submitted and for a truncated ordered extent,
    such as a direct IO write that stops short.  It is set under the
    ordered_tree_lock, before BTRFS_ORDERED_IO_DONE.
  - Patch 4 makes a fast fsync wait for BTRFS_ORDERED_IO_DONE on the
    ordered extents it collected, direct IO included, before it checks
    the flag.
- Patch 1: drop the bi_status store that nothing reads anymore.
- Patch 2: use btrfs_folio_clamp_finish_io() for the cleanup.
- Patch 6 (patch 5 in v2): don't count the replace target in
  btrfs_ioctl_fitrim(), and Fixes: 929be17a9b49, which made the trim of
  a device depend on its alloc_state; before it the replace target was
  never trimmed.
- Stable: patch 1 6.6+ and patch 2 5.15+, as for the commits they fix;
  patches 3 and 4 6.10+, and patch 4 depends on patch 3.

v1->v2:
- Rework patch 3, now "btrfs: wait for ordered extent IO in fast fsync".
  BTRFS_INODE_COW_WRITE_ERROR is set after the end IO handler clears
  writeback, so a fast fsync could still miss it, for plain write errors
  as well.  Fast fsync now waits for BTRFS_ORDERED_IO_DONE on the ordered
  extents it collected and checks BTRFS_ORDERED_IOERR, and the inode flag
  is gone (Sashiko, Qu, Filipe).
- Patch 4: use DEBUG_WARN() instead of ASSERT() for the check that can no
  longer be true (Filipe).
- Collect tags.

--- Original email (v1) ---

Hello,

I've been doing some model checking of our trickier paths with Claude's
help, and these are the fixes for the bugs it turned up that actually
lose data, or tell userspace that something is safe when it isn't.
Every one of them was reproduced in a VM on an unpatched kernel and goes
away with the fix, though the fsync and log sync ones needed a delay
injected to hit the window.

The worst one is the fstrim one.  If you run fstrim while a device
replace is running we'll discard everything that has already been copied
to the target device, because the target's alloc_state is empty until
the replace finishes, so the whole device looks unallocated.  The
replace then finishes happily, the source device goes away, and you're
left with zeroes where your metadata used to be.  This has been around
since FITRIM learned to trim unallocated space back in 4.3.

The split bio one is similarly nasty.  If the last piece of a split bio
to complete is one of the split bios and it failed, we drop the error on
the floor, and a buffered read returns success with whatever was sitting
in the page.

The rest are in our error handling.  A delalloc failure in the middle of
a folio leaves blocks dirty that no longer have an ordered extent, a
fast fsync after an error that happened before we submitted the bio can
log extents that were never written (which log replay then happily puts
in place of the data that was there before), and btrfs_sync_log() can
return success for a log transaction that never got committed.

I have a cleanup series for btrfs_sync_log coming, as I had to spend a
lot of time grokking that fix, which is a good indication that the code
is too complicated.

They're all tagged for stable, and independent of each other except
that patch 4 needs patch 3.  This is against for-next.  Thanks,

Josef

---
Changes in v3:
- Split patch 3 in two and set an inode flag for failed and truncated
  writes (Sashiko, Filipe); fast fsync waits for IO_DONE first.
- Patch 1: drop the unread bi_status store.
- Patch 2: use btrfs_folio_clamp_finish_io().
- Patch 6: don't count the replace target in btrfs_ioctl_fitrim(),
  Fixes: 929be17a9b49.
- Stable: patch 1 6.6+, patch 2 5.15+, patches 3 and 4 6.10+.
- Rebase onto for-next-20261109.
- Link to v2: https://patch.msgid.link/20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com

---
Josef Bacik (6):
      btrfs: don't drop the error of the last split bio
      btrfs: clear dirty blocks after a delalloc failure
      btrfs: make fsync wait for all incomplete COW writes
      btrfs: wait for ordered extent IO in fast fsync
      btrfs: don't report success for a skipped log sync
      btrfs: don't trim the target of a device replace

 fs/btrfs/bio.c          | 10 ++++---
 fs/btrfs/btrfs_inode.h  | 24 ++++++++++------
 fs/btrfs/extent-tree.c  |  8 ++++++
 fs/btrfs/extent_io.c    | 15 ++++++----
 fs/btrfs/file.c         | 74 ++++++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/ioctl.c        |  3 ++
 fs/btrfs/ordered-data.c | 52 +++++++++++++---------------------
 fs/btrfs/tree-log.c     | 20 +++++++++++--
 8 files changed, 139 insertions(+), 67 deletions(-)
---
base-commit: 3aefd67f08f8ed59ed0fa90619b25856df415031
change-id: 20261029-b4-btrfs-data-integrity-eb753b57300f

