Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385E3502A5
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846980; cv=none; b=maNfEIa+mMqhx6tTmjqAWta3dg33w/YBowCY/3DhzcPH/RkIMnKbjPlxuVFfYwiIjeBFOrHd1NgByYLaPwWluQZNQph+9js2xqrJ6t2GoTOCl/LlVkielrU/qbiHoDnAn8K7bzc8WmegJaO1iKOmoI5dIXzDRQHHysWRkR1NpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846980; c=relaxed/simple;
	bh=oHaM34hp+B9wAo6Y7dFZXtCxJZUfh5bqm1Nuxuql9Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sL2yUeUNtxQAwqjG723CjCNIMXW5WGzIKolJ4p3pq4Bqy2v9wR9yZDwFsSZWUH3tkqrYISd4syQxGmhYf5m2W3bSKhdueo0gaRtqMUwLBO5wC2D/ZDuppc/XmRSXuuQwkhQ8hoWYuMExn8/FoC8EH3UHrhsyBDN8Nih1fSOejqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=haNHaKdR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="haNHaKdR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so4297796b3a.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785846978; x=1786451778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACp9n2o3Ordwb2znUSpgKmVNWolGQJeT8LdRSV1/Gjs=;
        b=haNHaKdRvadfIfFLC6UbmprU1LvMKpyi/cHhEHtQSDoetWSl76L6oJwNN2ZOS6rvQf
         E0kMwPRQhw4xlr7PUmIfEpkulxpynCVg9Va9ZHrVFapprymRpgKxf+AUNnqlNSyEi6V+
         pgyja77egGtcmz/TUxdlPW9GTlqM41fnPECt7PDV2bbLMmwcKHPc6Y9+gW/YyCqRB7Ix
         wLp0wLVVFPNuOuSFMjaLmwSfEJGfpvX2IMMWyRgsH+m+IAABT8T1dm/+Tz0n478ib4FS
         alTiYP/pfCWU7Zk1kISbxzw1aG0tNbvEaOui632mn5Q5hDFQ0Q8i8YGokGFLCTW/13wI
         LO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846978; x=1786451778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACp9n2o3Ordwb2znUSpgKmVNWolGQJeT8LdRSV1/Gjs=;
        b=BwVECsUBGFwMx0dBaRnsMdXFsKYAnCh7GnKZjfOqXoOEiMH6rPD57nGwnHLUrRkyYu
         93MPtgTdoAQeEYm6o9NwAIXZ2k+nx5jMe+1TuWL5mof8BDsFd6+Q3o3egouEexcpQEOk
         SrQ6fuJuM4ksUNdpCermyMKHEm5WqturbtbgZHvrJevVXxrE/rvFXHt0aUgGblauQNAI
         SgfzJCyHTXu4uOGnfVK98eQO6b2s+AaVJj/sCF9WJp5csH1cAHiaYmUDXa9PLbpT6e6O
         xiV7GcIvr4WeHlQ/gEuD8VL7Rg5MHWZju28uacvyQXE+JTCRarYBr0J8ECEspLB5mlMW
         e49g==
X-Forwarded-Encrypted: i=1; AHgh+Rpn+CVtgiopFEsYvwuKGJ+7kWca2XIbaA1+P0zkUu8QtidPu8ZnNRrXuhGcprkIqZ63OJS0l8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4r6XI83m/GSSOStdhCfxFpQms/NnJhvd+6wE7efPnLIvjqKsv
	DcLGg0reviGOGyQ6+qEvRKrfkZFXzmJz1J56ZWO45guW3dY67S+tTqI4kt8gDRQKQNw=
X-Gm-Gg: AR+sD13/4kT3+LNoto6W9MqJTfGdRClF9S6j/Ewryr0pL842OOw6HjbliIJmbqDWnIj
	OknfkOGwBMht5XrBsfDdGni5Zx5hFfn3b/+xihGKNbjHc2ckTyPOOinRoXwLCoADNqX54vKp1/j
	qzZcrgBC1m8+uGPjJm2KOxlaIMfaq67ZL2APGkFGpVvo/Q+S8VUZZ8bb2GfW5A4vq9CNyTd7IF9
	ZX8njf/1tnAzyF3JmcT8XQxPE9zfQErc6+kaKftZWN+d5chFn8/z8vleoVnEkTadJ3jG62xUkMC
	ork80pJZjRDE/R0BHvaNoVBkRsMm7ktTl8dVkjTh8gT0IRanAokJedn30O5K4TIG6ELrTW3GZ5w
	ccYTiEeK1s6ACXKvbDglgmAYFxTK/evniO1vRos4pM6Tvwc8ZNdh1fxmgTeNpNOZy7yXWi6kaX1
	QNPPRM7BVofgF13So0u34q2qWzZKzmDiSOgOiRrBHOmFr1xBKBdBTI2NOdiC2eUPHbvozdM4+uZ
	+UrWvaCZZU/hfzslO0B/IAXDxHftzA2W7Sfftc=
