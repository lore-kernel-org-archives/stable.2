Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117889;
	b=2i8LGMNJGlZffljabrc2k5fwwR4ll88CxsaC8ii7PwlFuXN/VF8nDio0HZOLooc2Rqga
	 qGeGEeim5kKofZNhVL1BzPhAVEa+7d4yEMWfnreRP5OXPdagRImhqDxZNcEBCbNFRElZs
	 oMAMl7gW7Xx/0TCubTmuPDsaqL3vmjZobgfVvFZTAWf1ozujp3EMwu446HhiGLeG036vw
	 3mmOjElGq+pZ2yjHorgEWZof8qDOczmDJR3lzIoY+Fpw77+8adKIg1Jo+PxULVw+cD6K0
	 k0XBHbf92f6qpj1EPOdkbKub0Nk8QaMtcJbHGNOUJlVSAN2Wxj2NfDkTdQuMw7iHmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DPXZ2yO3cU+s5EkiY6YjtMfPdHRJToYSpXviTD5gzv8=;
	b=AY/PECEBClv1H7qQFbbLTd9IgdSxBZ//1dyRfBj1EQBRNT1UWnZ1lm4r5+/P9GrD1PIa
	 GH3GWcuZZUzAMm9TvUTL+P7MVPHBtNyJDtJl9pF+CSm7qWbdGpxkSkC3B78RbdXlALCLP
	 bngG7XA/EYDexzRwhB7gjim32x6htiSBkN6/8XUBwMmQkTTQYmZ/mglobrLG3/EqDKT3d
	 jinyMqAqfu2NtVxCd2ybrxze9X+kxORv3Ug1og2cjDp7eo+YbF49J8v8HaJ/9+Jlx78hs
	 O9vnA62L3gn3zpaDHGSp3LVBvDNIcblhyvjQfHrHM+vICLGROvb2knkLW6T9f2a4qKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+JlxNbb;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09278606A322
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09278606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+JlxNbb
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ae4be9594eso5003697b3.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117888; x=1793722688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPXZ2yO3cU+s5EkiY6YjtMfPdHRJToYSpXviTD5gzv8=;
        b=O+JlxNbbBci8nKYL2Pt4pT1VkmDlJsEd1AdhRhqw9wYVP/lt7TDymN6QDIQOPZVQq3
         HUA/xOfvzFYdfdao/+3O66XnwpitnwgsFXdhICCmraATdxZa4LwGXUdvwwNukG1cLe2L
         5qN5g2BveaYqj6x+IUjtD/oWIa3LZHMZPB3OSKx6SzVBcL5HDu5em3O+ORdHWQ3qqStn
         bIr81WEClQ+YbTAO/hc5rh0iDu4rFJUC6zZclKwpjN2YSRsr8Hcj7dm1GheulqnVJiVd
         7sRV5FMdTBhs48Wh/8Cmp0zYffAFLRWmoEY1HwUDDLAVf7U7NYOpWKNLQjx8xM2ecX1J
         lOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117888; x=1793722688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPXZ2yO3cU+s5EkiY6YjtMfPdHRJToYSpXviTD5gzv8=;
        b=Z64sXAfLsS3e2giK1PYLEfCmWOthZwn83tGxgzNirErgcoAHJtjerLatq4yrdr6x8X
         jpfmnuxct6Z8GOXt2EmZjpZ1ypxi7KQ9A2zawuSlwhbHxWJCpNz9xfqR3k3X9HcHI7ri
         v+9FvtPCoH6pb4UPAR289VjwHiZA/R1Uy3PH7PDKvajCYyJeUpHz6QJNhq7T11elVHS8
         J/kZJUNqbEHXY3ICNL5HMK2ZuIMp4s+5frSwArZGcIwiz/I0hUNBIXsqQJ1qkx+PcWSG
         vovM9wPNIPDFSWtFhzr79ZiNB1CzKDbCRdhDtd30mhWjP8YA+1XHHqK2CDB5cgifyMeF
         gpfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUySzntBlVwPDeZsaQR5czjNXs+lGwOvwEfcPdY6CzUupoJSUjqcmqIZnsv50s0YhLIfY6ce8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKb+Ql5kYr6OwhXji/0m6y2IQN8pIDelfdW3xnfp7TUKSoVpegl
	toQVyqtGIj650EYO887Kr197hcH5s/gRsXjUqGuu3l2vG87BkXMAmHQA
