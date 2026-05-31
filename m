Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E271345CBC
	for <stable@vger.kernel.org>; Sun, 31 May 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223029; cv=pass; b=K2YhMYsHDJ5l5tvY/07CbUmoCFwsmrKP6pY7JaXYH64EPVvIIG5fyIBgSSPZHoGc+T6wCiR+yM6PLn1MShFggJ3s7cR6/kLBDn9fJhV3zd56WUshkJZ+aeE+FfS+cczRxpw8ePXfMACxUS8smUjdzcn9w/vCbvvCyhYQdqoZ25U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223029; c=relaxed/simple;
	bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwchMwkUx8vH5L3xds0G5BUWlbOwy7Kv1P9zRlfpPtLEmYBUtLDjzM3pNqka++3ITTEkC39zyHWnxJ+SF5mGCfiKJk5rg3igKd0YkrWofdWis2MjNCk9ZLUDnTi4LYSoHWJxMKo6qeyl2CeiJPz69q6aL83HLn4VHLIRQczBpyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5z5fxJD; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5z5fxJD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1235345f8f.2
        for <stable@vger.kernel.org>; Sun, 31 May 2026 03:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780223027; cv=none;
        d=google.com; s=arc-20240605;
        b=cZnLK2tZ1dYKIt/0/UEfzmdPwjOOFwcY6zVPOVkSFzG267FdtwvFyUBK5hfNxoZ3Ww
         AN4utDhAXxPbnxxfMp1EloKJ7HHlisgQ44TX+ta9mJs+5JT7woPrB8Izk6JjtVA8zaGH
         5ex9Hgd6iR+eCYMlJE+byLLhBp6VG5ubcN+Cs+QiRdm6u37MWoZC2ImVrb15pmXT41U/
         FbJ/3sRoa8pF5rC8JhIwp1JsDplbPxnf65wHPHdqd6gM8UKdoct9nzdH0JVR58nzVF2q
         wLwedDpLm+zvpsqCbiKvROR3TlNgewuKXFOE4qTwMBCQtNYwDEuAwZyEEBW8XfDZENGt
         Zj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
        fh=immbg8U5f2eVFCyhMxcnJswbBzhyhWBmoRGzw11K4fc=;
        b=DyEfggJkApghdI4wtoxSDSHDIODYY82KPuSeDpDPi84297kLJk8H4RSbmExIpNJB+g
         9r508gbjSOfoA/W8CEazZrJsGzuO0QkfeyQrYdgNJ0sN5t7T+dLA8shGi1CQiJ30l7o+
         raLMOzrmawvo8J9oLFxLqAMosWdFVMbdAn5a3YVVbHFRH+qim+ruF+WDvLoKAkkIDORh
         JD4SJsEthbbY2Com9+qozYZA+hZaV6y89ZahFaOdecOXjQvL/JT+OAIL2mU5PnkCc1yY
         vwAm4oJJgkA7PsC0h2uJxHPAbDhzo4PGM4cGoDsa1ODsC5g4mInw5s+IcIZnwdqYOhMP
         uneA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780223027; x=1780827827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
        b=N5z5fxJDH4HqVdvtuMrFh5WFdzVe40AbFtLTd/6PKAcqHs6oDEzORYCMNZZkMh5PWf
         bRGaJFKv6rwMPwywdXY/434LbPk1XxHZIb58zVi3mTPhs2P4VRVZjBO8bdHb9Xab3mhG
         RvNs/1fClAW9wNsxPCBwuxmtbIWHpCb8UJl9kJykbkCMI0QYJzGVZpiCbRhBHjy4AXBc
         z0x0p0U9A5kkGoBh/68DIvvUst8ZqC5Aj/fmncYMzsQvXvCc48pAiHcVfu/wSI4td6EZ
         +XsntvK3OYr3+Fghlbjor2LFUjBTmNLho6M+yVLCyQAPFdPsbfcEZqiP/PQh/2V6nxR4
         zk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780223027; x=1780827827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
        b=s+eDRfH3j9BpD+CFk5NT4Ptjrpjvz7S6KMSbTOkx1AlxDIKYqq59BwH26PK4pmYXjF
         qwfCwZ1SS8ui4K79r+gkNTIoIe2P0J2dZdLsXae68yl3br2aibxTJXOm2xHaDp4DmPDm
         6N74WgsEUFfR8zZtk3CfR7OJ7oRN1GxxVfO85tSGvnGLcuqVLcfBtPSOlxQ+U8z9zCnk
         aseyQlJAU9dXDbS620Gz6emTUuJIM3sB38rg79XcHGXMLekqD+GsV2Fj67fa+ILDcaGL
         MBTebT0PcmX3LxKpCEG0COY/TFgHX5bIroeRHzxcMqhq5iCRfA3BFWP69LiVe2MoL/u7
         eoIw==
