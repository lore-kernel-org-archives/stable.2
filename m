Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270364;
	b=YtcwFOk8ysUpn5GXqsKY5Ow2UIDUQqpaWWJrbw9Kh624GCoVV1t+kpMj7w2pM/HCM+at
	 +QBmYeG9qntTulcWdJ/MZGJs0Yv8GMOTPlqPFJpS4pFW5h9UVZ0lntkeyIeCBPcOmqujr
	 cit80enDLKvUufZnvBIfVSeXbDmTVljyqUa2HeGOkudelgxQXU3Ota0aNInACjkrnDuT0
	 UTuZxV1MzX9KqZg4rqpRvls1ctBuaOMsp0DxGifkjKrtAkfSf4c2h1tYt3xFAUC9cbH4W
	 5p3byQTpEPlL8FI+rYPqlW2dgK1H6rIvbePI25CiGKWsRBR63EBDY0tJsh/MUbyUxfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Qi1ti4izdBvA4FPvYxDV0dCh2GnisjK7L+m92EFw0NM=;
	b=TsOrhLzxFIXwX6SmEQ+pf+c+r6XtzOnSdd8i1aC+P1SSYZuxCqrFg/c+oGM22mnWArOf
	 7TfHnR4878fpjz8dA127M9Y6kGeX8qRrP0+3ITSqv3q3NZuL8xJdsQw1hboGv4g/mVqmc
	 VOEmbM732c/uVyFpvqLcPi3eSOM1UwkS0GKD88/ELzHVeNGFD4zuzWgMewgwHRPLhhs7p
	 LsSsGuzw2Agx1drjfbcOw5VVNjFP31N6Jw37lCFFflUKa8U3ml0Xk6QFNykr8vX0Ij0l6
	 YuGxTsVk5+RnKoMBtch+PpFkHyEZf2U6QZ5XAYyDpWeu7jPIGLPDPzC3gQUvOXLWqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDRv2pLU;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58C606A33D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B58C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDRv2pLU
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso915603a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270363; x=1793875163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qi1ti4izdBvA4FPvYxDV0dCh2GnisjK7L+m92EFw0NM=;
        b=ZDRv2pLUJPbNgSZHNvl7mvVRFXQCtghrzmmFCGGCTiaj8CrYAuuwIXlsUeMNrjmUyt
         /dYiXN4aVTQdzMwRtrGWdKFDsSFbsvmN/jYilysuxX7hKt0N16+nEbkCdXtrRcNPf27p
         XNoVxO/s32vhIS80Z2MpIJX2hz5Taoe1H0Dl6zftArOABJFcHSU1J2D5cP8Df0bklADl
         lJqyJT+DBrGppLr1LF1Hcr7BURvNSGiGfD5R4DiD0esrtk0CWafNoQHh+jvso3fQJD4E
         UajTQ5N1kFh1EI8tTwsHe30CtdFLRZ23GAdKBFnE1zfh2ZfnsfRcxGvIXcUHFO109HPn
         Z3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270363; x=1793875163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qi1ti4izdBvA4FPvYxDV0dCh2GnisjK7L+m92EFw0NM=;
        b=1L+/Sg6QJXrAozirpqnY9HpsEDgbDFZ69BRc5Hhimg3UKaKnkZt+FuXpz5css2g8si
         gGL9oLCT4woH7L4wEcP5aVW7yxBpGo9r2lfmxmZW60QZmeQfRsZi8PlU7w4It6x9lK0N
         9rRc/dTM4QffOGg3Jtd2uoWnioqdIeKqpD5vUGcx30grbDGN9RnMIKdalh117MnexKIk
         HGCjg0/O9Sv/P/QbeuiDq6UNjOx4K6QZl4gvyd6+lv9KwLTg+G564rXpJ+OK3FvTFwHe
         fmjc2OWF9eYbfDAzNtU8GF+vPW75IdrNLdn/3yYcXlmbUVGdqbgnw3xr9bdRxRVtmllD
         X7DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfAVaK1qqzJ8xuZeYXbGBwEfnEDvnknW15txFm/vWxlJJUmWI3H0VDk10Zc1jFXG1D89EaGsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1G4Sh0qDjN0XUc7csmn4MHEL5O69S6PeAzNda9yCxrJ66YXUX
	CYVwE2zWyWAi7he/pncV8cfY9GCZdqSuSFGuzdj2A1HNqwGNxoDBOMiW
