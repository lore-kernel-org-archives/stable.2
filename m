Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837045;
	b=hPi4N4OcbfcQ78onzc1FE6u8IV3m+ykrf+ohs6Y0586b9Ef0SZY2GFfG+20OgJS8G+PJ
	 Zptu2KON1dJ33XDtLKE7DN3MupT+V8NMPrBRWgqTOqNW97xHFHp9P5Hog3WHifziS8Vn+
	 dyrpLefI7eWnNl9pnvc1hpLRvp/WLVmBYIfUugY/XTsx7tkIG11pCNE4sRSMIQt9Cf83V
	 Yg/4Myo5qN+3o67Rii1EMsPcZ+v7mJH+02srPm2t4QgN7ix1UY3hiO2E5ylY6CnLWY8Rg
	 ZHKTsifycpuHruT0jXW8t5WpdoRjv/3QrCyvauyQiHqR4P4sU7fndazTIp+QFUU+M3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837045;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=tkbLrbTkKrmPpxYmc1G/c3qRueui5Pe/3v2IvJX2qp0=;
	b=QdgHxOnefa8utfbzM8RTRiTzBp2Ep1yCLaEF53j7Ya4JMTKyEpqyfbe5D4ZHRO90Suvr
	 Y2u4PyJWptS6egzRmGC80K51NPfyFfEfOCFCTpi/1p7acKD4ui8OYpoqy9VISHKa+2FNs
	 cKY49v+TpqDpZWOKkOeRLn42WnLV7Oq7Bx8teBw63RaTBVKmVFcPBY6Sgq6nLridJh3rJ
	 kLZVv2kSBw+DzZf5Ll6JQHYN7ik/RwJVgDDRm9zHUERLEhuhGduCWJhu3ZzsmRtbu1nuX
	 h4suGcS70r/iwJ15xe4JaXjxgBebmK6bkIk9XP++wUizWzaixnvbm6SqgzDfES8ezVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=DtkQG75w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE3606A333;
	Mon, 16 Nov 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=DtkQG75w
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837045;
	b=rlkOPmEfQevXFNmd5YBdPm6ThQOTUZBYybfQfVahJAorsHAOVjWEo68gdhl5WtSsQaOc
	 ruHEb0FxM7Nz6fIe0LqDB/1Cl6pEnGLSWKowFj08JowtUUh6b23XyJfrUHLaDpSYkv4vX
	 lKMed84bVdpApZFb/uQ5WAnFAnCKHslXBRwfZq93z++/Q+iodAxeozx3rAhk9BfpQkc82
	 pZsvC2fxMYICkugidLjH5PSDsoG6u15YWXmm0DIcHSdW53H2PH6/vHus1+3QsOApRGIES
	 37zaTvnNFUuIkJFpO8ssxAbMn26Wjap+g7aOshU3vRd0yahZx7c2mKrJxd/RXzvWBQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837045;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=tkbLrbTkKrmPpxYmc1G/c3qRueui5Pe/3v2IvJX2qp0=;
	b=khc2IMQh7jNI01MeETPuCRthnQFRVD2Jebp0U3zBIUbL0xYIXNBywlANtd1HoQRgZKBk
	 D+ILFnviMEQVqaFUYpRy0D2xdRaY0B9FtYW/sv9p/XhWMTN7TRi9j8w+S/yZk21wA+raD
	 AlDwwC3lMFM+Wpk9Ldm3IdxsmEmiMXNpXpBPzzzcVjM9D4IsK6limERTKgopDg6apU5zN
	 odzeHqsrS4ffRwSQc5bIDR5Z2KNaNIVrxvFLOsXW3L5UY048pagT/Gno32jwl0J0OjmEl
	 YbVlWAq7z6VHJ/+LRUi6zcCQuT9aPkvCvoWHn/YQTX2vgOjVRgKPlCi78FR8sfZ1IVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4017F1F000D0;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837045; bh=tkbLrbTkKrmPpxYmc1G/c3qRueui5Pe/3v2IvJX2qp0=;
	h=From:Subject:Date:To:Cc;
	b=DtkQG75w3Q653N2wZIdPU9AL0qiGpusaL+Lm/6ypmcG8X7u1xNqnoRoPJbdsVrnp0
	 k8R2hKQTEnyHAJpoJFiLnTJn8sMYnqgaQ9wzM7zY1qHO5r2jufxBA3r4bsuMOMFq3k
	 UU2EE5qC5cTLZTzshedTsSna4MX0JatLlVxSUrpo=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 924014A493;
	Mon, 16 Nov 2026 13:50:43 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Subject: [PATCH v4 0/8] media: i2c: ov9282: fix strobe timing and control
 handling
