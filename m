Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B613426D37
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604138; cv=none; b=Bjz4GwoV+EZMZr46U5HxwmACpu+tAp6ig1ckuTVTvXreFeON/eohoPMRlynP6oxSU/N5S/anOuUJkWiiyGAZI1XfYmphGexPk0IMJQggytUgeBC5SsXl0M7r4OlVhX9NWHnMQM/hSzKwACmpH6/54DHpbH78uFiorCvsmu9WdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604138; c=relaxed/simple;
	bh=JXjc9l0WQXaZ7ljFf5iYEucoFzQI59YNmW9VuI6hfxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlOlCUcq1Zgbr9S06z3DXuxOoazptxkBi6B/NR6QFkgdHiR+fXmZ+uem8Dn09Pijinduzer5RGiugze0bIII13zqSecZ9SmLUqxwi7T8DSRhs6rnV/QABxVe5Baqs+qnxgjZgyXndrg/ACSFoEBukFCwP47180gTtndtapKBu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uk8pB0yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uk8pB0yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6831F000E9;
	Tue, 16 Jun 2026 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781604136;
	bh=pOrSmj/uamnl/nRo762VYdWiJDBwcJhEPZspWLlHVqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uk8pB0yCy/kv68MMpbcGYilQaPbI9JlqxofETeNoF/EaeFBEeb6IUwD5LHqFTp+vV
	 jlHK3iAWToY4AX1n2W9lzwuzg90RqcZAj2icIi/v2WccncrZ9BEt6118JqWqv+9djp
	 X+R0V3enukjwDPi2a6kQY4CDigyglVRk0ndoCNeo=
Date: Tue, 16 Jun 2026 15:31:10 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, lee@kernel.org,
	sdonthineni@nvidia.com, will@kernel.org
Subject: Re: [PATCH 6.18.y 0/5] arm64: errata: Mitigate TLBI errata on
 various Arm CPUs
Message-ID: <2026061655-veggie-rerun-83e6@gregkh>
References: <20260616051329.111597-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616051329.111597-1-mark.rutland@arm.com>

On Tue, Jun 16, 2026 at 06:13:24AM +0100, Mark Rutland wrote:
> This is a v6.18-only backport of a workaround for a TLB invalidation
> issue affecting several CPUs. The final patches landed in mainline
> yesterday:
> 
>   https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16
> 
> This issue has been assigned CVE ID CVE-2025-10263, and Arm have
> published a security bulletin:
> 
>   https://developer.arm.com/documentation/112137/latest/
> 
> I've pushed a copy of this backport to my kernel.org repo:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.18/arm-4118414/backport

Should I cherry-pick these to 7.1.y and 7.0.y as well?

thanks,

greg k-h
