Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526688;
	b=V4Jl9VyJh1w8e0UcR4P13PDln0HlQ4fFBC8fnGjnykQFyaC9Lv4UYrBnjg9rZ11pPAav
	 pom91xIPxGsjtPXXpbZIqt+ZRHXmRmvJnWK5ah/fRdU2IVBcSSxzdaMTfTwTQvLSnSiCO
	 0hdVfMWHzdZ/nvJSDJf0x9rG1+WQy3MocLfukCryL8YlaayhApNHqXp9doRAm25r9J5jz
	 UHJfv9ESLmsceE8G+ie1owQGVFSbVmio4Fs6OfXXAH+UXxufBgZNFgG3C7WYgVSaxiXat
	 HNLGX8drrPAuf1O0+F3IX+5htAxRapysuhFuD8pvC9XJNreFrSd+JyZoxEbGf3AOOsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526688;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5sjb+FMhot60NLMjgu2dUYbzY71aghxYfVe1HpbzzCo=;
	b=EWeGugSoW80C4zjynG8n7frRLZeZk7YT94fP8vvKTHMT/WXmHc/a69XljRu70fbOHelo
	 FjkIBrS2b3s5ZL+DEfAN1NfVONIHxfdq1KBagNOt3c0ewjd7X2GDkfgQ/6sEXnztXRzeU
	 QDiN2NJ5W+vz0Nt2FWBKYYXxGjlyJ2qBeNh5Ka2LjkVZFZhsJtAAGQOw6MTFcSBewSQyf
	 YdbpUtTAUHJJRGEVuFZcF/YSV1wHuuDuC8h9qVQMY7eLAljhejhUkWDodyIA+9o/epYnx
	 /7KXGkm+iXuG7Aummeb4M0FTPhd1jD2VEQ/g8res8JgxzUk5TBHb6U7lb/50dv9QzLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=q0XyJazx;
	arc=none smtp.remote-ip=51.250.60.160
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [51.250.60.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757B606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0757B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=q0XyJazx
Received: from mail-nwsmtp-smtp-production-canary-28 (mail-nwsmtp-smtp-production-canary-28.yp-c.yandex.net)
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 10E61C7D1B;
	Tue, 24 Nov 2026 16:24:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-28 with ESMTPSA id YOg8RW3Xma60-dvosX3tm;
	Tue, 24 Nov 2026 16:24:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795526676; bh=5sjb+FMhot60NLMjgu2dUYbzY71aghxYfVe1HpbzzCo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=q0XyJazxilxIac0cj+6NnqrmOR+6B6WYWYa2+Xr/nxwtbjkHBg6Pw5AQS2MGHPjXS
	 dNdVVKyO/9ofz6jW/5TGoTwoiUE2HY0ZVZHCDKZCRtr2oRyR4hz0TufYrz//GKwzm0
	 GgSz0jZAb1c0Zug/d3NNs/RnfFAMlOEllGaNEAhA=
Authentication-Results: mail-nwsmtp-smtp-production-canary-28; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org
Subject: [PATCH 5.10/6.1/6.12 1/4] HID: roccat: fix device access in roccat_release()
Date: Tue, 24 Nov 2026 16:24:31 +0300
Message-ID: <20261124132434.134814-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
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

commit b0a42af46363b65d6e5018d971189c4882d689c3 upstream.

In roccat_release(), access the device using file-specific
reader data rather than global array, thus preventing the
case when original device was disconnected and a new device
has connected using the same slot indexed by minor number.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-roccat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 77042c7edf76..12953852b465 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -211,24 +211,19 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 static int roccat_release(struct inode *inode, struct file *file)
 {
-	unsigned int minor = iminor(inode);
 	struct roccat_reader *reader = file->private_data;
-	struct roccat_device *device;
-
-	mutex_lock(&devices_lock);
+	struct roccat_device *device = reader->device;
 
-	device = devices[minor];
-	if (!device) {
-		mutex_unlock(&devices_lock);
-		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
+	if (WARN_ON(!device))
 		return -ENODEV;
-	}
 
 	mutex_lock(&device->readers_lock);
 	list_del(&reader->node);
 	mutex_unlock(&device->readers_lock);
 	kfree(reader);
 
+	mutex_lock(&devices_lock);
+
 	if (!--device->open) {
 		/* removing last reader */
 		if (device->exist) {
-- 
2.56.1

