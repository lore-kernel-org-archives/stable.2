Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882648821A;
	Fri,  9 Oct 2026 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547031; cv=none; b=Ly9b07LNy/ZmFFCsqmUuTOWYn2WvOrjooDlOh21hn5OsHSM2IV0UaRbZbURu1vPOruBlSOGmZ3MdREZy+muuVPmjgFwYVoCmEvZ2GXpCaxEiPr4PsmuGF5qRW70sTEiHFwANSI1rVV9qcQNzGKkKaumfX05Hk5iCyxpjvaDe1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547031; c=relaxed/simple;
	bh=48jLovzU9sDOmARCH/bhpsr7OGGaWHZHCuYj5YOTiJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjM3LiAJQfrIlvI/dV0BHLix3VBsLn1poiIo50Fo/rpeyzLixiqgRcJvlwNMWwyM30LorfWmivsUTFTp+0iSN2ZU8M3hR6W6YdLDlcY+eaa9AXC6V7rh70/NARDtygzcceZqO7quBG3o6DelO1o0jAHHGCq93fRC6/LntK6D6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH3fiBTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH3fiBTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399A51F000FF;
	Fri,  9 Oct 2026 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547025;
	bh=48jLovzU9sDOmARCH/bhpsr7OGGaWHZHCuYj5YOTiJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QH3fiBToKGh2utYkFO6TLH5i8kObVvKBj6ZhRijieTlGZO3XsIs9Q1/n+IKqEZK4N
	 qKne7nLlSx+/5pAdPjCx7AREXyMAv8vTNFWaCzBWaLMzwfiKlXjAHUUjT6OsQAUkmn
	 v7VAdfGlLG0x0NsRrER1auFt31TZ2H9/YSJXFuXbyZMXTEnjD4spdwIMRDGSCVwCsS
	 jAnZziYtSxMGNME0FJRT1rRPgLdSGb/XnoKvQCW7xr0T7WD8UQ7Q+0GDXW9JjlZ+3R
	 p9ZQu7BJf0EtHwkhIIqzddqA+DSU15q0Oyftd6reKmDjj8vX3W5bEpMRkNdY1hGLH+
	 ooL/QkyMoUpbg==
Date: Fri, 9 Oct 2026 12:56:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	david@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com, ameer.hamza@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asjWUyFVbq4fhfLu@gremlin>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <2026-10-04-1-daily-reply-0001-secretmem-requeue@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-04-1-daily-reply-0001-secretmem-requeue@kernel.org>

On Sun, Oct 04, 2026 at 12:29:39PM -0400, Sasha Levin wrote:
> > Since commit 97d34aa65c29 ("mm/secretmem: properly account locked
> > pages"), in v7.3-rc2 and the 6.18.52 and 7.2.5 backports, touching a
> > memfd_secret() page for the first time fails with SIGBUS while the
> > same user is running perf record, and read() into such a page fails
> > with EFAULT.
>
> Re-queued the secretmem accounting fix for 6.12, 6.6 and 6.1, per Lorenzo.
> The perf fix will be needed on these trees once it lands.

Thanks!

Perf fix sent at [0], LPC will be slowing everybody down though I expect!

--
Cheers, Lorenzo

[0]:https://lore.kernel.org/all/20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org/
