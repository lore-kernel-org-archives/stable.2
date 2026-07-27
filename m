Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63041F5C8
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168837; cv=none; b=gBqoHChwa+Oi5p7aEzOW0YLfjkKuPNwEJmktBLXNwDgSFnIf3y9iXoXCLAnKmUaESytENDdTUFCpC09caOHwLjZCaoxxB8V/MUh5eoVbznJLMFHN+ZThdEoSORODBZOZJn4mS6u38SDXjzqLOGUnJkcQfDFD3rUvmDGGtU4Jdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168837; c=relaxed/simple;
	bh=M6CDqdYKhpv5poRbrKy+OyIHoOpHoVrZYtaje71XpQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWVGTUEQSQ+klJgiqElbfrex0qFRF74CzYbZnK622fCtKzSYqcujdGvkZuDR/l5axe/2ahKFdYFidiClwMiqzRqDvwyVRK88gFooCGWKxWTIYT5R6itf82DXQwAkLdv+6oPwmHR09rrUWyEEFf0iBlz5FLWn1NfjNgHCd9t3ESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AGu70SUe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AGu70SUe"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5d6f35c1so240659985a.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1785168831; x=1785773631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TTY+STYwMH0ZtrJAz3SmNmqE1zha3pWeJMVUMgWHQEw=;
        b=AGu70SUeQ0lJS0cR2s3M5abwIjEHjC5lOAFK2jhHedERfLqr3pF+GoyuexIg9AZnGD
         6Da7mKO1/nFUvJVyZO5dvKcPYQdmAJo4hJt3PveWjK/W/f1T8akgMa1b2FWBIBq7jv1n
         Xh7u/fajB00W/5W3VnSTSAzj+J0U4evuyI8ItVB1YuH1a4QWIUj/SNZ9fm3RUGfK0px9
         ilIYWcmBiptLkQ9vhOluZJCeGIDEnTcH7j20o9qUJBavxC3G6nO+7z3C+k7qKh5FypkJ
         Y54k0eBMwmmm8PyXmor8fM2rlzSyzK5pxe9K4faQNbh1q1mHpjL9ngv886D7ELuiYP3P
         mmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785168831; x=1785773631;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTY+STYwMH0ZtrJAz3SmNmqE1zha3pWeJMVUMgWHQEw=;
        b=Vhk6ur336zv5w/e/PNsgZRmBDMYnnynqIZzV16tqVc6ItG4JwzcD0f/6Z6IsW7Vbjs
         NMctWgn2sYlUksmLgiLKhjyIPnI1ikLAz6VJecRykFDdgDknFAR149M8FooBkg9azc+c
         OLVDhQ6wmiORAiav4BOrKp+w7ugiCxNDLI/A3c8NiaR2U7LgHD9AHnWdlzfbIlpNIXIw
         WBq2xCIwlOCWsCsWi9S18iNrMF6V6jvLr28h3zPLwtqIkz7RtATRsDauOn8RwZyOiYH6
         UhbvCRrcmbJJYTG/f75cypJF6FxGBaYRrGgy4WFc5n0qkeTgfaXG5X3qeElt0xB4Jy3f
         B2zw==
X-Forwarded-Encrypted: i=1; AHgh+RoLl6vFufAonc7hpn4KmWjzL/f1+odX243XQoynB4wuUuy0zhwI5ZZLiJyqo699NcGzelQRlWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgVUYNp3T/J73VwrSw1pMgCMKhJLQc+YLmEr9P2iGhOT59SFm
	0GwaFug5O0IvmzHIU2Gg3QzQpHTweerunJMQ0n4ePvwoiWoeI4wACildKbIviCYoXQ==
X-Gm-Gg: AR+sD12eB8J36eLfkr96BIyIN5Jnul379khcVlWKklDSIwPGpMto9HzOkBHl+KGaCDt
	u48T/mr0u2QB0ALcHsETJYns/oGx/fiqhw9E3QPdSlHpeyBNFLjx9jAp/OQLVBVqegVYfUmXJnH
	2yzBlUGBJiW+wK3sIJBspLCLW8hvNG87+M/MS9CG+t0R6xzrMep4kyCnRBg98BF2+IFSWchKhl0
	kQXkjk9EcQ28oHUK0c6pFQan6t5IwoQUZhaTj8B9oN21Hio4ZPYeU8mXDD4EmIOzAMquuNlWs1z
	bAUE0l7M5w/4l7gsTOmsXWxJX2g5gsHtOF/L20wdbF6FNGmKxz2AZxNzVmWaEqCagOqFxJBJ5jZ
	KeavI5BRrCU+op83f/eqUP4D7O6VKSY6j71qgOIyijLliwnsNuVapicdV7sennUDeHVAHgXKdLK
	PCkWbkSnpWUmtZUwd4Jlt4w7c800T0/0cDulHqGUSXcEl33EAQQi+TEfCP
X-Received: by 2002:a05:620a:710b:b0:92b:6805:91b5 with SMTP id af79cd13be357-932df6e982emr906710985a.61.1785168830608;
        Mon, 27 Jul 2026 09:13:50 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de51a7cbsm653190885a.8.2026.07.27.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:13:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:13:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <a0db0e6d-ba94-4577-ac11-6f2d26055427@rowland.harvard.edu>
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
 <20260717195336.98500-2-nikhilsolanke5@gmail.com>
 <20260726182946.79a4ef98.michal.pecio@gmail.com>
 <CAFgddh+1Bk=CFkKYNzB=L++UejkhCEcTHp4A2JL2v+P6uBuF2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddh+1Bk=CFkKYNzB=L++UejkhCEcTHp4A2JL2v+P6uBuF2w@mail.gmail.com>

On Mon, Jul 27, 2026 at 08:55:27PM +0530, Nikhil Solanke wrote:
> For the remaining comment and log message wording, I'd prefer to keep
> the current version for now unless there's a strong objection. The
> patch has already gone through several review rounds and I'd like to
> avoid extending the review cycle further over comment phrasing,
> especially since the implementation itself now seems to be in good
> shape.

I strongly agree with Michal; the comments are overly long and contain 
information that the reader doesn't need to know.  You don't have to use 
the exact wording in his suggestions, but something like it would be a 
big improvement.

Alan Stern
