Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371876;
	b=Oy6lDM33VXpggvrxdxyWCttUvybYvlvQDLElSa5mQmDRUDRzL18UgSzx/jpB798f7lDe
	 X1J89NVwqbsmtKBC1F3O2tbQF4afT/pRwoj3l6ITHRLLDTD4Hw5NfarFybp7WPzRcWdQ2
	 UXVBeef7uYKaQ4hIroNA892fHzHrvixRBXB3bXYvZqsFRL/MY52Jgk09gjjZm7wXP3Ci/
	 RjUrgZORA4WTGqvpac5rzmi5w55nhQzlNRsiZUdp2qrR4sCSg5mVRB2AOPywv34ciLq8q
	 wZQJXEbgNshmD0BfY6lAPcw27bxFtByar3dHIU2Nqg7HzwaozyqqoeatZpvwEoArnWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=76A4WPudZsZy4CJtPE5LMtql++Tj2dohb2B1StvtAx0=;
	b=WmmdvkQOjbpTVW9X4wURzOHeCktW1XGly3zN6gG56cQ46GgdtXkgvQ6gPSehJvAS2v1m
	 5uoT6QDsK2s2gfJiwuZMorhadVq5moiNPuD94V3tz+ZVMC3gWv96o2NcIhQjqFnx3Z5RX
	 wtJ+7QBUzwHyljx+niyy3wMbPwLmvgj9pTDsyHy3usfhWbW/GR+U01fzu+zOE5Gg8+RGT
	 xuF8lbFi/JJg6GTSXvWxnL7Fqv4a//BgO3SvwbOQIslpU9EfqTpSg2IecowxNtlf303Nf
	 C5qK5tvr5vFqFBkcafbh0osJu07qkeIDi4Y4SV3OtzFEf9EsaxCL/ZI9ZF/2DhowfRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDml5vAB;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEE606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9BEE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDml5vAB
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso18561895e9.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795371874; x=1795976674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=76A4WPudZsZy4CJtPE5LMtql++Tj2dohb2B1StvtAx0=;
        b=aDml5vABEDkKy8vsbL8COyzwkkoQ65IJ/EAggkdXqeEmF24s9kd24MeYsbiaxzwR0W
         Cw3o2WQcaja8UqOGtGtCT561ukMh7lAg6gLEqaOYI3LKQxSergdTZCvR7yEbM1fmcZel
         ghDhF62n0JAq/SmNfVwRF7lVKklbAKmY4ZFtyojZmn3Xud2A5fK+ndU9kyYD7kCPqLUH
         yOyQ45G6TPLx3G+EsReFD6vLfhe+kvNLWbbe5NJcIHAdZjlX9Jo/yvZ6LY1w0IlyrpD8
         RTAXzloYIEBO081PQjjcraJE9wilm6GBqDtHCqDCzPXHnA21vymOwXgQh3kFs5Gi1qwJ
         qhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795371874; x=1795976674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76A4WPudZsZy4CJtPE5LMtql++Tj2dohb2B1StvtAx0=;
        b=a1dJqaUbD14Vv6wGeeTJ+Dp1g2Fj0VN0upSNX/BIwOdELuET+IxxmYqFfAKTZSlepm
         gLlSRl56rMDZ/CRQUnU2HEo3VVIUou8mTFOmgmeS5A7LuxVGG8hShEyqsfjrZ9rmojAC
         O5iI6estQwUIaYyZYmGKDuJV99PYmpAn0sSW72w4WuAFyWZWqt1yvnmyQOMSPDFMiQVC
         WiYwr7PzJqmv8vDOBwqAf+WFs9NS5UjKXzXQTKiPji5NPjHkUYiVcrYMBcDjwbuF4+u/
         2MPmKD/6b3ZLH7pxoLYDXmAg2Gy3YUpRwMLg+uIkM2l4XtubZgbnMcb0JVqVJn6Gdx7v
         nNmA==
X-Forwarded-Encrypted: i=1; AL+hErFrOEFg2Y/TCJIfwxeZsR5ILQTBwox0YTNxtwO3MCirUx03Uni55dCT5S9cCDi7AxauwhTqq9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GRYQfZwlU6186pv5wVYZHBYQGH+YJl+MW1MV6XN+//ydAcdgq
	841wUMr4LI62QgfTZS+fJeoZHAlbsMtY4s7prhUvgcY2Uo8CPn2k+jjT
