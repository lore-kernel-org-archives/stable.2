Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353838;
	b=2Yhcot47+IEJRRaqtgYArwQGAybeOaT5OOjE04jjWmpNlI6xny/KTwtbs3H5jEb9UQJd
	 VitJpCACy6OXAouQKKjCvUSDHL1bl/0mECvv81BRSRpRpyMZTAEUVIWd/OorDkZECmyTU
	 pdLPyCdsxrZNI/ZCagmfjCDosXM0PbEUut3fRqavPKNpsaBn1NdVE2nnST7r+J0lMnEL5
	 IXR5wrQ7Q1shjZfyLHPwozCHo00pgPTVy5C80Sek6uDwqyRAWil9+q82RWkmT9AMfxmro
	 iHylEvZdYKRZm457P4fftKe/ewpOFNVQXH3eANvWV6vwhfk2IIn14c1gmWdOlMzu1vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nucm/aleCVbqWE1ilGDcefpNzHQgxL4IFzC4QCL3uuo=;
	b=Z9Eula8fji48axMviFqK5PvjySWZMA69vyi8ut/tc2C5F76UrVDHsCZ4KjptCHlcdxVD
	 8IbYKFQBYqyaRLHqB9OCdbKyuSOYmFz4W/DAp3pBW8Fq4wjSZiYoGNA9InGV7fo0QN7cb
	 0kC25RLAc0V1LYf6LA80r3jNykrW+Y4stCOTcwuq08CKhlVk/u3ZiSOFT3wO1JnHng7vc
	 Um3Wgp+Hf6P6ALguxxT6ETmVK1uIs87I5n8xNtR6ylfGxXspUbNCmQ5o198iM6mOkDeF6
	 yAZ2TdqSl3lebeucJU6+IMs9ZJqomLRVbNjif9odsyRhIQDd82PQ0PVg6B+VJyjlS+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6zkm0r+;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EC606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3EC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6zkm0r+
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-170135e43c7so337638c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794353837; x=1794958637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nucm/aleCVbqWE1ilGDcefpNzHQgxL4IFzC4QCL3uuo=;
        b=U6zkm0r+Li0Gw+HszhANqyt3xoRZtlLyb5QfVwaorfokcRRa9+8SuufNx11mYAigdO
         UI0ONO0j7dw9r3ouGdCazB9drEGI+AOKGYB2T+u82KQk/BDGn6HbAYh0+b7yF2QGgOQw
         weK1SrNYANzm1DCaTZzA4Cov4dx3vRqGKH6t097njBU/WiyIN5oLKbPgwCgPcxmYxOZV
         I0BvswsPSbj7BbUPaE4qnUFRi3GwXFUGgWYr102xEFEiSEjyqV06LGcvrpn9N9fq7q7r
         qM2hIfcpgE2NW+VbDSKTCJwddFnHub4hDH04UOnjMM0oybYsAN9WWbBTMS4amhaucuph
         SIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794353837; x=1794958637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nucm/aleCVbqWE1ilGDcefpNzHQgxL4IFzC4QCL3uuo=;
        b=q0Q8zs+BGMfugKTFwzdNIbqOKPwEUQ1kUQHm7s4jiQhtArnmnKA4fneZcjNf4JUMwo
         3XJzYGhMw2679oyC2d1ngFdVxnjh9SizrmG6Ah2YMGB7zkDd1VBn5HH7BrkyPnCjEBqJ
         qXDhEY7OquMC0zW2O6Rr1H3ifUUs8RqHwqbMjXnvuwN367mbpchyEgieoxubiFlBvpcu
         rZ1werB1HyKkAu6GD9bwGzQulBWsy2X+RuDP8b7H+wA6GQ5jiD16OycPiDj0CX/jbl8z
         xa+gtOaBMf8hTKDKzK9ZiXuwLiEu9UU5kaYl4sl0ZfZnqjsRdRxPtE+MS+1dexXF4a3E
         fNZw==
X-Forwarded-Encrypted: i=1; AL+hErFzsMU9v/uzOvu041OGAJrSp16dwd6pl8pA/PSKkymq1ADVInHl5pLUmZQnb0LAp0EXTTv6Aic=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nwxWU/KRX3LwN49nA3jObLMEqg4GnY4z1bstdvK494NRRX7qG
	jsAcoUFQUoUhFdzX9zaXsor+zAMcPoJaAJNbmrVyqt3qYzVoZFXtGbFl
