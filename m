Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11284A4EF4;
	Thu, 17 Sep 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677582; cv=none; b=BCs0UDAlUdVRhLbTFjVylBLeWBoWjyGFlB18hpxv6qnWnCHH7riGuCCzD+19PAqj/9YtMcL69oN/COv5tvaZWwSX6SpglFFfIZ4W9Bce84sbv3Y19uhmD9U3ovQQyMNAidarpzvguCnYQkiy2PIpyRS75rypzORBpkAKUJpkNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677582; c=relaxed/simple;
	bh=cg7BCvR1cLAHYckn6sXbcMfbGYSZh3IvF6MOBd1cfDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLI6mMLARbQ0pg4EXcmdj4gvAMMwTxPTFUzDSHBkH4oCQAs8iCIPmpcaNehN3jQKBflwIud0DSIF1BVgWBfcnCR6Sq90hyAU5ZIkXahdVWJ+bueFTN2OSNwvYu2I7oqJEUfcDXNP+lzwirFJmnHzoPQJJGhBFPj7WlvzEwQws2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKbdwe4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKbdwe4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568831F000FF;
	Thu, 17 Sep 2026 20:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677580;
	bh=8F8vuRKsQlvpmUswJ4XE1PgRyZZ1pDeb65uVpTL9SmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZKbdwe4HeSL1dEjr23I2q7ywMJ/zdRa72oxd6e64/QZrrH6SDT2P6G8nibieI8Mr/
	 kltPQzLqUhcR+tAqEJoJAp0LqkGqwCBAunK170nxqB4YywJNC8Tr7XwjTOXsegw1wK
	 68t1GV9KHLrwX/xe70h9zSI6Opm5D/xjZDgB7x+nG2Vd7yPnvrAIOKFfBoTh6ZS6dk
	 XH6dUOYQSjCKmhywFppM0yQKzUX+KFpcGkrJlmWF+xvZOsqasCqHL85oxWYWg+Phog
	 jNnGHuX7nNkVWu/OMvd8G+/0c6FrXO1LOCL2MF9qxGjbfchcXkVNHjzEzjaEMzE9+5
	 nNQKKpmAAk2bg==
Date: Thu, 17 Sep 2026 15:39:38 -0500
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
Message-ID: <20260917203938.GA3480871-robh@kernel.org>
References: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>

On Mon, Aug 31, 2026 at 06:29:18PM -0700, Abdurrahman Hussain wrote:
> /aliases entries added by a device-tree overlay are stored in the live
> tree but never enter the global aliases_lookup list that of_alias_scan()
> builds at boot. As a result, of_alias_get_id() returns -ENODEV for
> aliases declared inside overlays, and any driver that relies on
> alias-based numbering (i2c-xiic, spi, tty, mmc, ...) silently loses its
> pinned id and falls back to auto-assignment.
> 
> The gap has been public since 2015 [1] and reproduces trivially: apply
> an overlay that declares e.g. `i2c99 = &foo;`, ask
> of_alias_get_id(foo, "i2c") -> -ENODEV.
> 
> The core fix (patch 2) is a reconfig notifier that mirrors /aliases
> property changes into aliases_lookup. Patch 1 prepares the alias path
> lookup for /aliases becoming dynamic. Patches 3, 8 and 9 are the
> overlay-code changes the use case needs; patches 4-7 fix pre-existing
> bugs on paths the series exercises. Patch 10 adds a
> unittest.
> 
> Prior art
> ---------
> 
> Geert Uytterhoeven posted a 3-patch RFC in June 2015 [1] with the same
> alias-tracking design shape. Grant Likely reviewed positively; merge
> was gated on missing unittests and an object-lifetime concern the
> author self-flagged, and the series was never reposted as non-RFC. Ten
> years later, drivers/of/overlay.c still contains zero references to
> aliases, of_alias_scan, or aliases_lookup.

There was another posting in 2024 of Geert's patches and AFAICT my
comment there[1] still applies. To repeat, what happens if the alias 
number already got used because the subsystems can pick any of the 
numbers without an alias. The only way I see to solve that is make 
possible alias numbers and dynamic numbers non-overlapping or only allow 
alias names that are not present in the base DT to be used/honored in 
overlays.


> Series contents
> ---------------
> Patch 1 makes of_find_node_opts_by_path() hold a reference on
> of_aliases across the alias walk (the walk itself stays lock-free, as
> does the pointer load: of_aliases always holds a reference on the
> node it points to) and validates alias values before dereferencing
> them.
> 
> Patch 2 adds a reconfig notifier that mirrors /aliases property
> changes into aliases_lookup. It also refactors of_alias_scan()'s
> per-property body into a helper of_alias_create() shared by the
> boot-time scan and the runtime notifier. A one-bit `owned` flag on
> struct alias_prop distinguishes kmalloc'd (overlay-time) entries
> (kstrdup'd alias name, of_node_get'd target) from memblock-backed
> (boot-time) ones so the remove path can't kfree the wrong storage.
> The notifier keys off structural properties of the target node
> (name + root-parent) rather than the of_aliases global, so overlays
> that create /aliases from scratch on a system without a boot-time
> aliases node are covered too. All aliases_lookup readers and writers
> serialize on a dedicated aliases_mutex.
> 
> Patch 3 fixes find_target() so an overlay applied with a non-NULL
> target base can still reach the DT root via target-path="/foo". The
> current code unconditionally concatenates base + target-path via
> "%pOF%s", so target-path="/aliases" resolves to "<base>/aliases" and
> target-path="/" produces "<base>/" (never a valid node). After this
> patch, an empty target-path continues to mean "the target base
> itself" — preserving the shape used by drivers/misc/lan966x_pci.c,
> the only in-tree caller of of_overlay_fdt_apply() that passes a
> non-NULL base — while any non-empty target-path is looked up
> absolutely.
> 
> Patch 4 fixes a pre-existing double-free in add_changeset_property():
> a property freed on the of_changeset_add_property() error path stayed
> linked in the target node's deadprops list and was freed again at
> node release.
> 
> Patch 5 fixes a pre-existing NULL dereference in
> of_overlay_fdt_apply()'s idr_alloc() error path (negative id stored,
> list_del() on an uninitialized list head) by only treating a positive
> id as registered in free_overlay_changeset().
> 
> Patch 6 fixes a pre-existing reference leak in
> init_overlay_changeset(): on a mid-loop failure, the target and
> overlay references of the fragments initialized so far were never
> dropped because ovcs->count was still 0 when free_overlay_changeset()
> ran its cleanup loop.
> 
> Patch 7 fixes pre-existing "//" result paths from
> dup_and_fixup_symbol_prop() when a fragment targets the root node.

Fixes should come first in a series. Then I can apply them if ready even 
if the feature patches are not ready.

Rob

[1] https://lore.kernel.org/all/CAL_Jsq+72Q6LyOj1va_qcyCVkSRwqGNvBFfB9NNOgYXasAFYJQ@mail.gmail.com/
