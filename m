Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896382;
	b=Y2V7lxMyT0QBWG0HrTMzT+f9QcH2wTj8U9V1B8plhWCWLo6VRXHajLZOohWCl8iz7qHF
	 uAhCr3cjBFz6WX+H74cEiVPXUfRuz1pHpPa6O+CEP+wnCr9LyGA54dXLcGZh6x1V6s+uX
	 EOzwBU4YapT4Bi5ApJZVpd/qHensWIqj8MEqW339RA1xYtkSttazpkDiYLyUNfUx1bB1v
	 XKePMFXo86+ESp8lFiYVzK+RFIksnzBidpnAcEFNTWfTTSSTpEs1U1gTMOu1qSPCBpw/4
	 IUDsXwBBceSsROTSj1Ave+qz6ngFB7wcukoqwU+voPB8CFSBeoHsQNpiaH7ukVvmhBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XUXEvm+x/520Y7mG6qCOQoTpy/YNPEI1fZRb82iDonQ=;
	b=xWBgbf1W00fuJco3cJj4SV6melHy+o5OW1wKyktRvRImrI/meYZiicsERekvmZB9ZgBB
	 fwcI8aQ7sJxsr8OEgTduQGeS5NHDnF7Ea+6zHu+ueJqBe6px0XW7L4xRXtyAgrp46NRGh
	 /Jf9F2prhr9249vYg5Am2yH61re0ckvhNhYFui9Ps1dbI+rEzyyj5BD8nDTihLCBgTba4
	 cy4ypesqi3p8f2GDodFjzcx8rghdqG2HgN0CLrTKqy8oqlU+MNiy3+Wka8y2/TdwwKXBI
	 4mTX22qmxX8cWaF4/JSQKOd5udDc/mLbVLeRm6KQhvG22IGjHQWxDyGa912dXtWtcrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZIDijORl;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB160A262C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5EB160A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZIDijORl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e47347279so1282482f8f.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793896380; x=1794501180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XUXEvm+x/520Y7mG6qCOQoTpy/YNPEI1fZRb82iDonQ=;
        b=ZIDijORlWOpzf5a5XcnQtJBxUwIcwKG495iGPJKkK+btm9KAOoMOJwVJl4OOHzOkNv
         VWxmpEQTIdri9U6c8WWbxcXNdpeUw7vA9OPev399E/jszK+plXaFgpJneHuAT9UB/QYc
         oZQKRyn/c5tdDgoK8gIZ531hHmOX34tcl7834FGOGGKC7cpupdpVs5R56d8tJw/2TpP5
         AbQDLVyJa8Jj9FU8G5RKk6vUXCKKFfoM0q1hbpUVueP/yqKs7fOGIJm0k1b/7wDIuroo
         EQPeQ6cSNvq14gMMADAmzQG54E3kZGA6/qrKmYDUhE+HVZ3E6G63QM7Pch/AbhaWo0Qh
         D5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896380; x=1794501180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUXEvm+x/520Y7mG6qCOQoTpy/YNPEI1fZRb82iDonQ=;
        b=Ri4yhTcKPDrnVqz7OXCPwI/0OxvCfOQJESyE150udgnOBJLdOXBppyNu6pI0FuAi6p
         uD660eyOgkOSJq9xiO0bxP0+bvGQmVtsaCC6DXpdffXkcv2kiI9n9rn0L4nYMkzi/ofh
         CMTkr0EGByShcPFOJXQYfl8SOiPipOS3+RSAUkXo9WZYmHaWhV0ndCBpp0CE+gHHJK4e
         H6Axl1bnakkzI8YPI0WyVDYTQLJieMF+K4/5uQm/0vUUkwFYj0v4ez/Ent56EIUVwS1K
         cuy9LGotOPWP+a+gvviQjP8ZMS5OfJI3uT0qUArelaV5vacTl8TNBIDkFVV9PAI7SJSl
         vzqw==
