Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141175;
	b=Ushue4tuT8l6WBVFK6CShWcVyHLyyjDL8W5t9D7VBythses0xZW9IUrgukyfUyi3MzyI
	 W83z/xIEFNi8V8tnw0l5XeLA8/EKPgmjUXHmp9SwGnxpAXTXS1F3PkQEBVHhSAMuawNp2
	 k20jvFQ3/Vkb1Ba4/BkNSKC0CccsSI10+eV3bkxvpD6y+7cPFC1LGPcCe+YGmIraT9xmZ
	 7AINhfKuNQyhACgv09j96DlQs0VJTef21kvCjEn8xKsElwIX/mJ84DYlPXe+KSlp7L+2V
	 YaX2vyLea9Dko3fMybdrw36JCikH216KHZUcT9PiPKJqRbi4e9FHH6aRpMlq6NAEeog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yKKrVaDw8VhN0ThEY1srVBzSbNH24223CDIfI/w1Bw0=;
	b=sHiMYGX3JP7YfGk+uZaeJ1wnSgoM72lj+2I50qEV/mvd9peTcGQ2JS4K9ZLLjlmHR8sz
	 Zmah+Is0cUzaZCE3vYiVtzit9DMPIUFmW7CV1eZFC8eQ68kLbDpLnOHnGCHgK5+IpQFla
	 VifzUEUfU6ytDWMEZBr9hxUOmbQ9oxWay6xljzKDCrtGaD3YQUZQkM8iH058+O0RlIQjb
	 xFWKiS44MImHHKTKosdtHlUA31broMFRYHPPPWKBWusxL8vdGXHyau4GlNljiodOGyj2r
	 VhUpvlR+FtVAAWJDgFDjLNDow9Nl/vvWbkknt/m995WJQjr1OnjeIN+4CSyY6ac6kYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNSg2lvA;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48248606D823
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48248606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNSg2lvA
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so132857c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141174; x=1794745974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKKrVaDw8VhN0ThEY1srVBzSbNH24223CDIfI/w1Bw0=;
        b=DNSg2lvA/YwwEds4kUckpEBeQb9JSJZaMJ+7AhOnpdKDZwhkQECjt1S97dHZb0brLO
         JIVeXHMX1RTIk088T0AKg+urcSev4bzUCIKaPTszlcQ+ROeNi83b56okerZdJP0ttVc3
         pB//u4vRcwchCOxuIVqKiREHBMjGFydYlEg8kXVKqqgK4q9S481H5jfNW/DzIrZkXCT7
         hJc9JwaGw0Z3aK2e4MXMvOjgEy8sPZnrs9FvG4ko5KdvLZgIegRFo5+i94aR5OOM144G
         ZIW94yWRYeHTbHfrE8LGqJaeVOfWn4rLlxENx/vKswW0LXJ74C/1HEti5QtMq3H3sED5
         S64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141174; x=1794745974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKKrVaDw8VhN0ThEY1srVBzSbNH24223CDIfI/w1Bw0=;
        b=RhYGGC+yf6dxNu6K/gMpyLjGQ6Xp+UTRVlCT4JUuPma0Y4nc49YdOzaPLPqsFVweVZ
         d3oCYS0vZ+izOYHhsCCPaYTi0wBxYpE1VLMnLBswLvJO7QoGjl4ITpcVuQcon/ooXFgj
         M7JrB9UAKQYjbyTQ7XnIvrrzRcrXjyMKx5tUyXU5pxCe6jjCYgmYM3CgZKQcihPiwzg/
         j5I+slN9DFK3YALTtI6YVspgjGC00ZHFJtM403bB1XXOEjsv50hPnjan+QSEIg6oqZq2
         LzhSJqP1UDdgMNk6kekSoWGQ9xXIBNiTFxkY8zp+zZcihjQUu/twKjd00s8n9l5gNrj+
         DLlA==
X-Forwarded-Encrypted: i=1; AL+hErHlpndgmp+QSpFGMIJ+n9WbdH/NoB/K2kc4R+bAzc43y02IG8R6AFvPy4BxfNQ/4I3ddH1bHRQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GjQxHC2i8Nr8oFxYEvJaKfXm9d2MA6xTL1Bq0ulfQ9HZUm3uS
	2PBT+OAv5/xKtgFpBULIZomyItY8mK0CuxQmSpTdSdJbVvKl3ixM3RFk
X-Gm-Gg: AYBFou0kBGpwHBzSvGlHS/rQ3ZyVMga3fz/FBgad9TxVlvAfpDsWSLt4nizH+1RXkNb
	0UEFl3ONA2Q5PrYpFcHCszcMtW5RGNYoTdAjyYjYS0qscD1IrKhakLMfS7fLfd+QbBhcR2+vxS7
	VEl7JpAZwgPLYK5Rvc7AsS1vdaEjgdL8hU9gijL8sX4nnaP73nYC60j/S4Ua62nSyZFFMex5yAG
	uZ//6cTmWuX/Vrhk9Sv15kZbT83kASD58AHt4UvgIEIZNfYDyaawE8sqUKLVanGfOSrUMkDFm7U
	EG49JEzW+wLZNsAS7ycU6Mm/UQxTihymVa3IbVNh9sdmWzoyArgGmQOai2bss1Sbz57/kc5FKpD
	reUrdUf7Yw7VvMx9AqZkEaOEokwWCTKmfjaT6PGLR58zOzNvgRNNNhue4Ci737xkNBKLr8uqQzX
	joFIh9Z4dxO568btXAp4HO9674rfWcZHSh1BITOvPc36dQMkS4vtZUQd7UwK9Z1Xa1jpgbHyJTC
	C2z0GwNxkuB5HruSsaozFv6Nd422MD0raTnI+2p90pMobKlmQrGe5a/jmFTrQ52K3Sf5btZDbbs
	NKYx7P/PuD1qJZsu0RyqK4XiW5OCs+XGIULIf6iMVVm5XahH
X-Received: by 2002:a05:693c:69d9:b0:36a:270:ce76 with SMTP id 5a478bee46e88-3725603960bmr2921302eec.33.1794141174312;
        Sun, 08 Nov 2026 04:32:54 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db733sm4767363eec.23.2026.11.08.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:32:53 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Sun,  8 Nov 2026 21:32:46 +0900
Message-ID: <20261108123247.426040-1-hj351016@gmail.com>
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
v2: Rename the local bool flush_timeout -> flush, per Jarkko's review.
    No functional change.
 drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212..97c1b7c 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,19 @@ out:
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() acquires buffer_mutex, so flushing it while that
+	 * mutex is held deadlocks if the timeout work is already running and
+	 * waiting for the lock. Flush after dropping the mutex; the timer is
+	 * deleted above under the lock, so no new timeout work can be queued.
+	 */
+	if (flush)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 
-- 
2.43.0

