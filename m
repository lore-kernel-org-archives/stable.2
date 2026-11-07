Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068210;
	b=HA9XYyY510f79LGnvaHE43WCdwy1uADA4mGcFiNPpN5Sna2N3MT5Dej+Yt5ehFMWvV6F
	 FDen+hMDB6yj4YnnwCq/BMy4mQHcuO4rHZyWY2A+fsPUuCuJaTCKfMqwCIdn1DcWViKjD
	 Hn5Stvw2/AMzVgpJ1IhO8JkxokRmCkOl/p28P931s743KWUuzctmyt9C5TKZszPfgXRGf
	 RYpcdJeEPcLmgqgxyCK5V/iCyq11+ULjf9afkBEXkKXlX/A+H2GMSvn4iLzVznJplMbqX
	 XvEsjxAAT4nkJNYw+ROFMdq+9jZn21tsj2hQKvlTjpaLTOUhUpkM04DAbz+aB1YgXcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bA2msMLXm8v/LnNLG/MT8NCmiogg+FlfeLVFRIZY6EU=;
	b=MEL3lORegoPOIva7PGUwBcWoPtuQCVefw1Qe0Z+ftdjRnlDxPisY4uquMhnXZhXYbloL
	 n8S063fBHtPz8oSm8ooOFP4xFGSJFMAsRSwA9h1ekPRthjpqZJleUCBmWfe5BAWnyT1ns
	 JyDF3kA/78QdhhO3qgOi+Wlh3BkmBEuKMDe6zL6DlFdGH0VnDgvrQoOFuplOmSLUYn3Ie
	 MZMOXNgXmS2cV37yr47G/xhJ8qCOxl7P4g3/9d5vfmWmXgU/otMhiLANBcps1PoytGPJ/
	 XEm307nwubRpGOddZmpGI3P3X88zxPUFEzQLWHW/9o6DVzHQCdLjaZoVY+JuGUgVVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sdUE2s0i;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2841606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2841606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sdUE2s0i
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so960016a91.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068209; x=1794673009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bA2msMLXm8v/LnNLG/MT8NCmiogg+FlfeLVFRIZY6EU=;
        b=sdUE2s0i4ZhayX5RO96KVAcKOqMDSHQUiWCQqYB1o+gh7gehdwCgkk5x2LSyo9dESa
         6jDFiKsL817pL9Vza5/bHz8vs65I3GwvDkszeTkQENDdnSoaBojiHKYPdNflrApLb5L8
         f8+eAmBdXdxTDue3yaDrsCwr2WrYzggTE708gWy1pfGshD3XwQzdNdZnd0dozFum9l33
         zd959BvygXxC/hTwcOgmFLH4HxT5JF4K5pDa0cFlyWi7o9v1Q4ph2p0VAa8VNKhqYrYP
         vUACvxzRUhxI3f2uDCr/cA58eHQz3D735/nGkLDTMUluEsGLdCwYpfxVKP5dL5ZHzUKn
         jLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068209; x=1794673009;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA2msMLXm8v/LnNLG/MT8NCmiogg+FlfeLVFRIZY6EU=;
        b=QVxWlFT0jkClm1/s7u2k3Hn3dmcCZB8P3wtUVJG2A0Btwu60iTmGnRU1uKGpszGh0y
         inrtv+yl29uGyN1JJ2Dkqyt5FGeSsgjAwi0zKi/W1YGoxz0+86jsnct8sZiaZbU95Wxu
         gSBbL7vJgaY6/miatWPrUfr0pESSr7CRKshkPr0oqwjcVv2Jmu7g4UJdL4IlVDJB9icH
         hzaMXb7fSDrh7k0ZBy9saNX3pJFGJabwNiiDjSs5NRjBNmni39IvFn3pyXvMGarv2Cfd
         7bvJ5XQAqXH3Hm3Ee4EUP4kQDrP/U/3ZR2YztMtv5eokCgRPJuclQ/nAEHBCkGqhkCLb
         FeRw==
X-Gm-Message-State: APuU4Z/H8og3ulx9hpkdsgom6CrKk6blLop84TtY+yB10r2yRfJ9h01y
	lZPyUfxw8+VrOaeKKg9lNaHK6yTx6Jvgu+nxvAayaSeL/dQ1CDwDviG/N4kLMNUXY4jzi+qoSiS
	jglrM
