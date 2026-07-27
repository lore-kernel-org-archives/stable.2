Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0D40EB98;
	Mon, 27 Jul 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158361; cv=none; b=APNlNvhn9mNFM5pRkKqaezNKCjvPvWX7PrwKh3G9Ngt3iRajvPLs3189FRxPYKUe5/ySGzbka1xaOyeEgN8BLpsz9ouEVNwy3FrI4WuzYiMbcAoxv6fx3Z6v3xDJjSu8pRjoK0lCpHGYe5gmGDTCNtOuvq9SEnPcOxBAON2+goQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158361; c=relaxed/simple;
	bh=r/yey11PwuQaiKdNacCXZYcIRFP9DChos4riXWM+zTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvZiRUi1EWSd9MvnmAYucwsYhnhAYBG+Abcjq2kaur7Orwl7fB+7/HrCzhJQqqWK31tbcMaozDY0azSq1Y68kLs11S3+4DWX1mtB8iD2AZ8h5su1T7GVWG3y4fY+24trFMq7zmpHhi5C/B+m8Z+I/oKjOlhLEaar116aae3nhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=U6vENB/T; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=U6vENB/T; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="U6vENB/T";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="U6vENB/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158352; bh=r/yey11PwuQaiKdNacCXZYcIRFP9DChos4riXWM+zTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6vENB/TrvCs0+p5FmzMib5FuiwrB8KTWxhZdwFgMIOjKzIOnayT9CZ/dxePvR/sS
	 4npf7yMeEihyX2zHHm7Ivcz3aOvstnYBfhEiyE0B8AmbRXH+a20yPsjfLyKX2cEY8j
	 lUJ0q8878ANJEBbhDr11mtZmYkGM4GIoi1oJBeumVN6hrqU7jBrf6Nk08scPkn7ZM7
	 ZSXCiJhPCbS5qQHq67/+7XDLTVRh4lPdMH8qfU2FKsnME5ZrNDOmKh5REMFJk/8tD/
	 HM9qmv5T4+ppP6RVp/twLt63azRwpAID0QtVSBGnTWqyE8Q14ZVS4BAzlyTrs0KTvR
	 Ouax8Pjk34vdw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id CED9D42528; Mon, 27 Jul 2026 14:19:12 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158352; bh=r/yey11PwuQaiKdNacCXZYcIRFP9DChos4riXWM+zTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6vENB/TrvCs0+p5FmzMib5FuiwrB8KTWxhZdwFgMIOjKzIOnayT9CZ/dxePvR/sS
	 4npf7yMeEihyX2zHHm7Ivcz3aOvstnYBfhEiyE0B8AmbRXH+a20yPsjfLyKX2cEY8j
	 lUJ0q8878ANJEBbhDr11mtZmYkGM4GIoi1oJBeumVN6hrqU7jBrf6Nk08scPkn7ZM7
	 ZSXCiJhPCbS5qQHq67/+7XDLTVRh4lPdMH8qfU2FKsnME5ZrNDOmKh5REMFJk/8tD/
	 HM9qmv5T4+ppP6RVp/twLt63azRwpAID0QtVSBGnTWqyE8Q14ZVS4BAzlyTrs0KTvR
	 Ouax8Pjk34vdw==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 6AE3041CD1;
	Mon, 27 Jul 2026 14:19:12 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jarod Wilson <jarod@redhat.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/15] media: redrat3: Ensure rc device is freed if enable_detector() fails
Date: Mon, 27 Jul 2026 14:18:45 +0100
Message-ID: <38945c6fba0c0e1c7fd9ac90bcc65527bb319cbb.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This particular error path does not free the rc device at all, with
its priv pointer still pointing at freed memory.

Fixes: 2154be651b90 ("[media] redrat3: new rc-core IR transceiver device driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 3f828a564e19..2b639fe59923 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -979,6 +979,7 @@ static int redrat3_dev_probe(struct usb_interface *intf,
 	struct usb_endpoint_descriptor *ep_narrow = NULL;
 	struct usb_endpoint_descriptor *ep_wide = NULL;
 	struct usb_endpoint_descriptor *ep_out = NULL;
+	struct rc_dev *rc = NULL;
 	u8 addr, attrs;
 	int pipe, i;
 	int retval = -ENOMEM;
@@ -1102,26 +1103,31 @@ static int redrat3_dev_probe(struct usb_interface *intf,
 	if (retval)
 		goto redrat_free;
 
-	rr3->rc = redrat3_init_rc_dev(rr3);
-	if (!rr3->rc) {
+	rc = redrat3_init_rc_dev(rr3);
+	if (!rc) {
 		retval = -ENOMEM;
 		goto led_free;
 	}
 
+	rr3->rc = rc;
+
 	/* might be all we need to do? */
 	retval = redrat3_enable_detector(rr3);
 	if (retval < 0)
-		goto led_free;
+		goto rc_free;
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(intf, rr3);
 
 	return 0;
 
+rc_free:
+	rc_unregister_device(rc);
 led_free:
 	led_classdev_unregister(&rr3->led);
 redrat_free:
 	redrat3_delete(rr3, rr3->udev);
+	rc_free_device(rc);
 
 no_endpoints:
 	return retval;
-- 
2.55.0

