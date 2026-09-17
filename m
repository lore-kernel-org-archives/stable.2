Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335939DBD4;
	Thu, 17 Sep 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681295; cv=none; b=Pxv2QOlR0aDPynycQtiwiUnvcLiK0qMkZOvcsN/CXh3+KgEQq51DafEL4vR0SwZKZidDHn3EbHF4FZF0pijWL8bWIQ7BiclhySiJ0hocqvNpW2j9cvV38NQRzc7C1FTBdKxQTivL7Z7Sqy+o048McQA0qVUD/gholvbemw2LG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681295; c=relaxed/simple;
	bh=boUHk/skY66kP+y3bHiEAtk+qGJNkIAMMWTZ+35HUJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdgDWGkMnXjCQyq0YRYScU8/cwdNCg3N5j3+pBh1+CuRW/JAtvFe7ETRt7iXvuXNYg1BXACwxrGRsJ+R6UYyEQfp4SsvndxRHw1snW7q+s+/PbTpYei58EDVvg8Ltyu5eKkotVOKaW9/WOJZdG7Ev3dEojUshEZe1n4NwRTYrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgxYBXBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgxYBXBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5831F000FF;
	Thu, 17 Sep 2026 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789681294;
	bh=4vNKMNshTA/HjzXjwQ/qVz15MnrjiCLTEuI/UAhq7cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cgxYBXBK1emnwC2JEmWau0y7s/pn/ofxYWw2FGorAz9UdDJ+mZW6Au6ZwpaRGgwey
	 UrRadFsL3nd3olKwx90J6r4bACnbq5sR/2OK02nnOz8CGweMSMC4aUKcDWzEtUgOlS
	 yiBnC4j91xF6TKHGSqvMixBNRumZr4EZm0ADSiZcTnX2n9ZdIBlT5iH2i78qjEZNhI
	 9ffddxJ2UeQVtgcBIJKhCCsaNyCEh2y0z2Ih/BGz/OZzexrNKnY5w2/Sa//aZjZwN6
	 mCGmak+3lCrKygQelJt7qgzhWoNuH3toqJtjJhD2+aRQTFtk/oBMKiLldeX3IzQUEQ
	 3qCJAVi6QBO+w==
Date: Thu, 17 Sep 2026 16:41:32 -0500
From: Rob Herring <robh@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Grant Likely <grant.likely@linaro.org>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	David Daney <david.daney@cavium.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH v7 00/10] of: teach overlay code to keep /aliases in sync
Message-ID: <20260917214132.GA3844826-robh@kernel.org>
References: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>

On Mon, Aug 31, 2026 at 06:29:18PM -0700, Abdurrahman Hussain wrote:
> /aliases entries added by a device-tree overlay are stored in the live
> tree but never enter the global aliases_lookup list that of_alias_scan()
> builds at boot. As a result, of_alias_get_id() returns -ENODEV for
> aliases declared inside overlays, and any driver that relies on
> alias-based numbering (i2c-xiic, spi, tty, mmc, ...) silently loses its
> pinned id and falls back to auto-assignment.

[...]

> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Abdurrahman Hussain (10):
>       of: hold a reference on of_aliases during alias path resolution
>       of: update /aliases lookup on reconfig notifications
>       of/overlay: look up absolute target-paths absolutely

>       of/overlay: put property on deadprops only after changeset add succeeds
>       of/overlay: only treat a positive changeset id as registered
>       of/overlay: don't leak fragment references when changeset init fails
>       of/overlay: don't create "//" paths for fragments targeting the root

Patches 4-7 applied.

>       of/overlay: return ERR_PTR from dup_and_fixup_symbol_prop()
>       of/overlay: rewrite /aliases path values to live-tree paths
>       of: unittest: cover /aliases updates from overlay apply/revert
