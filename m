Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908272D0C72;
	Mon,  5 Oct 2026 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171675; cv=none; b=r//7GwIdsCrDT3d/ucAtN4fuicY/sfns0iHdLQBXC/2z5mxLaIDo8FUmSc0bQh7TgrdlRvBC8waRjkgoVhmlb8WV5FpBv519SAMBNLsOeRfgUoiDv/Aze0ogDw131AxLbm+37eenF3rX9hrMZupa1Z6iTorewBOXb2rXGpz/CJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171675; c=relaxed/simple;
	bh=a/I5W75Wzj4Vi2hL0gaTgGCWcVuhYNZC2fvTbQdp26Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYJDV74vpyJhrIiEWnPI5faDECiD7udB8fY11S54rv9+W+Ef8pVCBBxKoa5LuUDGyO8FvNwvdsI5RwT0lIeRZVoBMtjh10Uin0N5/2kRCl8oOaq4o3L2NztlZdKWoo/30l2klLrGyam+PuRDNwJMlwMBAONsVb1LLRi9hPvIpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnmbBDdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnmbBDdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601D31F000FF;
	Mon,  5 Oct 2026 03:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791171674;
	bh=/++80sm8ie9dA37rGV3zbq1wVFGW3yfdcVqabOTu/MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NnmbBDdBs7MeM4iT9Xab0exrvDBwqVJGZRd22IpZ/iyM0aRPZ3C7Tz7ciLTCehgma
	 LWDOwfDyZR9UxlTqBf7e8aPHABRpTi/olsJQpES2YhfvKHPpsuN3JrRjThRT7tZx1I
	 ZTrHNBnH2slrBLk5zhsyp2lkDS3bDOR8cxG0jusrv5KIJqiTQGkumza5q7y8SJluAI
	 QTqEoN3mgCRkiPEnWP9lcAu83FpWWjeugHvaQujSABBWeiPrgRsEZxseSm0BsSIufn
	 1fOlmze0nD8otivmtpzwrZV8ZEI42IOjSc+mgLR+RIETvQHxzyGIZ9xhrBGSDvFEO6
	 AAWv+hFMrnsYg==
Date: Mon, 5 Oct 2026 03:41:10 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: James Fairweather <james.a.fairweather@gmail.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, stiraspo@gmail.com
Subject: Re: [PATCH] platform/chrome: cros_usbpd_notify: Only use parent
 drvdata when parent is GOOG0004
Message-ID: <asMcVmEa67BUmQ3D@google.com>
References: <20261003222855.23707-1-james.a.fairweather@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003222855.23707-1-james.a.fairweather@gmail.com>

On Sat, Oct 03, 2026 at 06:28:53PM -0400, James Fairweather wrote:
> Only read the parent's driver data when the parent's ACPI node is
> GOOG0004, and otherwise continue without an EC pointer. While at it,
> drop the reference taken by fwnode_get_parent().

Because of this, I'll add "Fixes: e4ee0bb077cd ..." as well when applying
the patch.

> Tested on a Google Nami-based Chromebook (BIOS 09/19/2019)
> running a 7.2.5 distro kernel (linux-omarchy 7.2.5-3). The unpatched
> driver oopsed twice in two days, each time on a charger plug/unplug.
> With this patch built as a module against that kernel, the probe logs
> "Couldn't get Chrome EC device pointer." (confirming GOOG0003's parent
> is not GOOG0004 here), and 12 charger unplug/replug cycles produced no
> oops, with charging negotiating 20V/3.5A as before.

Hi James,

Thanks for looking into this.

Sergey Tiraspolsky ran into the same issue on a Pixelbook (Eve) and sent a
patch shortly before yours [1].  However, because your patch also catches
and resolves the preexisting fwnode reference leak, I plan to proceed with
your patch.

When applying, I plan to credit Sergey's earlier report by adding a
"Reported-by" tag.  I've also CC'd Sergey and invited testing on Eve if
feasible.

[1] https://lore.kernel.org/all/20261003204623.18124-1-stiraspo@gmail.com/
