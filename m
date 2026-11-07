Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068211;
	b=UF6jwVrfX0NualFBUrCbvtg0yqXWXV6b9DtCKVpPLQxjQgdRUrZyFxEfDkcdyVHh6xI9
	 iZ6YuyELdKn+NaFtzOvCmtiL5ZL4sUA3QVJxPKTE4Gs3d+Jy2NFJRMxf5yXRYlpAc314X
	 20E8feGQWZvs0V6hY+ZYNSET2wETzFEF6E5vWCORJs6h/m6h31MO1XIJvreQSUje9xjgC
	 HokipfN/GqjBzHc4wjTCyWhleYGkdFFNuHPKOqWNAdm43PoW8AUT/ue6x8Drt16ESJdsM
	 SUReuAClCXRWWRWaSpH9bA+LHileP3wCD5Y1sMxLa3kAPWdGwkCR5y71Kx04qUtuJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ox9A+C5MWzJzcgqrj3KM01u0fes4m/cjWGP8DBUs7Hg=;
	b=isQlXqyCuYSnJlDsZueWgTaYKJFJVLpdTCzxJWT2vT+8W9ck8iSPBzrNX7FeOwHfCkNd
	 peM+PKAY5QtxPflJdM2CqL2NDAXgABfclTuCa2YuirEWKKivjjrGY60AVCCjfOP8mnndx
	 yLXCUsykWHq+aew4/OiYbwo+egQeT0s6cr2Gv+iGfOb9lQ2EdXxF+v58HkTNCfhN1wdTq
	 yFwa9yXfvVOFdWN1EXLjhpvG0r2i0OYBqcP6cPiSjlMqNlBtEarzsRCLcix5/iuKJZpiU
	 vWQx56cUvbv1ahrN18T0w9YKbU7P8vigGUGlzIBvNSHMv1gCyFNZkCWHys1I87EjahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cnNpb7Td;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B4606D3C5
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480B4606D3C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cnNpb7Td
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so879457a91.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068210; x=1794673010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ox9A+C5MWzJzcgqrj3KM01u0fes4m/cjWGP8DBUs7Hg=;
        b=cnNpb7Td6Adu2LA3KZyt+XzT5GlTNepo3FG6A9UKCZhkwMNWVweeqLDvW7KiKkdkCC
         Jqoog6j8y+9a9ytjXR5/ZZKP668emtwKFc4foFFjcwUZ3Gyic3CDzy1JhctHpJQn6kG3
         EdOFtTot9FqgVFXpU2S3+q7cYGxLohN+sV4pWD25xhPKc9foD278VOSbKNG+E1LxNDzB
         dbZ4FK7tCf9ftRqNHsybK8pWX5YiKJtjWSICdgcMRRskUnra1VaicEu/7gheUZYEqEwa
         1XfGslq0QoMyBk7yBx7Pc63AQnDCyVQ7jYFlg2Rq5qmGXSiVj3l1TDJGUtprFi3mg+4N
         8uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068210; x=1794673010;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ox9A+C5MWzJzcgqrj3KM01u0fes4m/cjWGP8DBUs7Hg=;
        b=eVm/kZUHGP6vmk86ayhwcbrApXpQEBHdnLjRrPFTajMLYw1ehPwhGgP8Sz6PbIdI2w
         tjJT4Cba7AvAaqv6BOpaQBJfe9K8eEXh96vBMHNy8BsSDO758F8fn3igCFw6cV8pnwKj
         Q/5Wy5lWgd1Di6JfgzZ2ASh+oTK+pCbq0LpPjL5GEP+TUCCdoSjEhcBruMjYEQkdhuNx
         VwPHgGB3z+vBazLCjxqG/2x62stfcbpPKg3/PinOC/BSjvmNJXL8+sdCgQIenyaOQQBf
         JBEA+s9e1MQqquB+PSl5locTfsGErLdvfdBITOLde2DDclPAUsGxI50NJWaCzxk6+QuT
         /Txw==
