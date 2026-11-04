Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817964;
	b=fY2shaEoHeMQjav9QKttpw6nMUBi2RZghgCgsPb1AihrARVcHk4Uk8eDlf72BQm1fGxa
	 reXaBzxDqrs3ySyxQl1GS4DSOBoiKCsA4jUrXRhTIdPxhCIFIZa0JpuBCLgWFCFIQWe33
	 Xdi35tgqNvT5ZxVP0WWD7vNHWvjnNDmemuMkxOWxJtYQkwGppV9486devJAb+mvNH7CCM
	 72/ajPs8IIimMisqUd02lO/XSBoHSkUPS7+4B4drjd1geUtm8n9pYWWF/A1n0Z1U836WE
	 hgY8KbPzrV8Cv5asPTTqH3wHZXb5qYEgJtaZP0g08RGwCDjOS9hRDYbE44dzudRMSQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VArFlCtb9pCmnR4OIe6J/O/sKD9jy24HbcdjyBbUe4s=;
	b=YlD1A25/Xrmun4r+rC10neZODl1U/NZ+6JRx3y3jUhwaxocYo6cNopUonHGNv1i3i6Zz
	 jrsvuLltiiiDWpk3OckKih2WVgGuaXYIIeyUmkn8Yr3NHN6NERMwBKFp9t+1dSVJxNc4Y
	 1klJlDlCfB7CmZT+J/PEQKrYnFDBhN4mXHrYT3lQMlGizd70SOYF4jRkm4Uo4Ro1FciJp
	 2/eHN2II2rbcP0yiR+YSIxb3QkQmjPRQLl2cgy3hg79DDjte7EK/6PYgDjoCuL3zlyhly
	 jYnsz4pZouAjaXnmQFitw0GHkOVg34QtaVAlInH9mGzfi5e2cE/IOI+CSKzyhdRrwJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zkSDsf2i;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA8606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFDA8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zkSDsf2i
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b042c0728so300606f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817962; x=1794422762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VArFlCtb9pCmnR4OIe6J/O/sKD9jy24HbcdjyBbUe4s=;
        b=zkSDsf2izIok4I8cdnRpe0ERxo8+7t0ksu+R/SKshfMKzqM+Cfas3VEJ7ym4Q3+L++
         MGRvYkto56IXDiUx/P2np8cnR1eiC6soLAly3uiypeBsE9/kOR8U0/Cm+uZ/3mOSMb0Y
         vv8Twj5+DENLubl7ELAQJ7ZrWnzKvevGaaNpC0i9Z+RbMVsEPlGRtPMICCSPUbDuc2W8
         LgXKVLrU4ZkwjqQqNsmDW6KmOs62IoRxMXkXqLtNKUjp7a5L0uzswgZlmfpEi7J16UKa
         n9oPQ/zHS16MzoNQ4qIvl4sNsc/FtWn8K5xDsn+4fXMS81Lpe9jKadgEIumwBmzQSTwz
         FrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817962; x=1794422762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VArFlCtb9pCmnR4OIe6J/O/sKD9jy24HbcdjyBbUe4s=;
        b=mZ3jbo2dEEfrFaBXt6AiY/D8CNzBPd9z23F8EfJT3ogLdiwbqUXu0BIWtxugdudh2U
         CFyJJCrli8rOtwy8BqB93rfWkkhqs6SJMLpruULPPqMUnj5YSonD57VTbWparYGzJa7+
         8lFrfmmA7qVmIkndliPFuzCK16aYc0BgXXqF9X4zg3AtSB1mKGLMl+AxjBQq4gd2o2xw
         OXl5gaUsoK9NFvo8+PGpk1xZfUAr5dwZeV2t/dcvIjWkLLkoJxLLPTsUKCR7idegi7HM
         AMDaeNCZcy0FEZi8zX21WcbJFmsda4rwTPGZeuA1KRTx7C5wssmBjhf+X+cgrk2mzsQ4
         /7gQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCj3HrlH7Vq9oWG166E5mv7su474+36nWMXTJ5CASQ1OzmVkIoVW9sf5Id40cU3jkjrzQAFPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9A+6/wnslBE8eo2jjozrdZYXvioM1UThf37fnaonjoscLuMwHC
	f6DkDjAh9YAmtGvI/fO+xDiJcC+ifTcsdiOhuKH47tb2SVoQbHuV3mWt
