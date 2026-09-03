Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86A4A6CD0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440118; cv=none; b=E213j0xxS8J6/GLvvgCL1vGa2mHRJsK5E+XNIV9ORWN1qXRjRhPDseCMAuglyYcZ/xsfiDV3vTInc+ul2pfTml9HwVOeZqRTohgCoLJ89qehvBxAMpWZXQxN0UU9e46jiAXMkdNiyq2ir1pzVfma/GpkUfMd+wO7jSe2ATWcLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440118; c=relaxed/simple;
	bh=Vk9dACJ5yNI7vrTmZTS/FmZ7Y39sAqNYDtnauoybGFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LhoL8knoDWNTTLuSMxtcLtflorwCS+pGKRRvbo47ZLcarKROoPv6DEf5ltK4t00JzeKC8ESulx0DH8sWX4kOfDalNofThNT3wySkBwKxOQKhR5u50aYIZp7UNjLX7QRfBvSyuelXhtDoP61mPbZ00I1k/XU8NlTJDOThGtdgUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F992+IqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F992+IqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B01F000E9;
	Thu,  3 Sep 2026 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440116;
	bh=+F3IlRiUN4TGMAOV7dIRv1T5ZHhgVBhYc8ElrzXHhEk=;
	h=Subject:To:Cc:From:Date;
	b=F992+IqRk+VfnuljkLYjpHljHtmEWVECEvNMCTGOMixQu/SCoJoF0Qu19c+MMdHYJ
	 wIR4DCZVrzFzDI/hrkpHAEnOKvuH23N2YkNhbHkYJfPSRhOJSQ9wWDReDTunMHJhZs
	 KY62ZAuQxJSK0JXE2pfI9ARNQ582DbNRjzzbGHTY=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command" failed to apply to 5.10-stable tree
To: huangwei@kylinos.cn,boddah8794@gmail.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:40:09 +0200
Message-ID: <2026090309-kelp-viewer-b3c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x eb4573cf2fd860b20adfae050c3f6ec6ddc3abdb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090309-kelp-viewer-b3c3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb4573cf2fd860b20adfae050c3f6ec6ddc3abdb Mon Sep 17 00:00:00 2001
From: Huang Wei <huangwei@kylinos.cn>
Date: Wed, 5 Aug 2026 16:57:25 +0800
Subject: [PATCH] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command
 completion

The synchronous command completion path in ucsi_sync_control_common()
hardcodes a 5 second (5 * HZ) timeout when waiting for the PPM to signal
command completion via ACPI notification. This value matched
UCSI_TIMEOUT_MS when it was still 5000 ms, but it was not updated when
that macro was later raised to 10000 ms to fix PPM reset timeouts.

As a result, the two PPM communication paths are now inconsistent: the
polling path in ucsi_reset_ppm() respects the 10 second timeout, while
the event-driven completion path still uses 5 seconds. On machines where
the firmware is slow to respond during boot (e.g. some Lenovo ThinkPad
models such as the E14 Gen 7), commands sent after the PPM reset, such
as SET_NOTIFICATION_ENABLE and GET_CAPABILITY, can exceed 5 seconds and
cause UCSI initialization to fail with:

    ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

Once UCSI init aborts, USB-C PD negotiation never completes, which in
turn blocks USB-C dock enumeration since the dock depends on a successful
PD contract.

Replace the hardcoded 5 * HZ with msecs_to_jiffies(UCSI_TIMEOUT_MS) so
that both communication paths share a single, consistent timeout value,
and future adjustments to UCSI_TIMEOUT_MS are picked up automatically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221740
Link: https://bugzilla.kernel.org/show_bug.cgi?id=2183790
Fixes: bf4f9ae1cb08c ("usb: typec: ucsi: increase timeout for PPM reset operations")
Cc: stable@vger.kernel.org
Signed-off-by: Huang Wei <huangwei@kylinos.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Fedor Pchelkin <boddah8794@gmail.com>
Link: https://patch.msgid.link/20260805085725.389761-1-huangwei@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ecbda2a3783c..bef3f9b71d71 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -91,7 +91,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci,
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+	if (!wait_for_completion_timeout(&ucsi->complete,
+					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:

