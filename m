Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352B2749DC
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593580; cv=none; b=EJem1hZ5POR3KAYeA9vtHhO57zCsdzwa0VWV0kRzmrX9tNUgSZgmURMOqq0Kp/E+7EwT0tclvP2StawdOLTASM2m9B1Y8tbzAd881kVqpPloBP6pk5hPLe2VpEIAEB3wJriLRLfim/l/gTXhbaYsNMvEqrVPKup5WjWt0PRTA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593580; c=relaxed/simple;
	bh=nD6RhNxzKWTetqlzx61RBaqinCaMJA4+rhml6gRPCNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOX5DxQuSOc3BsRl6BVWCghHB5WG97rg6+wxDGWAC+U8dfyp7TmDE/0eipl4gQGvLLPIcr+V9NH4v0TlxkUXStBxlfSm1g7i6QD+siVZbYy3MM5lO43oqagKqQWMaReORiC6JEYhGaUtQET60HcmMtaHnHyfxjnCyiEzjHk5Xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU+8CZHe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU+8CZHe"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so246838b3a.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786593578; x=1787198378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FudjjefIGcYQYJoeZLUqTaC0084KO9kQWcwAp5c3ro=;
        b=QU+8CZHeKwQgXT0He+Jhc143VaS8WjnXYAGTJz9vPCWG6Ze0Llrj+vBPOAsxkzMzVm
         nD4KF5JcroriJew91KUFmuXeBHaOHU9ukJ49e32A1bo7mD2mYM1lra6uWdPZhpemmOFo
         cEWGoOHPhT0D6dcZB6HBXKzz4RBP/PoTOIK8ptAbDBgpp7L6sbNWmnDwZ4EHvVg7TkJJ
         WE8uk+Jrvq4nWkNzwnB3VXiAK1qlO8j4XrsqTaL6kqB2DneRTqifdkx7u8nIyjNnzke/
         MC477tZMlspywXesDXV69R9zBHlk4bSsDOJE6+p4/+jch1wrGQhn7mfKev3BXhhV0wA+
         7VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786593578; x=1787198378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FudjjefIGcYQYJoeZLUqTaC0084KO9kQWcwAp5c3ro=;
        b=VwMw9u4Shl6ZgU5x/vR9Vae8uW1wRbVomC2G0MX0Yl2PVM0LfvHUN4/yyKjSYcL/eS
         sH+LQoDDnAQXc/zjmYrPaJwgXf8Sa60ubhPtD1FbUEkoyCLxJxJGrL3DapsPfyi3ggqN
         aQ7OOIDJOlrvdWIgJQP5g4VqTDXStlptNRs9r+wNT0ZWsOIYHRE2pSdFjRKyPb3jxVQt
         4Wd3BF14o5NdtcpreaPHuh2iGnybi3qq1f0n4t3MjkgVgTRBGfmz6+Vze8s7oBPIqzXt
         j6qPRUwoht9r0QKqKJLJaWcDRSmK65TXQOjnqeo7QBojup5/VsklhEuK8ndSJmG8hB7V
         jE7A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/unKymxyO0f2n1GOd+Zc+KWaSB7FduoAQH0gbATsCMsLcerQj8R6OjNRA5XbUn9PPhGWjjOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83vTo8LcBOSeiQ0LskhjgDIWbIBHEbqF3A+FbmumvJqYeA/c/
	/cnH2KlBPfAca2iu0HheaxT3NuN0+i7Qp8Mh2cxNHLBITD1bS+wM3IM=
X-Gm-Gg: AR+sD12wF1fVbSw9ljnjlsW+vJBRDYdcK6hi9WgjqjiHLm9py0kHx+oqApGIdgZabEC
	nKQTwAGqBnmTfckY7ik4MRrw2avevOk/eOxJAtccXWsAhZn9qCQDVkqGiQB+ly8HsKFvY2MqYUa
	LxubLZ1754RKnK5DziFvsOxJNKWQwCI75p9Wci/DLKxfh8dAMgZaZcKcEpVhMjcHEXBkadhqL7z
	DlVTHeVSJgTeDFoRxn7L6i9K4dDMg867iqKo6x7xm3yI9nJG+A5EdBl7pp+AGS33Gaw/hAfgw1p
	7CGUGsEyu5spaSrUbnSVbeeLEueru5jc+wMg0GOWp/9bSeKR5OdQ2F8o47mfRq81/LK/dsgImWA
	wwmhzN4ImAH6KMwo1Qm1RYskIMZNYQDNZEgh5uMV0R45oAtjnfPJosC9jDpWs85ScoJGanZuKuK
	lo5N48b/APQzFhLM24hR2TvSR6VkVm516cvJTKVdbPGMp76GKzgFW2M9hWY1s/Qe9P8HMbc0TBe
	3dOi3JLFVLb83L1DtXa
X-Received: by 2002:a05:6a21:62c7:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3cc554d4f6dmr3963089637.36.1786593578062;
        Wed, 12 Aug 2026 20:59:38 -0700 (PDT)
Received: from localhost.localdomain ([165.1.213.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d964443sm3619941c88.9.2026.08.12.20.59.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 20:59:37 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	joannelkoong@gmail.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rochan Avlur <rochan.avlur@gmail.com>,
	syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Subject: [PATCH] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
Date: Wed, 12 Aug 2026 20:58:36 -0700
Message-ID: <20260813035836.74045-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
concurrently processing the same request (FR_LOCKED set), the caller
frees req->args while it is still being accessed, causing a
use-after-free.

Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
returning early.  The wait will not hang because fuse_abort_conn()
ensures all requests are ended.

Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
Tested by injecting a msleep(100) between spin_unlock(&fpq->lock) and
the req->args->page_replace access in fuse_dev_do_write() to widen the
race window, then running a reproducer that concurrently writes the INIT
reply while SIGKILL is delivered to the mount process.  KASAN reliably
reports the slab-use-after-free without the fix, and the report is absent
with the fix applied.

 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c105aaf9ff5d..b946884d4d5b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -572,7 +572,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_abort_conn(fc);
-			return;
+			goto wait_for_finish;
 		}
 
 		if (test_bit(FR_URING, &req->flags))
@@ -583,6 +583,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 	}
 
+wait_for_finish:
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
-- 
2.45.2