X-Gm-Message-State: APuU4Z+HqUMTrsrSP7Kcc+TtTj7AhFtjTsl/oAm4LlDcC2MXPL74yBxy
	jmOLUq5LHOoCx+rH0bD6BqNlR8pqQWSVT5gy/A52nNvWWd7mABVh/9n70nZTtlsxXeSAhdQUZMi
	HIUruyIA=
X-Gm-Gg: AYBFou0puP1Cb0gBS2CYKrJIyFd+LXIT+WaieRQ9d2xezorLHeJDB08ld74BU5Ld0Ru
	MCjqluE6cFyyDasBLoUbSVJQd2ff0Cc1P5HZcQT5971Dn5Qax5fcyTH0XWXA2cV+qm9OsSiRPO2
	Z8jk+qzE+HNjE5Z0kplmOGnsSsgmzwmZDIFGNkVJk4Qprf9PVK1EOQepS1YlyuD/iwGWxkzdIN8
	xKhIDHNVhbVYzejnw9VDUb4ilYRiMY8HsjNURAHmtRinkh0cTYBcI3CXVJxPwIGKIniI3DHc1bE
	ptfOeeys73g1j98VrtlIhzBzNC+ERIt5zLpp/wZFqo3hiH2UGrFUGupBnaa4SUXbEHqv3tYCSYi
	xzg6Bd25hYlPOeLG2W36xlP8LuN1l06mwWQxK+d6ly7uKoI75ztrpcrJ91BJZbm2et6ranIwQgs
	2laQch97M/qco1ehpJXxnpkD9Ak3rcRjYIPF/lnqyWlKp2/gJ+v0uft2kOUz63TEJ76QiyF4Dkt
	3cf5ycs5bH6OQ4xfsYfvE0VuoiyDHcsoN28p3DMvfJzQPw+aA5adD1DZDnlX+9aKeq20NSg47IT
	GJ6iaq4N0SYTd7PnVFz5rSVy8JYwrTiFADMgfZCKeiv/rBynJE1KaANGvSv1oCYtvsVUA4vbtBV
	x
X-Received: by 2002:a17:90b:53cf:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3b0db5f1550mr5773014a91.8.1794068210469;
        Sat, 07 Nov 2026 08:16:50 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 8/9] io_uring/poll: don't poll a writer for urgent data
Date: Sat,  7 Nov 2026 09:16:33 -0700
Message-ID: <20261107161634.2500557-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161634.2500557-1-axboe@kernel.dk>
References: <20261107161634.2500557-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit edeac4546a71b6c1db4ba006a2dbf7c863f54e9a upstream.

io_arm_poll_handler() starts the mask of every async poll with EPOLLPRI,
for a reader and a writer alike. A TCP socket reports EPOLLPRI for as
long as urgent data sits unread, so once the peer has sent a byte with
MSG_OOB, the async poll of a send that waits for buffer space is ready
on every re-arm. The request spins through task_work and
__io_arm_poll_handler() until APOLL_MAX_RETRY is used up and io-wq takes
it, the same spin that EPOLLRDHUP caused for a half-closed peer.

While it spins, the request is neither in the poll hash nor in io-wq. A
cancel issued right after the send gets -ENOENT and the send stays
pending, until a later cancel finds it in io-wq.

Only add EPOLLPRI for polls that want to read. Urgent data is an event
for a recv, not for a writer.

Fixes: d7718a9d25a6 ("io_uring: use poll driven retry for files that support it")
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 3239bc3039fb..2594c1f04e70 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -736,7 +736,7 @@ int io_arm_apoll(struct io_kiocb *req, unsigned issue_flags, __poll_t mask)
 int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 {
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
-	__poll_t mask = POLLPRI | POLLERR;
+	__poll_t mask = EPOLLERR;
 
 	if (!def->pollin && !def->pollout)
 		return IO_APOLL_ABORTED;
@@ -744,7 +744,8 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 		return IO_APOLL_ABORTED;
 
 	if (def->pollin) {
-		mask |= EPOLLIN | EPOLLRDNORM;
+		/* urgent data is an event for a reader only */
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
 
 		/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
 		if (req->flags & REQ_F_CLEAR_POLLIN)
-- 
2.56.0

