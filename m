Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318962;
	b=huvue5wjNoWgMZZzRDbiuG90fAMcepSy70cq/9nq5tJj3TMDRIySsnF4RCbrIJ1bdSDD
	 DMhZvUQbe4P/Sz94cfNLIPAENT0pxSuH8CdJKNKXi5hLl5fCDMpbC3tgWSw1BYdMTf6G1
	 b6Hcl5bik75+orZTZkx+yMhubY+kNMazl+WDdXI90BCjoWhVNKXlna85efU6XERmqlDHW
	 oy/efHqX8409ZF32pJVKYF5/1DcoZmCSKgrMdBbPBBGIkuCwg4/n+v0TNmXyHuhTaRO5e
	 PVO3tz31Fk3grC3vJO07rtfovdEq/QTNWl4OGZAGEccR/5eMbN5eUiDT/UQnaTlN9QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318962;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=79fJ5zsQRH5ZFuAEfEZbISVjHVWUFTm3gRl221dNcnw=;
	b=eL+UEuM6NWapdIIloxuQLBTSuZr6Sz0hLWsUn7BBVRZ2iAS9B/7z9OBnE0GeIB5Daqnv
	 aPHUIAGcm9xLjqtBobZO/4FBvGNE3csZKBDXW+PSh1dpwa9J3oIDFQdzJcBJqDN1I+AVU
	 VzazF09zweeyH2OhyAUkVtUrNWvYRMYA0cMVmR0X8Mn+UWydPMxyahTZDOtihgmkDiI7G
	 TUYWabJSRshtMKEF7tviJXOduaPNHAd+lthP/MFGTX3nowjS7ot+qFeh7aCp5mTm1WwNP
	 KD0JDWfe6+mvwQM9zycFdbPmx4Xo4Hw8/vTm8fLajGDj877mVzRoqfkNQYkf0Eq5Lzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doYn0Rdf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08434606A31A;
	Fri, 30 Oct 2026 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doYn0Rdf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793318961;
	b=gV4DjMtSSWHNruCZEguAbVsatzIMdY4Y46BsFAQEeX+akoDGRe3M+O7mgp7jKOcLhp4M
	 2OsX2mxnBkIZO76LjihT50M5vADDusvxwS2meabAxlQYmo2SKNt1EbbxaVbVY10jRk1T8
	 0rFJmHOAD0uYoRZnE7NJSv+DsMIADZHxjX4kcaRrQJLs2sMBaPv6W7fmcBT13MkiYHGAh
	 LaM8oeuXcVTv6vnAm4Avk6vsZag2kTVPf0TgVYd9nGHrvIxVmVUiVcfbStE9ZU+f2gthq
	 KZAMh7Ijk36c7S2DeryypT4+H78F0cnrDlQNlgb4ANqdxzcjygVfTnpON/KaTYwPo+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793318961;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=79fJ5zsQRH5ZFuAEfEZbISVjHVWUFTm3gRl221dNcnw=;
	b=hAWam5GkDroucyhM1fh46l8PkAngRHY0rKOxLEBxqT1/Y3ySGL5ZymxzMmnqtqR6gBsX
	 8hAiMlJT1X+utVKjl9iTabGW/eFhIPCFiXUwF5H3WBxpeBnwmqMmdJLOE/Igcqs5iYtuT
	 VQLpTppAqcwhgGA5zlw153EmTuFqHSOLX+qiQ0NOely9HjUHnw4gDBP86yAl9nfgVRPeX
	 mmRtX3pTu0nQsKKVJ0D+qBHezav5VYwhWZ269MRNUYhpNdCBprh+6gX5FDjsFrACgfK/O
	 IzJzuiWMCvR+OugenIAdfiuN6+pSv5UIYpZ3BHqFImdgDQozJfgKzwGmYgzz/o7PqPA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2D371F000C1;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318961;
	bh=79fJ5zsQRH5ZFuAEfEZbISVjHVWUFTm3gRl221dNcnw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=doYn0RdflSbYdQZ5LPvq3Oe3xZv8xRyRPZdeXHXB0z3Lt1tNHKH9DA7l2ldPqYQ6I
	 CaxuTB6OW0vbLJQizL04GafGkOH6wxYxfJgV9NRC5r5HwTgjZilvX2WeGK14NWU6tM
	 q7bGdWq9OP3gqQbqRzRlQcA2TWSSgphPAYMnQSvvtcijgHjnZhOZdJobGXEB4mYqZK
	 iz4pyK2OEfKFPwcsN4ZiDnXZ4rAR5UzL87mHZ9xYsoNrP+MgcIiDW64tlSRd/d7TX5
	 nqXMXAUUtKEaw6VuqDC5dYscDR49UBCEiLhVKW3MMEC8NgCyiS5GizqbUt804WDBpa
	 rZulMyjUgMYBg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 53851409DF;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