Date: Mon, 16 Nov 2026 14:50:21 +0100
Message-Id: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPyw6CMBAF0F8hXVvTTgFbV/6HcdGn1BgwFBoM4
 d8taHzg8mbm3MmMKNjW24D22YhaG33wTZ1CvsmQrmR9ttiblBEQKIkgAjdRAAfs/GADNlLw0ki
 lgXGUyK21yyCJ4+mZQ68uVndzx7xR+dA17X25F+m896qm+W91pJhgVwCRrhDGUXW4+roftsZGN
 FdHeGNK/jAkzJRiu9JwRaVYY/bBlJIVZglrVRrHiU6vwTeepukBrucaAjQBAAA=
X-Change-ID: 20260909-ov9282-fixes-da986dabc238
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Daniele Alessandrelli <daniele.alessandrelli@gmail.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Martina Krasteva <martinax.krasteva@intel.com>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Gyula Kelemen <gyula.kelemen@advasolutions.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=3997;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=Avrpj9TSbmW8HxXDV/hEDnUl7Dl+3qFFb1QyyA6F1Xo=;
 b=AFBCuY8SUyde0cytqozu7FgSQKVyixaZAfC3CnKxKcTU0Q+/BZK11+ER+2lk2uxW/XXSHfW2F
 YCrUa7FrH0eD+s4MpJXCNV8xCs6KCOrJfCzjjMf61cbzqnFaTHJWSGJ
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

This series fixes a set of related issues in the OV9282 strobe timing
and control handling code.

The driver updated exposure- and flash duration-related control ranges
in several places, but some of those updates used an incorrect timebase
or were triggered too late, which could leave the controls clamped
against stale values.

The series:
- checks the return value of the exposure range update
- drops the redundant vblank field
- converts probe error messages to dev_err_probe()
- fixes the 8-bit pixel rate (192 MHz instead of 200 MHz) and the
  corresponding line time calculation
- treats the strobe frame span as a line count and converts the flash
  duration accordingly
- fixes the flash duration range (min/max/default) and refreshes it on
  HBLANK changes, independent of the sensor power state
- refreshes the exposure and flash duration ranges on mode changes
- reprograms the strobe span when HBLANK changes

This series was tested with an ov9282 sensor on a vision components camera
module attached to an i.MX8MP mainboard in a defined (dark) environment
with a custom made LED flash pcb.

Any feedback is warmly welcome.

Thanks!

---
Changes in v4:
- Replace DIV_ROUND_UP with DIV_ROUND_UP_ULL to fix 0-day finding
- Link to v3: https://patch.msgid.link/20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev

Changes in v3:
- Adapt commit texts for 4/8 and 5/8
- Thanks to Dave the review!
- Link to v2: https://patch.msgid.link/20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev

Changes in v2:
- New patch: fix the 8-bit pixel rate.
- New patch: re-write strobe span and HTS in s_ctrl when HBLANK changes
- Calculate line time in ns using 64-bit math instead of 32-bit µs
- Treat the strobe frame span as a line count and reuse the helpers of the
  exposure -> drop OV9282_STROBE_SPAN_FACTOR
- Flash duration range: min is 1 line, max is S32_MAX instead of the
  current exposure time, default is converted from the register default
- Refresh the flash duration range on HBLANK changes instead of on
  exposure/gain writes, so it is also correct while the sensor is idle
- Add missing "\n" to dev_err_probe() messages
- Add Fixes: and Cc: stable tags where applicable
- Reorder patches to keep non-fixes at the end
- Reword commit messages and subjects
- Thanks to Dave, Bryan and Sakari for the review!
- Link to v1: https://patch.msgid.link/20260914-ov9282-fixes-v1-0-f520af59df1b@linux.dev

To: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Daniele Alessandrelli <daniele.alessandrelli@gmail.com>
To: Paul J. Murphy <paul.j.murphy@intel.com>
To: Martina Krasteva <martinax.krasteva@intel.com>
To: Richard Leitner <richard.leitner@linux.dev>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
To: Bryan O'Donoghue <bod@kernel.org>
To: Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Gyula Kelemen <gyula.kelemen@advasolutions.com>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Richard Leitner (8):
      media: i2c: ov9282: handle error from exposure range update
      media: i2c: ov9282: fix pixel rate and line time calculation
      media: i2c: ov9282: fix flash duration to/from microseconds conversion
      media: i2c: ov9282: fix flash duration range calculation
      media: i2c: ov9282: add refresh of additional ranges on a mode change
      media: i2c: ov9282: recalculate strobe span on HBLANK change
      media: i2c: ov9282: drop redundant vblank field
      media: i2c: ov9282: harmonize dev_err_probe usage

 drivers/media/i2c/ov9282.c | 236 +++++++++++++++++++++++++++------------------
 1 file changed, 144 insertions(+), 92 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20260909-ov9282-fixes-da986dabc238

Best regards,
--  
Richard Leitner <richard.leitner@linux.dev>


