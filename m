Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591148;
	b=MFhHo2JSWzAwy92+jHXQdCTvpevp83YXfUJP71zy40XM+QwDpZ6COUAh1EGDfKe/Vsas
	 qwhHS4aym9k3hg0NoU5vCYpKPP4ApT3nJRvfY8AO+9wrublfTO5QTHu+Zc7R9PUrjOM01
	 dvrKeBClxB0bbjuOkp7Kub9wi9PIGGsh8QJP1lvEqoFYlVPk1dEFQaK1Hnwa44dBOPhYo
	 68zSY/CZcXy+cz6sNi4imswKbwBFPiMXH+chqZTJMrtoLlT7pWR6rFUgpCoothlkjWic4
	 desvgJutpKAd3ZTbPuEwl2HLd6EDO/SgbV8k7zzYojlvo3hJukGtY3wMyje/hA3LV1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7653Z25URCQw51Ar2IS4ZcgvokQrZoYW0xDq4LSwubQ=;
	b=3yI8RttAHiIBPI/z+XJJ4CYqFXWVajDR+ilrt4vjr0IVjUJz7Idi7ArmyLJG5GdY6dIS
	 36/bBUvoprPoE3fMo+ZWClHmYNsUIyTc/irXC7qaFL5trFJFlNoxK/rLf7rJunkw8tcbB
	 E1p3iXXmy3J1SaFIhdKoXHferpQFonoIZ0913bqx3otX0XS5eZfqmmn0mAfXDm3yuJv0w
	 CuRZ0NnOeG+HoHHbH61ZjYdOytMooruT07AhGXjWzGzsmY0ijK2k2y7I8d33rz+dTD/pe
	 fkUoyO9wTn7EIjx7CuD9u3YsT2FUnXga800F4lOdkSp+wJ+Z/c+DNzLAhbhT8Xn3hVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wul8qBKR;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777B606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 03:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C777B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wul8qBKR
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535a54bed9so3876489eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 19:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793591147; x=1794195947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7653Z25URCQw51Ar2IS4ZcgvokQrZoYW0xDq4LSwubQ=;
        b=Wul8qBKRAP0Daw2OPIL2Cy4HHNJ+FoV/0vVmVHZYOA5NVJ5gWZDkIRPHdDSx8covUr
         uWzh8og36uKFtFcS3tbT3hTw5nyaoGRoegdsnfemQEJTIyMWNuzegAW4uHUBOdgr8ez1
         noUeR0laq2sce1zBSQl8od17Q1KFMjYxdNaqWvhyWMnP8nq6CEjPfEaRT4GB5+tbEnea
         Y3tACXNmFc2MDq6qRmuql5mQqeR+NyU6yFOHIRf88d8YzZoZr03WwRKKb0hKrgsvdy+3
         L3Nf+W0WvLbQBv2mjfZOUdVjrJPw/x/ouWtd6xzBYGroEB3fYV0WeaokxUqQQHho/7tb
         eXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793591147; x=1794195947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7653Z25URCQw51Ar2IS4ZcgvokQrZoYW0xDq4LSwubQ=;
        b=TlRv5T3lDMzvRd5+6iYxhOnE+FXeoCM2USCbt/FVBjDhqoifaWLedbqxhEiZyMMcQP
         ZUf0Jh210jHsTy+anAu+VioDvLUdm1qwkxS5I8QiM/6evQp2KfPqpEITxpfHXI/2rGFb
         jc2dwVRJgUn7snS3yGPeeAhnEd5b14jNKrmn8uv9rMQg3wE6iOlpS9ZdJcNkWFxb/MxO
         hJt0LK7u3QU2BzgkEJQtRTEY9reMmozHRrEE8KnpJfJ07Rjg2hFj9+TMfvykEJdhwC3h
         a34RpGlJLrIZrZ+rN2RSyomz2BooRpK21exFvkcUjUxRUKofrFdOd59OMvxrTR57fv9A
         X70g==
X-Forwarded-Encrypted: i=1; AKwUvBzLli+PJT5o+8wbVLF9bu0FokcxBiMV0Xe3f7uYCpy9DfdSSmJeNzQ9o8R0mI3h+6B743hfmH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M+FSIaLbfQB2xib+PJRSs9bF6ElMAy5iAcv0Gl+55rvHvVqtU
	q3a2um3aktHBcRt2PFtiLrDeGfzOBil+K8hglE5gAGKxIdutkFjQsSU2
X-Gm-Gg: AYBFou18fiL2lXML0u3vpijheL7sadLH8vN1u6XEHS07K5Lo8j/4iwwa4qs+S48+KFM
	vzbr/UFbbOKLLsElJBCM3ksSGqeVHrfhKcsPILjOqYnZGAuYlNTuET5lp2jPkf3ndQqvLf3yEEp
	sR/BMchG96d1N7yLmv+5xKIPHUMwyfeTZqXRiyoC9BmQGE6/+Ow2paeRyM7QHpsnJQ7NGEB6ChZ
	twyMj0fVChyonbyNELsBu6FP7X1ryjTBlkET9qisw2oM4Xfe639DUWxJdCN9PGcMRnQBisw3iak
	tifDG+IE2kRxTPxjTMCE9ROu7/UXdWCq3lQ9a5OnhdsZr35hekOjsTNIetAplqWdWTssjsZi0xe
	6JOUe5A8TJWrT2Oi073mtCcZgBl6Q9pK79F3aI0UY2GVuDAj+dPStPr7w62Pr/y5vHfX85ULOsh
	m27SJ/waygYCWSRK4lOUkbC3Iyf01PoeWsi+ZVJ8E8yOUd68vih/iiEb2M3wIhkPLtoDNAxJ29I
	eZYkxU6dVuY95H8FJuOaonERVnrfiwLOkiB4wd1qmrJAJuQCwZ44j0Uln/TDi6VtNKgGb9F5nXt
	bnCfTdpASTZhYdM9iUzQRP1HgpkJ/A5zmJaei1k9DtIg9i5JSTMEP2c/Zd5EbKaNmoSNPIfU4Vm
	BMc+e9irI1cMoCDQ4VgcpdB8Qv9IuPJ6Mwex534TNS2GIpQAIwOjA6lGn0GbNiYDkThnRVhSTu5
	DDI1Oa
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a425e10f8mr21842182eec.36.1793591145568;
        Sun, 01 Nov 2026 19:45:45 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm33470820eec.21.2026.11.01.19.45.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 19:45:45 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Mon,  2 Nov 2026 13:45:32 +1000