X-Gm-Gg: AYBFou2aLLA6ykNwsSIWKlx99SCceYsYJhRz/BRBxZpBlwu4TGWeuixFwSfB0509l3u
	p1EVR8JFHyZFtU+dYwI/8A2AnrhmbH/C90WM/2H/rhukWCWWyGoFhDacOoxWsiE6SW/+x9tiHnO
	uba2FRMhJNlYn21h16OiH3jj186oXSxN0OCvdhG84HpRAkijc4Gr6ui/QDwxG0haJF15HSspd81
	CgvRX8oAmI2tVqC6vpZI97hXgLe9mjAl7bgskBfXiBTNsPPWPUZ2Q+wItuVnHJYYb2Adhs/tqNe
	aGGs/YQs8oENwN7xlB3Lx39/cTnEBNZw8jDxtKEt76kk6R1nz/jgsYd+2EcKjukRbKYpmCtX4JB
	RcmVYmz0LXPHLszhJZgatf8qzGIHX9IBJ8n2XC7xeZi0PPCvFr76h7Y121SXhAHL91Semi9Emea
	TIi1IITyDNDvkO7r09klJKb/GuXj3BNEHAVOkM3+Z9oH8YYRQuiBd/LvzIr7sOBbOQfVF72vG8i
	vy3CuI7XrbKr3EHt9rLyz5lgXlgsNSIFoqLoKUjDvtHAfE9MjC28TJ7koNZhf+TasUFxFiluwjk
	2s2DFuirbln6xD5YMXWrFdW3cz1Fg5FHobE1bD2wwKa4ovxNJVHuyHA5LhmZ+ulEH9KaOxBlGXU
	=
X-Received: by 2002:a17:90a:fc50:b0:3b0:9a2e:b491 with SMTP id 98e67ed59e1d1-3b0db71a89amr5863824a91.66.1794068209073;
        Sat, 07 Nov 2026 08:16:49 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 7/9] io_uring/poll: don't poll a writer for a read side hangup
Date: Sat,  7 Nov 2026 09:16:32 -0700
Message-ID: <20261107161634.2500557-8-axboe@kernel.dk>
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

Commit 74c1f1048e4401d6a953ab2299b14ace1ad6a899 upstream.

io_init_poll_iocb() adds EPOLLRDHUP to every poll, including the async
poll of a send that waits for buffer space. Once the peer has shut down
its sending side, the socket keeps reporting EPOLLRDHUP, so each re-arm
in __io_arm_poll_handler() finds a ready mask and the request is issued
again. The send still can't make progress, the request burns through
APOLL_MAX_RETRY in a few milliseconds and ends up in io-wq.

A send in io-wq blocks until the peer reads, but sendmsg and writev go
through ____sys_sendmsg() and sock_write_iter(), which turn O_NONBLOCK
into MSG_DONTWAIT, and the application gets -EAGAIN for a request that
never asked for a non-blocking send.

Only add EPOLLRDHUP for polls that want to read. A peer that stopped
sending is no event for a writer, and a poll that asks for it explicitly
still gets it.

Fixes: 464dca612bc6 ("io_uring: mask in error/nval/hangup consistently for poll")
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 6af64c7618e5..3239bc3039fb 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -128,12 +128,24 @@ static void io_poll_req_insert(struct io_kiocb *req)
 	hlist_add_head(&req->hash_node, &table->hbs[index].list);
 }
 
+#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL)
+
+static __poll_t io_poll_unmask(__poll_t events)
+{
+	/*
+	 * A peer that stopped sending is an event for a reader, but a write
+	 * only poll must stay armed until the file is writable again.
+	 */
+	if (events & (EPOLLIN | EPOLLRDNORM | EPOLLRDBAND))
+		return IO_POLL_UNMASK | EPOLLRDHUP;
+	return IO_POLL_UNMASK;
+}
+
 static void io_init_poll_iocb(struct io_poll *poll, __poll_t events)
 {
 	poll->head = NULL;
-#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL|EPOLLRDHUP)
 	/* mask in events that we always want/need */
-	poll->events = events | IO_POLL_UNMASK;
+	poll->events = events | io_poll_unmask(events);
 	INIT_LIST_HEAD(&poll->wait.entry);
 	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
 }
@@ -1003,7 +1015,7 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 			poll->events &= ~0xffff;
 			poll->events |= poll_update->events & 0xffff;
-			poll->events |= IO_POLL_UNMASK;
+			poll->events |= io_poll_unmask(poll->events);
 		}
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
-- 
2.56.0