X-Received: by 2002:a05:6a00:4652:b0:848:2f7a:2e5c with SMTP id d2e1a72fcca58-84ee499eab3mr12628434b3a.75.1785846978444;
        Tue, 04 Aug 2026 05:36:18 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe593basm5086345b3a.21.2026.08.04.05.36.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 05:36:17 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] ALSA: FCP: fix OOB write in fcp_meter_ctl_get()
Date: Tue,  4 Aug 2026 21:36:11 +0900
Message-ID: <20260804123611.91715-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fcp_ioctl_set_meter_map() bounds the user-supplied Level Meter map size
by the driver's own limit of 255

	if (map.map_size < 1 || map.map_size > 255 ||
	    map.meter_slots < 1 || map.meter_slots > 255)
		return -EINVAL;

and passes it to fcp_add_new_ctl() as the control's channel count, where
it is stored as elem->channels.

Every control read writes into struct snd_ctl_elem_value, whose integer
array is declared long value[128], so the limit is 128, not 255.
fcp_meter_ctl_get() stores one 64-bit word per channel into that array
with no bound of its own:

	for (i = 0; i < elem->channels; i++) {
		int idx = private->meter_level_map[i];
		int value = idx < 0 ? 0 : le32_to_cpu(resp[idx]);

		ucontrol->value.integer.value[i] = value;
	}

snd_ctl_elem_read_user() serves that object from
memdup_user(_control, sizeof(*control)), 1224 bytes on LP64 out of
kmalloc-2048.  offsetof(struct snd_ctl_elem_value, value) is 72, so
element i is written at byte 72 + 8 * i and element 144 already lands
past the allocation.  At map_size 255 the last store ends at byte 2112,
888 bytes past the object and 64 bytes into the adjacent slab object.
The stored words come from the device and meter_level_map[] selects
which word lands in which slot, so extent and contents are both
controlled.

The core does not catch this.  snd_ctl_check_elem_info() is reached only
from __snd_ctl_elem_info(), which snd_ctl_elem_read() calls under
CONFIG_SND_CTL_DEBUG; without that option snd_ctl_skip_validation() is a
compile-time true.  __snd_ctl_add_replace() validates kcontrol->count and
never inspects elem->channels.

Installing an oversized map needs CAP_SYS_RAWIO, but the control outlives
the hwdep descriptor that created it, so the out-of-bounds stores are
issued by any process able to read controls on /dev/snd/controlC0.

KASAN on 7.2.0-rc5 (arm64), triggered by an unprivileged control read:

  BUG: KASAN: slab-out-of-bounds in fcp_meter_ctl_get
  Write of size 8 at addr ffff000017af04c8 by task fcp_trigger/185
   __asan_store8
   fcp_meter_ctl_get
   snd_ctl_elem_read
   snd_ctl_ioctl
  Allocated by task 185:
   memdup_user
   snd_ctl_ioctl
  The buggy address is located 0 bytes to the right of
   allocated 1224-byte region [ffff000017af0000, ffff000017af04c8)

Bound the map size by the ABI limit rather than by 255, and bound the
store loop at the sink so it cannot run past the value array whatever
elem->channels holds.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 46757a3e7d50 ("ALSA: FCP: Add Focusrite Control Protocol driver")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
diff --git a/sound/usb/fcp.c b/sound/usb/fcp.c
index 6f5dcd35e1d4..2bf572c6fdc4 100644
--- a/sound/usb/fcp.c
+++ b/sound/usb/fcp.c
@@ -129,6 +129,10 @@ struct fcp_data {
 
 #define FCP_SEGMENT_APP_GOLD 0
 
+#define FCP_MAX_METER_MAP_SIZE \
+	(sizeof_field(struct snd_ctl_elem_value, value.integer.value) / \
+	 sizeof(long))
+
 /* Forward declarations */
 static int fcp_init(struct usb_mixer_interface *mixer,
 		    void *step0_resp, void *step2_resp);
@@ -410,6 +414,9 @@ static int fcp_meter_ctl_get(struct snd_kcontrol *kctl,
 	if (err < 0)
 		return err;
 
+	if (WARN_ON_ONCE(elem->channels > FCP_MAX_METER_MAP_SIZE))
+		return -EINVAL;
+
 	/* copy & translate from resp[] using meter_level_map[] */
 	for (i = 0; i < elem->channels; i++) {
 		int idx = private->meter_level_map[i];
@@ -636,7 +643,8 @@ static int fcp_ioctl_set_meter_map(struct usb_mixer_interface *mixer,
 	}
 
 	/* Validate the map size */
-	if (map.map_size < 1 || map.map_size > 255 ||
+	if (map.map_size < 1 ||
+	    map.map_size > FCP_MAX_METER_MAP_SIZE ||
 	    map.meter_slots < 1 || map.meter_slots > 255)
 		return -EINVAL;
 
-- 
2.50.1 (Apple Git-155)

