Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6015625EB;
	Wed, 14 Oct 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996210; cv=none; b=YtUwJ/5p0A7TzOHuUQFvoWgf3LfrpE+maRRH/2KhfDWPoxnXxywrhjtUvHBbR0/0kzB8QPmt4fqSn2zknsfuB7v6i/T1NltJ90YhCwS/ambJKg7VNxDr7a3zLR7JOM2jmn7jBtftHLe9aGYM4gYjKjHSSplNG+ZNft33L7nbPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996210; c=relaxed/simple;
	bh=xV3YYzgiHKNYv4ZsS8U0n7c7XhEmcNEyuf7arRai0qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PXE5XjCc5l0uA9t45jZw50pojNjGwSMxfN8laTMvky6USAUQbUg7eorUgNYxbGNmu35+bq+EsPcxhI+l3FaYPQYdQrF+QiSEZznmIqPU2vBmyKBEUYJkcV/yysUvkqDKhlOLl5CYNI+82hquEt0SyxDTr+6sstyp3lfA4syBG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOD/ewOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOD/ewOb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B60B0C2BCC7;
	Wed, 14 Oct 2026 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791996209;
	bh=xV3YYzgiHKNYv4ZsS8U0n7c7XhEmcNEyuf7arRai0qE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TOD/ewObUfVCU7M2AN5PF+bNlZ2Ksh2xs1e3QLIhS1UIrFXcKartL+ctPKPCXV0Oy
	 R2ca7BXa4YB6iryJcXqWgduSPjZlVYmL3DNrmwoD3zWYHbJ6JyGODg01vJyLhLWjoN
	 weydsL3rDlOdP/s5pvQlyVxuRpk9giP79+3UxJXZjnJH5DDGS11/DBluklWnE2u95d
	 ccs9iWOkyk/QG6OGaNrfTnwzdxpjp7mzBBSUM0V+7e6gZe2p1QmyMBrkaRBpDe+rCL
	 hGE4jUn19h/V2KfhchRGUpx5sxhizgJ/5wPrXyvdgiqxhLHMdxC0GIToLXNImACp8f
	 ya6unDeUJnjjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9170ACC6B2D;
	Wed, 14 Oct 2026 16:43:29 +0000 (UTC)
From: Phil Rosenthal via B4 Relay <devnull+phil.phil.gs@kernel.org>
Date: Wed, 14 Oct 2026 12:43:29 -0400
Subject: [PATCH] serial: core: Shut down a suspended port on removal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-serial-remove-suspended-v1-1-fda644ab5f89@phil.gs>
X-B4-Tracking: v=1; b=H4sIADCxz2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0MTXZD6xBzdotTc/LJU3eLS4oLUvJTUFN2URHNz46RkI4uUZFMloO6
 CotS0zAqwydGxtbUARzE2PGkAAAA=
X-Change-ID: 20261014-serial-remove-suspended-da773bc28dc5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Igor Putko <igorpetindev@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, Phil Rosenthal <phil@phil.gs>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996209; l=3532;
 i=phil@phil.gs; s=20260718; h=from:subject:message-id;
 bh=yrEleuf8PDdDURngAqAjAHzp6HlswgNm82AG2coKGik=;
 b=WIVLdFyRwPAk6R38h+U3YX1ARJdv/nYj/MQzysE1oPHuXitVhz/MT8sSoNwSqP2A+nc/ZLyKm
 pwhp+y3ABi/AUG1wa6hLv33oD1ZsEZBfxhAboOtVD4TAB/KrJy+4SwY
X-Developer-Key: i=phil@phil.gs; a=ed25519;
 pk=08BMg1YPtTS5NnKn5I1Mq1ra3MdAg49Awe6OjrC59fs=
X-Endpoint-Received: by B4 Relay for phil@phil.gs/20260718 with auth_id=881
X-Original-From: Phil Rosenthal <phil@phil.gs>
Reply-To: phil@phil.gs

From: Phil Rosenthal <phil@phil.gs>

Commit 810d467c11f0 ("serial: core: shut down initialized port on
removal") calls uart_shutdown() from serial_core_remove_one_port() only
if the port is initialized.  A port that is removed while suspended is
not: uart_suspend_port() clears its initialized flag, sets its suspended
flag and keeps its transmit buffer.  Nothing clears the flag or frees
the buffer on removal, so both stay in the line's uart_state.

If the line is reused, the next uart_resume_port() for the new port
finds the suspended flag set and starts the port up although nobody has
opened it.  If the uart_driver is unregistered instead, the buffer is
leaked, as uart_unregister_driver() does not free it.

Call uart_shutdown() whether or not the port is initialized.  For a port
that is not initialized it leaves the hardware alone, and it always
clears the suspended flag and frees the transmit buffer.

Fixes: 810d467c11f0 ("serial: core: shut down initialized port on removal")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-164404@kernel.org
Assisted-by: LLM sparse
Signed-off-by: Phil Rosenthal <phil@phil.gs>
---
Greg asked for this as a follow-up to 810d467c11f0 in the thread on my
duplicate of that fix [1].

Tested in a QEMU guest on tty-next 8db79ea07a67 with KASAN.  To remove
a port while it is suspended, a test module registers a polled 8250
platform port, which becomes the console, and after the port has been
opened and closed it calls serial8250_suspend_port(), as a system
suspend would, and then removes the port.  It prints the line's
uart_state before and after removal:

  810d467c11f0 alone (on tty-next 36844ea19656):
    before removal: initialized=0 suspended=1 xmit_buf=allocated
    after removal:  initialized=0 suspended=1 xmit_buf=allocated

  With this patch:
    before removal: initialized=0 suspended=1 xmit_buf=allocated
    after removal:  initialized=0 suspended=0 xmit_buf=NULL

The cases 810d467c11f0 fixes still pass: an 8250_pci port with INTx
unbound after its console was opened and closed (IRQ freed, rebinding
restores the console and getty), and a polled MMIO console port removed
after being opened and closed.  A port held open across removal and a
console that was never opened also still work.  W=1, sparse and
checkpatch --strict are clean.

Not tested: removal during a real system suspend.  What happens on a
reused line at the next resume is from reading the code.

[1] https://lore.kernel.org/r/2026101433-refuse-unbiased-4b63@gregkh

AI assistance: an LLM coding assistant (Claude, model claude-opus-5-5,
in Claude Code) wrote the patch and the test module, and built and ran
the test kernels.  I reviewed it.
---
 drivers/tty/serial/serial_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9eea8d1a0e8a0e60d8af9b56c917954f5dc45f0e..a234217487d3718ae5e9c533112c2020a3aca946 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3246,9 +3246,7 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 
 	scoped_guard(mutex, &port->mutex) {
 		port->console = false;
-
-		if (tty_port_initialized(port))
-			uart_shutdown(NULL, state);
+		uart_shutdown(NULL, state);
 	}
 
 	/*

---
base-commit: 8db79ea07a67b126c773da6efdc00066000daeb8
change-id: 20261014-serial-remove-suspended-da773bc28dc5

Best regards,
-- 
Phil Rosenthal <phil@phil.gs>


