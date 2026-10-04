Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBE41441B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108483; cv=none; b=H+zaYx4G3z9zD9tvJVdAOuDkLj6G8ctzTQJVQCvUrWdg1BwM+5otrt5NTwjZ8Avu/htXU34ElpwetX4fNxos/PH58HVfF6n+fvZQEQMaNOrnDXin4xdst1nSE+FtLuBTxuLMAJQEZBN9k+lqWEgAYNLi7W9ZEiiiuMxEBd+erVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108483; c=relaxed/simple;
	bh=cmwdYXaQEPpllQNN37SxJSYqTwAgWmylyfZBms9d8po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi7mtSLGYQGhEKYnS/yDL4xB0rlTHPw8jHLMtGPOJPUzNOJFNsjH8qBuFf/vD1UUTPaliYfXZzhWxL2KI3CW9bHzJDuZiIL3HtIopR0ekwAXKWy1XMfORLyMt3ndaoJVkS7bqECWyxE2vgKyume0t32rLqi5vbd9fOu2qLwO/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFKenC9F; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFKenC9F"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4649b35bso853127f8f.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791108478; x=1791713278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVoy+1DKk/EAuFh26qVXsO+Sc45U9WmkeSYeupZYfeU=;
        b=eFKenC9FL+FVOiRGp8J5TRFlYZ/KeTzUD/tUTUFIAQjcFoER7BkqWRB0JEsAkaooog
         ysULlsdazp9XSwu61W1oA3pDntH0dOk8MNJpYbFcUPRk0DH8ukguBq7Laj0/OGz5513a
         eHAznODivoDlJXiWmQ4z9HHo4TWjiKriLHRMpPyt+9TvyuVzqAy90EA/NV4bXRJNlZ2n
         mpznIjrs7UcEBVCx7fEO1OkCMR6jS5MCZCt4DX9+8rCblXodIebz3YdioAnmRpj/B+gI
         bjGv1NLQznyi1DVUBqKFk0UGjMwINJ+4BNVP7O5B5EN8sMRnY7lXxkDICJQ/IwRSWkgF
         hYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791108478; x=1791713278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVoy+1DKk/EAuFh26qVXsO+Sc45U9WmkeSYeupZYfeU=;
        b=RTN8WphInRBUc2gqQvxj+erAkZKxdJRLauZtbk7EiR//kxYvj/91dI1WCBHUlLq3BK
         1AybdCpc+fvSkyyyC1XWhdaTN/CgA2VERO8iPsjT6gEEsrKgfQff9Xng6fwvpBS2aTKy
         fmiLiCTTU9bM0iy50ao/jcDjWokA0ExD1Lj6pOjVFn5Swa4o8PGTzmQYyNrVMB5d73AO
         T4CHTT0gnyror+3NT1heO7V4eFVX5WcdsD5uLfiG3uujj+eJZY2lr8oIWaosgZ/oVZGH
         l0Yh3vhc5u3bzfX4nv3JTLQjcrGe9fO5tgbiPnu2UpT4KoztJkjcP/SWvl5isJhjWszU
         F6Uw==
X-Forwarded-Encrypted: i=1; AKwUvBxEsIX5wLsvNJZCrVwMoBHGCzRSwNl2FLYaC0T4JAtLYCH7PnYt/qMrbkl321Dqj5ejuV5qev4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtN0rrikgUQXz8IR99HcK8hgywspjXlbYHiZkmBoxOkg6mZxwu
	6gcMlY7buC781j3xNwDIqnGGRI0vx85z2+XcF74xr7z6WV/rUgjdRE4p
X-Gm-Gg: AYBFou20wMJ8U6T1emaz4StfWNvmR4N6MYsWs2o+iKRaGQ2CvMy4t8cKvUfs3qd/zH/
	y3WNcxBjJotUpjwKT/C5s+k116AeTE4QWG9T1+XRIwhqWrrdhK0TJ1oNIjLwa9EiHuVwEgguHyf
	7Km1BlCD+GsaewxyzSm+4cpd/Vb3WzF8YRaiNcDbSW1ZdjnY26zNsXm/eKCBQItyNqWMAf14xJq
	SqYCL4WhM/GRbEIsodlaHuMjWzWIlxBzJc9R0zKJNhsvKC7U1iC6dqdDq52cDDPVCsb+6rkQK7v
	U5utWr0xu8K3+EbRC/lPKE6oB5xqTdp6zZT+24NSQUvXBtIgnn7ex3Qsj884w0KBY+ofjxFAxa0
	CPVV0RN0Ys7zFv7/165YiRk4fMpyoHLRuL+1frohNilb69PS3z6hHYO9fUnALxUfzZwGllNa1g7
	U6/S2GUdNE2/oNuClI5xsbbIKW0RM4kgEp5XGd1r33P5lJ4yuQSWbMKp7KIBS/cELvY5RUKF13N
	fqqJzXOGAjQxWIFahweSaemUrUVJq/Jx6JR7TuXZfE3zuAwC0MxQFf1T7H9d7iOXq6Y/Si8tAzK
	mCkETspVtu4/GR33qf8Un5zmUwS2hNhq0g10+EN5ZVZ/wg5vrhfx33eAgMr/W8X+QH5vjWhmrUS
	jiZCfXqNJS9UkjHsUuL3W
