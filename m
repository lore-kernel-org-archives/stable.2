Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793536484;
	b=MUoe8oG8usqQku/pAxMtTasAOREXs41H4ruF4rieOPzIQ4ZEUVBOE1CgRZbuhgUm+0hQ
	 QAk60BX5iBtp6vgUKNUbkOqGnnGEgZa3YKiXr3HXnxgSw3IyFWvmjp9VwFU2XfDS1AWhk
	 7g/sT7CP3X9Ru5mpN5JhqeBCHulp0fo/fTfGcev/OG78QCF+31XTpVZ1ZVwvOV0vD63n3
	 qRnc6wTBHNSRRxreJP3kXr1hhutkC3ccpBP4EIZV9Z/kAr6FiJtbsaHjIG5r3gHT/qMH1
	 Z2veL2JDf0Rmre4pu5HVl++tUqxKt+MErLvvG5zEc4kGcLhntNEmmFn+u+cSMpd+F0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793536484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/D/A9T2EJRYZY/+rdAawlrNFx7uSdrcye6ffwoxRa54=;
	b=ckY4kgEiZ68dO23BWfEcusVCnIZRcgzqwGL7czCHBcAIBLxRRefAEBZZVZGFZUzXOtx/
	 f//LyrA5r4PLRQqtx/gDVpt3NZa1ZIpbxpYKoKodhkN+V9hpodVAZ76SOmrvY1JQADU6c
	 rhdztJtGZVjyiF92kCG9YVRBGhqXJaEttA1pEo6HESOsBVNnLjrG0xChiz2sqcxMu6bBF
	 x1NLBQS4zPaLnUP35f/fzxHUTHlnVffVVC3YTEWEDXXtYJif1VXGCWMl2uSB04akKVTgW
	 rf27jGepDt2Ol/dy+GIYJpHr47dkJ9LUEcKvnJrthP79fVY0LIsX+x1gimPae8Kmu0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ea5BdI1n;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0B606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 12:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA0B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ea5BdI1n
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c169ae1cb26so512528066b.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793536482; x=1794141282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/D/A9T2EJRYZY/+rdAawlrNFx7uSdrcye6ffwoxRa54=;
        b=ea5BdI1n3jMl3nTFIjg1OVwLozn1JI9ufbHSZXBBTwqcISfpOrOD/hWSMAK8goj+JV
         ghJw6j73yFnthUnjFxDslLRT+4HB7LlKV30AQYBDStO7smzuBRVrv8FErRmKnTSoG+Hj
         HGHO7IrLwKc0e5GRHgH76UfMvD0Kx9ImmbG7L6G4wlqp8coCHtDEUXPTDrPeq16C0EJk
         B4SjJ2hc8+jSM00jQEiKvveoTypIWvKmLgpreALDqigMx4jHf5g6oCgmucBsLR6y2anN
         cpWLspOjtXj3p1OjOQQA6moH5MO6dK1nAz8nb8lfgSH1fVyNMRdow7h2cIsuiO7KjvR6
         4LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793536482; x=1794141282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/D/A9T2EJRYZY/+rdAawlrNFx7uSdrcye6ffwoxRa54=;
        b=pRU/8o/bGQptexdjrf1/QVIp7p2DVtnPf9RcwU/a/1vaDnvfIEvxL9jmkQ1i5BJn8R
         Fm6Z2CBxYQeLpI6ULgaavTKdczGp2z5GJqi9mSR0rkvFBwIe0ahWIkUD84p/d8knu7UW
         9eUeOnVsYDh2tvdConn+t+ikTuKaEMuKZZIGZGCPU45sbk1HxJQ/1lnqR+oCXYfNVOAP
         b4NPKavcAIy8h9NdB+pQOCjQNjCk/jLo1Juaz+SXsjR/YRoIAYjoUJKN1CO2uBV6XoM6
         /LvXUFgIZfreLiTekGuENOQTuMZJaeBxeTiSrMv0NYQnf7yspKkkN1bFj1u+yJ+JlXAs
         Q22w==
X-Forwarded-Encrypted: i=1; AKwUvByTaQLahOe/LE4OhsICqFpCRJfNfFdFORRR4fRSxU/HwhJxK2VEeb/z79Kc0Vw/M5S9lU6bKic=@vger.kernel.org
X-Gm-Message-State: AFq9FYILmPIduyQ/DgSCwE1mztyllbqMWH/BsiUYEnQHJmjoJuckZ6wn
	W4ACbhBvBSmOaU7RkSazcHoSz2mpzQEfR8o1kf+qiVreRYkcncGz1GcjpiylAvbC