X-Forwarded-Encrypted: i=1; AFNElJ9GY+8gmf1E7ibXS1k9Hax4+k7CTzadryBFlb2OU0w/o4TLWFcxPL+nU9/ZMhMs5SgTL1QJE0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6ZGeZO2AcOsi9mGUquEcQsRnR+WX2EgFbTT7xq7Mj5OP1pES
	THkeXFfNJYZ1dEfCn06w5HV3x+15YZjdOikknTcj4PWhBt15uVz6Dw5pZeVp3NrCg7AgC4Qqf3I
	Ibm0NUe8dFePDpvBllHDwXWig8cQtKq0=
X-Gm-Gg: Acq92OFef3iNZrhixQ28AA165OGIgHkGvGsIQIaPq2fZQ0qXZvkwIykWjwCLDdBCeRf
	nhJu9iLUZf3OfKghdnMQVKDmlRf6Yy0F56jOgzLyC76sHnMKtWMMizJhHlQJ1SIYjETmu7GSogk
	T2HUYdNnUDJM74cz+PNo7r1ZRNGnM2ZrplBIF+zUe9kuTIEkz3vsJHLpNxnylJbEtvVUe2dB5FO
	/iNAaX7IGYcocUYP1tyFGHDvPDFppmmiL8yQoBNrF92RAYE5gY+/uKCpi5/5yNJBlCI5vVyMSGm
	79VsvVQ2TFUtn8kbzco8RNd5RA4O
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id
 5b1f17b1804b1-490a29639e6mr116698675e9.29.1780223026778; Sun, 31 May 2026
 03:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
 <20260527075924.2707856-1-maoyixie.tju@gmail.com> <21df0b14-f530-4e9a-931a-21154ec18c78@suse.de>
 <20260527161849.738b7f1f@kernel.org>
In-Reply-To: <20260527161849.738b7f1f@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Sun, 31 May 2026 18:23:35 +0800
X-Gm-Features: AVHnY4Lg-drlo1nT7uZW5coIPZFwVZQUv9F4k8fWAy2gBbp-s6mdZBwVD22P17I
Message-ID: <CAHPEe=F+ii=GgNorkhYJYXZAa4akxjKxG+qFr_H-USQE1F8bRQ@mail.gmail.com>
Subject: Re: [PATCH net] hsr: broadcast netlink notifications in the device's
 net namespace
To: Jakub Kicinski <kuba@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jan Vaclav <jvaclav@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Taehee Yoo <ap420073@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 07:18, Jakub Kicinski <kuba@kernel.org> wrote:
> Not sure TBH, we'd need to take a ref on the netns and allocate
> a tracker (on DEBUG kernels). One could go either way.

On the RCU side, you're right that moving the net out of the lock
means taking a ref, and this isn't a hot path where that really pays
off. So I'd lean towards keeping it as posted, with the multicast
still inside the rcu_read_lock. Fernando, thanks for the suggestion
either way.

> I'm replying because I wanted to question whether this is Fixes+stable@
> worthy. Sending the notifications to the namespace where the device is
> makes sense. But it's as much a behavior changes as it is a fix.
> The commit in question was merged to 5.6, real users clearly don't care.

On the Fixes and stable tags, my thinking was that the init_net side
is an information leak. A privileged listener there ends up seeing
ring error and node down events from devices in other netns. The
payload carries the peer MAC and the slave ifindex. That was my reason
for tagging it.

But I see your point that it is as much a behavior change as a fix,
and if nobody has hit it since 5.6, the risk is clearly low. I don't
feel strongly here. If you'd rather take it as a plain net-next
improvement without the two tags, that is completely fine by me and I
will respin it that way.

Thanks,
Maoyi
