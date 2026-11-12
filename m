Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794465445;
	b=hBtocHsh6zMS8v9lFQY2M7bag8Hbfnt2NfzhAf6IITx5FD1GJ7d5eILGFlDcN9hXK7JI
	 DOQorSanVQt5K5MbsD1aL7sGf/n0Lttj3svzMBzRJrDkIoHGmer8Pf2DJsL+EEqFrCI9D
	 lPq6PeFVYPV5i8kXkQ24GDPHCn/XECTEdx3Lhbjkh/3Kr9mSK9nbAS5F20qygbuPwJHzq
	 mMX1TcgqEeG/IM6jsjqS8flXiiqkYXUQK6M8lg8f/EG0kidYe3PWmB/fFJOGjH/lsO/WW
	 YKwVTLT7PXcHoQFFto5YLvVjeaks7MRw1JOIsdoN2+Pg2IMrdNglJMinyU1RAUZq1AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465445;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3VzuKLLz8C1S2TtrLZATgDK21zLtdbVWSHYlrogRoeQ=;
	b=zXLLmpx4rd37e+J13ycWo/HedWUcyB96LPD8JJMfvn32bSFwJC/zLBtS5DYZOVA1czq0
	 xzGMPa2NtEfK9be0iVo7ULylqpUfoQsJcLk75DCctBzxNferejuKm2MrwpE1u5WcLlbmT
	 +GooVUX2yjxEodgM5yMnx8Ve2E1Z2JwvjFIMOq8h8wBE5RIIlLEBimVhxhBtaiV+956Na
	 7NRfz9hNsNfpSqTTBOYIhg4DaACxqUE++2OUnbDXfaYZOuSrfH7Buc4lNM6BoVSnYdEpd
	 QZyQHwR2QEla6ahSBtLKqlest+5Y2xFgD9caQSIYj5AhwC4pJgX9iKxn4BJuWWWG/4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJ2ZQmbB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46101606A31C;
	Thu, 12 Nov 2026 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJ2ZQmbB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794465444;
	b=tJeLpMOT+Wpw4B/7S0YRB3995/mPkHRSEX4Bl8A4L074wZ+pfoRcQ4P/YS17cWi9cOhx
	 MP/E34u8IY9B1q3/H4E5RmS6Hawe1v2r4JEt8UY+zPpo6yPSPiEeVKIlbm4IB+B+MwJtB
	 G3kqzMVa2LMPKflRgWAnvcYpPRSCxL/2sMYH5Di5y8U2sr83tY1I6VNgEkwYI9nsM28xb
	 /Ij9lMhQNkaFVQGtZK39CXoB7bdNKGzebkW8p4laheobU/pgKjOqbTXzatUSox1KiBytC
	 UgXP/vHado++DZdJxFb6UCRFw42ukAqvjGHVNhIIIgEjX+0psBezuSbPp0E6oNBEJGQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794465444;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3VzuKLLz8C1S2TtrLZATgDK21zLtdbVWSHYlrogRoeQ=;
	b=YxyCCFI6pj1gLDu9Z0xwiYi7U4YyOUK/26gvX2KjtncKnAiWA6lg2AMipY9bJr/ZwUiG
	 eAUS8iUHtyYmbgyf7zcmQdWHxaLz2QLLkqYkhmdqaU6TgjhBNdsUnBRAama0ebLj3dhkQ
	 FN5qxXVTWx7ILGE9qEFN67i5N/Cz6kKZCRm1HrSU42Nq5SCAzFU6FCpmf/ZMGi2a+lo9D
	 yv/zcwnrtBbu/ognPK5ihqH2QqxIAJY2yyEVr18lLM6aOHyxpvTtJK6akmrhBrzvE5JEi
	 Pjz1nA8AWRQAnfLaAb554iP9fv9yeKwmZsVC25+HEa4aL2t0WH2BrArAJb6UEum5NDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E81C1F00A05;
	Thu, 12 Nov 2026 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794465444;
	bh=3VzuKLLz8C1S2TtrLZATgDK21zLtdbVWSHYlrogRoeQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aJ2ZQmbBWz25kBx0oIim1zEDQzGJprz0HFcpQBTgbk/HCKBgoR4ab7xxQbwuK4mHS
	 z06PZmE3uRxpN1/RajKaIcnHEwGf+37pm64acoJ5/Ia01TN9M0dro2E8lY23sSR/86
	 J3sFCFeTPgQLufvXnQ2SpMwFylbUkY7QeX4jBpcWUrBJASZyv5DwxxJQIy4lAZ8l3Y
	 mUhwt4IO9AnQ3rLCbITlToFXngBFOQsv+HhvT3epcpk5lT++uhyR0INNPb0y73KLcj
	 AAFm/u2EX6Wz4wMxH4GsnEYxMrdyjbYrvuVOkDzncMvvL3yFDyKxrf8CeK6/8V9zWW
	 hIVot4WbbNqeg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AE681492E9;
	Thu, 12 Nov 2026 06:37:23 +0000 (UTC)
