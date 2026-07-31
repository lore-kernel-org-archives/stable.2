Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865A3F1AC4
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499436; cv=none; b=WIxzXZJ5Mzv/kVFQGZlxAj8c6uQ5osAJ36X4lHob+qeP28K6r8pZrFc+HoaDUBTZbN2xmjw12CLFpDTButHBhJTbKe+QknvP2hHsxQM8KSBrN1Pm4UcrJXjDZ/lorp9prN8+DcBitFCU5Y8XoA6jshJtTWv4ie4k0u0KRrDRnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499436; c=relaxed/simple;
	bh=a3u47kRr3Do278tdnqPPYoZAssH2IdMcqqRKQFentd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsWsl4NYzu6pS18jju6LvKMm54rB1Bw9Z1ZblNny4i6LVlEo36soeIaIiQngZiF7g+uH4Ty5Eq+NETmuFr91pjnPehjrVu3Vs3MPH9R8UOFCZxN5n4mq55dZdi4YY1Joiv7yJQ2mca2sh0Tu6W6PAr8ASIY4P4ew+AP4qqzA5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QZOauCFr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QZOauCFr"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efb708b1a0so5776076d6.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785499434; x=1786104234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzP4sK4hBb/8A2cn+zbTFn82mSE4pQ11vgzpnhcOkCA=;
        b=QZOauCFr3xyLEDBIb7cKExLNMMpFwSFMmaSe8Ol+FwpNMQV/RHYreY95FE1EvFzq3R
         oEA0PI0dsNmdKEUoPgVJOe975hPQazJEqcVpy4kdOGQh9uwz/XPGmHrrulzRoNflemTo
         Y90f/KjkYnUK55xPM1dbKrFEjAMoX/hpy88ufM8TWhioZW0/eqU8HJ/TfBcRaLU5RjRm
         83YuHz/rYn6FWJoJbAiRp690I5ENcWjAz3D368qZtRwFKB+609r+/7ofDoOyQV2mZQ5R
         jTvC5vpgWgCepdbYi93yyrxvOLRcEkqWa1PMwGY05b7RGLSAeSFOop5PFTfKE2HGrmJe
         /BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499434; x=1786104234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzP4sK4hBb/8A2cn+zbTFn82mSE4pQ11vgzpnhcOkCA=;
        b=ZFpK+DbApComoQHok2a7OfAO2BYMoF3AV8NG6B/TMwweVnht9HT+VSydCVyfNiLfQ2
         rSNG8G1DU65vHab29zkKgH9d7+2Rn4QMUqE9wKMZOv2HQPCjRnmklo4nxpu6QekfMTqR
         aBrEg8C7V2mja5In2vtcMKb8Zt1Ge0qWM7JNvGJ90CR12Dt6bIPN/mZCLpC/lQg3rC9T
         nV4KaTkzVf4MTfn3kEivf+P8TYxvZ703peP4waynVNaOMhQKbcqjfw8/+z3MBJl6NBq1
         Hc+iT8tYY6MKtFp/MKkIVjiXxdOcp/updE45XnywpTkZGKbqC0QhFBfy2ZsQnGpJlSkW
         4KVA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8379kU/1pHI41ytdyXW1AeRRL+iwtSXuA1FITQLRszXsoAQrpqKTluZe7f1TYdxlhQBnk190=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMsrnOmEJM3L7IuFwHi2ihiFuwRQQRbboS88WT6H4fQdIlMil
	+0yAgudJNABeNcYgwDuOzJb6N0i2cE8HkItUh3GeYSo+MBN/+7P4iC1a9GhfpBTDhDM=
X-Gm-Gg: AR+sD11JNL++lswV3CbnPWFzzwmjlEqSjXEIJp2mlOYcKXdYzsNISVxTKzyZnqWL5Oa
	wWYcq1pqtDZsFOqnGP7NruKjbUSDck5ecJjVOwMzr2BDhnGOSuNkN+MNyeMBxfcJpUAO6wzkaSq
	v7XxA6f4IPEJOZb732vdbjEta+LXc1yu7qhxPA4eGEEuxFCx6hXOTEIHiobJVCCB30SLmZm71ND
	MoG68dlh/yzRblsydDQEZZfqmEBf8wk+FoSEE0Vtgb6V76rdVNFJ5qbL4v3sXEadxl6OgsCj1dn
	uSjBuZV35nXlCJgfN/jUiYDrdq/q/FjfZ8UKj4d6q4oeTNVEWdbA5N4EvNoUFhENKoQfegojUFp
	Vvwj5w1N9PUdqwI+XBPDvMPpWTQh3R5JTs1GxGmqtlJX/BgBvaXpb2NjaemzHBVx/vi9xLotlVX
	2Kug9+NwTv5MY3I5OTmWSUnP5Z/WjBXovNjFAVkdSHuQzJJEo4hUEEmVnRcjJIqZseNw==
X-Received: by 2002:a05:6214:2025:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-908421a38e2mr30020526d6.4.1785499434242;
        Fri, 31 Jul 2026 05:03:54 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908435def8fsm8686026d6.38.2026.07.31.05.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:03:54 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: miklos@szeredi.hu
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fuse: wait for sync init request after abort
Date: Fri, 31 Jul 2026 12:03:52 +0000
Message-ID: <20260731120353.558833-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a fatal signal interrupts synchronous FUSE_INIT,
request_wait_answer() aborts the channel and returns immediately.  If the
request is in an FR_LOCKED reply-copy interval, fuse_chan_abort() leaves
it for the writer to finish.  The synchronous caller can then free the
fuse_init_args that owns the reply destination while the writer is still
copying into it.

Wait for fuse_request_end() after aborting the channel.  This keeps the
synchronous caller's reply storage alive until any locked copy has
finished, while preserving the fatal-signal abort behavior.

Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 fs/fuse/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3..deee1585d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -725,6 +725,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_chan_abort(fch, false);
+			wait_event(req->waitq,
+				   test_bit(FR_FINISHED, &req->flags));
 			return;
 		}
 
-- 
2.53.0
