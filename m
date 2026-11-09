Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218257;
	b=SB9NKiLCJMgw8EH1FgdtqWG5jjwfgQwebezRS4ZnHcchG0j3R6jDk9KcQQl98W/hJlO+
	 oLuQ4OkqXuPFSq0Usgf8ni5NuN1t7pHTEhjRVWPHFFyEPdGmP4v/9o4M01Z7S6vnIbD57
	 3qS4cM+ijGAd+Q0SH7u7CKqWKSmnH0kU6nFVNNsPqWKiulW5Dygq7Jq96CV3Ss9pvKMrd
	 a03IWA/wrcycbdQKfdWZi+joQ6sj8vc7mqBKUwpMAmBvzfFkrZgiBCLjSFK0lBnxy4Et8
	 k6sh6eJ6TsZaId+BN6UTl1h1V1DE48ki5AgttBT2Nfq3ln9wxUHqwPG75QxAAXC5v6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YSGDtAVI5NKCQhTmv1CpbLpCOuvRYrihGznKJ/oZidE=;
	b=DxNNdsmwGwNbDWCw32xVRWUbvNPgUtLi6GrzUPn+PpBhfuOMZ8Nw6wcFonyADLIXcyxq
	 zntw3trWTObxECo/n2WlqdqoIlgjCOKkxNdbCXtFsHmD1e8zUyRrMN55ZjpG0eeSB8Jic
	 rXaP68jgB3vA+3clRpqpTVMJnZimXjVKQOUbD8ZWt4idp4acwts4J1VRTovvNJ9xLB9sz
	 QZtImfm9tzf3wEa4itmC+8ul1iOj9P2dHWAxh1Rt16n9uqmy1DaInWuzPalYyfOoESTZO
	 7+eT3UEYbfq1307Zkh0Np2zKzWdrdh4dpSzHxSujIs3vb4qfU45jo9WxoUKDl3WGxig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc85Q+nF;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DC606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A70DC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc85Q+nF
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso422896a91.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218256; x=1794823056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSGDtAVI5NKCQhTmv1CpbLpCOuvRYrihGznKJ/oZidE=;
        b=Wc85Q+nF1L2NMmYulDMI9aHB8p+FTQdXo5F+8CbjBRtWYH68b2Bwvh7/ZJ2pK9C+xn
         sBXII6wFQ/t7jVRthLl/G65GpVfewrKUj2hPnwrnn0Y0pmrbRMF9l7uIX0ubuDDRo8UW
         j3Im7WwE18LzBPuWlwcRS6c86YSGCa6r5n0lSWSsZqm9rTAtHlEy+OovuAmH6I0Fl9F3
         Puxs/BhkJ/Bex926XJjYWGxy+VhivyXh5B3GNaiSjWzuUb3ldlULylZVr2AKWZx5a1DD
         7e7+dLIhuWaNKsPh74d8HD/k/29VkQprS2yfq+DA2RlxzLazhMAuFNc3ADXTLuK3NT4o
         p2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218256; x=1794823056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSGDtAVI5NKCQhTmv1CpbLpCOuvRYrihGznKJ/oZidE=;
        b=wZxO1/ZNAnbiFNm8yZL8/q8UelLgjT6V/COD661eHcicGh1xTrADx1mMoysdr6yR+V
         UiUNxT+dmPSzQmd3hmm+p3nj1QHfmb4+0toz/ugOM63y9eYyFG36/rRQPwtamoFGChyb
         Gqw7Ott1nQMhKPqeDT0Wak20tGTLatLMvrhkNOguOkmYXIsnek6vCeMu6KHsenbNscgU
         nzyGhDAD96UfxbLmSPOjrmW8d84VzE1ScqBRvJYbOvrnDhaT6J3vajy3HBaQPfW4QZAv
         zOiKUgd4U4Ud47iiLy42DMw1RzOznfw+2AbCXZyoBYzEaoiGLixrW2FrUEVg8aMSfHce
         lM7w==
