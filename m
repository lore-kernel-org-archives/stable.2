Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610799;
	b=wfRLiE58dD+JxWmqteN+J7b1Sqo26pu35EwjaSNPDRLNqlI0WLIfLKgkPHlLqAPmMDS2
	 D28KEPj58CZcdjxSbhsn01Ipap1G64EWY2Jat6dOyt+Wk32PZqk54IdPrEisoU0iBaVXg
	 b+e4Y3o7upGrRR70TTDV65ZCDJgOlw5m3t1k/cNl2F990coQcxk6hVxQuZDXi88Igho7P
	 TAr/7qltJ7hqtc9OZlAD2CKcw5oUZAuVadP63SCB6z6pnLWyG8A7OaRoYnH8t6viM5fN1
	 dBmzVDwJQSP9s9Ghl19I/W8VVkW0Jc8MLDfn/3RNAiWVVQHFGnYEZXusEjmzBaMApAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610799;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xMrcZNFB/mE9Cx5+3D69rV3MZRP1PNb34fHSywMrVI0=;
	b=Nc98l3a2xPZcYN4Cbs/v+4O44SbDOoD5gUSX4JmLsQ0Xozryl+8X/HmkrqBLfGlDE+6l
	 Tx6V4N7wLhCWscj3iEUF83FmWcWAU9r6bAbPmogWZvQZRpOJXQC8ki2L5N4iG1zNH5pwz
	 4xoRm5mDma/U5rXUinRCdxmes8apRx/o6J32GAlvlokxdgvr/p66pY/QwYWOf67KD7DUw
	 So8g8BRtQspZEZ1m1In1chitfg2IEFsvQngERND4OsgzvHzt3TAzYLznWRxpZUm+I1pWT
	 jc1Nuu8fizd4Nk8MbkvBLk1vcfs1qhV6MzKEmZnW6pTk6CsY54TmogVWmN3qnn+fUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="ti8SEc/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF08606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ti8SEc/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354AE1F000C4;
	Wed, 25 Nov 2026 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610798;
	bh=xMrcZNFB/mE9Cx5+3D69rV3MZRP1PNb34fHSywMrVI0=;
	h=Subject:To:Cc:From:Date;
	b=ti8SEc/X+JoZV2m+UTtmatkZMEu1HAZBECrLaCXkTo0OYMQC5ZYxt+AEwR7oulNN2
	 Pvgkv2nLkhqVmc8inweuSBs+3Ar0wJnLFjT2u60zSSY/G1oNUeIg3KV/VHrQ1ErtWl
	 t1Hzeixe2oS+itne1WQ1B2e7caxT2MeEA4rLI82A=
Subject: FAILED: patch "[PATCH] iio: proximity: sx9500: ignore event config writes that don't" failed to apply to 5.15-stable tree
To: kapoorarnav43@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:41 +0100
Message-ID: <2026112541-onslaught-uncapped-4491@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9165906597b69a46fabf39ab41690721ebe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-onslaught-uncapped-4491@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

