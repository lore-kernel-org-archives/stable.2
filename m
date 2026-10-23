Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756165;
	b=JAByy31ddw0K1ciQBlukgm1cVUP6UkHP6AnzXvnkhUfSYHYQQORCpBfGf1cTSaiPIjcM
	 T+P2sQRNd6Suc6CkyMkxTYcci+8QKdCGKMS0XYMnU1rOV2XDW81ITAl4fFK3RgRU4wupC
	 bis1Qt0k3eXg4V5UiuvgbozMYA24eGhA4t629i9c1NoPNiIzjkqHHgLcF3Vdr0CU0T5TT
	 t53Msc6enh1huc8hx5W9VO5WC2d9Dlfu+/AafPa6pRv+VEHfU9LZwnMq628Xun8sY9tlu
	 D9npckvC4zgaj+LFtZsieBxaLjco5dUZZYrQkPMCAC6lQQhZCPCUmm6tBnmeSTFbEbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756165;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=PgdvgbOs8Ip8pEZuOttpd3PTmi4ldTAfHuypoKwXcZU=;
	b=RC9gkRfD3CzS+1qoqwed9YuPNG5YlQ069WkaQKGwMx2piBJWGEUXOScb501brdMfwJmX
	 /awowrl5M6dSl51kyj/adKJwji6rSILh/6GOMHcXwuNcwBw9eTE2+eQNAqjQ9i3JyNcKS
	 hdwJ6sNf+dmAxikXYNVBdgIfgUbWtcXviApCn3o3sh0qd3V4OuQ0ipKyY7BtfL75HCXZt
	 ZQ16NsK7sOZaMj69VQKtEOHHzkogftFW/EEjALu3r1h2hQn7LyRVa6siRiVcSBHN4CFQt
	 s2mLYcwx14r6O2WleY7qIDqrxiwvQZxMSAKrMrxu7pe1Ts2/+WIxKs7guj9Bqewsucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=diG2PSdy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vJV1q+b5;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE7606A31B;
	Fri, 23 Oct 2026 11:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10BE7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=diG2PSdy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vJV1q+b5
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792756162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PgdvgbOs8Ip8pEZuOttpd3PTmi4ldTAfHuypoKwXcZU=;
	b=diG2PSdypOscM3SGF0rAehbFvDBFkfPQlYomtKie85144bSIMZ6RDT95yYRxo6GPgB8ric
	c2tjdcc7IqtflEyNlXqMelVZCw/FK8L5miVHGxOzM9J9G17rHyrpblhtwwAhz22HdykW3q
	K/e5Xk2CtRfRxdtuO0I1aUVOxH4HYG16+XaQj0CWfZXNIIwk0LxPTFwrgrd11yzZDxpyWY
	x65M1zO7nMthvdOeg1RS9o657ZKnfLNsj45qNQb1plG7ON/6A0ft9fYhL5nGn1rEf+AqY8
	2q4gnjwRz4gwf8g0UlDAhszv2rMX69tdMyM0+o7mPwLTtUSSBf5p/MPO/CRrrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792756162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PgdvgbOs8Ip8pEZuOttpd3PTmi4ldTAfHuypoKwXcZU=;
	b=vJV1q+b5OYIIplhsI5aK9eqt1g7zS5hkBRJmwUU4ZirQOviIGbjY2Ahx5009r4P3Fo9vtI
	YNg6320eq4NNRGBA==
Date: Fri, 23 Oct 2026 13:49:17 +0200
Subject: [PATCH] timekeeping: Update offsets on sequence counter retry in
 ktime_get_update_offsets_now()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261023-timekeeping-clock_was_set_seq-v1-1-61c4c53d031c@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrBvQEar2KqVISH510EabERXEu
 ze4eItv805SRIHSKzspYhOVOSQUj4zcYEMPIz6ZOOdnkXNpVvliBBYJvXHT7MZ2t9oq1tTPeC4
 tV7V3qBtKjyWik+P+vz/X9QfCfOBlbwAAAA==
X-Change-ID: 20261023-timekeeping-clock_was_set_seq-d23a278dce89
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792756161; l=1699;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A0hhrYHZHJ06dbp+Jm5W/t7n4uCcnvi19+GwSyMtMuE=;
 b=JSpIcet6TYaZMEZ2jg6XtEceOapvDcHi+NWPI7WKUIPjcLnqotvznKNBxmSBd8MFMpyKZHnrf
 C+W2wTmH/7mD1r1kudpQk3NUkxehjnge4ZXXXWtFOEvoqOKrkBMMGpO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The sequence counter of the cwsseq target is modified during the
sequence counter loop. If the loop retries, cwsseq will now match
but the offsets contain the values from the previous loop iteration.
These are not guaranteed to be consistent in themselves or with the
current loops "now.

Save the target's original sequence counter value so that the update
also happens on loop retries.

Fixes: 868a3e915f7f ("hrtimer: Make offset update smarter")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d54c4d303db6..ff1c08a500c9 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2850,6 +2850,7 @@ ktime_t ktime_get_update_offsets_now(u32 *cwsseq, ktime_t *offs_real,
 				     ktime_t *offs_boot, ktime_t *offs_tai)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
+	u32 cwsseq_orig = *cwsseq;
 	unsigned int seq;
 	ktime_t base;
 	u64 nsecs;
@@ -2861,7 +2862,7 @@ ktime_t ktime_get_update_offsets_now(u32 *cwsseq, ktime_t *offs_real,
 		nsecs = timekeeping_get_ns(&tk->tkr_mono);
 		base = ktime_add_ns(base, nsecs);
 
-		if (*cwsseq != tk->clock_was_set_seq) {
+		if (cwsseq_orig != tk->clock_was_set_seq) {
 			*cwsseq = tk->clock_was_set_seq;
 			*offs_real = tk->offs_real;
 			*offs_boot = tk->offs_boot;

---
base-commit: 348f54c435bf3177baa78201952810b255d44b30
change-id: 20261023-timekeeping-clock_was_set_seq-d23a278dce89

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

