Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526688;
	b=E3nZQjF4gcJueSuOyZMV958fUefOZA9t4RGFJuLLxt2nJpD/YwCAzy3iOB2JZFQUMa6Q
	 vumDvG5zQjdvyc5VQJinkwhlAc5jbUEablQXnjqzBOYt2g77SOuG1R3FscWW4p7MPdt0k
	 DlXj/9M3PXb37UYBB5v/fF17RrKcqJFBV9E8wFzEWn2/2XbeLycoJADjrR/qjO9LXw+PD
	 iGe3dLm6dorZYjdL4swsIkQHisRmuUkxO3Ci8ZxEGuqCbDfcISZPL0KVryVQnYkIUc7e4
	 Ev1siQjvXz/TmxaF/WA8tf7RuYNRB6CW9diwjmQTPdGpvYlJ1Migf5BQ5MsBMkkKWXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526688;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eoXndNCMVUFukFrxbYi3LBRkSPdIlz1+kEvkI3V/2PY=;
	b=VvEN2osckIW7CR1Hnb3X0jCyVyj/f/E1MqpsMDD2/9Q9keKkceIweu2UBLHQAnHbNugn
	 Bii7jUKCcenp+/fqCKYSjAaJAT68y7288RDnonsxckKYQJ1ZlXwEegFDqfGE/IOScasu3
	 tQy5Jja30ug0Fw0RP7Ymr7HQcv1dbg9WXkQXbJwr6fHPSVqvsRvDQu0G7oUtouqu3uOEG
	 7zxZ4HJSrMRVp07+jvtzfpjLbeRvpxSyGUk44zkujCYwFe9aDU7U0rvr8yLUCLhGxxUhF
	 X/oZsxM0sPPduh/yPwEp2w6heFXNdLD2bjL2g/Bk9lpghOBXxmjT1iqRjo92mwIseJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=N2zjfor4;
	arc=none smtp.remote-ip=31.44.14.17
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [31.44.14.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA175606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA175606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=N2zjfor4
Received: from mail-nwsmtp-smtp-production-canary-28 (mail-nwsmtp-smtp-production-canary-28.yp-c.yandex.net)
	by forward501d.mail.yandex.net (postfix) with ESMTPS id F070181413;
	Tue, 24 Nov 2026 16:24:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-28 with ESMTPSA id YOg8RW3Xma60-yPQqCqJL;
	Tue, 24 Nov 2026 16:24:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795526679; bh=eoXndNCMVUFukFrxbYi3LBRkSPdIlz1+kEvkI3V/2PY=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=N2zjfor4dCCFlU321soD2iMkhFC+XreInXgMW5XwCR84SiBy3ORRPLslKOJaqaDCG
	 elMadyBJeZjSaJcp/Iblnp9sICZNha9pxEbC+O1UwLzQIACxKL8Ec1E2i+iDwzKttO
	 wIxfm5DtAYDvuGxOUxmez+k7SDz5t1khWo03b/kY=
Authentication-Results: mail-nwsmtp-smtp-production-canary-28; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org
Subject: [PATCH 5.10/6.1/6.12 4/4] HID: roccat: avoid unlocked report buffer access in roccat_poll()
Date: Tue, 24 Nov 2026 16:24:34 +0300
Message-ID: <20261124132434.134814-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124132434.134814-1-dmantipov@yandex.ru>
References: <20261124132434.134814-1-dmantipov@yandex.ru>
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

commit 8343dd786b4725c69e4352afc5a24dd796aadbcf upstream.

Since roccat_read() and roccat_report_event() uses per-device report
buffer holding 'cbuf_lock', grab the same mutex in roccat_poll() to
avoid race against them.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20261022054454.238343-4-dmantipov@yandex.ru
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-roccat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index cd7385531eb4..ddf2f7dc1f7d 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -160,12 +160,18 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 static __poll_t roccat_poll(struct file *file, poll_table *wait)
 {
 	struct roccat_reader *reader = file->private_data;
+	bool avail;
+
 	poll_wait(file, &reader->device->wait, wait);
-	if (reader->cbuf_start != reader->device->cbuf_end)
-		return EPOLLIN | EPOLLRDNORM;
+
 	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
-	return 0;
+
+	mutex_lock(&reader->device->cbuf_lock);
+	avail = (reader->cbuf_start != reader->device->cbuf_end);
+	mutex_unlock(&reader->device->cbuf_lock);
+
+	return avail ? EPOLLIN | EPOLLRDNORM : 0;
 }
 
 static int roccat_open(struct inode *inode, struct file *file)
-- 
2.56.1