Message-ID: <20261102034532.33246-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026100246.68005-1-yuz08559@gmail.com>
References: <20261026100246.68005-1-yuz08559@gmail.com>
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

current_trigger_store() holds iio_dev_opaque->mlock only around the
INDIO_BUFFER_TRIGGERED / trig_readonly checks and then drops it. The rest
runs unlocked: it reads the current trigger into oldtrig, acquires the new
one by name, stores it into indio_dev->trig, and drops the old trigger's
reference with iio_trigger_put().

sysfs does not serialize writes to the same attribute issued through
different open file descriptors (each open has its own kernfs_open_file),
so two threads can run current_trigger_store() on the same
.../trigger/current_trigger concurrently. Both read the same oldtrig, both
overwrite indio_dev->trig, and both call iio_trigger_put(oldtrig). The
extra put drops the trigger's refcount to zero while it is still in use,
frees it, and a concurrent writer then dereferences the freed trigger.

With two sets of writers hammering current_trigger between two software
triggers on an iio_dummy device, KASAN reports:

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 3 PID: 3467 at refcount_warn_saturate+0xbb/0xe0
   kobject_get+0xf6/0x100
   current_trigger_store+0x15c/0x4b0
  ...
  BUG: KASAN: slab-use-after-free in current_trigger_store+0x168/0x4b0
  Freed by task 3468:
   kobject_put+0x125/0x220
   current_trigger_store+0x2cc/0x4b0
  Allocated by task 3454:
   __iio_trigger_alloc+0xc7/0x100
  ...
  Oops: general protection fault
   __module_get+0x27/0xd0
   current_trigger_store+0x192/0x4b0

Hold mlock across the whole operation so that reading oldtrig, swapping
indio_dev->trig and dropping the reference are atomic with respect to
other writers (and to buffer enable, which the -EBUSY check guards).
Acquiring the new trigger with iio_trigger_acquire_by_name() under mlock
is safe: it only takes iio_trigger_list_lock, and the buffer path already
calls iio_trigger_{attach,detach}_poll_func() with mlock held.

The trigger swap itself keeps its goto based cleanup of the newly
acquired trigger, so move it into a helper and take mlock with guard()
in current_trigger_store() around the mode checks and the helper call,
rather than mixing guard() and goto in one function.

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 60 +++++++++++++++++-------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fe..cfc6af0 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -421,37 +421,14 @@ static ssize_t current_trigger_show(struct device *dev,
 	return 0;
 }
 
-/**
- * current_trigger_store() - trigger consumer sysfs set current trigger
- * @dev:	device associated with an industrial I/O device
- * @attr:	device attribute that is being processed
- * @buf:	string buffer that holds the name of the trigger
- * @len:	length of the trigger name held by buf
- *
- * For trigger consumers the current_trigger interface allows the trigger
- * used for this device to be specified at run time based on the trigger's
- * name.
- *
- * Return: negative error code on failure or length of the buffer
- *	   on success
- */
-static ssize_t current_trigger_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+/* Must be called with iio_dev_opaque->mlock held. */
+static ssize_t iio_trigger_set_current(struct iio_dev *indio_dev,
+				       const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_trigger *oldtrig = indio_dev->trig;
 	struct iio_trigger *trig;
 	int ret;
 
-	scoped_guard(mutex, &iio_dev_opaque->mlock) {
-		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
-			return -EBUSY;
-		if (iio_dev_opaque->trig_readonly)
-			return -EPERM;
-	}
-
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {
 		ret = len;
@@ -492,6 +469,37 @@ out_trigger_put:
 	return ret;
 }
 
+/**
+ * current_trigger_store() - trigger consumer sysfs set current trigger
+ * @dev:	device associated with an industrial I/O device
+ * @attr:	device attribute that is being processed
+ * @buf:	string buffer that holds the name of the trigger
+ * @len:	length of the trigger name held by buf
+ *
+ * For trigger consumers the current_trigger interface allows the trigger
+ * used for this device to be specified at run time based on the trigger's
+ * name.
+ *
+ * Return: negative error code on failure or length of the buffer
+ *	   on success
+ */
+static ssize_t current_trigger_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	guard(mutex)(&iio_dev_opaque->mlock);
+
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
+		return -EBUSY;
+	if (iio_dev_opaque->trig_readonly)
+		return -EPERM;
+
+	return iio_trigger_set_current(indio_dev, buf, len);
+}
+
 static DEVICE_ATTR_RW(current_trigger);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
---
v2:
 - Move the trigger swap into a helper, iio_trigger_set_current(), and
   take mlock with guard() in current_trigger_store() only, so that
   guard() and the goto based cleanup of the newly acquired trigger are
   not mixed in one function (Jonathan Cameron, Sashiko). No change to
   the locking itself.
v1: https://lore.kernel.org/all/20261026100246.68005-1-yuz08559@gmail.com/

-- 
2.43.0

