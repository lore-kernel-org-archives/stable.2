Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878929;
	b=4abD5U9zWtuzTzdNc/dc/JLx1gk22dawWkJ7QkMlAlFrTt911voeqLst9iqenAKTNLwQ
	 wKFDImlar0D9SIPtieaPB5dqZqEDfx56721KWBkeG9UPisx5RTt7l+zUX+KAKAzcNuy/U
	 JqO8IawgB+mt4baIrReIwTyb/D6UmNaj6f2Pn8C51nptqjoNfVkx8P4+lxuKy3D9Ew+gk
	 8xeHbrta1aOEDsIOshOw1w9C9FlzZCrMoacu0oKr+4+FSTwWvH35bj5DJG6a3rzbLBLBo
	 YL2hdoWwLdIaeTX5LF3QuE3BfIysiVr2vRkzROM1QWVxhLdY114VtE7w2TTw06e57aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+/ie1fjm6lAVadllpDyXq/QvwISd8L07DcsiVDBTI0I=;
	b=uR1f+YZKsw3veZwe0njpo9qcYUYAFBlZ0Hoedp14gpsYfUgg5iYRs3YZNyhiEWFp/cDB
	 WIwD49MwuhgSP04OnpgE9pRKrkfOA7XvhnLD7jYlWSjIvcycY1nnX1AT9zZLSk7Ah0dIy
	 Y5dO02VFoAykn7wMMY83YZtzfvVnekPAfAaDqEluKc4M/bm22lgH4sGgzssMQ4qiEXBE1
	 bmjcnU1DJnIol+VwYWrRLUOc5a0Bgc8/Dy3YhOa2NFZEyfhzAwndeO2NmLmpiSd3IF2Eh
	 m44sATmlNk/OUFYLD/pSddufk0+eatx6EUZGkUUkIDKc/WORTYLd3hnSGXvkjSbv5Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QckRhU5C;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81146606A336
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81146606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QckRhU5C
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b2513decc3so89044c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878928; x=1794483728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/ie1fjm6lAVadllpDyXq/QvwISd8L07DcsiVDBTI0I=;
        b=QckRhU5CJkjAS4fl2aFsDdwQ/8P748ANtPnFDPABXbZiJP2d/8abLGNb/3w46KoLsS
         +3/o24FMUuAS3fiUHesMMD1sZwVSvi0Kad3x/6g+vEWpYWQQFq2EkwgPE4zudbPhnck7
         cPmKvDiDnDsKGPZHblsNznrCIDh6U+YPl3GoT4uiqres1qujHjr6zAuhb1CzDxT1ykcY
         Q17b+zArM3H+klpDyIhojcT9fQ7cPZcPA3bIK4sShAQk/uG5ytbnJZWRltsHL5i/Hh84
         fCMWmO3gqX1NTYd9QrsYzHldMWSigTloUACWeF9btwLhLa/l2TncsTIzRkk1xWhap4Wo
         pGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878928; x=1794483728;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/ie1fjm6lAVadllpDyXq/QvwISd8L07DcsiVDBTI0I=;
        b=sXew4tnzQKEbIZZbrB3DbOplCO1KJRKbYn2kudVzNgsG5e2SZriZ0sLfkioZ+mmm4a
         i5qzzXuETAzLkzSufqPHB/VWaCSefM7+AgQ00g4SyGrPW3/np9D3XCaJ0uP6pOyzfAg+
         W1oEuqgTzCIVMxU5K+jy3r5gPjyVui5HxxAesO3wOqszy+55s37BXH7macqevtOlLm4C
         OIxXnbgvinaqkC79bNEPz62HWlMxq30WojYo64rxL6X1mWZkaNhgfpikCt/zxRQwO9hb
         +EEPKvtHJOZQYBbDCSG+CvlE/L/zbHtj/h93k+WTtsy3NREIPk9f7OYrmjHpm+1Np/DU
         MLgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRWgxl/Ltvrri2Mdst9u8iEEzgPL/PsUm25t5JLRvL1mHOnsdveSQPjnAz2rpkhoUyHSd/9lI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A7tKx6y7XU8baAl9uDLK0Po/D2/Heeubv5aU2fyWkKAqE3xbn
	UWcAK1GNyWQpU0rwdq7ME/5aHEEBufNVx7ZBDSEsQzR4HvMEGUC27aqP
X-Gm-Gg: AYBFou1wqLZx85WyeoCrdW5mbLtxvNoVDiNtecHfv2wo1dBacTypynql4MLdQ2wrRtc
	KIUjEKp20itnoLUSR1JKh1ZYE5Hcc6hdtE3RXz8/bxGxqmenjviORfajy1AkxqWhRmDZMBodfbw
	Cbn1/bmsk+s03uvN0wXjkSgkio6x+KVrY9wmJS5dUmUo0AGXPXRlCDFTJzKfTlnc4+tsWgRj/8X
	2+fHDkfr+AoeFAEOGYxcUJLaoyzcMGfJqbF4gvy5ZFZic/tbRyh7efpVXiUNRnY7y0bnlGpgCPi
	QnxK6A9AbPvOjDVaXmLZ/KQ/HAB64WGlHVMHyA60PtwlFAjMYv/h1GflYINDW0/oY8KezM9kpIC
	lu5nIRZte33p63P+XssEGguGzAzckaxk1tip8EnUkZC0nUv1qnvFVvR0YXE8CFByikvMhY1ZkgQ
	OSVd2M3qEJNiPP5S9ys64+/TAnv1yn2kdNKbO5aEkRBHiXkBFZbNCDquA8pl2+Ehrj+opwbFx5c
	8z2oPGn2R0EtVi1ybxX4f7vxhzZxZ4/556fhspuL8ANnqKTKOfzoJoW9YCTDcPgiBabzICRF0fQ
	GkydC19OCIKOxIsBMzjwbtjo05j486v0IlodEPrAPQHIooBvgb/fB67WZjbTcE/AYWvbppt39HM
	y6W1AbF+huXgNtBu66KCUhMvpg8QgkuI=
