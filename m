Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28684334DC
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662114; cv=none; b=DymO41qIclxOhrEvq9vwEEthFK9kwY0/nRLcJsnohf24LfdopDSZ8HISM98ZfsMLMCc7vaS70YZ83oGqV1nu9HUT66v5zBsRTEIxBrdz60p5qlZMAZp0hcWLzD9NEG5Tc69G/rWPNeLFLttf40DKI8KGXj2WCOvtyeQdo1yAhjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662114; c=relaxed/simple;
	bh=B/+CNehnMyEmWX/4Qp6Vf6pWvZBW38FTYYoJkAL5M9k=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=u4d1KLFz50jMm4nIXX30ihFxcdB6pEaxjWI3tZKsa3KipX5Qm1LW+Yj5EdjgZAkQPAfxzmusrVBU5wKGEzraZfLV5Mpp9N7lHzKxGV5QA/p2FBAPY3sEL8FaOra7CPm1Oy/sW2t+/J1LVA4ZYdP0/ZCPgZ43OI0bxd1ET/ZBAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHh6fK0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHh6fK0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85181F000E9;
	Tue, 25 Aug 2026 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662105;
	bh=poTCS2vEpJizv+3Lyszcc5cSyUbJPOa7aT8NSV8l5XY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bHh6fK0DZI2xUiMuqb87oNYU3TtFXp419Lo3kJzwkNyAvGAuDfYCVBBAbYWxXsYE1
	 v8y3m3qURIhGDH7UF47VMhPstXQsrYc/H6Th32DImJjdyi1RetfkGMb7jVmmANMPeM
	 rgJymmSY+o4luDS63iAhQ7fJ5Hhrc9puHznXPiQD8CRvwSwgZh4YbBFMA6nYalI04w
	 B/3/BRFCMGlG8wzLBELstQuixcO+aBw+GBYbwYoMAhRFhi9tj5uVljbH6KODPan6ME
	 Kb+ttbeGmXC3/qOVcDI87ZwR47NwxqiJi3UFTx8CevavOG7NYfzGkAAigR1L7dfFiV
	 r5oeiSHfBLawA==
Date: Tue, 25 Aug 2026 14:48:22 +0200
Message-ID: <20260825091624.748852250@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 peterz@infradead.org
In-Reply-To: <2026082446-lumpish-subdivide-9766@gregkh>
References: <2026082446-lumpish-subdivide-9766@gregkh>
Subject: [patch 7.1.y 0/6] futex: Stable backports for recent issues
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Greg!

The following series is the aggregate of the futex fixes which hit Linus
tree over the weekend:

d8aa5dd97944 ("futex: Fix might_sleep() warning in futex_pivot_pending()")
bde023808364 ("futex: Fix race on the initial mm->futex.phash.ref allocation")
c5f0bc9fd1ce ("futex/pi: Plug private futex exec() race")
f9ece060cc43 ("futex: Sanitize and document task_struct::futex::state transitions")
59b3732f95dd ("futex/pi: Reject cross-mm private futex owners")
8e7ff730dd96 ("futex: Fix race in futex_pivot_pending() during private hash resize")

Thanks,

	tglx


