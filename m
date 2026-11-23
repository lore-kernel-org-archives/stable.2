Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421549;
	b=CkjY0kPlK6XYETu7QD4iLOASD7uzHkx7qV1Q7K6tCtu0oLaHRju60K7u82lb1sg4FWVg
	 JDj1HFjUgISmzlQjd03tZUFOMkJJ96Q/ysKhHlk9VZTm4CNKQiTEptLz1wJbvnlrhvdJZ
	 cBD2ZSZs4DpIWt6T55+WXu19wMbBaCj92I28f0CBeBK2D77G9fwQoPny1lwYl8ttOYltQ
	 yvoCkdZERzWlHtsEko1WuXYqDsnlc1Mww4dGWS0jXZUkjOi2frHea1SzDqRxFypO6FfY/
	 uj8LHxSIDRSY48AY2Yt9zZSIDoPBB7G4FoKXRhFPePXgJPeZE7J/wTL1CohXvzO5s+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2szI1ZqQtgYM2qe1Z1F3aOmh0lr8LS1pFbMyBrHQw58=;
	b=JqnmVYuf5yqQnCF+7/VhaBxIsH6JnwW/Yq5D/0TACmy1ORcuAeDOMx+5WkTbhblYrJuk
	 LGfeXSX2U9oXZyGrclU7Ped/jg0gDHA81cRLTLwt+/LLQFd1ele2lStR8HtMmBvynU/VS
	 KuBIgId55RtS4RJ8H7MvhM6mMoQdNmhYXJE8wyQ94kqgN5zjiMGHef1ua31CE/MQPSSHg
	 tYc/R2qG9zq+Y/Z9h2rDG9KqgTJo/5ljpOLb5bveNbp+BBFsqhbtbuG41S/iCn3zHvc4d
	 l/qPS4XBFYUCgah1kZvmtGhXMsxzWXrsvr61KaY4H2s1sm3l1zOlYQGpiv3OZRnzwnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="TYuAlc/U";
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19448606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19448606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TYuAlc/U
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-94961d90b79so345733585a.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795421548; x=1796026348; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2szI1ZqQtgYM2qe1Z1F3aOmh0lr8LS1pFbMyBrHQw58=;
        b=TYuAlc/Uck7EToK7F8qMvGOp14+Y3Z9Lo2bo1rUhwf0BXJGtH/DG9/KyjSTwYgUHAw
         LQgslvJox3M6GBzEsjDqWUxJSbrlO8Lu1FPNG6yAquVXhkeB8t2RdzhYa1eZ2Xkk14Yi
         gu4GQ30Rx0Edf76fRKnZYFcB03FkhfRtiCdWSc+GKN/W7LDj10DA6PqozQ6UZvsv7o7F
         hxCoNkCWBDRQ58Tv6ve9iSyrQ2ORJHXiZbqvNk7ApWUfFAv2KdaKRoBTmd9KL+KxmLKA
         degB3wsknJY2pnMbbTSyG6xlQfv6x+AgfNL7FBuTz/ntTlMZvmqXeZGXCOgpL8HZaftR
         mT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795421548; x=1796026348;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2szI1ZqQtgYM2qe1Z1F3aOmh0lr8LS1pFbMyBrHQw58=;
        b=qDWsaZ0eurSjbGroOxbF+1b0zDLHUjFCoRkERcTDOwTbgvQa0McMRSPkornLuy+mtP
         uYZI+jAbzy3Ud5LMyuyBxvdwyDrIzDSmBBw4ubj5r9eHY9Xggf2nAyqYQy9WoLUzpB5i
         4gdkxkz5Ut1seriuyOmcgoWj4xis8DXm+ghaElkpLjdDtBcliTlqn/NXeiqZKqDE3LQU
         HISyjUI1pILraduqYxvYLRpOQyB139VENUtwjb9arDVMVZwqurEY9J6ymDooJFRWR2xK
         t/PaIq7khhDTI6ObgnCx1vCQzurjMQdiSYdXas1qS1eMv6ND+VnxL2INo//5wbylgtXV
         UdUw==
X-Forwarded-Encrypted: i=1; AL+hErHRMiSprP6vBvAKyI1afQZ4bvoT7wCKb6NtI02dFEk7D1Oj49R4mLflXVt9jh0zzm17H/Q8qFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TeeXCae9Vg64S3/H4B+EdtBz0mEUU2eZOcUwh6nkSgkPXy2es
	RSqPqiVz9j/SJvej5OrU+MVrII9mPfsfFNrYEzEVnPrbjzk8Nyzy90dAIB1EQWGO7BI=
X-Gm-Gg: AZFdTZd+wJrW4hqt7WgalfGQW1i9rjyQNFmMfQ+sOHOva5xD+EFTHijhOxGjENoKs/B
	Xhb7WVXn5uRf4s2h0l6nfJmOHbpv94mtr9WGVAkdgVAw0RHXHurH0tAOgiR+E5dRjfUN7X4tS94
	XKgo6OsuD+/2f10z1JNbE9tMjGsjtxLPKvFpMgvv8f/5pkKLEj/LPIPYxjBElbUARmxfGW5pnvo
	Ag8HhrPEGO0VkmTLUB6jteaHYylZG/M3IgPhOsSF6vmrjC48/JxWw5JYQBwYhCiqDltafEmxVHS
	1UZ9QdF/aLbGpgdwnnGUWebFI7FA0hBYwng0JhR7oBsv/2R6Y4g4ZekzZWX8OwBCNyQtokaMLWV
	UhMFHDZvjB7jKFiTG5UalQwFpZYbtC4oLs/fipPHr48K4XWkRw/05snvApZAjdpNdMnJNQn27EX
	yBiBy0t8V+Ew2yVXla/rPgj6Fq7uVSwz9yDBrKV1HTkL3WoISfGjCix6M99Q3ViiXkI6wuBfUf7
	e/sBzd7fZHMP6NOJM4dCnmw1Op17yDZofr/GgaawU9150uO7L0a4FQfSsObw3ri+Fn122UG3X9o
	mBxnjzvfpCPVZlAoisRIC2sn39GLTPW+CTZeIxIG+IPQQzDk7zhS+UsmOdGYFAjY2XAq3A1A5NB
	kCC2m4iA=
X-Received: by 2002:a05:620a:2956:b0:949:70ec:7e76 with SMTP id af79cd13be357-949ba80f78dmr1737529485a.1.1795421547930;
        Mon, 23 Nov 2026 00:12:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm752293485a.37.2026.11.23.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:12:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Barry Song <baohua@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
 <179537313704.412063.6683001223228002260.b4-reply@b4>
 <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
Date: Mon, 23 Nov 2026 03:12:26 -0500
Message-Id: <179542154647.412063.5153407036844671374.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-23 09:14 +0800, Barry Song wrote:
> On Mon, Nov 23, 2026 at 2:46 AM Gregory Price (Meta) <gourry@gourry.net> wrote:
> > Reproduced the hang determnistically.
> > Base deadlocked.
> > With patch 1: -ENOMEM (safe)
> 
> Hi Gregory,
> 
> Just curious how those -ENOMEM failures occur. With GFP_NOFS, we
> should still be able to reclaim anonymous folios (except in
> SWAP_OPS_F_REQUIRE_NOFS cases) and clean page cache folios, right?
> 

Ah this is a little dumb, but i set memory.max=0 to force charge
failures.  The -ENOMEM is basically expected in this scenario.

Not really something you have to address.

-- 
~Gregory

