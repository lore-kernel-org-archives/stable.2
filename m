Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278841;
	b=lu51RWEDE9IzhaLhDOcF4VvlaINlZSoP+tsy9diPxliORzREDN18wBm3WNTj46S1n36g
	 42/WdbWW2s7TNMiDFZ+UDDfQmEMMZCn5nw7dfm7UdRgqsUU5SDLwKpCOlqht0/YvAuhTY
	 dai0N/UGA02JW4+G8KiS8zxjsmHqZfUDikNg433w1r5EqZhm89cUzMYZrbSDRdwIM9OMa
	 djcbxb81hH+NXqxGDC4kjqTsRSWAFuhVmdQLzmGEICR3iU98vgfArO3ZG9ixUD0GS8+eh
	 Fdbk1eo1zgjQxmRuvB+vJededKwRs3gRCVH/aQNJ01KG/jhFnFBZziI9cbR0Yvhmv8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278841;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OUXYjt8dvAsEPE6PsQOQb6gwqlZLQFgR3EWNJ6ptA0E=;
	b=w+swS1t1z/pksVy2iWvDrNIrEZ5ZYq5WqA/qJv2ESdTF/rMmh/YyH2gzfjehwVXOTx04
	 t1Pro71znWdFS9Mf4/FyyFyb98gw9f8ohVFAwx/TN/z1OdDB+QXt4JUev1qZBNMnNwNrA
	 HEsu8NHK3OvWltkymJaOokw6y5GMf2paSdvmOWEoafnfYah77LKlfSOibTQPu8PB+oy3H
	 0VEwORti8GqVJ72Izbk6A/rPfS2VcjFHRSefebG+gzi2zhG/9rFc9khc4R9SkDgvcoBCc
	 7oyotXTsnUiIJEUovIYfoYCCogKBE5li2S/e7P51J1DlzEHzI7v3OYK7tSgHsHms8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.com;
	spf=pass smtp.mailfrom=yandex.com;
	dkim=pass header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=LGzwtka2;
	arc=none smtp.remote-ip=51.250.60.163
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218D606A333;
	Thu, 29 Oct 2026 13:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9218D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=LGzwtka2
Received: from mail-nwsmtp-smtp-production-main-94 (mail-nwsmtp-smtp-production-main-94.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2501:0:640:a27e:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id E9726C0844;
	Thu, 29 Oct 2026 16:00:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94 with ESMTPSA id G0j4ICQiIeA0-NuWAJvZs;
	Thu, 29 Oct 2026 16:00:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1793278830; bh=OUXYjt8dvAsEPE6PsQOQb6gwqlZLQFgR3EWNJ6ptA0E=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LGzwtka26ZTwj8w/A8gqOP8u+QKep05jpFHjy+bV3NIb5JGQ1N10zm84udaFNNx+A
	 Sx/hm5s1K06tQH4wk6Cd5q48lv2LF4HlCpM5nrIH5zd/kOaRFoS8IvEZZfoDIYDpEf
	 nNumWk/X+clpOFjd3ymAaVxLxfmoRT4nkot4tnEE=
Authentication-Results: mail-nwsmtp-smtp-production-main-94; dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Martin Roukala <martin.roukala@mupuf.org>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex <xnderv@yandex.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/nouveau/therm: mask the update bit when reading back the fan PWM duty
Date: Thu, 29 Oct 2026 16:00:12 +0300
Message-ID: <20261029130012.21738-1-xnderv@yandex.com>
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

Found with the help of an AI assistant (Claude); reviewed and tested by me.

Fixes: cb9fa62671ac ("drm/nv50/pm: add support for pwm fan control")
Fixes: bc79202f4c8f ("nvd0/therm: implement more appropriate pwm fan control functions")
Cc: stable@vger.kernel.org
Acked-by: Martin Roukala <martin.roukala@mupuf.org>
Signed-off-by: Alex <xnderv@yandex.com>
---
v2: commit message trimmed as Martin asked, the details moved here; one
sentence on the AI assistance kept in the changelog, as
Documentation/process/generated-content.rst asks for tools used to find
a problem; picked up Martin's Acked-by; code unchanged.
v1: https://lore.kernel.org/all/20261025101640.49779-1-xnderv@yandex.com/

How it was found: the reads that hit this come from the two therm timers.
nvkm_therm_alarm() (the 1 s poll) and nvkm_fan_alarm() (the bump alarm)
both call nvkm_fan_update(), which reads the duty cycle before it writes
a new one. When the two alarms fire within microseconds of each other,
the second one reads 0xe118 right after the first one wrote it. On a
GeForce GTX 560 Ti (GF114, nv50 PWM path) a bpftrace probe on
nv50_fan_pwm_get() saw 7 of 239 reads in two minutes come 7-25 us after
the other timer's write with bit 31 still set (e.g. 0x800001e1 with divs
0x21c), each followed by a drop to 3%. gm107_fan_pwm_get() and the
PTHERM path of gf119_fan_pwm_get() already mask their duty reads.

Testing: same workload and probe with the fix, no such reads in 155 and
no fan drops. The gf119 hunk changes the same register in the same way
but was not tested on GF119 or later hardware. Both files build without
warnings.

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

