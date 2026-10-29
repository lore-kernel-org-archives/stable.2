Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245034;
	b=PUPK0zkfSZc4y5JSY0HzQFyafsFKXXLsF6p40iFrNUUtBs6KKssEUbnS+NQ6hn7B3IQ9
	 AGBHVmbDeup8z5m5JlETXgR+isw/HzHApbhVWYPWC+1YzHlcTGeTD/RZPZI48aFvb6rjN
	 9X59/wF1cmIdUl06tQ9Pe+IIi7LUnIbGvyjgdzqIHJh7uUxf27b1gihpbwHwn5jtRLjm1
	 5BOjucf8vRysA9BCvsYY7N7vNG5Sx+hZgka2Zw28v0Hg/XZIj/PrXuaBZl85e+7UCsMbH
	 vNSv7swWmhRYDxMc3AJWRSkta4N2uMNZI/cTwoqO9YPog2tkKVJlQOAr1nijR95j3SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245034;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=12GT4EhTbX39PzGGZFoO/AfGlalW+8tUPjKC4n+eba0=;
	b=x3VIhcTJk87087D6WMDrNByPvI4SCnQVVESWCOqnGX4J9HDIRsSO1+Q7AJ52eMKPlZbg
	 wog9uhgQxaDdzSESBEUejApVLWZKUsq6ggL8pAyFeI3VJFRzF1lHtEJvRYqj7eH3nxCKy
	 WQnivpGNPfIDJiq93faqD7apgUF/gUN3Qy/HAo643En5M0w1HmUHOaSNVhtC2Q/F//1rj
	 r7kYqMIBKpPtbGEXv//X+LvfiAneKr/7YjS4P00Njz6SH7rvBYpmMzO6AeYSc2SAU6w2K
	 gAYiys6ejD9qocVWkRpdXtzEYBEcEADovQWLc7vdCX4nYD3zFxatnlOcJQJUnWsqUlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=RPbN2Qno;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7684606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7684606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=RPbN2Qno
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T39Vg23151667
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:37:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=12GT4EhTb
	X39PzGGZFoO/AfGlalW+8tUPjKC4n+eba0=; b=RPbN2Qno62lvcCeVcsG9k8YDC
	nJsupb+ugKMaWQXA5RuKGXmI0hAmtZYIxT4o1va1hsQujO6T6g7EOx6SCInUXQc2
	jj5N/DZWqeMkAtiX7TCj25A/IRl59DJDp1wyBU4tYx/PXIjA3LAlwyGZ7+87cl37
	8qGw9ESUIMJm1Ur5o1HgVfp7sN7XrQOxac1FoCfbb8s58LCBNm3aHlmRHXHWzxC+
	zkNZzjXKQ3KpCSFZowRVS4bubG9KHM1JDgF0tfo76kvX38f00b185bxXyVF0mIyM
	uyr5XDlqtGxUSol6WGJx6pt3QBVXhaK4ELSba5c5Ow8V3LhL5DJjPDu15oTYQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hjxcawaxh-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:37:12 -0700 (PDT)
Received: from twshared13996.31.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 03:37:09 +0000
Received: by devvm33008.atn0.facebook.com (Postfix, from userid 228142)
	id 328B91323D9C4B; Wed, 28 Oct 2026 20:37:03 -0700 (PDT)
From: Leon Ming <leonming@meta.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Luis Henriques <luis@igalia.com>,
        Joanne
 Koong <joannelkoong@gmail.com>, <leonming@meta.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] fuse: set dentry epoch before making the dentry visible
Date: Wed, 28 Oct 2026 20:37:00 -0700
Message-ID: <20261029033700.273707-1-leonming@meta.com>
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
X-Authority-Analysis: v=2.4 cv=I8/w19gg c=1 sm=1 tr=0 ts=6ae2bf68 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=0TxM4ttc_5TPnjwGPAwA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxMiBTYWx0ZWRfX/hoKeo6yto3u
 zwM6eESa2jlig9LnrJjKSIjNaJ4RLFFmNp0h1hHxeeHXk3PUReS756CkrOsoPTEsfq6MMhA3Pi6
 zzYF3oDej49kK4MGPiQ//E50PemCr34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxMiBTYWx0ZWRfX40ReBev+TmWG
 Apc6o8x1/Y/DyJ1yS+cePhdNecauCBn4C/bG592E9oNNzFi8Z260li8cnBspEa5wh/PI4jUdLBU
 J1dc3Z+M6YnuGDA3aQI7mT5/PrdgrY+dH+xoUYiVaeBCrtRywDsEeHmPqJdGWsLq0AvbJCdFVn4
 Kuw7qBsp51r8IqAtjc8nf0u52Y41gx614/51AUvBGgGl729+VGp3z2gMJDJlPEmHI8y1r9+a1QN
 lYSM+RcCrbdQbKRFdwm1Yk+q+9Jq+IaVIK8GQvRjyJG9WVbywR3IYuULH5Da/7BuDQAuiUSbaRG
 N1a5+Gr7IGqXDD+QnW01h9MK46mF8IguMdvWlY5RCYkZndgIq8t/3kkdm7YT2na0ab/9ujb/vg0
 C7D9bjqqxzdZtPb0RERIpiATagarm8ancMAAubv+nrJLQ87TRNvtFGokts885Ar+FzTmAOOWtSU
 7QCVw3S26OCWVzEawdg==
