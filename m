Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810300;
	b=iXozx/2a4iAZIYd4PIlZlo0PHD412hAP46KIEEE+OLiT4zsj5ksSjsEToUQmiHsO0aaS
	 4L4zpJl8Sj1j7P1t/2a3uNYTUuwgxneJe2iD4+5u7YqNmnR7mwVUGiIvv6hvSaRNqy/zF
	 XgSSRHVcefnEfsJHUwQnTHqJFEFNdNi76q/frX3DCdPnDI9uUGzy/HpPeEl1OORk4JEvv
	 8QcY0gtqZ7pG2OAnM7MtGA3KUsHG06FdPUEE26Lsx4zLjXQ5qivQyGbmuS362dZA/u3Fs
	 5FIECeY+1LxCQEzNj12FCww5xRNogEoAurYT3gjlI3OjOhWM1AJR8nsIQ1ehmmANSzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6i3qlWtr8ju8uMonL9duKT6B53tyoPmH9qmKQuiPpdw=;
	b=kMNWkB7dEiF3vhkpJ80IifbHDR/bLz479xiFpQ4M4DyHKtC7wCYki64XVfjQGnmUiaqW
	 xzT15iz6Qeil0wcwCnxCJdJcPuT9luxWqBYLkZmC8OL32QME+TP+B1/RrxPiXIVZIAEvD
	 azWUJfsLN0CkFDP4zPA5cjDXZcQTGvDIwJhVw0v1LqRHaxiUXii2yNazkN1SCPkYlPdDx
	 bxEEs+XtpEbyOp+C6DNeWqsabNRz4AcYTY5uhhgqT5ciisTZmDZqb2/yu1yrSKnQ229zk
	 1R9cLZr7U1X6VGa55tx/89SMat+HEsf1YVPi9Ix2NMyuT6cCTjwbDT+gQeavmwleX2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVU7asea;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADE606A33A;
	Fri, 27 Nov 2026 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVU7asea
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4081F00893;
	Fri, 27 Nov 2026 20:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810299;
	bh=6i3qlWtr8ju8uMonL9duKT6B53tyoPmH9qmKQuiPpdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KVU7asea4oI6mTwJM5m8ug00A4yrB0YvJ+Dxu3sy9jHmJJ0feqkRwlhzghaxY2X48
	 k9nxSgQ/WjbY/cKom+BgDDFGEz0lM5GRx4pWJ4EMnVQRq98kKxrIkgMZ+tnfPYfynn
	 RLuqCy7pXIYlnd1pqni3VLpAfJtGs+yuG4GYIWghd6cxzfHERUlBPQ6nMDeNShnmH9
	 XvjBMnM7xKMPDqb4tTqO04/Pcj2qJUBS1vb5+PGBtSDMwmAe0EBRN8Bwds/28yeL8g
	 LVHy1vVz/Axv3LvLQAHUQwphXOp01Au9+VBovQuKqZeVf6k6pn6+5dpEm9T4wfLUAQ
	 2svdNTUEclABw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Anthony Liguori <aliguori@us.ibm.com>,
	Markus Armbruster <armbru@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] Input: xen-kbdfront - check info->ptr and info->kbd before dereferencing
Date: Fri, 27 Nov 2026 20:10:00 +0000
Message-ID: <20261127201050.3532488-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When XenStore disables either the pointer or keyboard device,
xenkbd_probe() leaves info->ptr or info->kbd as NULL.
xenkbd_handle_key_event() dereferences info->ptr->keybit and
info->kbd->keybit before checking whether those pointers are valid,
causing a NULL pointer dereference in interrupt context on key events.

Check info->ptr and info->kbd before testing their keybit masks and
remove the unreachable NULL check below.

Fixes: 3ef8a2eeb6dc ("Input: xen-kbdfront - allow better run-time configuration")
Closes: https://sashiko.dev/#/bug/linux-9e0f9c2c-45ab-4045-80b4-47629154e917
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/misc/xen-kbdfront.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 6471d836f6fe..4e0bd4480f83 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -92,9 +92,9 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 	struct input_dev *dev;
 	int value = key->pressed;
 
-	if (test_bit(key->keycode, info->ptr->keybit)) {
+	if (info->ptr && test_bit(key->keycode, info->ptr->keybit)) {
 		dev = info->ptr;
-	} else if (test_bit(key->keycode, info->kbd->keybit)) {
+	} else if (info->kbd && test_bit(key->keycode, info->kbd->keybit)) {
 		dev = info->kbd;
 		if (key->pressed && test_bit(key->keycode, info->kbd->key))
 			value = 2; /* Mark as autorepeat */
@@ -103,9 +103,6 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 		return;
 	}
 
-	if (unlikely(!dev))
-		return;
-
 	input_event(dev, EV_KEY, key->keycode, value);
 	input_sync(dev);
 }
-- 
2.56.1.839.g22a8290db9-goog

