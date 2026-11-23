Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443162;
	b=Q2+C3CQFN7L6dSTVAP4NZUL0193D/I9DECc2f/lq96qEB0CzlDtSmVqjq7aosCBCOQTf
	 ojB6ICkeTVCiRu5GW26fyITrbAAC7loId+KDMwPIRefb2C3acLaxEz5x2kxMjTzq+qg3R
	 e8iLvdwW4HwRv0nSgsjFDghEM6MX7GeK60UNAgMJBdSC9TU5ibCP6F8iMPdZHIquvJXQF
	 hZYdC2C8xOZKaxNnb/hLqXNMzIBApPoOyw3EMrSUyGg3+oHM3tsdPzbltm1+Tv/DVas0k
	 P4oBAxmlDarr/cRR7rZ6ovyb4yw7tzN4B/EwbvqW6nH3V5do81Dr9WLgXz5bgdGX8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FpQteIPOJ7jso2isVNK/FXoPVqd5TxYTuttF9zGO1yA=;
	b=GxeeWJsOumNDcTiJ/oJjdKe8O4IFY28/gcgzGCqs8DeiSNBTZrOYvBQNACjHWUgeO7XI
	 M6TKU0avI6wkatjx1MzTsru1aOPRqxzdaFn/q8kQePVPNGqB6Lomr+OfTrZCD7KqvsSo1
	 qgWKrxk8lUADzWM6+WxGCu98V1G0S3ZfwwjLtGs6qLG+3HPoZ+n4kYF16Wn9tWtF4vYqi
	 Ps50e9FNnEaijPtUhzca/mxQfYx2f+L0+mYyvPaFYQqWPdfobxdAhWoP5TFWT+OrQ2qei
	 7gBjB6ZhOG+pqajEJlL72YGn4E3wbqZ31HQwhA7q1BFplNd8ywKqOrY5znwlBcEicaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HSDIN/qx";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88544606A32A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88544606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HSDIN/qx
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5676623c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443161; x=1796047961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpQteIPOJ7jso2isVNK/FXoPVqd5TxYTuttF9zGO1yA=;
        b=HSDIN/qxhXjIe8cpCe89tmnGrEkq/g67ziZZmU9iYOrYOh8IF5sUmzhBx+5YJP1wDM
         f6Ut/vhOK71Vib7hIAvZxFVaDViu80YZrsA9EZJJEnW3+YaEJPT2ContZLY24lpR2SxN
         QTvzTWO8r1i3mMO8SzY41qYfMuhHGnX+LxVi63vXhkJSCeBixtwQylAyvfS6zpmPxMO+
         h3h1ALkFm5mP1ylfVejUswRjCOD+Flu8f+wcxbPSV00bKOYKZDznMCpsfwxmn3HVe/B9
         53/KwBCt/xCPmR7d6yQsPCiSGcVyVstJNVCqsKCFJ9vZ9KB1jpjFBTOmr5rRTxRd0R9B
         6gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443161; x=1796047961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpQteIPOJ7jso2isVNK/FXoPVqd5TxYTuttF9zGO1yA=;
        b=JD2gSt3L7SEuQ0qgAhZhvOIF3lhfn27h+zHV/GwCT2W5EDotulxWs3s5SkxeqE15Tr
         poA8ghTn+7WP93aD1EMS4WELjreO1dhbnjlmVat1ZqMijvXDsYi2tkNQfl1jEBRSpuJP
         764G+Ny5Z5/uWtoeNEVXlmN7hDyyR+R/Q5OhTToDIM+grEi/PcOElbVUZn4H6sInknHV
         KQydDHxbHWAQuQaW1ckzNTwEc3gRuqEdfcqjLiZnVh128PZvO1/gskOpZdneoW+8Dye1
         5JBNWfP4OAknofJIm0UppIoEXj2rHjAJMgHTvnPvfhhOzE6OhLoG7zSy27VnqQBj0lAs
         0AGA==
X-Forwarded-Encrypted: i=1; AL+hErFkgE8D7jZb7txg0c5hj4LQrRX8wcLrKJv/PptZDLlyrG3SA1Q5+gOLkPOATasYzw/5IPMoSRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YmzXK/wbV2yQUrGO74W0SCm+u9jRNTMzYTpIG/93s1GI/bqbV
	T8Od1z9+BZz/3p2itVu6ICawnPIa4p/ZoTrHJo9oKst971Dur2FC/9Ht
