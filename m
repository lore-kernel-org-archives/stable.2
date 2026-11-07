Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068170;
	b=bfN3v5z1Y4IFFY1xLBExUgIVkK6PT3mJaks5vpWjmY/Bg1SkQyXFsqMUzic+fB7Gd7qC
	 Rtb93bnwxR4GCg7ordrNwLsVurYk7nvUlF3KnFXiseRgvel+0X7BSXCQt0Jk9wR8Lrc8W
	 3cuRJyNCTWhIXds0Ch2QxjyR1sMpvGAOjvH5h4YTnBysuWLUzBy04wpTGXFwOIg6rFwaU
	 xhfl3Nzn0gT+DeCUE0TX0GlPDgB0wr0J36iCOg49VlZTN1GMaeowzTSMXYTP42OUJcs6a
	 V3pklTD22b+XfKNft5CoZPu2ay0dJmx3feGdTR0O/OXMTsE/1k+hbTqWeX79Rc06Zpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ds1rdaCiZDWLpLvQ8XsIu2E6Ei1SkwxqUaihTOAQvUU=;
	b=r3CpEht8BXIp7hZhhWPgluvm2ATRZnKRVX1gwy1chv8azx3Ko+fMC+yU6xpJ/Z5G19/+
	 TNNZIN45TYbCkWvdvney+9s6IfqN4wqM5/yfp5bxSLW4+Uo+65+yTqILbgTVsNr9ndtY6
	 WfwrVMdwFw3LdmttKciobwrwC+8s/wSw0RJV2eMleNUVFSoi6xshSCAPpTUj+/9vMG9Ga
	 77FJPmNopFwW+CJBMWlfaGCWXypL2WPr5lNOfbHqDtH45YT/RgFkimgd0093Qhc4OHOaC
	 6hQUYE71ShD0a4byLCKrnf+jFVk/K1b+BJO5A9y1x0c0dQ/+zu6MggKmjNFzqAjMv2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LOydmRJs;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9D606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE9D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LOydmRJs
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso531107a12.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068169; x=1794672969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ds1rdaCiZDWLpLvQ8XsIu2E6Ei1SkwxqUaihTOAQvUU=;
        b=LOydmRJs8KUxWqS/gz/NW5LxOx5fWdaj04ZFsrfYfp7yesv5F0gYp51244RsZ9Gusm
         AYUCRNa1O0FCCLwXo1rTDUXRbQkU80PAu8LZMLYRsvQPObj+Y8+yjsIOkSWqvtLvudZY
         b4G3Zmpj7BiafdayKUSE/fsGtq69Is1Q7WrvdRL/oBXYJwx9s1b6nbUEHT44zGi7bN1M
         zCIoG+SgI8VROzbQzi042qnV942XnvuXL00/8XBqgAyDAyYs9+p1o+craiul9Sbx2dWQ
         8T6dJ5Ueg5MZZ08FQ/e6vhSs0ls/ozPEoZ3Cl5Q5pIJLWWgnByHJW2zl83CfTXwLZOBX
         MVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068169; x=1794672969;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ds1rdaCiZDWLpLvQ8XsIu2E6Ei1SkwxqUaihTOAQvUU=;
        b=wKFLkOXx7tHunTyascb7K9Bo+iFkabmWHF9CyAKYiwFWk2aYgr0KGX9lF8EQHJby+B
         vzBqLDiIgSjpIxBdm5a2pwM1aSlnun7YdYQYN/EPDv5OCi0NHiVPNC5zlBMeyxzuGCRD
         Ujiv2yEkeY5bSwlN5hyBI3Koodp8XeaNa3LP3GJDv1sjIounRBoA08k7cvOvq62N4qiR
         0ELza3LNKVfGbZHEhnhHaAcRv6Rq9CWhJDjwq7yvjjUz69w1tw2aIm2OMm/pdAYjzq7i
         DYrzM/949o42p5dUUfAr3SKJoy5NDomxD296u4eq9f0lbLqOPW/oXP0ihQU0A5ELcTK5
         5eNA==
