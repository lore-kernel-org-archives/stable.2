Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855659;
	b=YcR+beIOsymkC8lll5aT2W8tsOpBsRD+hec21/L0IbS8HFV5JvqE8Kbr/nSsT6OgbZmA
	 5bNqQ3Pbteb1la6E8+0G82E6NM+8lZztjYmLcwpdQp1yAfeD+ZBSbBCTxlwJX4rOj+Cyb
	 lkEoMxfaK8CyfyUEnWK57TFblYItXdJpu4uxMLzJj2J7DogVAsFo+QFVzNBDaNxQF2ivd
	 pc30QjviAoO4dVpwdCAQDpIGc+5jENRVg11m7oDCLFah2tOO8m2bKZR7xfFfEZT8O5naV
	 yKN3agDAkmeFESPfq8fghPQiEP7ymTWUKYPMb++5/2xW/xVyQGgyC/A7Gf35xJmtcmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l1eSX+6egLtOu1lrQcTgUdiF++U+c2v1MrLX8sa3W1M=;
	b=ICHJng9oHoRRSrQ4vUG23SMq8x3uwDMDUbE+QSeBCW834/2crCqDIA6eEjQ61JGtl20g
	 bloq3B/2zslBGtnGPXBH5dZZhGKRl4wukABZVKANw0KNGIHzRjyHabZLv7nd8ZDBO8GcE
	 HJzRIGicYfUZaEFBc71x9XvPmUCS45Q0QCUk6nXEb7/Q052TPS8BHKLjNRpOD4jLmS+UL
	 tSlSVd0KqVOBOujmHeWOD/4lQZTRMhlze03i/b0qM7V/AUEuDPnY62feLUf3blQAVST1i
	 1OTqJ2w9NeUKI43T0ZtX9Ju+qJBwjXvrr44TnlbNlb15q+WttvEJY4wDlWwar4byhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+unyceh;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD5606A332
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2BD5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+unyceh
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d73027aedso565488eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793855658; x=1794460458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l1eSX+6egLtOu1lrQcTgUdiF++U+c2v1MrLX8sa3W1M=;
        b=o+unycehWeryTcRSxGc+h2Dc3fEnOliQuiQCdnsHRKUgGjU1AG+VdIjBDc5OJ68/MX
         Fpe/yCBi7FY+2rtIwDbdjpnvg/yefTvvXMgaRYbde75/NERLRS3xGmbER4QvbM/B5oY2
         1+9E0MDBPf48Xeld8f53td+67l3AHv/uaG3r3xbs2idFxelZ9CXTtNwyVtXG70aiK5y/
         ZW8T70W06hrYtvnuE/2WPgATmwaDKoafZjd1AT5DtdEmhZr80Nhf+dct+uOAQLwSkb8A
         g+ujz4/HpokjJTelStEbPwQ2duF7qjhwnyiUs2anNDhl3GIxwMkWB/Fgn894ykyOMDsR
         7Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855658; x=1794460458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1eSX+6egLtOu1lrQcTgUdiF++U+c2v1MrLX8sa3W1M=;
        b=0ClydP5B5oQG6T61YTOpQJroybE5rJWsartlSmGOJFn/6wnUUNMslizimmPRp+/yyo
         Hzx40qI74gbS8IuPWDcOxHaidFQmTUzD7G8hedGdh3FA/ZcKt3RdBWinF2JVvYSG7SJ3
         5XbEblGuAGRFmzqqdSKfg42aRb4vJRaz4XnsM5bOsr4zaGEihm62KW6e2lFqGTf8ZZna
         vemF74XZE5pjiyaXdKgIEjSd7uR+h031bfqCB5DJDM2WBn+A33SwMWxvo8bMrViyIQt5
         LKlN8VLeDJvN/s/tetFQejO2jPTGYM9QWcf4l5St8wEhCiYvT0Z7W6E0u7j8hUyt1bNa
         Akhg==
