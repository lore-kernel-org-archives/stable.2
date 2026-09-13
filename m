Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42E3750BC
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335264; cv=none; b=buaKh9uRPubaVXiDTtkWnptqiohpVS7Tx/khqVkSYe05gdFsAbHggNPPn7tCWsinJwFWyuhw3UWCAGwAI1yKtQIKrWVWLUGz75eC0XuiBpTJEfeshLIhoFoZ02T0P4Mulz2XFes/pSbUmBsQrel41IpKKNDAoTBCDU797blOpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335264; c=relaxed/simple;
	bh=7k1hisha0SaAstxzyShuH8xYn1U2H6VgoJ/ZkYLYQIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToFQ5xrNo6WDqQr8pseUPhFlhLuXwYJMKqQ5zD5bROyeJ1QWDSPV6Pu/SL4Y8sTq24IMt3fCQxSKiih2Zum1Ahy2P2zmBEkvS0EiGTkeJNYd48AJAV+lkQzV6B9k0eJTEx5diRCM2y37K7cqlYWsAc+4UAGSC1HNg5cA1tjtmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiXYoa9y; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiXYoa9y"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so1080911b3a.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789335260; x=1789940060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHfVEcK3sauaFk2XrUxZ5yLnrxF9PTr4AtCY8Hi4Vvk=;
        b=SiXYoa9ygv70bKNPtATzerafsD2WF+EPC+DoouSRLhJG5q/xLyByZggyovwMej9Lfy
         SAx3q5xkyhN5PJgAwKjJBZvrMb16t6LEJqd1UNuMauNV3u/yZ+lx7qzungx7ZOGmdevZ
         +BO+TPCpEzlBZbyh4v2xly9AQxMj7iKWe+fFyuSUoCMT+U2k6Aw9i7rqDrKabH7ikyeM
         V10M5W79NrJhVyx3UhEPhM624ScJTJnSHz+wDPPbivXibpdCVdSGKzHcsYD3IFMRJh9g
         306xgigUaSnsnAn78qxiMZBmkxv9ZzZJNsA0YwUkgK7eZl/h9gsvyLJcUdgYsG44/V23
         dByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335260; x=1789940060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eHfVEcK3sauaFk2XrUxZ5yLnrxF9PTr4AtCY8Hi4Vvk=;
        b=BsnUEmc4lP/t4/g/K8qLfwQmyjPPc31+voor6UGS+TSvDUB8/fEGg8HHtk+IzqFlF7
         AWzKlO/iD/JqVv+AIS/TTKjtBDvJk4ZVrRwbtkZakLXeuRI/XwfZEYTzD8Oj3CNazui4
         SepuDb1NfRYkE54+s5glebdghnRcWqRfU7YW4pkqkH8BDUFSKwREHIKUbvTSW7X/cN7D
         43gt1KtvKoq6/xTCQJNr0gDYlQb5hGPig/tRjsJoUe24J4jJQCpX2InfTfgU0gzYUVG8
         38CQmmr9SbUdadvWfJJ8mAXHBcXN8tVHF3+/6eLempwejvmjjlNMHXq/9EZ0SoCYzSOe
         OGGA==
X-Forwarded-Encrypted: i=1; AKwUvByEbiinFWwBLEWmmitaus0d0yEhnr5Z7rEYTR/ZvECqH+tl71/sifP3M/WldA3bH05R9qgD8qU=@vger.kernel.org
X-Gm-Message-State: AFuF++l/ElvoP+Jg+e5cbZ54flSlgK/FK/sF4Rpv4daEYr7vexwFMB5C
	Z/zY4MY90XizxWRxnuFVQK4vXkniH/Wd8m3NwEutktr8TiXRZRnTvu9e