From: Weidong Wang via B4 Relay <devnull+weidongw.illinois.edu@kernel.org>
Date: Thu, 12 Nov 2026 00:37:21 -0600
Subject: [PATCH] fbdev: cirrusfb: Fix overflow in the video memory check
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
Message-Id: <20261112-c4-n053-v1-1-1e45ef75304c@illinois.edu>
X-B4-Tracking: v=1; b=H4sIAKBe9WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3WQT3TwDU2NdI3NLi0SLFAsDI8tEJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tABkLWDxrAAAA
X-Change-ID: 20261112-c4-n053-2798a8d8029a
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Zijie Zhao <zijie4@illinois.edu>, Weidong Wang <weidongw@illinois.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794465443; l=3801;
 i=weidongw@illinois.edu; s=20261108; h=from:subject:message-id;
 bh=xRG3ca+6pdSvKSwRB+UJidN1R6P4hGws1bA3L4XBzg8=;
 b=jteVozVB8mMHGt6fDH8LV0GIynCc1mAKqvbMM1Ch7dewLc38Z7nammT+XsN2loZ789CGrNYNN
 uHL1gCPqlspDfsnGqSAf2q/e6pcqiapACSjISMTmVYApJWFxJoDNhs6
X-Developer-Key: i=weidongw@illinois.edu; a=ed25519;
 pk=DR2S1xPEa5sELrWPfOpvUphJQ2VHC+MDc/wJavE/ifg=
X-Endpoint-Received: by B4 Relay for weidongw@illinois.edu/20261108 with
 auth_id=1449
X-Original-From: Weidong Wang <weidongw@illinois.edu>
Reply-To: weidongw@illinois.edu
Content-Transfer-Encoding: 7bit

From: Weidong Wang <weidongw@illinois.edu>

cirrusfb_check_var() raises xres_virtual to xres and then checks
xres_virtual * yres_virtual against the video memory in 32-bit
arithmetic. fb_set_var() checks the product for overflow, but only for
the values passed in, before the driver raises xres_virtual. A mode with
xres 65536, xres_virtual 640 and yres_virtual 65536 passes that check,
becomes 65536 x 65536 in cirrusfb_check_var(), and the product wraps to
0, so the mode is accepted on a 4 MiB card with a line length of
65536 bytes. The framebuffer console then draws at offsets far past the
end of the video memory mapping.

Do the multiplication in 64 bits.

Found by an AI code review agent (an LLM-based bug-finding tool
developed by Zijie Zhao and the submitter) and confirmed on an
unmodified kernel, without error injection, on x86_64 under QEMU with
-vga cirrus (GD5446, 4 MiB) and KASAN. FBIOPUT_VSCREENINFO with
xres 65536, yres 128, xres_virtual 640, yres_virtual 65536 at 8 bpp is
accepted as 65536x128, virtual 65536x65536. Booted with
video=cirrusfb:noaccel, fbcon's redraw then faults:

  BUG: unable to handle page fault for address: ffffc90000b00000
  RIP: 0010:cfb_imageblit+0xbc6/0x1970
   soft_cursor+0x5eb/0xcd0
   bit_cursor+0xb41/0x1910
   hide_cursor+0x6e/0x1d0

With acceleration enabled, text on the GD5446 is drawn with the blitter,
which QEMU bounds, so the mode is accepted but nothing faults; drawing
goes through the CPU with noaccel and on the Laguna chips, which always
run without acceleration. Asked for without the wrap, as 65536x128 with
a 65536x128 virtual resolution (8 MiB), the mode is rejected, as it
should be.

With this patch the mode is rejected with "virtual resolution too high
to fit into video memory", and 1024x768x8 is still accepted.

The reproducer, fix and changelog were drafted with AI assistance
(Claude), then reviewed and tested by the submitter.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Cc: Zijie Zhao <zijie4@illinois.edu>
Signed-off-by: Weidong Wang <weidongw@illinois.edu>
---
Tested on v7.4-rc1 (05441d697f7f), x86_64, KASAN, QEMU/KVM -vga cirrus
(GD5446, 4 MiB). FBIOPUT_VSCREENINFO at 8 bpp:

               65536x128, virtual 640x65536    65536x128, virtual 65536x128
                                               (control)
  unpatched    accepted as virtual 65536x65536; rejected
               with noaccel, fbcon faults in
               cfb_imageblit, panic
  patched      rejected                        rejected

1024x768x8 is accepted on both. With acceleration on, the GD5446 draws
text with the blitter and nothing faults; the overflow is the same.
No KASAN/UBSAN reports on the patched kernel; checkpatch clean. The
code is unchanged in mainline and linux-next (next-20261111).

The reproducer is not attached (AI-found issue, see security-bugs.rst)
and can be shared on request.
---
 drivers/video/fbdev/cirrusfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 2693b5cc0..0fa809127 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -588,7 +588,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 	if (var->yres_virtual < var->yres)
 		var->yres_virtual = var->yres;
 
-	if (var->xres_virtual * var->yres_virtual > pixels) {
+	if ((u64)var->xres_virtual * var->yres_virtual > pixels) {
 		dev_err(info->device, "mode %dx%dx%d rejected... "
 		      "virtual resolution too high to fit into video memory!\n",
 			var->xres_virtual, var->yres_virtual,

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261112-c4-n053-2798a8d8029a

Best regards,
--  
Weidong Wang <weidongw@illinois.edu>


