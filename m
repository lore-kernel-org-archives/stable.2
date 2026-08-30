Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E551280037
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788081232; cv=none; b=lOJDu73QkVQ4kCmA/8D+esZ3d2nPAT7/qDP6xDEA8PTkxUxXwZjFLXwwnz9537wISjAs3J2uQp/Moo6rZfyA55THdBpLJYMNQ3V4Ombrb0AytokrLHMYHBE7rBrFjtLJ7IxIlP/xfn33SDaP+r/Ip9ns25wtmJlwgqdcHc2Len8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788081232; c=relaxed/simple;
	bh=YeEwfeyHKK6gIeEWh/rVLFOhOsvD3Jt7Q0LgN6+iTPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFanu+dcELjChy7dz4ZuizKwyNRbSgaheJU4wArHaA8GUdxKX5rz8QdNNI5sujCJKBnP2mJE+X9pkq6BQOx5Tybz7eqP/jLhIPGmGD6LSoRKtulcH+76n6rABoRIrWoOclPxf1FU0XIoFvrJ3iCasoYCZ58NaAOX3CDRXcIsbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlx6S+eO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlx6S+eO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2838583a91.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788081230; x=1788686030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4mZMnam9PuFjLpm1vuMO2JXE5Y2qa9SZWkY6IJ6iwGk=;
        b=Mlx6S+eO76CyiF4syZE6PzjFBqLUbW+MZG283x4kPIF0e3A1TaFKhijWBr5vye/atN
         ypYsiiuWhHSUBW7PDDTopIdYU8ccIkGdmtpvF/Lg8dPeCvuEvi2+Ycqox2lWgaK5pjMr
         Ezwpkv/9vAUdhoWGEd5Q3fJzm0y9aWijfUBFEvvhwypZlwvv09UQvSEyuFzt3mYssmp0
         /EjMKdn6bxVpIfiGsEFN0P9tZU4z6FVmGGR5ELXTy1OJsTYFvSBzWg7+opnoDdoOW5oC
         wZARTsl+SNJfco914ANaeDFYDLy+57nTtFtRjyWBm4Vubre/syIJ+Mtfe4oURiF60Bi0
         CgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788081230; x=1788686030;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mZMnam9PuFjLpm1vuMO2JXE5Y2qa9SZWkY6IJ6iwGk=;
        b=b4sf1uxRvo37i43IHR0G4amBwW/xv5ii+PWJEAkn9mZeh2EwA96idQJR+5xzBHFAjr
         Kv33J7D3//oM0ndM04kfki1JHez6MlDL0E0FLHPaglsc7VnvpNb68R7kCbQ8MUb3N0t9
         eBGkveov0Uhc13b9pAbzGsnS2OvITcy8RyQDUq2HE6ej6WSdQ2QTeKNa7IoSjxvZvIWN
         /bdZ0bbwYjqGFzwl/2nCs+ilU2ga1Bl9Jy/4qc7yT8mKnkKbzxaPmTRlNzkhl9p9yRgY
         phww+8dEi2fxYrqmjR+k+0rxfBLF3DpD6F5XcS3KMa+KIygkZABAzUleA2uMvdfEGCYS
         d5rQ==
X-Forwarded-Encrypted: i=1; AKwUvBytkeyufJ5c4tzzVvbah+ky1HPut+OBHKqfl6LsVoUCQz1fcOERUlzg18tVM5VOd0Zj10DrPTc=@vger.kernel.org
X-Gm-Message-State: AFuF++l3fU8lIjgDfXF5EAEUOeIHF5ujOMezRIoDggc66EfLFmh7OmqI
	RozG/xnLbtF2eJ88p9Lvnt2T0+QNFz94i79q219mDjWyZBeylmAupw1h
X-Gm-Gg: AYBFou0nf7akpvdbRa/nKIjDx5icceJMMk66Lg3sW0tqZ+FCtRKyTjxmz/oFDIO6G2G
	fC1OERFz6AaiElq1ZUq8TgGrehOJOBQmmyPj1KH7ixYusvQbggHbVIvKnF/gOHZG3IRvhdE8E7o
	J/Cugbltph2YE4Ubsfa0akVEb/BRLhf/F+bT50nmSPskZljaF1pIY7hFJPN+Sm/FKTU3f9yk/c0
	sfl1zJyqnRA9JqoapJcM0o73mv0ff0BKbssA1VSbps8yHilNJCmg3G4EHKDNSf+3wl0C0m/IkSX
	6OU1R2SOgHRFYMcx3jxUklkx7Bmmmr3RI0hXVlYcpErt3YzIMwnxmHvwcO7uOI2+hqNr+kAsQ4r
	kJQ+Gt8YF65E4jrt2jUJwAr1mUf3oQ6gW+ES8/G+LTOVds7L1pic6bd0Rsw1JX3B7uh99NeAIcL
	sn/y6qUK1Hp9WDJAM4mBwhVMGhRp9VApT6l8guxN1bHBduXMU5qYvdNe3PggA5z1piFZCXduIat
	GZ6YuDBkHno48rZ86e3cQ==
X-Received: by 2002:a17:90b:2642:b0:398:9be8:ea64 with SMTP id 98e67ed59e1d1-3989be8eaefmr17172526a91.17.1788081230369;
        Sun, 30 Aug 2026 02:13:50 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea80a2sm15459428a91.3.2026.08.30.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:13:49 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: baohua@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	axboe@kernel.dk,
	trond.myklebust@hammerspace.com,
	tz2294@columbia.edu,
	jaegeuk@kernel.org,
	chao@kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
Date: Sun, 30 Aug 2026 17:13:43 +0800
Message-ID: <20260830165401.1788080041-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAGsJ_4wpUBOXKd8aGNz76U+87bwDUXZZFSW2UhNcq4qpjVvggQ@mail.gmail.com>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com> <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com> <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org> <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com> <CAGsJ_4wpUBOXKd8aGNz76U+87bwDUXZZFSW2UhNcq4qpjVvggQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Yes.  The current path removes the folio from the page cache, so a later
mmap access can incur both another fault and I/O.  I should have stated
that explicitly.

For fault-around neighbors, folio_mapped() cannot distinguish the faulting
page from a speculative neighbor.  This patch takes the conservative policy
that an installed PTE represents a competing cache user and wins over the
writer's RWF_DONTCACHE hint.  It can therefore retain a speculative neighbor
which is never accessed.  Distinguishing those cases seems to require
fault-around to preserve the faulting folio while not mapping, or later
dropping, dropbehind neighbors.  I think that should be considered as a
separate follow-up.

For folio_launder(), filemap_end_dropbehind() holds the folio lock and returns
if the folio is dirty or under writeback before calling
folio_unmap_invalidate().  folio_launder() also immediately returns for a
clean folio.  I do not see how nfs_launder_folio() is reached from this
completion path unless the locked, unmapped folio can become dirty between
those checks.  Is there a path I am missing?