X-Received: by 2002:a05:701b:420d:10b0:184:d593:2897 with SMTP id a92af1059eb24-1ac5d5aa2aemr30545874c88.29.1793878928117;
        Thu, 05 Nov 2026 03:42:08 -0800 (PST)
Received: from lwq-System-Product-Name.. ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4706bsm19644566c88.15.2026.11.05.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:42:07 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: mkp@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: stop asynchronous event work before ANA teardown
Date: Thu,  5 Nov 2026 19:41:49 +0800
Message-Id: <20261105114149.970315-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NVMe ANA work has several producers, including ANA AER completion,
namespace scanning and failover processing.

An AER completion can queue ana_work for an ANA notice and can
separately queue async_event_work, which sends the AEN uevent and
submits the next asynchronous event request.  These work items access
controller-owned state during asynchronous processing.

Controller teardown must ensure that both the event work and ANA
processing have completed before their associated resources are
released.  Cancel async_event_work during controller uninitialization,
after the controller has stopped accepting new events, and cancel
ana_work again before releasing its ANA resources.  Draining only
ana_work is not sufficient: an ANA notice completion can still queue it
while teardown is in progress.

ana_work is initialized in nvme_mpath_init_ctrl() during
nvme_init_ctrl(), before any teardown path can run.  During controller
removal its producers are dead before the final cancel in
nvme_mpath_uninit(): namespace scanning is flushed in
nvme_remove_namespaces(), path clearing removes the failover source,
the transport's delete_ctrl tears down the admin queue so no further
AEN completions can queue work, and nvme_enable_aen() is only
reachable from nvme_start_ctrl().

nvme_mpath_uninit() also runs from nvme_mpath_init_identify(): from
the ANA log growth path, where nvme_mpath_stop() has already
cancelled ana_work, and from its out_uninit error exit, which can be
reached without nvme_mpath_stop() when reading the ANA log fails.
nvme_mpath_init_identify() is called from nvme_init_ctrl_finish(),
while the controller is CONNECTING or RESETTING (LIVE is set at the
end of nvme_start_ctrl()), and nvme_ana_work() returns immediately
unless the controller is LIVE, so in both cases the additional cancel
only drains work that would be a no-op and cannot race a work using
the ANA buffer.

This issue was investigated and the fix was developed with AI
assistance (ZCode/GLM-4).

The race was reproduced with the in-tree NVMe loop target and
scheduling injection.  Cancelling ANA work alone left reports;
draining the event work and the ANA work together removed the
reported use-after-free under the same test conditions.

Fixes: 0d0b660f214dc ("nvme: add ANA support")
Cc: stable@vger.kernel.org
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---

Changes since v1:
- Corrected the causal description: an AER completion queues ana_work
  (via the ANA notice handler) and separately queues
  async_event_work, which sends the AEN uevent and submits the next
  request.  v1 wrongly attributed ana_work re-queueing to the event
  worker itself.
- Noted that ana_work is initialized in nvme_mpath_init_ctrl() during
  nvme_init_ctrl(), before any teardown path, and documented all
  ana_work producers in comments.
- Audited the producer shutdown order for the final controller
  removal: nvme_remove_namespaces() flushes scan_work, path clearing
  removes the failover source, the transport's delete_ctrl tears down
  the admin queue, and nvme_enable_aen() is only reachable from
  nvme_start_ctrl().
- Corrected the error-path claim: nvme_mpath_init_identify()'s
  out_uninit exit is reachable without nvme_mpath_stop() (when reading
  the ANA log fails without growing the buffer).  nvme_ana_work()
  returns immediately unless the controller is LIVE, and
  nvme_init_ctrl_finish() runs while the controller is CONNECTING or
  RESETTING, so the extra cancel on those paths only drains a no-op
  work.  No additional cancel_work_sync() calls were added.
- Addressed the Sashiko review note on the explanatory text: the
  comment in nvme_uninit_ctrl() and the commit message now describe the
  actual queueing paths — an AER completion queues async_event_work
  (uevent plus the next request) and separately queues ana_work via the
  ANA notice handler, while namespace scanning and the failover path are
  the other ana_work producers — instead of attributing ana_work
  re-queueing to nvme_async_event_work().
- No functional changes beyond v1.
v1: https://lore.kernel.org/r/179378587000.73780.18152328009023418065@gmail.com/

 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/multipath.c |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..8efa306205e19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5182,6 +5182,16 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
+
+	/*
+	 * An AER completion can queue async_event_work; drain it
+	 * before the controller's final release.  Note that ana_work
+	 * has additional producers (namespace scanning via
+	 * nvme_scan_work, and the failover path in
+	 * nvme_failover_req), which is why nvme_mpath_uninit()
+	 * separately cancels ana_work after this point.
+	 */
+	cancel_work_sync(&ctrl->async_event_work);
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e0a0fd77c56e..4ced8136d5f63 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1610,6 +1610,15 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
+	/*
+	 * ANA work can be queued by AER completion (via
+	 * nvme_handle_aen_notice), namespace scanning
+	 * (nvme_scan_work), and the failover path
+	 * (nvme_failover_req).  Drain any remaining work before
+	 * releasing the ANA resources.
+	 */
+	cancel_work_sync(&ctrl->ana_work);
+
 	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 	ctrl->ana_log_size = 0;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

