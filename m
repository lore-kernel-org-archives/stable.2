Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068198;
	b=M7Tj7OpfhFscV3wCJkC84i562ifRwcvq3+SItCOxQq88SjyENHT1+faN48Sq0qfN1BFM
	 HlSK2DHuJVmny0qSKGaivva3f83QjUPX5guWFKkM7EQWImrcuNKwLyM99T3ksDrTmIr/4
	 giNBN/ZBX2q9A5WwU2sDEevdOLH8ne9XoaX/YwH4o5ovesdDw0c34vmXpfQUwGrDKwIci
	 ZyktqVV6EsrawepgpR1Y3JQjaaXTiChfgcWTE88Wcy7t+WpGrEjd13xM2ulxOr85zgtRN
	 SdDrm2okDIq+9k294IzSZCdCQU4xC9U4EGk0ykKddssSbTTbSAy/waKlKf3yrIQzP1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cAiyMedquw3qNxhZVrFytSVH2Bx5zwsPc76ygLG8ef0=;
	b=e/nJkFcipgRXnO3PqlcQqLPzmjbIhUl178F/IeB60CVtnBBPSohWj6VOhlP0FDOFZ2U2
	 MFm9wtGR3Kza2t+tPkyU2WR5PzqhSq53ED1Gxt/0Dn9+kl9OTuceMRlcT7G2pvKpcPo3C
	 Axv+Pg5pd+h7CKn4ZWLoNPfX5XLt8x7w4ZfNwGmOrWwwgicbxNy9P0Ql64dY0wQAZgvfv
	 SXrzROc7NK3y/w2Z3Q+Is+SqUeQnFI4y/VUsvw0wVcXKW1w3aUKvZMEB2v5IFruRzyVDY
	 RzLuyR2RTEu7ofMyMXk8Xkqcv9d2L3O1PpNZXvWD5t72Cxdj0GPrl2pl8X9dYX8WMbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KU8BhxY7;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81067606AC24
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81067606AC24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KU8BhxY7
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so644784a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068197; x=1794672997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAiyMedquw3qNxhZVrFytSVH2Bx5zwsPc76ygLG8ef0=;
        b=KU8BhxY7loqSgamPprRnikw+/aJEevpZw41N01332WuEWlpOGKkjXzBn06Bu6xK77r
         3YVNBY4rCxHsfK9JPAf2CMWafDaIGM2Xzl+RFK8ip0oQsDHxjSE7hnD/QB1OZpdgCWGf
         L1AVa+CstEVdEfQ+zUWs9Nls66jAINcb6b371tc3oTeniW/+u988nfh3DqQ4QqRc/owp
         hJqedGYusFxPClGdv2iIdd00i6d42sPGeGytUUkx987mwLjVSYaqnREu/ecSWdfVsR6d
         iy/6J+KN8S3rjc/KPE1yLkqZqVP8YTzYhnXhi469gd8/O1jgypYmLclPcixjZzg+3mqU
         drQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068197; x=1794672997;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAiyMedquw3qNxhZVrFytSVH2Bx5zwsPc76ygLG8ef0=;
        b=YlQT4c8BYATeBYHyMvoMlUPNwxL+a5PEqzOZNIBJ20+u7gHPpV71gWnGEFmn7IuXN6
         GZ3tngcB2D2Pp0IQEo21UP10EkqWcQ70XllIAYOqH38KIO+zkCGqAuiQ7fW522KUvlNS
         KgV41RiAP8msolrgYRdB9/RzR6hPyrcQ0AiCET/yoJo0/zjdev4+TVzJYVSFz269FLHw
         2Dsdr+Hv+QBvsHtNzXAbXoTZ0oqhQ+DYb8gCL4RBWxCWoe5vUqs3iFySmLjRVNNQ/Zpx
         sMc2QcHcG1p4gfFg81+POqVlXE81EZ1uTa++u12DIqUnxRb2/SETDmY76y1rdDq5TkdY
         Q/vA==
X-Gm-Message-State: APuU4Z8izytrI4m8TBRnF0pI7QNA6Nr55wS7ONVchVcBUkZb0SNs4TQm
	fjvCwja2o4XXoh2inhKcanrVIbpV/bI+Sbj+NmqwLFnyBQFvba+W6MO3pc9oySdEujQG7O8REaR
	gJcOZsAo=
X-Gm-Gg: AYBFou343FM2qUwVRjFFcatKUEJza0xkz6EH6E1N+e95MNwCfQnPrdSHD+MzpT568Fk
	PBhifwmrBbHBa0O0q9bTaSgIZ4JFXBaoRZCs3Pw74DGSQCPCOMrYSldrPDnkxhAyAme1iLSbvGC
	SAa+Xi+hU16C/cHauOMClBL87hp12U1CUHABTK2OaUxVCM3lKdWKEs35S6YshDDmn1Rf3Au+wcS
	SSPeIBwFxPYsJypL4uQJz2k0sarkXwKX07KTDteMDoED7PEzEP517yOgUrDpxWh4bv2nBo4P+f6
	RFsc7uTcmWrv4+eDBps2CkSLNxWoQyYpyZFozZjJ2xd+Vlb7kNNk+MfOEEzSwW+CgPvuG1KJHO9
	iPOZklM3Bd8Pp6JZUGebvKxaU4/IYD9sjhuUWN1XnlJi0IJlk3Y+zbvrUHMOHHFxDhQK4zvL/lO
	gEMTeSxZH89doSkEV2wPGDFMvTfol96yTmjwuHJuU/U3Omc2AeOMa5xpNAFeSfAkS7vNmku0klW
	EQdKv7Zk5xmeB/AB10NyStpoI8OSQkq38wKzsGiZqwmJxLH3RhxvI5pJOchT146LGy84iCZ+hYF
	PBa7V4fCZ3/k/KyV+OgNUgDH+9bNiBvu0VlwdWS+HbcmxnjQ4jsZr2PyDgz2nc4REwwMloLpfN6
	Y
X-Received: by 2002:a17:90b:3951:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3b0db6e89ffmr5761608a91.49.1794068196849;
        Sat, 07 Nov 2026 08:16:36 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 0/9] io_uring fixes for 6.18-stable
Date: Sat,  7 Nov 2026 09:16:25 -0700
Message-ID: <20261107161634.2500557-1-axboe@kernel.dk>
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

Here are io_uring fixes for 6.18-stable. They were waiting on the
io_uring pull for 7.4-rc, which Linus has now merged.

They apply on top of v6.18.62 with the current queue-6.18 applied
(stable-queue 0ae08d01c389). They don't depend on anything in the queue,
and apply to v6.18.62 alone as well.

The io_uring series I sent earlier this week is already in v6.18.62,
these go on top of that.

Please take patches 1-3 together. Patch 2 closes a race that patch 1
opens up, and patch 3 fixes a WARN_ON_ONCE() that patch 2 introduces on
SQPOLL thread exit.

Patches 1 and 9 needed changes to apply to 6.18, the [axboe: ...] note
at the end of each says what was changed.

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

 io_uring/cancel.c | 26 ++++++++++++++++++--
 io_uring/poll.c   | 62 +++++++++++++++++++++++++++++++++++++++++------
 io_uring/rsrc.c   | 21 ++++++++++++----
 io_uring/sqpoll.c | 26 +++++++++++++++++++-
 4 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.56.0

