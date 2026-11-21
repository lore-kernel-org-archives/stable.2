Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795234455;
	b=Ayj02c+DUXMpq1V852DLjPBNukPjrp4ni58mDGf1KapPynkx3yuEk4ngdry0BiLKA+33
	 Zy+x9y1kgKQsyeI8e+Bmfv2cp2bliuKCHapwdpaI4TuGZowNpeWkwp7/ifpkC+3JdNHFH
	 P6Sjz4Ly/QR4oCLEadBx7aX59E2sfwnnhgCSoZuRNADVD/VpchnhBDZvJIbNCsNIg981n
	 riCrLN6f8r65WacQ57tN90WOES/ci6F+aGNvEf4q6Njs+KhovEzNWuNaV3gmcDPVrph8A
	 ff7uqXS4PhLFCYF6UwlvEhqM3ldin3LCOYMVuJD80f7KVYhj6sbcJg8u6C/0JpAaZjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795234455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s1oUBUVsJdLlZK0BnMYfKVB2CVE8s/YWPNE5QQrqzaA=;
	b=EFk0Sko+p2LnYyZXtfyI2svQGa3TOZT1vCmUaLv1jgGcEcldQlo+desLnwnUYmrQGByU
	 ncvvu5e5ATuE2Cg7KifMQ5ldg3fkG+I0vv5r8hTQQMC/daGKbSyAqAgZqQjHmd7UwbUuJ
	 T1+YBZn6YcBzZzI6ROQfHjuHXPGHy1Ea3N+mZQbjgkhAQD83Y4HmeclqEINXgPnVEaRND
	 Tl0FmFqeGih4BN/vbwg3Lhn+GdQAAO/N3Sv0B679VRiqzru1NJMx+iAGWrY3b7rEimIWZ
	 J51405MATxjWyWVi0ReSAa4UmIRsymdazLcPmUtV5Mxy125YJOyFTB9F91m8jQwpwKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=perfloop.ai;
	spf=pass smtp.mailfrom=perfloop.ai;
	dkim=pass header.d=perfloop.ai header.i=@perfloop.ai header.a=rsa-sha256 header.s=google header.b="eD/tFb9W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1E606A685
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD1E606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=perfloop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perfloop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfloop.ai header.i=@perfloop.ai header.a=rsa-sha256 header.s=google header.b=eD/tFb9W
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4d198f1a591so1526384b6e.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:14:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795234446; cv=none;
        d=google.com; s=arc-20260327;
        b=GaFCm0dSn0z1WfmQpPi7WPn5WOvniPAtBPtjAS9jtBaB2KmpjR2Hoe21wdh5WPXYfp
         YTj9AYijBY9rBWRtjyfg3Zw+Xshde1F7+1nnLmtPMSHAAWkmxSdLSAEQ++fg+DNVpzVj
         JDqSKF28PnYt7UK2hXpq342nZo5MyCQLNgEWcf7n6HPhDBAKTxzAG6rZrN9c1aazR+xO
         Cnnc8qQaA8M6jNhR3dcDXnFzcqhLU88/o/sWm+2i6LlcjHp/pBIpY4yDK/CIGjIzOGAd
         a6o+I8FDb9NNF15SSP3zAv2EIHGSg5FK5FjB8eSqC2FXueRKUlUsyZGriVD0eIn2fO2s
         xvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=s1oUBUVsJdLlZK0BnMYfKVB2CVE8s/YWPNE5QQrqzaA=;
        fh=FRaljPhrk32STkRVW/V4qiyVndDH8qXpEU7IYi+VwJU=;
        b=Hb/kGnauOtpHfOdInfx26fLNKXF4qyZfstpcp0izpQfN3+8Fk8p+Q88GXMBAlX7xLV
         vAum63a2GUPWord5IJCdsVHD39U9D68ic3ftvTlPEcUjdl0U1A6zGYDYHgAvLqKiV/w6
         XRyaoT9TIMfT7+AdXOMypANoNDC4fzG5vZpQBd2u3PRU/MIKahFQTk++pwtIadzD0UKZ
         DJZXfqzf1skjFD8+9ifJQSIVhNfTxVPkC0bjdW8c7P2Gq98XU2z18LyfE1hu2Zlc4Wyk
         or6HuazukSLddpy6ib2CYJAjC9Rft+oQ1tIKM8owcwbkqLQdcrtHpTAtvb5BjBDqH96/
         DmLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfloop.ai; s=google; t=1795234446; x=1795839246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s1oUBUVsJdLlZK0BnMYfKVB2CVE8s/YWPNE5QQrqzaA=;
        b=eD/tFb9W0QTkZfqXX2nY5syzxoHKkMcvyjIGZ7Wk1DVYUwMwEfvGxY+UxaJ2PAVwxY
         uQ/yNcPc2mIkQA6v3NAk7JWhYcWgCV7X02rDRlNSgR1+E5S1Fym992p5q/+xwqH3bDUS
         2aW/FfCl3UW3jPngIzEVKSbwo5eRz+f2bPx56lLGX3nsqCCgBv3SpKk9Zi2NLLKeVVrI
         Tp6jDVbYVE9rx/Ovu/yF5YQ9gOb9ZPscWckCvNdwJlZTuSfB58YOWRs3Wxmfv5tuJgGQ
         nZzej4qYVdSJCcmyF41kXyDYTRcohlHjMIiB0AZQ98VGF9YidyUsb5LwXWmYNVB8SoeR
         jrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795234446; x=1795839246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1oUBUVsJdLlZK0BnMYfKVB2CVE8s/YWPNE5QQrqzaA=;
        b=oHJHeLty37wokY/Ju/h0ch3NctaG2Dhy0BlwmRRrDlMMLU/eg1PrYh4hlshdg2sGoT
         Y3ZALSRicZ8pEkGagski7W7RfNu1KLNGXJzJDLvpq7WE/IR1XFMZnu8v2DcA83V05v9g
         kY3ZEHp8t/9HZQ5QyW51BYko+70ie9UjkAP9ribT49VNsFbeLw5QKKDIghdrOKzrM3ux
         R8UJGG4BrhFbNZ/rJgbtaX8RkgLK6y/XZ8+jGp/OSvw7eUmBQvRriWSEMC8ky32wDu2Z
         mn7AwXwmOV4u23+rh87/baeUKw2aTEw5HIdsVNgY2XdBbfKofdmN6FSv5zTeM/ehHNOE
         eExA==
