Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DA4D4890;
	Mon, 28 Sep 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603984; cv=none; b=h+ekie34IMOp5KlQgqsapNlOdcU5Ec0nIQeXmXYeuqMbeWnQOkQmNzAjgf6frUHT/FoecxXM3ffFMdP7s8nnNnkr6N0s5OGNEdIv3Ys+0po8e7igwT/eLCpVBVaEY4wOTxuZofXXTgIYXPITuLMBVPlaqEq9e6zoAVt0799Vvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603984; c=relaxed/simple;
	bh=C2Fe0MYJaMj1TO9k6t/S2y+fSC0s2SJC8TTMFZGWn+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QH7SOFT3qdnLcaW94KjA9EOggoP3ly0DjbpvUCShnuUCryLiurQCajF2D9FA7lv47Ani0rE/mGzAyhU7I424k7MpRMGG41cF7SgiWMxrF10z1OIsdvI3Xn0ABkq8Qc7JRPy9ueuKmnrnazluWty2LNeK6ISmeyTwIxj5XXm/V9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM7jNw8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM7jNw8T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 441BAC2BCB3;
	Mon, 28 Sep 2026 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790603984;
	bh=C2Fe0MYJaMj1TO9k6t/S2y+fSC0s2SJC8TTMFZGWn+I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HM7jNw8TzG5zPMXw3FdSiEBUHY8DjZWU6dAUMHqUXW8yCoJL0aqvRHEw20SPWaUHZ
	 pIqxJhMwP92V+Kgm5Kc7jZcdSi8radfI2hvDKp8Gf6QoHX2v6EoZRv/bAJ3DJSC4h0
	 mW6x3PUAz6k045tXkNsjsxOnJ5T4kuszep/viVpwh3qWIPz0KOzaP9gWUUFfsE7oAE
	 lw2zUMa1TLAoNgMb5BUCDVy+x6zOMxaxdBqDj/yXpnoa88GL7vE1xVXafLaDiWTiQv
	 kW92oqn05AgVZGfI7F7hSAB5Ut2rIneKziU3lo47Ub+IWLUbQbxdEcwC6bcyHC8mlx
	 r16gI2St0HPNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2050CCA5FA2;
	Mon, 28 Sep 2026 13:59:44 +0000 (UTC)
From: Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org>
Date: Mon, 28 Sep 2026 07:59:44 -0600
Subject: [PATCH v3] usb: gadget: u_serial: fix NULL deref in gs_close()
 after failed open
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-u_serial-gs-close-null-v3-1-c688d93b4c49@gotenna.com>
X-B4-Tracking: v=1; b=H4sIAM9yumoC/4XNTQ7CIBAF4Ks0rB0D9I+68h7GGFqGlqSCgZZom
 t5d2pUujLN7L3nfLCSgNxjIKVuIx2iCcTaF/JCRbpC2RzAqZcIpr2jDKMy3bSFH6AN0owsIdh5
 HkILKIq/SoSBp/PCozXOHL9eUBxMm51/7n8i29i8ZGTBoZImiEC1Tuj33bkJr5bFzd7KhkX9Av
 P4J8QS1CpUua41Npb+hdV3fFR+/WQcBAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kuen-Han Tsai <khtsai@google.com>, 
 Prashanth K <prashanth.k@oss.qualcomm.com>, 
 syzbot+97aa71f55869d71bc94a@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Brian Ellis <brianellis@gotenna.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790603983; l=3583;
 i=brianellis@gotenna.com; s=20260910; h=from:subject:message-id;
 bh=nr2XdxRa87a7C3jXAfs1qnHiC4oajvF4Zv7whfXEp2I=;
 b=oKEpgUrb7WdSJkn86FX4RSIJG9R8343giM8IgMStYsDjHMhKgDLamU5C6ftPzv5J6BZELP1Xu
 IEiJ4vNdg8rDIrRtDYWvA4A5bZ3kTM2srfH0O8zB97UKE8JroeJp73l
