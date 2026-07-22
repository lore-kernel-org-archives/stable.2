Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02C1EEA3C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724411; cv=none; b=O4l1zBssxeJuetDBDrHBjs31DCDQ+1UoCQA3RGtzLaLLCOCYycW4irneCw0VE6U0pQjO9C9ykbXgcEtWDvbd4Bxq8n6Qxsb+CuN1apK3XpSCEYapDzd9iUjelytrenNOKli2tvjAzxVp74mATUC+P5nRUrCY9VnGRtQoSmzcry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724411; c=relaxed/simple;
	bh=qzJxGXH8Htt0yjiGZUhOAsSD1L9xnX+Cjna4RQOMgcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFsshKxDPteCZR8ySYRDQF5eMniSVaK3DSBmx5kmmrKTtSXNuLxGONW/TWCfVpfZJ/X7Ln2ZiOy3RbmcdQM/g3hYna74dW3CTHRHwtihxusVqxGeIfZo8nzQQTNT6TFEInoLBqOpA2j4GZBb2JUVM0cL4GLMjuRjlyYSgeDME8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVzKoD/U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVzKoD/U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caf228a910so99157045ad.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784724410; x=1785329210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hP3CUbxxqWNFygvsCAGPnhevOX5On7UPJqPs3IPq7o=;
        b=GVzKoD/UU8H+mU3lsK5nRkFvGXZAQFt+Hl4Wn5edcOOqjLa3oV2wXAkD1CnSJjvMSd
         ZLtsf/0QNECQ+Qtht1e0i45c9gMG1Zuu81a8HLnUbZE5dfxQA8X8vujid2ZH20JzEUtl
         FHM8cH8pYVHlchGU/FTQokrUn17GDRYmGPSorEyAbGkKaMJ6X0R2ToXWkBNDYj7frWpm
         t5dKYF2vxbMAKIy1k5OZA9+sEdwW0X2QqjUTxzIyGusGHXvxEg3xWDWDP1u5tAiAmasr
         AjUFPLb+kz01mqfXTurTIDiqX6f+izu78tzpyp8wSmhoe2OexD6PHPPoxEvIdERTP9qw
         98zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784724410; x=1785329210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hP3CUbxxqWNFygvsCAGPnhevOX5On7UPJqPs3IPq7o=;
        b=lohby3Q8D3NuiiUPxIrf6jd2bw/MjjDg340hm/59EyZlz0tYLIP1siprqvTh5cv8ni
         Q5Ik2JKghb6z9xWYgFRS9T3ahuAdr7oDQcYW91XLNxTM1wQGsZNifMoDy79A+BcOugPn
         5UfSRwMAzCLE4g01wH1lfQRGB/IZ6uCUhgcbzX8T4TePXILJhJArvTc06csu3ehQLRBs
         mSZo8ZR5LU+SOYRV7S6lLWQBV+/Lq+0ql2On2+1+qXYeiEhmCe785VLV8Q+/2I42/79e
         Lhc6YxAgan1kU6ICcyK0abrf/jjcWcEpR6FbH+1fbJwPPUGE5y4NcdUzuV53bFm9z5YO
         9fPw==
X-Forwarded-Encrypted: i=1; AHgh+RpjUPpAI5E1NeVWDJqVvksgLEa2WDHWjrfaIgybZ0Bp8nf4yW1eHwl3EBRqWaFZ2HwITy/Szto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5THPj50PtPo/FE4Xyjf9CPzItR932yfX5iphSJWUiVZ6OwaVK
	07a1+/DQdxcSsaISNWryAUXrQrCQ20TXO3Qnlipa0DYNhH+AivotQaWF
