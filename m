Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB7279DCC;
	Tue, 22 Sep 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040220; cv=none; b=H9o4o1u4h9FVLEmwywQhrYFMPR8tmaTd4VMqY17UT9BpD9EulvJS20WWq/WrEHNQPbq5lyHdRdC3eii47es/l5PlWKqkWoiIQQR12AjC00Pae2Sf94myYflD1ghYePH/8Q3tTl/AmWMub8/KLK+894xbplTZbnesXq72Pn9wiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040220; c=relaxed/simple;
	bh=qkwY7bpZcT8tzaU519Lq5BhL2mG7LNy2Xqg6UPj/Tf8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=CB/pyCzwPgskh9l0/rakv/8OHeaC6xge949Tr/a/Nm2pHp1diwWKDcElT0rqosbQMEk7W23QLt8ZGmTDqoce2MRgw8Q9nLfeT4JB7I8zopjlR0auODlxOzLa8SEPxhUXOLBsKQ2fsuk53dT4g3/Yp7Rhm+k88p0BgO6HMPm1nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=serow.io; spf=pass smtp.mailfrom=serow.io; dkim=pass (2048-bit key) header.d=serow.io header.i=@serow.io header.b=DMUMLNSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpWECrBh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=serow.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serow.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=serow.io header.i=@serow.io header.b="DMUMLNSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpWECrBh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FCF77A0073;
	Mon, 21 Sep 2026 21:23:37 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 21:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serow.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1790040216; x=1790126616; bh=y2
	yB26Ce1uR5hfdEhMeGbsIPkmpdfEsE9PbOrwadxpI=; b=DMUMLNSdEPHaS+Q6vP
	3umnZnJnVuH3OR1VQPDy2YlH2F+dz0ZEAOD5YHqfnAn4AEH9ogKGtj2ArPVPTXpK
	LwAHDuLUU+suXHSaU1V97eh/ZQk/lSV63ZzZG/G7TSSReu1Af+q3bJukAYIh1mul
	IQ1K3dVZ0EW+tfMfXWr4p0ehykiAHlss5bETe3OmMQ8gwrWwjDen3N3qTWMq7ygW
	fQF+8GwpuhJ2vHcQHFx8FgLwJEkQLT/o9ZaNbpiRISpsAhdRCi3vbqPZNLQynE50
	G1rW6sU8U+HcaNxbe2uAMFCtpAJvgaAS2HGqPpNMCXqTZkWin1L7VoDHSdP3pMvk
	G2Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790040216; x=1790126616; bh=y2yB26Ce1uR5hfdEhMeGbsIPkmpd
	fEsE9PbOrwadxpI=; b=LpWECrBhpldkybrjUnKaefygsEgszwxrBpMkbTHcfRlY
	jbCtXYFkXhD1Y7FgW+RTsvA742bn5ZBp8rjcfse2HBojNk1a72xWcD+XL8GXsqpu
	gEPFM7mIYYcjOWU53AE/ZpVx0BsGV1T/fjxTxMmrWEFGxAN4tfqAzAV+78ts9tFW
	4n3W66JMb4HCt/N8OXm9SiJXdzSj0clVgb6eyK8Z2AvNo0HZNpaJj6rAiCpXRfJ7
	dAx/oOS3VhuzH6JJOBVGrESYzr9JMte8asaOyy2+t98gi/7OKpZMRyCgSPLdxgCN
	tWOUCL17fkuLRe0pZTIAPelbIkwSrduGV7AvKQqK8w==
X-ME-Sender: <xms:mNixapLPzTwA-gCCSMNe4y4m-INxIkfXqvQbnzTH40JFh1KBrDRPUw>
    <xme:mNixav9gRZ6xQIZJV5MjNbRQdJuGiQpfy-O1VqGMBLm4O9IT5jY7wZvAP7VPj7Edj
    oOy5VRsKD_Z7sF4Ru4WMsRsKN0UybH0csTeOX__a5yiy-8EWGHFF4yb>
X-ME-Proxy-Cause: dmFkZTEq/TRVa6MTThR+1j2LN7qpYuXLwj82iFMxFu7q2MHMZOafcjaLEkJPlhejv3pSpc
    /ElWdVMUpec69cp/px/F0Wxsu3GPPntu3MAqspCcPU1GNM01jSCnHcyjaD5ikIQVeDE+Cr
    4sCCVRJ9gh0ZdnEoAszKCUSsP6csTFLAjZj1wEtS/74TJNYgsd2hSUPkpf8aCVezRLB1JL
    YIniF4KN9FSeinCTBDBksxUC26hiU9KlE+B4qWHQZXhfiI3U+m1ajz0WJOiU5LOhYljI4C
    7WTf5cK4fMjR4OXtjoKrTc1XwLkNlXBJiCWDFjyqzaa9MJLxFbx+qJqMwK1BoL/4aFQ7lX
    67jLEsR02Ayu17aXVWr796qW2eh3tBeJLseybVQYwIK2V2CybIjnR7EQaxo5sR910nnA4H
    tzARjVcKtG4k91nISkSFqGcXn89n4BXQXjqwlZ0gN4Zi5FcIbNyJ9ptLogV4xDN2WvDaMw
    bCquXEGYCq0k3zdDlOFbSqsWQlyN9Qqwf/O9bDPb+151TON0AvCbulzt1zuYawvb6L7bN1
    BUDKKTi+StHB29VziB4Ki7A6T1mBax8GaAhe5uesJSw89e3SN8jot57fTT5218uAk26ykC
    fmvn9wRDf17IqIFkrgSBQf/KXioLTYRNqAedI5OLRiFlUuiVy6JE+gxFa2Pw
