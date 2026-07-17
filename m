Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0673DDAE5;
	Fri, 17 Jul 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290390; cv=none; b=bLfCqB7uhwFHSy9VGXloPXmJu8I+i+inqIpiichoER2J+Fh87rzKewPYDVLz1MobTPABdkLB9hxZh07Fw3yHI+FklN8U3ZzAi+1lyIyoWHRMBkA3dv1K3ArsNF+MFRvDYVRcQt6JjL7feb9bupzoXARM+TOEhzxOvH6nQ6FCtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290390; c=relaxed/simple;
	bh=Ax0qum+9ONyQlDdDc0Fe6aWyz5j+p0vdYKFoEjglluE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJDvftsJ8wU2lCfq4WzPHbXP+4V95niy/4YLCXEiORfIfWnpXBpPOcibNs/FwXXqxfySq0W/JDlM/iC+0Bc2Ktr0+IhamEcANR1gp+eYaMsSzBlSJzRARyg+dXoDGIMHb8BQzYXH/fxRjCY59XF4IiOrw4MPzGcZ+xSLiWr6510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=azEJHSoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="azEJHSoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554E51F000E9;
	Fri, 17 Jul 2026 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784290388;
	bh=7IngRKP+1oI6ikH0PsflMTaobE2bdkCxNm/jkx/T4D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=azEJHSojGN6W+HLtYPW1ADZMRpb0A6rIhbpEdTq6nsEQg2KPeCj4+zSW2hAwaHcUO
	 62+Nx/VOvhOK+1EIRYU8B7e+BOAcxu1/HAvGo2jO+WBesWXOlAmQJDSOPNPsbYmZc8
	 rxFP64AINqO8DiSIDysxm7n5maugbHzcYEkmZ4IE=
Date: Fri, 17 Jul 2026 14:13:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio: bound topology parsing to the
 received buffer
Message-ID: <2026071744-unsteady-easter-16ab@gregkh>
References: <20260710212312.117781-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212312.117781-1-meatuni001@gmail.com>

On Sat, Jul 11, 2026 at 02:23:12AM +0500, Muhammad Bilal wrote:
> The Greybus audio topology parser trusts length and count fields taken
> straight from the module's topology blob and never checks them against
> the size of the buffer it actually allocated, leading to out-of-bounds
> reads of the kernel heap.
> 
> gb_audio_gb_get_topology() reads a u16 size from the module, allocates a
> buffer of that size, fetches the topology into it, and then discards the
> size. gbaudio_tplg_parse_data() then walks that buffer using fields
> stored inside it:
> 
>   - gbaudio_tplg_process_header() computes the control, widget and route
>     block offsets by adding the wire-supplied __le32 size_dais,
>     size_controls and size_widgets onto the buffer base with no bound, so
>     a module that reports a small allocation size but large block sizes
>     moves those offsets far past the end of the buffer before they are
>     dereferenced.
> 
>   - gbaudio_tplg_process_kcontrols(), _process_widgets() and
>     _process_routes() iterate num_controls / num_widgets / num_routes
>     (also from the blob) and advance a pointer by a per-element size that
>     includes the __le16 names_length of an enumerated control, again with
>     no check that the element stays inside the buffer.
> 
>   - gb_generate_enum_strings() loops over an attacker-controlled __le32
>     items count and, for each, scans for a NUL terminator with no end
>     pointer, walking off the end of the buffer.
> 
> A malicious or malfunctioning module can therefore make the parser read
> past the allocation. The wild block offsets are most likely to hit an
> unmapped page and oops (denial of service); the byte-at-a-time enum scan
> walks from a still-valid pointer and can copy adjacent heap bytes into
> ALSA control name strings, which are readable by unprivileged local
> users, so an information leak cannot be ruled out.
> 
> Thread the allocated topology size from gb_audio_gb_get_topology()
> through to gbaudio_tplg_parse_data() and bound every walk against the end
> of the buffer: verify the block offsets are ordered and within the
> buffer (the "< previous" tests also catch a 32-bit unsigned wrap of the
> running offset), check each control, widget and route lies fully inside
> its block before use, and give gb_generate_enum_strings() an explicit
> end pointer plus an items-versus-names_length sanity check.
> 
> Fixes: 6339d2322c47 ("greybus: audio: Add topology parser for GB codec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

How was this found, and tested?

thanks,

greg k-h
