Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068193;
	b=Yrx2MXff3j2f0sWAMWjaNpueRpUXYxKAFb3U0S1B6jz5hTmjFeqz7qfbucSj+rme42Gn
	 sCGV/Bx5XD3ojFn9WVV3tuazzDTNLTAX1wA2VXxz5AcyJq1PGfNKwI33eSAnbHnDNETK7
	 uOCF2TD66a/pEni/5hiWVJEH7inXjLforMlbxmRp/gSjvk+9k3SSdDngZsll3HEErLcoa
	 OwcnqPiTZ81vATiYL5ZW8/Ct3aHZuKMIke2JGXAcqaRtv15y2hQ3rXH+aC9IokQNIeXhh
	 sQCVk8jVp3jQnlRzwzB7+YzQwBeS7FFYoiTCzbD3pmsBxjATOtnGjEl0gCe6LV8uqjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l8ixEYmO6XnGohghWXJezkDyFhc3LgGcQqZstr8QQkQ=;
	b=TpCAz1GczF++XSukDug86aKuYsudZDE1aF0tCND4wmnS06HbibGpYCO6ucZHYdNLJTft
	 nvDKaHcMtKsnHRc2yHCNH8sl29H5CHseOMlsr1/UHbxtIMCZZMUyG9+ei9vBPwMIB1kaJ
	 4ibH3BuyOS2JcMiwdyAWjQQwEo0arjEwyOprQ8PCHdce99n3PFmZPpwE24PIkffq1Fz4e
	 eIO43hiLnkWZVZnBpeKZ2C9CdSqbLkxHVxqLia5B9sKMC1/x6ruNdCqlekUaT41dtP243
	 ZeXiQqx1AQYNSKJfPN9dxAcC65alHHyFSLG69vc2RBryEt/j3y5pVSL1id5Ef/hcWXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fRcTQd6M;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C6606AC26
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47C6606AC26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fRcTQd6M
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2382bf051so714946b3a.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068192; x=1794672992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l8ixEYmO6XnGohghWXJezkDyFhc3LgGcQqZstr8QQkQ=;
        b=fRcTQd6MPXoH/wXf02zazg714SQd6PeCnr1zXxiGQeDoN3qSPcZkGG3CKHKuibCkrL
         +ICFVJbP5NaZPjLCailwFOakMW1lnKQwgXymx0BWmAXfHO9WcnQHdif31Ljgy5V2rIaw
         1udvDIWqLwNNm0LxPuCus0BoHjwiWckf8l+azndY1iOS5hU0FL0HDEB8XXWWPWgp59R/
         pWrE2GS5bIpBAH8l28Mad0BmizIb/wyYCvhRhuUA55JaJKpBeFl04ntH/B0nFXQLfC+B
         TDP1NswoGXH1x05N3bb0tmYVINbMLRIQC5fNp18GnaQ61O0JIwunw9IFUntxRuICgbd1
         8z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068192; x=1794672992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l8ixEYmO6XnGohghWXJezkDyFhc3LgGcQqZstr8QQkQ=;
        b=BXyH84g+Y3LnP0d2X45eOzeOgiGmuEJ4eQby51SK4YItGxG9UU+P6jYfsfQQp19juZ
         LjEXsD/lN6Bk4WgLhf7kBpxyZjil7c1kK1AwhU3FLmkg58DSmB/37lmk3buf3Ssd7VpP
         E7Qn5EEAKSmJbtJj9TC7CBb2n429Iz1UNZAbm3C3SDLYUGBkyMWYKfBpWhPCdWgJm1yN
         l/Ww+YhJC6B2uBMmVcrO+kQW73w76fV4tALmBtXahN67Ol2g+95LUTcToQdUv4uo0OwW
         v0uIV/Z333BFYaDgYlhKBQaqBqhNBdcmG8ANpozM2Y1CEs1c5yYE8BVOzPfvlBwktFwi
         twvg==
X-Gm-Message-State: APuU4Z9BJciPs6H8l4vaJ5RAsz2V4zKWbeRC/BcPV3jxSeF/1vNgEbk5
	r524QS+wAJXCa7P9EFva1CItZ5HC0apcgdoWMuxd+3kwDZgD5llzMjgfy5Cdgdnu1uNDmRGG1Sd
	8+f9Eyr8=