X-Gm-Gg: AYBFou3wDcZkuNsxNQWx8m08z3EP7kK4Cu8qHPbqQf5k7l07V6S0bWk8i3HAQVKUoLU
	3lnKKzdKkH3/1IVUFgz+cgosj6HfGXH1fiAQkGN8K48tgsV06mAhWVAUitvkbJX9zyDeDte1Om2
	CUSIvSJ8KbzdNniCEu0xv7ojQ5Zn7Tpq5pgbwiOaz3ShSeRjJeRgj0dGsxcnsyZ+1pKLcwrybSk
	y6iE60f1tlokdL2TXzZBOPWJt+6RdAG7oPPeYUlS7wNbLQG0bZ87ay+FwtgToKWjq+P7GHr6bKO
	YQiS4bSx1ZsjyEflkRgvC9l7PmretT1Bmtvp1ZiMLePEpaOUKaO0k94wWOdASccyCUoTIwXM+dy
	kuC+usjkZGe3xEdTZ6ujH8OdcnFQ6Kz+g5Rbzif4OZZ33ZQer9MgqScTRrVA8jgwTGstbQMKqRY
	d8nY/tuaTVwEHa3IQvltOEx6uqGf+LDMxd9T2mqpPRnJTmClBDtY9+3j1UwX3Ot3Y5UJ5zqTa50
	ZSsVeLpp2lslLs31KOkow3KzNybLQObFJI7Ns2t8cXsz/X80WA3BfI3LMnqc16fUvE7p8LvgoLB
	xVrD/bTwJXvge2NtV3TR6qRgpfP/xCw=
X-Received: by 2002:a05:690c:a847:20b0:8b1:a3dd:a6b4 with SMTP id 00721157ae682-8b1a3dda6e1mr20302397b3.4.1793117887797;
        Tue, 27 Oct 2026 09:18:07 -0700 (PDT)
Received: from tacolabs ([2601:6c1:600:2d04:4132:6a2c:2819:9df8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e656162sm15033077b3.44.2026.10.27.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:18:07 -0700 (PDT)
From: Reid Downing <skibletz@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Reid Downing <skibletz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] xfs: fix wrong compat fields in xfs_ioctl32_bstat_copyin()
Date: Tue, 27 Oct 2026 12:17:48 -0400
Message-ID: <20261027161748.2760321-1-skibletz@gmail.com>
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
Content-Transfer-Encoding: 8bit

bs_blocks and bs_xflags were both read from bstat32->bs_size.
Read each one from its own field instead.

Fixes: e94fc4a43e5c39 ("[XFS] Add compat handlers for swapext ioctl")
Cc: <stable@vger.kernel.org> # v2.6.29
Signed-off-by: Reid Downing <skibletz@gmail.com>
---
v2:
 - Also fix bs_blocks (spotted by Eric Sandeen)

 fs/xfs/xfs_ioctl32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index f6875a2cc70..77bc936bf0d 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -143,8 +143,8 @@ xfs_ioctl32_bstat_copyin(
 	    xfs_ioctl32_bstime_copyin(&bstat->bs_atime, &bstat32->bs_atime) ||
 	    xfs_ioctl32_bstime_copyin(&bstat->bs_mtime, &bstat32->bs_mtime) ||
 	    xfs_ioctl32_bstime_copyin(&bstat->bs_ctime, &bstat32->bs_ctime) ||
-	    get_user(bstat->bs_blocks,	&bstat32->bs_size)	||
-	    get_user(bstat->bs_xflags,	&bstat32->bs_size)	||
+	    get_user(bstat->bs_blocks,	&bstat32->bs_blocks)	||
+	    get_user(bstat->bs_xflags,	&bstat32->bs_xflags)	||
 	    get_user(bstat->bs_extsize,	&bstat32->bs_extsize)	||
 	    get_user(bstat->bs_extents,	&bstat32->bs_extents)	||
 	    get_user(bstat->bs_gen,	&bstat32->bs_gen)	||
-- 
2.53.0

