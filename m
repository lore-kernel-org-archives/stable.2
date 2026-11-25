Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610796;
	b=V1JNdGGQwvYAfwtQwOGe38yQ4gw/vvstDRQ+5XnzMnk6Qz53xLsogPGCGKk7a4PYg6ix
	 8QP3LuNxqd9QNnfT97Mk/zcZaw9xqE9JAhZjzYWUG5GVveVLVEmIU4myx0D9IRsOG72/A
	 jipK62bGG5zxqPu6ZieRSyhsmmglT39WoVT9z0bRq+jdY5Esp57axid0SM1Nk8A7OSOEK
	 BjYvn40lKJuoUmodYgW/HAgmU48V6onwzF1X/DLu3GYBTavMcMMzWjQJeky4NygwuyRBr
	 3IOD2hAZYWKatEIaW7GvDgI1U6xb7YM+U8bZ/Njep8aOr9I2bhMtuwqXEzgh+Rax0qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610796;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pQkvEcri61Va9g3o+U47jX05FEcAIg9C4bvSSuxjOXA=;
	b=oiu0RAjr2lyA3BpnhC6hHZUwf6FFTRccPLW9RDjKnOdOA40aMKu9dTmyWEEq1xdgm/HE
	 Dfc4EryV3lwNUttrAnmx0iYd8bPFmbc1prQZJ6YufokW4sumRTjygItJHm7G1E7ZFtHKt
	 w3fkIvepwrdH6MyY7rhc7/UKDOqnqvVzQbQTZR/BWRFxqyfENOtgK9PSeL8L+Yn16/Bz6
	 7ChLNBBXVM2vNlY8D6HRXslpqN4U2zHC7lRSKlCkbNWemlr2+RvgNeDDrL3z4tDM0bshJ
	 Rqjpct3zQSVKhiWaVE7EEn9+chXT9DkbH1Cm6YOJknJKsDsBxNHSuNI+JzyTfeNeIUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=obF7+hXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F501606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=obF7+hXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8AD1F000D3;
	Wed, 25 Nov 2026 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610795;
	bh=pQkvEcri61Va9g3o+U47jX05FEcAIg9C4bvSSuxjOXA=;
	h=Subject:To:Cc:From:Date;
	b=obF7+hXeTNtQ4iQrFY1VOBaKssLYOhxPLIOYPUAjO61SpT9EcdbGOY3kt7oF5Sn3H
	 jrTxyds3XRrE/2+iRAo8wRRAO1VphlGse0vUYChnDEXWrXqqCC593smLzZsDCclLGS
	 OeZx8KOJt8JY7bzozsQXyj78UgM92zHod9K82P+A=
Subject: FAILED: patch "[PATCH] iio: proximity: sx9500: ignore event config writes that don't" failed to apply to 5.10-stable tree
To: kapoorarnav43@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:41 +0100
Message-ID: <2026112541-thursday-proud-9f04@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9165906597b69a46fabf39ab41690721ebe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-thursday-proud-9f04@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

