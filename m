Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794244952;
	b=veAiocBaVYppmOljDqtxc9qF6qH2e1o12HtFaM919oDeihITJKLkoC4yCsyaU8oDz5c+
	 MSPsMCbWcjcH9k/7ZH9mjX2+M0ndD0Yu48ZUiIekbrIW4IlCauh+Ak/0hh7iR1xyDhft3
	 dzHz3E2pGnjR8aU2TPcFpPf8PQDnE/yO8NHvLHoSE5QR8nY8btn75/YISooFbAWYgxnjz
	 QJnqupeNGeTs5ZLRgie0C+kKnnZ9KDNMi7/Thouxc8RpPT/ZrBB1/JbWDAghElEz3ErMv
	 7xRte41dS8VDJyV20IaaoPDYbrp4L3zkt3YaNiPp4j32pc8pUJEAo6qs9KiXtQqKOWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244952;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D9U6IfQ/eO/lP3tHlty6WQMujUfLneQ9jmVLjziVU14=;
	b=4uao6LoVxbwecfw7hSvWrXcHkWwzZsircoOUzSqvSHz73QP0IqG1VRMj72JLt1Qi6Mnj
	 /Znvb4dCu/s4BLFd7CCRftxYgSnNgHeKcbfmNuo0nzhSnLLskWWlfJAmAs1mQ1529fN8u
	 jaevdv7u8R0lTfBUkJD5DDUVlhz0N34m+eeY021CnjU2mX1OozPi76+KZQLLyAAyR9xd2
	 NzLkh6GPuxIf58/WopB1xR9U8rHOLpytyjYASBUrgqScY8V3h2/9n4Ax2GwO8n3j0TZqk
	 HHsvCaX5oKWMF5dXIn7nqOlUvKAc4kNk+yyD0yVVgV2fSNJ0YS6AG/Q7E9y/sfYos+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0NPahwk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071F606A31C;
	Mon,  9 Nov 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0NPahwk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794244951;
	b=lL5LEJxyCC0Uzb+ggJqbTWpKPjz6TVWx8NBDYAtPeCulFdpesFdy/peL1BzTSMKZTt4W
	 R8/97m2gJoOCB8SwVqUsggJZ//ST3N1OvGw9xv1ewh/KTauR7ihNvzhkodhKAQ3WUJQGQ
	 c5rOfi35gTTW7UbalwWf/H7kE9MkRtylcaQ9dNPpax3Nhyt9IZfzN8UmoZLPELhzCYKJk
	 rHf9c4pILIxmuZvByQDDX/m8g8bpA2GuKi8jAyOtmlMANmng2XDIHeFP6jjJ3Es0dL5DP
	 368HgmZWTz56ygHyqc0qp8quIBGmqw15NHRiLh6PGD5vCrJownyooqOmw8RWtPtH3pA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244951;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=D9U6IfQ/eO/lP3tHlty6WQMujUfLneQ9jmVLjziVU14=;
	b=C5fVgEzloT4v/siWiPs92JKTajshCxlh075Lzl1UX0tYu1FITx+MxzRhE/mZUTpUd+AE
	 fAO7awskSCFHemg/Es75Ss0jXJ2oEw6+g/MXz/1r5GKTzbWZUxMHwTmDmhuYC8oRWSfi+
	 KdsNXg0eFoBZQJTWh08EIK0oj2YG3YqPCTOYqIpDt8ksp/L2bowa7v54spPQwJsveNojC
	 2L6ODfsRhU2SloF5cuXhIUbrmdhTGrjb6HoirSGvldpNmL2+ra9igUdDggW9H0/mvp9PO
	 RzYVChk3wsLNd9rqZw1F7xr7wG4BrcmdvkZgv0R+77guhFBCmesaMOkgM3LR00Y2JqA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2417F1F008A1;
	Mon,  9 Nov 2026 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244951;
	bh=D9U6IfQ/eO/lP3tHlty6WQMujUfLneQ9jmVLjziVU14=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=G0NPahwkusp3/Mon21rx6ECbSa0acf9lj5wLuUlQBviiMhTUud5I9HNnOAAEVnaPu
	 OiSXQqnDuKmn9bX5ZkJJzOgmFCKaXCsIJqNQUjKwFNTtZsoMWP6SDn+SYiCwa6q6R+
	 q6TkL9lDpdz5AzM3LtCncDGb0B4HjI+P4pK5N6VSUBiIvyEYusw8btd25S21k5iAOX
	 NqpKxDa/hyYJTQqS6VuJ4+tpLSozogBJ+5I4G5WKyUewcVCRok/6aIxKcl5xIPTaAm
	 7IQNX3ddJP3el+2LT/4t89Tceur5c/Fed7A3jvZG+7jPKSijjjSy5ZzRCJNKew4UwN
	 CW6F7a8MEcMGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7BA7348586;
	Mon,  9 Nov 2026 17:22:30 +0000 (UTC)