X-Gm-Gg: AZFdTZfPltnLhbUuu6h18HiQETYVTJ+fbcDVzJbg2LBCGytRpRLAM+OXj3D27eNwaL5
	h4ykB16iqZKLaex709fHd+BPUyawEOz7wtOmHUAlEcCWUui7iK0lSvmpfTSSj8m9eG8VorhXmSU
	nys7jgREe8jZzbhu5SOsmL5UeNBoAU6oXAbHQ0093YFR2Z3Ofbe/Eb+KqsHDLxg77e20CytbFO/
	c5ysdza08Ari+ic1svM9oM2aSNYXlO6UiR5DpQrQHwVxd745rzm3LOiFcc108fPywOxIDlzg9lz
	qYU1SoXSxbh0pOylWOiW0++KiGKwMnLf8tuvKWtn5YGGDnIMNgmd/bWaQ9wMXG71y+K6RwXpHHY
	WLPwyJn6OFA4v4qQ3u4s4e8qtF8OU/TvhRxXumjop46Wny+9EEHuKotWZjWSfuvyORIBf/nKvnb
	SKb70K9koyVzzWrc1JkKzEKBhmSDXWXx3nyrceyA9BZCAkGXl20vfTFCHR09FK8Y1khtjhDVcgm
	bYd/O884jpeltgIUpzePOIPBn9a/19tlpPuQn5cKXp7YskbOYowgUmNADzymBIG4NZJu+fRFaRp
	wBHSxS6MJauZljeeuQe8WcFlTFfffacOPvfoPCQuwImoPDSQh0fiOqV5
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr190688825e9.7.1795371874103;
        Sun, 22 Nov 2026 10:24:34 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f0f1csm112711375e9.0.2026.11.22.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:24:33 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Eric Sandeen <sandeen@redhat.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1d23ad199a3bfd6f9149@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] ext2: handle NULL fc->source in ext2_msg_fc()
Date: Sun, 22 Nov 2026 23:23:31 +0500
Message-ID: <20261122182331.13740-2-arbabhaider649@gmail.com>
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

With the new mount API (fsopen()/fsconfig()), userspace can pass mount
options such as "nobh", "dax", or "reservation" before setting the
"source" parameter, leaving fc->source as NULL during option parsing.

In ext2_msg_fc(), when fc->purpose != FS_CONTEXT_FOR_RECONFIGURE,
strrchr(fc->source, '/') is called unconditionally without checking if
fc->source is non-NULL, causing a kernel NULL pointer dereference:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:strrchr+0x24/0x80
  ext2_msg_fc+0x157/0x1e3

Check fc->source before calling strrchr(), and omit the "(%s)" device
prefix when s_id is NULL or empty (e.g., when source is unset, empty,
or ends with '/').

Tested locally in QEMU (x86_64, KASAN+UBSAN) using fsopen()/fsconfig()
with NULL, empty, trailing-slash, relative, and full-path sources.

Reported-by: syzbot+1d23ad199a3bfd6f9149@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1d23ad199a3bfd6f9149
Fixes: 98f18c76c2c3 ("ext2: create ext2_msg_fc for use during parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 fs/ext2/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 54a6c26d0..c99367652 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -89,20 +89,25 @@ static void ext2_msg_fc(struct fs_context *fc, const char *prefix,
 
 	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		s_id = fc->root->d_sb->s_id;
-	} else {
+	} else if (fc->source) {
 		/* get last path component of source */
 		s_id = strrchr(fc->source, '/');
 		if (s_id)
 			s_id++;
 		else
 			s_id = fc->source;
+	} else {
+		s_id = NULL;
 	}
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk("%sEXT2-fs (%s): %pV\n", prefix, s_id, &vaf);
+	if (s_id && *s_id)
+		printk("%sEXT2-fs (%s): %pV\n", prefix, s_id, &vaf);
+	else
+		printk("%sEXT2-fs: %pV\n", prefix, &vaf);
 
 	va_end(args);
 }
-- 
2.53.0

