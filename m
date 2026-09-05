Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB64ADD8C
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620700; cv=none; b=rDo/dpRVJ8CtwcZv5iKjc0f61/wTuFyEcycQlOWLpM114N1Ezy3YrUwSCNuKMUtfOFbNrPwyMdeyW+f9V/zlG07PYKbppw032f5ZQODTilQw0D43QFIOhhoh0gaC4xzULyWqIUVxxRNaQ9lRoslOSmHQudBkIMNDpsKqTTokewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620700; c=relaxed/simple;
	bh=vzCLdzwVDkmEvFXFSjIK/EbVy4grvzU5TVEOTYzHBhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOhUhknhySnNwA2aT7Qd4rW5K1yQZ43iQfWCsQIuWQ+g5BLFY8WLEXh+eCtdgO/9ShmJwiuaDbN8krpt37Ne+n89S0oPXiQzLxdgwQPT20NktbiS3j1HfRg7fIg4qSB1SBrkuxg6IqEUb9HyqpN1kvBUqY4XT8feUSt6jLMvxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx3prEEm; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx3prEEm"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b55da8so184488f8f.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788620695; x=1789225495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NM2S1Q42b15aXVJKX75peJvXAR4lZmt0uA+gclfAVgo=;
        b=Nx3prEEmtQthmIBi+auFHNpckXeTadJWYe8WSnsqKCWW/9I0EBPAuSyrubiVlB8usH
         5v0bAudEkP+secRmqSc4YbxGuExKHIWzvQtozYCldRj7fkqPlF9pcNi27ciqghA+87DV
         55iU+G36xvvP0y/Hr7L8kn5L/ZKxBdKZfpgUAwKub00nzivEaI/2n7sCjNfNpofB9dvA
         L9s4+8jTAXf3btmnvGRx5eYObj2rm7VFh3FEUP+2e2SR7jo41b9R3ghAlyMJ4Tx21ECB
         FxSFF+nPPGr5+aBNze4dwpnGex2N+93g7nzCiR4XOb2iU/OkS78MyTg9h45A0HQDM224
         zNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788620695; x=1789225495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NM2S1Q42b15aXVJKX75peJvXAR4lZmt0uA+gclfAVgo=;
        b=j6qos6b0FxrKfVBI3dFL79ZlSYMQkJgfssJsAN8di+3dZhYhh8l59qJAlv34l/42A2
         h3vc+LuL7u7gjE4aLzxhvXuNaPtrqBHB9uxwRvwAulNKRDi4xN1pI5XzC3C/7/6sw2LD
         R5hZD3vvMVIGAS5th/Vd+Ge3eowpymIflwnnet6ah7Zb9c0w0uxadISfjtsTjqq8/eoG
         bUo5H/dvx8tkdd0gmzAUjuFSnOf1u1MzF9HzaRW1sh4nOTMEAJ5NvsV6O1ieJKcbdvze
         Y7pznU8a9h4RPB1hHUJNWA4tEd8YF3BkfIwUytBqeAv13VLu2cFwCQjKJJskeFKfv5Dc
         7nGw==
X-Forwarded-Encrypted: i=1; AKwUvBzuwrvvmy04YztIpTPu+99VKZ+fweViXi/nHuryYXWs7E9/dDenVVCnCK7+mtHpEdqFCYMMHAc=@vger.kernel.org
X-Gm-Message-State: AFuF++mKcYlqY/Pgw36TMBOIUW2jR/G8FusqP0oyAlw5a+TwfIJhomiP
	mDRIJNLKw+5w2hDvLswsO3zhegmeyZKHLYA/TKJFLtU6QIHNJxBJLAM8
