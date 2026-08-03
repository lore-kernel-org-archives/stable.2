Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB22332610;
	Mon,  3 Aug 2026 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785254; cv=none; b=svEhEoTmKhS0q9oIqQ5ed/aTvtYUtmByewJBhN9PUYElebtl3DsnO3CaTB3PbY9Qhqteo9rusRUF16b0IPRN65QjOhCqgTwM/Ews458osNvZ99Tq4rtVXAyMDga6l3o6CyiZraiKDPhKvozKJgB6aNj4Qcou/nECtp8SIg5+kYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785254; c=relaxed/simple;
	bh=+hsbs/71Ch2egmR5g8qxs7EemWyPdLevah5exvBp9cc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cs0NMg9rpZ0nnK85W4jfzPkX0L859h+TskLamnlzmCPtmMTDPxDiCOY/TDuNQ38cvuWhTSTpMW69i23151IBqxV8tIKJ8OsUwuG8mMRhVDY7f4EFVVqufMlDwqgGlo+oRThLRvc2VxIfglvR/kvQNQQqyX51EHB1s6xI/n8suK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP7ez7uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP7ez7uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE4F1F000E9;
	Mon,  3 Aug 2026 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785251;
	bh=naqkmVzg9Ps424QZ0gMerNJ/YrZHARlIWMxgClmZAYw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MP7ez7uwmALo4O+eJL9Qv4FkhQIQBn/HNrSJ52OsXWqx5uW7YWtBDWdiO6dQbd1ZM
	 5/ErivauFs8LohPFzu6qmau8oBgLpOOLI/No7jzNCZ7Nkinxyrgg2nxe21wYi6jNFI
	 56ldPXGAi3nD2wVhksweXOt+O1CFG+kTpG+9dK81OvaFlvdQ0SpJOfQBOaODCgO5Wl
	 EF1zLkKpbKy6Y4VQ1rG8YGCF1SmAhMZNzUjGG3W3o1gxqWuios8UKlVwiIBCi6zEQh
	 9nIasDCDwgMmF6farsRV/q2bbMD6JVr98iGPrv15aURdTN8o+yfE/3F97wZx82KY3U
	 dKwXc7R5iXmLw==
Date: Mon, 3 Aug 2026 21:27:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Christopher Kodama <ckhordiasma@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: re-enable multitouch after
 reset-resume
In-Reply-To: <20260725203446.35001-1-ckhordiasma@gmail.com>
Message-ID: <7s9734o3-06r2-r964-r211-43o8255s0s13@xreary.bet>
References: <20260725203446.35001-1-ckhordiasma@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 25 Jul 2026, Christopher Kodama wrote:

> When the Apple Magic Trackpad 2 (USB) is reset across a power transition
> (e.g. resume from hibernation) it drops out of multitouch mode: it keeps
> sending report ID 0x02 on its HID_TYPE_USBMOUSE interface, but the packet
> shrinks from 21 to 8 bytes and the trackpad2 handler drops it (size < 12).
> Clicks still work but pointer motion is lost until the device is re-plugged
> or the driver reloaded.
> 
> Re-enable multitouch from .reset_resume via the workqueue.  Only
> .reset_resume is needed; suspend-to-idle keeps the device powered and
> retains multitouch.
> 
> Fixes: 87a2f10395c8 ("HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude-Code:claude-opus-4-8
> Signed-off-by: Christopher Kodama <ckhordiasma@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