X-Forwarded-Encrypted: i=1; AL+hErFrtRyvIsHzys0qHZinU2hs5Z+sTPE1w8LiH/iHSQIE89dT3x52UxMk0xhRWT0lQYAmpW3J7Ds=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oAR7fHIw8Nx+QfcvMcBrbDuKGmAy87WbcjmO++LIH5M3A8PbJ
	tCrHn0RCpPk1goIEMAJQG6J/UYFjC5uwQ5SYY+3ETLz6q6SZA1CCLw4kXwdacIFo721Z9GtKsYD
	jLCdjNJhR2reSK1B+ahcv/Id2GYK7ngdltjREbanNw0g=
X-Gm-Gg: AYBFou0b1XHljhD4i3/xYTvUFOb/giYTAgkU9BynWKbENQWzpytZx3eE3bD5UEYfp2c
	TY8MjzyF7bVUS1RJQesOj4gndSS+CPUFFqDu7UhhBQ9v6dRrT32K2KrlnuufabVkX/7h08FYIPo
	TwEC69RIRCe3C+kGeSnl4XaxjJy9/GBzV2R/s2rYd5nctbLSq2tjk8H4U0+7mwheww7DPvJq02d
	XdusE+pZErCTuCbGHpZHwqJi1P0i0vP4OmiqZVuNCCqO7Z/eIDrEd3PPoxEWex0lHQSvok3+ibW
	er+cwowi1LJQQwrJEwZNk5MzrOkQnmaMdGveJcUDHVFES67xL6SzWleD8V8UOrW08tsGgSuFYVQ
	BxuHYup8r6d4xMS3C9PEl/lGZmVrTdKQY0blctDhLYmaOML/THk9yJ5yObJ7Npp43SvQugtO42U
	VCoydirRj9cwfaAGXfAP2F1W2Rs/cIVHhWBrlnVUtXkkwlKHguwjyGKW8Rtn/dH6VXA7Gqiti4a
	PEOXhjCLKzbx3Ty5mCvjH48ky0BhnxTfqTWU9ZqpmydKzZZeg3+BzLl5h/McGMm1xGUXszOevvJ
	D9RN9sTjs+YDLjhGPkevfwSr7gSikx7srSYlOk37Vw==
X-Received: by 2002:a05:6808:1645:b0:503:8f9d:f11a with SMTP id
 5614622812f47-57a0a10c7a2mr5856561b6e.29.1795234446035; Fri, 20 Nov 2026
 20:14:06 -0800 (PST)
Received: from 202080787392 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 21 Nov 2026 04:14:05 +0000
Received: from 202080787392 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 22:14:00 -0600
From: =?UTF-8?Q?Tom=C3=A1s_Senart?= <ts@perfloop.ai>
In-Reply-To: <CAEEBa3XJt0XU+5pXNQz_tjZyPEeEnY67i_QGupOnHLnXB=BVDw@mail.gmail.com>
References: <CAEEBa3XJt0XU+5pXNQz_tjZyPEeEnY67i_QGupOnHLnXB=BVDw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 21 Nov 2026 04:14:05 +0000
X-Gm-Features: Aa3M54opRXm5ReTm4e3sjvrgM48zr-FpYqoMbn_tWRbU6Gsjp5HSemBksayrHS0
Message-ID: <CAEEBa3Un8x208Ox=20TTmGgcmdMSTCC41fB7SWP7uuY1N3xLPw@mail.gmail.com>
Subject: [PATCH v2] jbd2: fix fast commit recovery failure when the FC area is full
To: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

