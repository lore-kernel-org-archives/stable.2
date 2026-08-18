Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83841A926;
	Tue, 18 Aug 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042390; cv=none; b=n4qKIAg5TD9lXXAg62CmPfYDOUkG9ql/0PS5HK8Yrx/k+vxsqDj+gXJLzMjEB5nzO597S0Dl68mfcFn5dvcN3H6rIQrsPCnE6rqysLV86YEuWhmmu8oqLxbeyv7sC8WO9jqHWcrgBr6+2KkqchUNG0eGgmnjdcDkOGudXXgQfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042390; c=relaxed/simple;
	bh=5e+Kh54oSJILI35pg6NyFCPUiZ4Zq3wUi1ZhifVoJ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqhjfYZBcnK+4aykdQ2pCBfKfnjSobD+JEGKIXUit/TAl48pPSgk1N+u5wrNIVqEsd5oXIltrP+dXJcxepYYNbEsB/T07JeNdok5YFwZ9cLBM+wTIdGc1L/B3r1vmQCuwRdLREYpXgpM9FB21Eh8Plbf2nP4uZnWaWEP2v386EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jb5i4z4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDXyJghL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jb5i4z4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDXyJghL"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E011EC0280;
	Tue, 18 Aug 2026 04:39:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 18 Aug 2026 04:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787042387; x=1787128787; bh=4Rodb/ZJBZ
	gEY7rwUY5EUITa240uaSvSzkaQI1N163U=; b=jb5i4z4FGwV8sfhPGeQeTZhOAr
	tFwYriui26eY3v1Irbqd3ruCCc9reezGvo/4ruErEaW/8TH4+FyrRezZ5X5X7dUD
	h5yfysMnRYswPLHpEJ78pvlUxXISfTlp2IpC4paqv4U+Ff+eTlZT/azzPT56lP1c
	A/h0AkA8JYzcTeitKHQeyPAxqk+tia9f2tSPiNb73lsOoSrPWvRYcDogIfMzgFNU
	OaCzfXiztX4SODlxY9SG4+EH25j7TejTaXrH15zRzreBgmalFQcCAXD84ANI9Jf4
	hylw9lv29Zd+cU+0hk8RzRww7ZSK1090K5KkuRHVTXJmHm76hEHBLTE0DPdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787042387; x=1787128787; bh=4Rodb/ZJBZgEY7rwUY5EUITa240uaSvSzka
	QI1N163U=; b=PDXyJghLiDpDQP/ZMGLb164KIw5FVlVQx3SMnqMpzJOQ8WE9R1B
	JDe5yJx7pWJmFYfdvavwlOkQlqNazhmzCOqUwGr4WJQjx92bcJ9L3D9iH6ntS2sF
	ggUJWzQlSZqk5dHuOzpl6umT//rH/NEbVHE4PoaBu8CcP913Z6Wb323qPsCCAnmM
	xOiZ52A7jLfFRiI1e7wpKtQhkwaap/+x4sHZCiCY1ESzYzFi32l5bGm3NnJ6GO0/
	vmzvgB1B0Xj3I8l6DRBC5ejCsvh6B+k6EQMjgjnrdFpjEv7j7mWf3TvsjUQ5Tmuz
	q1HulCMgu6pp4N7NdW18kpXPRQzg60pNrxA==
X-ME-Sender: <xms:UhqEavBUebZlBNZMmw135mcLXM2OfiNL7CTn6SGAtKyZj26bVc1Szw>
    <xme:UhqEak_unzyGeksF-NGwjT2smdWMRA1inP-NUEfR33fG-bpoSvWKTVpRWwi7gCfsn
    HQRIlJUrAnNwG3ZZcVXz81yQOEZJhQrcM3vnaEHwUH9JqTGFQ>
