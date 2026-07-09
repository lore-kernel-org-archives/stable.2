Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B843273D8F
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603151; cv=none; b=Yc+sOG4g5ohyC0dUloBtjBzOXsYPvBTxemoVIXQmBHEl2I1Lif5sAIFexPIIFD6FeTAqOcnLKqppFCmfFD8hAy7gn01CytoMsLRYw5CTD8gnjfeTEmxHCRq87qqJQpuMpq63fnSylhVdC22I8kXtLoQJ/RIMpXGKz9zQQRD49F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603151; c=relaxed/simple;
	bh=F9vDf47ixbnznasLGKzTkoh3Mf021Menp2X4kQr5Gw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtls8sBOQflPiJcQp9GhuHLjHOfgGz8gjKaJp+a9xCbFSeuHqgc5KLBgaZfFgLBaNHbjIrnopNZkbhkMtjkS11/uoYuqtMsbSHNIpCWIlsdah82hNITaVOTNHf+L5C8izCkpu+mnI5KcbTohU1zJNFhYF+dGfVHnMznsRo1NGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPidSYWT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPidSYWT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so793642a91.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603150; x=1784207950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcJGxgmDnR38OVaHjck8+5Pv/cW2l1vuCnw3aV8D/74=;
        b=gPidSYWTZv0yEdN1qbgWka+yzjA3twD9jqvHxJWoutL6wP3NZTZxdELEbFMDyh4poc
         Lq6zDpB2oKLX3m5Z2OwAB5vJhZgz7hFx/VHZpx85ywIwVfsSMIHvXskm1KmHjsDeckdA
         1hLQyFPoRKXZjuBRwQm0MEu1t3Zrs278VMIRcTBhpR4A+A2HM0zq4DSnrGkw85CFdqCe
         kcpZxQVrJNofBQQWnMLocS9B566B7Tzf3vh0nLeVAVRyp1bPhMJ4dgTg2vyASelmJTwo
         pBHtVtaez63TpgY6pxhD9sf0XQgtBzUm2apvAyW0/5645yakWALro1rRbC80P4m80Tfm
         SMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603150; x=1784207950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UcJGxgmDnR38OVaHjck8+5Pv/cW2l1vuCnw3aV8D/74=;
        b=m7NYBRpKwB//AU2cJHxP1wqfuuH/4+07pNZeKcZrEwuq/Ef5A/xH4JHi/m0zBBDOlq
         q0Iroiy1UokWr/+tzlYGwN4fFLYqtP7tdZJbbNwyC4K80jWWst8MqnxML24hj+tHVQLm
         2eqwSGbJjVtmICA7idvIMHtboTMDrXAU7p+stC+wUgEdnGgiviYSpRZnlL4Qzd+yhPqS
         1ULfXMtH2+laH24rv3M1HdQJWgB/uxlygoyQNVjlUIJryDRGXmndIHmVaZcQoojmV/C5
         kzlDdIVe3QGXKMK8wCY8S4hnJr/3K9AhkcISjwbg+TmStOcQGkszAyZZ8i9Rm83Jkb6B
         JAkw==
X-Forwarded-Encrypted: i=1; AHgh+RpTIYhvlP9scbiEE4W5LysP8Jgbaj96ZES/SEi2590j2Mtn/xX6n/rn9QQ8I/kIwMIVMtXn3uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Vx9gmPhIE4B8+LYeQekegAWOMNXFzGfk5KJhdJWQp30EqIhg
	U+NHPMV0JXZcepl2qxfDsItSayr2qKTDc9cth33zD8Mv2XN07odoizPint3E4M23Gw==
X-Gm-Gg: AfdE7cmIs95N8e9C67b9RPzpaZddcOHqeD2JY9gid/TUdO/26DWSeJrgVtpT2BXL+kB
	Uyu16g0toFfWfg4QCrKzp7WAHlV6YAaOvqX77Vx18xRuIZORRfiMlS5oxmxqpidLQH2+dz+LYv9
	785OgCaTZqhJVUEg7Ehbw2C6Nd/nNg27nqxhvUyXQiheJx6SCtFXOA/PiVAUQzbeMzOKeRAouy1
	0w4KAPBYwnUPYINLM3hnmuGCrZ/ugh6vHS9StpMc3BaxhfS2tJgeCVV1beS4R10hn+1UAvU2SrE
	1ZoR8ae1K3h0AY64jabMkBvpYLYOU/UcjCtdrPVMBmkTpWylIwjspRKMQoCcfhPeyrVqY7LJ2O2
	Gh2ExfvvAJyaDP4swOtlNtOZIdjG0R3+bhIr9D48R1QAWr9X3heuBuuH5vCIlb/rht4s/8r/Vfa
	saqv6hyCDpLYVUJA1v5pG5UCf9y6bk0vdjgTVVVXu/iz85cTA2KA84p9hqSw6KKhG0
X-Received: by 2002:a17:90b:510b:b0:381:b1ad:c9e4 with SMTP id 98e67ed59e1d1-389416e7d75mr7203452a91.26.1783603149803;
        Thu, 09 Jul 2026 06:19:09 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([58.146.106.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm33960852eec.31.2026.07.09.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:19:09 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io,
	axboe@kernel.dk
Cc: gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v6 0/2] badblocks: fix infinite loop and validate sector range/shift
Date: Thu,  9 Jul 2026 18:49:02 +0530
Message-ID: <20260709131904.596684-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak9CC591ivuQ4BP1@studio.local>
References: <ak9CC591ivuQ4BP1@studio.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces the single-patch v5 with a two-patch series, per Coly's
review.

v1-v4 chased symptoms of the same underlying bug (an RCU stall found
by syzkaller through the nvdimm ioctl path, in _badblocks_check() /
badblocks_check() looping with a non-advancing range) before landing
on the root cause in v4: rounddown()/roundup() don't modify their
argument in place, so 's'/'next'/'target' were never actually
rounded.

v5 folded the round_down()/round_up() fix together with overflow and
zero-length guards into one patch. Coly's review on v5 pointed out
that:

  - the overflow check that was there wasn't sufficient on its own
    (only one of several range-validity conditions), and
  - the round fix and the validation should be separate patches,
    since they're independently useful and one is safe to backport
    on its own.

This series:

  1/2 is exactly the round_down()/round_up() fix, nothing else. This
      is what actually stops the infinite loop and also fixes the
      32-bit build breakage kernel test robot reported on v1
      (rounddown()/roundup() do 64-bit division/modulo on sector_t,
      requiring libgcc helpers not linked into the kernel).

  2/2 adds the range/shift validation Coly asked for: s+sectors
      overflow, bb->shift too large to shift a sector_t by (bb->shift
      is populated in drivers/md/md.c straight from an unvalidated
      on-disk superblock byte), and detecting when round_up()/
      round_down() themselves wrap near ULLONG_MAX.

Both are tagged Fixes: aa511ff8218b ("badblocks: switch to the
improved badblock handling code") and Cc: stable, since that's the
commit that introduced this code path.

Ramesh Adhikari (2):
  badblocks: fix in-place round_up/round_down usage bug
  badblocks: validate sector range and shift before rounding

 block/badblocks.c | 52 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

--
2.43.0

