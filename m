Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2C3546D6;
	Mon, 27 Jul 2026 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137750; cv=none; b=SD8FrUo2F2TifMqvk54UljvRf748EmgFENXJ8m2b31jHTQiDXo00y2t6/pjgkf6FJu9h//kOhyfqLBANi18HdKsHOec+wkwB2WymXwganj1teYhOVZ3r63lSpdE+pP4OyZtB84sL2jWvL6QtquhZBIkGBYC5N7lLohxtSIulYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137750; c=relaxed/simple;
	bh=/imp7y+7vcd/kYaRoEG5SbixDtIxcsGnlRjvU2AD95Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Th1LHIJmkD3mDt0I2PImVgm73cBXcWlVA2Xu0C73opWNBShkIzxKsfTw2xVIek74eraXoTEA6Tdz6Q6MkB+0sxH6Sh/Te/nfFGDsg8RTtXdnW+RTp20CqWpOS21dTb3jpPGl7On+7nHW41czFlS0yIA4nLVj5RrQw3TWVEbMFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJZ0SJaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJZ0SJaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542191F000E9;
	Mon, 27 Jul 2026 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785137749;
	bh=nXAaHU+bO6CqmNP8GeiPSG4IKFMie3KJhHcvrJtgBf8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XJZ0SJawpx7JWMu6jmEZyrR6huQ8VXg+Gaf4eQiG6O6mjvZG1+GoTJp2vzvcd8c7L
	 IO/dD+BEnswYisCreq+7xCU3q4F+QUK3WFao5q19Zl83WOGpMPuPUQpg79ICgW8Oyf
	 PPg+7FMUKocG51WRn8PJbHn0EpF+pvdYNV7WcQvbkJQA/3xWs0rGAt2DPsalEXHMMk
	 PhIHFnTQo4lNlEafTWj8SBuRGZp0eWhYolBHK3LZdg9eeIAFikGr6YBBLYloU1DJK0
	 ZvKOD066ZHxQ+mUEX2sJ5SeSb0VAG7sCQx8z3VHjZPaGdCY/YLdmGxDlUVi8Rsyy1K
	 mZOtpObISlPvQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 03/24] binfmt_misc: reject a flag character as the
 field delimiter
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
In-Reply-To: <amTXwUK2FXu2sHI2@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-3-a162f7cb58d6@kernel.org>
 <amTXwUK2FXu2sHI2@lt-jori.localdomain>
Date: Mon, 27 Jul 2026 09:35:45 +0200
Message-Id: <20260727-lauthals-peitschen-aufopfern-1bfd12376820@brauner>
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/imp7y+7vcd/kYaRoEG5SbixDtIxcsGnlRjvU2AD95Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlcwXd5Y31n7zpd/dXhb1Xzml89quJ+iNfHhb0XSVbL
 dr8xZTijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlEb2D4p5W/Zs00pXf3Y2ds
 fN7veVSRTWgO284/Ey//OqSZVpRpJszw3+/LobkLTh5e7vieJ16fpft1EUtqqMhKwaWLFKzfnHu
 8nwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-25 17:37 +0200, Jori Koolstra wrote:
> On Fri, Jul 10, 2026 at 11:33:04AM +0200, Christian Brauner wrote:
> > The registration string starts with a user chosen delimiter that
> > separates the individual fields. So that the field parsers terminate
> > even on a truncated string create_entry() pads the buffer with that
> > same delimiter:
> > 
> > 	memset(buf + count, del, 8);
> > 
> > Most fields are scanned for the delimiter with strchr()/scanarg() and
> > happily stop on the padding. The flags field is different: instead of
> > scanning for the delimiter check_special_flags() consumes the flag
> > characters 'P', 'O', 'C' and 'F' and stops at the first byte that is
> > none of them, relying on the trailing delimiter to end the scan.
> > 
> > If the delimiter is itself a flag character the padding no longer acts
> > as a terminator. The scan swallows all eight padding bytes and keeps
> > reading past the end of the allocation until it hits a byte that is
> > not a flag character. For example registering
> > 
> > 	PaPEPPxPPiP
> > 
> > with 'P' as the delimiter (name "a", type extension, magic "x",
> > interpreter "i", empty flags) leaves the flag scan running off the end
> > of the buffer. The registration is rejected in the end because the
> > parser does not stop exactly at buf + count, but only after the out of
> > bounds read has already happened. With an unlucky allocation layout the
> > scan can walk into an unmapped page; under KASAN it is reported as a
> > slab out of bounds read. binfmt_misc mounts are available to
> > unprivileged users in a user namespace so the read is reachable without
> > privileges.
> > 
> > Reject a delimiter that is one of the flag characters up front. Such a
> > registration was always rejected anyway, only after the out of bounds
> > read, so no valid registration string changes meaning.
> 
> 
> Looks good, I see no user visible changes.
> 
> Can't we support a less arcane and impenetrable format, like JSON
> or YAML?

Adding a json parser into the kernel is something I had played with but
that has a bunch of very subtle pitfalls as the spec is underspecified
in various ways. Also, having the kernel produce json is one thing.
Having it _consume_ json is a whole other discussion. Ideally it would
be done in Rust.

