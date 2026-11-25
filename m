Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610789;
	b=BrEB8djYkPmJbaePp9lmMUpyxmqI0w0CrY4XDLA37pkjhAzQkd/TIGGbGB7y629+3aB5
	 qOUOvMTlmggJkZWM8gzWQAM8/IGQrHWa6I3W+7wEsi3Tuf8Nd3XLt3fD/Qt1uoGVSOIfe
	 cowzla8KsIzRHjE8J8tWsXFugwEURQVmIrC9rIvVQQ2i0ms/tF0288WvOv7EwPR9XuOpE
	 CoPwZWJkl4JhobkcW4clNzswmlSmhDqwshWrqVvQJIvN1zHUTRwEgVagF0bmg9NP9uHat
	 MmtFZa08SLb7HXEMkd+2pPwFMMXr7vERsp4Qs9GYUI1+27DgEKR3j0cNjlKxnzecBow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610789;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6zX6IGGrnlp/tE99YamIpoFJnSjXUpbJksoFFGYyNJ4=;
	b=rxT1ULWxzQdDp04DEnn5+/0/T6ewXN2u9zZGYMlZ9kIMCFFHBaDyteUXRFe5uT+6GwiE
	 xsClz2s1Y76Gbqnhvj35jHKcg7DdN34zb2AbdfD0kdZQkzoKiMLF6+m9TolCgdTBG6LWh
	 frCI5d6isQtd1b2TBuUdgtAWQFuRhV/UGSDHVwHPOZCO72rimd/n+/pn4t6FBP88704CB
	 JZfDC8OCGCBJFV/v4qE/ySUsiz1aJoup17YZ/+jr6b4kGdTtka44bPnvpaihC9cGPMbCu
	 v5xy5CubdShb/vyGkE+hizjn/JNxfpBsfD5Y5XEoLsGHsQlLMATPF7wJdDQOY30mJjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="jtt/D25i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E8606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jtt/D25i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E81F000D0;
	Wed, 25 Nov 2026 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610789;
	bh=6zX6IGGrnlp/tE99YamIpoFJnSjXUpbJksoFFGYyNJ4=;
	h=Subject:To:Cc:From:Date;
	b=jtt/D25iX5qbM+4SnzyRRfdsOf7Q41lX+lM8j7lF1nvk30RqTsH6aZ9WIxcNuB8Rj
	 H4AFA9+xo72hGWjx78Vdtf788/LvTH9wdKGa7kFk4h34zRdaCjrGfDzETvLp/Obv/b
	 ReJgzHPFRFownojQKaFaKCYEb4igQfY3si+cSEiM=
Subject: FAILED: patch "[PATCH] iio: proximity: sx9500: ignore event config writes that don't" failed to apply to 6.1-stable tree
To: kapoorarnav43@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:40 +0100
Message-ID: <2026112540-shone-tamer-89bf@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9165906597b69a46fabf39ab41690721ebe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-shone-tamer-89bf@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

