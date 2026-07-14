Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA41315D3E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006467; cv=none; b=Z0XTERALcEpKDiAMAgrrDA3FMBneMAZrn0ohraI0Luvv6NIRNNuDPCLlCl7ZgD39JfTiCxAyuYF02T+QbDrc/qxkCGKeW9ISpUKEzDfrt3znkPvJmySkLb04NB/T+JKmgXzPkXyogDgdg+jvDB7E5F8M/XbqMNddK0D6VVYqgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006467; c=relaxed/simple;
	bh=ZI10RsFHefOClL7s49H3P8q1oB3YAwWHiPRL4Hqrnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYFKQDynvxu6BbkfG3IH0MN++r0Lt+AdnvdlqQkweuFDHxn43wkDITG2nbUDuuwBvlwBHqCup0igrreb3KjIFUGfpym/8PV8otfpvBxEBSv8osiKlutUZDe+x5Zot5Fgl+00Qr0x5BEheF9bgXvckV+oM1NdGCDuQ3G2M4cswIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=nT7mpWVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ickbgmOF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nT7mpWVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ickbgmOF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ECB4DEC01C6;
	Tue, 14 Jul 2026 01:21:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 01:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784006463; x=1784092863; bh=UetucyJhGG
	vtfnGy4WVN9y3ft5gRI1F3ms4FVT7cIfM=; b=nT7mpWVvWFTW9TU1RAE83Hgx6M
	heyFFTxBkyDGl6FxrSFZeiGihjADJ+LfuFLhX938oUxMnKNCuTvWk3Ln4+3NEiez
	Iz4q1G1aeLFdDlmNEF5zAN51KJHCKmloXdf1akdadjZ1nKAkZanhhW3vm7wBrpuU
	WrEshEaWLlvG+gHRlW6dvzvJXoG7oawHouOnPRXA55/0TNn/LcHsjWMzS1WpGUsS
	SFh/ugypAlN8Z8K8rWKF5X3R/h5ipdZ7sy9HGCtbrMAIp3tKOF2J3DnlCsoyf5ar
	gb08Ree1pytZcj1pB9QPY/VUsTEWO9KdsK3fCh+Nr2pBy4fsBt49+IAtVNCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784006463; x=1784092863; bh=UetucyJhGGvtfnGy4WVN9y3ft5gRI1F3ms4
	FVT7cIfM=; b=ickbgmOFepbMg7R6f/rmWhGglpOgQGD6SZN0et6NNF7SmcEVDbL
	glf5TJlTfISyKEUBBMFBW4Ie6Ie6omFlPrnvJr3gClmFiabO6rs7DLwQGhuwKH3I
	bpqCsPlKXMuVgrv2mHtuWBdT2++qH5gnWNXi8jfbv4KWjPpXceoG9X9DKuWC/WaM
	YoeKIlAbrFe8D+3wnJE5tdJ2ZvUTmL91ZsKrdts3G7CbpFXm+4heFBfTEkBolU7f
	FZh89xiIc0O+2cQd9yPOj6YlsbGi8pIjmvd82T5aQWSju09TGLZrbBJ4YFap/IRL
	+s7Fl1RSenp+wEnOHOGyrIbrVU2bNNyPbwg==
X-ME-Sender: <xms:P8dVatAPiTC3dXpsgxA5GTm8xBvK-G3Qbg9K3qjVeG_XH9mCaC4NQQ>
    <xme:P8dVaumcxfK6aDsEV9zSzY6p8RdrAYAZKNZbiySo8PxnxnjcTUTCQDi1yI017ZbV0
    a-jwhE-JsDrrFh8Wrt3RzOow9l68hz-VcG8LTP55TECwnOB>