X-Forwarded-Encrypted: i=1; AKwUvBzlQGe2QOFsDxhR8Zis0igU6Zia0LBpgYAFqV0ctEVDyVWCjRM6m+w+A26WAeLXwJZJ/VnmCCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T+WDK0f063/NFv1hMtEWZGhXHYG4erpBT3BjvjcY6n5dsjRQD
	0UkMmR0x3PK7eSD0c5oJwwNo3QnGuB4+5o53xRJLEtCQjgr7awic0hjL
X-Gm-Gg: AYBFou1ne+3LYN5qzqty0SRMOtvoxTQYP7PWIJFHXPoJFrYXn/uGfScHKeQ1FIOx220
	y9XIxuL7L60KoAvBswVIeN8ryncezbbw+xrHRjC+3dChZ5Fiu+JU4sKLYvli6Ye1WDxJOBYmwfY
	0onbaci0Tg5i0zmW4mwV6KLafcw8WH/lwpvXlbCN4aRwU/Ba76cMyyf6SiDd/v2JiMpRjt9nQx1
	Q/QbPEb8hq1b++w+KQqh9J+qn3OsCN384HA2XpXYtNZ9lHw8YngJXBD56mSTdR/V3lEA7DpZeLH
	Hgc7BC7g73q9Ea1awVfzWY9bYIZ+F1kTLuk58+FF2Hm34akqRsMtY2YRTvftKSHkOpr1FfNwXzt
	IH1A9nvDBmgAJHk9kNsHeJFCALpyeCkMmgniQG8OuJ1f6znBoySxLWd4Lk3RZOTKLRernT5scDz
	6R0pYRw9vjpPmeqbD9PNgJ/X2DUnISyMVGMadtLXCQOiq2ooUltY0guUDgwGnDiy5ORLqIM5mwC
	8BgERbdztUMOvO3wVWYwZ7TMT7SDIf6Fn97NLo/Fc5gz4V8AX838ZZzLOuJYJRdlS01xq4lG3x5
	S6o6JQ8JAOoZahax3Mn6/TmNvhbtJhr1TlZHX2e5t3nu/K40NnI8pNKRxBIR5yHtQ8fdDgwaY1X
	j57izk+BFDxQniUcIkEw5Nm1J04LAB/Td8VRBjA==
X-Received: by 2002:a05:693c:6087:b0:369:f420:8679 with SMTP id 5a478bee46e88-36a42440304mr29748490eec.38.1793855657614;
        Wed, 04 Nov 2026 21:14:17 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36db94376b1sm6079160eec.10.2026.11.04.21.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:14:17 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaharkes@cs.cmu.edu
Cc: coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] coda: honor the append state of each write
Date: Thu,  5 Nov 2026 05:14:06 +0000
Message-ID: <20261105051406.52442-1-dennylin0707@gmail.com>
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

coda_open() adds O_APPEND to the container file's f_flags after it has
been opened, without updating its cached f_iocb_flags. An O_APPEND write
can therefore overwrite existing data instead of appending. For example,
writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".

Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
incoming IOCB_APPEND state. This also honors changes made with F_SETFL
and per-write append overrides instead of relying on the container's
open-time flags.

Fixes: 164f4064ca81 ("keep iocb_flags() result cached in struct file")
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Keep cfi->cfi_container as the vfs_iter_write() argument.

 fs/coda/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 6ca8bfcb58f2..c9fba41f7cea 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -71,6 +71,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *host_file = cfi->cfi_container;
 	loff_t ki_pos = iocb->ki_pos;
 	size_t count = iov_iter_count(to);
+	rwf_t flags = (iocb->ki_flags & IOCB_APPEND) ? RWF_APPEND : RWF_NOAPPEND;
 	ssize_t ret;
 
 	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
@@ -80,7 +81,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 		goto finish_write;
 
 	inode_lock(coda_inode);
-	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, flags);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