From: Kamil Chojnowski via B4 Relay <devnull+contact.diath.net@kernel.org>
Subject: [PATCH 0/6] fs/ntfs3: fix a deadlock and data loss in resident and
 sparse files
Date: Fri, 30 Oct 2026 01:08:09 +0100
Message-Id: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWTuQixbpqxQXTTza6SItmbQUx
 Hc31uXH4T8rKbJA6dqslPEVlVeqsG1D8XFPC1imanLGXazxhlOZ1XOGyoRUeJYflGPoO2sc3DA
 Equk74z/U8jae1k94Ipbji7ZtB5C/+4t4AAAA
X-Change-ID: 20261030-ntfs3-resident-fixes-cb54102e288b
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kamil Chojnowski <contact@diath.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793318890; l=5846;
 i=contact@diath.net; s=20261029; h=from:subject:message-id;
 bh=IMDHc6D5LBYf9bTtoSfC5z3DtdZSwElxUKK8DMto4jA=;
 b=VAaw+exSqLGQbsxPkopLvXOvx8VzGT/RxobnSb1F1CWf1lRktAEnmswqI11SHBnAq/Q+JB71C
 c0ugb/H0nLUDnYg9d+VDk54Z5KBa4cCVDymDNBKvUOR3H9kcuvcbngm
X-Developer-Key: i=contact@diath.net; a=ed25519;
 pk=G15RQXroUn6f8ud+bOEqlqpPdpLoCB3L3G9XVUf+YaA=
X-Endpoint-Received: by B4 Relay for contact@diath.net/20261029 with
 auth_id=1360
X-Original-From: Kamil Chojnowski <contact@diath.net>
Reply-To: contact@diath.net

Hi Konstantin,

I have been trying to move my workstation from ntfs-3g to ntfs3 for a
while.  Every attempt ended with the system wedged: several coding
agents and git worktrees working on one ntfs3 volume left tasks stuck in
D state until a reboot, so I kept going back to ntfs-3g.

The hang is an ABBA deadlock between folio 0 and ni_lock/run_lock when a
resident file grows past the MFT record.  attr_make_nonresident() runs
with ni_lock and run_lock held and locks folio 0 to copy the resident
data into the page cache, while ntfs_read_folio() (iomap ->
ntfs_iomap_begin() -> attr_data_get_block()) and the resident path of
ntfs_writepages() hold folio 0 and then take run_lock/ni_lock.  A writer
appending to a small file while another task reads it cold hangs within
a minute on ntfs3 master, 7.3, 7.2.11 and 6.18.59.  The same inversion
was already in the pre-iomap code, so all stable kernels are affected.

  1/6 the deadlock: lock folio 0 before ni_lock in every path that can
      convert $DATA
  2/6 mmap writes to a small file are lost when it grows: keep an
      uptodate folio 0 instead of overwriting it from the resident copy
  3/6 extending a resident file with ftruncate(2) races with readers and
      gives -EIO plus a WARNING in iomap_read_inline_data(): resize the
      attribute before i_size
  4/6 writeback that races with the conversion drops the folio; since
      2727ac2ba87a it reports -EIO instead of warning, but the data is
      still lost: redirty it and write it through iomap
  5/6 ni_write_parents() walks the record without ni_lock, and a
      concurrent change makes fsync mark a healthy inode bad and the
      volume dirty
  6/6 writing into a hole of a sparse file that ntfs-3g created can
      zero up to 15 clusters of data next to the hole, leak the old
      clusters and push total_size past alloc_size, after which
      mi_enum_attr() rejects the file and the volume is marked dirty.
      ntfs-3g allocates sparse files cluster by cluster with c_unit 4,
      so every file it wrote with holes (linker output, for instance)
      can hit this once the volume is mounted with ntfs3.