X-Gm-Gg: AR+sD10jnYFBr0MQTXWyJDFAZ8/P7QmU3NiyyvEzlsygr6RAUBKpxz8k1GM3lbAO+gC
	eJ2iuwvTCmW8eS64Il4pzLPCMBpacXdmxyHNM7GNxhdoptK8cVVs1hyJybK3474+mgnQFZmYkz6
	zTiG/pyurASa60xNO59WUTIcc0u92o9/WPHop32jW0DTmdRS4uWkqQZvMhxMg5NDN6BR44XjovL
	teghY5irCwMp2Z+I08cEXqpibxhLxwHYRVs5RzcWUWASrnP3sM1l4TKOQMUChuhD4n1e+r5Uvyc
	OFqeuAMKV7qojyMqbOsj+vmHFfANkq9hsFVLmeKJ+WCPiN7G/dvxn9+/s9ha4YFSUimDOSCLVIP
	Kw0fgwkL8vyeT9nCLpxnKMarsLgywtZoekuBdjVuukFwdJNHxspA3adhg9KmiPcbL7ub1HbIfIe
	NXjXI6tBnS
X-Received: by 2002:a17:902:ea02:b0:2c9:97a7:3276 with SMTP id d9443c01a7336-2cf349eb1bbmr259155515ad.39.1784724409650;
        Wed, 22 Jul 2026 05:46:49 -0700 (PDT)
Received: from wokron-navi.. ([113.215.38.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f38757esm14108605ad.75.2026.07.22.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:46:49 -0700 (PDT)
From: Yitang Yang <yi1tang.yang@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	io-uring@vger.kernel.org,
	Yitang Yang <yi1tang.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] io_uring/rw: fix missing ERESTARTSYS conversion in read paths
Date: Wed, 22 Jul 2026 20:45:51 +0800
Message-ID: <20260722124551.130563-1-yi1tang.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720114116.21830-1-yi1tang.yang@gmail.com>
References: <20260720114116.21830-1-yi1tang.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both read and write may receive internal restart error codes from
the filesystem layer and should be converted to -EINTR. However,
when multishot read support was added, the error code normalization
was lost for both io_read() and io_read_mshot().

Extract the conversion into io_fixup_restart_res() and apply it
in all three locations: io_rw_done(), io_read(), and io_read_mshot().

Fixes: a08d195b586a ("io_uring/rw: split io_read() into a helper")
Cc: stable@vger.kernel.org
Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
---
 io_uring/rw.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 63b6519e498c..95038cfda615 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -615,6 +615,24 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	smp_store_release(&req->iopoll_completed, 1);
 }
 
+static inline ssize_t io_fixup_restart_res(ssize_t ret)
+{
+	switch (ret) {
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/*
+		 * We can't just restart the syscall, since previously
+		 * submitted sqes may already be in progress. Just fail
+		 * this IO with EINTR.
+		 */
+		return -EINTR;
+	default:
+		return ret;
+	}
+}
+
 static inline void io_rw_done(struct io_kiocb *req, ssize_t ret)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
@@ -624,21 +642,8 @@ static inline void io_rw_done(struct io_kiocb *req, ssize_t ret)
 		return;
 
 	/* transform internal restart error codes */
-	if (unlikely(ret < 0)) {
-		switch (ret) {
-		case -ERESTARTSYS:
-		case -ERESTARTNOINTR:
-		case -ERESTARTNOHAND:
-		case -ERESTART_RESTARTBLOCK:
-			/*
-			 * We can't just restart the syscall, since previously
-			 * submitted sqes may already be in progress. Just fail
-			 * this IO with EINTR.
-			 */
-			ret = -EINTR;
-			break;
-		}
-	}
+	if (unlikely(ret < 0))
+		ret = io_fixup_restart_res(ret);
 
 	if (req->flags & REQ_F_IOPOLL)
 		io_complete_rw_iopoll(&rw->kiocb, ret);
@@ -1034,7 +1039,8 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req->flags & REQ_F_BUFFERS_COMMIT)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
-	return ret;
+
+	return io_fixup_restart_res(ret);
 }
 
 int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
@@ -1068,8 +1074,10 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 		return IOU_RETRY;
 	} else if (ret <= 0) {
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
-		if (ret < 0)
+		if (ret < 0) {
+			ret = io_fixup_restart_res(ret);
 			req_set_fail(req);
+		}
 	} else if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
 		cflags = io_put_kbuf(req, ret, sel.buf_list);
 	} else {
-- 
2.43.0

