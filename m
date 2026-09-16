Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E0525A6C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577396; cv=none; b=XjxrhJdh7BFZ7MH2gaGt0zyUMusxPbSMDtTAnibcgZhUpBogTZSR1TKSlX5leuXGPV4ew3vQer85rzZGGtXT5WJm4t17gP8dH/iVdsHejIM/w+DYER4eaQyGUON/bcTUNpIuS+uJL1ANg7UKkbekjVHfpw6LzqPGkErISfK+KiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577396; c=relaxed/simple;
	bh=M6AIL5yH0b/LF0GWrC55rxHvFKmlIRC0KSm1QNevzLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7tF3qPVapRaxKYopvvnX11emevfi+XLivklsY4XGq9OHdaCBD8lUdIf9RwKp2fYXOiCpwxjG9YZmnfQ+LZzhUaExegdbj78O5qq1DlmkOveGE3CCYAhjljxKBLjPXow0+RqTzWcvsYps1ZmIy7IfhJypXKi50sjmAq24J7i1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHKpf4lg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHKpf4lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DBB1F0089C;
	Wed, 16 Sep 2026 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577381;
	bh=sS5eEWLBynlxAw49LbTktKk/s/JTfEuGmu7MKQwyjrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHKpf4lg2OF1yOr5NOu7yiJLm2kDS8GnHSGqH08/1r0KQ3opKmOKPg2zkiZv8UADc
	 3N2yZMiePw/wQ2gSRCKCvE2mq9e6Y/3+HH5mJtyk6CLfR3tQqbEGdjezCfDepOziX4
	 q9GjhYw911/+LPE8ylwIM0bd51FGDnPz10PFHD0uAtwpU9AZmePwci9mvQnBzhkzPc
	 /PsyERVSPeyi5xDH0q5fhGXqA4w9Q0MbzPTyn4cAe1DdrRQnCMjLE77B84hHwpLOse
	 PH0AQG9wy0Nufr8ZzLVyxpGWKhx9V+hQp8vKr/LzA/DV+gqfS90VXkKJh0aKeDX4P3
	 19hCejeu2izag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] ALSA: usbusx2y: validate URB actual_length in interrupt callback
Date: Wed, 16 Sep 2026 12:49:36 -0400
Message-ID: <20260916164936.551732-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164936.551732-1-sashal@kernel.org>
References: <2026091646-junkman-leverage-0c14@gregkh>
 <20260916164936.551732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 8f5ef203abda9dd36b2af473c7b737d544f807bd ]

i_usx2y_in04_int() processes the interrupt URB data without checking
urb->actual_length.  A short transfer from a malfunctioning device
would cause the handler to process uninitialized heap data from the
kmalloc-allocated in04_buf, which is then copied to the mmap-accessible
ctl_snapshot[] array.

Fix by using kzalloc() for in04_buf to zero-initialize the buffer,
and adding an actual_length check to skip processing on short
transfers while still resubmitting the URB.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Link: https://patch.msgid.link/20260904205826.4071119-2-tristmd@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usbusx2y.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 9dcf810ae71df..842b3bb8d5aba 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -190,6 +190,9 @@ static void i_usx2y_in04_int(struct urb *urb)
 		return;
 	}
 
+	if (urb->actual_length < USX2Y_IN04_SIZE)
+		goto resubmit;
+
 	if (us428ctls) {
 		diff = -1;
 		if (us428ctls->ctl_snapshot_last == -2) {
@@ -247,6 +250,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 	if (err)
 		dev_err(&urb->dev->dev, "in04_int() usb_submit_urb err=%i\n", err);
 
+resubmit:
 	urb->dev = usx2y->dev;
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
@@ -299,7 +303,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
+	usx2y->in04_buf = kzalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
-- 
2.53.0

