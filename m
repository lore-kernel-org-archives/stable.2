Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817813;
	b=UJwkCCHLCg44sAD7bigoA0xzaRu4SoUHAhsQJFe6rep0K7VnUojHrHEnxIdfuZ7E/hja
	 cUN48YskoRZNGjsZhrnuEKVTG9H6BH1HS/CWpSbSWdngo88n09SmEjYx8q26Hes9tysAl
	 jg8I6ka+2tD//HTqtFeajaLvWRafMZGA+Y0+3MhVRqYuKdZCvFsjSXHxOav6zzPGR4ps5
	 Y2A3mcEg2y/APJzS7UO1T3qlqWVGK3QCTRY3wTJX9NymvbWeiN6TzFvkWawkQk2jpzvcG
	 pMDWXkv/K1yua5yLtSPQinXjVW4pICiUMmnibpCP7AHAOiK7EH14gqFqxAwIJzwLWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=76SApyLuR5toNly/nNQRtkgpOpbIqkrVYQyUrgzYh2o=;
	b=TrNYVFk7Hx15/kyLakVwqfLBu6ws9BIQVPD3Y5BhKxtS1UAq2B00U6B58bDXYGTdLnxV
	 zVseQPBT2BQTJlwcnZzm17Gic7O2+R0JdfoI8Z2Al47Fq7OBixaT+1W+xQjGAxoLPq8kR
	 UAwsXFmWiWSNWiHZ3RHQyURb5BHf1nLWwOg/E0eJ6tlVAxk51YkSq+pkBpODSXlNbv8hK
	 NIB3mZb3GmvwUztFS6qrTsHIi3gCRutX7airioXBIeBV4h9xKB4vt05lqkwpackKVVPEv
	 aBWiYllCYmkF4MuYVwz0wS86afn7IC37oCUfV+IWsI0c+nE7ns+B+48H8X9zlGUQxow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QN5aTRwq;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F9606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43F9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QN5aTRwq
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-823e4047037so742057a34.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817810; x=1794422610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=76SApyLuR5toNly/nNQRtkgpOpbIqkrVYQyUrgzYh2o=;
        b=QN5aTRwqiQsMSx1fQlj/zdRkWFFeCSuhbYg6HswgvKDwKlzitioUfb46rRJ7L9qNl5
         +Nnq5tS4Htbpwnxcr2NBK71SdjINtBEcyyPZqDicMT6jAlw+VtD0rE0kci1MTcKF4EM0
         n0JPrBkMY2TqIysTY4QWzhwDs1V9qo+OmsHnyTOffDO+PZf9us0FpK+P5XwoAtVHRB4P
         uaIJSPooq4+kzuaX0QmU14OaiWLtddi42U3AYdqfq9x996vXoASW+OvtbICcrS4pAiVJ
         TTf9RSeu78M8270SXcXE1FxTfoEepdWwNc4cJ+fW45H/p6XffK1nT+OBKUuUx2W9/x9q
         9gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817810; x=1794422610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=76SApyLuR5toNly/nNQRtkgpOpbIqkrVYQyUrgzYh2o=;
        b=n5MeQ/4agbTNGPlzLGqdgWbTqEYxgzbMWXE0J+qvMwCApuT57PeOp3QSrcDPal75GT
         gsCHJGelBzIaB5yV6oaRyzXHKz+UWBFixIfDl6eG5EXahASmpDGZoi+w6KiWnz4aWxGz
         gJjcQOpfFdkuIKqFIFJmT2tEiDvtMK+6yeMGRrtPFB0Jas7lo+s2C7qmJFTh7WRGJVyf
         nkJXcznfYoYAzJHLrqoHH6rvMqb8WN6PzVVnqb6KRH8IRaUyP9VOa1mpGqeVfLyU/s9B
         aSL1TsPHw3cjMo2++GjNufz3eeKi4Z7zi/aKqQ5RBDUa4tKo4+F/6Doffnm0jEYZPOjw
         5g6w==
