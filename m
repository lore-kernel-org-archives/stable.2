Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008985;
	b=jQk5goEnC3AqnOouJsuXCtL65FKbo4jtVbCQMCzAE0Z+OfqMWVOOghNLpy6Bg6hJHPev
	 Wh1CEFgRscXPRZJhXnE3x6KaNoyaWaVy4CgkbybzCBAS7K9WJgEofR3Yz69ggJ3NHPYCG
	 Uwr6lFnuuV2+hXW46Wnti1DBThinQk+ET/KNa84EHy7x7mYvQ4jJnrNvqfvp96N5pCSZf
	 G/nzeLpNw2gf9ovMGffkA1uykQEb0Ypn9PJ73ya4zb+51+tTdyhNw8cblfI1sPSwzFUoH
	 xsWR0Ljo7KPBZR4OeEbfJTnR+Jh0g0Z4SAsFS/sFFonevVFUQPNy+b2yn0u5joi4HpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DXpJqO2ckp/EX7hz6QTsLqnm/+vAUv9IUn8k0FN2zk0=;
	b=CL6592twEzP9r/mtccm6MdGI39/xO+IEd/LiBPNZKqXdcGAwnLGq1MUFYzUNF8I7j6AY
	 YeS5LOCn+agPayjje1MrhnTeWgo+8Md/qs0ACFmeb3BjrNMEoesvHSQsck1VAxMw/Cv8x
	 JEoVphYhKPzii9jkpKU4/HgzrRH2Zs4RE7UH8cilE7BYV5AvtrwAWHZuN3QIGGKBGi/Gc
	 9HpSAbzeWjb/LZvIml1NkH9naMCmyfH72xMOF5KK9P6nFYIDxCWBNftqwEdw5UMOJUxaC
	 rneeNE4kCwGpvVe51GeVFxBGmdwmwAPOmjOEYni1FuNR94/KxGJlDZAIkMYbz+u6rxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Th5kBiS7;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B6606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD5B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Th5kBiS7
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89f639ba307so948749b3a.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008984; x=1793613784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DXpJqO2ckp/EX7hz6QTsLqnm/+vAUv9IUn8k0FN2zk0=;
        b=Th5kBiS7rQtx+ZPtW/XI5NlYv6ndEQ3BLDezHD8vkN20oXlVNQYo0W6lygaeZTsa41
         K2mBJfF+KE+C5HfJCuCdnedjJYJ23bbgYoOBwQ2+3tpdRi66VCh1eKlWxr+VuyVfhmXQ
         vsn+J4+QTkHXgZf72WHT2VcW+Y7pMKcz1FAceJ3erRT03CkcjYZBCJIbDElB3mf/F6F+
         ua1i4df6eyognp+CJWF9IDzGAIX9GKjVnl4dCU7dIl9cnYlwGook7MHredWDCY2g0IVp
         jxQCzf8804PZ+thtHYb5wAMGGOY+AFej6GxUSOwRf+72IR+49AQhfcC3Ohqc2ZtbTn9D
         HNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008984; x=1793613784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DXpJqO2ckp/EX7hz6QTsLqnm/+vAUv9IUn8k0FN2zk0=;
        b=n1Xhu2KaM8+xshIDyBALqSN6pxoeS5XUxMNPJ8g03c4umTEXRnIvQXBFKBC1VJfKf6
         2sgFrx7npixUmGfhd3gIjxLnDTcUEVdOimHjiySX4BSzhX2cFeg62LE0LJlYFkAJLGpI
         OlNhXWccPqA1ANOiKLJeE4z/L0ULGMV53vtTTkQyKO3Yrx4j+Vee0NHScWSq6HHlK4ql
         mzT4ujMowHBqHG4535FGnaKYz4VOgpdc7l3ErLi9ZcQRwDU4Oo821nElC9HtpzvBFrw8
         YVfxrCR3UByZ537zugcDXH/ZkvfiZkzYr39Mxk8nNQ0viqE44eipNvXgl++iKkwOOb1H
         siVA==
X-Forwarded-Encrypted: i=1; AKwUvBx2RXYGnNLymxI45jZyqEMSC70c4QHdMWZxhi7QkuL9NN5Zj6rmaOkSGtjgTIJ4ZMZX9l5/9cw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAEs22eDSgW8TTQeWte4OQjIKzFY67rjbFH9ksZ0Eco9zGPzie
	Tu9Th1jVcsGeKt9ahWS8QYq20jZfQMSbRD4Lj9+ynk5OrSGUYp27tTHr
X-Gm-Gg: AYBFou18OBUf4yDA8R4d/1SdBjFyI/4YDXDeBICXpU3L07blHFCv6W1patdr4T0SJZW
	JEd4hccw5+EY8atdaCSRPzd5RstWwrsMY75am6g2HxpNldNjz0Er4oqQkOah7B6ag74fOsao8N9
	UbGlsJFPIBv0EkfDaIr6tJJgANIESx/2O9UCv3RLq1mES+pTuImnbvAPEHS2EcSc4nw3z1KJIKg
	LEDKeotHfxtyrU35Rn9jQvUfGs+xMUcodwHv6cTe2/COyRhcY8PfmgzeF5A6ih+eiv+9Nc5Vsna
	4puM1zoH6YSViydGu9Pk7+JVAp4e1xBeQDED6lVTN7m4SYaGz0A+qnYjFSxKWdsyWFZZcPK5/e2
	OfzH6SrFM6aPyIUoZNAjxU8ExoAVBuXGSjg51SaWZagWyvoXCn752rvGM66+sn54kg67vm5FeyF
	XqEKArjbR8DoAVDpv/9XFBbJyNWc22mIO+6IyWU/v30YqFxqE4P8Cr9eUgyJBjayh95fQTjy28w
	bTbQ0b7qc2rXBROwlGoJ1x89p1MRGu1y05sThpHhC1fE5rd8EYJw6M55bFu8r3ekEZjjK+0vAAg
	i+gUwnMQSnwzdu4OtKVOjYFOoEi84hXqA5mbbhOVQZSimstw4V00DHJZ3fVbuc8AT/g4bDMWgIl
	3PSiXymVBjPJWDlpfEBba3Ua39V0p
X-Received: by 2002:a05:6a20:6a22:b0:3e2:8c30:2e4f with SMTP id adf61e73a8af0-3e7cd4f5d8fmr4700592637.66.1793008984058;
        Mon, 26 Oct 2026 03:03:04 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccccf37esm1425204a12.27.2026.10.26.03.02.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 03:03:03 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Mon, 26 Oct 2026 20:02:46 +1000
Message-ID: <20261026100246.68005-1-yuz08559@gmail.com>
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

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fe..9241cd6 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -441,17 +441,18 @@ static ssize_t current_trigger_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_trigger *oldtrig = indio_dev->trig;
+	struct iio_trigger *oldtrig;
 	struct iio_trigger *trig;
 	int ret;
 
-	scoped_guard(mutex, &iio_dev_opaque->mlock) {
-		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
-			return -EBUSY;
-		if (iio_dev_opaque->trig_readonly)
-			return -EPERM;
-	}
+	guard(mutex)(&iio_dev_opaque->mlock);
+
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
+		return -EBUSY;
+	if (iio_dev_opaque->trig_readonly)
+		return -EPERM;
 
+	oldtrig = indio_dev->trig;
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {
 		ret = len;
-- 
2.43.0

