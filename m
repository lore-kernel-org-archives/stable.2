Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296673;
	b=amYwzKA0lE68vpG4SNtsjcIyYaukHC29Co4FaelRpdzrCIBJDDBgwOo48xpey0pPOtP6
	 WWQCVq+5Iu+eZH6RfPC+b1YN+Y+HdXCczCm6uNs8RYUFLthg85lB6I2x1MT+rdAnjkgdK
	 9cWIXmz/5y7FlLclpD0dyo0JHqZPiSQq1mKd2VARFY2/MHPjdfgFvBsohBtFOllhd8aJK
	 mv7kM05tX32ABhJTxvigzOz1AJPTPHj7n2msyi6nl+UvuFoELe/xGLuF7+tgcnQ4eNma5
	 yEkXUqHOfdIvKXMYR/x28b7OAvXHTsC4L0+mMMsmIXwH6u33y4+TbpdJc3ZsP0YBLCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIhDBhVDX59yPKxbJx8GKaQ6cMq3Bl8uAn3ypQ5mGGg=;
	b=RFoA0FKCZZazNjsUXHg+r2kfvlJSzBZqyNwUYa4qPHIvCjjCRCpecesMUHa8IzzBYRio
	 /oPi+7/PFpbPsX+N0T0oW0dkSqPmIIldTMW5HNc9at8Z0v49Fu9D7wU7YOnW9GUl7kfKD
	 jXFqGaTcQ7qAU+57U+wgmrvxCV+1+ddngDyK/1e+NRirojkpSf5ItVMHezetei3X46mHE
	 6kxWZfnVQ5BieSX/UU2uuzFAWcLF9/pvtU5pl8gGTUoQ49OSIbXnBRRUHVlGNyIhN0WCt
	 fDVbWj+DNHgHe5ARSBzFPIeqvJJgNsQT6s+/vULW74SUtuk/04fhjkjvFBoxnpsLATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=QT9Augyf;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77346606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77346606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=QT9Augyf
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-702fd86d674so1402410eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296672; x=1795901472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XIhDBhVDX59yPKxbJx8GKaQ6cMq3Bl8uAn3ypQ5mGGg=;
        b=QT9AugyfHRzjmQe3vuNYiWk8f11AUGstz6Vt5fkaG7BS35BNbIbanhe75ND8xcf639
         kDaOEGFXwMgpVtnE3qNLIPemArYF/oX9nGnNgUaNNsc3xaF78NxVdnTPU7YDAMhOxe6V
         P3OC9wBaMYvEJydftFSLnsrioTL/2ZVx4N8mExzLncRacZQmFTzxBLI9UDP4CjgOYTU/
         JAYzSn0zYfDTOHGTUVrn8rePYDNMxe0YnobaN5M3Prbx2+69J94FtoDwcw7baMlbk2W4
         7TGHLdn3No2E72LsPEQEQLsz0c9fvCGoVLCW/Hvg3YAM6/SutMfkg3QbAACw1qeaH1eH
         bXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296672; x=1795901472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XIhDBhVDX59yPKxbJx8GKaQ6cMq3Bl8uAn3ypQ5mGGg=;
        b=QuVd1Pd7QV+vMVFyii5eFBO8aY78iuEmj14D2BzictHiFMRxRW073cOzpuw94/xt5h
         aMLd71WkbBEopBn9XgYYmdFA5aPmufPaMpMvThOgiJf5gLasFRj7vpg1bf0+S0id60Mt
         hISOm4YZf/iWCfxoWeEYkl5wY6TUID5QDuLGPyADbSlJ3LJycjnnGjlmg7vvm1NPwRAI
         R9UWp+WLsq0E2zFPpxZonJr19oUDpvibsluZEv4h2znzXPtauKNowm27tOG22BjcPJ/e
         /Q+Dpeb2tizR/fBz3crdwdSdEuRkdXzdMjsYn+qcSy1ETrs9ZKmBSEV8S496Dkh84aoj
         t9+A==
X-Gm-Message-State: APuU4Z9/xRbHMsdLOsZuxK4OWFamjAyL3qqKOPOwd82pn4DZI2BMAbwT
	YTuTKK59rJG9/aTxNveFjj6odBD8ZH1hmj2x+UcSKz/x39Ic6Gqp+pHmlQD5iWV/aCWuzCz+bkd
	8gMhWHQc=
