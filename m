Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA63DA7F2
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140080; cv=none; b=XkiXWvED0KFQYes9n8UgNUYAJ/rhdTejZ9Z5v/rqTZBRYeBIUDmcTj/uFwXNK8NSfT9YVfOYIjBtCgUEyxUmlSMSviytDG6wm6Il5/uRcvoM3cboIKf+kj8rKZw4Sb8N1JqwC/NkJJsLGaB19ObhthaXQlNwLlqH+TBia91cLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140080; c=relaxed/simple;
	bh=pWMDmLyLKpVCD6cQdAcb0ozDPKiIrpriRsiPCEF7RPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfAdi9CXK9ypY82Afp/++k1cRZ6zJJ+fXG+iN9++vwTV+cAHDS+CcwxRK31qd6kWOFSGY3TgNB2CW4wCT7XDVJvkKaKjnr7SfGVgWGyzaM6kuDcugTsiSU9xVv+nOwMYUxjmrsRXqWsa5Fwe1UVa9vvvctcG8UEeS6JwGMzrT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VVHnMaEJ; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VVHnMaEJ"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4h7rwh2MKnz87wG;
	Mon, 27 Jul 2026 10:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1785140068;
	bh=pWMDmLyLKpVCD6cQdAcb0ozDPKiIrpriRsiPCEF7RPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VVHnMaEJxQm+ChlUNsWn7X0gclc1iXOHASdKzDTY45sHVudu1xuNiSRf0r6y+LqA9
	 MCyH8UnzeH6a5GtlqADYVBmKkOvBjNihU8x0L1qpdUEOFR8aS+m5PcZra4Xh9/EyYI
	 SZer5UraItiSeFCXu0dGUpMrkULlJErUcZzfwmsEEm5K+h2TA8ZuP0s6qG4hASjdYG
	 xKhSCn/v7dbmk1AwtyrNwf11RsQZgWmk5Sw5X3P9YAnE7mpXoK/qLuG54yQLn1VwVi
	 Tp+8+ChE52ufVYZOR/wpYEZZX4taMMl1b+3wrtNEKuW/mXgACWVjwkrK0nb2bJ/htL
	 /TWjsnAebpt/g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4h7rwh1g8hz4xK5;
	Mon, 27 Jul 2026 10:14:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4h7rwg39Bfz8tZd;
	Mon, 27 Jul 2026 10:14:27 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D35785FBA6;
	Mon, 27 Jul 2026 10:14:26 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6dc6ac56-3126-4266-9e43-ec67a3203b34@leemhuis.info>
Date: Mon, 27 Jul 2026 10:14:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport patch that wasn't dropped, but not applied in the actual
 stable release
To: "sashal@kernel.org" <sashal@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "Alex L." <lkstl7@proton.me>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: 
 <Dwu6EPhoqrm1RQ9cqVTWmxbiSKyzKQLg9BXcfdVDrUiF2_MAdSlmA6gU9EOdv0PaX6vysSJUVsVSOMu6aNnppuA3sfg7Z8M3rYdaf75KkO0=@proton.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <Dwu6EPhoqrm1RQ9cqVTWmxbiSKyzKQLg9BXcfdVDrUiF2_MAdSlmA6gU9EOdv0PaX6vysSJUVsVSOMu6aNnppuA3sfg7Z8M3rYdaf75KkO0=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178514006713.943031.17031930286996130963@mxe9fb.netcup.net>
X-NC-CID: NI14b1O3ZmDCnnGQyzmPUHHSx/V6pANNF5TKFeQPqpFYWXQ4iUk=

On 7/21/26 20:51, Alex L. wrote:
> Hello, I'm writing with regards to drm-amd-display-fix-ism-dc_lock-
> deadlock-during-susp.patch that can be found in the stable-queue
> repo, under releases/7.1.3/ on the master branch. (https://
> git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/
> releases/7.1.3/drm-amd-display-fix-ism-dc_lock-deadlock-during-
> susp.patch)
> 
> Despite being under the releases directory to this date, this patch
> wasn't actually applied in the 7.1.3 release upon inspection of the
> stable tree. It also wasn't included in the release announcement for
> 7.1.3 nor the diffstat within. It wasn't even included in the RC's
> for 7.1.3. I have searched the stable mailing list and the stable-
> queue repo's commit histories to establish whether the patch was
> dropped later for some reason - to my knowledge, this doesn't appear
> to be the case.
> 
> On further investigation I found that the commit that first
> introduced this patch to stable-queue's queue-7.1/ added the patch
> file to the directory, but did not add it to the queue-7.1/series
> file. (https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-
> queue.git/commit/?id=76522806dbfb58941f6fa4b6116b891b66689613)
> 
> Could this be an accidental omission of the patch due to it not
> being on the series file, or was there some other reason that the
> patch was not included? As a user who's affected by the regression
> that the patch addresses, I would very much appreciate it being
> included in future 7.1.y releases.
Greg, Sasha, from a quick look this analysis seems correct. Did some
script do something odd? Or did Alex and I miss something:

Reminder, it was Sasha that queued the patch for 7.1:
https://lore.kernel.org/all/stable-reply-item001-amd-ism-71-20260628203053@kernel.org/

Sashiko shortly afterwards (see thread) complained about two things, but
those were pre-existing issues (without any fixes in mainline, at least
I did not spon any references for it).

Ciao, Thorsten