X-Gm-Gg: AYBFou19ZvxwHT88vdIKAECEU/ABT8anD7Xvxkhqe9M4v6iUT4n7WtK99VuNGiamyB0
	LD+y3Jpw5t4Fq/sIISr1bqCjSAlohFFrPrfSG+OWqRZMxt6Ic1yJDydtsdKVB3mBz5elI+wTpSc
	DuYIJw4r5vpNPs0LjYt6T80AOwC93gCr55DflEBP2CKRD1jUPeSG92E/pmKuvAeEvdJNwuXBrEJ
	k6eCw/FFeYp9TG9CSOBaNkUI3NS9aQCqUF+5RysP6y851sEIWjNgesAhVQNdL+vgNsv4JJ0ShTW
	eUmDKbJtuZHBPjpVBMMV2hVRj8q/9MXwRfwDkOpa+d+kgvuzV2tET4yqznhC732stEnbVTGrtWt
	R364O7Yz/zDInYPUEzuOmQgRyOqk1P5cZupFgdBTWE/tNyOywanypo0isD9Yla3fi7VsXE108kD
	2BJ5eVYNSQrc4QZJOesZVx4n4p+EwKxhR84DxRfvzXtoA0XJgZULaKRJfjl9c4i4oUT6ZtFhmZW
	SVbX20EmZjTapFzJaF+/3RRnYAW8B/E+XMws/Vqm138RiFMtAc5wgWCXFazfqcqwMHP9oT4CZDc
	K+omX6j1EAt1u8m8oSRv8fFv4h2VWzgDoaL8L/X31LeDUSjCDedJdr35BigziAMjHLKqJRP7FSv
	edHGCzljT/Xnr
X-Received: by 2002:a17:907:7294:b0:c42:4557:4532 with SMTP id a640c23a62f3a-c49d128171emr173949666b.5.1793270362388;
        Thu, 29 Oct 2026 03:39:22 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7abf6asm708508566b.81.2026.10.29.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 06/16] ovl: take a snapshot of the name for copy up
Date: Thu, 29 Oct 2026 11:39:10 +0100
Message-ID: <20261029103913.2785828-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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
---
 fs/overlayfs/copy_up.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 92b3d08a02349..12000e45fefc4 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -920,6 +920,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct dentry *origin = c->lowerpath.dentry;
 	struct ovl_fh *fh = NULL;
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -957,12 +958,15 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		goto out_free_fh;
 	} else {
 		/*
-		 * c->dentry->d_name is stabilzed by ovl_copy_up_start(),
-		 * because if we got here, it means that c->dentry has no upper
-		 * alias and changing ->d_name means going through ovl_rename()
-		 * that will call ovl_copy_up() on source and target dentry.
+		 * ovl_copy_up_start() keeps ovl_rename() away from c->dentry,
+		 * because ovl_rename() calls ovl_copy_up() on source and target
+		 * dentry.  It does not stop d_splice_alias() from moving a
+		 * directory that a lookup found under another name after a
+		 * change to the lower layer.  That move frees an external name,
+		 * so take a snapshot.
 		 */
-		c->destname = c->dentry->d_name;
+		take_dentry_name_snapshot(&name, c->dentry);
+		c->destname = name.name;
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
@@ -971,7 +975,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		err = ovl_set_impure(c->parent, c->destdir);
 		ovl_end_write(c->dentry);
 		if (err)
-			goto out_free_fh;
+			goto out;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -1005,6 +1009,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 out_free_fh:
 	kfree(fh);
 	return err;
-- 
2.55.0