X-ME-Proxy: <xmx:mNixaiB3LRJ7zMUWTHqUPeyn8xABqUA_qIYjImRFFrdVC_wgwJ1Zhw>
    <xmx:mNixakpK4VKT_lia1abp00vLl3Q75e6oDTsX4PdnQ6BJaiHwZq6mbQ>
    <xmx:mNixalErfCSzzZjgnuYvhetIMGHIaGuZdrzZBOr36NC8ZkFmKMgb1w>
    <xmx:mNixagu235b7EoNQ5kC5Z31DTeLroTMuu80ySPcoiQIUop8MfIII9g>
    <xmx:mNixam482eNPiQIQTX3TlQkrpvdTzutZX5mWZaqGRtbWhp5yln8Wa9QF>
Feedback-ID: ia6364811:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7032A2CC0086; Mon, 21 Sep 2026 21:23:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 20:23:16 -0500
From: "Grant King" <gking@serow.io>
To: "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input <linux-input@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Linux Stable" <stable@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Antheas Kapenekakis" <lkml@antheas.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Sasha Levin" <sashal@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jann Horn" <jannh@google.com>
Message-Id: <069bd866-4eb0-4c42-bcf4-6983ba59aa49@slotpi16m74>
Subject: [REGRESSION 6.18.48 -> 6.18.49] hid-asus: ROG N-Key keyboard dead, also in
 6.12.y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The built-in keyboard on my ROG Zephyrus G14 (GA403UV) stops working on 6.18.49. 6.18.48 is fine. The N-Key controller enumerates, but hid-asus fails to initialise it:

`asus 0003:0B05:19B6.0004: using HID for asus::kbd_backlight
asus 0003:0B05:19B6.0004: Asus failed to request functions: -75
asus 0003:0B05:19B6.0004: Failed to initialize backlight.
asus 0003:0B05:19B6.0004: input,hiddev98,hidraw3: USB HID v1.10 Keyboard
    [ITE Tech. Inc. ITE Device(8910)] on usb-0000:65:00.3-4/input0
`
An input node still appears, the keyboard just does nothing. On 6.18.48 those two error lines are absent and /sys/class/leds/asus::kbd_backlight shows up.

`ASUS ROG Zephyrus G14 GA403UV, BIOS GA403UV.308
keyboard 0b05:19b6 (ROG N-Key), usb-0000:65:00.3-4
`
The culprit looks like d0754db7883c ("HID: asus: simplify RGB init sequence") in 6.18.y, a backport of 56d1b33e644c taken as Stable-dep-of: 02bf61dfb44f ("HID: asus: fix missing hid_is_usb() check"). Reading drivers/hid/hid-asus.c at each tag, v6.18.48 has the old code and v6.18.49 is the first with the merged init path; it is still there at v6.18.52. 6.12 LTS has it too, good at v6.12.107 and first bad at v6.12.108, still there at v6.12.110. 6.6.y never took the refactor and 7.1.y already has the mainline structure, so neither looks affected.

Before the patch, the N-Key branch ran the init reports and never called asus_kbd_get_functions():

`if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
        ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
        ...
        ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
        ...
        ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
`
After it, get_functions runs for every device and returns early on failure, so the 0x5d and 0x5e inits never happen when it fails. That is what kills the keyboard here.

It fails because of a size mismatch. The controller declares feature report 0x5a as 62 bytes:

`06 31 ff     Usage Page (Vendor 0xFF31)
09 76        Usage (0x76)
a1 01        Collection (Application)
85 5a          Report ID (0x5a)
...
75 08          Report Size (8)
95 3e          Report Count (62)
b1 00          Feature
c0           End Collection
`
and asus_kbd_get_functions() asks for FEATURE_KBD_REPORT_SIZE, which is 16:

`readbuf = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
ret = hid_hw_raw_request(hdev, FEATURE_KBD_REPORT_ID, readbuf,
                         FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
                         HID_REQ_GET_REPORT);
`
The device answers with all 62 bytes into a 16 byte control transfer, so it overflows and hid_hw_raw_request() returns -EOVERFLOW, the -75 above. The call cannot succeed on this device, which I assume is why the old code kept it out of the N-Key path. That descriptor came from /sys/bus/hid/devices/0003:0B05:19B6.0004/report_descriptor; I can send the whole thing if it is useful.

The patch says "There should be no functional change with this patch", and in mainline that holds, because 0919db9f3583 ("HID: asus: always fully initialize devices") had already moved the init reports into asus_probe() where a failed get_functions only warns. 0919db9f3583 is not in 6.18.y or 6.12.y, so there the inits are still behind the call that fails.

So either revert d0754db7883c in both trees and rework the hid_is_usb() fix against the old structure, or backport 0919db9f3583 alongside it. The revert looks like less risk for stable, but that is your call. Separately, asking for a fixed 16 bytes from a report the device declares as 62 seems wrong in any tree. Sizing the request from the report would make the call work here rather than just avoiding it.

Alpine has what looks like the same bug on a ProArt P16, same error string, same controller, bisected there to the same commit:

`https://gitlab.alpinelinux.org/alpine/aports/-/work_items/18451
`
That reporter only loses the keyboard before root is mounted, mine is dead in the running session.

Caveats. I am on a patched distro kernel (Fedora 44, Bazzite "ogc"), not a vanilla build. The function symbols in its hid-asus.ko match upstream v6.18.44's, so I do not think it patches this file, but I have not proven that. I have not bisected; the first-bad releases above come from reading the tags. I have not captured evdev output proving no key events get through, and the 6.12.y entry is from reading source, not from running it. The descriptor was read on 6.18.44, but it comes from the device so it should not vary by kernel.

I can reproduce this on demand and have a USB keyboard for recovery, so I am happy to test patches or build a vanilla 6.18.49 if that would help.

#regzbot introduced: v6.18.48..v6.18.49

Thanks, Grant
