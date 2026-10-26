Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045471;
	b=LAI3mh+22zAxlALtKDe+X+3uEDgDAy9X3xyEJ3uxZBVe2lzMwTmNWcJhjj7H7FMkOdyf
	 9Nh67nIL6xV2d8u4LtoDl37EszccBJrMbuvsue3teBOhQGsSGiUC/r+lc+cnRh8vCjBh6
	 VFbo8+4SLCqvrjoOmeqGCzslk5snPtJHg7nxTLJ2xdY48QEoVQ7tNxhTsi2XzSN478TWh
	 jfpka9eVEsAO6HSehrqlgOEjbg8bwfNOwXpWCAAvguzFtKvPY2J7ecLcl8YjuDcf3kMse
	 IOhysD8DKsl9LlMJECQscyINYR5ed6aUEk8gBnHMUH3D1fVcxWOZrEgZD5jIHhuBntg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=qYGmspSDri8F9HUYFDu6GHeZDiCWXNATZ3rpWuwaMVI=;
	b=QNJBbct6rhuCRMcUAN9ygduuzUw3ceogACRNpPa4FLp4vFUX8gFMb15WZXUTDo0AHKPZ
	 lVcJy012emXNGc7DrRnd6f/VrpSDXrGCbid0h27c6Z9faz9lnAMyOq4pGpDEr7LoLSzzY
	 CIYnc9AuDs//t+fK4QR2/SX/kQEpxusr9ze/Kad0a9m8cvgBzJ21bV1ffY++l6j6dZp+p
	 FJ+PreyBAbdgQ0BR9/HNEtsW2dhYaKp1acg7XAIVrc74wEivJ4EXiUPqNnXVWUbqUaEkq
	 bn5uuWUnEnea1R3/VfwyK9/cRjDooyShnRN6o5SgzeK/JcoDdcQp4t0xunHjKoUGzaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hJcciEKi;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49AB606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A49AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hJcciEKi
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QImem4772700
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:11:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=qYGmspSDr
	i8F9HUYFDu6GHeZDiCWXNATZ3rpWuwaMVI=; b=hJcciEKiP7JOPDYk195bCDe8l
	3soiDm3V5iFNcCOk5pK+koJcFLBsV/McUy5VDqOBqa6y9mhTDmRvpNR4B6gedjwY
	joKth85BBuRSubR4RJmGypC/w38DqTH9/H2ffQWND7SCKL4Qki5qtAPmxJfJnAmN
	WdVw5UJDFnhTTThI/SxfORejketSRoAQVOMeoJk8gF+sM9l4+Mo3iHRvbL313QH+
	tZNbsJ+zTtf4gftfI/BCRT/NFaNB3JbEuHnL+WfFopWDya+Ttl2qV9mM2x817IvB
	wKWFl9Tc4PMWghQV6u0vw6ykLZBTMw0YyI+4N0Iee+Srx1AswPtuWTR3ZBPxg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hgss7d65b-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:11:09 -0700 (PDT)
Received: from twshared0305.01.snb2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 26 Oct 2026 20:11:07 +0000
Received: by devvm33008.atn0.facebook.com (Postfix, from userid 228142)
	id AAC9B131419B40; Mon, 26 Oct 2026 13:11:04 -0700 (PDT)
From: Leon Ming <leonming@meta.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Luis Henriques <luis@igalia.com>,
        Joanne
 Koong <joannelkoong@gmail.com>, <leonming@meta.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] fuse: set dentry epoch before making the dentry visible
Date: Mon, 26 Oct 2026 13:11:01 -0700
Message-ID: <20261026201101.3915217-1-leonming@meta.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9Ub0dfcTHPs-hcbIDCRb1nMZiSczEcHD
X-Proofpoint-GUID: 9Ub0dfcTHPs-hcbIDCRb1nMZiSczEcHD
X-Authority-Analysis: v=2.4 cv=BsYIUoX5 c=1 sm=1 tr=0 ts=6adfb3dd cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=fdC3CPP0TigLrd-b9RYA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4MCBTYWx0ZWRfX4e3v7ZFytMhq
 SnOgIMncpYsM/niH5s5tqxyzaqj/PlacN0ZAm8uM9rGX6fzNBGN38lk2U2FONEjnHi6r2xeF+n5
 3YeCEOkEyeygQCvMvoagF+E2IxCGNmEJfBhQBh2eQ1IBa/TjXxhANoPZ5SJ7iKJ1pHq0FzeDJaf
 IsNyPQrkM7kHPfVMFy4VDC+ROX3mSX3haXNaZ8VziI6VXrg1bgC9yyCfM2UeorXMlw1U5QA6VRn
 ai2+EQx4frS58pO2cz29vbNvWZ6QQJ05ClyLU77sIKGGRTFuJ5IOniyCwxsUTBM8EGAcXGSeQ56
 kUtmXUqJAM9gE0bG1KiCs54eq9ulWcJDkjzA1lOHKa4ZlapJCBP75cfpIbdr3wZ4TQRSZonrlA2
 wHlJ34rLCbWaPgElWyuCs4SGvaoEP+ueSPEnxlVT4QAYf6ivnebExiLPUpk4JhTtSUfLwbH2PzG
 7PPyDZh3jeY5vi2zATA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4MCBTYWx0ZWRfX1hN7OUR5V73h
 S37J2WrMgkqyLXNjQ9w+N4fi318eYGTKUJaZMiUU4SJErTXUIVbmrXYenC1kbrdHGqLkckQEOjx
 1NC4LjvZp4yhhfHtOgswoH+BuVldKUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01

