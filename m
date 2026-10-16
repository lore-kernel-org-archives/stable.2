Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B63B7B83;
	Fri, 16 Oct 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144634; cv=none; b=f6NzmC+BuujIInIyOsqHqZZqA8TddnMkSh1J0ESOtR1oxhRi+HUgs+FHRTNVprC/y3lZ/At1Jei5c+DINEfkbq/dN6Q7MScwqruVrhdwq5WfG6NWVYlSHN69UQw1hlsihcKx51a9F9r6XawvnADmuC4v/1e1U7G64ASnHhttdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144634; c=relaxed/simple;
	bh=zYIwrLLAU7PP2d0x9w+aBblEp/0b5I4GL1hE9vxVE44=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p5njK8nPKjrjWVmSThCtOt/btAF6xBsN9COEuaxS5oecRLaSBcQ1gaRFDpDu80xZp+v0ZFRW461p/PkHlzAJx4NB7BfoNv7+teuKfLG71jjoAZXsI3ATM1/XuWMzCWUATz7IGF0JhnTrd/aGa5uEAsx0rg4/DRqb2nM7NGKPWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXWCxszP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXWCxszP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98C41F000C4;
	Fri, 16 Oct 2026 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144632;
	bh=keyCxRSbagkSqM2i86G4Z1V7nJP55VQiMZ6RJMi4SiY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LXWCxszPtCHX+Sh5b86nlR14KK3hMVe1ZOUFMuZqrJRjhN9b6amEFVn6RdI1yCRq9
	 MQpsRJ/RmZeNxhoEjYGrp90m6BfhFid0IzLnPVvVBiMGxm6QKVgQsH7kDhUJZBwH06
	 sWegiXdJc0McM6SfhttXFvjmHotxR4e6fKH704uGiNuuXp+o+9v/r5hBHjjSox6MMH
	 IlTzYkHP5BvexmlYdxAlFNzCdzPFmcpjMonp40uS2gJzx7SxgWsuUmOyT/9kiKCPUK
	 GrBVPuTV2v/U+nmcekAOaZqTE+3Mrjthbjm5tKIGoV9Z+KJHPW26MCwliMy0HDoIlA
	 7mSsDrl5I5Jwg==
Date: Fri, 16 Oct 2026 11:57:09 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ahmed Yaseen <yaseen@ghoul.dev>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Denis Benato <denis.benato@linux.dev>, 
    Antheas Kapenekakis <lkml@antheas.dev>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Alan Stern <stern@rowland.harvard.edu>, 
    Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>, 
    regressions@lists.linux.dev, linux-usb@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices
 with no input reports
In-Reply-To: <20260828104159.62399-2-yaseen@ghoul.dev>
Message-ID: <172916rs-519q-3sn1-o138-9ppno78noq29@xreary.bet>
References: <20260828104159.62399-1-yaseen@ghoul.dev> <20260828104159.62399-2-yaseen@ghoul.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Aug 2026, Ahmed Yaseen wrote:

> usbhid starts polling a device's interrupt IN endpoint on open
> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
> input reports there is nothing to read there, so the poll is useless,
> and on some composite devices it is also harmful.
> 
> The ASUS ROG N-Key keyboards expose a second, input-less interface used
> only for RGB control via feature reports. Opening its hidraw node (any
> hidraw reader does, including SDL/Steam Input or a plain cat) starts the
> pointless IN poll and keypress reports on the keyboard interface get
> dropped for as long as the node stays open: a lost key-down drops a
> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> reports never reach the URB layer.
> 
> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> asus: early return for ROG devices") is what exposes it on these
> devices by keeping the input-less interface alive instead of ejecting
> it, so its hidraw node can be opened and the poll started.
> 
> Skip the poll in usbhid_open() when the device has no input reports.
> Feature reports and hidraw output keep working over the control and OUT
> endpoints, so the interface is otherwise unaffected.
> 
> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-strix-16-2025-with-cachyos-during-gaming/30823
> Link: https://github.com/ublue-os/bazzite/issues/4590
> Cc: stable@vger.kernel.org
> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> Tested-by: GameBurrow <gameburrow@pm.me>
> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> Reviewed-by: Denis Benato <denis.benato@linux.dev>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

