Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2B36B92C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139623; cv=none; b=af9uKvYtO2uCKu/iR7vZfM9V97EqfngSxCDGXANU7FCuP8wDPISqy+NNnB2RUFDIfOk2fl4LBKLdotHQnvWg1kpgBsleEWXN71T980TjAua3OizKC4uvgGOxJRji/42Jt3BMnIAeeMyRxbBUBlrDqfgR/4MZWCzUTdjEJPcyb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139623; c=relaxed/simple;
	bh=Au+SCB+zNI9l1fOceWRc8EraEyvsCHK/g1ACRBZm0BE=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=O3nQ7lFb5ebq7HLzJ/hgVRsYr42gr2vK1qRbSKr0vOYBuwJozKHQ8jvpA6xWlbIsSwYI/ISa4XOJ98Js7kysF6pxYutCG0OKdlIVp7WHtAsQbDYHJWB+SzLYbCpLn4MWgkNMJSVr6ezi2Htpve7j05+K4Xjh2Jn1QVd9XWa4xYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=yftMiiXB; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="yftMiiXB"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 54DD4181EF6A1
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789139613;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=i3FS69MrT4+l4qAK7QwAFh7KU8cJ5diW81tkTTXtX6I=;
	b=yftMiiXByf7eFVuV31HWhbakeGZe1t7A2i6T9nH5i/9HVYwlEjaaDDmkMfrrXZ+h
	PC2esGTxyX4EpUqen5OqeIsHJ9Rv/gj/yYUbEmUPZF7jyz2D+GHmNW7uFP0TWRVkqou
	+zwaP4v21kxznYjhvT+Gnv3kkQvl96M+RiI44Yw2iIqAOCzQchwuNuUBTJ/vixAydMs
	czplm48LAXVeCZ8hIrnkHGA9nlhqT9A02TD+doBal2iUSVN9sKLz08MP1WiHQm0Nu3X
	eHIYpx/3OiuAd98+n2+SUL8ZhkHYV7MqRU03W0rSfYQAxigvBdBLvwoles3VmO0lGDe
	oyszmflnTw==
Date: Fri, 11 Sep 2026 17:13:33 +0200 (CEST)
From: McKenna Fan <blue_sun@tuta.io>
To: Rishabh Jain <rishabh.jain1198@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <superm1@kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	Linux Usb <linux-usb@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Stable <stable@vger.kernel.org>
Message-ID: <P1FsfbW--F-9@tuta.io>
Subject: Re: [PATCH v5] usb: pci-quirks: always assert xHCI OS ownership
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 0187c20531a577579818688044ea8b1598dc676ba037cb422bc7fe017ce2170cff1d591c2b409c04f62272b1235757094d7c57ba2d2d5a547d0034541fbd608314:TurnOnPrivacy!:tutamail


This is an independent test report for [PATCH v5] usb: pci-quirks: always assert xHCI OS ownership.


I independently reproduced the problem and tested the proposed ownership behavior on a different AMD Promontory xHCI controller.

My affected controller is:

AMD B550 / Promontory-19 xHCIPCI 1022:43ee0000:02:00.0

The machine runs Manjaro and uses ACPI deep/S3 suspend.


I ended up collecting what is, frankly, an absurd amount of evidence while chasing this, including firmware analysis and repeated A/B testing, but the shortest useful version is:


Stock Manjaro 7.2.4 kernel, no helper module loaded:

EXTCAP_USBLEGSUP = 0x00000801EXTCAP_USBLEGCTLSTS = 0x40000000HC BIOS Owned = 0
HC OS Owned = 0




After entering deep S3:

xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit

After the failed resume:

EXTCAP_USBLEGSUP = 0x00000801EXTCAP_USBLEGCTLSTS = 0xc0000000

So HC OS Owned remained clear.


I then booted a custom build of the same Manjaro 7.2.4 kernel implementing the proposed behavior of asserting HC OS Owned in the xHCI handoff path. No ownership helper module was loaded.


Before S3:

EXTCAP_USBLEGSUP = 0x01000801EXTCAP_USBLEGCTLSTS = 0x40000000

HC BIOS Owned = 0

HC OS Owned = 1




I performed five consecutive deep-S3 suspend/resume cycles, including one approximately four-minute S3 residency.


All five resumed without:

xHC error in resumeUSBSTS 0x401Reinit

After the final resume:

EXTCAP_USBLEGSUP = 0x01000801EXTCAP_USBLEGCTLSTS = 0xc0000000

HC OS Owned remained asserted.


I then immediately rebooted back into the otherwise matching unmodified Manjaro 7.2.4 kernel. With no helper loaded, USBLEGSUP returned to 0x00000801, and the very first deep-S3 cycle reproduced:

xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit

This also agrees with earlier reversible testing using a very small test module which changed only HC OS Owned in USBLEGSUP:

0x00000801 -> 0x01000801

It did not reset or unbind the controller, clear USBLEGCTLSTS, or make other xHCI MMIO changes. With OS Owned asserted, repeated S3 resumes succeeded; clearing OS Owned again caused the resume failure to return.


So on this 1022:43ee controller I can independently reproduce the same causal relationship:

OS Owned clear    -> USBSTS 0x401 / controller reinitOS Owned asserted -> clean S3 resumeOS Owned clear    -> failure returnskernel asserts it -> 5/5 clean resumesstock kernel      -> first S3 fails again

One potentially useful detail is that USBLEGCTLSTS changed from 0x40000000 to 0xc0000000 after resume in both the successful and failed cases. That status change therefore does not distinguish the two outcomes here; HC OS Owned does.


This appears to extend the observed problem beyond the 1022:43fc controller in the original report to at least the related 1022:43ee Promontory controller.


I have complete logs from the positive and negative-control boots and can provide the longer A/B history or firmware findings if useful.


AI assistance disclosure: ChatGPT 5.6 Sol and Astra-medium were used during the investigation for source/code analysis, experimental planning, log comparison, and assistance preparing this report. All commands, kernel builds, suspend/resume experiments, register reads, and reported results were executed and verified on the physical system by me.


P.S. If Rishabh happens to enjoy following journalctl warnings farther than is probably reasonable, I have another USB rabbit hole which may be of interest: a kernel.org Bugzilla report on a USB3 Type-C peer-collision / port-power-management warning. The useful part is comment #1, where the issue gets reframed after more investigation:


https://bugzilla.kernel.org/show_bug.cgi?id=221987#c1


Different bug, but another fairly innocent-looking USB warning that turned out to have considerably more behind it than expected.

--
Secured with Tuta Mail:
https://tuta.com/free-email
