Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817840;
	b=yYE8Usb4kMWODhR8NFdHImkhThCfxbchUzTAAr9tvOqA5thC2Spdpnm64ljW5z1s4EN4
	 YBpCt2gVfGstUj1cfDmd4AR+M5PPiJz534SP3dSREsKacvbi0+W7Muz9TdGpUHUvis5wF
	 lF8H66f9sW+IeFclEVNoxCfLoa8cHXlaiY/z6bMP8ZcuwYdKikdUCJSSm7OS5+p9bZapQ
	 luuKSDnlagQKIsk5J8ZX11/pcMyQvhqmgMKcMcdVcABw3ZpYm9OBOdYxrXpuoWs6q48eP
	 EyE83qvkMmW1nKe9WAruvDoQ1Ld7qaeFiOcNDFIbPJI2gnsAD0/cKTtCosM1b7fPvpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BDwOUjpVxmKIeCl9aIvePUtDNho1EZXb2sO4HP/6gjQ=;
	b=oYuu14EkuCc951YDJwKU3WtJnMNxrcFkNM8foyhj27hf6z5igBrvQ2G+Xf6WAiwnp9Jk
	 ZJSyWkuFwlQpUDnVotDqFUasBPBgjR/P2YuyKAU+GDLw0sY8XkZU/z93bMLrP92FKR6Ii
	 0cAs86eJoZ+p787OFjSWz/zOl1ZHnVahe9Xx/4d+f9GAd4wdtW24T+/lZrHLEuvgdYBCe
	 A5jQT0RMqaxLzldOJuJ67BTc1GqnZENHkCzZKhq89dL1cHbJVnY9mFtFZTx2oAS/xy1v4
	 8/YKWAs42l5GY746q6EYCiWsA/si/QsojJvmLFkY9uMYWJfh4OmWjxg1g2SFGv3MNKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JOSYsLhw;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B94606D809
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B94606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JOSYsLhw
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b190cdc9feso667134b6e.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817839; x=1794422639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BDwOUjpVxmKIeCl9aIvePUtDNho1EZXb2sO4HP/6gjQ=;
        b=JOSYsLhwTR3XyfXZ1SBY/PYeeUflXRVz6+qgr5uqjCXIeJTtV6ruHO9XUvQGofC42a
         yVdqGiS6kC5IAaaqxK6sVceFOHUrgZG1Ac4QJiuuRIOmdGieIn/amWsrND6K2O6oDvwe
         05eWeMoKvC5TCBwFOvD96M0BmiwQZHI9JdnKe4enU9A+WVUL4bqI9l3QI3dOi2LnIpbg
         t/MJesaQzOcKUajzXGlLC7xInV1bOgbvy8L306d6FHQHLOvQC8czrpm7/42kqu3NrJ2z
         g+a+8U2zOe242oKz+xTa7s0VUu8srA9E0/RFVMVtzgb4oTeU3n9wSKL18lUupWtR+8I7
         4BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817839; x=1794422639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BDwOUjpVxmKIeCl9aIvePUtDNho1EZXb2sO4HP/6gjQ=;
        b=TE5B7IOsh037Vi6hRA0h+1Bv580ssCxlFdg16IlLx3d8tQlzSS/HD59g4kjTU8Te4d
         wp3VH0A7MJ87P5sVrvtGIbc98bNPxF6uXs9un2kKmDheQMcJnPhowA4A2/aHZb3PzX5i
         iPhR0txUOrLSeTnWC28pGue/7sQ/AiZP46NXQgPEvZg+nEmhqsOcixTMSCeae0JQdWiU
         HQSjP9oBvrdGdyfUhBD5AkfaXOSuVq7gdn5C0tqKjMR53BA5IarpFDqGLXObF1sdmo8b
         7TBN9lDtQAlBtdAYw7Tcr/aCn9rsY0NC8vPqhchtf59gv2YXkMWCy5xh2RAwgUy5SjGJ
         ZDkA==
X-Gm-Message-State: APuU4Z8ztO6A6C2/0Ygw2Z2UcV7I8H8H5UBzm9GXj9vZ0PyAemmKP+KN
	nr+gZfCmFmksziIva5y+iwsVOv6kSmkjaJaJGZqXmIzoRga6vJXi6xPo48HV+B7OSfkUFKIEDnb
	rSwfVPdE=
X-Gm-Gg: AYBFou0RnuYfBAH6oRMcWpDBDblM9G78LxiTKKf3+WFElByjjing9fOFoCjgXfCdVwZ
	k8VFq2qMyjcQXoCRC8jGKai0EDpShy3m+oNVh9J5b/hRqEluSrgE60Wvcfwuajmqkor/2Y5ax2T
	467bEpTAcZ4gQ8M6DyUdICGL7iHJsBfJpwKydrIcCo22EclqRdXZBbpN4KOlaaZSSKvzd4MwUXA
	7Upf0CKKdDpIyRyhqR//NHqYfueRh1br9OuxDP2fZ89rpPc79doYyYuZ6mqv9jVgF9mmKHWyT3U
	DpWARfWhYQu/QJh1hNqAzq/Prhj/M1lY2MfKqAvNMOpbvnwkPJQWHGw/+bMNHJbWKbwi7hLrAlt
	e1XgWM+sxx+tDzk3N8qFbILblWP6ypqe5WnbzSo/duUqz/a0yjjbosEd/Nudo9nLVHpU9K6NRYV
	EGzGO1Fu0au4UAHBFz8StFfZBV33vIR8Ju+WZrjHm9cBAzly2MLfIeealLalcx6c0oLtldmm1sK
	Yu319pFJaEH9oMlQJ/XSIwndLwgdqos1xkOxNwjFLMMqQVCZhY8hZWhMFyeOcOgI3cwPvx3hRYl
	1qGRG/WYqavUmL6y0KdrVNJcjKn9Myl7MpVPa535BNAos6FPHZNshv1Zh49njKjGwMAkezMktmM
	=
X-Received: by 2002:a05:6808:1494:b0:503:8f9d:f11a with SMTP id 5614622812f47-5640dd9c1demr11895674b6e.29.1793817838998;
        Wed, 04 Nov 2026 10:43:58 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.43.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/9] io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
Date: Wed,  4 Nov 2026 11:43:46 -0700
Message-ID: <20261104184353.516403-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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
index b7f7c5fa0bf8..43edc6cf13f6 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1061,6 +1061,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		sel = io_buffer_select(req, &len, issue_flags);
 		if (!sel.addr)
 			return -ENOBUFS;
+		len = min_t(size_t, len, MAX_RW_COUNT);
 
 		if (req->flags & REQ_F_APOLL_MULTISHOT) {
 			ret = io_recvmsg_prep_multishot(kmsg, sr, &sel.addr, &len);
-- 
2.56.0

