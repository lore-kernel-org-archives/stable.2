Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6ED3672AA;
	Thu, 10 Sep 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070050; cv=none; b=jheIbzEMxQ+wbxu3hff6lT9dWp7yyIITojCUH4Myp/yxI37y9OtFMn42wVOr7o0FZ6IHSRmbldaYZZmD/Zhsksnhyo+i7H1HaqohhTShJHopehLzNlft3Ua57sgwUL5YUtR0L/ldQk46EztDxkFolvw4xwwZDlzc4xeLDpmvMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070050; c=relaxed/simple;
	bh=G3FgjhmjeFD2HGgRcoAVakUIklX5/ERfE8Qmxt5XNfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KhuZhPCEhFz6VXzevPjgZ+6kHOygeUaKMN/zwQH38yPNQG/H9oos0M7tKRyL3ME/UwDMJYtyG9YoU+DBi6OeEDD0QIE3XRkq85o1J+K0SytgKeiYDiwi4BNbykeY5I259Uyf68niRxYix5wuVYlE2YmKKR4NoMR+RaOX9chhL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGJ1UgUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGJ1UgUA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACCACC2BCC7;
	Thu, 10 Sep 2026 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789070049;
	bh=G3FgjhmjeFD2HGgRcoAVakUIklX5/ERfE8Qmxt5XNfo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WGJ1UgUA5oh1nKEj2B+NESRhfWXSRVyLZumxUClEv9aMlqtxuHv0PkJAexVyOsjhZ
	 iRWD2ctUFHpYeAdP9HMC8tQcM0NkNnmnoosjcuhja+BDh7msxVaGAmOt0yRFARS7Rt
	 qqfmfIz6wN9iGxbZbhncS++Eod0BYnTovdn4JumMFWL3pqhYhwdZRHlX2d+1hOR7mX
	 4hLY3ZYs0Jr14b+fjw12LaxVFxBRBKDWR1vVBMqbqJUcLo9tPegyAvH2f06JJjRnVo
	 ToBODGY8KKmxfZG+W3kgxtrVhr0/zsmRXJjCrP450L4kfMRzsF9IRoTOhPn317JN5S
	 1BqgCWCU68MuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D9BC88E42;
	Thu, 10 Sep 2026 19:54:09 +0000 (UTC)
From: Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org>
Date: Thu, 10 Sep 2026 13:53:59 -0600
Subject: [PATCH] usb: gadget: u_serial: fix NULL deref in gs_close() after
 failed open
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-u_serial-gs-close-null-v1-1-9a5e848b1dfb@gotenna.com>
X-B4-Tracking: v=1; b=H4sIANYKo2oC/x2MQQqAIBAAvyJ7bkErovpKREhttSAaLkYQ/T1rb
 nOYuUEoMgn06oZIJwsHn8UUCubd+o2Ql+xQ6rLRndGYpq+wDjfB2QUh9Mk5tK22ddVkqIUcH5F
 Wvv7xMD7PC/YgSY1oAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kuen-Han Tsai <khtsai@google.com>, 
 Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org, 
 Brian Ellis <brianellis@gotenna.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789070049; l=2951;
 i=brianellis@gotenna.com; s=20260910; h=from:subject:message-id;
 bh=elm183E8ARQLqVNCj2uC/Zn4AQumLckjzIgt6S1EnX0=;
 b=6fsaZbzfuwEtD5Xr3Gvzr3qRhjpR4OxD/mPqG7UrV+ekUxg3qGiM/kayiEUntWUnUkKA2Sg+o
 sjH+Mu9jzQqA+4jhG/oFJf93J+k63j1lchrThYPfFdJ8Sa0XbYrWcpe
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
 drivers/usb/gadget/function/u_serial.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index cdd1dfc66..5bbb4d04b 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -695,6 +695,13 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	struct gs_port *port = tty->driver_data;
 	struct gserial	*gser;
 
+	/*
+	 * tty_open() calls tty_release(), and hence this, when ->open()
+	 * failed before gs_open() had set tty->driver_data.
+	 */
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


