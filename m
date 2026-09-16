Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE84CEE75
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574184; cv=none; b=gotnFa4krAcozROSR/lZ+8Zuz8T5uLmr43u5cW2lAIJDCmMKbDqNn2ywa6ah3zO/GBWXtZEZWDEcDiKQSfnwKN0V6Bm4uqWUgATiZiHpMWFu8D/qHGLD289DmiZ20AxNvHoxqHQlE9Ht4d6Un+iCtz2tmldga0bERs7iN6XW77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574184; c=relaxed/simple;
	bh=OrSj4x9uEWMu4npb44d8CK0Ux7Gu699fAmtdS0ZU7I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGvKmBcwSr0Bgr5YXKmbZudBRnPyYqfs8rzlA6i9IsTbYfG/4o1Wm+wUOAQUHTVxUsQgHrhGIG7lepkz7MjoGPCB2oxB4qxVJo/R3UkWxC/sBB3Ef6mn/NLv6AYS8QbBASehrHHK8EEHOIVn7Ro3eoBr2toYRj/C80jkur3vo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG/gXMh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG/gXMh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297631F0089A;
	Wed, 16 Sep 2026 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574176;
	bh=UbRASGlwqjAkv0Zo1YVWb1Yiv3zkfcbwnFRAUQAjZ5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JG/gXMh76H1/BcPaI7Ucgdqlvm3yB1zQyKQLGfL0NzYLNywwl++Sq26ab1+auW1ER
	 O6bCiAu/0OML1p8x6bisPvsdnNYZ7nR7cyLmHiFooiNjTIFc95IyO6aJzkU8ReWcwW
	 lPPnhQo/bBKOb4zarIqZ5CXIRF7F7Rr3o3/ap8gLDa+Th0zFT1aXpT8nn1BLm2wX90
	 RKABVQ/3w3RY0xMJXDg8LAgUdJ9RDYV8moToIzdbUnSvloWQzj0upH8PRFtDquk6ux
	 iEDE8Ty4wumyiRVqwlFqhd1BoQkWR2tzJGJTfZYtQZEfXP+xNG5EZxmBVgqyK1vY8o
	 BTjgTmEvkLgbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ALSA: usbusx2y: validate URB actual_length in interrupt callback
Date: Wed, 16 Sep 2026 11:56:13 -0400
Message-ID: <20260916155613.10251-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916155613.10251-1-sashal@kernel.org>
References: <2026091645-overstep-marine-1c54@gregkh>
 <20260916155613.10251-1-sashal@kernel.org>
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
index 5aa373d1edab1..d1e907dc773c1 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -189,6 +189,9 @@ static void i_usx2y_in04_int(struct urb *urb)
 		return;
 	}
 
+	if (urb->actual_length < USX2Y_IN04_SIZE)
+		goto resubmit;
+
 	if (us428ctls) {
 		diff = -1;
 		if (us428ctls->ctl_snapshot_last == -2) {
@@ -246,6 +249,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 	if (err)
 		dev_err(&urb->dev->dev, "in04_int() usb_submit_urb err=%i\n", err);
 
+resubmit:
 	urb->dev = usx2y->dev;
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
@@ -298,7 +302,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
+	usx2y->in04_buf = kzalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
-- 
2.53.0

