Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CBF2E7165
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351807; cv=none; b=soy04P9sA/ldlp75UUDHdHlbccblRTaxLX4VSGIdkA6Y4fVYTCzOGbkoSQZNSkVCYua7Hdzg1JZhzpHGHrOxDnCWLdC81rpM3XJVnZvVEnx4ipWhH6HfCoJUMpOqIzr21Rml7P/uNbEGm8oea//4J0nKsKy5/gL9ibG8kuzqP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351807; c=relaxed/simple;
	bh=r9Aq0smRbtGVXoOkB0wcDk///UPxMJx1xjzV3KGy6PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JYL1L1biFDG0fCcDYSKr3eeVv/gqofkwKCs8DKHl0t5JE+j9hEjxaXs3kUgSs2KeibSbbGHKJNl+7Fm6NsDDSHIZp2F67cLc2dNfvvz2wvr7drd6SY39TTjeZRgbw09HC8ReeSoB7cm2RKND2dEN/HfVDyS7G4UhkGzkgMxQ1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH+kHCYL; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH+kHCYL"
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a4492f5cd1so366589b6e.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789351805; x=1789956605; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VyFl8OR0uDUO8uKxg8rNc5Dxixa51YMSLn7xjZ2lM5o=;
        b=bH+kHCYL2rZIYFJv1kV3aY3u8nV2i8zLtOwUYI7HbJvXvv8Pib8VUoA0kGULwYC84i
         dxBeuroZ1lKFn5UK4srWuWLeSra05g5WrpU92uRGLxzOcbedYR2HNZppceD2mhGKwhvH
         YyIZMwKdEvsr8Bw5X/zE6xx8hDX+JMsJ3YX7wu2ELsnR8KoXbS8I8xUbEemeYYptp/TF
         OJCXhprimy+61UTx4F4i5K5H01r9yQezX0qhGXO3EK2la1lWE6frko+sjhU3AC9eZRe8
         1wXcInqu17lsmCm+wN5nVZQeCL7TNQwwphJKN7XclULqVZQG1n0XMUf9tvnjUGfiCkXH
         XqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789351805; x=1789956605;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VyFl8OR0uDUO8uKxg8rNc5Dxixa51YMSLn7xjZ2lM5o=;
        b=tBfkmPSa+fIDJtGdMIKA1zWWgzsrkmxKl9Qi1VnyKKfieB0nc0CA7WFx8TIQJFFdEa
         b8a8X2b1jG59pcbgfiVv9iDxvj/42DmmoIaZ4YPOUBizCjcNxtyFNgH+SfLUFG8e2SKY
         Dsnrws/dUox63yMNpBhuPVm5sl94aQFeL+jRq/f3tqsFVBoL2/R2qDxSTsl61yxRNPxb
         +YCssFVQtMZQHgk2aszDoxrSMTv48CIBYjPAySmf52f4GDKOp5jXBRmThh1u5vaP703r
         Zg0+o+St2gUS+1TEfTFjUxrGxl95qWbhb22wUhAzkAdiURmCUfmgTaqUYjppAyohH1RU
         wuow==
X-Forwarded-Encrypted: i=1; AKwUvBycu1Un5VgdrWevw4ohCYvUR6ULMJIELQf/GHY2l9lI4ONRydG86nfGtNroYaTFPy+71tSKvLw=@vger.kernel.org
X-Gm-Message-State: AFuF++lf9ZTvS0HcpDTis9uljPZEGJjnBE/vzd2azwHIu2p2DSt0suWU
	K3Ig54uUiNIqUngw/Y/dHOiXKB8AwmttjYo5HbQr9ET9OZeX1+ECgpaa
X-Gm-Gg: AYBFou3OkSLFalFR+9pSBO768AX5MIxqb0ft4ImQcCgmuuOCsik51T7LoCNsO04XNNh
	FXdJbr/o3Qjo47W5B3oBgMWRGvK348UTb73MVvharYyrvCEcBPontlYeKzVlPy0MucnScQh63wM
	guPbKa95v4nD+543SSAMJtVZJAm9sVTlRMbmD/6zvxbdD3i+Gn032ZLkx2F5+YvWIkuqQKoSONd
	zdX7Ik8CiqjZMXnDdNI1ffIPFk1t9qqd2P3diAMW6pMF4qQaH/vRA9+VviEANaiHnB3g19UvVsF
	QB9P7sEI3tWflcLK0+kRQWQn0ZwKF/qEPoknznnWV29aI2ya1VDP7QeMx8MRDqz32mWlAkyCcbJ
	eFFF5N6LmJ6yetHXy0WpIb6A1hqxzn33Pgr5iIwQKmjts9c0FVC9XVP9y+1h6a1DvtHxrksoMrP
	Xk0Oouf6N4nFg/YwDRdC09Z2Oeq+DRfmXEGnyVcCojnPfMu9xhFdPNHJjWnBKk5wLKauE=
X-Received: by 2002:a05:6830:3692:b0:7fa:ab72:9dff with SMTP id 46e09a7af769-80899b59dcbmr170262a34.23.1789351805145;
        Sun, 13 Sep 2026 19:10:05 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:10:03 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v3 0/4] drm/imagination: fix system suspend, and the
 callback design underneath it
