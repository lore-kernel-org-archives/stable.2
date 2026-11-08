Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124741;
	b=vgnVfEcFzYIkDLksJSFQrygqyHlt6chlym8jloFFD/dm+6atVd2gswoG+zwZMYhmoSLJ
	 yEIM5eTiNmeg2t6nJFgs4tH8sWDIFlzPiPRGuicBUayy0pdVPwTll0YL8ttziOmK7CaQr
	 HCXdPnL9/8ZCGyEXBrTHzdh2JdQE1KddZ0x3KdEQqStHQpRSxuG4OTZQ59aqwqmfAsjga
	 KwtszkIcSVSqXU/7fJK6xhokJMb4y2UKvv1yJ99uUJCQfA4g3E/Q7w1crRzOWlF8VfFck
	 iDxZkR7QYxkC2210Rya9ZjDf3T2qnPLLAmJlEBbggf4xAzLXGVz4XPkPSMd5LlUod4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hwIhs2lYepVcUm7QFvUJxPA/hvff1VaV/dOu2IxaRvM=;
	b=cUm7vNxwDajtJop6nfrGfwx9XUk+LsbOjjCs6aN1Vn2Ln+ciicUTBePyFfd70DdpoSjI
	 q2IV81LB9bu7j3W3z7rZoNO+IzKM1FeF2agkEgyM9fyrD6Zg9Ftu68kAb2WOtfD98I9Mz
	 DuDj1XLzhqsnQaZj9FW+v3khdznXdBaNqTqXKHRmRXkKvPSpMAfsmjq2FVCn60hVlAfwG
	 uv5nSos6E9L6GDyCvnyYCg+bGSObQ3cQtteervPnf+urFDf1FxjxhrBCtVyHWgogprYVr
	 z2vrtmSTSMP2EKS1koufBLKcyMUVxBQYKpO7YusDaUdrhh4VEGAqyEKYIVihocAefxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weR81Ncw;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713B606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D713B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weR81Ncw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so794771eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124740; x=1794729540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hwIhs2lYepVcUm7QFvUJxPA/hvff1VaV/dOu2IxaRvM=;
        b=weR81NcweyuBhQaWTFWZGi0vcRkp5kMYOWKhOi4uNjRNhOxGNm4GnkUKoMkOmfC9U7
         VVizkZCDuufxRNyda4QuRywNb2G1xpxgezv+rn5cr3/6hv0IWTEiF7ihY9m8kp9GDam1
         9yH6619OKEKqVpKmvBWEIBG3JMt0ZbvRpeKm8BcIB1o4+4GGPgcESFv01/xEbcxdrRc9
         hCiUJfSeWkxI5kxPY260FaxU+Px/24c9/Upo2CciHRAmXjQwRmBSu/Tk9Zpq6x+rOI+x
         q0Ygf2Soy41A6/ifyYohAxMd0DVynJZukvVIoXHOWWiny+wv7xqx9tsHiX2nlSGSxAjy
         NXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124740; x=1794729540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hwIhs2lYepVcUm7QFvUJxPA/hvff1VaV/dOu2IxaRvM=;
        b=W/8omux5dGV+9HwaQskUwvF1iRp+c5DM85nDOogQTDR5KnHa86HV0APpmrcHu2vlA6
         IxpZwxCWTTekVvQgXjI+x/YyEvDrqYR3BSVWT+k629zOKWj4TcqplcJief8OPG65wXof
         WsdkE6QUp5WpvAy8FzyVu4eRwHrdAuyVnVa3L5ueMQPdRdcuuahWJk3qNGm83pw1Fz+m
         HR4hDveUSRBkXxOSTIRogXTOXtpkQnSDNR3SQQ9T7I97rPyw7b4t6P/FlseFKdDjLyT2
         XlY92HaFKmXwQIqQB09Q/0viy4llEJnoaGL0iI3Zaw1QLDn07kUqqqJWUbQhhJ9tH6Ds
         4Ogg==
X-Forwarded-Encrypted: i=1; AL+hErGueuQQJ65HGsv/lXeyNmFDaLMgpOiNFAXaOURYjR4qekQmhdtRYOOW9C8um7OGeeWH/f7BxS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XWcDUf2wxOBIYUe+GD6EP3INySimrU+xhIlaJuf7LTJSawKuR
	I+2PlJbB/OeZYkiYuVojU1AmQ57/HW7NHFaXwiemAOk1TlGVwmf3ur0YLYdqbgSG
X-Gm-Gg: AYBFou3pFQGAGVBZFtMT+BPTp2PsLX1Gl7RyGUzNGRBh2keH02joDxW6Nf2JR5SAzPV
	+T3v8jLemObeS2tf3QFRv3SYDYs5IXoq7J1v4cfKfr1BYRGuoFSWD8AwB7imM4oaHRO7wWXpwFV
	2DQ6lZeh9SAKO33Qw0D4xpStJNRdJ3UROiL+1Ce6JQ4Obgj5MBfJSayJ2INAUsPFnmKn16KHU+/
	88XA9xUJsh7nDfsVi5zZ345395iUI6iKprP9+WikVcnn2tXd8smE1Td0boYi27YbdPtGU3IaVfL
	fscdHGd3uSJNQe3hnei+ehq2ZFPE/bxqx75+fhW2wW6QEl6W1vACtOCoqjYJDqjZOOS0gpWY/Kr
	omiXfuKt1c04JKrLlIimhatcP6UCGbbxXqr2WPasv76VzYq2U5qPbW22+v7/aGA//C6PAYaOnBb
	R9gHbhOzHK18o/kW/qFFcBgkw62dqxVCcwmQhWoy3CkL2hXErAJJl2mTN9x3W/0ez+C0qU/k5Np
	6FlNgWAfabZC05Z1fubRkdXDYsRbmgcUvZTIHwyPwgiW3yv2wFhZteA+kbd64x12K39yOQa1T/r
	RG0oBQHuAZ6//PLNz4qoKLjmC2nFPRKoeNnF2QWNV4wmmxMS
X-Received: by 2002:a05:7300:d211:b0:36a:1709:458 with SMTP id 5a478bee46e88-37256df1551mr2243835eec.27.1794124739956;
        Sat, 07 Nov 2026 23:58:59 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d48bdsm5966379eec.28.2026.11.07.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:58:58 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Sun,  8 Nov 2026 16:58:48 +0900
Message-ID: <20261108075848.257145-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

tpm_common_read() flushes priv->timeout_work while holding
priv->buffer_mutex:

	mutex_lock(&priv->buffer_mutex);
	...
	if (!priv->response_length) {
		*off = 0;
		timer_delete_sync(&priv->user_read_timer);
		flush_work(&priv->timeout_work);
	}
	mutex_unlock(&priv->buffer_mutex);

The flushed handler, tpm_timeout_work(), takes the same buffer_mutex at
its start. user_reader_timeout() schedules timeout_work from the
user_read_timer, which is armed while a response is pending. If that
timer fires and timeout_work starts running while a reader holds
buffer_mutex, flush_work() waits for timeout_work to finish while the
reader holds the mutex, and timeout_work blocks acquiring that same
mutex -> deadlock. lockdep would report this as a circular locking
dependency between buffer_mutex and the work.

Before commit 9488585b21be ("tpm: add support for partial reads") the
timer deletion and the work flush ran before buffer_mutex was taken;
that commit moved them into the mutex-held section, introducing the
flush-under-lock cycle.

Flush timeout_work after dropping buffer_mutex. The timer is still
deleted under the lock, so no new timeout work can be queued once the
mutex is released, and the flush no longer runs under the lock the work
needs.

Found by static analysis (a checker for cancel/flush-sync of a work
performed under a lock that the work's handler also takes) and confirmed
by code inspection. Not reproduced at runtime: it requires the
deprecated user-space read timeout to fire while a read holds
buffer_mutex, so the deadlock is established by inspection rather than an
observed lockdep splat.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212..f9b18ef 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush_timeout = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,19 @@ out:
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush_timeout = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() acquires buffer_mutex, so flushing it while that
+	 * mutex is held deadlocks if the timeout work is already running and
+	 * waiting for the lock. Flush after dropping the mutex; the timer is
+	 * deleted above under the lock, so no new timeout work can be queued.
+	 */
+	if (flush_timeout)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 
-- 
2.43.0

