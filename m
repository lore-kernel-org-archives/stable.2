Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFD3B8959
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389305; cv=none; b=B0gWZC974fXORhL/zYtm4ZZXWk8eRLXVsino6CDMPQLAoeoJR7FfQWidE8ytriyLulPefFnnMJrSXprKhfoJSYElHWUQedJK0DdSugB2odp5zMyNU9X09SEYBQ9KLj4QbEan3Ylmi6McwEwq11cFplO99W+RDWOpzZkPKEwfqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389305; c=relaxed/simple;
	bh=JvgG8elpY5kC1tmOmtJ925WyWExqIFQwb9CQv7YaSuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCiXgJn6IvovvSjX3ImjeQrtQX7uOYzyFcSLCCkZBBOFKXnStqX5Eb4AniH4Vp2Dm29NOm2vQauhLT/ZQBsoOB855LhJw/+HdAQFvnNdCTq0TSx/cfeu2ipaChNZRc2GReBGuEV4SmGdtAaZgKpHY3wxQnKdSaRGFJdf6Skw23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzull5NK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzull5NK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC64D1F00893;
	Tue,  2 Jun 2026 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780389304;
	bh=JvgG8elpY5kC1tmOmtJ925WyWExqIFQwb9CQv7YaSuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzull5NKHCZc1Ix0SxveUYuTmAftN8ECgK2P/Z/p0MKEDSo3K3pB8xG+UgbJ6Zuoi
	 rNkNA2mntqBnfT2Ll4s/zGLOAF4laT1Fh8l1NTSSV5YfrjbQyL+jC2FozoWaGejJ91
	 MFDNdqrmeqOvR43sg8WG8EIz4YJHqCctZa8Tfu6Tm8OkCL1fYzzASMQwdxyQucl0Vb
	 0YS0u/aaPAoShYMlcNwJmAnLifJ8qj1bu90+fe4GcukHfWbGVUrKTlg6282lYCSPp3
	 FBDVNtv/dIZ5isc+SabhBGhL0m65O9oksPbluRn7DwQgpbYNdDX9IeFzTGKkYy+K4S
	 qxxW1b7UMB4fw==
Date: Tue, 2 Jun 2026 09:34:58 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth arbitrary kernel-memory read in Discovery
 Get-Log-Page (buffer + offset, unchecked attacker u64 lpo)
Message-ID: <ah6Vsn9eIBlgH_gB@kbusch-mbp>
References: <6a1e4ce3.77e39773.179d8b.1a31@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6a1e4ce3.77e39773.179d8b.1a31@mx.google.com>

On Mon, Jun 01, 2026 at 08:24:19PM -0700, Jeremy Erazo wrote:
> I'm reporting a pre-authentication arbitrary kernel-memory read in
> `nvmet_execute_disc_get_log_page` (`drivers/nvme/target/discovery.c`).
> A single network packet to a Discovery subsystem - which by design
> accepts any hostnqn - lets a remote, unauthenticated attacker copy up
> to `data_len` bytes from ANY kernel virtual address back to themselves
> over NVMe-TCP or NVMe-RDMA.

Duplicate report:

https://lore.kernel.org/linux-nvme/39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me/
