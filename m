Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FA33ADBA
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036727; cv=none; b=SIPBvN7bFuNnE0xLNY/ph4253iR+FBeU+8h++FeStZ+UcDwNcW9bqQm1IrEa9eLTlFLdo2kfTTlOHErMg6TDhgkSYH7cLFCs14t3hWENwhhDdAXn/Tawn8M3tCvubFuxtbfs9Kh6E7I+y9UKvDyL2wzJv9A/cHMcf639ug8SXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036727; c=relaxed/simple;
	bh=CFod7ORF5bcMXh6c7wljJrGoHS5+ucXand+nmqr10/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7DTzjg5GjlF6fBe9hrrPbOv6OC21mH1PTMw7jszH/pKzSeBvaz6KsF4B28pwftE3sQ7w2ggOb1yAd9YLFHx82uFo8glJJzUTtCkXE3wMdpTBi51G/rimzUSTdFNpnQcrwSboAt4nIqDy/koizpsZPgrCC5eULnpP0Gk3EsGxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iVUoeIeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iVUoeIeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01EC1F0089B;
	Sat,  3 Oct 2026 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791036725;
	bh=P3v29nLDCqH85Ja4FY16YyWLhmvfC0hUp7w90sSZd3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iVUoeIeKSUc9uB0RLbEMdw5Nj2upjvYU0qmwe48/EEfcP+wJz4Ali0tQZWBKQK+Eg
	 TU36FkjgChU73KUvs23tfe+BgvjPg0L6rCjx2MDgmegJLU0rza1v/H2hOHVwZp41Zz
	 zi34rbJPlc3oUnaiMlV5O0WclGTdslCUuRobhj4c=
Date: Sat, 3 Oct 2026 16:11:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Mesa <miguel@miguelmesa.com>
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com, Jerry.Zuo@amd.com,
	harry.wentland@amd.com, mario.limonciello@amd.com,
	mgorny@gentoo.org
Subject: Re: [PATCH 7.2.y] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Message-ID: <2026100353-vintage-skipper-594a@gregkh>
References: <20261003131523.1502250-1-miguel@miguelmesa.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003131523.1502250-1-miguel@miguelmesa.com>

On Sat, Oct 03, 2026 at 03:15:23PM +0200, Miguel Mesa wrote:
> commit 7e5760f084d0 ("drm/amd/display: add HDMI 2.1 Compliance Support")
> selects YCbCr 4:2:0 for a 4:2:0-only mode only when the IGT override asks
> for it, and YCbCr 4:4:4 only when that override is YCbCr 4:4:4. On a
> normal boot the override is unset.
> 
> A 3840x2160@60 mode that the sink lists only in the YCbCr 4:2:0 block
> then falls through to 4:4:4 or RGB, and the Wayland session cannot build
> the output layer: kwin_wayland_drm: Failed to create framebuffer (EINVAL)
> right after login. v7.3-rc5 selects 4:2:0 again for those modes when the
> color format is automatic. Do the same here, including HDMI FRL.
> 
> Keep automatic YCbCr 4:4:4 for the other HDMI modes, as 7.1 did. The TMDS
> depth fallback also runs for HDMI FRL, so a mode that does not fit at
> 4:4:4 can still drop to 4:2:0.
> 
> This is not a backport of a mainline commit. The 7.3 fix is the rewrite
> in 0b0ff65d3c ("drm/amd/display: Refactor stream validation"), which
> cannot be cherry-picked to 7.2;

Why not?  What's preventing that?  We'll gladly take large sets of
patches to fix bugs, in fact we prefer to.

> Jerry Zuo confirmed the pre-7.3 logic is
> gone there. This patch restores the pre-regression selection on the 7.2
> code, following the v7.3-rc5 rule. Mario Limonciello asked for it to be
> sent to stable in drm/amd#5760.
> 
> Regression: black screen after login on HDMI sinks whose modes fall
> through to RGB, e.g. Strix Halo (gfx1151) + TCL 4K TV whose 3840x2160@60
> is YCbCr 4:2:0-only (VIC 97). 7e5760f084d0 shipped in 7.2; still unfixed
> in 7.2.9.
> 
> Tested on CachyOS linux-cachyos-bore 7.2.7-3 (znver4) on that Strix Halo
> box: Plasma runs at 3840x2160@60 with the same userspace and firmware
> that stayed black on every stock 7.2.x kernel.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5760
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5893
> Reported-by: Michał Górny <mgorny@gentoo.org>
> Reported-by: Miguel Mesa <miguel@miguelmesa.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Miguel Mesa <miguel@miguelmesa.com>
> Signed-off-by: Miguel Mesa <miguel@miguelmesa.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

A bot can not be an author.  Please read the documentation for how to
use a LLM in the kernel.

thanks,

greg k-h
