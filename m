Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610792;
	b=pS2Uovonz1HN/Sh8gDFW4HscfYlz7+ipp/pssZCAQD5RbHot4+mjSotvVHpkSTUMTRce
	 gzbjI1yRKgh+0SiSrNPayw+rHGrA07qvsrAWlzJq5mYYWzeuQkpKEM2iLRYXooMMiFAyV
	 KLzL0EeNjhmDvB+8oIGjtsQz2ITeTVJyWvYMY2axo15BDkOxvu+Wa6gt3eXaA2EG7twtZ
	 X3Zz2/ExMu5w9KsCUUK8g4R3PaoGioWWtEN04a7jNdfiliJ/cNxTnGbN5LRRVAvNPiW2u
	 DJgM6Usou+I0j2tsTHUlK+P52csMUbUNV8P8wCKndblwWTVSSnyPn5cZFFIupDzbpiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610792;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KpTWxqb/XSJnRhaDAOMI0fK+AHJdTShdoAacQZSqxFc=;
	b=5UNIYxv6abClUse6y5FwUpLX2jp7RcMtqmPtH6TT+7bAbCpEIUtNjrCR88ob1aIfijDP
	 aY4bxeOi3TlUyFrTQMLZBqAflBLQs/bmXMW5L4llUxnDp15lauSxdp0i7/CNuKuCsqYsJ
	 BgOqf24KD1RJS+j4AVN+XGk9G8gTauvfLPkLzUIxpSwMZAYvk/gKGaOAvP9HGO5aKOXTT
	 jgIB6sTEdPxz2Yug1vY06/1dlfUk6IymgWpAnAwz9fjbSuwJnrp6Ok6zDp/I+0nQR50x+
	 Ao/+0x0nziAHccGeT8y9m4tlPZOvdtXbXPtDcV0ixm7k+pdtSOi3d4du/XRcUhyHe1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ESREMi1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CD606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ESREMi1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F651F000C6;
	Wed, 25 Nov 2026 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610792;
	bh=KpTWxqb/XSJnRhaDAOMI0fK+AHJdTShdoAacQZSqxFc=;
	h=Subject:To:Cc:From:Date;
	b=ESREMi1X10kpMj/q9TNFHqnYW5uHSgiZ7i5nw4RU73BiVifGe18a//5X+oprfB4RL
	 w5bTialOeyCueV06t4grL29RaJCR1XtmnE571lR2mmtIjaSdIsE2Tfa/psEDfBGZVM
	 ySoWYvbNSkrRo1h1RTUsxoFf6TVS77N8jOJWhBO4=
Subject: FAILED: patch "[PATCH] iio: proximity: sx9500: ignore event config writes that don't" failed to apply to 6.12-stable tree
To: kapoorarnav43@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:40 +0100
Message-ID: <2026112540-drainpipe-glamorous-4154@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9165906597b69a46fabf39ab41690721ebe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-drainpipe-glamorous-4154@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8ed9165906597b69a46fabf39ab41690721ebe8 Mon Sep 17 00:00:00 2001
From: Arnav Kapoor <kapoorarnav43@gmail.com>
Date: Sat, 24 Oct 2026 23:26:53 +0530
Subject: [PATCH] iio: proximity: sx9500: ignore event config writes that don't
 change state

sx9500_write_event_config() adjusts the channel and close/far user
counts on every write, even when the event is already in the requested
state. Writing 0 to a disabled event and then 1 leaves the counts at 0,
so the channel and its interrupts stay off while the event reads as
enabled. As channel_users[] is shared with raw reads, those can then
wait forever for a conversion. Writing 1 twice and then 0 has the
opposite effect.

Return early when the state doesn't change, as
sx_common_write_event_config() does.

Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index dadce9b44227..26522b6c5a2d 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -548,6 +548,12 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
+	/* The user counts must only change when the state does. */
+	if (data->event_enabled[chan->channel] == state) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (state) {
 		ret = sx9500_inc_chan_users(data, chan->channel);
 		if (ret < 0)

