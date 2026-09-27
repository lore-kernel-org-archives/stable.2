Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB83B2FD9;
	Sun, 27 Sep 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526945; cv=none; b=ARDw5JT2FD6MLfpCUgfdGpJkjmueFMGSNBWbP1CId7LREPe+vsiXESNcKnlIrSeG1u8Fh5zzvTGh9PgCJqaRsVaXLKDRxUJZS4o8P96vaTAsloLDRf0qKXqlvAnTYM7GQfUpRwZBKXHZZMvJZn3uW0kGMUEiBu7bcDQRyAAPukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526945; c=relaxed/simple;
	bh=Bh4eqpjlXYZJnktfb6bIA8/7sjOl3WFlNWua6nYXIIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BNa2s6FRy8upKhDiUoU6Y1k9EKcPt+4u1kUCzb3o1Ews8ADcT6VSc+wihoMg6Vf1vdmUt/K+sxEuWnba6rDVyzOe8PdAPUXrd7gtRTTRNyR5s9MNreFD2SNHL7LHi7fCF1Tr4RiyuOQ2Dx9sHBjlLYSpE4+8vlLTw2ktf5q5zKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6wNIx6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6wNIx6G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD4BBC2BCF4;
	Sun, 27 Sep 2026 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790526944;
	bh=Bh4eqpjlXYZJnktfb6bIA8/7sjOl3WFlNWua6nYXIIg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Z6wNIx6G+1IzwqCf1wmwRPHE2Iu4/T73fG+VYOwC+FKMcmT3CHZE4ZZDSOBco0SKi
	 vSbqU9+TDDIGPZt7slABHtS9FKERqYubrfExFPpCLKuEE0KgizfUG0NRkxf+531wGu
	 lrmaPWGQUHgYCkyKfjQxS3TH+04Mt6Bm7twvzMzZX3XaZ7gzHh+NbBwKe/NCgVLZ2p
	 RuRCQNHdR5gxuX+8RgwvCFsV6tJhtbE5zE/QZ37ITrlKOTmj3kZEAqu8KefP75uMqH
	 CpolIcqcOSBZlO30zjkobRxRdD5coqSbKJiUzRtevOlL4N0oQ+C7NDOTWWE9i4Achz
	 ZlqgNwr78ebxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43BBC9832F;
	Sun, 27 Sep 2026 16:35:44 +0000 (UTC)
From: Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org>
Date: Sun, 27 Sep 2026 10:35:45 -0600
Subject: [PATCH v2] usb: gadget: u_serial: fix NULL deref in gs_close()
 after failed open
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-u_serial-gs-close-null-v2-1-bdedf57fe96f@gotenna.com>
X-B4-Tracking: v=1; b=H4sIAOBFuWoC/4WNQQ6DIBREr2L+ur8Bag121Xs0pkH9IgmFBpS0M
 dy96AU6uzfJm9kgUjAU4VZtECiZaLwrIE4VDLNymtCMhUEw0bCWM1yfu6Es6oiD9ZHQrdaikkz
 Vl6aEJBT5HWgyn2P40RWeTVx8+B4/ie/t38nEkWOrriRr2fNx6u/aL+ScOg/+BV3O+QcaJtuEv
 gAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kuen-Han Tsai <khtsai@google.com>, 
 Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org, 
 Brian Ellis <brianellis@gotenna.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790526944; l=3198;
 i=brianellis@gotenna.com; s=20260910; h=from:subject:message-id;
 bh=zsIlMAuOeo/QnHXqKOHJz0TaS0Y3etnOytR55Awk234=;
 b=UbZHsXI/07D4SVkdfqO4AceRih61lDgprVhAzuVohFqBwIu/HErZdHfTUTj+AcSf+1L7324TZ
 ePzkmRDf0ZDCzp6lQvskMcXKgpTsdt6TaA2MpIAiJB0E2nXHjR9DCJH
X-Developer-Key: i=brianellis@gotenna.com; a=ed25519;
 pk=JciDR8ctfMqvKeRCDP8VPwNLUDULxCAqDum6H+/ByBY=
X-Endpoint-Received: by B4 Relay for brianellis@gotenna.com/20260910 with
 auth_id=1022
X-Original-From: Brian Ellis <brianellis@gotenna.com>
Reply-To: brianellis@gotenna.com

From: Brian Ellis <brianellis@gotenna.com>

gs_close() dereferences tty->driver_data without checking it:

	struct gs_port *port = tty->driver_data;
	struct gserial	*gser;

	spin_lock_irq(&port->port_lock);

but gs_open() assigns tty->driver_data only after two error returns:

	if (!port) {
		status = -ENODEV;
		goto out;
	}
	...
		status = kfifo_alloc(&port->port_write_buf,
				     WRITE_BUF_SIZE, GFP_KERNEL);
		if (status) {
			...
			goto out;
		}
	...
	tty->driver_data = port;

and when ->open() returns an error the tty core calls ->close() anyway:

	if (tty->ops->open)
		retval = tty->ops->open(tty, filp);
	...
	if (retval) {
		tty_debug_hangup(tty, "open error %d, releasing\n", retval);
		tty_unlock(tty); /* need to call tty_release without BTM */
		tty_release(inode, filp);

So opening /dev/ttyGS<n> for a port that has already been freed, or when
the write-buffer allocation fails, oopses in gs_close().

This is not the situation commit ffd603f21423 ("usb: gadget: u_serial: Add
null pointer check in gs_start_io") was reverted for. That check was
redundant because gs_start_io()'s callers are required to hold port_lock
with port.tty and port_usb non-NULL, and the dereference it hid was a race.
Here the NULL is not a race: the tty core deliberately calls ->close() for
an ->open() that failed, as its own debug message says, so driver_data is
legitimately unset on that path and every tty driver has to tolerate it.

Fixes: c1dca562be8a ("usb gadget: split out serial core")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Ellis <brianellis@gotenna.com>
---
Found on a downstream 6.6-adi BSP kernel, then confirmed present in usb-linus
by inspection: gs_close() still dereferences tty->driver_data unguarded, and
gs_open() still assigns it only after its error returns.

Compile-tested against usb-linus with allmodconfig (CONFIG_USB_U_SERIAL=m).
Not boot-tested on mainline: the board it was found on needs a vendor BSP
device tree to boot, so the argument here is from source, with both halves
quoted in the commit message.
---
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