X-Gm-Gg: AYBFou1Zwing2tWWNUfvfUQ4JHoT8SQ2yYxa5mXeA2AKLcdooNd2TB9MRdWF1He8q30
	STEMcoXpigXdTopAU+z7ROLruNoyMNd3Te2Bq32vlmYN1oIknjr7aoS46pEpqCgpMpkLDPlT2Bj
	2i2DkWGXVggtQqw5j4OylvtExcrNCw1tbjeQQv0v5djaeA73rICzMliRUxHuKwO+DGAizajHRjB
	aYMHZ1TOtiFOP3XVPdE57eC1Jiu2cviVrG4D9iy3X8e9RJnsexhf7lyC02W3ttUU4qt/9AjxCRx
	iIFFgcceejcSGO3aIpUHbr+OX3fEox3DoLt222p58GEODCBGNNjrMWfmglzD88BcGHsMwl4hFey
	69BLTQ0uR9tqLW0f+EovVOBGzdNG4dMDj9JKFPZ8EGpwRv9hnOH1iM1TgMHZtU2EXSQLf6r3nLD
	Ex8joaElXaU6aIbw/ygLNJG5Rd7h0ivOJspcXL6sqcXKpnkkWN8cYJQluyIb/pmlu4Flbcy2ZP4
	rolRRsvfJLW9BC9+6PGMAxHUskwGx/MSSRsh50v50OMpg3LFSHDXEiIrEzcGd+vieAO4qRCDzI4
	anuzH2jGxh3FO5nwasCh/tMIySZC5ch8eOrGlrAx0WdFv4GYQxlOxlL1SW1GmQiPKBRMXsOQu3U
	=
X-Received: by 2002:a05:6a21:4881:b0:3dd:a006:ed90 with SMTP id adf61e73a8af0-3ebb28f3beamr5129681637.38.1794068192082;
        Sat, 07 Nov 2026 08:16:32 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 9/9] io_uring/rsrc: hold uring_lock across index-alloc put_user
Date: Sat,  7 Nov 2026 09:16:06 -0700
Message-ID: <20261107161606.2500384-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161606.2500384-1-axboe@kernel.dk>
References: <20261107161606.2500384-1-axboe@kernel.dk>
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

From: Yuansheng Yang <0xbeac@gmail.com>

Commit d7c7037253f6935af243570635d71b4920b5a4ea upstream.

io_files_update_with_index_alloc() installs a fixed file via
io_fixed_fd_install(), which drops ->uring_lock when the request runs on
io-wq, then put_user()s the allocated slot back to userspace. If that
faults, the error path calls __io_close_fixed() by slot index after
re-taking the lock.

The slot can be closed and reused between the install and that cleanup:
another fixed CLOSE plus open/accept/pipe/socket, or a FILES_UPDATE, can
put an unrelated file into the same slot. The error path then removes
that file instead of the one this request installed, ending an unrelated
file's fixed-table reference early. This is a correctness/DoS issue, not
a use-after-free: fixed-file requests hold an io_rsrc_node reference, so
the node and file stay alive until they are done.

Hold ->uring_lock across __io_fixed_fd_install() and put_user(), and do
the failure cleanup with io_fixed_fd_remove() under the same lock. This
is the same class as the io_pipe_fixed() fix in a3d7ee11289f. Faulting
while holding ->uring_lock is fine, the registration paths already do
it.

Fixes: a7c41b4687f5 ("io_uring: let IORING_OP_FILES_UPDATE support choosing fixed file slots")
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
Link: https://patch.msgid.link/20261104154655.81876-1-0xbeac@gmail.com
[axboe: various touch-ups]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.12 uses copy_to_user() for the slot rather than put_user(),
and ->file_data for the table check]
---
 io_uring/rsrc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index ad7ad35545d6..168c6987435e 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -562,11 +562,12 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 {
 	struct io_rsrc_update *up = io_kiocb_to_cmd(req, struct io_rsrc_update);
 	__s32 __user *fds = u64_to_user_ptr(up->arg);
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned int done;
 	struct file *file;
 	int ret, fd;
 
-	if (!req->ctx->file_data)
+	if (!ctx->file_data)
 		return -ENXIO;
 
 	for (done = 0; done < up->nr_args; done++) {
@@ -580,15 +581,25 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 			ret = -EBADF;
 			break;
 		}
-		ret = io_fixed_fd_install(req, issue_flags, file,
-					  IORING_FILE_INDEX_ALLOC);
-		if (ret < 0)
+		/*
+		 * Hold the lock across the copy_to_user(), if it's dropped the
+		 * slot can be closed and reused before the error path runs.
+		 */
+		io_ring_submit_lock(ctx, issue_flags);
+		ret = __io_fixed_fd_install(ctx, file,
+					    IORING_FILE_INDEX_ALLOC);
+		if (ret < 0) {
+			io_ring_submit_unlock(ctx, issue_flags);
+			fput(file);
 			break;
+		}
 		if (copy_to_user(&fds[done], &ret, sizeof(ret))) {
-			__io_close_fixed(req->ctx, issue_flags, ret);
+			io_fixed_fd_remove(ctx, ret);
+			io_ring_submit_unlock(ctx, issue_flags);
 			ret = -EFAULT;
 			break;
 		}
+		io_ring_submit_unlock(ctx, issue_flags);
 	}
 
 	if (done)
-- 
2.56.0

