Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09A484251;
	Thu, 23 Jul 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821402; cv=none; b=vCWcg4AyU6ddahRAndoexzrsT8JY71Nd8f2WUr1j9hMollrF0PiLOPNEOp7udkC/HkravOZUiq1saqlMa3dMABstcSBxZen2NuknyeRECd498yQ9Bn2SWO+ZMgpAGHSNoe/SdwQ2KyvUGMpluU6aYOTfJixRxXGc1JX9H9WCZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821402; c=relaxed/simple;
	bh=+nTaZadFvHzFwb9WV3t9tfvESyUtzUJC5/SIOYBmDuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncnwhDA5f3VOllvofwKHZUoPN++I4L22hozkfEEtokXFvJNwuguAqKlXxWkxpk+aoKzt/s/0+XBZM7oki0Uxke8EepRQ/6j12YswWXZEADcx1fOlDXCGExB4RemT54MoQ8vbnedlDIYSaBEvr0XaGRdd5JOOsim6A+bsn8euOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9K7+F3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9K7+F3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F651F000E9;
	Thu, 23 Jul 2026 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821400;
	bh=9l39nxaJlVumfesYbCWchnWzHz2hnjGpdRnOUVgdbJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G9K7+F3hZUEpmlihriUo629h0/ReOIQtMYAK3uzSwqn7dhhu9KRYhMCT4EGFRpREl
	 m9Mo6gIEI7ahlX2r5jxSNybOdfJMPVdrgWpAZbZEZSZUNoYh5Lr1wDLiZvrVnXdXMx
	 kGbWGTNMO8O80c/ubp60P+9YSfcxZidROy5cROyugvJLZS+xaarfBdShAX1v/iFkZ7
	 h9gsQcN7ql7A3j04P0jQGy4gvrJ+L2jUPhSEh9zxiNSBq0o223wa5LnNdTSH1gS7WX
	 uFhWKUbAcPiTV+7STs8NH7bxhduEkNwPKkPSNiMzB9DdFi4Fh4ZtOw0Nndsk/P1C7/
	 KCw8Xjiy8dSrw==
Date: Thu, 23 Jul 2026 08:43:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>, Oliver
 Neukum <oneukum@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] usbnet: cap max_mtu for drivers without bind
 callback
Message-ID: <20260723084319.40fee97f@kernel.org>
In-Reply-To: <20260717151626.2913171-1-lvivier@redhat.com>
References: <20260717151626.2913171-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:16:26 +0200 Laurent Vivier wrote:
> Commit c7159e960f14 ("usbnet: limit max_mtu based on device's hard_mtu")
> caps max_mtu inside the if (info->bind) block in usbnet_probe().

Okay... but before that commit the logic was also missing,
and that commit only refines the condition. I don't think
that's the right commit for Fixes.

> Drivers without a bind callback never enter this block, so max_mtu
> stays at ETH_MAX_MTU.
> 
> QEMU's usb-net device (0x0525/0xa4a2) is claimed by the cdc_subset
> driver which has no bind callback. The guest accepts any MTU from DHCP
> (e.g. 65520 from passt), leading to TCP segments that exceed the
> device's 2048-byte receive buffer and are silently dropped.
> 
> Move the max_mtu capping after the if/else block so it applies to all
> usbnet drivers.

A short explanation here why the changes was made under the bind would
be quite useful (presumably it was done there because that's where the
existing MTU check was, and the existing MTU check only mattered if the
device specific callback could modify the state etc.)

It feels like we should update the max_mtu instead of capping it later
for devices without bind (note that only a device with bind sets
NOMAXMTU, too)
-- 
pw-bot: cr
