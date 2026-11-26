Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697921;
	b=NzYj8E9XbygytKXEVXxyYmDIsO7XatFKVXdkRur/IbJOVdwlQH8ne3+zgvHG4YOSinIY
	 vJa7SQJgu9G9WDrkZj6aZMCYztIpnLZ3LgkGFD7q0hR62GxGIyGB3sAjJ36p56gKBuPm1
	 ArEsKB6ZOKG2aQJLGCsEmy6oIuEnWG7MYUe8Bv5nzdHCDeiNvA+tCsNmV2GkGGfF4/RFD
	 Uz6squy3c0lL20ijhMXQ57+rA2Sq4lCU9TM3h5sjDzqTNjFSmZhziHMxC1H6kiPOVimJh
	 GdZYRtc4DDrsDfyonorUPCtQoXSad/HX3P+PVxzCMOeLTwcANbfoBKOa2zI3rVHYqQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697921;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=It/HB/xtI5bDhLTNfm9nX6/osdkbdAzhRiDtEC2MTFQ=;
	b=PiuJDsVDy9k4+WmiX37EoAaExCPItt1NLFyoeUf4pfHwPKosWE4soQKsvavazwaQi53Q
	 OIj2jYAacZ6vJNrE1poexGydfC5+GRwlEhb/ZdpIHazGPLwBldRGJ6eVIPKcFkykbjceE
	 etAayGXF59yKu4QsuWes9+gGCY0zs4MYz2O8rNnj1L2oo89RkX2j7e4lSTKPoALZOnUhN
	 z3zvbQxQ+F9T0/Md+k7WxcNFHsiclQ3YIcDiwc8nsG4BhPL9AmAi29x02Js9sPtstTjGE
	 79wcx0+nPTG0niN+d3IeRXwOLfRwFzUBISVa6gD45J7tNtUwAgwlnKbxMlfSuGlItdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=G3Qf41zO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FC606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=G3Qf41zO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11741F000CF;
	Thu, 26 Nov 2026 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795697921;
	bh=It/HB/xtI5bDhLTNfm9nX6/osdkbdAzhRiDtEC2MTFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G3Qf41zOWJtEPNvYskkhzLXIZTZO8O9YYce8ClK2XaWDJ5sUxuiy6wxLKNOCe8ib/
	 MK1zMOk74Oaz66iedvoMlUjpkRiYZUjxDPhFt0jyxbx7GOgV1iQZEXwfk31IGQyam6
	 T3QuuOYSfgiSmtsY6XZvypQ3rtEqm4lnlqbWFskU=
Date: Thu, 26 Nov 2026 13:59:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dickson Wu <dickson.wu@certik.com>
Cc: stable@vger.kernel.org
Subject: Re: Request: security fixes for 5.10.y, 5.15.y and 6.6.y
Message-ID: <2026112650-vigorous-outclass-f813@gregkh>
References: <CAFaZ9erY+wo3QhtNvBdw1q2CB1fm4d2Zrx4t2QuJWEakDmo0bA@mail.gmail.com>
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
In-Reply-To: <CAFaZ9erY+wo3QhtNvBdw1q2CB1fm4d2Zrx4t2QuJWEakDmo0bA@mail.gmail.com>

On Wed, Nov 25, 2026 at 11:06:47PM -0600, Dickson Wu wrote:
> Hi Greg and Sasha,
> 
> Could you please queue these upstream commits for the trees below?
> They're security fixes that every newer stable branch already has, and
> each one cherry-picks cleanly onto the current branch tip.
> 
> 5.10.y:
> - bea3e1d4467b ("hfsplus: fix slab-out-of-bounds read in
>   hfsplus_uni2asc()")
>   CVE-2025-40082. 5.10.y already has the earlier fix with the same
>   title (76a4c6636a69); this is the second one.
> - 90f601b497d7 ("binfmt_misc: restore write access before closing
>   files opened by open_exec()")
>   CVE-2025-68239.
> - d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip reset")
>   CVE-2025-68745.
> 
> 5.15.y:
> - d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip reset")
>   CVE-2025-68745.
> - c0b7da13a04b ("scsi: qla2xxx: Completely fix fcport double free")
>   CVE-2026-43414.
> - 8ec9c1d5d0a5 ("PCI: Free released resource after coalescing")
>   CVE-2023-53743. Upstream tagged it for v5.16+, but 5.15.y has the
>   coalescing change it fixes as 26277a425020.
> 
> 6.6.y:
> - 59e1592d3c27 ("ALSA: seq: Don't leak the extension cell pointer in
>   the bounce payload")
>   CVE-2026-90220.
> 
> Testing, on v5.10.275, v5.15.226 and v6.6.163: cherry-picked onto the
> branch tip, W=1 build of the touched objects before and after with no
> new warnings, and x86_64 defconfig with the relevant options enabled,
> built and booted under QEMU/KVM. I didn't run targeted runtime tests
> for these paths.
> 
> The list and the test runs were prepared with AI coding tools (OpenAI
> Codex agents, with review by Claude).

For all of these, please provide actual backports, that you have tested,
so we can apply them that way.  Some of the above you list seem to
already be in the relevant kernel branches, so be careful and test them
properly before sending them to us (also be aware of when things have
been reverted due to problems...)

thanks,

greg k-h