X-Developer-Key: i=brianellis@gotenna.com; a=ed25519;
 pk=JciDR8ctfMqvKeRCDP8VPwNLUDULxCAqDum6H+/ByBY=
X-Endpoint-Received: by B4 Relay for brianellis@gotenna.com/20260910 with
 auth_id=1022
X-Original-From: Brian Ellis <brianellis@gotenna.com>
Reply-To: brianellis@gotenna.com

From: Brian Ellis <brianellis@gotenna.com>

gs_close() opens with

	struct gs_port *port = tty->driver_data;
	...
	spin_lock_irq(&port->port_lock);

and never checks port.  gs_open() assigns tty->driver_data only on the
port.count 0 -> 1 edge, so any failure earlier in gs_open() leaves it NULL,
and tty_open() calls tty_release(), and hence ->close(), when ->open()
fails.  Acquiring the spinlock is a write, so this faults outright rather
than reading garbage.

syzbot reproduces it on arm64 as a KASAN null-ptr-deref write at offset
0x74, which is port_lock within struct gs_port:

  BUG: unable to handle kernel paging request in gs_close
  KASAN: null-ptr-deref Write in gs_close
  Call trace:
   gs_close+0xac/0x65c      drivers/usb/gadget/function/u_serial.c:698
   tty_release+0x2c4/0xffc  drivers/tty/tty_io.c:1745
   tty_open+0x46c/0x89c     drivers/tty/tty_io.c:2146

Return early instead.  There is nothing to release when the open never got
far enough to claim the port.

Unlike the check reverted by commit f6c7bc4a6823 ("Revert "usb: gadget:
u_serial: Add null pointer check in gs_start_io""), this is not hiding a
race: the tty core calls ->close() for an ->open() that failed by design,
so driver_data is legitimately unset on that path.

Fixes: c1dca562be8a ("usb gadget: split out serial core")
Reported-by: syzbot+97aa71f55869d71bc94a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97aa71f55869d71bc94a
Cc: stable@vger.kernel.org
Signed-off-by: Brian Ellis <brianellis@gotenna.com>
---
Reported by syzbot (still open, with C and syz reproducers) and hit
independently on a downstream 6.6-adi BSP kernel, where gserial_free_line()
clearing ports[n].port makes the same path reachable.

Compile-tested against usb-linus with allmodconfig (CONFIG_USB_U_SERIAL=m).
Not boot-tested on mainline and the syzbot reproducer has not been run here:
the board this was hit on needs a vendor BSP device tree to boot.
---
Changes in v3:
- Restore the Reported-by:/Closes: syzbot tags and the KASAN trace. They were
  dropped from v1 and v2 in error when the commit message was rewritten. The
  report is still open, and without Closes: syzbot cannot associate this fix
  with it.
- Say why this differs from the check reverted in f6c7bc4a6823, since that
  revert's reasoning is the obvious objection here.
- Link to v2: https://lore.kernel.org/r/20260927-u_serial-gs-close-null-v2-1-bdedf57fe96f@gotenna.com

Changes in v2:
- Remove the comment above the check, rather than reword it as Prashanth
  suggested. The commit message already explains the path that leaves
  tty->driver_data NULL, so the comment only restated it. Happy to add a
  reworded one instead if that is preferred.
- Link to v1: https://lore.kernel.org/r/20260910-u_serial-gs-close-null-v1-1-9a5e848b1dfb@gotenna.com
---
 drivers/usb/gadget/function/u_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index cdd1dfc66..892d2673e 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -695,6 +695,9 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	struct gs_port *port = tty->driver_data;
 	struct gserial	*gser;
 
+	if (!port)
+		return;
+
 	spin_lock_irq(&port->port_lock);
 
 	if (port->port.count != 1) {

---
base-commit: be4219dd98608736e13e0b790ef742b76a13254d
change-id: 20260910-u_serial-gs-close-null-a80a436666e8

Best regards,
-- 
Brian Ellis <brianellis@gotenna.com>


