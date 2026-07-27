Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20A3F823E;
	Mon, 27 Jul 2026 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155658; cv=none; b=nbM9wc47erQfYFdnN7mmVcaU93PLQ6E04pi1mEDWxovz8Ed11rDhtDLFJO8SiYzXPSYduCeiO37KPAnU4uATnckEs7RpmXchfvRs5YNw1704KD2AWrg/a9q4jMUwopLL75ZZwR1dMKER/EQh/F8uyEhK07CzhYj7Bt0oOqcD7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155658; c=relaxed/simple;
	bh=4NKP5XOkpu4oTqud1t4vQGtZRZHlVZt3idNsSSDyLPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ263Mcf8iK+MU/q9sMKfk9iVAP0BN7z7/1gc3JkfZQCq5bU94k+4Whs8ww6/D6FLx7f7dUW26QbahwVCJCNGdFjzZkP6UBoUj5mtfZ7PFkYIN/lbiOSbGM5IMFIYQlyOy9kBNhgjaMDvmc4i6rUnRNPYl3/BEQDu0qxkh0ArlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lilrqU46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lilrqU46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828DC1F000E9;
	Mon, 27 Jul 2026 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785155656;
	bh=8driKVCnf8Kbn7RW89LGQxINbySI0/fMRE1fgoul8Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lilrqU46OYgcQV3ZKKs8z9siC1SwiwjTbzgfw7lud/ZgpAMkNIsJ6qRzcThBLL6P/
	 cOPfpp9TI0KyUqIQr5DCBEgwd+VWYmLxSiAMMM3L9hkrjLsdhhM1PlYKUuOu4LhncP
	 mlOgK6M39Hpn4FRvmVEN161wT1mgY7pzl8XBPVBscOMIT+EDLcDoOALxnaA4ca3K+W
	 n3DhiogNNqqrHWF5M01/VN65kfdLcE573Io1Y9job4myx2jQv0qZ7ie1+U2PM+sWUN
	 vlrIpwHyxCoKMiSiOFBluuUVD/6DSh0OGDNOSu4SUVGNromcVOjkzAEpJhfLYdvzG5
	 LmKgwJ/Z8blkw==
Date: Mon, 27 Jul 2026 08:34:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Alex L." <lkstl7@proton.me>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Backport patch that wasn't dropped, but not applied in the
 actual stable release
Message-ID: <amdQR3Hod2aX22On@laps>
References: <Dwu6EPhoqrm1RQ9cqVTWmxbiSKyzKQLg9BXcfdVDrUiF2_MAdSlmA6gU9EOdv0PaX6vysSJUVsVSOMu6aNnppuA3sfg7Z8M3rYdaf75KkO0=@proton.me>
 <6dc6ac56-3126-4266-9e43-ec67a3203b34@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6dc6ac56-3126-4266-9e43-ec67a3203b34@leemhuis.info>

On Mon, Jul 27, 2026 at 10:14:26AM +0200, Thorsten Leemhuis wrote:
>On 7/21/26 20:51, Alex L. wrote:
>> Hello, I'm writing with regards to drm-amd-display-fix-ism-dc_lock-
>> deadlock-during-susp.patch that can be found in the stable-queue
>> repo, under releases/7.1.3/ on the master branch. (https://
>> git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/
>> releases/7.1.3/drm-amd-display-fix-ism-dc_lock-deadlock-during-
>> susp.patch)
>>
>> Despite being under the releases directory to this date, this patch
>> wasn't actually applied in the 7.1.3 release upon inspection of the
>> stable tree. It also wasn't included in the release announcement for
>> 7.1.3 nor the diffstat within. It wasn't even included in the RC's
>> for 7.1.3. I have searched the stable mailing list and the stable-
>> queue repo's commit histories to establish whether the patch was
>> dropped later for some reason - to my knowledge, this doesn't appear
>> to be the case.
>>
>> On further investigation I found that the commit that first
>> introduced this patch to stable-queue's queue-7.1/ added the patch
>> file to the directory, but did not add it to the queue-7.1/series
>> file. (https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-
>> queue.git/commit/?id=76522806dbfb58941f6fa4b6116b891b66689613)
>>
>> Could this be an accidental omission of the patch due to it not
>> being on the series file, or was there some other reason that the
>> patch was not included? As a user who's affected by the regression
>> that the patch addresses, I would very much appreciate it being
>> included in future 7.1.y releases.
>Greg, Sasha, from a quick look this analysis seems correct. Did some
>script do something odd? Or did Alex and I miss something:
>
>Reminder, it was Sasha that queued the patch for 7.1:
>https://lore.kernel.org/all/stable-reply-item001-amd-ism-71-20260628203053@kernel.org/
>
>Sashiko shortly afterwards (see thread) complained about two things, but
>those were pre-existing issues (without any fixes in mainline, at least
>I did not spon any references for it).

You're right - thanks for the report. I'll queue it up again.

-- 
Thanks,
Sasha
