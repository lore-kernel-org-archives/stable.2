Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692638D6B8
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824239; cv=none; b=OZs23utQuehyE2rzuLGBXRLQysR/OkgzZbcg6XpCxkQ5FbDhvXiaRYFFmH3mQrdV+f0nRlxBWPrAdcnjgdwf9+/+SsswDa8XMybh5o15nIbDDhCW519PMpWXeTNYWXSdqIbrJxcRwELEIuHUi3ULckxFNNVzZ0Hi46dj8494GNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824239; c=relaxed/simple;
	bh=rr7pg8W4Ev03sHh2U6WrIqNwqklnpWb+YCSRGZmb9D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PsT6S8XDtDAKXHr/dsMIEW3/XXYS+45QvBaN3iJRNwcgvv/jUtX0ykkjz7K2Ojsw/M8uSyoFlUVWNgRG9LhD+oNbsUwwHj6nv6qihMwD+qw3/10mX8K4F7DkWo3G9MRDISWueH+e4IV47+pgOC7UTymaLGUSDs9ee4ulcdvflps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvJiXvcf; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvJiXvcf"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3e517e6dso1297902eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790824237; x=1791429037; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bKmSym7NamtEMfhbkbwVj/i7VYaex0n/r9jJ2yJ7jA4=;
        b=CvJiXvcfwx7Q1sRVwPgyIr/a+AO6oCY1V3gQpFKJmFPCeP2eYIGLLjalJA/PYAttV6
         /nu54bhkNuqzXDmSSqfAYPIO7ZDDG1keBH5PZU6qimVq/A38QuwHO99UIOv60VDfHDLL
         4LXA8zqGjAAuy52nFxCs4UuzhLRl/bSZd+nKr/T2+QFDotlOUnrDtjkjAgX+kQrPHzbC
         DbLvv6FyeCkWf5R7agou3KUrwDX6Om0wr7GqjLRmrm0R2RIXgupaKN7rLQeDcanftHhz
         EvweHpV6mbis77WC05sugj1CWH3UhFh/pYe57ToE0uo1n8QJYlVreNdKD69PFJ2cbUTI
         Gs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824237; x=1791429037;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bKmSym7NamtEMfhbkbwVj/i7VYaex0n/r9jJ2yJ7jA4=;
        b=U/xTKCBsHGyCEfgPGBD+87CRFNOB39DDLrODUAjOn+m0afajKlh8w8n5m8gr5xe7+/
         GeAJalUPn4G5x1J/8+TKlQ7NiHSLtQtq8ju49mPTTnwzsNsq+SgaDl8LJ7npN/6XvG/Z
         xMBrpbvhy6xsMTbUfOOkvmmeOKmV2eGnJAI9IjMghnXo5YA2yfikjD69mztvtyYm6Cg5
         mCmS9xgWt3XL4KgY9XezO69hRtu7+2Ry9BdA02evzC9NMUHgCcg4rDcks6/9cdaO574K
         gzKwfZT8PciUqWtsPzhl2ndemzFArj2+m17EgrKMXJL2xWefxRKt5NequglFu86/YPRd
         pneg==
X-Forwarded-Encrypted: i=1; AKwUvBwabpqPRGBFaftOWOpxSd0mlgZzjxuCDRdTOPOAQSy4sqwvpxoMLtM2czjsPUaP8V/LK8H4g/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzYfPGwbZSzxHAtBbQYzslWcBn4k6ZZsmOf1OuJbixM1pmZ1Xr
	nDVsQ1Ki+PU6DTLop4Tfe+VnTmS2LViU46ZaBmNsDJrmlsJUNkDDdwDt