X-Gm-Message-State: APuU4Z+re1jM7UJNgsaKDQ6QCle/pac7KNFSRULTBAfrPUPSDJ6874DJ
	HSjLVoHvj19kvXOvU/mFgEyXuJeE/RZOtz/ftTtl7yyALrCFjHl3zpyiIiIa66plijIYVPfg6Bm
	G8+LJKNI=
X-Gm-Gg: AYBFou1qaVVo2R6yAobA2YPxRXSA2n43ns/glAhgU2H7gIg/CBi7Dk60VwQHwWFKJYC
	Lit7orjKQ0Z2sqn4K0brHnvD+Ty3m3Qr2cxCcqahlB0nX3v9fc1g5rP2+JTcuk/85sjUFYQXmXr
	TO1vPyU9x8ToFPKloi2bbG3dqPBBcITtAXx+7Jf+7FZK/pqIymaH9eOXnXhid1PG8ZI+ZAVD2Uw
	fsGTFblIYMFXcLPU4qWu0BF8CjSylNDNcPCYsV1dN6MCkNwEpmKGLKNwKdQ06K80Ew7qxMPTh9k
	OXwpjX/jI5fE9mUSRlNyHpkQwjQUMI81RqUhYTvXDkb+Mt+07iucjWd+5tqrcOFJ+N4k4xvCxt3
	kfVQywWULDHcvwbA8IEn1bH6Jwv4LeWvQt19XWizU8JP+7Q398ok2G431A0n3ParyaNZHI+s/fc
	l39Tog+nKg6y9Kj6h7WG7bOH1GZNAV4CZKqjNCyrs9+vmWdy/nX0TF22Kawugh8A+mJuVKXTsgt
	sDkcposBaPu8YeAj2aApEeRT9wXLxMTkngeZ7Tx3LMLpaw9KRXEtRBpG5aofm8zZMlkgYIEykmU
	NbkrSYp2qr9kVUt7C8bwsjJ8HD/4/0RyRtpRXq6l9fKaU4pbztvky2YwrMMcH79jds2jM++6VjI
	=
X-Received: by 2002:a17:90b:534e:b0:3b0:aaa3:ce8c with SMTP id 98e67ed59e1d1-3b0db6d3fe6mr5163696a91.14.1794068169077;
        Sat, 07 Nov 2026 08:16:09 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/9] io_uring fixes for 6.12-stable
Date: Sat,  7 Nov 2026 09:15:57 -0700
Message-ID: <20261107161606.2500384-1-axboe@kernel.dk>
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

Here are io_uring fixes for 6.12-stable. They were waiting on the
io_uring pull for 7.4-rc, which Linus has now merged.

They apply on top of v6.12.116 with the current queue-6.12 applied
(stable-queue 0ae08d01c389). They don't depend on anything in the queue,
and apply to v6.12.116 alone as well.

The io_uring series I sent earlier this week is already in queue-6.12,
these go on top of that.

Please take patches 1-3 together. Patch 2 closes a race that patch 1
opens up, and patch 3 fixes a WARN_ON_ONCE() that patch 2 introduces on
SQPOLL thread exit.

Patches 1, 6, 8 and 9 needed changes to apply to 6.12, the [axboe: ...]
note at the end of each says what was changed.

Chris Mason (1):
  io_uring/cancel: drop sqd->lock while SQPOLL waits

Jens Axboe (3):
  io_uring/sqpoll: don't attach to a thread that is canceling
  io_uring/poll: don't poll a writer for a read side hangup
  io_uring/poll: don't poll a writer for urgent data

Shakeel Butt (1):
  io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread

Shang En Sim (2):
  io_uring/cancel: count all requests that a CANCEL_ALL cancels
  io_uring/poll: cancel all matching requests in one pass

Shuai Liu (1):
  io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Yuansheng Yang (1):
  io_uring/rsrc: hold uring_lock across index-alloc put_user

 io_uring/cancel.c   |  3 +-
 io_uring/io_uring.c | 23 +++++++++++++-
 io_uring/poll.c     | 77 +++++++++++++++++++++++++++++++++++++++------
 io_uring/rsrc.c     | 21 ++++++++++---
 io_uring/sqpoll.c   | 26 ++++++++++++++-
 5 files changed, 132 insertions(+), 18 deletions(-)

-- 
2.56.0