X-Gm-Gg: AYBFou1ha9xcggwjRKsGd2gphRKpZ0A8fyRVzCnyB2w5TAZDoDtdLJHun8BUxLvtl7z
	91l0LVa5oc9NdzVxenI3HmDOMJODu35c7KTVg76LJKa3hRT8+Nb5X9JbRhjxvigzXLC6XSUkIRw
	cK32TX2jYcOyIBPgI3dgyDNN+SWvvpCbhTS4njySPcrZDtY7C2wh9+k4VqMHytbXsMC2X3xNf28
	v7fe4gVmlGkhpgidC5iQWZgSRQkruPeR2eIcsAXqtFDHiEwBEM8a7Mot/yry3XngkXjYoxoAwD5
	Y/ccI7T94dzVZ77XS1AYo4ZtKYYU8CH3uoIldZ8blBUmGbqDlYRLCEjXNMdlOPuYBXwB8LHkPwG
	83ft/Y9RWoVGwAKB6OcPLFvz4pUcMu+gBqJ3r/IfX4uy9mb9hif3BeGtVfGCBmJFHELBlzBc4oG
	QKLLqlm8CblR0UVzcRumOvfY/KSufbP54X9NDlEsAjlSlK0AwK0t9r/NE72AdHRq+lBC+PLFN1P
	yj6zu14+en1uXJ0Kr7yDUEJInrWQYEXcY47DyMsCkGE3kCedV1cDLIe72r3mrXc5WU=
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id 5b1f17b1804b1-49cf823c012mr101940875e9.1.1788620695367;
        Sat, 05 Sep 2026 08:04:55 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B950E0061C002CD703C2CBB.dsl.pool.telekom.hu. [2001:4c4e:1b95:e00:61c0:2cd:703c:2cbb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75cd8d0sm142811705e9.2.2026.09.05.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:04:55 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	Heiko Stuebner <heiko@sntech.de>,
	Jiaxing Hu <gahing@gahingwoo.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/rocket: search every core slot when looking up a scheduler
Date: Sat,  5 Sep 2026 17:04:32 +0200
Message-ID: <20260905150432.7477-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_to_core() walks rdev->cores[] up to rdev->num_cores, and
rocket_remove() decrements num_cores for every core it removes. Unbind a
core that is not the last one and the cores behind it fall outside the
search, so sched_to_core() returns NULL for a core that is still bound and
still running jobs. Neither caller checks the result:

  rocket_job_run():      rocket_fence_create(core), core->dev
  rocket_job_timedout(): dev_err(core->dev, "NPU job timed out")

Unbinding the middle core of the three on an RK3588 while three clients are
submitting to all of them faults twice, once from the surviving core's
job queue and once from its reset work:

  KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
  Workqueue: fdad0000.npu drm_sched_run_job_work [gpu_sched]
  pc : rocket_job_run+0x234/0x838 [rocket]
  Call trace:
   rocket_job_run+0x234/0x838 [rocket]
   drm_sched_run_job_work+0x2cc/0xad8 [gpu_sched]
   process_one_work+0x640/0x14f0

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: rocket-reset-2 drm_sched_job_timedout [gpu_sched]
  pc : rocket_job_timedout+0xf0/0x1e0 [rocket]
  Call trace:
   rocket_job_timedout+0xf0/0x1e0 [rocket]
   drm_sched_job_timedout+0x188/0x6a0 [gpu_sched]

Both are the third core: the workqueue names are its device and its
core->index, and it was left at slot 2 while num_cores had dropped to 2.

Search all the slots that were allocated, the way find_core_for_dev() now
does. A core that is still bound is then found, and the two callers get
the pointer they already assume they have.

This does not make unbinding one core out of several safe. An open client
keeps an entity pointing at the scheduler of the core that went away:
drm_sched reports it as not ready for every job that lands on it, and the
client waits in dma_fence_default_wait for a fence that will never signal.
Stopping the NULL dereference is what belongs in a fix; the rest wants
more thought.

Reported-by: Sidong Yang <sidong.yang@furiosa.ai>
Closes: https://lore.kernel.org/dri-devel/apwUewaRnoTNXHCt@rock-5b-plus/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 3141f210fcd1b..a6c24dfe0563a 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -283,7 +283,7 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 {
 	unsigned int core;
 
-	for (core = 0; core < rdev->num_cores; core++) {
+	for (core = 0; core < rdev->max_cores; core++) {
 		if (&rdev->cores[core].sched == sched)
 			return &rdev->cores[core];
 	}

base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
prerequisite-patch-id: 519bcdfdde80d902309c8346f749ebc4bb6b29c0
-- 
2.43.0

