Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEC3806AD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189693; cv=none; b=BWu1wIIBPUbBSa0hDAn7BDip2EkV6/wgWp0yvEXy5+gfb7pUJ7Se+O1emlab320eMFtFe+f0jVcgFUkKJC7byQjnq+bMS1LwvL8axamM34wnmBjLhBUBT0UfZHexG1KBfIQaZFNTnyqJRGqxGmrGIvFUXqIxAzL2/jCvjZMBu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189693; c=relaxed/simple;
	bh=jJGYjuHozBIa2PjKG6skxIUxIPL1vSk3h144hcyqIjQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fnybA0dAphYsCN48vUOY9bAxZ806eHmJwhZBRHTCnYnJV56yZ0F3k6+wHqBteowV1aKf+b8Huh7ytU/zKbSxXRWMfMAw6NN/RXqhYe0QA+FTpgItoe9hVvW+Gatsrm0CqBI9iDzVVgpbv5hzGdxFPOQe8bC/ZE38LU77XKf7wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Koq86tfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Koq86tfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD2B1F000FF;
	Mon,  5 Oct 2026 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791189689;
	bh=CndVXo2xvtYrOrMLFOGchqtdHPzXxXeX5N5FUB5x7u4=;
	h=Subject:To:Cc:From:Date;
	b=Koq86tfASeLcTZWD/81wYVoVc9mSH0wRPF5mBiTNzZNB6K8FdXcRmharFqdEZwisu
	 MmMrrv7RAVDm3oIrH2GRmGyOnYKXcXQrVaYCIikNQQYR7m/P7q66+DNnce7xjaNlpB
	 uFh0mwGkp3E3KATRLAPHn8Tj4a61nOOEiy6W26Hk=
Subject: FAILED: patch "[PATCH] usb: octeon-hcd: fix the FIFO-flush timeout computation" failed to apply to 5.15-stable tree
To: orgads@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:41:26 +0200
Message-ID: <2026100526-seizing-camping-01bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4c7a1b9f1f1979f2b3b69428ada12680695159c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100526-seizing-camping-01bc@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c7a1b9f1f1979f2b3b69428ada12680695159c2 Mon Sep 17 00:00:00 2001
From: Orgad Shaneh <orgads@gmail.com>
Date: Tue, 1 Sep 2026 19:30:27 +0000
Subject: [PATCH] usb: octeon-hcd: fix the FIFO-flush timeout computation

cvmx_wait_tx_rx() computes its 100us deadline from
(u64)octeon_get_clock_rate - the address of the function, not its
return value; the parentheses have been missing since the
CVMX_WAIT_FOR_FIELD32 macro became a function. The cast makes it
compile silently, and the resulting deadline is effectively infinite.

On a healthy controller the flush bit clears on the first read and
nothing is noticed. On a controller whose PHY did not come up (for
example when the reference-clock configuration is wrong for the board),
txfflsh/rxfflsh never clear and probe spins forever in __delay() -
observed as a hard hang with a soft-lockup splat on a CN5020 board,
where the board watchdog then resets the system with no console output.

Call the function, restoring the 100us timeout the code always
intended.

Fixes: 3e195a80e096 ("Staging: octeon-usb: Replaces CVMX_WAIT_FOR_FIELD32 macro with a function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
Link: https://patch.msgid.link/20260901193100.1352110-1-orgads@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/octeon-hcd.c b/drivers/usb/host/octeon-hcd.c
index 34ce771fa0f5..7d121909f514 100644
--- a/drivers/usb/host/octeon-hcd.c
+++ b/drivers/usb/host/octeon-hcd.c
@@ -578,7 +578,7 @@ static int cvmx_wait_tx_rx(struct octeon_hcd *usb, int fflsh_type)
 	int result;
 	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
 	u64 done = cvmx_get_cycle() + 100 *
-		   (u64)octeon_get_clock_rate / 1000000;
+		   (u64)octeon_get_clock_rate() / 1000000;
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {

