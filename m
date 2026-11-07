Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068136;
	b=DNd19qJGA+SyWzpEdM1x7IC4Q3nfJ976cnNyXzZltVKXXATXC0P7gp5s5C5WtcM7ROih
	 vgVWSzU8oyuJr9n7uMn6A2N5xd6QygzundbCGqGJSHt/4PfIr7cU/xE6YR7Kmkp0WmwXr
	 OK0EC8dW2FLHJsrhdn2mMGp44cyPLhWrpA6OwC/LjEsDuzPdrR/iRDl+ogBNmeFirHans
	 avWKXV8f+NoPXFkKMlz/7ANtk8LA0jd3OMClIcIHjE9KfK9xvZ/EgFk2v4JOCUS+vggb7
	 hz+w7dmjPB8dsZNwfVOcm3VLLeTMS4ocCQY1r5XyEZn0V81c/+wosRGFOatcdFM+TAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UxeD2i07Tjwqk60mUrt1k80fXnLuOWmIztH2xlXgb/8=;
	b=B2JLc3NbDP/IPN2usvVrGyo5wZ0zCIbL58R3kwjPFq0Saz/6SmAYcEhAc2hUTtELHaxM
	 dC+jxWNQuGvj+Einzdu+igvqYzWlz5xhw9QOgG5LvRisdRpaaUZZPZIdjMPagFPuh2PRg
	 UtoYcmdc1/7j4JikSVQ7t6Dqnu7D7wheDTF1VVz/N09XJcGUKYOVL+W+fHt/V62M7hvjA
	 Myud1jOhBwdHY4jSLA0EMSZhuEAdx3yCT5MLGMBY4mPxzgjx9r/1ccLzP8x96IZI2NCta
	 p2zGq6PfkNTs5KqISxI0CdCvFa98XRAmZ+fwR7a4DFt01s33jQbLbEWLPu1xC5vWrzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=airBtlU3;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165C606D81F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0165C606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=airBtlU3
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so978658a91.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068135; x=1794672935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxeD2i07Tjwqk60mUrt1k80fXnLuOWmIztH2xlXgb/8=;
        b=airBtlU3uoBd+PnrQD0rV+AedZv3TOZB4mIz0EvQMpeQds5c4ygxqjHXtexgeTKRSD
         mtYsB2D795g9q79ds7YM/Stbu9IZ38/bZYYyd0E63ur6Mmxy9lqDgHD159Q4nSWmBYqr
         8WG5jN34CPbbwtTI43JB+IKFiMj+75KIUxu7SLE6s2pstOsUKZVsRffdyVYicVBjgZHr
         3mxwmhWx3yszNLxFSHdUixen3QeMo7zfNlbhCjKsG0BovtRjHE7PU9IUSblzomaUwS3G
         6YFDct1xAj7oqbr1YDHO+aDkTej/Fqc+WPN9TwUQXWVZYBX+zH+1uFz3r66W40dCvgqj
         iqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068135; x=1794672935;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxeD2i07Tjwqk60mUrt1k80fXnLuOWmIztH2xlXgb/8=;
        b=vWHtF3vuVumcFZqXwBWo4OsatZI3MwCoP7H/eV0wralIKgwE7gkOoCEkAz8dgG+3V1
         I4sieKcN7gRZMAd+l2H//4jLXgVJUOwR8mrfCape0HRv7WsuVTa0ssOqrIc+FWRRJ8zU
         4W8qsChYEj31+dtLAat7KOaC81b1N3NRiu1Hxjuw6j72emQKTtybX37Pq3XsC9PHS0Bo
         gp1F/hHvLp8k4I1oUHxj6YVaobtm6KRnJ9eA9EPEbHE0z8j0uqkv5Zpm+7K2urdC+G19
         xOTIcAsEXEBHSsf7zjF4f6u9UI0LpWknU/fbpr/CCbScHEqrdZNlLpG9Qy7OFVMr46t2
         acBQ==
X-Gm-Message-State: APuU4Z/I3azn0J02Xr5NU6cHpKXGquiyh+pGAiCSIo0OfSzazSrZDAG7
	+wp69xc3k/PW0Hmw6N4bFVO7ghPB7l1ur3GPmK7nqQp3qPIW5hMy7kb1LlbTmH7PwDQSPuMCNlf
	1eGd42YQ=
X-Gm-Gg: AYBFou1pkSQrYz/BLLfl355aNoviOG61GF5QmaftkC0Atq/R/GB2EgR7JVBuoGgUvzF
	Gsn6WLc3Nyu6AbL7/MSdEVX/bYtow7FHpP3ZHJo3zdoLP27jM2NtiUlctKaeWqYpuUsnHnbnWlz
	igiCsX3g703ttjQ/vBZPPlQ28rkQEQgTt93loLHYmFXun0jdID7jPlNMx5TTkPNMiWuzVkL9rmA
	G85WijxHY3myXVrL7//kcgElM71oM8XYKl1RRfj11saeEsPzfO/3JmKSj+qdcRHUxwbAYKzETBq
	QrNbfsL8xYX9JPIa0lOGXVk+W4TAp+RVVu0J03dl6ObC8X0/PADjqZvZmEa2nPCLXK2QSK2YPGA
	x+dDmYPfrrc5fnEusOcyuNQ/hw5MdeEKdEqk0XIbEYAWWj/kW/6MxJTH1HdOcHx2nGGcocxiUMq
	PgrrBmOPRWSsdihJgGtAqMvCzFkRTNL75O7rkdwUswzgmrfYYDMl5jB6V8dQdIXFtqi84qTZlUX
	yYvh3Ob9xy9Cq+kk6EfS9zO6+i3MUZ95vnrcjdUFbiRACXNu/s8UpWsLlW8lD7Hae3GyHFmxc34
	wMrr/tMfGbkDN3Ior1IMeVeF9GRgscO3q8uATpyfqHb+aS99VAqXTwVr0YLwcqgT0fSjvpqriag
	qNjOEKlqbEDHRnJWHfSXi
X-Received: by 2002:a17:90b:2682:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3b0db6ed2c1mr5671580a91.57.1794068135293;
        Sat, 07 Nov 2026 08:15:35 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 6/7] io_uring/poll: don't poll a writer for urgent data
Date: Sat,  7 Nov 2026 09:15:13 -0700
Message-ID: <20261107161514.2499962-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161514.2499962-1-axboe@kernel.dk>
References: <20261107161514.2499962-1-axboe@kernel.dk>
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
[axboe: 6.1 sets up the mask in io_arm_poll_handler() itself, with
EPOLLET]
---
 io_uring/poll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index aa7ffce3a295..10786e84b372 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -753,7 +753,7 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 	const struct io_op_def *def = &io_op_defs[req->opcode];
 	struct async_poll *apoll;
 	struct io_poll_table ipt;
-	__poll_t mask = POLLPRI | POLLERR | EPOLLET;
+	__poll_t mask = POLLERR | EPOLLET;
 	int ret;
 
 	/*
@@ -770,7 +770,8 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 		mask |= EPOLLONESHOT;
 
 	if (def->pollin) {
-		mask |= EPOLLIN | EPOLLRDNORM;
+		/* urgent data is an event for a reader only */
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
 
 		/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
 		if (req->flags & REQ_F_CLEAR_POLLIN)
-- 
2.56.0

