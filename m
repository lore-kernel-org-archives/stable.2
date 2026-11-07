Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068120;
	b=uBmNLyJ5RfGyb8qKOcDYPZI8Rxhg6QEkIj7WCPMapDVA9mHAlTd7OPA7o5/qYoc8I9ZD
	 Y0/ixmlt7vmo3cg5ctkXIwcWen8BwWY6S7k7EGPDuEyJSBxYifOuJug7XHGW/X61+ci+a
	 bBoOnBNwkSs0J+2T4ykRRITw1/09GsRedzSgXseNl8TQ46947BSH/hvgB6Og3w22e1Oyl
	 hP/tdwx78Ewr2bLvNj5jnyDHV+VicU4TksXUvaKERbmE2jH/6bBYZBYShltt/Wgttb1DQ
	 1lzLqM/L+t60dbt6uw/bhBM2nYgWdSTZmRFTbgHoGe9i/ofs+IbX3gJhXdJIIowKV+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GQu94S+RChBxNN2SxGkk9mT3MKMZ/qAKK50dXR6p5PM=;
	b=fcvluYSG6go7ROFe2ah8BzJQpn9qo+j5CPojqFpNUfDQ6EFAieKKuIYSN8V0AbkrG4Ze
	 bC5q7PNr/XaXXv6JlsXIzebmbXsimKYR/793PsOUgnWJCayS5nxfI93KkdxbDl+0gFZJn
	 V1RaVwBED9xfDv9TtZCFrjumOU/nnL4XmvVR2RuXPqVnqSLVhMRiLAgnyKbg8ldR9Yk7v
	 D1AAOJ+w6fDt+X9EoEWhRRIn7GOl9uzIr94Oe7zax4sEOhusJQFo56we964fDwM0O7DHy
	 BG2BlOLa2YDGtSJXIoc235Ctlnq1PZwJip7lVlY+rQerigD4ZazAvnCsBVaSHbVBCrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c5J4CkM4;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355D606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1355D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c5J4CkM4
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ccca948203aso587881a12.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068117; x=1794672917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQu94S+RChBxNN2SxGkk9mT3MKMZ/qAKK50dXR6p5PM=;
        b=c5J4CkM4xlAz15h1+pilJTXWbnzi6uGIL7bXkaTSbXSE0JV3NmaBezbtyept0KjwJa
         tyYX82FR6dlKpro7q+os+hFCMsccMQQH7gZMtKHkMJYTx5o+yAnW9emB+kOS5aliTPez
         0gocWHsFR3LGyT7RY3rbvc2BpSkgnqwzd74rQCj3owRIREIB7VSDegbw9VXuq1GBHS/j
         hzt2gd8PhQGjKEEyDiEdtiJBEIm7xDNGunVSxe/wLjIVmbZAP/MiQd/jHFU8aEibS9+W
         jsrVyyyYJkmC9h/gAn0Juci7KGBOCWjvHHR3UeLA4X6XmX+sHOcXZCV/EXLx08v36Wlw
         UxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068117; x=1794672917;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQu94S+RChBxNN2SxGkk9mT3MKMZ/qAKK50dXR6p5PM=;
        b=rWMrUtf+ajkCigf8novxFBq0MUDtYVdxBl2VW/l0OdC8q6X0F59Okl7CoPR4U2+kDE
         djRFCDQMne6XYa7L6ThQVVSMqJCK9PITsVmqMNqn+p3XWUEcoza232ufxPiMgbPQKpDq
         6tLSP2XStbxM+P3wBtAQf1W4e0YpS1/f72iOGj3skcT60OGIEV0LK1aXZBD15aHQfAQU
         6/nM0l9RK5gJYLGjaXX7xISfdXsKSgjT5nU2m1aRbjmzdQhl2Uxps0vPpJIs4OfJRK15
         mSpPb3u5bYDdMpEKzQ+C6Cs6K89YdY3yV5Kon6iwGb/xRvNNQIkKwkkM5LgnDdVtyTky
         17Og==