X-Gm-Gg: AYBFou1iJ2DuYoIk/+q+6XrIeJqbnShf9EylcVYf+bMLYb9Bx+JTGaiiA/Zvg9zstpb
	Mmy3Bx9BohuC5EgVeBgiW244ZYYwFK9qsQKyQS4+yUe9KZYqyFmznJWogbcFn7hsoUDhrae8pKc
	ZRhiMvFy4LeoIbAX4NpKrZNijshMii+CrE/2Bp1In0Qe+ORWr6fwCIAeYAeeOTekracpzSt3J2i
	FSKXWfFB0/xcOwV4Lmdzza1UB9f1v4Z5jKUdxcDaTEn/2oqYkafTdjw/RlJvonq3df1GxyXICMq
	Ux3sp+MTJxCTHPtgFa2mRE2lxyX02XXGeveiATX51Ucko6xO2d9o7G7DeLpX3N0gnJSJXTrbEqP
	NU8BP8kRKDJSbOrVcvneHjONhCzWQTUJ7fzKNsb9scHKFQtZwoi58nZUuxQujW6af5bEjzEn52M
	jKI6NKQLxFwd9GMmcIk6hg6HiVjD2+tgJXnGy/vhMpVIJg6hda2JsKan37XU4KtuSoCbOm2EL0D
	I+JHVQCQAi8WUIqhSEf2Lm2RwOuX7Z6LKipmsgslKhjLGRNmG2kaTtiA1fOyJYuNJeFjixMA4xe
	QcxfbmCghAa1Z86jgMs4J0k3blfy8CUWlyqg6LiR6Gj9XA==
X-Received: by 2002:a05:6a00:a16:b0:86d:9ade:13f3 with SMTP id d2e1a72fcca58-86d9ade2b9amr8504968b3a.19.1789335259818;
        Sun, 13 Sep 2026 14:34:19 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b291c5e8dsm3477094b3a.32.2026.09.13.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:34:19 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: min.ma@amd.com,
	lizhi.hou@amd.com,
	Min Ma <mamin506@gmail.com>
Cc: Eva Crystal <0xiviel@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] accel/amdxdna: clear the mailbox channel pointer when starting it fails
Date: Mon, 14 Sep 2026 09:31:55 +1200
Message-ID: <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789334558.git.0xiviel@gmail.com>
References: <cover.1789334558.git.0xiviel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aie2_create_context() allocates a mailbox channel, starts it, and on a
failed start frees it again:

	hwctx->priv->mbox_chann = xdna_mailbox_alloc_channel(ndev->mbox);
	...
	ret = xdna_mailbox_start_channel(hwctx->priv->mbox_chann, ...);
	if (ret)
		goto free_channel;
	...
free_channel:
	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);

hwctx->priv->mbox_chann keeps pointing at the freed channel. That
pointer is the driver's own test for whether a hardware context has a
usable channel: aie2_destroy_context() returns early on NULL,
aie2_sched_job_run() refuses to run a job on NULL, and the message
helpers return -ENODEV on NULL. A stale pointer passes all of them.

It matters on the restart path. aie2_hwctx_restart() calls
aie2_create_context() again on a hardware context that is already live,
after aie2_hwctx_stop() has torn its channel down, and the context
survives a failure there: aie2_sched_job_timedout() discards the return
value entirely, and aie2_hwctx_resume() only propagates it. What is
left is a live hardware context holding a freed channel, and every
later user of it takes the non-NULL branch:

  - the next job submitted reaches xdna_mailbox_send_msg() on the freed
    channel, via the !mbox_chann guard in aie2_sched_job_run(),
  - a second command timeout reaches aie2_hwctx_stop() ->
    aie2_destroy_context(),
  - closing the device reaches aie2_hwctx_fini() ->
    aie2_release_resource() -> xrs_release_resource() ->
    aie2_xrs_unload() -> aie2_destroy_context(),

and aie2_destroy_context() then calls xdna_mailbox_stop_channel()
followed by xdna_mailbox_free_channel() on memory that was already
freed: a use-after-free, and a second free of the same channel.

The AIE4 management channel already does this correctly -
aie4_mailbox_start() clears ndev->aie.mgmt_chann right after freeing
it. Do the same here.

The create path itself is not affected: when aie2_xrs_load() fails,
xrs_allocate_resource() removes the solver node without calling
->unload, and aie2_hwctx_init() frees hwctx->priv, so the stale pointer
never outlives the structure holding it.

Starting a channel can fail today without this patch: the ring buffer
sizes firmware reports are rejected unless both are powers of two, and
request_irq() can fail.

Fixes: d5b8b0347fa8 ("accel/amdxdna: Split mailbox channel create function")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/aie2_message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index b4c49259a1a2..f658760c3d48 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwct
 
 free_channel:
 	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
+	hwctx->priv->mbox_chann = NULL;
 del_ctx_req:
 	aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
 	return ret;
-- 
2.53.0