jbd2_journal_load() sets j_fc_last to s_maxlen, which is the first block
past the end of the journal, and jbd2_fc_get_buf() never hands out a
block at or beyond j_fc_last.  The recovery loop in fc_do_one_pass()
nevertheless runs while next_fc_block <=3D j_fc_last.  If ordinary fsync
use has filled every usable fast commit block before the next full
commit, recovery reads one block past the journal and jread() fails
with -EFSCORRUPTED ("JBD2: corrupted journal superblock").  The
filesystem then fails to mount after a crash until e2fsck is run.

Stop the loop at j_fc_last.

That alone is not enough.  ext4_fc_replay() calls
ext4_fc_set_bitmaps_and_counters() only when it is called again after
fc_replay_num_tags has reached zero.  A TAIL tag always ends its block,
so the call that handles the last tag returns JBD2_FC_REPLAY_CONTINUE
and the finishing call used to come from the next block.  When the last
fast commit block is the last block of the journal there is no next
call, ext4_fc_replay_inode() has already cleared the inode's blocks in
the bitmap and e2fsck reports a block bitmap difference.  Do the
finishing step in the same call that consumes the last tag, and drop
the in-loop copy, which would otherwise run it twice.

Reproduced in User-Mode Linux with 1 KiB blocks (mke2fs -J size=3D8,
63 usable fast commit blocks) and 4 KiB blocks (default journal, 15
usable blocks): with the fast commit area exactly full the unpatched
kernel fails the mount, and with one block fewer it recovers.  With this
patch mount succeeds, the file has all fast committed data, and
e2fsck -fn exits 0 with no differences after recovery, for the full,
one-block-short and three-fast-commit cases at both block sizes.

This bug was found with Perfloop, an automated code analysis tool. The
fix, this message and the reproducer were written with AI assistance and
reviewed by me.

Fixes: 5b849b5f96b4 ("jbd2: fast commit recovery path")
Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Cc: stable@vger.kernel.org
Signed-off-by: Tom=C3=A1s Senart <ts@perfloop.ai>
---
v2:
- Please do not apply v1. v1 only changed the loop bound. As the
  Sashiko review pointed out, a full fast commit area then mounts but
  skips ext4_fc_set_bitmaps_and_counters(), and e2fsck -fn reports
  "Block bitmap differences: +2113" (4 KiB) and "+32769" (1 KiB) after
  recovery. ext4_fc_replay() now finishes the replay in the call that
  consumes the last tag.
- The reproducer now runs e2fsck -fn after recovery.

Tested on torvalds master 65e4fd942f72a9dba0e4e257290c4fa1aa756854,
under User-Mode Linux only, with one journal size per block size, and
only with INODE fast commit tags (no create, link or range tags).

 fs/ext4/fast_commit.c | 9 +++++----
 fs/jbd2/recovery.c    | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0cac890cf370..5d9b95817ac6 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2608,11 +2608,8 @@ static int ext4_fc_replay(journal_t *journal,
struct buffer_head *bh,
 		ext4_fc_get_tl(&tl, cur);
 		val =3D cur + EXT4_FC_TAG_BASE_LEN;

-		if (state->fc_replay_num_tags =3D=3D 0) {
-			ret =3D JBD2_FC_REPLAY_STOP;
-			ext4_fc_set_bitmaps_and_counters(sb);
+		if (state->fc_replay_num_tags =3D=3D 0)
 			break;
-		}

 		ext4_debug("Replay phase, tag:%s\n", tag2str(tl.fc_tag));
 		state->fc_replay_num_tags--;
@@ -2656,6 +2653,10 @@ static int ext4_fc_replay(journal_t *journal,
struct buffer_head *bh,
 			break;
 		ret =3D JBD2_FC_REPLAY_CONTINUE;
 	}
+	if (ret >=3D 0 && state->fc_replay_num_tags =3D=3D 0) {
+		ext4_fc_set_bitmaps_and_counters(sb);
+		ret =3D JBD2_FC_REPLAY_STOP;
+	}
 	return ret;
 }

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index cac8c2cd4a92..a59de33a2a4a 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -242,7 +242,7 @@ static int fc_do_one_pass(journal_t *journal,
 	if (!journal->j_fc_replay_callback)
 		return 0;

-	while (next_fc_block <=3D journal->j_fc_last) {
+	while (next_fc_block < journal->j_fc_last) {
 		jbd2_debug(3, "Fast commit replay: next block %ld\n",
 			  next_fc_block);
 		err =3D jread(&bh, journal, next_fc_block);
--=20
2.55.0