Date: Sun, 13 Sep 2026 21:09:51 -0500
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/62OQQ6CMBBFr0K6dkwpCtSV9zAuKAxYA6Xp0EYk3
 N2iG/e6fJOfeW9hhE4jsVOyMIdBkx5NhGyXsPpWmQ5BN5GZ4CLnkktwynkE8vgEb2lyWA3adGC
 Di0eyaBrorAeaacIBqEe0oFolm7YpOC8Ui5+tw1Y/3tbL9cPk1R3raVNti5umaXTzOyuk2+63g
 pBCCu3hWB4KVctjqs7dUOl+X48D2wqC+INDREeeVzIrUQpVFt+OdV1fWAbGk2wBAAA=
X-Change-ID: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=4695;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=r9Aq0smRbtGVXoOkB0wcDk///UPxMJx1xjzV3KGy6PI=;
 b=CiWuBsJLTwBQZxeWjo/KaH9V7N9Md5YIjsdxwa8si31Q7IRnNpuHYvMmQd6nQ2z/6NpWjR99J
 CfH6p3TTFkADDVel90drI3YbtOSjnZ6Gipp8L5HH14UG1wEiUFt/Ais
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The GPU has no system-sleep callbacks, only runtime PM ones. If it is
runtime-active when the system suspends, genpd drops the power domain
behind the driver's back and the first firmware operation after resume
wedges its caller in an unkillable D state. Patch 4 is that fix, and is
what went out as v1 and v2.

The v2 review showed that wiring the force helpers in raw was not safe
as the driver stood. The cause is one design fault: the runtime PM
callbacks use drm_dev_enter() as a "device lost" test and hold the SRCU
section while waiting for the watchdog worker. That makes a lost device
fail every later suspend and makes pm_runtime_force_suspend() deadlock
against a worker that loses the device. Patch 1 fixes the callbacks,
which lets patch 2 unplug first in pvr_remove() and lets patch 4 go
back to v1's one-liner. Patch 3 fixes a watchdog-vs-teardown race found
on the way.

On the v2 review's remaining finding, that pvr_power_fw_disable() can
return without re-arming the watchdog: after a failed runtime suspend
the device is in runtime_error with a zero usage count, and the
worker's pm_runtime_get_if_in_use() returns 0 in that state, so a
re-armed watchdog could not act. No change made for it.

All four were measured on mt8173 (Rogue GX6250), both arms from one
build switched at runtime; the details are in the individual messages.
Lockdep cannot report the patch 1 deadlock: cancel_delayed_work_sync()
only touches the work's lockdep map when a worker is executing, so the
srcu -> work edge is never recorded unless the cancel races a running
worker.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v3:
- Restructured as a four-patch series. Instead of wrapping the force
  helpers to work around the runtime PM callbacks, 1/4 fixes the
  callbacks: they test pvr_dev->lost rather than drm_dev_enter(), and
  hold no SRCU section while waiting for the watchdog worker. That
  removes the [Critical] AB-BA deadlock and the [High] TOCTOU at their
  source, and 4/4 returns to v1's raw pm_runtime_force_suspend()/resume().
- 2/4 fixes the pre-existing remove() ordering the review reported, and
  can now put drm_dev_unplug() first.
- 3/4 fixes a pre-existing watchdog-vs-teardown race found while
  reviewing the above.
- The review's "watchdog not re-armed" finding is answered in the cover
  letter rather than patched; see above for why.
- Added hardware evidence for both arms of every patch; v2 asserted the
  failure without showing it.
- Link to v2: https://patch.msgid.link/20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v2-1-66a938e92b87@gmail.com

Changes in v2:
- Don't wire pm_runtime_force_suspend/resume in directly. Once the GPU
  has been lost, drm_dev_enter() fails, pvr_power_device_suspend() returns
  -EIO, and the force helper hands that to the PM core, which aborts the
  system suspend -- permanently, since a lost device never becomes
  suspendable again. v1 would have traded a GPU that dies on suspend for a
  machine that cannot suspend at all. v2 wraps the helpers and skips the
  transition when the device is already unplugged. Caught by the Sashiko
  AI review bot.
- Commit message: say why the wrappers exist, and note that
  pvr_power_fw_disable() leaves the watchdog cancelled on its error path
  -- pre-existing, but system sleep is a new way to reach it.
- Cc'd Chen-Yu Tsai, Icenowy Zheng and YoungJoon Lee, who are testing this
  same GPU in the MT8173 powervr thread [1] and are the people best placed
  to say whether this reproduces on a Chromebook. That thread doesn't
  mention suspend at all.
- Dropped sarah.walker@imgtec.com and donald.robson@imgtec.com, both of
  which bounced on v1.
[1] https://lore.kernel.org/all/20260728091804.382753-1-wenst@chromium.org/

- Link to v1: https://patch.msgid.link/20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com

---
Ryan Brue (4):
      drm/imagination: don't gate the runtime PM callbacks on drm_dev_enter()
      drm/imagination: unplug the device before tearing it down in pvr_remove()
      drm/imagination: stop the watchdog before tearing the device down
      drm/imagination: suspend the GPU for system sleep, not just runtime PM

 drivers/gpu/drm/imagination/pvr_drv.c   | 17 ++++++++++---
 drivers/gpu/drm/imagination/pvr_power.c | 44 +++++++++++++--------------------
 2 files changed, 31 insertions(+), 30 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

