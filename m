Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D47411F9E;
	Tue,  8 Sep 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864721; cv=none; b=mxFRIqoDuZkjnbchQGY5lDX53vWUGHnZ/PC5Zu8ZIvSH3are0JuvMX6jdp7faUd3LIPNpdzcqNM4aSZHk9tvkcLyTz4HtRE9Rse7/P/nhMwGiYIC5VTex5m9WvV+CGfIcviGZV9nFRF+e/AErKXgp0umHgoJDSTiILJz7Ht5Sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864721; c=relaxed/simple;
	bh=SAULTH2ZeF827fDTayUmOOBrRH1WDEVQ+2AQzhbbUm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCmcINJK6EzRHE0gxs9mjyfYHDTupk80zD/0KWNvzIHPfpnlyZSyOOFf0lWqJuh0gjm+mCaAxuWoRo4XyjI9jrqszdvDs6H3TAHsuxvELPlzzj7AVgh/r9UTVEDl12o9W3slIZOeUx/uovafa25dEp1JHh6eSwBAuZc6avMQCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZvHuM6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZvHuM6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731901F00A3A;
	Tue,  8 Sep 2026 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788864716;
	bh=ACWM/3ZqSIHqMix/gE2BwfaEjmdKW8xW4+BFxvCQUxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UZvHuM6YgEe2R0fI9BTor5fb2lg/Sddy9g26bLD86NM3vEo5T/4VXmhazzW3QD8fH
	 keLDfV9F8BR5Yyvnma+92qoKbfebbBwwFIy93MCckHki5g+9nlcMW7kOPAp2u+EN3n
	 rmmddEOMMu4Bn78JOyQRET0LQEEdD++pNcuqi5Xg=
Date: Tue, 8 Sep 2026 12:51:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: stable@vger.kernel.org, dmitry.torokhov@gmail.com, pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before
 updating state
Message-ID: <2026090833-mutt-whiny-242e@gregkh>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>

On Mon, Sep 07, 2026 at 08:50:01PM +0200, Miguel Garcia wrote:
> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
> 
> aiptek_irq() derives macro key indices directly from tablet reports and
> then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
> the derived value in aiptek->lastMacro and later use that state to
> release the previous key.
> 
> Validate the raw macro index once before it enters that state machine, so
> lastMacro only ever stores an in-range macro key. Keep direct bounds
> checks for report type 6, which reads the macro number from the packet
> body and uses it immediately.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn
> [dtor: fix macro fallback in report 5s to use -1]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> (cherry picked from commit 95dffe32a66cbed07fbfa7afed39d56d5014e04f)
> Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
> ---
>  drivers/input/tablet/aiptek.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

What about 6.12.y and 6.18.y?

thanks,

greg k-h