X-ME-Received: <xmr:UhqEarp2Mkfl4PAc6t1Lhb_VTLZi35TMae8IqPPmJ_iMQ_wPgwKpkEspDEaKyedQ1VccSRuumT1DGTU9efBjza2WDkIozLh4QaCMd7SlPLA>
X-ME-Proxy-Cause: dmFkZTFB2aBy6Rqs44X8ii2UQFDqCYWbolDrrtfyd5TAjJGCUfr63k0vPLlTPWwF70xmS0
    1z5bNETFeFIRlVwmWCz68KDNjOySesLVOwmuXRPx4wCdH1lsa/E2hm4Woy3zGPG2mu95EU
    eFAQ0+Iq5xKV0/d3SJtVX59f+EkojJG/MSoA8siUYOB+UAqoeItZoYSnnC1H/Ah2DjgtyP
    THWD3JT1wNkb8A17nWj8/hNsDRUF1USbnm1HJPyIZKFMSl7aA6DaTYYuUg0kSSOPhtmBnr
    X4hyOA3ZSj3s5CKNQlHzsR9rrxlEvVDV7TKgWPFhPCKnFKUuxcsr7eZ9YUerc+mneArggR
    m0G/78fYUVZGtb95PaUZhLJUzUK6QXUrZwRAWVDeytTeD0seKxYSKjHSa7zou7K48Ohdqk
    uivF6weYRUn2pULXWf8AEsAbonDUXJngkJxpLyYRf99GMTb1p0BPj+c9Ckj9dKUkJ44xKS
    gt3yEUwt3kt1ASj7LmNh6vMgVXKuCWplTZNkC2ipNE8yWV0imucy2wTi3Ff21z5pTUvMwo
    Da9+XEpg/YaSqJNqezWbjCY1Y2yrPNSnq6g1YtXuWDRhgTnv2K5Kx9ncdBZqed2hmoBHaw
    o7gLaGqC321JDinB3lpp55+8CxXtQDz/aHQPVIwss9JH9y/aYv4dV4764QHg
X-ME-Proxy: <xmx:UhqEamEcSpq09upFxmH43GdLvyCsrznnN3K66MIlEF4QXtXD5IzrSw>
    <xmx:UhqEan-rXO9uO_B4FOzQf-UG4jpU7tA36LRBKS7m5TZ0DvWNMbRfyw>
    <xmx:UhqEarTuLr6JJYOjnPDLU8VUMYJBz01Lzw0A_iWHCveNZ3iN38CeCg>
    <xmx:UhqEakplDGUOdVKLSNxz9AaO_pL8p52z1ag-jBbEyd6siQabYLtuZQ>
    <xmx:UxqEaorp3E7g-Ge_l80Ku3MIP5GIdE4ntturRt_qHLxk2ujxATjBWtyK>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 04:39:46 -0400 (EDT)
Date: Tue, 18 Aug 2026 10:38:10 +0200
From: Greg KH <greg@kroah.com>
To: PANZ <panz.development@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, denis.benato@linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: asus: fix touchpad multitouch initialization
 regression
Message-ID: <2026081827-handbook-giblet-40cc@gregkh>
References: <CAFinCN9OV6fS8acwZjqsp9WR7r9tKk2afdc0y9RuAsmmmJpWnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFinCN9OV6fS8acwZjqsp9WR7r9tKk2afdc0y9RuAsmmmJpWnw@mail.gmail.com>

On Tue, Aug 18, 2026 at 10:25:27AM +0200, PANZ wrote:
> In Linux 7.1, commit 7253091766de ("HID: asus: do not abort probe when
> not necessary")
> and commit 0919db9f3583 ("HID: asus: always fully initialize devices")
> introduced regressions in the probe sequence for ASUS I2C/HID touchpads
> (such as on the ASUS E200HA):
> 
> 1. asus_start_multitouch() was placed inside the claimed input check block:
>      if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT))
>    On ASUS touchpads, (hdev->claimed & HID_CLAIMED_INPUT) evaluates to
>    false during asus_probe(), skipping asus_start_multitouch().
> 
> 2. The asus_report_id_init loop in asus_probe() was executed unconditionally
>    for all devices, which sends keyboard initialization feature requests
>    (asus_kbd_init) to touchpad endpoints, corrupting touchpad probe state.
> 
> This patch fixes both issues by:
> - Skipping keyboard report initialization for touchpad devices (!drvdata->tp).
> - Moving asus_start_multitouch() outside the claimed input check block so
>   multitouch initialization is always executed for touchpads.
> 
> Tested on ASUS E200HA (where touchpad functionality is fully restored)
> and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).
> 
> Fixes: 7253091766de ("HID: asus: do not abort probe when not necessary")
> Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: ppanzenboeck <panz.development@gmail.com>


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
