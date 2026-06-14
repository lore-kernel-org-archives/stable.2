Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21724A078
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417145; cv=none; b=i5wf+forVXylrWfiqJ06wHt7OpvxtL8zYzFkP0C5rjvHQ7qyl+X52Fnqg7RNos3Ot3vVX2O3K5iH7oKy2kHqm3GbzT9hVlauGc0T3k6Z249w8IJhyvgNcTNPj1t9Q0ifaxeahguEXNuk7tr/GX8lTnR5EzU1WA15/h18tZ0AcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417145; c=relaxed/simple;
	bh=eFr0PrQViiQGGMG/Ffyp5XuNr3dzKhhQxtZ3h8LSAp0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=rJAvHGxGrYZEwr9u2jtlt4s3Uq3XPz0PtaRKlcjzWNnzWrFF0tzPZ3PUpp/UNRqGNfD6O5igcgp4J/9jCSWDKkIFBqg7ScbdDsTy6yd/F2eKH8+s7qNsgxS0jCzWoegzazeT0YDcEtdz0c1oq1H/BwY08ywCesU37QwO/ZTmaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SNx943y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SNx943y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22481F000E9;
	Sun, 14 Jun 2026 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417144;
	bh=ZuMxsQlXOPq0IS1stKbgyu27ryCl34xHsQhYwr8eYB0=;
	h=Subject:To:From:Date;
	b=SNx943y80TZmmyah+QfuYoGA86JQ7XMDG8Zr26NlvWRRgEpoCPl0h5YXXUeodDcpZ
	 jK3Khxx1OHXsIXoJT5fr8zTXNoY4526VFALnj/weJkWf/NkVup0yUTvZcVTHQSycBH
	 asOdm+5c2z/ERUoo78pIcSbCbStX9PdYgI10Eb7I=
Subject: patch "iio: adc: ad_sigma_delta: fix clear_pending_event for registerless" added to char-misc-next
To: radu.sabau@analog.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:42 +0200
Message-ID: <2026061442-size-cusp-fc41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad_sigma_delta: fix clear_pending_event for registerless

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 91bc6767a4f55dc470d8a56b55b9f2ea09094efe Mon Sep 17 00:00:00 2001
From: Radu Sabau <radu.sabau@analog.com>
Date: Wed, 27 May 2026 12:38:39 +0300
Subject: iio: adc: ad_sigma_delta: fix clear_pending_event for registerless
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ad_sigma_delta_clear_pending_event() falls through to the status register
read path for devices with has_registers = false and no rdy_gpiod. For
such devices, ad_sd_read_reg() skips the address byte entirely and clocks
raw MISO bytes with no address phase — making it byte-for-byte identical
to reading conversion data. If a pending conversion result is present,
this partially consumes it and corrupts the data stream for the subsequent
ad_sd_read_reg() call in ad_sigma_delta_single_conversion().

Furthermore, with num_resetclks = 0 on these devices, data_read_len
evaluates to 0. If the clocked byte has bit 7 clear, pending_event is set
and the code attempts memset(data + 2, 0xff, 0 - 1), overflowing to
SIZE_MAX and corrupting the heap.

Fix by returning 0 immediately when neither rdy_gpiod nor has_registers
is set. This is safe for all current registerless devices: ad7191 and
ad7780 (with powerdown GPIO) are reset between conversions by CS
deassertion, so there is no stale result to drain; ad7780 (without
powerdown GPIO) and max11205 are continuously-converting and cycle ~DRDY
at the output data rate regardless of whether the previous result was
read, so the next falling edge fires naturally.

A future registerless device that holds ~DRDY asserted until data is read
would be broken by this early return and would require either
num_resetclks set or a rdy-gpio.

The same heap corruption is reachable on any device with rdy_gpiod set
but num_resetclks = 0: if the GPIO indicates a pending event, the drain
path executes memset(data + 2, 0xff, 0 - 1) regardless of has_registers.
Add an explicit data_read_len == 0 guard after the pending event check;
the stale result is then consumed by the first ad_sd_read_reg() call in
ad_sigma_delta_single_conversion().

Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready signals")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 651ade67ad2e..1b410291da53 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -262,11 +262,25 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 
 	/*
 	 * Read R̅D̅Y̅ pin (if possible) or status register to check if there is an
-	 * old event.
+	 * old event. For devices with neither an RDY GPIO nor registers,
+	 * ad_sd_read_reg() transmits no address byte and clocks raw MISO bytes,
+	 * which is indistinguishable from reading conversion data and would
+	 * partially consume a pending result. Skip the check for such devices.
+	 *
+	 * This is safe for all current registerless devices: ad7191 and ad7780
+	 * (with powerdown GPIO) are reset between conversions by CS deassertion,
+	 * so there is no stale result to drain; ad7780 (without powerdown GPIO)
+	 * and max11205 are continuously-converting and cycle ~DRDY at the output
+	 * data rate regardless of whether the previous result was read, so the
+	 * next falling edge fires naturally.
+	 *
+	 * A future registerless device that holds ~DRDY asserted until data is
+	 * read would be broken by this early return and would need either
+	 * num_resetclks set or a rdy-gpio.
 	 */
 	if (sigma_delta->rdy_gpiod) {
 		pending_event = gpiod_get_value(sigma_delta->rdy_gpiod);
-	} else {
+	} else if (sigma_delta->info->has_registers) {
 		unsigned int status_reg;
 
 		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
@@ -274,11 +288,24 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 			return ret;
 
 		pending_event = !(status_reg & AD_SD_REG_STATUS_RDY);
+	} else {
+		return 0;
 	}
 
 	if (!pending_event)
 		return 0;
 
+	/*
+	 * With num_resetclks = 0, data_read_len is 0 and the drain sequence
+	 * below would compute memset(data + 2, 0xff, 0 - 1), underflowing to
+	 * SIZE_MAX and corrupting the heap. There is no safe way to drain the
+	 * stale result without knowing the data register size; it will be
+	 * consumed by the first ad_sd_read_reg() call in
+	 * ad_sigma_delta_single_conversion().
+	 */
+	if (!data_read_len)
+		return 0;
+
 	/*
 	 * In general the size of the data register is unknown. It varies from
 	 * device to device, might be one byte longer if CONTROL.DATA_STATUS is
-- 
2.54.0