X-Gm-Gg: AZFdTZcDf1L3TIB5X0oiYWF7pdesApvaIY6eEB1UfD1xY649LAsrUkV4vFAFx2eCYSd
	aU7a23+5xUyPtGrd/vNBJ24+esjTl+IW5I4SgcAVPPm9Cvpr8F5eUL7s4l5zcp+pjhWtKHeyVct
	TOwa5er47Hl28GcSaPkUlyURd6HkwOQDfSbbwEY8tFWA1q2uYRlBsqu6YMo3gQXNJzVL6j1wUoH
	7vYtbkG6RjI4kFnPm22qKu92AuMJRqpe/NyAmvXz26adMWn+VnDgNIfwQDA4GDfaohVMkVkFDag
	k7pZ8NkmmUutFF8XVQQ8oHpFUuaETJmT1NOrhD7FUBbUZLDVdjQwZPZ7p/4E/n4AxgHjcdOgkkn
	9OHYMMc1zfZbiMlDgMaADYT4E2yfdwLnqZIvjJ/L1laSwaHo1wPh3Mrmfnu7IFj194+MVV1RjlJ
	Ke4mypGB3jL7BuRSLoW1A5n+WIgrQ4nihsU8lmebRJ50MJqtNupjSstomuo+IdqXLz64/IxqJDb
	lQYRpyaTXRu1zP3a3LUIzcSc1jsncSc31ur5hrBLdhJYP63dX6++sKYgGB9mXN1ivCCbZelVDJ/
	HulTyRe8Sy1DmBZDXg36qekYvAaVQ4C32/zJrnfdUh1I97rkOirD+g4ov/q1AxJmIS8m8spzFEV
	0HzK12ncyQzy2+STX2sdXrqoSObsK1HEAAqno
X-Received: by 2002:a05:6820:a703:10b0:71a:e9b1:65e3 with SMTP id 006d021491bc7-71b39631876mr3862484eaf.81.1795296672404;
        Sat, 21 Nov 2026 13:31:12 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 16/19] io_uring/sqpoll: zero sqd->thread on tctx errors
Date: Sat, 21 Nov 2026 21:30:46 +0000
Message-ID: <20261121213049.1788332-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

From: Pavel Begunkov <asml.silence@gmail.com>

Commit 4b7cfa8b6c28a9fa22b86894166a1a34f6d630ba upstream.

Syzkeller reports:

BUG: KASAN: slab-use-after-free in thread_group_cputime+0x409/0x700 kernel/sched/cputime.c:341
Read of size 8 at addr ffff88803578c510 by task syz.2.3223/27552
 Call Trace:
  <TASK>
  ...
  kasan_report+0x143/0x180 mm/kasan/report.c:602
  thread_group_cputime+0x409/0x700 kernel/sched/cputime.c:341
  thread_group_cputime_adjusted+0xa6/0x340 kernel/sched/cputime.c:639
  getrusage+0x1000/0x1340 kernel/sys.c:1863
  io_uring_show_fdinfo+0xdfe/0x1770 io_uring/fdinfo.c:197
  seq_show+0x608/0x770 fs/proc/fd.c:68
  ...

That's due to sqd->task not being cleared properly in cases where
SQPOLL task tctx setup fails, which can essentially only happen with
fault injection to insert allocation errors.

Cc: stable@vger.kernel.org
Fixes: 1251d2025c3e1 ("io_uring/sqpoll: early exit thread if task_context wasn't allocated")
Reported-by: syzbot+3d92cfcfa84070b0a470@syzkaller.appspotmail.com
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/efc7ec7010784463b2e7466d7b5c02c2cb381635.1736519461.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index b1428f91b5ee..bde67560ace8 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -280,8 +280,12 @@ static int io_sq_thread(void *data)
 	DEFINE_WAIT(wait);
 
 	/* offload context creation failed, just exit */
-	if (!current->io_uring)
+	if (!current->io_uring) {
+		mutex_lock(&sqd->lock);
+		sqd->thread = NULL;
+		mutex_unlock(&sqd->lock);
 		goto err_out;
+	}
 
 	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
 	set_task_comm(current, buf);
-- 
2.55.0

