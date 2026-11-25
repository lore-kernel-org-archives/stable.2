Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609485;
	b=PAXwKR0pXCNqA+BWpLBNaIITKbsS2D2o++buP7AaUqft49b6l0uFinqI0Ee+BMFaYQEY
	 YrVYsPqyi0QZ3SNlzvap6LoCA1gbdgdESTz0azG7oKrbUdPLGp6nxIKw9MxXL3ZuG0of2
	 SqaxitUyU7oA+1XZ0N1ET48bIgIFOlhdT3Z9CaYe4idG+GPKIirTdR64srbriPQ3WKjWL
	 nxDG8MD5K++jhuyLuKHHosCuo0xGOb4bqG5KFuziIYA5Cfgw8HYHXZW+pH/vqAcSwm6qU
	 tNzlfWHw2AJqgDku6K71aV1ooyW/gMsTblyoS7qV6rnhUgQAkYMCOdT0lHskJyJE8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609485;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CnzKQfGd+iKyaPOokjwyVtiS6w06axVYZ3iH7BuYJL0=;
	b=zqW8YbjlAHjeK/QHiL7Odlcc9hjXLEGmrd3kTgDv4atEsUiOAKwKed8OKHY0/BQ2qxyf
	 s1E+PJZCL+kranv+qxIroqXSwhK7Yynpu10EkGKz0oMfC6pP2FexqzyzeFfKMK3ogNgrf
	 DOr33jBAymo9UHtoxwuK+UyPgImQXShX86m0YTU3nDNrizGGEcYvhawMpXjcxoh6ltDKx
	 j+aHeSoKU9iF6PI/i6EZIA7BSFeW7PWvnbRRNh36HLVokH3L55b3hOc5OQP9vaHaOSMAU
	 9MqdR+LJHYvzhTrfkAGiWp0D+1h0hZw517PTlLgXDr50mNBh5PmhOSVl/TJgxhHKK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZzEzl0pP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9E606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZzEzl0pP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA31F000C0;
	Wed, 25 Nov 2026 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609485;
	bh=CnzKQfGd+iKyaPOokjwyVtiS6w06axVYZ3iH7BuYJL0=;
	h=Subject:To:Cc:From:Date;
	b=ZzEzl0pP7zEYADJ8jsYlh1FpL8m9flVC0G9pfXvUZmK/nwurBmXedDYZWiFiBlsL7
	 eL26Mkgml4ZUY9aGgqwTNdle8Uwr3aAhx5QDflruDVvOovFUSi1xoDn+f89ixrf5Na
	 K0c9wWikRGgcD3B5fR4hl1mSDCjPRGrwMhJn+xOU=
Subject: FAILED: patch "[PATCH] iio: inv_sensors: prevent timestamps going back in time in" failed to apply to 6.18-stable tree
To: jean-baptiste.maneyrol@tdk.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:22:38 +0100
Message-ID: <2026112538-browse-ascertain-b38c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3785dffc7c68751a8429ae6dd75804c14a5a7c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112538-browse-ascertain-b38c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3785dffc7c68751a8429ae6dd75804c14a5a7c7a Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Tue, 20 Oct 2026 17:26:00 +0200
Subject: [PATCH] iio: inv_sensors: prevent timestamps going back in time in
 transitions

Ensure when computing first timestamp and when applying odr change,
that the next timestamp will not be lower than the previous one.

This way there is no risk to have a timestamp going back in time, meaning
being lower than the previous one. It already can never happen without
a transition because we are generating timestamps by adding the period
to the last timestamp.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 8c9e81a77e68..9040da80f0c7 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -133,10 +133,15 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		return;
 
 	/* no previous data, compute theoretical value from interrupt */
-	if (ts->timestamp == 0) {
+	if (!ts->init) {
 		/* elapsed time: sensor period * sensor samples number */
 		interval = (s64)ts->period * (s64)sample_nb;
-		ts->timestamp = timestamp - interval;
+		delta = timestamp - interval;
+		/* prevent next timestamp to be lower than the last one */
+		if ((delta + ts->period) > ts->timestamp)
+			ts->timestamp = delta;
+		ts->init = true;
+
 	}
 
 	/* update delta timestamps and estimated period */
@@ -184,7 +189,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no)
 {
-	s64 interval;
+	s64 interval, timestamp;
 	u32 fifo_mult;
 
 	if (ts->new_mult == 0)
@@ -207,7 +212,10 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 		fifo_period = fifo_mult * ts->chip_period.val;
 		/* computes time interval between interrupt and this sample */
 		interval = (s64)(fifo_nb - fifo_no) * (s64)fifo_period;
-		ts->timestamp = ts->it.up - interval;
+		timestamp = ts->it.up - interval;
+		/* prevent next timestamp to be lower than current one */
+		if ((timestamp + ts->period) > ts->timestamp)
+			ts->timestamp = timestamp;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_apply_odr, "IIO_INV_SENSORS_TIMESTAMP");
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index 4f08204ede3b..91690778ae88 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -66,6 +66,7 @@ struct inv_sensors_timestamp {
 	u32 new_mult;
 	u32 period;
 	struct inv_sensors_timestamp_acc chip_period;
+	bool init;
 };
 
 void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
@@ -94,7 +95,7 @@ static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
 	ts->it = interval_init;
 	ts->delta = interval_init;
 	ts->delta_counter = 0;
-	ts->timestamp = 0;
+	ts->init = false;
 }
 
 #endif

