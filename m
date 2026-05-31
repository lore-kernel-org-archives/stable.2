Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494C21C173
	for <stable@vger.kernel.org>; Sun, 31 May 2026 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780258767; cv=none; b=BvDReT6B0LMUc9IxDJWWJOCADiwDBiMYa1A09cXk6HBsZfyZYZtXCAa9xwuIm8z3MnfyRmgAml+5JzSvGXfGdsDWARd5MRA/53ENgKfpt1DyxjRZhmzoRFxmcXWio7En5bgxj7LkxtZeLsLvFCoLQgGqDaQMQMgKXx9+WRF5ISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780258767; c=relaxed/simple;
	bh=vOQF8BMPHnIfgndK06j3IO4dzVdZ364JXK3m48gBNqE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UKHCXYEJm6wwc9kZOY3Gb2smLzOLr84bx1JK0D9h7W3zRHaVxvxgiHNrZUm+Pb8brXf6Q0gsn0hW8rgzEUdm05jefy/Gtroakdtj2N4vTInoGw6dk2HPLE0Bet1DMLeTucX4z2nXBStWjHRPtFmv9TA4bXXhKsUGexDc8W6hM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AHDaRqNZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AHDaRqNZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QpGaYgr6Qtu17GRuSnJT6BZDx5iVwF8//EP6Gbc8Hwg=; b=AHDaRqNZUEoElsvlloOA9RT1AM
	tAX4nqjuw7qU12+UsAEoX1jiXgz0l+AszDDo7fPz38hmiNSav190Ruk2zO2UrQ9+5nd3BJ7/OkEtC
	PkDIiIbgsV26KF9lyo/puXhOJ4+YOuHNTAW6ilmcojh+aCSCh86Cdmc8Kg+W7alZvQ/gKl22vEITv
	Y5RzduCS+LdImAncm8CaSBsm7TfZlCHAljUhCfN7CrFE+nq8lozDd8cAtp8+D9WgSuKcgHcPldbcN
	FpzlX/7p97EshK+vNEn7zsszNLHkC2eftnmAOlRdxnlA6f7OUWi/JSnzyaR5nUQ02EpptlHpBxEtg
	KJ/5UBig==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTmcr-00Agcp-BW; Sun, 31 May 2026 22:19:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/4] drm/v3d: Fix perfmon locking and cross-queue
 isolation
Date: Sun, 31 May 2026 17:18:54 -0300
Message-Id: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PS27EIBBEr2KxTkeAAX9WuUc0CxuacUuDPQEHJ
 Rr57sFMpGyyrJL6veoHSxgJExubB4uYKdG2liBfGmaXab0ikCuZSS4N11xDbh3cMfqwrXAjjzs
 FBNXbwaETfBAzK6f3iJ6+Kvb98swRPz4LfX+Wf/DiOtGKdxWd7IIOAiULlQBGtl07cNGhbscsT
 /o8JQS7hUD72CgrDQojB9V5droWSvsWv+tHWVTZ7/j+//FZAAevZ22UtLzX/o2u042m16Jgl+M
 4fgCeIj39JQEAAA==
X-Change-ID: 20260505-v3d-perfmon-lifetime-48c9ded1091b
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6009; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=vOQF8BMPHnIfgndK06j3IO4dzVdZ364JXK3m48gBNqE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHJe9INo0XI8giHAFn3G0ygvrhGOQdvbRAOeTE
 W/3BE/tt9GJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahyXvQAKCRA/8w6Kdoj6
 qobRB/9nDHgz2WGhGRyHSsJfM6JUkolUPPh4Rw4DoPaAd7mgAvhBk5l4gtHsDveby7+cNct5wG4
 dTImkXo+TIOcti6UBgEfhWGt+AG2vZnFPRqDA71KomKlEXDuTPZ9v1R7w5B5Jnc7tKdKrLECSL/
 Yv9GgnB/EKVSW4KTEa3iNCj4DnkwOODM1ziKeY4m7cj2my8GwfdbIw5m0toLqEMtoAMFg5en6Ds
 mm8Vv2W0I2dCpWXAxc9Ot35y2kqccIoO7s2FWaotfXSP9ZXYqOjGr2//F5vPFoUyuLKUpfcxGYY
 nSljjF+ZXXSxwPbwqdMFWPJYAhKi277e5Ln+L3D43+qaB+7Z
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

A v3d core is able to expose a single set of HW performance counters, so at
any moment at most one perfmon can be programmed in HW. Currently, the
driver tracks the active perfmon with v3d_dev->active_perfmon, but three
long-standing issues makes perfmon handling unreliable:

1. The active_perfmon pointer is accessed lock-free from scheduler
   callbacks, the GPU-reset path and the perfmon ioctls. Note that the
   v3d_perfmon->lock mutex serialized start/stop of one perfmon object
   against itself, but the invariant that needs protection is device-wide.

2. perfmon start/stop is hooked exclusively to run_job() callbacks via
   v3d_switch_perfmon(). If nothing is queued behind a perfmon-carrying
   job, the perfmon is never actually stopped.

3. A non-global perfmon should count events generated by a specific
   submission, but the scheduler can run jobs from different queues
   concurrently. Without explicit cross-queue serialization, an unrelated
   job running in parallel pollutes the counters and produces unusable
   results.