X-Forwarded-Encrypted: i=1; AL+hErF7Ud50l/ph0vWnSPvPSq7LAsakFcIcvroE28KUieowpJaPiJkRKB6vdzZuQL7OOILLEIqfwwE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1teakS/cKaOKmOSXJ0vM6r27DbQ33APt88YBCcoux2hFfIrOM
	adkz+lH53Pmax4ByBYX5Dg9T+JnaDnmk/zJs8LqDtNKByyiCJ6qUB5Zk
X-Gm-Gg: AYBFou1hiThhS3OaoHVswerBsPAGF9DNvnuWen621lYJNAIgbpglDpeWidNdtopJcaS
	TVdH4ag1EI8Mxxq13Phxs6GYFamcYeuHkTbSAWt1RLQPnrHl3AhqMNvoezVQt3xttGnQIzX/4MQ
	Gx9yFbUrK4EwYed/y+5OONL5ChTpR9LvsX5Lo+SCk+n3ygWbHwy2xIcFBhWuGSlrkg9OhVPmXAb
	Btkk+9Xe0vwihtyp74xG0LI9Xi5QeG21/OAxoAqPbnaZpCMdt+Hf/g2bq+0chhV14ERNKqaJVE+
	y/4SlwXsDHabpeoWC5k5RSFC228vOpYTJAeytjwZtcFf3ecfrc0AN55ktYwgZ5KyPUicYJkg51C
	3bsXkq+4vmjmR0JcKXgSfOOH1oHv6M/5dCFMo48IJ6w1mwhdO8z5L6n0ahxOvoCvnFga0kLGhv2
	o6xPS42qr3W5ZV8ue67uiBLnmnGkRy+poaAzGivp0HBLm+9YCTRKoPAt4RSNvQtAmp2X+uOghzV
	mMuWeK6h0xC8oE0auje81JbWIj5SYTMhjCvfzeDrkDaWUyvIB+cSuVDd9C8+jjD1AKkbjFVUG5f
	vX51pXC38ksjQZRM3X+sDvAwq4SbFGsjC8ZzZy/VKfYt/XJkHuIP6eFcRYR56YDUHTl6tmfdAjR
	7FRuyYOzEC0izAak5W17oNnOLkpD/au1c2rq8eswzes3C5a6bI4+RE8dNIiOzbPmzclkTOGKpgu
	9wNg==
X-Received: by 2002:a17:90a:fc4d:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b12d441a33mr3608057a91.29.1794218255891;
        Mon, 09 Nov 2026 01:57:35 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278d1191sm6728852a91.8.2026.11.09.01.57.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 01:57:35 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Mon,  9 Nov 2026 19:57:28 +1000
Message-ID: <20261109095728.59024-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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
v3:
 - Add a blank line after the -EBUSY check and drop the one between
   current_trigger_store() and DEVICE_ATTR_RW() (Andy Shevchenko).
 - Move this changelog under the --- marker and send as a new thread
   instead of in reply to v2 (Jonathan Cameron).
v2: https://lore.kernel.org/all/20261102034532.33246-1-yuz08559@gmail.com/
 - Move the trigger swap into a helper, iio_trigger_set_current(), and
   take mlock with guard() in current_trigger_store() only, so that
   guard() and the goto based cleanup of the newly acquired trigger are
   not mixed in one function (Jonathan Cameron, Sashiko). No change to
   the locking itself.
v1: https://lore.kernel.org/all/20261026100246.68005-1-yuz08559@gmail.com/

 drivers/iio/industrialio-trigger.c | 60 +++++++++++++++++-------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fe..74058f6 100644
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
+
+	if (iio_dev_opaque->trig_readonly)
+		return -EPERM;
+
+	return iio_trigger_set_current(indio_dev, buf, len);
+}
 static DEVICE_ATTR_RW(current_trigger);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
-- 
2.43.0

