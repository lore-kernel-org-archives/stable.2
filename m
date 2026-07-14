Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B62E2DFB
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005181; cv=none; b=rsfX09V0Vl4q3wMrekzfY3VIMahiRqjcM5Fr1s/fTkEl8YWMcsUXA74ipsWfhWwg7QvOmL8AluQgL3LWGajOk41UAaMt5s/sovdxao4WdFUBN4mkGtZ0oo8s4KK++lOZN2AGmUgsZqjy/rJzS0m3rQdFd6xiF1yvrdaiCOK+O1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005181; c=relaxed/simple;
	bh=56nVkZDjPjfLIJML8L1xZ2/RYls7zqeXi+oMUQZz+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfXNJ3UKw5VmkUFbVTBPrjpHThPXD3i0xPbUaMrw1g9W9DfJ68kGYN3n1leOu1df+zYtdl7Uvbr/qdBTGroMnpbj8i1OMlw61RgMrKC7kLvARogVVSlKCVITsiQJIGIcE6vgmCebGOyTx9xZOPC7gbOiMdU8RWUayz+VQPIHCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=W5wzPoOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAnqJ6DV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="W5wzPoOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAnqJ6DV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9163BEC0177;
	Tue, 14 Jul 2026 00:59:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 00:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784005178; x=1784091578; bh=KSk29/CZYk
	8mDgdFFtDJK5LB4HTiVnFo5FoblaclGqc=; b=W5wzPoOMgXahUvSho9EA0ds0t5
	fpw8gJR1GgHFHo/wX6NGZJ3BGoLMuf/i91lrZlxdFShhKXHux7EnhmkFgQbjVm5R
	tfP5VqXRu2jtt1WyB91dgWJ87wNuRqU9vObY5L5czD15dTvnBHJxvMbqZfQwYS9y
	eMLDo37MBuL2C/NfXyVR4lclUMNIiFef22lo3bbUY4yC3RIBjgFUI4R0pM5YRDon
	zcoPtBhbXZRYhhya6PM9vRwkMLC+appP3Eq8a0Y2Sb+PQuxv58KhOpaKAXHSw4dg
	L8BFbfxH0L/fB9aT1+HNrmbQYVrTa7T1bN3PQESQG6GHEVzelDXXJCPz4Xew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784005178; x=1784091578; bh=KSk29/CZYk8mDgdFFtDJK5LB4HTiVnFo5Fo
	blaclGqc=; b=TAnqJ6DVoyPMIZLaVFvIq5wGt2qvbQsovTGyyFdJuLqYSdcg14c
	BgmaVw0VeE+Ye8nDTqBenKoVYYGJIhRl4tIR7r8SVxNLTmSG+fuE0hB7Pt8waqeN
	BLogqDwv/ulgRqNHfpT8OgknJGdfDAFaKF1jaugTxdrHKDwHdqiAuYBRyH2KY+db
	bY0eDKGKTyXAxxbxhp+Fujf9DXgNyTX6RxakMg4gfHsxg3yfPVtFVTASatG4bNEQ
	P+6cd26HV5Tp1w1EqhxxZNedyc4ihrvrQxLYFbF9D636SPX0rkqLPduaEbeXbo60
	wNyavs0sBGgAKngB7cccVthRwSPb3bswVgQ==
X-ME-Sender: <xms:OsJValmsqflaV2LRMHWEP1hnaOzwm61uKQntSjef3XSCoUtCRc6hVA>
    <xme:OsJVaj5Zl_7RFnw8vRAmmGERnpQ9goXiC1R1H5WJe9GgqgGCLpTpZK51eIPbMSI73
    V53VldjWbao7fjlFn5ArOK3rZ-_BE8UWl-cYHzaOYuNxuE2>
