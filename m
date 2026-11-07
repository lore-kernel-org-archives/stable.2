Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068158;
	b=ojs0sSVFb9LorZTlhxpn41DNPZUBlVQs0CCi4b2AtRhkHZJJa/o4PpCJNU3NgbaIwJxb
	 ScQdXzAjOCipsx0mCyz+vqmQ6Unhi4UfOvy0jtGhC8633pZSZSqLEL0TeTwVRGoW/J6aa
	 9xW5B5LWRQd4AHYkSL2QijX0CAtE9iUhv2eokOU7zQTnXCyzZaPMaQKPVEGf0dH2tMmFp
	 6PETIWwtcAPxddeRvUzWwCywvfJlUBqOltsHHuYAjqMzxJvUP+FBCquUIQJUBhVa6Woit
	 Ye0Xf/OXHo9coodD0UEAmJc1nDxoUdBlBKuIwtoMyiFRtEFBiIY5tpZQpEVAOEb3MBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3jaiJaV66I6tjs7YD4nPeWo2XxQzB8tjkM0T+CnxcG8=;
	b=piaQY1B/CvVNa81Pl+8ZBj5sOlWt6u6XGa7oq9a9pb9lqfelXKaWZIgD5aXZ6JW+DUU8
	 eWnmHdOavu8GepKmOmZsK02CsZHmPr7qfhM8MfqPAidbcCRT/tSAVirJw0ydDV4aJqYAv
	 tB1Jaf9sWaVzMb/GxSs4bL79LlLstqPncXDVjgpjmojH4A2nnOd9+IelYILG0JX5BRQru
	 /WhPEUTKV0n58c9f9hPrDZe/h+hQHdnVr0/qivtGtzxdbBWYJKgUsPXoWevZ9jnBD+pp5
	 60nP+CXNurCwVuBdA2NOHKah8KVmxWgi8/fjQDfBY6ai5D0ZDhJVmDrMzeFRJgC3ZMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AJDnzsFx;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAE606D3EC
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAAE606D3EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AJDnzsFx
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed1414df17so5962015ad.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068157; x=1794672957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jaiJaV66I6tjs7YD4nPeWo2XxQzB8tjkM0T+CnxcG8=;
        b=AJDnzsFxRvtKyfWFH1oSTnDGuK2TFAA6TsTc+O6GU3/BJ5QSzlVWowtdGalyqST1t2
         xb1/CuQlaClIRiKhg7CMPrNuDiem/yWyMOWFmnwoQZnUzgQV5DcAbjtmL1r6g+CoESB3
         e0+XVe/oYxF07MvjXsSZqxeugmuk7O815g+xyFMAoZx5EhG3lV3Jrr4kjWRafc1c76LU
         48g5ZNLrdilajMWybaWldUYGW8L7Z/axGnZLuwdQexOqie3BfN8GHZ7RihkQyB/9xWfR
         8aEeODKrVTo4RgT8V2yN9KwMJgAB4lCHZcg7eUYexECMKqDtfNNmEJLLHWoVy1wxkKkh
         J7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068157; x=1794672957;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jaiJaV66I6tjs7YD4nPeWo2XxQzB8tjkM0T+CnxcG8=;
        b=Z+lVGPAOsj1Zp1TMdfcRlgcsENoP5vZw1kTVJXoD4aedRuIh3BXf/ZDJgcWoGVi2KC
         SV812nk0ZRNxiM2RhgdnB0HDoY5ZlTzZi7Nywa1H1aj89PVYfS2QagXtlusWC7qvc4F9
         UJT3zySFzor8rA9Wyw/IHU/D28/bUWZ6JnKFl/m9fWVKdRTC7GOz3svd8AdKE+RJRXB8
         O46rFueldsPSM85TMgtFRt2X9nCjRCu6H0+6+NMnJ4tHeqtmiDeWtn0Y4jf8iJIQxPmO
         lxFJOoqg8eRiBTPkxkfTV3ebw8t6RvHQAeowcVGYXdeK1TSmrApKwjWSiIhGGsCpOlD5
         tZwQ==
X-Gm-Message-State: APuU4Z/gQ0R4P29GpJKEZ5XvFluFbIxnG6Bf4s6V0gOzPJ8gdr3xdO7T
	QRHw4JkbFiplVdlAvgN/kVZ1lqzn2yp5ih/Q0YASDgly6SsAaw9+NcdnVWH/XpXlfIdI/QFzPvf
	Eq0MuDec=
X-Gm-Gg: AYBFou0mS6gS+oSaGSL5CfxPAKj4q8lAa9OLHHdHxkrEaZ4ZEfHfUjRcVaRK2HT3ia2
	kGTU6UW26L+HpcNfDPbOPF6icWJ+CMCqglA5l6bfz9nQ0HaNaIRiK6OzUT2me/am2JjQX1A8N03
	Ww0ZhUgE2ANoj6auCCCLVsLVo/j7VA1RCin7B545S7woZI1mjbR7o/w9AnpuYH2O/smUgTslnq9
	KnagZCN+M0PjQLv36m31Jq8dnWGvCCT+S9PxmusJ8z6X4VXb5ubFW43EAVLsaqySbwJDqUms6lE
	YwCBcrWEXvwhz0yZqwElv+Tcd/BkK8+EpdZnyz4haXLZApQlkLKbLHWoll9Wu1NzQTwryUBVh2E
	tA2ADgUfC+uS4CMI1iVITHfrP3lpIHe0dmWpuLAYKtmJyRZKESf9TXnrYRB/lPzIkIpdBfu2tqc
	1WNVcu1ggo5FZk8zNqClcJL5twfQjYJX7HYCNOviY2H57KZ/O5K0sXn4QRgxGMygbv7GhhukGFk
	kWiq0VNwo8tKvzgNXNmdNck/6077Gip9NA/p0rs5cbXAbw0yl8xFhT5/PqmOljcf5a+8GVOZgMg
	5si2xUHrj6C01Ca5fDcFCvg0/+UO+4vqZzHLpcWMxf2kXFUhc2kF8pqBrja28fwzfI7q2EjW99o
	=
X-Received: by 2002:a17:903:3708:b0:2ed:1df2:8b35 with SMTP id d9443c01a7336-2ed40c9d179mr72839615ad.37.1794068157497;
        Sat, 07 Nov 2026 08:15:57 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.55
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 6/7] io_uring/poll: don't poll a writer for urgent data
Date: Sat,  7 Nov 2026 09:15:41 -0700
Message-ID: <20261107161542.2500190-7-axboe@kernel.dk>
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
[axboe: 6.6 sets up the mask in io_arm_poll_handler() itself, with
EPOLLET]
---
 io_uring/poll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index de7da2bd283a..2a4b575dbdbb 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -742,7 +742,7 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
 	struct async_poll *apoll;
 	struct io_poll_table ipt;
-	__poll_t mask = POLLPRI | POLLERR | EPOLLET;
+	__poll_t mask = POLLERR | EPOLLET;
 	int ret;
 
 	/*
@@ -759,7 +759,8 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 		mask |= EPOLLONESHOT;
 
 	if (def->pollin) {
-		mask |= EPOLLIN | EPOLLRDNORM;
+		/* urgent data is an event for a reader only */
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
 
 		/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
 		if (req->flags & REQ_F_CLEAR_POLLIN)
-- 
2.56.0

