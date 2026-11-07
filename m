Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068161;
	b=AUirfK7GV0uvgOwR891GIg/8gy87gcDYi9fqamUQtbEThj0zNsVMnE/3D+74smh3qwy5
	 M/SDD/NFi+QWaW0gkuHQP4awFjzYVSEAWmMiUKNKCZIVQAIQpSh/uSQTHzZdXCBlyyOFR
	 +Sr1QwOCXiJ6cMQ3uvM7H6Q8whiN8gbfjNobekmDlIuaZZyUegAX5DhbMPtCy56GOeumx
	 JHKzOFKo3Q0G5KX8e0sCMQZ8YV83rFNIwZHqJTrBNhNIHOmWaliDhQTvpLBV5QAJdzxmu
	 4HpLAxD93zsm1wkDeC9hAAelW1wEfIZ4nDae4/WM15utKlezZq7pEL9VrnswlExvK9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5kjZs+2RmABEUfKX+yVAmzBN+CCZEKDnPCb0DKNL+cU=;
	b=Jh0J7dziqJFbN2PXApmtDC/0RBk+ka4hDqcrf2JI8J+LWyI3hZxs/JDwObvs3A5TkvPC
	 6TIoPOuKlVrMwcqLNWwaHObDFLYXT7CSSoTt8kGyfln1HrdzhG3bmB73tu8pF3rrjeJBc
	 RW15RppHspHxOUhGkW3+gbUh9DnKbggUQX/Ph4VWA2OcGMIelT0AAQTOwzbaXlESIFXbk
	 G6XT3+BoPZEI4NEFGo6W7xDBfxz9PICPhJfk1evFvgLtr+0hnJwolGpJuFMAxUERAdhEW
	 z7xd0p6kNiPvd1945ewEJIVVAnJitCLpk4omplXq9735dX9JvpKhO3doMmhOPq/OKDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Env6K/KL";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D930606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D930606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Env6K/KL
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e977109392so7800195ad.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068160; x=1794672960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5kjZs+2RmABEUfKX+yVAmzBN+CCZEKDnPCb0DKNL+cU=;
        b=Env6K/KL+ahcf+B5Aeh6FTboOPsSCdUqsvQL3nksPk3whZ6FGXuHHw7FmFWSyAUicX
         gBP9SsQQ9Ck8JXLldglyZmRlmVdMz8TPXSySLP//hd86GDc6Aosk0ySUAFdvQx/CB5oW
         cA97iYtsaLGfnR7PWvVA6Gl82YNG+UK3tY8qDMAhAqtBnV+3N4Twn/SLekR799CvoKXH
         LkM++ziO0wfT+YEkouSF6mtz1hqY0vAJiUuPZ48+xQ/Pk1XMvtLvY1Jf8seB7xsqV0Ok
         9ZwzgfLMdgHDik9f2MqY4uMwQx1OrnIcnenRuRxfCA7gwv+QlZskPtE6rypCKya3/+mV
         diNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068160; x=1794672960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5kjZs+2RmABEUfKX+yVAmzBN+CCZEKDnPCb0DKNL+cU=;
        b=BGBJgL4lIYHtZq+mmbyGQ/xmrXzOWZhmUk5tlreeqsiCf9nXU335wGFvpcrc1ik4UE
         WlOS3SLB2jE3xBXTX153yOKa5ZfU4blCfCs88tjRoApSOSJ9E/f9HOZkNNupKPWPbMza
         FexEzyl2lNug1Hs1OqdGgnWCsrTTG34zE6lbE4FNCaXBg+5lU6vyLT9IetBfvb2Ndwna
         ccd7X3Yw4BvHx0cGBtSpTvQgXrbCI5OfizHnfZ+IWtX/kurWSVx6bLvySHx4jq5ppmFf
         99tsZWkGEmqEVb6bxolSfFBuqfG/quw572Ffz8KI9m7/oF1LQuikSQZZUe4ROH62aMGE
         TzPQ==
X-Gm-Message-State: APuU4Z8NI6tB0rd/DKwiUW+pOW15U9XQRiTwEyJRR4TuSlF/B92ffBh8
	BGD6DVQeyNSTSbH7Q5l3cdHkS2rQDicJZP0azo7qApn/8Pif5JiSogjbSDwR+niW/wZDAW/nSg3
	Tw3/N3As=
X-Gm-Gg: AYBFou21Cwa7vB3bwsqKHoMNAVmqKfzUDx5QP+b6b6XeNZpsuV5QJbOZL2zEwFisaQJ
	dJXbp1knIVRLDqxQcIlWclcircl9850H0ZNXVBCFgtM02rY8kwOYvcBD4wmRnQ8wypYFUrecgbq
	Pm1ReaM7Nu7LwWQMyq65998mJs/Z2fZaVpZ1tj2m0Tboydg/FewoKk9vCPQFNicS1wre7kABQC1
	ZRPf4UsBXGXUwKbn19QaYUjMmutplv0Iqx4dihfsm7a3GGAWXQ34iTl1Bi6apN20oh3HBZ4ou2R
	q/C3EIwhWDuzvqtPebOP2XJR/y5+WedRGgZErEct6WICjiPvLcwmUiP87Pehoa1jhAYJP5IRw6q
	JrzBYWoloVRr7cs7OXeOW8R/+xHnRgj/0LcAFaoCU1sCykzf59IkZLrXO0O41qW+tUwd/vv2ESF
	5A/orHsJeXatlAiNl6aym9/aNHteKqYiEu57DNlrdC3IDFhPk6VO3VbiLeUeeYAb0eC/S3pkFXc
	j948fzBnuOLjxbVbUJhttNChpuwmpjwvjjlO9HH14WpaEob1A7GXzbXrVZ/KAF/xdpL9yHKfzkE
	zwSvFVotYNXohRnf8zSWnCsE68Eqyy7FoMTkhw5OU6IW+Ri5qOD0eM7A7j1wG2I5wlB5382wFyw
	=
X-Received: by 2002:a17:903:37c8:b0:2e5:54b9:6b5c with SMTP id d9443c01a7336-2ed40ad2feamr59324845ad.20.1794068160243;
        Sat, 07 Nov 2026 08:16:00 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 7/7] io_uring/rsrc: hold uring_lock across index-alloc put_user
Date: Sat,  7 Nov 2026 09:15:42 -0700
Message-ID: <20261107161542.2500190-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161542.2500190-1-axboe@kernel.dk>
References: <20261107161542.2500190-1-axboe@kernel.dk>
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
[axboe: 6.6 uses copy_to_user() for the slot rather than put_user(), and
->file_data for the table check]
---
 io_uring/rsrc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f35ae7d6ecc7..ba1dedaaa7c4 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -574,11 +574,12 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
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
@@ -592,15 +593,25 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
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

