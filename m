Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403941;
	b=fvwC37l1IIKCfvl0h+bxbYUak+3VYxTCGWFhhFISAOpmJQG6so3AJfeLD7EPW779Of68
	 KR5tNw0EoKme0mn62Be3z9bMrxPvFM/DmMDZzgwoUNwDZEOOE07DSXebjGqeVId0S3lA7
	 kbPJqZJgLUreCWIZFt8EZ8BCFRtlRjZ2MkSoRcPCbiig8nibte0F84a7h6eABJRM/UPqS
	 3pL6mh3Sn7S+yN40FVZ34DnODgYIPYfPvmjFUrj5e82al6u94BJsPt1SYKWN4yFLh1L/o
	 PiJGTkpvgb4MIqHkkKnBs3qVaKzL1HRsntdFInAds0U7g8ARqXspBNLrJrJIYoW9x2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NVTyTjSD88ZslZBZa+qkaw0eEzwB/Yf3D99qESsb/J8=;
	b=VFsU6SzHuE25l9HFAhyAJbun5cHlDLYfPl/lU++dEwYmaYJe64xWWgJ2+qgUi7id8P2E
	 3AYG63D5FRQzdYy7AJTeMJHLRIQJZoX8Qwz/1hp/Zc8eEMIG2uE3wDDK/yXFiDahcdii/
	 f7jiJq/3iEr89V/F3pc7rb+FFX/PgIPZ7ptEO8CaV+Wl+X9AtGZQnhNIeRzHrXmAKAYQm
	 +1sZ/Jzkl8kDOh6izoPA+hSNe0+x89HrLrWv0NPqSW0Z9ZbORPAgI2X/zH5kUKg1bKlCN
	 7HkdErgGiRJ6WWdAkePsbPUBI4TKuwEJBPWUFgSRpTo+4PzAYqLUyUE8dbOAIbear5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UlO7TVsp;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDAD606A33E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BDAD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UlO7TVsp
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so32578825e9.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794403939; x=1795008739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVTyTjSD88ZslZBZa+qkaw0eEzwB/Yf3D99qESsb/J8=;
        b=UlO7TVspUXSlocLLHY+xdNnTQFFzFI+0cINbb6Sg1Tn4yPiBCKR40++aZ4ooCKnCLV
         EfMcGds/wjr+WCLnHyUwfHvHSDhIHcRS+mQKDfTZkRlna5eTjk59Rr6CO81D+V2Aah/V
         WHODxTeVpICKMxLa5TqKOWGPiz7tHe8XdUGS0of9wMQXVB9c0XcwLVRHoDZDQ+v0/gFO
         hfAGITQFUVIZR7cJuVCwqF3mkrwZHBrVUtrgnp6RwsJ/6vG99PKxoysj4QELbPxe0+Mk
         iOByEbttPqohzAgTeNlgYnElPNG48arMMDUg8SafT7UYbFNfjdVgbRBwOtYOJA4r1irH
         WF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403939; x=1795008739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVTyTjSD88ZslZBZa+qkaw0eEzwB/Yf3D99qESsb/J8=;
        b=uYU8YN+c0A+WgegunPDzQhDh7lIuJjk0x5Fv1v2Ewcfi6OcvJ5BMPagqdPybSS58sF
         SIq4snmZKXKYYIhUkn1Pt0j0SqGbvNcaT61HSFlmmLJ6q8ggYEy7llJ+2xi8WQEkWqEu
         kX4ZJ1VdSRxJrg8O3+BxdcSVPsBDc7UOtSj+W6bTASIvRWPrZjKtUUlPmnkWX5YzAoeY
         ofbytBVSYpa16LPs/3sQzzxB4YVi2XLmhfhZvnnQwxPAOW9qDLGoNVtRZ0nsVMb5nvqj
         JJN1Lwjn3a+Xfy+aDcbthI7WDpL4RbpeEPj9l9ueA/sYdBwilaGD0FgEQlqZHsGBzMSM
         FeSA==
X-Forwarded-Encrypted: i=1; AL+hErHmmcFyj3Cdu40jxwOZsx2Qyij4B5irXKbZxahUY5zQXhLBhDX1JbW5O7U7M7NfcKxpK2NCD5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mp2JwEwhvq4YTW3J3eQCAEd1jWOiRAK6ajcF0ULeR4v4J6VUA
	Ja5X2T8G7qYEw2HPOiy4qOq5zF0dn+LVsFzmh3PRYNh5mJHpsILBM2GjWLWG03Os1w==