X-Gm-Message-State: APuU4Z/d0yVciBMh7CRnTrlrzAm1wJV7oK9sBprGuoDmOQQoPdb60W5x
	ByKPWbFbHZtcjvfgMMRLYHFj8WR/G7eRgJzfygNx2BkhI34DSsWM5z6ZZMf7P9AI901oRhQjppE
	cT2actgE=
X-Gm-Gg: AYBFou3fKp/jyLx3NDhEArNBMskhGS26oIi9s1w0LxKSUI6ZkzpcKOX3OfA1TITG8dH
	81JK9T0U/Q/8FCGMxG8MCQpSl3kkpzaj4vMdW6qiYNOmUxbMpYkItypVn4obH4loP5d/9W6335U
	3a5sDgdkSwOVwraaXZW0cvKoebd/ust4vk0/8IrYcT2XJXtqwk1tVvk2h9IMh4ksoIug1hQyiWR
	sYUMcDvTgWcfuBJsPqffO59ckvilrlRrhavTjSuj8iJUG3a8Qj5JcgwS8eE/5xAGXiVXsy7WQB7
	8L0D6iLVbRmRjh7IwquQeUGIQ8Q+48UqVop13X8tiIHoORH+0Q2lycOrjAiVRLZYmHhMD4He33w
	gcHDv4Usypubrd16Bk6rkjFZbOAl+xxKwVc54Lm+hTEkDPOowO0bjL9xYXg112FyZfTEawAZTXh
	EPMQO+1ZQBiXycnLlhI9qZ19IoU9BvdM5QB46VkSvh9khFL7Gbt6CDm7cVit1K0VJWnMdpMcDQ5
	pSefRbOJWKuUu9tgI/xNzKlWaH2iKMVXnhf4Dk8BnYAYurhj7uhOZjqKSWvJgZBUKS2M2T2eSrR
	LFJtSVnIjaglOs4YeG+lY093LGaW0W8jiWHtYWVk6ICFfgmfPuXuWIwo2NybYC5Xr8fR5KQ70HQ
	=
X-Received: by 2002:a17:90b:384f:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b0db60a50dmr6053762a91.3.1794068116882;
        Sat, 07 Nov 2026 08:15:16 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/7] io_uring fixes for 6.1-stable
Date: Sat,  7 Nov 2026 09:15:07 -0700
Message-ID: <20261107161514.2499962-1-axboe@kernel.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are io_uring fixes for 6.1-stable. They were waiting on the
io_uring pull for 7.4-rc, which Linus has now merged.

They apply on top of v6.1.192 with the current queue-6.1 applied
(stable-queue 0ae08d01c389). They don't depend on anything in the queue,
and apply to v6.1.192 alone as well.

The io_uring series I sent earlier this week is already in queue-6.1,
these go on top of that.

Please take patches 1-3 together. Patch 2 closes a race that patch 1
opens up, and patch 3 fixes a WARN_ON_ONCE() that patch 2 introduces on
SQPOLL thread exit.

Patches 1, 2, 4, 5, 6 and 7 needed changes to apply to 6.1, the
[axboe: ...] note at the end of each says what was changed.

Chris Mason (1):
  io_uring/cancel: drop sqd->lock while SQPOLL waits

Jens Axboe (3):
  io_uring/sqpoll: don't attach to a thread that is canceling
  io_uring/poll: don't poll a writer for a read side hangup
  io_uring/poll: don't poll a writer for urgent data

Shang En Sim (1):
  io_uring/poll: cancel all matching requests in one pass

Shuai Liu (1):
  io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Yuansheng Yang (1):
  io_uring/rsrc: hold uring_lock across index-alloc put_user

 io_uring/cancel.c   |  3 +-
 io_uring/io_uring.c | 23 +++++++++++++-
 io_uring/poll.c     | 77 +++++++++++++++++++++++++++++++++++++++------
 io_uring/rsrc.c     | 21 ++++++++++---
 io_uring/sqpoll.c   | 14 ++++++++-
 5 files changed, 120 insertions(+), 18 deletions(-)

-- 
2.56.0