X-Gm-Gg: AYBFou0faISfvEl+CCSkM+/IVCLc3CCx5JM+kmkJIJIIC+KwHX1XsgQnntg/3Pw7/Bk
	8d5++7Ahn5Pi/9YNDvjSDqx3a/V455h+bkl9NCIKxj/OTonWjGpSM282Ckp7V94uEevcFxvGxrP
	/7jfDoAHCnZsMn6Pt04R7hxok2yi3EBxmiv951tqpNcdw7Syg4pSNGmId4Xqd1+Kh8Pb2HTUs8U
	DEUwrVwRxXrs8XouIPf33Az7hmvaotRvQHrNIXkp8hjhbJ2u+eAnKuwz2DEHeg6TEs2zI6v3D1W
	R5Ws/vvYd2J2sDdUo4emgEiJUIpyo5V1+Vo6TH4w56vywBBuL9+YU9WniYzvqzLjtva3x48XnAU
	px++gV6S/dn68ljld2tPiWCAchRa5QrqKgjyXQzR07GXsjy52/JbujC2EFXn82veaDwGVV1lFWg
	+mDcCpD+VcN7Y7Ktu4TgIdtpuM1X2JqNHGZeVuqenKNBX/VxY/wiKMWJ/Wm0pRUBe2HA0wdvVxr
	49TjnTVWrY7i2QFt2SVH6xZwbkIn/XLd1pgqL8dyp1Hp/pTat3piyC0D5EEQC1ovhLK++VWQ0MA
	1FDFNTRJdUh7Z+VTLYTtjPzFkFqYTbKLUnuDwGgvHTkZZythf0djnpFfIMCPRVYaYSDakVgFV+L
	zL85+3pUyr1o9usZpK5VojpCk7v04UQe+Ig==
X-Received: by 2002:a05:6000:41c8:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e6e2bc714mr37538611f8f.7.1793817962193;
        Wed, 04 Nov 2026 10:46:02 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm6034141f8f.45.2026.11.04.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:46:01 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.6 1/2] ovl: take a snapshot of the name for copy up
Date: Wed,  4 Nov 2026 19:45:58 +0100
Message-ID: <20261104184559.3630145-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104184559.3630145-1-amir73il@gmail.com>
References: <20261104184559.3630145-1-amir73il@gmail.com>
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

commit 65bf000962a33ec9d2488e4e1797b6cf630abcbb upstream.

The copy up of a directory reads a freed dentry name when a lookup
moves the directory at the same time.

A pointer to the name of a dentry is only valid while something stops
a move of the dentry. ovl_do_copy_up() keeps a plain copy of
c->dentry->d_name in c->destname, and ovl_copy_up_start() only keeps
ovl_rename() away. When a lookup finds the same directory under another
name after a change to the lower layer, d_splice_alias() moves the
dentry and frees its external name.

With a delay in ovl_do_copy_up(), a chmod of a lower-only directory with
a 60 byte name raced with a rename of that directory in the lower layer
and a stat of the new name, and KASAN reported a use-after-free in
lookup_noperm_common().

Fix this by using take_dentry_name_snapshot() for c->destname.

Fixes: 829c28be9bb9 ("ovl: use d_splice_alias() in place of d_add() in lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: destname is set in ovl_copy_up_one(), take the snapshot in
 the non-index branch of ovl_do_copy_up() instead]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -869,6 +869,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 {
 	int err;
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -897,13 +898,23 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		/* Disconnected dentry must be copied up to index dir */
 		return -EIO;
 	} else {
+		/*
+		 * ovl_copy_up_start() keeps ovl_rename() away from c->dentry,
+		 * because ovl_rename() calls ovl_copy_up() on source and target
+		 * dentry.  It does not stop d_splice_alias() from moving a
+		 * directory that a lookup found under another name after a
+		 * change to the lower layer.  That move frees an external name,
+		 * so take a snapshot.
+		 */
+		take_dentry_name_snapshot(&name, c->dentry);
+		c->destname = name.name;
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
 		 */
 		err = ovl_set_impure(c->parent, c->destdir);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -935,6 +946,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 	return err;
 }
 
@@ -1070,7 +1083,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 	if (parent) {
 		ovl_path_upper(parent, &parentpath);
 		ctx.destdir = parentpath.dentry;
-		ctx.destname = dentry->d_name;
 
 		err = vfs_getattr(&parentpath, &ctx.pstat,
 				  STATX_ATIME | STATX_MTIME,
-- 
backport
