Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C371E2614;
	Tue, 25 Aug 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642983; cv=none; b=M/7ZcfoZYJRSJ6B9FOWJ5DgsEziGVcT4FLWeaMhBZuSFyAnYtSFsLTgCmnB1mcn7fL79WEM0TCRwCv9wbrlY6wY8qEX05UEq+mFaLOcsrUlbV3HQBStC1MWYHX6QqrtjP7lMo21g1NvMAkbhU1mWXymGc+hbtpjn07O1tg4hiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642983; c=relaxed/simple;
	bh=r1SW5hsw8cC+Rw5tTcsDyAfvXUpuSkKCnrump62ZlDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAtpbRntOx3f+Tk/nRiYA8GUq1EsukxxCMOpQ/+GTY5hX+rgeKPGlgAa43j5ppoli6Fk0SljKKACazI0CfoTUJ1FSnvwzTLGiY9N5UlArG8OUBW2uzAbYoVcf6wIQLjW7RQZZUuHpibyEE/hDlrJ4/w9wKcBufq13LXNrg/Mwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugwqiJCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugwqiJCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9A1F000E9;
	Tue, 25 Aug 2026 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787642981;
	bh=NfZZnMBWOikoEClIce+/vqhwaYr1dCzaNJMYSJ5kJJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ugwqiJCQRicKUA6DDZagf8aYtRGN1A/4PKXgcaWHuemtIp7gT6A+yCSnMRcZtDIjc
	 jKYZ59WgXULIurL6w6feMmhSvX2WxwBaM5AWlsb9vgdzHzzZ9JZ0q+Qi4ZMP2N0ve0
	 ZIluykmIY8Tf7gHr4HSsQEeyRzfyRHCxxPrRKnyM=
Date: Tue, 25 Aug 2026 09:29:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] staging: rtl8723bs: fix multiple OOB reads in IE
 and frame parsing
Message-ID: <2026082555-balancing-facility-6e54@gregkh>
References: <20260728125456.32359-1-meatuni001@gmail.com>
 <CADqcGB=j8cSE-CW8dLC8My0rk70RC-Qidmvr-dZvzCUFE5wadA@mail.gmail.com>
 <2026082538-divided-raving-3346@gregkh>
 <CADqcGBko4B8hEXkgG6LCb9HXoW5HdcTNBAuWh6CQN2cURgkT-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqcGBko4B8hEXkgG6LCb9HXoW5HdcTNBAuWh6CQN2cURgkT-A@mail.gmail.com>

Please do not top-post.

On Tue, Aug 25, 2026 at 12:22:54PM +0500, Muhammad Bilal wrote:
> Apologies for the context-less ping, that was on me.
> 
> For reference, this is the v2 series (sent Jul 28) fixing three OOB read /
> stack overflow bugs in rtl8723bs where length or offset fields from
> untrusted wireless frames are used without validating that enough bytes
> remain in the buffer:
> 
> 1/3 fix OOB read / stack overflow in rtw_get_wps_attr()
> 2/3 fix OOB read in rtw_action_frame_parse()
> 3/3 fix OOB read in rtw_restruct_wmm_ie()
> 
> It's been about four weeks with no review comments. Just checking whether
> the series is still on your radar, or if there's anything you'd like
> changed before it can be applied.

It's in my queue to review, it's the middle of the merge window right
now and nothing can be done until after -rc1 happens.

Also, have you tested this on real hardware?

thanks,

greg k-h
