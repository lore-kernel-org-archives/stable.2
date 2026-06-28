Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E236492A
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782656439; cv=none; b=Ut1o4nWxlJwHqdldBkTLy7iIm33NUdInjf4ZBPsDfaOiJp3auYDAOcX/T57ri+7ogQPlhroVHL1Xvc/tRvgVDFmsgDIRwf5USp9sBFLaPgTgaoc1+j9bKs3dVc5rSZVQMJHxcKdvVm2E0qDpLo1ZjY+cS7Jy02PE4oI0XkC61g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782656439; c=relaxed/simple;
	bh=Z+H/Kvc8XpNDcHZToc3a5fD/T+1alr+DVjRmlYJSPuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATi0qYTTQq/ROFEYaaaRJ51W/fMTXhV95MjJwRAaSHwAAoy9BmvSCLkLB2NVF7fN7msAmtpN84EYdniyoBGz39VqTEzvPXvbL+QvExtfZuMmvaCrFCy4CZPc3pcMlzukoImn4VOVb8j0xGftWHYDy/P0V6vfeF9XZSDDlFrI6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGK9mmJ6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGK9mmJ6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493a287b8c1so4901945e9.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782656436; x=1783261236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY2JA6iotpdc+Vj9khkxAw9AXIsRn+8IkOqa0Zg06mc=;
        b=hGK9mmJ6K4ioN9zfTCErTa/Tun7o55rOKwbcISRI8cmqBTtiINtxo+M+X9xBXDBv5N
         ZrK/gSL0IEAV3+m4EisqVmGSKu2XMwJLA4jNl5lahE5ASHE/54s0bedILp7lEscbFqS7
         WmpXeOxjHIXwwyIf1XgXClY/GXf+nv8Jf973lhrqQ/9L42kfmt9rwMVrPcC80dXzFN85
         ZgolDg440Y3gqRy25VOWn2jxS2MdDVbj+v200KH9Yi9v3VTUM8WtXYuEJzr/XYWS0kmd
         DovfYGBe+7Mtomi1n779MhGLIUOg+GdENGcJCr9R7flQTq0ugnbCbmgG14CXBL+9o0HL
         cvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782656436; x=1783261236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lY2JA6iotpdc+Vj9khkxAw9AXIsRn+8IkOqa0Zg06mc=;
        b=JZOZii6RWzXgKLJ41slez+QRyG5i6l3X+SxAcehy5KLh5Q+dfJK44RxJDWl+K5TlUC
         iZN7VgRdEhRLH9MumC8McDyjNWEk6zZ87SqweIfPjVJpwMpBWnNemeAd1tDseqN7CucO
         WAkrtBC8RBz+Z4qMsAdQfyT0yuVpMQOhV4dQanj8ajvmHAm7w3QgEqwy4qWRRmUPFyNj
         9LwxutZ2P86XT93UZFTI6dM6IISMUyAVQNzcBV04STu9fohx/9YPuA+ZCbP+5KvT9pdi
         81NkV3S39el7FqAbf2/0yvEuVMB9KEuOTERe23cyJ13rxdeb5/k0r4ZpC88Uu9VlMKio
         2nWw==
X-Forwarded-Encrypted: i=1; AFNElJ+t3wYPjaZaE3I7OVMZ+Ht/WemXAgPAHapLSX+5zxGJHPjZqQsRCns8eZQJrcKq+qoaifFNF9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEaLy4WTtyosrsiyqP3cWGWthsKR9Q6vv6nciI1+bMaZm3N9Tk
	wKRUfxGox7HlryMTrZRym1ogL/4ZV/yhSNJj1aCbrYugfbm0aJD3EeqV
X-Gm-Gg: AfdE7clLATpb5MQ0qOCrMA4BQUx/p36bMLljkXcCvaNxDP2YxdouJFHA+RNPjU3FpHg
	kCmJkIooMFACrsnIZeLkBPwd4s9OE1/Yb14DNst4376zZS7bcuPd+0427NqRKRpS5g0nSJkAN93
	HQ0Uu8ueH152v7+OZ9OcBoiU4APRn3aHWZ2qmGpE02dHDQE2Z0z0FVMyQx4me1D8D1kB8t5qxhW
	MGp90JVLx8isdTchN2gqCV/lywchJruyVkQZCsjERUETqIRGi1Kvl4yJCeTyBkek+b0vsIUyOLQ
	RVjh0nBkIFGDmiwOKx3CRhjrmOI3Msm4OmatXWN6aVW5TZk4pA8XAarbNQvsEZREOtW4OBGrcJv
	g14iktjNMvjaCSbNSbfEXH2lI78xqBguvFWXVSRSYaVz5W1hBy2y6ZR7G/w/eZxP5hx++AdqHeA
	Ji4vjedZtrHEqta20jVBBGdtd1MbC1klpp1vMPoEH/H1wOUp7DdMo9Pa0UW1Q=
X-Received: by 2002:a05:600c:828e:b0:493:a525:f4c with SMTP id 5b1f17b1804b1-493a52510a7mr56041405e9.17.1782656435727;
        Sun, 28 Jun 2026 07:20:35 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493a4cc6659sm84430425e9.13.2026.06.28.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:20:34 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5650DBE2EE7; Sun, 28 Jun 2026 16:20:33 +0200 (CEST)
Date: Sun, 28 Jun 2026 16:20:33 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>, Wentao Guan <guanwentao@uniontech.com>
Cc: gregkh@linuxfoundation.org, foss+kernel@0leil.net,
	stable@vger.kernel.org, brauner@kernel.org,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll /
 struct file UAF
Message-ID: <akEtsUNOcuws0xPC@eldamar.lan>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
 <stable-reply-item005-eventpoll-66-20260626@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <stable-reply-item005-eventpoll-66-20260626@kernel.org>

Hi Sasha, hi Wentao,

On Fri, Jun 26, 2026 at 01:54:18PM -0400, Sasha Levin wrote:
> > [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll /
> > struct file UAF (CVE-2026-46242)
> 
> Whole series queued for 6.6, thanks.

58c9b016e128 ("epoll: use refcount to reduce ep_mutex contention") got
backported as well to v6.1.175 and v5.15.209, will you provide
backports for the 6.1.y and 5.15.y series as well?

Regards,
Salvatore