X-Gm-Gg: AYBFou2WcTPPSmIA2qO3yDH6PIqNccQ1McMjo5dA74Tqii90tnxvknKvipW/bNUZS4G
	RB3HhMhjuN/ei9wV8OJDHPgHP4PO/kMvR1RoPHwcodeN97MwFFZKj8ijgincvodaot/fjjGJVPV
	cvi+lQSonNLQXCsXSy0+w4QAHvhYBpdcVmwKEVHVSxdTsA+ozHiokGWwEngrhR9xRv2ajh158lP
	3tP95uDxEyqxVTJGmA/62Dw2dYJyc7pju6qmVRYU/YtBJACROyJlONNmKDuGOX3E2VVVH6sOtpl
	FFyLPzxBQcqqkMQTVc+LFxPJ9tj4LdPyKfYZzb0gM+9ymzI5lSpXxUCo0fFHSokI0Iny5ONXjMC
	KW31rBcVc1bxhK5nY+xTH18m3/Fs3euWPgSb1blBw3eNsuN8ll88pLxfy5ILzd2UoiUGOIE8/j4
	9v+G63bcs+e4GAN7aRLULFgQ4wCYzmBBtUVn33Z6KnYJWdqzPK1LmZ5mDjaf45D8T/rmudzOD05
	7wkCCPaEqNUfmbfD90bYyVXpNwiSFVRQPloAEmvorxQ5qDhw8XyxnJNlwaSpX+cnPAOtacwCW1r
	O49dKN2TJn4+qAUi1v6zH0bBPrS5ofUTZLzH3bsiUqIYTSTAW/DFt/taVbBaD3XW+vFRs9+eTQo
	mPEwKrBJWZJQ=
X-Received: by 2002:a17:907:3f9c:b0:c42:fc8b:6c6a with SMTP id a640c23a62f3a-c4ca7a9ef71mr660488666b.14.1793536481629;
        Sun, 01 Nov 2026 04:34:41 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ec5sm275298666b.12.2026.11.01.04.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 04:34:41 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] backing-file: pass RWF_NOAPPEND to synchronous writes
Date: Sun,  1 Nov 2026 13:34:40 +0100
Message-ID: <20261101123440.3184069-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Chris Mason <mason@kernel.org>

pwritev2() with RWF_NOAPPEND ignores the offset and appends the data on
an overlayfs or FUSE passthrough file that was opened with O_APPEND, and
the call still returns success. The flag must make the write go to the
given offset even though the file is in append mode. Any user who can
write to the file is affected, with the default mount options.

overlayfs and FUSE passthrough forward the reads and writes on their
files to a backing file on an underlying filesystem, through the helpers
in fs/backing-file.c.

The flag works for the file that the user opened: kiocb_set_rw_flags()
clears IOCB_APPEND in the write's kiocb. It also copies RWF_NOAPPEND
into ki_flags, as it does with every RWF_ flag.

overlayfs and FUSE passthrough then pass the write on to the backing
file. They opened it with the open flags of the user's file, so it is in
append mode too.

For a synchronous write, do_backing_file_write_iter() calls
vfs_iter_write(), which sets up a new kiocb for the backing file. That
kiocb starts out with IOCB_APPEND set. vfs_iter_write() is only given
the flags of the user's kiocb that are in BACKING_IOCB_MASK, and
RWF_NOAPPEND is not one of them. So nothing clears IOCB_APPEND again,
and the data goes to the end of the file while the call returns success.

An asynchronous write reuses the flags of the user's kiocb and is not
affected.

Reproduced by calling pwritev2() with RWF_NOAPPEND at offset 0, on an
overlayfs file and on a FUSE passthrough file opened with O_APPEND: the
data was at the end of the file afterwards.

Fix this by adding RWF_NOAPPEND to BACKING_IOCB_MASK.

Fixes: 73fa7547c70b ("vfs: add RWF_NOAPPEND flag for pwritev2")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This is a followup to commit 19b18e01d0361 ("backing-file: enforce
append-only and immutable backing inodes").

It is NOT a security fix, but a correctness fix for both overlayfs and
FUSE passthrough. It fixes RWF_NOAPPEND being ignored by sync writes.

It had to go after "enforce append-only", otherwise sync writes could
also overwrite append-only FUSE backing files, as async writes could.

Thanks,
Amir.

 fs/backing-file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 5780f60662d07..c601b27f0fd35 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -115,8 +115,13 @@ struct backing_aio {
 
 static struct kmem_cache *backing_aio_cachep;
 
+/*
+ * RWF_NOAPPEND stays set in ki_flags.  Pass it on, because the backing file is
+ * in append mode as well and a new kiocb for it starts with IOCB_APPEND.
+ */
 #define BACKING_IOCB_MASK \
-	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
+	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND | \
+	 (__force int) RWF_NOAPPEND)
 
 static rwf_t iocb_to_rw_flags(int flags)
 {
-- 
2.55.0

