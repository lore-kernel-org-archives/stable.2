Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817858;
	b=Z1KRlgaprCBCMTFIC9g1P54M/15WoQ7qBj43dOu3mObGKHcXnOexPV7CfniQx+xnC6le
	 j3xJcKmI0rvrZdr66rga0oXp3gnuQAG4ji1xPKmAOwziZov0pjup1JDJJMWFoEBqDb/ut
	 0efq4oHNPG/BxvoWC78D/6AaJLG1gUj1miMZgp7MNUMW3jDdmRKZ9gEwbkWxHCGESwcYj
	 mIMkrVKCd+l7D7pjOu/g+DUFoSUCUMgcm+F+xA1R2p2BS95Aw0pty5G8FN2arRXYl5ANC
	 XCehO+hhDA9d195jdZ6ooxKd4qlew5NW+NNFAOHNA+Oe5a+O11RWAfUcKbBmE3NtiGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nTkqzUKHTMgmZgBgwIFl5oeRReXHewL17h6JAbt10HM=;
	b=yIuYnFTbXP9HgwLnS4M3JuGOEGYjtjglUKNSbwLmWAQIwC4ymiezWh3KSd2AeKZfXnt9
	 JJG67l0dlQTcou9IDiE7QZgDrpPI4NA4T/qZwqx3E+WmISq0TY4qrRIAsfbhgJOrmz5jk
	 1BjfrPK6AKhDs7E42ED2bzO7EnzlCN0bRuiZOdb3tYAFZiUkHSddRrYUGEw0g4WoO5YuT
	 rqa1x1sAOJ1SKLPH8H+Ek4LBnZ6/Hp+6nPTiuXCkqv6kBgHTBTB+mQSxiYk96mIjIB57n
	 OOjYnDUER2n8ocLkHEEZxBWOTMXIUDfnCfg7400/kK9ZxYzvHIQNg2L+2aHNPAj5BJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Kbm+mpR2;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239E606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D239E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Kbm+mpR2
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8439fe796ebso586520a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817857; x=1794422657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nTkqzUKHTMgmZgBgwIFl5oeRReXHewL17h6JAbt10HM=;
        b=Kbm+mpR2yE//G68B464Mz6Xfz5otsWDvMm5cECYVjjbXzzjO0RmZXqcKz5rWsvXfps
         t0SYg0Q+UGC4UttLReQXqb5d6xgcMMFL7+9yPdwhnWF9FdDxQmaqEJuAyd7uQopaYcoM
         +rSu/+EBUk2GlEq1jxIKyNrD0WZpmgjKYqf4WRfLp6vhKO/FYcY2f6PyyWTIsRJUhQLC
         TtZCj8R5r6Uv11pnXcAi6JhzGhbKxSLjqD0gANZdjcUtM98lFLeFKYTU482BjpjBLHVl
         4eQpmH444deYOul82QkJ5/O+96dkuNxHAWfPx417dpWk6VnNZ2mhEw+PqksTGA6wMPOs
         uaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817857; x=1794422657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nTkqzUKHTMgmZgBgwIFl5oeRReXHewL17h6JAbt10HM=;
        b=lpTv4KwLKQz5+v38u2MrtZIyDFqvJyFAby4pZ0cYrgFRDZYc/jxqA14k0+BghaeuQl
         nMki8pc6LIKSI+tiYt9juqU0cSuuvL2QRenGWHEyYiJHWwWEBwifHgvGdFlNVuglh7fs
         y5LwsbxXt7pJmvsuANno4bkGPIrOThoHGydBmKZYofz2ixew8Ym41t5H4J00jJ1y7ZjJ
         vb0Wbwe+/HZSSWdCB0HGwwUsuyU03G1tBG6PqAJJ2Ah4LbwJs558TyIdu2nKklIGM3D0
         lnd1bemyr5rzj4Jqu+txTpuAcQxPo1ZwZmoyLTf4RyJtDvz8GgFOsejmunACMh5gE7kC
         gFXQ==
X-Gm-Message-State: APuU4Z/vGxNKFL+uIkYUZl+rtZpTOuuFcorqTCeZ4DnyLqnCCekbPmXO
	zD53UzPbj+bolMm+RAgBM4IXjRiTDgE6j6QOfPtBAD2SNiZlB+0HPB63OPZRJbSGejNu+1iEupQ
	PqRX60n4=
X-Gm-Gg: AYBFou2qTl3y3xdN0g783HG3ZkxYTW77zmYk6KsfIoKeVqy9q3cfZ5j7e7DBiE2FkzL
	lfOuslam52kJNyxN6pmrbjw6KSyEB9oFSDvvwdpG9/IwTB5Zm4tevwnG6DLdxy5+RFlVm7xYEbw
	mUwSgvbFkHdgjpHrqu6pUJUbqMqi+YhQyuNWOniQK/6f4o1+njZQZkbV8iZj83STlctaNo+g/t8
	dIa43wcJXc+sYl+FBS3444AA9T9c1gmw0c+/UA8bK6IofNQIimgr4A6UoUf39k2FHLzNT/7RHev
	irqIxjLeUonw+wR16qt//8Lg6Gw5FZCh7u1U4z1u3pNY6XG0j3NCJX41bbPG/rNcXWXeIAWr49J
	4xDzZm6qp6/INd61deQzrJ3Assy8AfedrFM8Y6Zfds0CKMBB+WTsTy+b60AuErZmojM9V/Y0x7n
	BRp9RiAV7Iyp5uULBFm6r3y6NNZkVjsGu51JSQpXRczER7HKdy4jK+ZRHiTD1oLsmlBXL9RNRHt
	C7ytfX4ZVd85DItWKSzS9U9XCPowfifkfA/AkNfOgQlea4s8w3Xz6wxYarEcyx01sQVP4DrD87U
	O1VgtELFFViahxEQh/R5e9WEsShageNs/LdUM8lH7A62f9WkSenelRXm7wm19L1WqxHleoEFeTv
	B53GUTtKgluIJRNHGW7M=
X-Received: by 2002:a05:6830:25d1:b0:803:c56c:2b1a with SMTP id 46e09a7af769-85d3661f69fmr12464442a34.26.1793817856766;
        Wed, 04 Nov 2026 10:44:16 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 02/11] io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
Date: Wed,  4 Nov 2026 11:44:03 -0700
Message-ID: <20261104184412.516558-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
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

From: Yichong Chen <chenyichong@uniontech.com>

Commit 18d3f56eb6e6500a65d81cf265f0fe74fd9ecab6 upstream.

io_recvmsg() takes the transfer length from the ring provided buffer when
sqe->len is 0, and such a buffer can be up to 4G. min_ret is an int, so 2G
or more makes it negative and the (ret < min_ret) block is skipped, and the
oversized length reaches the socket layer unchanged: an empty socket then
completes with 0 instead of arming poll, and a short read is reported as
complete. Clamp the length to MAX_RW_COUNT, as io_recv() does.

Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Link: https://patch.msgid.link/20261023112209.87979-1-chenyichong@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index 163ded47602d..622d40336f5a 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1066,6 +1066,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel.addr)
 			return -ENOBUFS;
+		len = min_t(size_t, len, MAX_RW_COUNT);
 
 		if (req->flags & REQ_F_APOLL_MULTISHOT) {
 			ret = io_recvmsg_prep_multishot(kmsg, sr, &sel.addr, &len);
-- 
2.56.0