X-Gm-Gg: AYBFou3CQ/S1PFGfdTD7tO0m9ArKWeei5Rt9oSrQJKoi98VHVaBmPccmTOm1Mg/i5XW
	HVr1DuKjQj88vRwkfUrtUmPh54ogGSTMpQZf/71Fbjg/L3YA40uVpQ9PCkIWgc6VnWn976JGgl9
	fbqZhfBhZ6CPNtYFjJ9sj1bWhbY3G8QmAOGkcwT7RvMdllXBkNhiJAVVTdLVP9dYNLTWiERIPTr
	gJ3xlcZ1U+EDpg09ewlKZdGtAV8CSKPRbUxU1hPjbDnvGSGFumtb0eJZ8y2+6i5dCOHelFatua/
	Nlkdf8r6y2sKeCGk2TEOmxxEcrYxrqqoXEuunOBsQLbhDciTBDHeW1T5DdMm4dyKfIW1RzHJR+d
	eglBFvITxXlbefib4gyHn6ZN9dU18PyqrdwhJfllgXZ58Gln3tZoRs+Fz7yKt++RwSOn7xZfuuq
	vD68PCqxNe1UgiJrP3eemjwUGJvP2SnQjycZB/KUdUGsLLIw06Zm/1wKVjb3smKERJi9foTw2HG
	0giYRaTLQmsCwNmieXdWsMv8uX60V/A1OZpfRgkYJSvxKpFGrp1lhnK1rVnejTHrxVTOfRqSgle
	C7kEtMRILvJNMrTMQtIm1O8a28KR2IfMKPvcv7pMQyyWL2Y/IKQecf01jyK1Q1ombw==
X-Received: by 2002:a05:600c:6214:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4ba09375bb4mr41985575e9.20.1794403938536;
        Wed, 11 Nov 2026 05:32:18 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm64107395e9.3.2026.11.11.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:32:17 -0800 (PST)
Date: Wed, 11 Nov 2026 13:32:13 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <avRuXVxVrp-Kjiqj@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
 <20261105155729.0f9c7e4d@gandalf.local.home>
 <avGQnBjyUMwunknT@google.com>
 <20261110025202.78c8c03a@fedora>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110025202.78c8c03a@fedora>

On Tue, Nov 10, 2026 at 02:52:02AM -0500, Steven Rostedt wrote:
> On Mon, 9 Nov 2026 09:21:32 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > The issue I think you hit was that we have two HEAD pages, when interrupts
> > > come in. That is, we can get a state of:
> > >   
> > >   --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->  
> > 
> > How we can end-up in this situation? The cmpxch will only swap HEAD for UPDATE. 
> 
> The cpu_buffer->head_page is only updated by the reader, when it did its last read.
> 
> Let's look at it one at a time:
> 
>                               cpu_buffer->head_page
>                      tail               |
>                       v                 v
>   +--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
> Then the writer moves the HEAD page around the buffer while there are
> no reads happening
> 
> 
>                               cpu_buffer->head_page
>                                 tail |
>                                   v  v
>   +--> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
>                               cpu_buffer->head_page
>                                     |          tail
>                                     v            v
>   +--> subbuf ----> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
>                               cpu_buffer->head_page
>                                         |                      tail
>                                         v                        v
>   +-HEAD-> subbuf ----> subbuf ----> subbuf ----> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
>                               cpu_buffer->head_page
>         tail                             |
>           v                              v
>   +--> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
> Now, I'll break up the update part:
> 
>                               cpu_buffer->head_page
>         tail                             |
>           v                              v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf ----> subbuf ----> subbuf --+
>   |                                                                       |
>   +-----------------------------------------------------------------------+
> 
>                                  cpu_buffer->head_page
>         tail                                |
>           v                                 v
>   +--> subbuf --UPDATE--> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> An interrupt comes in and moves the head even more.
> 
>                                  cpu_buffer->head_page
>         tail                              |
>           v                               v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> Now  the reader decides to read again and starts between the UPDATE and the HEAD
> 
> 
>                                                  cpu_buffer->head_page
>         tail                                              |
>           v                                               v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> It finds a page with the HEAD pointer set but not the UPDATE pointer and does a swap!
> 
> 
>                                                         reader_page -----+
>                                                                          |
>                                                  cpu_buffer->head_page   |
>         tail                                                         |   |
>           v                                                          v   v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> Now the commit finishes and moves forward and will even hit a blank
> page but the last write is now on the reader page. This breaks the
> entire integrity of the ring buffer.
> 
> Does this make sense?
> 
> -- Steve

Yes, now I spent more time on it, I believe it makes sense. I looked at what we
could do and I'm trying to use a temporary RB_PAGE_HEAD | RB_PAGE_UPDATE. This
link flag is then only converted to RB_PAGE_HEAD by the outer writer. I believe
this would fix the race entirely... However that means the reader spins as long
as the buffer writing is interrupted, which I admit is far from ideal.

-- 
Vincent