X-Proofpoint-GUID: DnLFQ-Bry0tedrRUpyS6ycdAuEr0v4SP
X-Proofpoint-ORIG-GUID: DnLFQ-Bry0tedrRUpyS6ycdAuEr0v4SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01

fuse_lookup(), create_new_entry(), fuse_create_open() and
fuse_direntplus_link() set the dentry epoch only after d_splice_alias()
or d_instantiate() has made the dentry visible.  A new dentry starts at
epoch 0 and the connection at epoch 1, so in that window a concurrent
lookup can find the dentry, fail fuse_dentry_revalidate() and
d_invalidate() it.  The original lookup then returns an unhashed dentry,
and readlink() of /proc/self/fd/N on an O_PATH fd for it says
"<path> (deleted)" for a file that exists.

Anything that resolves real paths with open(O_PATH) + readlink() can
pick up the bogus path; TypeScript's native compiler (tsgo)
intermittently fails to find installed packages this way.  It got much
more common after commit 5a6baf204610 ("fuse: fix uninit-value in
fuse_dentry_revalidate()") zeroed the initial epoch; before that, slab
garbage usually passed the check.

Set the epoch before the dentry is published, and keep setting it on
any alias that d_splice_alias() returns; the dentry that loses to an
alias is dropped without ever being visible, so setting it too is
harmless.

With 32 processes making concurrent first lookups of 6000 files on a
fresh squashfuse_ll mount (UML, 16 CPUs), 1652 of 10.75M lookups came
back "(deleted)" before this patch and none after.

Fixes: 2396356a945b ("fuse: add more control over cache invalidation beha=
viour")
Cc: stable@vger.kernel.org
Signed-off-by: Leon Ming <leonming@meta.com>
---
v2: in fuse_direntplus_link(), set the epoch in each branch instead of
    once after both (Luis)
v1: https://lore.kernel.org/r/20261026201101.3915217-1-leonming@meta.com

 fs/fuse/dir.c     | 12 ++++++++----
 fs/fuse/readdir.c |  5 ++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 28516a1760..650bd13fd2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -644,13 +644,17 @@ static struct dentry *fuse_lookup(struct inode *dir=
, struct dentry *entry,
 	if (inode && get_node_id(inode) =3D=3D FUSE_ROOT_ID)
 		goto out_iput;
=20
+	/* Set before the dentry is visible, or a racing lookup invalidates it =
*/
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
@@ -907,8 +911,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
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
@@ -1030,6 +1034,7 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
 		fuse_chan_queue_forget(fm->fc->chan, forget, outarg.nodeid, 1);
 		return ERR_PTR(-ENOMEM);
 	}
+	fuse_dentry_set_epoch(entry, epoch);
 	kfree(forget);
=20
 	d =3D d_splice_alias(inode, entry);
@@ -1040,7 +1045,6 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
 		fuse_dentry_set_epoch(d, epoch);
 		fuse_change_entry_timeout(d, &outarg);
 	} else {
-		fuse_dentry_set_epoch(entry, epoch);
 		fuse_change_entry_timeout(entry, &outarg);
 	}
 	fuse_dir_changed(dir);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 83a1cc46fe..a3af5ad82a 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -228,6 +228,7 @@ static int fuse_direntplus_link(struct file *file,
 		fuse_change_attributes(inode, &o->attr, NULL,
 				       ATTR_TIMEOUT(o),
 				       attr_version);
+		fuse_dentry_set_epoch(dentry, epoch);
 		/*
 		 * The other branch comes via fuse_iget()
 		 * which bumps nlookup inside
@@ -239,6 +240,7 @@ static int fuse_direntplus_link(struct file *file,
 		if (!inode)
 			inode =3D ERR_PTR(-ENOMEM);
=20
+		fuse_dentry_set_epoch(dentry, epoch);
 		alias =3D d_splice_alias(inode, dentry);
 		d_lookup_done(dentry);
 		if (alias) {
@@ -255,10 +257,11 @@ static int fuse_direntplus_link(struct file *file,
 			}
 			return PTR_ERR(dentry);
 		}
+		if (alias)
+			fuse_dentry_set_epoch(dentry, epoch);
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
-	fuse_dentry_set_epoch(dentry, epoch);
 	fuse_change_entry_timeout(dentry, o);
=20
 	dput(dentry);
--=20
2.53.0-Meta

