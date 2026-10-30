Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356067;
	b=nSJKiUfyhEgsSHTJ180T6YkXxLC3wNYabaCw49m2tepve1Na6S2fiqCF5bJcWRPzomD6
	 WC7PFXu+wmyzTK3SwjEK9jQObpA2SYVMZfvxyv8K7OZstEJ8GiL8ZPYvLVJACZJYNk9my
	 mtUHLxukniDMBPDcqrDa96i/WUR+bAPf2dVy8FoM3n/rReeuNCTJTEoDW//h9RwYOJV10
	 4ONjaVR8cRfom37b8o704ycPqiwmiZG9L3E9pDni6UEZfNbneUDxivIJcmjNekWpvw7bF
	 9ZBmeimNBr6s+Hj1mxZlJy/RFHzuA4y1bpt04zWMKbWq/2wpWEWIZgQ6zH1JzEXiN+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356067;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n/M6XmCa6PAXRWxE9lzhWOYKw3B2kszDymNiyKm5Pww=;
	b=sdFTLedp8KCdYt6KrKDDxOGVPEdq6IMLeMubZngjTmFHagUxY/ipLiukS+fVOvc2n4zU
	 vpT/on3KbYOHS/xTkF/kI6BAde6xeuvn/+w8zm1P2lQOZTMwyTuZpvGrcY9eeuVURn3oA
	 jFJD/XdOG3w0stPX3oxiQudRWMegnaIUm8h9m72G33VKkvSRaUXdDuoDTMh6nhooiD4ze
	 EMHnQjtSFCz3g6YxuROxr9lUCFbpiTDt5q8TtEcLSv1SIJkjExRu4yKXdhBRRQAlUuvA/
	 AvM+dSI0uaoEqh4rfd0wvblXQfQTVPOKYbnOLTOkLYZ8mdgc4mG+3cPmsWWVvqqsKpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=dcs7DmLJ;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D57606A324;
	Fri, 30 Oct 2026 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D57606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=dcs7DmLJ
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8424:8fef:6e01:2a4e:9a3e:485b:cbb0])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id A8C2B19F593;
	Fri, 30 Oct 2026 11:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793356065;
	bh=n/M6XmCa6PAXRWxE9lzhWOYKw3B2kszDymNiyKm5Pww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcs7DmLJzPrw6X0IezWsSU+FhZ5RRh2IPHuaMDVUIAFrrBIUzjIvDa0WT9+HQkTHx
	 bB2NlrSDLJnsI7Hw4tKDlR4WwFYwvKyzd0m1fkK9Lp4yrc7rLQ8x3acAib47+R4v/j
	 ZgbUlDwecCh68cGJMSSFaRDIKGvbp9h7UZIX3zXTYfGDH6xyPp7P/Vm4kd33YjXE0U
	 f/xyMODwf8lelrqA5NSDeYdeRtihL35B5eqBIThblzDptD0qR380ufM7iEPU+Z707T
	 rjYx1ULo69TR7IsTLG2WHDRZB8+nj5oW9qeKVNLL728l161HXbiwGLDPZEe8N+ChIr
	 p9kEiCA7tJdnQ==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v6 08/13] can: peak_usb: reject records for unset channels in PCAN-USB Pro
Date: Fri, 30 Oct 2026 11:27:01 +0100
Message-ID: <20261030102705.30262-3-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179281433330.3130.2295013111859378415@kernel.org>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr> <20261022-canfd_check_channel_idx-v6-8-197704231551@peak-system.fr> <179281433330.3130.2295013111859378415@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 24/10/2026 05:58, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Medium]
> Should an empty slot be treated as an error here? The commit message
> describes this as an expected window: channel 0's RX is running before
> channel 1 has been initialized.
[...]
> Would it work better to skip just this record and go on to the next one?
> The same applies to the -EINVAL return added to
> pcan_usb_pro_handle_error().
>
> Two later commits in the series seem to resolve this.
[...]
> At this commit, though, the window is still there.

Right, at this commit the rest of the transfer is dropped, as for the
other malformed records, and as patch 6 does for the PCAN-USB FD. I
kept it that way on purpose, as in v6: patch 9 makes this branch
unreachable, so that an empty slot can then only come from a bogus
record, and patch 12 removes the dump in pcan_usb_pro_decode_buf() and
rate limits the other one. Skipping the record would only matter to a
tree that takes this patch without patch 9, and all of them carry a
Fixes: tag.

[...]
> [Severity: High]
> This is a pre-existing issue, but pdev->usb_if is only assigned here,
> after the netdev has already been registered.
[...]
> The later commit "can: peak_usb: register the netdevs only once all
> channels are set up" seems to fix this.
[...]
> [Severity: High]
> This isn't a bug introduced by this patch, but can this kfree() cause a
> use-after-free on the probe error path in peak_usb_create_dev()?
[...]
> The WRITE_ONCE() added here runs before the kfree(), so it is fine by
> itself. The later commit "can: peak_usb: register the netdevs only once
> all channels are set up" removes register_candev() from
> peak_usb_create_dev(), and its commit message names this use-after-free.

Agreed for both: they are pre-existing, and fixed by patch 9 of this
series, whose commit message describes them.

Thanks!

Stéphane