From: Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org>
Date: Mon, 09 Nov 2026 10:22:31 -0700
Subject: [PATCH] usb: dwc3: apply XCVRDLY after PHY init
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-dwc3-xcvrdly-after-phy-init-v1-1-488ed0a0c7da@gotenna.com>
X-B4-Tracking: v=1; b=H4sIAFYB8moC/x3MwQqDMAwA0F+RnA2kug3dr4gHbdMZGJ2kohXpv
 1t2fJd3QWQVjvCuLlDeJcovFJi6ArtM4cMorhgaal7GUI/usC0mu6v7njj5jRXX5UQJsuGT+o5
 a/5jJdlCGVdlL+u/DmPMNhc8OvG0AAAA=
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ingo Rohloff <ingo.rohloff@lauterbach.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Brian Ellis <brianellis@gotenna.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794244950; l=3926;
 i=brianellis@gotenna.com; s=20260910; h=from:subject:message-id;
 bh=jakNXExeE+3F8RWpGGZDS5fPEZqL1DBayyBy3aFZ4js=;
 b=qHYh4EC0tLu2Dq1qtTAHNTLSQp4jn5DMMM6Fhd/1GuvnW+jOInVLJ0XFKcUiTMcGnWDHfyrbl
 5LzN3MfzJxfCk7lK+FWF3LxMpP6vttnKQpS0lvcyPfANlt8X3wWUE2a
X-Developer-Key: i=brianellis@gotenna.com; a=ed25519;
 pk=JciDR8ctfMqvKeRCDP8VPwNLUDULxCAqDum6H+/ByBY=
X-Endpoint-Received: by B4 Relay for brianellis@gotenna.com/20260910 with
 auth_id=1022
X-Original-From: Brian Ellis <brianellis@gotenna.com>
Reply-To: brianellis@gotenna.com
Content-Transfer-Encoding: 7bit

From: Brian Ellis <brianellis@gotenna.com>

Commit a28de6335657 ("usb: dwc3: Support USB3340x ULPI PHY high-speed
negotiation.") sets GUSB2PHYCFG.XCVRDLY in dwc3_ulpi_setup(), which
dwc3_core_init() calls straight after ULPI init.  That is before
dwc3_core_get_phy(), dwc3_phy_init(), dwc3_core_soft_reset() and
dwc3_phy_power_on(), so the bit is already asserted while the PHY is
brought up.

On a ZynqMP board (DWC3 2.90a, peripheral mode) with a USB3340, that
ordering breaks high-speed links.  Each link enumerates at 480 Mbps and
passes traffic, then drops 2.20-2.23 s after enumeration, and the host's
attempts to re-enumerate the device fail.  We measured 12 such links on
two host root ports; every one died in that window.

What matters is when the bit is written, not its value.  Written at the
end of dwc3_core_init() instead, GUSB2PHYCFG holds the same value
(0x00022710 on this board), and high-speed links on the same board stay
up: one ran continuously for over 1000 s with no receive errors, and 60
re-enumeration cycles completed without a failure.

Move the dwc3_ulpi_setup() call to the end of dwc3_core_init().  The bit
is still set well before any high-speed chirp, which only happens when a
host enumerates the device.

Fixes: a28de6335657 ("usb: dwc3: Support USB3340x ULPI PHY high-speed negotiation.")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Ellis <brianellis@gotenna.com>
---
How this was tested: not on mainline.  The failure and the fix were both
measured on our board running AMD's 6.6-based vendor kernel (through
ADI's tree), with a28de6335657 backported.  The backport calls
dwc3_ulpi_setup() from the same place and differs only in handling a
single USB2 port.  The 12 failing links were attached directly to two
host root ports.  The 1000 s run was through a hub, on a kernel carrying
this change plus five other local dwc3, ULPI and extcon patches.  The 60
re-enumeration cycles were direct to two root ports, on a later build
with more of our local USB fixes.  On mainline the change is
compile-tested only (x86_64 allmodconfig, W=1, no new warnings).

Not established: why the ordering matters.  The outcome follows whether
XCVRDLY is asserted before dwc3_phy_init(), not the value written, but
we have not identified which step of PHY bring-up is sensitive to it.

Ingo, if your USB3340 board is still to hand, it would help to know
whether its high-speed links stay up for more than a few seconds, with
and without this change.

Not addressed here: on our board the ULPI ID read that a28de6335657 uses
to detect the USB3340 fails when no cable is attached at boot, because
this PHY only clocks ULPI with VBUS present, so the bit is never set and
the port runs at full speed.  Fixing that needs a DT property and a
binding update, so it is not part of this fix.

Tool use: an LLM coding assistant (Claude) helped run the investigation
and keep its record, wrote the code change, and drafted this changelog
and these notes from that record.  The measurements were taken on our
hardware.
---
 drivers/usb/dwc3/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fd5c2cd36c..9b37ceda9a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1371,8 +1371,6 @@ int dwc3_core_init(struct dwc3 *dwc)
 		dwc->ulpi_ready = true;
 	}
 
-	dwc3_ulpi_setup(dwc);
-
 	if (!dwc->phys_ready) {
 		ret = dwc3_core_get_phy(dwc);
 		if (ret)
@@ -1534,6 +1532,9 @@ int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc, DWC3_GUCTL3, reg);
 	}
 
+	/* XCVRDLY must not be asserted across PHY init, so set it last. */
+	dwc3_ulpi_setup(dwc);
+
 	return 0;
 
 err_power_off_phy:

---
base-commit: 3149e8b3237f58d4dd440fc64c45c93404c4b064
change-id: 20261109-dwc3-xcvrdly-after-phy-init-509803f4b0c8

Best regards,
-- 
Brian Ellis <brianellis@gotenna.com>