X-Gm-Gg: AZFdTZf9F6LcAD4v2o/cQw345UwQ24eFu8qq0xYL7n3orVyPRUDJgcPc+kEYSXylAqm
	bWWRoq/+L+Rlo5fLOVhyF2lrrT2JcUvUN58YQd88npOc/oVGjgG4BPOg59HOluDO0VbOAiUp7Eu
	wPsUgkD8ZrB5boviBZvLq2jPIffkQZTMatY2mKi1XiHkC4Y6y8OQ1ttCY31k8oYwoQniaaSK+xx
	0OSW3N2OTTQQZH4mkXtAUaMw2NHLGjykKFra2ar7xa46YLQYwUrbBEBDOr0pOIqdul+KiOQOsoX
	pRKMmUIsYw8p7JubRjQFiG3PnlbsuhCyS0xeLZMVnZDrpd+fyX5IpQvSNz47wwEQyb73Oo1z+U4
	TYXAhRIKnF8Mjf7g83OvvJxhdDN3Hd3ZZZg6EWLH+m0ewQKKdel7h04hIkW8RwUyDzbnyvMzQMq
	vnRUPBf3y80qnGAKco4IFiS5qV/5bAeURJrpLjMSrxQu4B43aeKWRNN+km5CZCFZYsH0vGwKWtJ
	9U9V3J9jGWDFLA+LQMx35L3hy/jPzO5BIqPgMM/lYhrYKsQhLhbFN8x2tsfaeKDcKzuenY5tC4P
	Hhp77pnB2aAOCFnubSzWl/kG7yV9pdUm8pTMvHygapsHw8kG1g==
X-Received: by 2002:a05:701b:42d1:20b0:1af:d88f:fc51 with SMTP id a92af1059eb24-1b5568edb1dmr12692628c88.30.1795443161493;
        Mon, 23 Nov 2026 06:12:41 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm35997230eec.15.2026.11.23.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:12:40 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Dharmendra Singh <dsingh@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] fuse: fix fuse_set_nowrite() race with parallel direct writes
Date: Mon, 23 Nov 2026 23:12:34 +0900
Message-ID: <20261123141235.2477526-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In 6.12.y, queuing a FUSE_WRITE_CACHE request clears folio writeback
immediately while keeping the request in fi->writepages until the
daemon replies. Cached writepage requests can outlive the cached file
handle in two ways: if write_inode_now() fails in fuse_flush(), it
returns early before calling fuse_sync_writes(); and if a file is
mapped with mmap() and closed while clean, final unmapping drops the
last file reference via fuse_release() without calling fuse_flush().

Once the cached file is released, FOPEN_PARALLEL_DIRECT_WRITES allows
concurrent direct writes under inode_lock_shared(). If a request is
still pending in fi->writepages, two direct writers can both enter
fuse_set_nowrite(). The first sets FUSE_NOWRITE (making fi->writectr
negative) and waits on fi->page_waitq; the second sees fi->writectr < 0
and hits BUG_ON(fi->writectr < 0).

Fix this by waiting on fi->page_waitq in fuse_set_nowrite() while
fi->writectr < 0 before setting FUSE_NOWRITE, and waking waiters in
fuse_release_nowrite(). Also still run fuse_sync_writes() in
fuse_flush() when write_inode_now() returns an error so close() drains
in-flight writes before returning the error.

Mainline is unaffected since commit 0c58a97f919c ("fuse: remove tmp
folio for writebacks and internal rb tree") removed fi->writepages and
keeps folio writeback active until the daemon replies. Fix the ordering
directly in 6.12.y rather than backporting that larger rework.

This bug was found with an in-house LLM-based tool, and the root cause,
reproducers, and fix were manually verified by the authors.

Fixes: 153524053bbb ("fuse: allow non-extending parallel direct writes on the same file")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Tested on v6.12.116 with KASAN in a 2-vCPU QEMU guest using an
unprivileged FUSE daemon (UID 1000 via fusermount3). Verified against
both C reproducers (FUSE_SETATTR -EIO on close, and dirty mmap
followed by munmap after clean close), which previously triggered
BUG_ON(fi->writectr < 0) and now complete cleanly without BUG or KASAN
reports. Standalone reproducers are available on request.

The patch also applies cleanly to linux-6.6.y (5139929c698c), though
6.6.y was not runtime-tested.

 fs/fuse/dir.c  | 10 ++++++++--
 fs/fuse/file.c |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 45cbe0cb2..54b9138fa 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1821,8 +1821,13 @@ void fuse_set_nowrite(struct inode *inode)
 
 	BUG_ON(!inode_is_locked(inode));
 
-	spin_lock(&fi->lock);
-	BUG_ON(fi->writectr < 0);
+	for (;;) {
+		spin_lock(&fi->lock);
+		if (fi->writectr >= 0)
+			break;
+		spin_unlock(&fi->lock);
+		wait_event(fi->page_waitq, READ_ONCE(fi->writectr) >= 0);
+	}
 	fi->writectr += FUSE_NOWRITE;
 	spin_unlock(&fi->lock);
 	wait_event(fi->page_waitq, fi->writectr == FUSE_NOWRITE);
@@ -1850,6 +1855,7 @@ void fuse_release_nowrite(struct inode *inode)
 	spin_lock(&fi->lock);
 	__fuse_release_nowrite(inode);
 	spin_unlock(&fi->lock);
+	wake_up(&fi->page_waitq);
 }
 
 static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 33ba8ae3b..5e01dd2b7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -538,13 +538,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 		return 0;
 
 	err = write_inode_now(inode, 1);
-	if (err)
-		return err;
 
 	inode_lock(inode);
 	fuse_sync_writes(inode);
 	inode_unlock(inode);
 
+	if (err)
+		return err;
+
 	err = filemap_check_errors(file->f_mapping);
 	if (err)
 		return err;

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.43.0

