Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479DB3F5BDC;
	Fri, 21 Aug 2026 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290230; cv=none; b=REitKV40OH561ts5qfuX9nyW6mjQkBUWhRJxBOAKEWkOtDC8cxGM/LD8rrqRIWuuinG/yE8fNgtM+76WhB6L+sXSham8zPPh6R1tuQckpmgY9ltqodaaT7dpvv4+6360+GpnEbzijEKuFJBoAbo6+nxDC3oiaRvR1TR39vtorlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290230; c=relaxed/simple;
	bh=R3pMWwgQDQHukjpib1XmBqymFThov9sXdfgXIzswDrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgTSf8EhfNbF9Qltmujo91ki9Pxg1tcwwQV1lKM6fl5X5T5hiRiieV27w9v8SE0nRM7jpoEj0Pkpq+fBe7qdt3RPYcjYQLNJdXkWZ2z671LXik6Ct+uEwNofMLJUeKUB2s9fkc7OpMK5FDJgJSMda/KofbOSnpbFZDebgkOhK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5j2Qb5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5j2Qb5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4551F000E9;
	Fri, 21 Aug 2026 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787290228;
	bh=mA6NsWor3Zn79eZUaLdZUoddv2CQsAoK7XSmaC8Otos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F5j2Qb5yg+a2iyeRb/4mFN8lqcvuuPe4aR3CNMhVSEQxlINXBdNLfBzabXw20neq7
	 +1pwpQLz8m4oTSGTtuBppfzjC1if+GP727NT0f4w10eIBMgHUfZvTl8YwCyAd3nKVI
	 wPl9CrkKn5YgXaaUGC7FCCw4iI9wKIR0WfbFjsGQ=
Date: Fri, 21 Aug 2026 07:28:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liuqi <liuqi@longcheer.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: prevent concurrent URB submission in
 usb_stor_msg_common
Message-ID: <2026082139-visa-scientist-8922@gregkh>
References: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
 <08b595fd-215e-400c-b090-df030f8f0ff8@mailsrv01.LongCheer.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b595fd-215e-400c-b090-df030f8f0ff8@mailsrv01.LongCheer.net>

On Fri, Aug 21, 2026 at 01:14:11PM +0800, liuqi wrote:
> From 2104fc57aacc74197aa81a72d283cad3351e59f9 Mon Sep 17 00:00:00 2001
> From: liuqi <liuqi@longcheer.com>
> Date: Fri, 21 Aug 2026 13:08:16 +0800
> Subject: [PATCH] usb-storage: serialize ene_get_card_type() with dev_mutex
> To: gregkh@linuxfoundation.org
> Cc: linux-usb@vger.kernel.org,
>     stable@vger.kernel.org

Something went wrong here :(

