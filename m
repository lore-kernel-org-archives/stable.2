Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819663;
	b=1lGQiDgMLnEj3dqc1fWMcZ2OdMR3Qr4GaT7f84y+S+o+yipHiGxoSKFgwlj33YB4g/W8
	 vbLNaha6VcVK5z4oM8OFsH0D/kkBTLDtp0vGWt/Ne5J58nGd/s9NQwGDLJp0jaNoy+W3O
	 M4uXxlGSt+9ej1aPPRwe4g/17WbS3y1VLehR6JwE3Pdyl/uyk2JI9hxlhSv3GIrM6sXxQ
	 Uk04o4x2TXoyvAx8+Gx4sO41jNNRO7r+yHkoDFI0J4924YCgaYH+JjTQO2UXYSlbkfYBy
	 X4iqk22lj3ZYlhtLCNWmNmm6PBi1zqTHA/XzGx+AhsNF0FvpcYnDEgc7h+sSUfVZICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xITUvna++NkI/eBI/dmyMX8RAsKhHBfiqDAe3Yile2E=;
	b=zzTdvcu3db3tCUm0HPOQLSDsPxT65RANOpSWZQidaFNCdesr736aKD49ZmZmo7OmegtJ
	 nB0oGwfZ/QJKGDFwoExD1ZggkcyUYD3BwGh2d8YT63n2p61leXoTOJmv2y1dPyEXsBMTQ
	 Z0wGge4cDP1UhqoqXZ6PDYw5p1ueX0GWk8ISaCzitqUfUTj9SauKBHx8jer0ZIBwPqsJd
	 ZKFCCp7LCirlQI9drogJg1cv7dwPQPHYas3nJbXrnhQVRfwnjJ0X2VIPNvlRdue7GwfCj
	 nnjDaLsi2ddAZ+BZcq7vCDBczZh8kD53AiYkVv6QGZef6WE7jBQytVD4W4G7lErbqzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcfxRMy1;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C6606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13C6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcfxRMy1
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36e06480786so13458eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819662; x=1794424462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xITUvna++NkI/eBI/dmyMX8RAsKhHBfiqDAe3Yile2E=;
        b=qcfxRMy1w09RryqXTW51hmWDlaOIQBBSRpMLN9d1F9lfCHcDP3GnDWzmpdHNb/1tvw
         BBIvcndRsf9hqsfhSYOHR4TiJD2P4WEPRTp8YaG41eKfG2CReL5Up1YXdLXRlEGkMKMs
         E0NAcm8YmnUKi2eln6RQ3TuOCrQai+bY20NLZJvtILd7aGT9L1+bplWyRIlF0VoIJGOg
         qqso8LaJ9LCKdOOnmDlHV45q8u5VMF5DYUQ1EEwMIjpR0MY0hL/4/AqwZr8MWplcfvvk
         bItWFr7ZjDZGig92HszanKDHuyAqv/NByHnN6ke7EqNlgrWC4OfGvek2DA7is7yjOtWa
         kQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819662; x=1794424462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xITUvna++NkI/eBI/dmyMX8RAsKhHBfiqDAe3Yile2E=;
        b=fCm5QwmLLp2aP/Mvog3lNwxzzLuUGZnkW1FCePllXfcv8tZXykvbNcP0mdPDe3F620
         3ik/jpQ/AKrC56kUd1aN3N7smKDE00TvWK/xfKgcOG/CSbMXybDGi8fc8zxSaowbacAv
         SCZ/E9HYdUSqJj4xtZuy0/w2yMc25p9Pbz+Bc+nDwOGuzIg5AKco6T6oWfy5jTHtm5RT
         SZXkZU8rnmSg3Pr7s788ffWzCLyLeJyAOZ4p2+fNonQMxasJPonDocKoFbhAYdY2gGf7
         7o0IVIZrwIR+zOd6TU16mZYw+LBEedajuTxEnbI/v2OSiZu3oEBLoHzUAy0x9YOfE3q8
         KIVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbpq6AC82UWGAOhjHh17vw7/ZVTyBWJiIMoiZQMdxOAu/xDq1PcVf7GUcrDZoKUxhPv3p5Wwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EMWpUkaOGsnNs397H8jUHHxGtOaB710AGNEfJWXi6+xItEHr9
	qSiGMCceMqXYVy4smQ/LjG0McHzXJUqU+9vCUVrnWnr7W7xSNbDcM12p
X-Gm-Gg: AYBFou2G354qJHGIkyYekxks7rw8tDY7lKhCfOpXoWmVfPvaIVy0myAH2mgMd5pJaVw
	mqFKuIAzGVNJEQ/zZ0PYew0TvLoenUmtbS5dKaz55TfspruZ0fOiRshy74U6ErNg5K7p77KMZ0F
	Sdf2vGg2k0s8LjW8Wa4XbAETlPFzIGO8MZ25k+yE4uG63ouYrAxjAyhrRC8V+g752UdFaa4x2FZ
	85fTbAF8sW07IEMZ4jf42zpbCXyRz90hyTVTTKj/FiKioKKKcQl2Qwhr9Z4p41JxV09vGHoLgbX
	rKC7jREk2PvAx4UcYjFciEd8SCtgsMhKOT5PwG1ndaftWQJRQox+1aJz7411oADtqCt79vfVF4i
	4IQu2f/4CbRPgeeZHp0dq9Lsxfe2UkMbGoLN5eH67PVBDmT0fY/maGGJXgktcZ6QRNI2DhooaI0
	W1DV6yjcNM/zPci+ruPiZHNHdAY7KvehYo407HB/yQjiqfDHATsC1gPxC7s28gOgjWKSMGmH6kn
	aN+XPbbA7eL2LyNkhlqenuCLAIfFxPGFxiQ2V1tD4FZ5T20GZ4Vx0LMpQQRHLDcspRgJ3876Enw
	KIVbmvuhT6fxAd/OuzDbpXIwNOrDWHN2rNbGk02Y9jpeP96996xnLQTuw3dfuJE94C/KFqJqOud
	t06r9lOjvyC1HIb3FoqdSq7z6saKUTB+SCMtzOw==
X-Received: by 2002:a05:693c:8803:20b0:361:6884:78b1 with SMTP id 5a478bee46e88-36a423bf728mr26751356eec.28.1793819661646;
        Wed, 04 Nov 2026 11:14:21 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6d3dsm11367318eec.7.2026.11.04.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:14:21 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaharkes@cs.cmu.edu
Cc: coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] coda: honor the append state of each write
Date: Wed,  4 Nov 2026 19:13:55 +0000
Message-ID: <20261104191355.89544-1-dennylin0707@gmail.com>
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
 fs/coda/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 6ca8bfcb58f2..ae03f0b30d84 100644
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
+	ret = vfs_iter_write(host_file, to, &iocb->ki_pos, flags);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

