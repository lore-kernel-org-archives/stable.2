Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792923438;
	b=mdWvesG7PRxUcwH6EIh3WmTE1SKuWfSk1ngCiyu5eJ6ZflkB0227g4qGkppUSanQMs0k
	 qp3P0o++TyX4Is3a8U/QBDqYftuxd0fangNrt2Wu1k0ab8HMzCCNpcsXF3318tn9Mlhde
	 l0CJCW82h6ucgEXr7jRKMW/wZ1kfqIDFN9S8srfPOgIAT8rN+3PUPB7Ej/IB86h6V2bOx
	 r6uUgYXBGW/FOm3XWMFStqadQl9AL1W3nVjbaExeH3eAdKRov6h5xYOWUJ49SkQkMxY96
	 mdNn3uPNfdrT2w1is9/9Br+yV/0iqEx1EJUMA1DX/LRAKVADGtZlpJPRlErHkjgvqFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923438;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aywIEJcQk95fG8yqIcjxmlvLYBajOmCJTLQHqNczgu8=;
	b=ijWS2Ll5yuzvmVeS9lqH+CknE3tv3/TZ/PWiHpq6NTpdKMc1/gnOuFFd3Ub+K/MCz+IM
	 8jRCNv5lf+OWukxlG7XEM1T6c6Z9/vq+WdudzyhpWRGKNYJ0DYw120BMsGl16LEGhlJku
	 dvYN2kLxXE7fI71XwoUdtNBWhmggJKpD6+rws7IclLxxBRDU5YZR8I1WiM0qRHzYYfsa9
	 gWoWTiUIBYXxQKIL57sMDiDEofmBKflWib98ISdrvK9qIYpPS32sFWlQUWoQFrRTZ+pi5
	 HlpSzvCpxzG40DKz+1/mDyIf9qQRz+eU1KBmu+8wJ69q9BaWh44cz3fvBtWcIsc6/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.com;
	spf=pass smtp.mailfrom=yandex.com;
	dkim=pass header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=EEYfXOWF;
	arc=none smtp.remote-ip=51.250.60.161
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [51.250.60.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA113606A330;
	Sun, 25 Oct 2026 10:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA113606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=EEYfXOWF
Received: from mail-nwsmtp-smtp-production-main-37.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.yp-c.yandex.net)
	by forward101d.mail.yandex.net (postfix) with ESMTPS id 85EA0C0055;
	Sun, 25 Oct 2026 13:17:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37 with ESMTPSA id tGcxncXiEeA0-zOYGgoQe;
	Sun, 25 Oct 2026 13:17:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1792923425; bh=aywIEJcQk95fG8yqIcjxmlvLYBajOmCJTLQHqNczgu8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=EEYfXOWFv9681Ho52IVEpkX/6dfK4Ss2QV/7Py6bd0W+nKcvwc174djHurL1q4aFT
	 HzN4AJwenj7cZ9S0gJ6cylsQ189Jyf+AT8mGGf7ye7CWgAMw3KQgeF3LsJ/3+KlwNR
	 x+lhRBU72VCyTJisII9bcYIxvVRJrPQL4yw84ztU=
Authentication-Results: mail-nwsmtp-smtp-production-main-37; dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex <xnderv@yandex.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/therm: mask the update bit when reading back the fan PWM duty
Date: Sun, 25 Oct 2026 13:16:40 +0300
Message-ID: <20261025101640.49779-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
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

nv50_fan_pwm_set() and gf119_fan_pwm_set() write the fan duty cycle to
0xe118 with bit 31 set.  Normally the bit reads back clear, but when
the register is read back shortly after such a write it can still be
set, and nv50_fan_pwm_get() and gf119_fan_pwm_get() return it as part
of the duty cycle.  nvkm_fanpwm_get() then takes divs = max(divs, duty),
so divs becomes 0x8000xxxx too, and duty * 100 wraps around in u32
(0x80000000 * 100 == 0 mod 2^32): the fan speed reads as 0%.
nvkm_fan_update() uses that as the current speed and steps up from it,
so it writes 3% to the fan and then ramps it back by 3% per bump
period.

The reads that hit this come from the two therm timers.
nvkm_therm_alarm() (the 1 s poll) and nvkm_fan_alarm() (the bump
alarm) both call nvkm_fan_update(), which reads the duty cycle before
it writes a new one.  When the two alarms fire within microseconds of
each other, the second one reads 0xe118 right after the first one
wrote it.  On the board below the bump period is 500 ms, so this
happens again and again while the temperature target keeps moving.

Seen on a GeForce GTX 560 Ti (GF114, nv50 PWM path) while the
temperature changed quickly under load: a bpftrace probe on
nv50_fan_pwm_get() saw 7 of 239 reads in two minutes come 7-25 us after
the other timer's write with bit 31 still set (e.g. 0x800001e1 with
divs 0x21c), and each of them was followed by a drop to 3%.

gm107_fan_pwm_get() and the PTHERM path of gf119_fan_pwm_get() already
mask their duty reads; do the same for 0xe118.

Testing: with this change the same workload and probe gave no such
reads in 155 and no fan drops.  The board was running out-of-tree
reclocking patches; the therm and fan code was unmodified.  The gf119
hunk changes the same register in the same way but was not tested on
GF119 or later hardware.  Both files build without warnings.

The problem was found and analysed, the bpftrace probes were written,
and this fix and changelog were drafted with an AI assistant (Claude
Opus 5.5 by Anthropic) during an interactive debugging session.  I
reviewed the change and ran the tests on my card.

Fixes: cb9fa62671ac ("drm/nv50/pm: add support for pwm fan control")
Fixes: bc79202f4c8f ("nvd0/therm: implement more appropriate pwm fan control functions")
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c | 6 +++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
index 684aff7..f56e763 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
@@ -74,7 +74,11 @@ gf119_fan_pwm_get(struct nvkm_therm *therm, int line, u32 *divs, u32 *duty)
 	else if (indx < 2) {
 		if (nvkm_rd32(device, 0x00d610 + (line * 0x04)) & 0x00000040) {
 			*divs = nvkm_rd32(device, 0x00e114 + (indx * 8));
-			*duty = nvkm_rd32(device, 0x00e118 + (indx * 8));
+			/*
+			 * Bit 31 is the update trigger set by pwm_set();
+			 * it can still read back as set after a write.
+			 */
+			*duty = nvkm_rd32(device, 0x00e118 + (indx * 8)) & 0x7fffffff;
 			return 0;
 		}
 	} else if (indx == 2) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
index 9cf16a7..9272256 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
@@ -72,7 +72,11 @@ nv50_fan_pwm_get(struct nvkm_therm *therm, int line, u32 *divs, u32 *duty)
 
 	if (nvkm_rd32(device, ctrl) & (1 << line)) {
 		*divs = nvkm_rd32(device, 0x00e114 + (id * 8));
-		*duty = nvkm_rd32(device, 0x00e118 + (id * 8));
+		/*
+		 * Bit 31 is the update trigger set by pwm_set();
+		 * it can still read back as set after a write.
+		 */
+		*duty = nvkm_rd32(device, 0x00e118 + (id * 8)) & 0x7fffffff;
 		return 0;
 	}
 
-- 
2.53.0

