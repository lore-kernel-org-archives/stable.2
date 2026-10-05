Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA896468C16
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212270; cv=none; b=NoqEQhC3ciHFiPQTMfrj6ybnRsU4PZ5qqFyR1d7kJaSfeQRBGvMOhpZ3BrIGxznT8/frbJvaSUcjLxUKqDiCwfsWeYFhxNhtx6npXSO1MLv9dp/3MCKhQxWKYQbSL/jge7I961zwhHXpiqxW6KH0R77BagR8S5Wbi39B/KEyN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212270; c=relaxed/simple;
	bh=2P/9V4ylzB1hGsJiLG3D15l8z6rMZXj95l9Kk37n+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv7Kxyn59aQr+0lsubYzC/WUsDR+Xkyu9ZsutxKYO11+t3gyxR0mjZhdSrFmoZ2YZXpaeNR+AY2pj24BgKJlejYuuFAgrnAk2uaLOdVDlrzZHSeN3o/0ILnw3WN1UOLGO0RrRcD+bIexmjGPRES0SvK9JyVPB4Chu2QbcclxZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N9JOa+xd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N9JOa+xd"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 76BFD40E0481;
	Mon,  5 Oct 2026 14:57:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0J9h7yH4isPT; Mon,  5 Oct 2026 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791212253; bh=N+xpnxH7V22C0Xoe4UOwrwr5hw0pQwUziRetdyqR5zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9JOa+xdC2os9yHuhR+EuYIa7lDk/dqeO5MtJUU/fyaicCVeSts9AyuCU+t+2iCXj
	 4H2XRXDDBSMPVcxTEGzKOiOBh6Y1wTtB0fUY/NUF61uo8gb8RtxayRD1UTLkV+r0zR
	 644AgYO6BhGrOjbRDihpx8OP3BOw/Bd3dOd1QK60Z8K3SGPlJQ4LXzxvxonpbIaF8R
	 OX8IeT4QFjwt926w1AJ0qfRJQOv/lC6rphngsu+njHQZdiU3kvEaG7ZppSDnNfq/XA
	 oURhmU05SwjIUsB26OwBeGttj6PIowHPbTo86XYihB5jpFdnvf/mdmmJxEG/iBKhmy
	 TKb5lzcF5AJGxTrEiIUdcnjoWLRy/Jj74lhsOf/smKlHyF3NrokRbPsxpxtAyBwR6X
	 PzM1TOdtL8IWzxXQ8MWTsYSywLWcSaU6REE8HBmnK5x3u3fA57cv6J8GtILGegBSny
	 L0JPm6WP/8gJOetbl/ifpK/nVrPvqgNl67zl2HmFIxLB9noHYqKHGYbEpPxuaj58ve
	 rU76nKLmMWyk4qHTNXqHqtXRBPP5FkjeFGomlub7IC64pmVXN0m0/PmvqzzDsBnjdE
	 qMxZi4mmvVf+lKyM7PVl2own7kULZAcZF78uZXmMVFjEp/Zlki7n2P66NvvRejS5Ik
	 ibBSSrqt2aBVMPF7tMqGR5ew=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15B4640E02B3;
	Mon,  5 Oct 2026 14:57:29 +0000 (UTC)
Date: Mon, 5 Oct 2026 07:57:27 -0700
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dinguyen@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] EDAC/altera: Fix memory leak on dci
 allocation failure" failed to apply to 5.15-stable tree
Message-ID: <20261005145727.GDasO616AnvymDNLbK@fat_crate.local>
References: <2026100524-payer-capricorn-e50f@gregkh>
 <20261005142732.GBasOz1POO8wYBLJC2@fat_crate.local>
 <2026100558-empty-water-c908@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026100558-empty-water-c908@gregkh>

On Mon, Oct 05, 2026 at 04:51:24PM +0200, Greg KH wrote:
> Ugh, but the Fixes: tag points at 4.6, so which do I believe?  :)

Yeah, I know. Dinh wanted it limited to 6.18 and newer only.

> thanks for letting me know.

Anytime.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
