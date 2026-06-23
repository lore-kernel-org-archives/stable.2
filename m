Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6193264CB
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220666; cv=none; b=B2JMvlIIy80j4P8qxD132M4bA16Djs7N21n7NwEwWxv6yNk+ZYJaNDBkmeN/31yV6ribYCrY4K4MLZmN9oSbu2uGncrSztgu//9i3cY5+wkmn4bHrufmf/CabqzTQyOBo3lvQwkOw/SvIpZEqXOW0O7IBBl6gICyh/wp+LaMIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220666; c=relaxed/simple;
	bh=IE5sT5CFflgNjiePovqg41+2aM8eY/bFlNMgCLrxHXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbdxy5LVlE+7DKh80UW6IO5uVr/Yi7ZyG+0A1sc9sH07a2uPSxaXT1dlH7WM4I7ZiceFZuXJ+QRopPfkOXg079CY6INDGFVD5KD72KMzWKxNKj3KSBgTwp/VmVyhrrG/PI61aWS07VUpMY1Me/r5vLQMqla4rm9vdhML1WAGLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=kMhYFPej; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="kMhYFPej"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44747d96185so1151558fac.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782220662; x=1782825462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgwmBiHtChacwN0HIN+HC9h/6/vpUYCVSBJ/q583oqU=;
        b=kMhYFPejsw2Jf+dbTJ66/q/PjT2X722H/6gg3FOonZ8Lo5IuNoAwYkNuTTJR+zs59b
         481eSGBc03QVpJRGRSg+qdzz87HzIzcLPEghXnK4cKsKXrT3ZsAJpFL/Z9iie2GxX7wa
         ++jEIRVqQsyd/aUgr5Gg3+IRImnGyPSgDORzzNwPGz9ZBstEPC57opGn/K/lHka6vcsB
         79nDNBb0xNjAivOE6fbl/iZ8PEgu4GrTI0ynvHhTf3kE9TF5Ktd9wcu1MtLVq1sqmW1z
         5zZJKxDBLB8Za0LODQywh383tVJqEZuiSSmY+ENMnhO8n/Hfzubvwz9jDo62eIJzJi96
         ibVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782220662; x=1782825462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgwmBiHtChacwN0HIN+HC9h/6/vpUYCVSBJ/q583oqU=;
        b=RPgEhKPNPfTb5tnGdNtHF288IR/ldPJfJx2V+LO8ZhgiSnz4W+rXBziPWNamBiZn/p
         n1i/PTs8qNF7A3A8hO2+e7oLv3C47yM+HTgC06WJmi86uJhiyX9uuCSSrVxYii08Ca0k
         EvDlDPeVEg0ArfrUCOwSQVTcjaJJG6m1wgCYtoWYJnXgHVJRzVLUf+Vw6Cwm2hq3RzTQ
         40/VIPQhQz8ip671kRPq5ql3cX0EirIwf2P2T7YyLUDHCYovO4+sYFjtAgLUDPrVTT0J
         UmOqY8ypPDYajgEFNHXaaIedv9FZ3IQV2nHJXy4ajXPWBeSj1oR1oCyHZ5HJB/a/Y0xD
         FLQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9J/uvG2aJKh9XJvqd9I5+UfjsPLsXkgdD2AQ/OPQqDR/UaXraEgpP/QFowXczltuyl9dWdp94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MFr2iZ5AdrPWuoij6Y2Hit4q7Fv32iabed7hm1PBNDzJZy1o
	8RaAkW7iqmwnqDc4u23BBBF9rHLfBMv+/0ptXlnSARwjqNM8fdTwgwy3o2fZ7sIqfQ==
X-Gm-Gg: AfdE7cnP2TODTv/SnYPjTgIYL7x9PgW9aLe/Lb+Y1Ctf2SlAfKOJ9HMw13zasYw0jtE
	HNGF0jkwB/oB7YiZtxNIThtO66VuT0zqIzUXjYnnIvyzuUHxHHgNb2IhcIr+IiKIFKrVeXru6Mq
	YZVJ4l2eIjEYCDVeQRlPNqbJ2SuAehBQBX4ysiJ8bvB3m4uoccyOxDD09Ai29TZRaXN15y7WgpZ
	beTjVnmGdFUfEhG7b03ZIUGrRVZzC5SPm62nkqbhoxa7YW9AY55zGv4raazLN5Osp1UqZ+oBHNk
	XsZe+GucQeOJJkUa2XliNKcYJ+UyTAH/bqmFGn5lV6YJapTzKRrgVVFpJV4c8dHnuo9WJ5xPUEF
	bpONQtM0+DijScuP+vf3YX6vTba6FGajuUOOZLlYxEkLyqDI9STcaY0O9ZaShXR9e6kBt7Ikilt
	+lFzpQprqU0Js4lwdR0rsGSBW00fK29C+0
X-Received: by 2002:a05:6808:308c:b0:489:751e:9715 with SMTP id 5614622812f47-48f6210a6c1mr1543088b6e.26.1782220662352;
        Tue, 23 Jun 2026 06:17:42 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df823ab84esm125078946d6.37.2026.06.23.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:17:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:17:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <933c5d7a-e512-460a-992c-25be64ff48cf@rowland.harvard.edu>
References: <20260619095936.24080-1-nikhilsolanke5@gmail.com>
 <8175e40d-357a-4513-b827-752f679e9904@rowland.harvard.edu>
 <CAFgddhKKuGQgu0Ahu_WRyZocQGwPZkUejjoaJQ+P8--+k=Lwkg@mail.gmail.com>
 <8da4a00f-a01c-4b38-82a3-a718e5588f51@rowland.harvard.edu>
 <CAFgddhLVAp7nMX4YUHoaG+Q_Hm6w1uq9df2kH+4RWiJJGYDdhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddhLVAp7nMX4YUHoaG+Q_Hm6w1uq9df2kH+4RWiJJGYDdhw@mail.gmail.com>

On Tue, Jun 23, 2026 at 01:01:12PM +0530, Nikhil Solanke wrote:
> I have a v2 patch ready with all the requested changes along with the
> documentation in Documentation/admin-guide/kernel-parameters.txt. Is
> there any other place where I have to write documentation?

No.

> Also, I would like to know the "low-level" type reason as to why do we
> have 2 separate buffers. a desc and then a bigbuffer? Why don't we
> just realloc the desc buffer? Does this have something to do with
> reallocs in general?

No particular reason.  I guess it just seemed more straightforward to 
allocate a second, larger buffer than to expand the first, smaller 
buffer.

> Also (a bit more tangent), can the usb device potentially fingerprint
> the host os? if we are asking for 9 bytes first and windows ask for
> 255, is it possible that some usb devices will fingerprint the OS
> based on this, and behave differently? are there any other such places
> where fingerprinting is possible? In those cases, is it theoretically
> possible that this patch might fix some weird devices that "seem to
> work" on windows but not on linux?

Of course it's possible.  Devices can do whatever they want, as long as 
they obey the requirements of the USB spec.

>  I might just add this one line to
> documentation that it might theoretically fix other usb devices as
> well instead of it just being a quirk to fix a game controller.

Isn't that true of any quirk?  As a theoretical possibility, I mean.

Alan Stern
