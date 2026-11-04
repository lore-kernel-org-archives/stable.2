Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817824;
	b=fU6Rp3P+dIfn+6s5T3Lk3hFC7/a3H6Rv9xrceMc3krHoyudnMq9KTei23T+gbcyO4Zs7
	 CgJjfiGiMVnUEDneoGD7e4mpUyjZMnql4ex1KxCn+pqsSgPeR+1D9AgqgNYH9w8+zd57+
	 p6aTNVNt6Vq/r0MYfarQq1T5PBjNEHvi2dPJnNkst7DiIcbC5ICePC7GSZixNAFFwMaJ4
	 oM85Lyjp+ivFzHA0tyr/wcIwG24+CeCuEDH3JAYc6PNj7LqxdKmImVcXG6Y2mhZORtxe9
	 byhD8xFmgI1bTD26CrJThksV2Gl2B5+9KYXanO8gjZhRyFDh8h9xATjW6N2XzrCxvmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CyayYLvL6Z0t/nFkXMWvK44cnkjbSYy3r4D+rmImad0=;
	b=NWH++oJ2BA522VswKm/ZD3SfGNJzPvZ+nGs3HnAfc+goAvjIQPWy8mGuevt5ajxCizNU
	 TMfMA6JGFQxcmuEtoatcF2YBs7zkQL+SZqOmudzQriMaelFSroLKRZcjJ8HNBJ1jWvs5M
	 VkaiUPdFCrjnjL3yIVzsZAZ1Sod37t38WLdVBExROB7lE/p+EgpKiAtsjg7QeQxchtzq0
	 xrxnrhqcEjyhsBmMlIiXrvD6urER8xWkR1Hla1+CbOE7sY5V+8c67041GidK+qoMo8SoU
	 j00ziFFNWYme3HN54kM14fwPKhIgUtw65j9IucD57gODF5MghDTUbBOs3h7IdGhhCvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aJcT3Gr1;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F59606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aJcT3Gr1
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4d198f1a591so618762b6e.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817823; x=1794422623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CyayYLvL6Z0t/nFkXMWvK44cnkjbSYy3r4D+rmImad0=;
        b=aJcT3Gr1vkBu+1SA7p5lpoDfEPivt06DMHt8E/1kycrfOEF9Ton++3PDbs4EyF+bhQ
         gobWbetVtvjxH8fOvhj7mMtQN1hoeEirUet1bxniAQD/fHKZiPkmizghgQPR9I9vfuV6
         9hL6GuKhuwesIBLXBlH9c2Ov/OQ6tdn7EnZSZHmozxIDqT1k3Vp6V/JCg85rNvmyWtey
         UZi1lrSeilzGDYfuNDUvUS+Vskxcwz0N/NbWGL9UPtqJ5Y1948gzkExi3RbsNHtd6kFn
         yWcWMFzetETuBv/F8b9Fn4z56/h9a5hde5zPBYBb3z5BkD0P+5fPoN1EfL1SfoGFGum7
         rplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817823; x=1794422623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CyayYLvL6Z0t/nFkXMWvK44cnkjbSYy3r4D+rmImad0=;
        b=XWzsQFct0MNVVomI3odmPZjtIESKbe13f2Phvi0cuJ01NjB1wpkEXbn3l7O/wcFAQf
         hfbFalTbTHyPqVcalo5SDiPuA5Z8nOGwO1xXYuLDU1iAzlENIMsZB0gHLT4iwq0mSJEy
         6YTKAAUdQmMB2Q0cdbka7egEFzwPNvJa9xXR1CgvRoEU6Gv6GfJv+8tdivVcqkhfpXt2
         SjiAByzMMMuZKRQHPrDUw2pD3IM5fVla5asbNDy30nEKihmq6VV1DIkP9Hp+G+SKvJWI
         I/aCx+vjEatKhbpw9ZMgdPT+CYD1GSD85oQMPmp2D7hS03ilH8JSaEKm6owrD9SpwIbP
         5nAw==
X-Gm-Message-State: APuU4Z9mmtdPxncz6vKyXgavFRVZeqADGUPyMWwFSB0XpckNIHElVXCV
	p584dFax/i5c5YrE2r/CkN3do7blXdbsQjJcPw/uSVZAQetpphNAshZIfiCiUeYxvDPgK8dhC+L
	zD8La5b0=
X-Gm-Gg: AYBFou0cnjXl7DbtODtkbVWX0yAgG+xP9eItzRhjZIh+ZlPHy6Tmcs+wjOCWySjEq80
	Aithgw8G6yw2I8IMOXKs0IXW4rJd86wJkdALVTnuDmIqVswZvVMozt4yf2N7j7kgp0q4DyKJx6R
	3hQM1BXM3sWxhDlRiAeD8GabN1N0+cwfxZCi2OP0CCOSfy1cnE0uDYonM/F9Z9VL3JfSKQs/AJa
	tzJLLqiNRF8fmFLhwPVxN6QBwexJX3+b3ImUtfajOSncHHTz+wbWSbjB/deFV/s+SOKtogtuEGc
	FOZjyOjkv9JByv62FHRtiQCQVhOJNJoKvN0DN3aLSscnclmJgA1P2dOdVtWh8UJRMnUTpOvYZvE
	EbiFfw2fqcb7A/Cao2xVA2zjU8Ffz4fE+qv/zqfCo4TxKflI0VFBBPZx0PjRg1NhIFuTqUegOmB
	sFkT3Av6PPTMkapxl59OTEMmFuE3qn23Il2PsqtUstFRAqGIrQodsOkCyLvAbBHcTv6mNKZM/02
	Krjpzf3QgJAIYLuTvqAG61QmZnSNEihjyb751lOsemj3T5eBA6zK3KC0AXgzTGVDg/GfuVr1+Pw
	y6oKrfouqI+YqPXaUXcuFPstOZcwOjo0jRDC8ho95SbBXqoOf3A/8AjpobvtCx71I2ftMG+ZNQ=
	=
X-Received: by 2002:a05:6808:1a1f:b0:4f9:e0b0:37af with SMTP id 5614622812f47-5640dd96d21mr12878967b6e.27.1793817823095;
        Wed, 04 Nov 2026 10:43:43 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 0/8] io_uring fixes for 6.6-stable
Date: Wed,  4 Nov 2026 11:43:33 -0700
Message-ID: <20261104184341.516297-1-axboe@kernel.dk>
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

Here are io_uring fixes for 6.6-stable.

They apply on top of v6.6.161 with the current queue-6.6 applied
(stable-queue 6575ff04f2fd). They don't depend on anything in the queue,
and apply to v6.6.161 alone as well.

"io_uring/io-wq: save worker type before dropping its reference" is
already in queue-6.6, so it's not included here.

Patches 4, 5, 6, 7 and 8 needed changes to apply to 6.6, the
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