Patch 2 depends on patch 1; the others apply on their own.  The readdir
lockdep splat I also hit is fixed in ntfs3_for_7.4 by commit
7a5aa6c45072 ("ntfs3: release ni_lock before dir_emit in ntfs_readdir to
fix deadlocks") together with Christian's pending "fs/ntfs3: fix double
ni_unlock() in ntfs_readdir()", which I tested separately.

Testing: the stress tests run for 120 s (the git workloads for 150 s
and 8 minutes) in a QEMU/KVM guest with lockdep and a 20 s hung-task
timeout, on a fresh mkntfs image, or one written by ntfs-3g for the
sparse file tests.  The guest kernel is 7.3 with fs/ntfs3 from ntfs3
master; the "this series" column also has Christian's readdir fix
applied.

                                    ntfs3 master      this series
  append to 4 KiB vs. cold reader   hung after 46 s   pass, 491k files
  the same, grown with ftruncate    hung after 46 s,  pass, 589k files
                                    EIO + WARNING
  the same, grown with fallocate    hung after 46 s   pass, 714k files
  mmap store, grow, fsync, while    hung after 45 s,  pass, 192k files
    another thread fdatasyncs       10 bad files
  pwrite into a mid-frame hole of   14 clusters       pass
    an ntfs-3g sparse file          zeroed
  rewrite that sparse file          rejected, volume  pass
                                    marked dirty
  12 threads: create, unlink,       pass              pass, 5.1M ops
    rename, readdir, mmap, fsync...
  8 git worktrees of one repo,      -                 pass, 4486 commits
    3 grep/find watchers
  16 worktrees, 6 watchers, 8 min   -                 pass, 30815 commits

The append and mmap tests also hang on 6.18.59, after 45 s each.

Patch 1 is larger than the stable size limit and does not apply before
the iomap conversion; older kernels will need a backport.

Not done: sparse was not run, the code was built only as =y on x86_64,
and no fault injection was used.

Tool use: the investigation, the reproducers, the patches and their
changelogs were produced with Claude (Anthropic's Claude Opus 5.5 model
in Claude Code).  I asked it to set up a test VM with the newest kernel
and an NTFS volume, reproduce the freezes I saw, find the cause and fix
it; later I asked it to rebase the fixes onto ntfs3 master and to look
into the ntfs-3g sparse files that ntfs3 rejected on my volume.  It
wrote the QEMU harness and reproducers, traced the lock chains from
lockdep and sysrq-w output, and wrote all six patches.  I reviewed them
and ran the tests above.  Each patch carries an Assisted-by tag.  The
reproducers and harness are at
https://github.com/diath/ntfs3-deadlock-lab

Thanks,
Kamil

---
Kamil Chojnowski (6):
      fs/ntfs3: lock folio 0 before ni_lock when converting resident $DATA
      fs/ntfs3: keep page cache data when converting resident $DATA
      fs/ntfs3: grow $DATA before publishing i_size in setattr
      fs/ntfs3: write back folios that raced with $DATA conversion
      fs/ntfs3: walk $FILE_NAME under ni_lock in ni_write_parents()
      fs/ntfs3: do not reallocate clusters of a partly allocated sparse frame

 fs/ntfs3/attrib.c   | 101 +++++++++++++++++++++++++++++++++++++++-------------
 fs/ntfs3/attrlist.c |   4 +--
 fs/ntfs3/file.c     |  33 ++++++++++++++---
 fs/ntfs3/frecord.c  |  46 +++++++++++++++++++-----
 fs/ntfs3/fsntfs.c   |   2 +-
 fs/ntfs3/inode.c    |  63 +++++++++++++++++++++++++++++---
 fs/ntfs3/ntfs_fs.h  |  13 ++++---
 7 files changed, 213 insertions(+), 49 deletions(-)
---
base-commit: ee1cb3443cff5a800948b662756f75b17ca63fe2
change-id: 20261030-ntfs3-resident-fixes-cb54102e288b