X-ME-Received: <xmr:OsJVamSL5MXD2RQJItg0dxyPvxvgvqHRBXwyAFzRv3Rs8fRquCdOd03RvBitIoWWoU3zQXp9jKrlgXDsYzWJgxP7PQ>
X-ME-Proxy-Cause: dmFkZTEMkIfjN8iNn3N/4d6GU21HX1XRrbFk8F9PkEb+qllhuWrXKcaLDzOXsN9IYHUfki
    qzcsLTOyzB38SZIerCZmDS+sQq6Rwn2ytpsT0cD2kpXHHcNIQOnW7irT8wsY84OfnV5Pmj
    K0+7EJwcIrmG3oFPRnikd5xOThmwRq+x0uyrDAXWINI7677ySseaGGkqO33RvrdDDlSqRD
    gOBfadFzBRHiRHJwSZcRRjws2gkaaFaJnUbTxzjoMN/wTjAXw+JyuEDNKZu5MEqUqWbNlp
    RLehktBa4a3t2mMclFE4ECtg/37EMyu98qYvrwuB/CX8HuFebPJ1vqUPGySsxIXGkEImLD
    jvEUfb8dAzOGmYeBK24a4siv8/EeDa53mpyv3HB7fvZWZEiKkBoPfTr5caRjbLYXAQFTX6
    BMSyTtTQhDsGCbwMZWEE7OUtQ5VNeArCath4PwMPqJKP5Qebpp8cED8vkqnXEH/ebGh13Y
    +mvGiCXI6lF3+aMfZCVSPEWwFqt0SvOnLDqhVMK+Qrus7oLHYyM6K7dfuKXAU/kmd1P/dN
    39IY0PfIe5mkE2SMFzxNnPF5BF/YEx5i/tKBJpZApmknorepSB7kFxsY3AWpkTbkhvsXxM
    3CQDoQA55U3HABAtqCo5avGCmG9ZCE9cj7PROttBRR8qSx0n+8x0jEMfNTTg
X-ME-Proxy: <xmx:OsJVahypvaiMAKjP5sThN5lKam-uYrHLNCUvLXNq3y9d4pat-bHwkw>
    <xmx:OsJVauqRQAAIjQ5uF7HcBh2El1h5FcnuSEfdnSKQOGnDOEywbAASiA>
    <xmx:OsJVak1twFD0ZV6decxlUDnqfMt5raIQoAX-V9P0Fq_CrhwQhflsTQ>
    <xmx:OsJVaux5mFZDDzVRJonPnAj1s-ZsdFGLcTLMYvaSs7i5vt42Hinp_Q>
    <xmx:OsJVarlkIUbfL0JUF7RS6FdmzDx-lAkIpyuV7Lmb4yOSrbc-7HMIpsDJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 00:59:37 -0400 (EDT)
Date: Tue, 14 Jul 2026 06:58:18 +0200
From: Greg KH <greg@kroah.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: stable@vger.kernel.org, Anisse Astier <an.astier@criteo.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
Message-ID: <2026071408-vividness-saga-4987@gregkh>
References: <20260714043329.3510162-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714043329.3510162-1-superm1@kernel.org>

On Mon, Jul 13, 2026 at 11:33:29PM -0500, Mario Limonciello (AMD) wrote:
> From: Anisse Astier <an.astier@criteo.com>
> 
> When writing EFI variables, one might get errors with no other message
> on why it fails. Being able to see how much is used by EFI variables
> helps analyzing such issues.
> 
> Since this is not a conventional filesystem, block size is intentionally
> set to 1 instead of PAGE_SIZE.
> 
> x86 quirks of reserved size are taken into account; so that available
> and free size can be different, further helping debugging space issues.
> 
> With this patch, one can see the remaining space in EFI variable storage
> via efivarfs, like this:
> 
>    $ df -h /sys/firmware/efi/efivars/
>    Filesystem      Size  Used Avail Use% Mounted on
>    efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars
> 
> Signed-off-by: Anisse Astier <an.astier@criteo.com>
> [ardb: - rename efi_reserved_space() to efivar_reserved_space()
>        - whitespace/coding style tweaks]
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> (cherry-picked from d86ff3333cb1 ("efivarfs: expose used and total size"))
> Adjusted for headers in linux-6.1.y
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc:Steve McIntyre <steve@einval.com> 
> Cc:Richard Hughes <richard@hughsie.com>
> 
> Background for this backport is that fwupd needs to be able to do CA
> updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
> process checks for free storage, and needs this function to do it.

What is the git id of this commit?