X-Gm-Message-State: APuU4Z8TOYcVBd4/ScbrgLYrjk8i7gzzIKKlsWsevUQ7aeOevi18iI75
	eNL6F+TKyjZbfflwr3dqZYykgicXzGchpr0+WGHdtPOgSMQ9fb+nSrhUDh2DckzF
X-Gm-Gg: AYBFou3v+76/3phKtu/HO3vuFriPrkBVI7yUzvw8lqQNs+/N4gk8PTwVmONALGeln26
	bNKg+Ey/qojtpbLxXe3JntNv5u2fpNYXoynf1Ma1YwH1Qw0vHRwzJBXRBiFdk04il0YqdasU7EH
	EN7/TD3DUXuT3QDwtQ2Aa6OikIFL3zl847EHN2607guGuNiq2gHGzVO/7x6zjw+g958KRKCa6bs
	1DzKV9g/8KiZk0qxo8us4mBH/o2EM6sSDTPgDZaxBOBLJwLv22waMGouFOcqnF85mAEUl1xVhUO
	rKAHPQTvuEs+oPX33+tj4gRupFnelZuCrsRWg+2Uro4v8/F4gDZ/AfzwaU9YLH7go7dmpGzH1Ts
	f/QMGoYOhbKtCxLVBiKoZKJJwPziBmV3KLeWuKpmacPmlhy0UI0gJz9JpAz7lLDYe/mJOUYFnmS
	QRZMVvReHJ7/l5WBcSOGb4ed//lAWr2wPl+804fgeMPlygLiazmVQqdwIPrxbBJbvhLnsHW/all
	FItwKHrN05o59kFfHDZck1di/F1m2b0ZF8zw6hrRrQCGIzHVGJQArE68mworl4KIkEuNkSwDcJ4
	eN2uZqrl6jraTR01+AJepjrKQ6GcxA4S2pXa9Jb8HJ04QXLbo9gLQzH6+csD2F4=
X-Received: by 2002:a05:600c:a41:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4ac150b2136mr409947835e9.4.1793896379969;
        Thu, 05 Nov 2026 08:32:59 -0800 (PST)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22f4sm125983355e9.13.2026.11.05.08.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:32:58 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id F032ADC02C5; Thu, 05 Nov 2026 17:32:57 +0100 (CET)
Date: Thu, 5 Nov 2026 17:32:57 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"eadavis@qq.com" <eadavis@qq.com>, "tiwai@suse.de" <tiwai@suse.de>,
	The Darkbird <thedarkbird@protonmail.com>, benh@debian.org
Subject: Re: [REGRESSION 6.12.y] Please backport 70b4db7d2581 ("ALSA:
 usb-audio: Use the right limit for PCM OOB check")
Message-ID: <auyvuXTfDDGcCTZN@eldamar.lan>
References: <shfaXkZCI7FtyNr5tS4kCC_d5E4uQFhc0MtwJa2CQFXpNMfSw7Ub6urwWpGrcoRnHuoneJEi9mLwtnvVImMhz1Hb25iwNJxx8GZZsDCV_HE=@protonmail.com>
 <2026-11-04-1-daily-reply-0005-re-usb-audio-oob-612@kernel.org>
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
In-Reply-To: <2026-11-04-1-daily-reply-0005-re-usb-audio-oob-612@kernel.org>

Hi Sasha,

On Wed, Nov 04, 2026 at 10:03:14AM -0500, Sasha Levin wrote:
> On 2026-11-03, The Darkbird <thedarkbird@protonmail.com> wrote:
> > Please backport the following upstream commit to 6.12.y:
> >
> >   70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB check")
> 
> Queued for 6.12, thanks.

The commit ef5749ef8b30 ("ALSA: usb-audio: Prevent excessive number
of frames") introducing the issue was as well backported down to
6.1.191 and 6.6.160 additionall yto the found 6.12.114.

Should thus 70b4db7d2581 ("ALSA: usb-audio: Use the right limit for
PCM OOB check") be queued as well for 6.6.y and 6.1.y?

Regards,
Salvatore