X-ME-Received: <xmr:P8dVajP9BvoYwA-O9dXI2JFMMuNVCnMcnE0WoBMvSJT7r6Q2yqbqlUtNHlqnv9R6_TgS26dyEGy0evwUOh_51xIBbg>
X-ME-Proxy-Cause: dmFkZTFeA6w2FVY6wnLS9lvZG8zFBA1I5eBONRD4qc5zIi4+uATJ1wzBj2qGkN+TDA5VnT
    EJRzB0yvCkBnxfF8MPxLWtNLAXWQ0WFiHSTZYB+MggxMyncsZvMYLun0TD+qguc2dUeWUh
    NEjP2Puc8Qp/1MfSGJjMoRnzw1uzcY9fDMmD0v0lWlzgr92YK8+yx9xqi9xkwB2zSr1wQ1
    XxtA+uW5CIy9QuF/QF6dIBtnfqreJr/Ko9/UMRqT3QamQCvanxh6nmXYvkKMX0JyElO46R
    39SQvH83+WvmLfOYYTcKEUX1CLN5vSlVlIJgefb4RT4LeFGzcWH5t/Y/TX2prWRShRodA0
    g8A+UCNwBK1cMM2YtjhEKuSJ/Mxkq6QN05Jt1Gnt18CDI+CimGi5B4wuGetZkFgQKxYPAc
    Gb1pNPD4xKEi3wrkB7cKkHmU2erGxsbNR+AcCTrEpogaaTlBnj6/ui2ROUlNvFHJXNop/2
    V03AtOMioFtPzxKHzFIYdWcp6QorxAfchXvLZHSkLvNYcyZ9/LqtocR5Vg1KcJjVRQpzjb
    FORL2LTNDmR775b/n/lpX/G3stfgYv3BAd/mR4gFtjzaLB/3+fita+2/NuLLeAoc+nsUG6
    nAJsjFJeEHIXfaNRrmUC+s4uhkhk4Z7DkM8WUYozRzR7Fm+fy+FiDwcOu0Cg
X-ME-Proxy: <xmx:P8dVaj8YfDpB7wBfshjgNrz1mJVqc1KHm7PujaNG1apG0RFjP_059Q>
    <xmx:P8dVatFVc_Qql2PCyAYzhi8sxD4j2qK6GyfvzDdRWwa5nB4bHVh7kg>
    <xmx:P8dVaqhgU9HCXcuwadg8kx6grLLwMBdarXfw6tO6DW1Gor4wNRLKog>
    <xmx:P8dVaqvZsV3qKcdeui0FGLUMmDeXYtgN-K2hfbQvMIiA7sKCGrRDPw>
    <xmx:P8dVajCXXiXPwtTl0QJB77X4apyh9KrxeRWyWWC3PvIUBJCgZ6G6CUH4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 01:21:03 -0400 (EDT)
Date: Tue, 14 Jul 2026 07:19:44 +0200
From: Greg KH <greg@kroah.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, Anisse Astier <an.astier@criteo.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
Message-ID: <2026071421-uncheck-talcum-0f7d@gregkh>
References: <20260714043329.3510162-1-superm1@kernel.org>
 <2026071408-vividness-saga-4987@gregkh>
 <3ea09dad-9688-4f50-9939-059b8c6177fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea09dad-9688-4f50-9939-059b8c6177fc@kernel.org>

On Tue, Jul 14, 2026 at 12:03:19AM -0500, Mario Limonciello wrote:
> 
> 
> On 7/13/26 11:58 PM, Greg KH wrote:
> > On Mon, Jul 13, 2026 at 11:33:29PM -0500, Mario Limonciello (AMD) wrote:
> > > From: Anisse Astier <an.astier@criteo.com>
> > > 
> > > When writing EFI variables, one might get errors with no other message
> > > on why it fails. Being able to see how much is used by EFI variables
> > > helps analyzing such issues.
> > > 
> > > Since this is not a conventional filesystem, block size is intentionally
> > > set to 1 instead of PAGE_SIZE.
> > > 
> > > x86 quirks of reserved size are taken into account; so that available
> > > and free size can be different, further helping debugging space issues.
> > > 
> > > With this patch, one can see the remaining space in EFI variable storage
> > > via efivarfs, like this:
> > > 
> > >     $ df -h /sys/firmware/efi/efivars/
> > >     Filesystem      Size  Used Avail Use% Mounted on
> > >     efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars
> > > 
> > > Signed-off-by: Anisse Astier <an.astier@criteo.com>
> > > [ardb: - rename efi_reserved_space() to efivar_reserved_space()
> > >         - whitespace/coding style tweaks]
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > (cherry-picked from d86ff3333cb1 ("efivarfs: expose used and total size"))
> > > Adjusted for headers in linux-6.1.y
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > Cc:Steve McIntyre <steve@einval.com>
> > > Cc:Richard Hughes <richard@hughsie.com>
> > > 
> > > Background for this backport is that fwupd needs to be able to do CA
> > > updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
> > > process checks for free storage, and needs this function to do it.
> > 
> > What is the git id of this commit?
> 
> Oh I mentioned it above between Ard's S-o-b and mine:
> 
> d86ff3333cb1 ("efivarfs: expose used and total size")

ick, you did, sorry, I missed it as that's not the "normal" cherry-pick
output, my fault