X-Gm-Gg: AYBFou1gY1CHqIFh8E78AKhaVnl90JFYah7iPQSQAThED+gczt1zV1A1uSVqhzx7xm6
	kd3CzMEDTOKiMQRHcxmZN7UZunhMnZioMlOsD5KZc77PAAeJWErKFGEE6gQl9oypLDdqBm2lZqs
	3Zw2U3hqzQS5yUw3Yt6AMU0l1Szqupsvc3YzbUIMzE3kwLdFrrlZD8i9o780bH/30kJMajU47U3
	NJQWCqlmHBka4PFhHCnzshsV3B7oREDXgog58Teu3tfAFyDdxtqw4wgioKzz7Fmsp9U1Up3tjvz
	1IyrYYC0gr6c3A3tyDmEohdlqdqW3VDiuv95m2iCmjbRw581qypIuiINDgbZaZQFLIspN9zWux2
	JnInAJXXN+Tq8v7+luAO//V2Ab2TEaJ6o51SYgL9WSG/JsYBbA8E7ejkJ+7ZVXfCKHo7kaiVwcy
	y9k+NMQWO1sUztMMlYR2uiKWeR9m20AQrZew+mkaaEBy7ejSh2m0hmzPcNs/sEEvdIeGmTLDx3j
	ezP
X-Received: by 2002:a05:7301:6498:b0:342:5098:a983 with SMTP id 5a478bee46e88-34cdb8e5484mr3635037eec.11.1790824236911;
        Wed, 30 Sep 2026 20:10:36 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34dae0ad3a8sm3042252eec.0.2026.09.30.20.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:10:36 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 11:10:32 +0800
Subject: [PATCH] block: don't quiesce the queue when setting the default
 elevator
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
X-B4-Tracking: v=1; b=H4sIACjPvWoC/x3NQQ6DIBBA0auYWXcSBLXRqzQuBEad1ICCGhPC3
 Uu6/Jv3E0QKTBGGKkGgmyN7V6J+VWDWyS2EbEuDFLITvRKorwX15s0XaaN7On1AdnzicRXGEKr
 WvtXc66aTFoqyB5r5+R8+Y84/JXkFfHEAAAA=
To: Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

elevator_set_default() runs from blk_register_queue() while the disk is
still being added: the block device is not visible yet and uevents are
suppressed, so no file system I/O can be issued. elevator_change()
freezes the queue and cancels the dispatch work before switching, which
is enough to drain dispatch activity from passthrough requests, as the
comment in elevator_change() already states.

elevator_switch() still quiesces the queue unconditionally, though, so
every disk added with a default elevator waits for an RCU grace period.
Commit 245a489e81e1 ("block: avoid to quiesce queue in
elevator_init_mq") had removed this wait from the default elevator
setup, and it came back when that setup was folded into
elevator_change().

The wait is paid in full by callers that add disks one at a time. ublk
adds the disk of a single-queue device from START_DEV, which takes 7.7ms
at p50 in a 16 vCPU KVM guest, most of it in blk_mq_quiesce_queue()
called from elevator_set_default().

Skip quiescing in elevator_switch() when setting the default elevator.

ublk null target, 1000 single-queue devices created one by one:

                     before      after
  START_DEV p50      7.74ms     0.68ms
  START_DEV p99     14.61ms     1.32ms
  devices/s             114        971

Fixes: 1e44bedbc921 ("block: unifying elevator change")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 block/elevator.c | 7 +++++--
 block/elevator.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2161b6eea680c..da9ba70ac9321 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -573,7 +573,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 			return -EINVAL;
 	}
 
-	blk_mq_quiesce_queue(q);
+	if (!ctx->no_quiesce)
+		blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
 		ctx->old = q->elevator;
@@ -594,7 +595,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
 out_unfreeze:
-	blk_mq_unquiesce_queue(q);
+	if (!ctx->no_quiesce)
+		blk_mq_unquiesce_queue(q);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -731,6 +733,7 @@ void elevator_set_default(struct request_queue *q)
 	struct elv_change_ctx ctx = {
 		.name = "mq-deadline",
 		.no_uevent = true,
+		.no_quiesce = true,
 	};
 	int err;
 
diff --git a/block/elevator.h b/block/elevator.h
index 3eb32516be0b1..3886d97427e33 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -43,6 +43,8 @@ struct elevator_resources {
 struct elv_change_ctx {
 	const char *name;
 	bool no_uevent;
+	/* the disk isn't added yet, so skip quiescing the queue */
+	bool no_quiesce;
 
 	/* for unregistering old elevator */
 	struct elevator_queue *old;

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260930-bug-block-elevator-init-quiesce-35d73f9b462d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