X-Gm-Message-State: APuU4Z98/VRJyhpt07efs1ehIjvwmM6VS7dM11F5aeFTOSsPBbHspL8J
	Mnq11WA6O38D73SeAhPteZRVQxk3N2jTeoWzgM4Bzp6jHxO4QaV8H8kYrSWbAEDX62MvPvnzXfr
	5DQVWGlA=
X-Gm-Gg: AYBFou2DHoueVfazw/1zX2SgjHoI2ZjepXsNOhR4lZeOy+l+mY7qSCuHE7fJDJTntqz
	fTUeGV1vWyLhVvJ6w1nGNLl6ADVrspeE9o010cNeLUwDh2+TcXnsf9pyPKP/aC1uNsWk/NOnz4L
	uBDUhxET+PkFuBBKD6zaureandfxUnKaPnMDXk2OUtkGjsPd/u6j5Esm+m+FR6P5s+g2JDHYFpP
	NODPzsG5kdrfly++ZQabqdqdLid/Gu7dL+TjZiHBYM/wayFhmqVA0STdhtLMkD1QBgBW5Ag+v1c
	q3EOl5SKyBNAJhq1HeIher3DXAgiLbBlhsue/B1QS20T5LpJbSQS6E+px+apoNZKSBnF5uqomKO
	90hLfs6RKJAO/6ldCSp0aL3HUWFO8rJizY863gQ4GgtlblZ2jhYFNjSaskDe6a+r7MJrerP6Sx6
	4lA15GVbIQ6dLx9Oz71HtZ0NlV4J9Oodu+i7QWfBxL440alzpS+AR6oGjN2252xJOtk69y2aMlN
	GQTmtF+aahRvSkt3xMxW7sosfn5ImFKRpgP5gQWOZ6gmcl54bCrCIXaf7Ws+bb/M864Lsp4jABE
	8xd/mcSMJX7XWhxnUpLwOeRlhxKGe9vs2JsmapEPQ8LRIX568a+K2pml8DMUQ8Fux/Blj4sS/w=
	=
X-Received: by 2002:a05:6830:4494:b0:824:df9:971 with SMTP id 46e09a7af769-85d3636d0fcmr13738484a34.10.1793817810240;
        Wed, 04 Nov 2026 10:43:30 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/8] io_uring fixes for 6.1-stable
Date: Wed,  4 Nov 2026 11:43:20 -0700
Message-ID: <20261104184328.516206-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
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

Hi Greg,

Here are io_uring fixes for 6.1-stable.

They apply on top of v6.1.191 with the current queue-6.1 applied
(stable-queue 6575ff04f2fd). They don't depend on anything in the queue,
and apply to v6.1.191 alone as well.

"io_uring/io-wq: save worker type before dropping its reference" is
already in queue-6.1, so it's not included here.

Patches 1, 4, 5, 6, 7 and 8 needed changes to apply to 6.1, the
[axboe: ...] note in each says what was changed.

Cheng Yongkang (1):
  io_uring/timeout: count cancelled timeouts in cq_timeouts

Chris Mason (4):
  io_uring/rsrc: charge buffer arrays and nodes to memcg
  io_uring: charge tctx nodes and personalities
  io_uring: free XArray nodes left by a failed store
  io_uring/sqpoll: don't wait for the thread to exit

Daan De Meyer (1):
  io_uring/net: don't retry a non-blocking connect() that fails with
    -EAGAIN

Josef Bacik (1):
  io_uring/io-wq: no new workers once the exit has begun

Yichong Chen (1):
  io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

 io_uring/io-wq.c    |  6 ++++++
 io_uring/io_uring.c |  3 ++-
 io_uring/net.c      | 12 ++++++++++++
 io_uring/rsrc.c     |  4 ++--
 io_uring/sqpoll.c   | 28 +++++++++++++++++++++++-----
 io_uring/sqpoll.h   |  3 ++-
 io_uring/tctx.c     |  6 ++++--
 io_uring/timeout.c  |  3 +++
 8 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.56.0

