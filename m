Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1D4D6C26
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574510; cv=none; b=XyKwRyc241zdkSVwbTPaivc6mlQVrmW8NgRBiPTT3BGNvSNSMFWp2JwnWsufNKlxxRUp792c0KBgMraWEOBZi93KcnLRGRu6my/Jl3ypCjcl+TXLaFYwOBgJT3XJdl4sKWSNSiS0mM3Yf5pqy50bSbJKyX03iKu4cFiU1iKd6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574510; c=relaxed/simple;
	bh=QIbL0UG4/CBkarVi5P38QSW1jAEexsmlglSYWGkenTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0DiDnGNBFzKyr/1AsVeYyU9FXym6rOn3WxHli13lfeA1VtgjBcH9CtlEIVbKvjC6pWzgJowmc8fJ+WadjiTkI7gIerJCn93gNWNKT+ez9DJmt6EOh1hrx0paEYdrs5oX5cTy0fOnmXfBkAojn2dFx2mSfGL4uMyi1KQ/kNsYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOOwtzj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOOwtzj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9771F000FF;
	Wed, 16 Sep 2026 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574509;
	bh=T+s7OUeHJaGRDzrfZggbxzw8c7ss2yz8/32AguapXw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NOOwtzj3NVDhccgxx/jk+Kx7painhOBdyN/Pbickpw7xam7dc6Ln2xVV3Mfy8SmTM
	 FCHt/m16HLJBgaESHbK6cCGihgLnuuE78R5HGzuEHgZeC6Yod5jUkDZOd+q9TFnJh+
	 4dqqlIeBzVEsFyiBMTreRdI3SWA2KkdpFzSsKXjbzKLJ+4hEKaiJtE6UyEOW5x6Uby
	 YJLShawejgUOaJIrXTC2cBzRhZfbkutdpP80cXI41ChlpPAnD+PiLlmQfBNoARuXQJ
	 uTFpaheqXLNSGNDc2lUzlbSfiG9cJkLqBr3FAMYt0/2mrTQRI2j0GwW90yH8ob/nig
	 vu0Af4sAnJddg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ALSA: usbusx2y: validate URB actual_length in interrupt callback
Date: Wed, 16 Sep 2026 12:01:46 -0400
Message-ID: <20260916160146.46135-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916160146.46135-1-sashal@kernel.org>
References: <2026091646-catalyst-goldmine-6801@gregkh>
 <20260916160146.46135-1-sashal@kernel.org>
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
index 9f305de713bbf..4e1ef6d80277e 100644
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

