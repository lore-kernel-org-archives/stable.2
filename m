Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068233;
	b=Y/soPdUE9k1sSFpGFxrSkwyKdlFZgPBQLZA/kLhf/EGpdBobiSaPAyHM8pdxTrpHMcMr
	 sYAbqUqhpENncZQcnk9Qr7uqLqZFKuCwA2zqTO/keUShCaxTdd8gtXIOTiWwHC62kV4Rx
	 YH94wFyLJttUCBmRi1x6Tzb5sS9gi7u6DIqc8uU73zGLOutr/uC9RzyQjnSBc3taff+td
	 hRucq72xTzOsTFuzOGM07VNrKS1QO4xF9cNOfvS1yJpUHHe9LOrMfP6eLhuLBvOvPxiPh
	 B61GkxaXe8mupqvCPnk0skJaYFflOUoqDa+gnZq+bGP1mja6vUSbuGAYNfJ3RlBdf/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=10M2Em+3HRbMrZcHnFLm/57pKPtIuMOGTs5A2PbiKks=;
	b=ozDrp+yKSMaX8x/dihMNtIW71cHwNDClQh/132cqXV3zWShT6c4vPEgdkMn4FfuCzkL5
	 9BUcgBEM6zRn93my3GBOvWZ0zLBRfQP00Ce6rS2xWR1adadBXgyl87XJy34HVzJTh3sGM
	 rH765vX9bHiW3iasbuAlq4AgmqFYNGaxarhm6bY2NRAiOQM30TzXIWPikbhs35D3ZOEna
	 zSoFs9RA7BdbyBrcqHi4uZC8/f9NbGAQ4M3ubYEFC82tqDH5w5qgU0uw5NchNhCwiOSF9
	 W8KoDOQcB2bcDjzAIkCSbFv30hVL1EtbXGZ6wbGLoRpXTpbVBK6/Y8LK0HXcaYOCQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SRLxCq8y;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAC606AC0F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3AAC606AC0F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SRLxCq8y
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso604763a12.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068232; x=1794673032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=10M2Em+3HRbMrZcHnFLm/57pKPtIuMOGTs5A2PbiKks=;
        b=SRLxCq8ymWs/GbneL1hEczgBd00GvbEAv4gv3PaO8oglwqXqFVtQ2aVsieFuVNOyh8
         9NxZCghzqApNvNOOt72HuJ+eb0NHPkdSZdV+VE9UeCWS+wgML1gSKWbGgGJ0e5pgv1fi
         XEz9QdXwKKbtJ1E7YtSaSkLFogO/TfISk++nZiKMpYXpTyDzMkpB1hidYAuItyY/Ydo8
         ORMbWkrBVXhW+lCNvOgPLExw0wrdD/ei9uQ85/KXrD1KDh2BQWtsloHXB2exXJz0emOM
         CmhC5omJkkXcwjTcqqNrCDTeAQVTHgi+bhn3vmJcJ+P4T8cMtKaSgdMEhVpOR8e4m0jz
         PlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068232; x=1794673032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=10M2Em+3HRbMrZcHnFLm/57pKPtIuMOGTs5A2PbiKks=;
        b=A6buLWdQGyKZ9QykzC1T+PP+nF6KSVVUJQU/AyqeLNCpJ8mAn5ARwiKP33pTRLoqgI
         UgrhI1aLv2LYpOZfQPsKszxR4I/PcNZX5wpmAVfxeptXIIW07N7rsZhU/dXEV6DA+XjT
         w0MQ0X8wIRL6AWHVdi+i2Q7b/bu/CK94hArnKfDHMozu4JzDXIEkAjY1BaxNrxu89TRF
         DLrgQOCQm8VzxkWu6bsFjTiONZajs/8H07QINiZ9sPsaNDCzLwr1B8STogtvBPZJ4fIO
         35TQ4pT5NvRSwVPYr/NxTu+vkWD0zRkr4qMOYhHtc7T3xrZ5dgVc4HyHYP+T6whCAHAk
         WlLA==
X-Gm-Message-State: APuU4Z9Cc59odbE26IW9zjflM7YxZOSa2JFoFnGHyYwWl0jiuqBWj7lQ
	cOsOCPvLxyJGh13MQagG5iprYZbLtcEmo2LhwkMNQpmbW/yYxnC//Z2vJbEvSP9IRS2r5nM5WXO
	GURaLq2w=
X-Gm-Gg: AYBFou1LEuC+U7Q79cjLHiSfaYMqsx3JDRVaO70/2XVVAAlgil142V1orVYlszY2cj6
	QBl8WN4IfHWBWUDTrSssVjyMeyWca36OPpCX3qL7k+lz/ktCcGIlxLGGJADXWXbyt+cwwo+6dUs
	FkRIdtyw7jnrMMwDdardxh5c6/DOExDyeQxtN3gpkfMkmh4BHQZP5eMYxjuSgv0a6bk0jrsD4C/
	RanDOdUxStMjSTbJLxkazO9aTi1ca+vLuo8jLg9rYwfDXFhzKgGpGhBDx1qu4iHMflD4Xu9lhi3
	8ZoBw6pIc9I15JrfTO2K64DYPbpGAJAYvm+YpFx8ECzp71gl0eIorHU1cAtC4G+50fdIVAgvplZ
	U3RZi4YNlIeFjtc0HJXbmZi/eOgagxeCrhU1hRgfmIPttRfV7yRKCk527BqsJd3lBMZeInWZlD3
	aXB4IYWS1OgmJ4TlOn8SZy5zvKNIc/mxpziTtCWn1UsAfTBDsT0ZUjLjc7Oq/xTVn/RzCd20uIx
	pc3mi8FpefPJCvFR2KIEtNt6nYplFMcH8Xi+bXzj5uUwzFl0sJTALC7vroW8R7vbizfldpfckU9
	mCZten31CZ0Gu89k3hNFHN7I/j/SZkwrl/hcL9GpmhGnn5rXiX4g2pYBTpUxtquzIY2uPG1n7mc
	=
X-Received: by 2002:a17:90b:384b:b0:3ac:9772:8da3 with SMTP id 98e67ed59e1d1-3b0db6f1770mr5869464a91.31.1794068231955;
        Sat, 07 Nov 2026 08:17:11 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 9/9] io_uring/rsrc: hold uring_lock across index-alloc put_user
Date: Sat,  7 Nov 2026 09:16:56 -0700
Message-ID: <20261107161656.2500790-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161656.2500790-1-axboe@kernel.dk>
References: <20261107161656.2500790-1-axboe@kernel.dk>
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
---
 io_uring/rsrc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d69baa47c7e7..c1ab760c4591 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -521,11 +521,12 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 {
 	struct io_rsrc_update *up = io_kiocb_to_cmd(req, struct io_rsrc_update);
 	__s32 __user *fds = u64_to_user_ptr(up->arg);
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned int done;
 	struct file *file;
 	int ret, fd;
 
-	if (!req->ctx->file_table.data.nr)
+	if (!ctx->file_table.data.nr)
 		return -ENXIO;
 
 	for (done = 0; done < up->nr_args; done++) {
@@ -539,15 +540,25 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 			ret = -EBADF;
 			break;
 		}
-		ret = io_fixed_fd_install(req, issue_flags, file,
-					  IORING_FILE_INDEX_ALLOC);
-		if (ret < 0)
+		/*
+		 * Hold the lock across the put_user(), if it's dropped the
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
 		if (put_user(ret, &fds[done])) {
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

