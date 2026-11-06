Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981078;
	b=ZwU0yIn1Gt3m/GnBAWhXRD27Pv83rCCd2oZFt/rXWmz/pa0BVXh7gMCZkiwDVwkU575k
	 agQl3yfH5Kf+jimNNYqPVNwHz9/TkTJoI/Yku9hMm11C4chp0RhpczHrq11PNYrbF25Hc
	 GO4KL2VDd1yFXFEmC4B2evsIExhGzKrVAcXtSqchXgpk0KJkDvNitiuNdFWleukJvNYQY
	 acOUZNG1VIHg+ZrxDWG2F77UvLmQS+tKFzBkYly/OQk0aA6ufRk1SayYhkaY7YwdH52ua
	 4AMUK9/2NQ3iVNQth4VjT7x8ggp3z6H8EE6hqHPCsD2Jm58r+Ecis67c3K6G2l/rApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ge/zVN4OrHH3glz23GfvxcZb8aPxUfChE7sml4cA/3M=;
	b=kLMfC9izrvCxk9mq5NVs8U68m1T0G66OZkUg7kBK/IWhML20ohGzT1OvdnWjSWzkZ/Jd
	 gi5QKP1+7d60xFInfROEhHXL4EbJ3Owarb1YErzRgC1YYqbHR3gRvMxaLqvxngjCkfYhI
	 khDcsD3K6s9c47Dm8sbRXGUob93XlctsneUYvd2s1NZNeHleHpYOL0G7XYb+73n9uXe8/
	 3cBtnqYZfz55xd9iPfExUeBg4TODuIUaeUDwHGMWMr42XpN33375886MSyqLxHTPRpNYX
	 QrCyeFhlN9z1/JU7v3ZuIAawht6p3WanrHRPxjkEwIbiTBtTtiYGPSGRKbLVEXi14cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mwlZhK+Z;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA063606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA063606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mwlZhK+Z
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67bee1f693bso698642d50.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981077; x=1794585877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ge/zVN4OrHH3glz23GfvxcZb8aPxUfChE7sml4cA/3M=;
        b=mwlZhK+ZL829RIhOfr9q8RWjBuE9ixnQb2MpSEejb1eo43g7mWzraSiirF2/88BOEK
         Ij4J6DdvV3DZQYn8y3ym8EYvO5B1jdMbrJw2Tc+5g7A3a05BOGtoawP1b+40DFQo1VSB
         2GoKH2+tW6+AGRWiMhAGO9qB2TMaOqJib/lgOJUwrnlYDjwgbQarVTyRJTbvs8CN5W7V
         hcMmf+1/m9BSGIJhHwHfxdfNxrfGk8OQ6pcKFPlGqfqBzwxBu0CXEq6TNec0ad/qB9ld
         thM71YxuAeGT82AMcxzMRr1d81bWu+i7u45spQbglXe9TCzdic2bs5xVHA4HD0EIxS7N
         jycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981077; x=1794585877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ge/zVN4OrHH3glz23GfvxcZb8aPxUfChE7sml4cA/3M=;
        b=TJiwmnrqWOfGinwpbLGa9VUp3hWkPN7ALEOPhpedIA7psHR3S7J7ig+XJT/azNRb5N
         +Ernv3Atxt6KKyNhddFFu07hu3i1YAzWP/neY7Uud9uvn40RqAuI9exsfzlVd8/t9iL+
         FcQ55Nbm1i7r5dTkivXK+z/VLTf6tJE7VC64lpMZsj9dyTSDdXMpeddjadTNoWn6lkBc
         4a2DER4md7RZlG+2YMGd3lcXI0LvDxADYHaqQeXFeX1AJK+UpSzhUK5/9XcNcOlfOPol
         nTcdJcBPX5CNYbvjxHv7SNYmjIRzTIJQipeMb1SwilfiT5mPK/ngCmUsjIrD+DY7Qlvy
         5Xmw==
X-Gm-Message-State: APuU4Z8d6kPBx8IgJIph/J7pGg8pO6804p76ZbKv/IZt49PztVWNI4+/
	1Za1iWzCRwV3SDW3ebGBvkhXT1760x2nY4kfe2cZp2cySlda2t9uTmUm
X-Gm-Gg: AYBFou01NrpaMR3FVs1QpcKbljWg5/LRRUbcDkR9Fb/wf+F/7tygjdzafp999lmINd8
	lEpO/d5gFz+/1o4DzWXyc/TE70hwUIkXe1Zfg+7Eszce6NzkfiEEczMujM1ZuD9Dz3glRO54tXS
	tah2+I/12veAdm4SKzdWuP8FObNEsrTYYq01loX5SjvRa8YNKIKVd2XC9mkgL61WOnwaWcCr0sJ
	fF7wOUwwpqiRo2M84KCoLjwEfJxNU1XheYZKTLRdbQ6cIeBpe3PC5D+znfrCUnpzvCgS5QqhBbX
	5oQEuV5iaEWWmfqHV5YtlyuG6e/kfvvlbDiH6hc17LJK1ol2Yhvhtq8Rr/mquoB/X5gBKwhUalT
	/Z06LfkIqYQ2u3X39SaSnVqfD2yj9SdGKNpEM6IVEfqpOPpZU1EJrPt6IDC0KiS6nIElXXAwWkH
	TxmSvafTnLE2Yxr7wMisBMr3pv/3zSA3N3KVWIXBVjihRURZ9YpdMFm9TWqiTB5vsUJ9NTJGgMs
	2TBIrzyReUy6BWyHw7IRuw+5+2O6rU5j8PlEcW9igOkuwBSqh1qlaUwcL3mRjBZmsyUuIEg9jMV
	wPVQgbgUWsM8bTXKoFd+x9Muz4xS7jmlfG0Z3n+bZCmqmxJO4GuAZnXqUm8OkpFL2wG+rSH3X7y
	vfLa3JA0E3LzzNRjUc5pCA7xqGbmdQ3nvKrobqg==
X-Received: by 2002:a05:690e:228b:b0:679:a650:a083 with SMTP id 956f58d0204a3-67c1428a29fmr1291761d50.21.1793981076502;
        Fri, 06 Nov 2026 08:04:36 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f770cc6sm21382727b3.9.2026.11.06.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:04:34 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	brauner@kernel.org,
	chrisl@kernel.org,
	david@kernel.org,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	ljs@kernel.org,
	mhocko@kernel.org,
	nphamcs@gmail.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	weixugc@google.com,
	willy@infradead.org,
	youngjun.park@lge.com,
	yuanchu@google.com
Cc: stable@vger.kernel.org,
	ryncsn@gmail.com
Subject: [PATCH 0/2] mm: fix swapcache writeout and cluster table publication
Date: Fri,  6 Nov 2026 08:04:30 -0800
Message-ID: <20261106160432.2552507-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Sashiko's review of the vswap series uncovered two bugs in existing swap
code: reclaim skips swapcache folios without anon mappings, and cluster
tables can be published while allocator locks are dropped.

Allow swapcache folios through pageout() and keep cluster tables private
until the allocator locks are reacquired. The second patch completes
Kairui Song's locking sketch.

Nhat Pham (2):
  mm: vmscan: allow writeout of swapcache folios without anon mappings
  mm/swap: publish cluster tables after reacquiring allocator locks

 mm/swapfile.c | 106 +++++++++++++++++++++++++++++++++++---------------
 mm/vmscan.c   |   3 +-
 2 files changed, 76 insertions(+), 33 deletions(-)


base-commit: 32959c9a49d24faffb39413322ef80014f88dd16