fuse_lookup(), create_new_entry(), fuse_create_open() and
fuse_direntplus_link() all record the connection epoch in the new dentry
only after d_splice_alias() or d_instantiate() has published it.  A new
dentry starts with an epoch of zero (fuse_dentry_init()), and the
connection epoch starts at one, so in that window the dentry is hashed
but fails the epoch check in fuse_dentry_revalidate().

d_splice_alias() hashes the dentry and wakes the lookups waiting on it
in d_alloc_parallel().  A waiter, or a concurrent lookup_fast() that
finds the dentry in the hash, calls ->d_revalidate(), gets 0 and
d_invalidate()s the dentry the original lookup is about to return.  The
caller still gets a valid dentry, but it is now unhashed.  One visible
result is that readlink() of /proc/self/fd/N for an O_PATH fd opened on
that path returns "<path> (deleted)" for a file that exists.

This shows up when many threads look up the same uncached path at once.
TypeScript's native compiler (tsgo) resolves real paths with
open(O_PATH) + readlink(/proc/self/fd/N), and when it type-checks a
project in a FUSE-backed checkout it intermittently caches the
"(deleted)" path and fails to resolve a package that is installed.

Before commit 5a6baf204610 ("fuse: fix uninit-value in
fuse_dentry_revalidate()") initialised the epoch to zero, it held
whatever the slab left there, so the check usually passed by accident.

Set the epoch on the new dentry before it is published.  If
d_splice_alias() returns an existing alias, keep setting the epoch on
that dentry afterwards, as before.

Reproducer: N processes start together and each run open(O_PATH) +
readlink(/proc/self/fd/N) over the same list of files in a freshly
mounted FUSE filesystem, counting results that end in " (deleted)".
On this tree under UML (16 CPUs, squashfuse_ll, 6000 files, 32
processes, a fresh mount per round):

  before: 3519 of 10.75M lookups "(deleted)", in 51 of 56 rounds
  after:  0 of 10.75M lookups

On v7.1-based production kernels with EdenFS the same test returned
"(deleted)" for 5.5% of lookups.

Fixes: 2396356a945b ("fuse: add more control over cache invalidation beha=
viour")
Cc: stable@vger.kernel.org
Signed-off-by: Leon Ming <leonming@meta.com>
---
 fs/fuse/dir.c     | 16 ++++++++++++----
 fs/fuse/readdir.c |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 28516a1760e..b7af3f5a3bb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -644,13 +644,21 @@ static struct dentry *fuse_lookup(struct inode *dir=
, struct dentry *entry,
 	if (inode && get_node_id(inode) =3D=3D FUSE_ROOT_ID)
 		goto out_iput;
=20
+	/*
+	 * Set the epoch before d_splice_alias() makes the dentry visible.
+	 * Otherwise a concurrent lookup can find it with an epoch of zero, fai=
l
+	 * fuse_dentry_revalidate() and invalidate it under us.
+	 */
+	fuse_dentry_set_epoch(entry, epoch);
 	newent =3D d_splice_alias(inode, entry);
 	err =3D PTR_ERR(newent);
 	if (IS_ERR(newent))
 		goto out_err;
=20
-	entry =3D newent ? newent : entry;
-	fuse_dentry_set_epoch(entry, epoch);
+	if (newent) {
+		entry =3D newent;
+		fuse_dentry_set_epoch(entry, epoch);
+	}
 	if (outarg_valid)
 		fuse_change_entry_timeout(entry, &outarg);
 	else
@@ -907,8 +915,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
 		goto out_err;
 	}
 	kfree(forget);
-	d_instantiate(entry, inode);
 	fuse_dentry_set_epoch(entry, epoch);
+	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
 	err =3D generic_file_open(inode, file);
@@ -1030,6 +1038,7 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
 		fuse_chan_queue_forget(fm->fc->chan, forget, outarg.nodeid, 1);
 		return ERR_PTR(-ENOMEM);
 	}
+	fuse_dentry_set_epoch(entry, epoch);
 	kfree(forget);
=20
 	d =3D d_splice_alias(inode, entry);
@@ -1040,7 +1049,6 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
 		fuse_dentry_set_epoch(d, epoch);
 		fuse_change_entry_timeout(d, &outarg);
 	} else {
-		fuse_dentry_set_epoch(entry, epoch);
 		fuse_change_entry_timeout(entry, &outarg);
 	}
 	fuse_dir_changed(dir);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 83a1cc46fe4..ffce4031892 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -239,6 +239,7 @@ static int fuse_direntplus_link(struct file *file,
 		if (!inode)
 			inode =3D ERR_PTR(-ENOMEM);
=20
+		fuse_dentry_set_epoch(dentry, epoch);
 		alias =3D d_splice_alias(inode, dentry);
 		d_lookup_done(dentry);
 		if (alias) {

base-commit: 416fd13cb4b789b78304ef1b8579125106ba3ffc
--=20
2.53.0-Meta