X-Gm-Gg: AYBFou3QPQQmoJ69Tql285/Cyk2M1Ap5Py7qEa93b1vwBhFnqXoTcctk8Mw+j1XkQDB
	TqpVSFcWRVS/97EXe/AGWj9aSwt4H5rhUkcfK9eEYvEGRqkLAeua9LfCZ8TNS7kY9T2Cmp09hm3
	qKT8pr6iE7quOnSvmC6QJlRYGYVDLPwsKX/ZN2hjtS5tex89YYP253LMnfHdX81c/2oFbjXmnHW
	IxN9wLxxh/eeIblEQ5NUksQCMF6OPCq98Zrkaeu9MMYljaPGn2TJbagdJWbgjCbFjlIrLT3LeIS
	a6WqewoHEvMthLep+3JnY3HfdoZt8jYdfE/nE5AlaMYEL8c9LNOFK/ynHmNEBDeQXpMcnkFR6tc
	fuicsppVWKIHWy7QYaWBXleQFO7x3uJLlsR9fCrqoQF0eKa7JwRrjLx50yvsDKIfaOXT5kbMOp/
	fu0NzGKXAQm91N2hL8be2W9s74g2+tUcOEOuSgAFqtVz4U30ZHiW079acgOaN4uzWJXxY37CUmp
	UsGcOc/TFoJmHQow5q9uKwZqibKNKGeoqyALvHU1qxq07AhCB8EF4dt+BTgUi1jwLV3y3SK84Wi
	5AY1XKm9OxOyURe/TooSafLvEJahTYO5RtvHZFO1KJ+cmItbhLCXElUZAmPlN1tD2+4=
X-Received: by 2002:a05:7022:2608:b0:18d:96e8:b913 with SMTP id a92af1059eb24-1b3c036707cmr794553c88.47.1794353837204;
        Tue, 10 Nov 2026 15:37:17 -0800 (PST)
Received: from localhost.localdomain (wood.seclab.cs.ucsb.edu. [128.111.49.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm11981419c88.7.2026.11.10.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:37:16 -0800 (PST)
From: Praneeth Balasubramanian <praneethb2002@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praneeth Balasubramanian <praneeth@ucsb.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: hdpvr: Hold io_mutex when restarting streaming after a timeout
Date: Tue, 10 Nov 2026 15:37:08 -0800
Message-Id: <20261110233708.318348-1-praneethb2002@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Praneeth Balasubramanian <praneeth@ucsb.edu>

hdpvr_start_streaming() expects dev->io_mutex to be held by the caller,
as its comment says. Every caller takes it except the restart in the
read timeout path of hdpvr_read(). Commit 6bc5a4a19275 ("media: hdpvr:
fix locking and a missing msleep") added the lock around the
hdpvr_stop_streaming() call there, but not around the restart.

The restart checks dev->status before its USB control transfers, which
can take seconds, and sets STATUS_STREAMING afterwards. In that time
another thread can start and then stop streaming with
VIDIOC_ENCODER_CMD. hdpvr_stop_streaming() sets STATUS_SHUTTING_DOWN,
drops io_mutex and waits in flush_work() for the worker to exit. The
restart then sets STATUS_STREAMING and schedules the worker again. The
worker does not exit, so flush_work() can wait forever.

Take io_mutex around the restart, like the other callers. A restart
that races with a stop then sees STATUS_SHUTTING_DOWN and returns
-EAGAIN.

The missing lock was found with an LLM-based tool that checks callers
against the locking rules stated in kernel comments.

Fixes: a503ff812430 ("[media] hdpvr: fix interrupted recording")
Cc: stable@vger.kernel.org
Signed-off-by: Praneeth Balasubramanian <praneeth@ucsb.edu>
---

Notes:
    Changes in v2:
    - Add Cc: stable, as the media CI requires.
    - Resent so that the author matches the Signed-off-by. Gmail rewrote
      the From: header of v1. No code change.
    
    This was found by an LLM-based static analysis (GPT-5.6) that checks
    kernel code against the rules stated in its comments, as part of research
    at UCSB SecLab. The patch and changelog were drafted with Claude Opus 5.5.
    I reviewed the patch and take responsibility for it.
    
    Testing: builds without new warnings with W=1 (x86_64). Not
    runtime-tested, since I do not have an HD-PVR. The hang is from reading
    the code, not from a reproduction.
    
    The patch applies to mainline 9ba46df34488 and to next-20261109.

 drivers/media/usb/hdpvr/hdpvr-video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 4290b2367fa3..b7afcebe80e6 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -475,7 +475,9 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 				 * streaming.
 				 */
 				msleep(4000);
+				mutex_lock(&dev->io_mutex);
 				err = hdpvr_start_streaming(dev);
+				mutex_unlock(&dev->io_mutex);
 				if (err) {
 					ret = err;
 					goto err;
-- 
2.25.1