This series aims to address all three issues.

PATCH 1 is a minimal, stable-targeted fix for a separate problem: the
SET_GLOBAL ioctl leaks the perfmon reference on several paths. It is kept
self-contained so it can be backported on its own.

PATCH 2 moves the locking to where the invariant actually lives (fixing
issue #1) and replaces the sleeping mutex with a spinlock, which allows us
to stop the perfmon from the IRQ handler at job-completion time (the
natural boundary for "active perfmon follows the active job") and fixes
issue #2.

PATCH 3 addresses issue #3 by building on the new locking to enforce
cross-queue serialization when a non-global perfmon is attached, by adding
scheduler fence dependencies during submission. The fence dependencies
allow us to enforce two rules:

1. A job that carries a non-global perfmon waits for every job currently
   in-flight across all HW queues to finish.

2. While such a job is in-flight, any subsequently submitted job waits
   for it.

This allows us to ensure cross-queue isolation and the reliability of
the performance counter values.

PATCH 4 is a cleanup that drops the now-redundant queue argument from
v3d_job_add_syncobjs(), as struct v3d_job carries its submission queue
after PATCH 3.

To make sure that this series actually produces the expected results and
improves the overall reliability of v3d's performance monitors, this
series is accompanied by a IGT series [1], which was already merged.

This series depends on [2].

[1] https://lore.kernel.org/igt-dev/20260514201637.1811428-1-mcanal@igalia.com/T/
[2] https://lore.kernel.org/dri-devel/20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com/T/

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com

- Rebased on top of "[PATCH v2 00/14] drm/v3d: Scheduler and submission
  fixes and refactoring"
- [1/4] NEW PATCH: "drm/v3d: Fix global performance monitor reference counting"
        - Minimal patch for stable branches only fixing the reference leaks
          in global perfmons.
- [2/4] Start/stop the global perfmon inside the set_global_perfmon ioctl and
        simplify global perfmon management across the helpers (Iago Toral)
        - In the reset path, before stopping the perfmon for the HW reset,
          v3d_reset() now re-arms the global perfmon with v3d_perfmon_resume(),
          as the global perfmon's start/stop points live only in the IOCTL.
        - v3d_perfmon_get_values_ioctl() no longer stops the perfmon, it
          only captures the values. Lifecycle management is left to the job
          (per-job perfmons) or the SET_GLOBAL ioctl (global perfmon).
- [2/4] In v3d_perfmon_delete(), first, stop the perfmon and then, check if
        it's a global perfmon (Iago Toral)
- [2/4] Add some comments to explain the refcount logic for global perfmons
        (Iago Toral)
- [3/4] Move the job->queue introduction to this patch instead of the
        previous one.
- [4/4] NEW PATCH: "drm/v3d: Drop the queue argument from v3d_job_add_syncobjs()"

---
Maíra Canal (4):
      drm/v3d: Fix global performance monitor reference counting
      drm/v3d: Refactor perfmon locking
      drm/v3d: Serialize jobs across queues when a perfmon is attached
      drm/v3d: Drop the queue argument from v3d_job_add_syncobjs()

 drivers/gpu/drm/v3d/v3d_drv.h     |  50 ++++++++--
 drivers/gpu/drm/v3d/v3d_gem.c     |   7 +-
 drivers/gpu/drm/v3d/v3d_irq.c     |   7 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c | 195 +++++++++++++++++++++++++++++---------
 drivers/gpu/drm/v3d/v3d_power.c   |   4 +
 drivers/gpu/drm/v3d/v3d_sched.c   |  26 +----
 drivers/gpu/drm/v3d/v3d_submit.c  |  85 ++++++++++++++---
 7 files changed, 282 insertions(+), 92 deletions(-)
---
base-commit: 4c26e162947f91aa78ba57dd4fddd38fc80e7d60
change-id: 20260505-v3d-perfmon-lifetime-48c9ded1091b
prerequisite-change-id: 20260407-v3d-sched-misc-fixes-623739017e53:v2
prerequisite-patch-id: 01823e165a822ddec72b0b18e49c096d35149e9a
prerequisite-patch-id: 1df1c11ec62617336e2ed5445c24bbb912570035
prerequisite-patch-id: 738852cd3115283b43cef336ba8fe88616f28a88
prerequisite-patch-id: e1fa04bb45b0c1eb1478b2893b0dedcb6a825255
prerequisite-patch-id: 32c804d9921bcf259b236b3f1d74f7972aec02f2
prerequisite-patch-id: b1b437650405dd43ed324f9c02a0e591a793aec5
prerequisite-patch-id: f13898126dac8b6f14d8e1fba8804123f012889e
prerequisite-patch-id: e03f525b4491a3475ed0efa68bc8049f92be0bd0
prerequisite-patch-id: 971ac9100d4958aa2c0da2d734533eb9ea9d80b3
prerequisite-patch-id: 9d3d40ef80c032c0c05b058f6c397d04d1879236
prerequisite-patch-id: fb2e7a320a7ec3df75b74cfa6683a558f87135a2
prerequisite-patch-id: 29537da4c8f3c2a97f1350638e9da035cf3e7057
prerequisite-patch-id: 7303a43285dabde083921fe380a294c9026ef6e9
prerequisite-patch-id: bc42b0633cf33b2a693cc17534a6090f3813cc60