X-Received: by 2002:a05:6000:2211:b0:488:57ad:d5c8 with SMTP id ffacd0b85a97d-48c47c8dc09mr7131551f8f.3.1791108477594;
        Sun, 04 Oct 2026 03:07:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-c000-0ddf-b17d-de75-1ac4-0a1a.ipv6.o2.cz. [2a00:1028:c000:ddf:b17d:de75:1ac4:a1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104602sm18136032f8f.26.2026.10.04.03.07.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 03:07:57 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/6] media: dvb-core: wake up CA users on release
Date: Sun,  4 Oct 2026 12:07:41 +0200
Message-ID: <20261004100741.71711-7-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004100741.71711-1-pepe.schlehofer@gmail.com>
References: <20261004100741.71711-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_ca_en50221_release() sets ca->exit and waits for open users to close
the CA device, but read, write, poll and ioctl can continue and blocked
readers and pollers are not woken.

Return -ENODEV from CA read, write and ioctl operations and EPOLLERR
from poll after ca->exit is set, and wake the corresponding wait queues.
Keep the release wait so the existing lifetime protection remains in
place.

tvheadend keeps the CA device open and waits for it with epoll, so it
needs to observe the disconnect before it can close the device.

Fixes: 280a8ab81733 ("media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
The unlocked users check in dvb_ca_en50221_release() still races with
a concurrent close(), and waking the users makes that race easier to
hit.

 drivers/media/dvb-core/dvb_ca_en50221.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index 1b91ebb8f667..d478f995d5a9 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1353,6 +1353,9 @@ static int dvb_ca_en50221_io_do_ioctl(struct file *file,
 
 	dprintk("%s\n", __func__);
 
+	if (ca->exit)
+		return -ENODEV;
+
 	if (mutex_lock_interruptible(&ca->ioctl_mutex))
 		return -ERESTARTSYS;
 
@@ -1460,6 +1463,9 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 	dprintk("%s\n", __func__);
 
+	if (ca->exit)
+		return -ENODEV;
+
 	/*
 	 * Incoming packet has a 2 byte header.
 	 * hdr[0] = slot_id, hdr[1] = connection_id
@@ -1618,6 +1624,9 @@ static ssize_t dvb_ca_en50221_io_read(struct file *file, char __user *buf,
 
 	dprintk("%s\n", __func__);
 
+	if (ca->exit)
+		return -ENODEV;
+
 	/*
 	 * Outgoing packet has a 2 byte header.
 	 * hdr[0] = slot_id, hdr[1] = connection_id
@@ -1635,8 +1644,11 @@ static ssize_t dvb_ca_en50221_io_read(struct file *file, char __user *buf,
 		/* wait for some data */
 		status = wait_event_interruptible(ca->wait_queue,
 						  dvb_ca_en50221_io_read_condition
-						  (ca, &result, &slot));
+						  (ca, &result, &slot) ||
+						  ca->exit);
 	}
+	if (ca->exit)
+		return -ENODEV;
 	if ((status < 0) || (result < 0)) {
 		if (result)
 			return result;
@@ -1819,6 +1831,9 @@ static __poll_t dvb_ca_en50221_io_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &ca->wait_queue, wait);
 
+	if (ca->exit)
+		return EPOLLERR;
+
 	if (dvb_ca_en50221_io_read_condition(ca, &result, &slot) == 1)
 		mask |= EPOLLIN;
 
@@ -1965,6 +1980,13 @@ void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 	ca->exit = 1;
 	mutex_unlock(&ca->remove_mutex);
 
+	/*
+	 * Wake up everyone blocked in read() or poll() on the CA device, so
+	 * that they see the error and close it. The wait below cannot finish
+	 * before the last user has closed the device.
+	 */
+	wake_up_interruptible_all(&ca->wait_queue);
+
 	if (ca->dvbdev->users < 1)
 		wait_event(ca->dvbdev->wait_queue,
 				ca->dvbdev->users == 1);
-- 
2.54.0 (Apple Git-157)

