Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979905;
	b=bsJ9AsqZlhA5UiKTLLBtMyxmbjuo/RX3HQQVBV7AabwCP8MAGfTz1Zf3wI0MJX7+MRnc
	 TGXWcqZAu3tcrjS3S/Y1GBtevJwOEuCC3Uvp+pYwvnl3le4gkHn/VnFJbfiiL5w/VMULQ
	 rldXvsWubPSk7gn0yXbAMnqYSmLOOtNkOjP+ISr34Xz5OoUMjjb/VPLug/laAK+T8ZlkZ
	 8jGwGzPU7oZXL86A+LqK5fBRpsnBHLNt0uZ80ZbOz1jkVQuQIP7oLpQbO4pK1wqInDVv5
	 x4MzJF0tABwzASq3K1b1nkk8RNUbH/BPh0NAMRnOLHGd5K6Ex6OPi6MXqSPD3iEH9KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OJzaqNYQam3G1mnM1dtOnV/6df3rTe3VoR8V9wQk5ak=;
	b=K6fc+PbUqZfd2eF7Wpwh8P1dFhruBgmpYt/08S+rG2Uu3d6O3A8MZ4OtBaBHmke7SLQ0
	 yIHkXo/0z71BTrg5yBJ/wWfZkuTjwAEdTrYvDvF1VbQ2qL2r8Ydy+uzrIt/m9AIxFv3+U
	 K3NprZhajtoxqP2OpAVad55+nOvuc2gZRcDZKRFxZp2GUTq3CesUtuluCwWx6GuEPDhsN
	 nNllTZCl1CDNkBLxbEPE+lSAspHmnC8WhX8iGz22uPpp3wydoXT/eJdBMZqZTCG96NG7N
	 pWiUuJFyqEAQ51QF/MgDxcVmS8rLBQP5ED7If4WFLosczKNj/+krQvBgpaTTxOMuxqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BVNzoBqP;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C85606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BVNzoBqP
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso4887457eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979903; x=1793584703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJzaqNYQam3G1mnM1dtOnV/6df3rTe3VoR8V9wQk5ak=;
        b=BVNzoBqP3fDN0Homwj5TbELiXSBF/6BGiC6AumkF+bgVwlaskN1zSKmD2txEKEN8ZE
         TJlflk6uKjqJ0VPFqleroermHqpa994qUManfiByxpJ2zSnlZDCGpfCA9NvceUe8qaG6
         Src3Sb9aC/IA6n99PLVg9DPxabxPsizmLIUhuuMBw2EqWag+RKLa5CxAVVdnIwe2DAHd
         /bGQOWyx7BOPkW91+aAxpKguys3il2O5BEtwZZzm9vkzu8dflLPEOIzDRTa6YVOT6PmC
         ScSI/RJ8ziFeeD1Zy4LIBMDxlYpnjFR25S6qFfGzfg4X7Vj2NOC16HQAwNLOwCIKjXyJ
         6ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979903; x=1793584703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJzaqNYQam3G1mnM1dtOnV/6df3rTe3VoR8V9wQk5ak=;
        b=UJnZfWfxPOP9kdYe1rddQShgaSbzbDTnKrdLQJP5ZaPDKleD0WYEzBE1Ql2YITTs9L
         GZEhNav8NlydjzfwYn3uG82FNGf8Iz2zoXKXF/jonWRIGmNG7bckvpUtM47X5pkQ5QE/
         4Y8pxBa9qBiKOczTe+YGA7e231VrM9+NzlnLwnLHcRw+Wrgm2JGIa0orGjzxkePHzhud
         agr4EhOA1DBqk5FZF1hyPLVft5TeU2BKrACNVkXHZ5EP5HEVlIQXt3/JJ5/YfaKRemp5
         /UbrIXdnV0F1aej3IVVLppMxwW6tAnX3ekb87455lpMAF6vWFuVKw3PvXjVD/cBFnG0m
         +Dlg==
X-Forwarded-Encrypted: i=1; AKwUvBzbuq9SkCLaw9xyf+iWYkOOFtuEik9RQNDhUEW80PpDbbkFzvo8piQ53QG6BAfKFhL0CDXNdAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4XTXrEG4TIF05Pk7aI0nQmgEnAGG2jF4Kyl4Ux6IBc9QCLymO
	/B+w4euXEU9vjdXIuWJntoDTRxwuZG3yVq/eM+yMRxLHVKDeZd8WDZ6y
X-Gm-Gg: AYBFou3F802nYvBxLv9oTgUqNaW2EiDSChtz7fm53uzoCc92XUdvE5LLhxAENG5hph2
	YtZBSCF39H4AFEAV0cHbgzKt6bpHUbXDuVvUTuS/H8JsPU+0bGWaP3Sk7K7a0Yq1Q8ApA7JjHQg
	ZVZ68EECFxSRp05mcGhdv67gBsBjkK5rq/gt+lKdxZ61WZ/UwNfx0Tn58Sj4FznE0bxeJ1kGQI2
	zD4yFfKpp1b3bvXNrXkurAakIk49HuqiRdLLISrS6t0gCKN7bKCjKmn17+MegZHWwHhiv2vsgep
	o7n1faA5M2chqs1wNQsE/BWQEWKGyGXgT6ijov4lUZIfjmIvtkYMys8ZfMAP/l0wyy4OY0XPZXx
	zgMlaP2YNhAV71ZGfCWMObl21fJUhydY/9eTpojJTs0qyKko5agdrv8a3uePp2L5YKYD0veF7tS
	IBEBinZTJNq5LoePdZIjCD1GiG/mtF1DwzXS3wo0CcQJ3ab8cC+nQbghsKm55lEPLkRfZYtYQ7m
	VzpZGsGeExNovzPQYr0ZKW4jlGwMh6PvrWhZUu/JseTNR9y2TUnVMhHS8nUwHw+nQuvwhkn1Pd6
	q8cDRyA=
X-Received: by 2002:a05:7022:ea48:20b0:183:3140:3ac1 with SMTP id a92af1059eb24-1a0ca49ad43mr2284534c88.24.1792979903481;
        Sun, 25 Oct 2026 18:58:23 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm21301850c88.9.2026.10.25.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:58:23 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	djwong@kernel.org,
	amir73il@gmail.com,
	dchinner@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] fs: skip copy_file_range write limits when there is no data
Date: Mon, 26 Oct 2026 01:57:38 +0000
Message-ID: <20261026015738.46230-1-dennylin0707@gmail.com>
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

generic_copy_file_checks() reduces count to zero for a source offset at
or beyond EOF, but still checks the destination write limits. If pos_out
is at RLIMIT_FSIZE, this sends SIGXFSZ and returns -EFBIG even though
there is no data to write.

For example, GNU cat copying a 1024-byte regular file to another regular
file with RLIMIT_FSIZE=1024 copies all bytes and is then killed by its
next copy_file_range() call at EOF. A zero-length request can fail in
the same way.

Check write limits only when count is nonzero, as the ordinary write
checks already do. Keep the other copy validation in place.

Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4da846a2bf17..c05ad2c42e75 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1531,9 +1531,11 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	else
 		count = min(count, size_in - (uint64_t)pos_in);
 
-	ret = generic_write_check_limits(file_out, pos_out, &count);
-	if (ret)
-		return ret;
+	if (count) {
+		ret = generic_write_check_limits(file_out, pos_out, &count);
+		if (ret)
+			return ret;
+	}
 
 	/* Don't allow overlapped copying within the same file. */
 	if (inode_in == inode_out &&
-- 
2.43.0

