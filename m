Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858676;
	b=UDtHv5K1z9cqufl7h6h++AOQaB1i7WK1fDfpEfDAILOA7DnbkiN0fTso7REhtoy9/mxv
	 rEasQkf/H7vk2dfpqM0q2fFhdWazI8Lzdtud04Y0KrgQGU7vw+rSSgWrU/Thth6MTJymO
	 VNPzozasYfbQmT2nML2z9XV82NcSf1uQgkwHYtfyIqP81i3MmD2X5EioKX24oecCB0IHP
	 ECF4yB3VjxNjCb+EY8JC6Jp0+zmNP5ukP7B0d2MhPDR1ussG/wCE0XCBJDuiK6fVGZm4j
	 L8a6Ypscx+Xf6ioZrX3eH+Z+EzslcgSY+hs5Mak6lgUIQKJKhR9z4aTsNZ17m287wpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6JrtG29F6YmjX1if1HVP+LUFJxu86N0pKm/C06N0tvM=;
	b=IWVdz9a1+dH4lcmJs8RBkN2ALyikwDm2XRpypnGNWLyBZMIz4sjpcIoBQFLOKY4XkMty
	 jJfbW2G7Hin5hCR1Gvo6nftTRzQ5fcTIoB17HmS/uDbO8cTfv87bvxcsfVfQsIXtE7fh7
	 phL0Ct3PGBDtr9i0hqrakM1HNTjMt4t1ncqXhLr6pOEbrxTHnDt1jQwaS6ZakDsMoRgxU
	 yHjsiZe+PtTxkxwuiMgOjxy5RpTskP1SFHQjPUMol/u5yysnKgcDiOWl+wegKtdlPsvh5
	 URKZWGmSJSuXGjj5eOeKWbCW7SfM3/Y/mip5CgvTd92+TEMmYqSqJ9Yg5BfhPpQXEAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TVQOyYjO;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75711606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75711606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TVQOyYjO
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0b8b5d28cso55851a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 22:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793858676; x=1794463476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6JrtG29F6YmjX1if1HVP+LUFJxu86N0pKm/C06N0tvM=;
        b=TVQOyYjOAVItUVHrL4LJGmA6SaBPDrxd55HCsAshRwiwqExexFaWANKBODSZQltlEw
         NiGlk2tiAhdyoX5sQcJS6h07oX09yhOIBNu7rMfjlkM+F6NBDZ9JrtRFClxBiCQWMj6N
         0P52TPH1VoZ+8IMeVtI/1WWSJTf2sUt9N4bUqWLzVDoKq9WIk9GzNW4Und+8PNLmuJG4
         oDd8RCet9ag51PL+SnPPU3pGxXy/v+Lpq6mk2LH9IKUaD04auVJ+gBT8C1t7HYo0k7pb
         CdPwfA6M58UMk4icOJztL8ghBnVO72JKFlxSPWeW/9DYU90lSMatm1B+AuhJwNGxaHpw
         58ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793858676; x=1794463476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6JrtG29F6YmjX1if1HVP+LUFJxu86N0pKm/C06N0tvM=;
        b=kcSUujV2obrR5cAG1BbnuUezoQFgKt6Z5mY6EXHjMgt98ySHtpJPy3ApGKOBRzTyN2
         BO9CuSMwT/6UiV1b0MmkLwF4ADSG344RKiTFsCBwra2i9r//TmIjYpVyyUWCnzdvb5v2
         t7W0Lcp1r5s2QeVjATxX+6lga9IiKcdObgUj5zrCZA3JgSiQ5eCtnowARykU37JuZBur
         bP9TgLVKYH24aSnISoLw6Faoi020SLOK39QSpVgNRw/ECxGYOL8BQZ6vTV9KatupUPPn
         ohSUA+JlKsbzUsnmHPjCG+T4R3HpMrv6Vnpd3IOi+ebRssBTc7HtxvfWc2OX7jpzZne3
         LQgw==
X-Forwarded-Encrypted: i=1; AKwUvByvWgczlrxwlpIYaUe5m7poEBGqjsLknZjKKtJy82AQaP/U4Pru7c7NPlsZmdjhnwppy7QTSTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8y2bfd7ZB29iZ8jnDsnZKCNIbjmsI8iGy3YbbJLdGkkhT3yKVC
	PKjRQMHpAcoykXPL0MygrMFH4s0BVlR1GYhzXOkWY/kRROVMFycHzzwn
X-Gm-Gg: AYBFou1SQLg31RhKGrv3IwAnokEHFNUEEelqaghn8wdJ4ESlwjNcECSWvtMtgA0M6L9
	09LCxz2ZRh7s5SecDvVp/utiJi9eh2Yn6eDT8+TiMifb3SWb07/we5TWMr609YVFrcHnOulK89n
	YM9+Evq50E5zEPT9fe1aW+YsawMQqQPwv7KIaiUwJDYqGIACzjjOMjVF98FHR7DVjvlxUqIn9qg
	nDYkJNjfOGlJ9BPOjUG+NCM6sqm3HRkY3w+uG0z8pU8M7nkvjkHx8Hyt1eyvRF5VRDMNLVK/W3t
	2zzA+0eQ0XnRW9GTrhG6dLv/+PC74OWCg5JfUe93pV8jgB1FrZKLU8hpEP7AbM3HwVFB1MhHjJd
	d9EmxfQvL3oZhpr9HFPwcnrYyKOjAb/JkfcPNtF5MxUDRlTEqgyTI49jWLDc9/D5JaecOJep7eR
	6fZ5hJqcIy8N/CoAVS4e9ucm5YE5ayglrAscP4Kn0WhGvWApxRSACmWvdVLPQfxij6PC5bWd13M
	AYunwVsjlGTSREPlsWEt4G1t8zVVy+/si/j5KDCmVmFeOKxL0aBUmYVAjbRGnWDuwDGmfADHANk
	lAJs4Sh5TqLscbYJkLHMme4smQ3v2MQi5sPJ+ZhmUg==
X-Received: by 2002:a17:90b:28c7:b0:3a7:fef3:8561 with SMTP id 98e67ed59e1d1-3ae89822b55mr26092371a91.5.1793858675639;
        Wed, 04 Nov 2026 22:04:35 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm2093100a91.1.2026.11.04.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:04:35 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	ville.syrjala@linux.intel.com,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	stable@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2 0/2] i915: two teardown fixes (gen6 ppgtt ERR_PTR, OA config sysfs leak)
Date: Thu,  5 Nov 2026 14:04:20 +0800
Message-Id: <20261105060422.51848-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Two independent small fixes found by static analysis:

1/2: gen6_ppgtt_create() stored the result of gen6_alloc_top_pd()
     directly into ppgtt->base.pd; on failure the ERR_PTR stayed in the
     field and the async release worker crashed dereferencing it in
     gen6_ppgtt_free_pd().  v2 follows the local-variable pattern
     suggested by Ville: assign to the field only after validation, so
     it can only ever be NULL or a valid pointer, and
     gen6_ppgtt_free_pd() now bails out on a NULL pd.

2/2: i915_perf_add_config_ioctl() creates the dynamic sysfs entry
     before idr_alloc(); if idr_alloc() fails the error path frees the
     config without removing the sysfs entry, leaving attributes that
     point into freed memory (UAF read via the embedded show()
     callback).  Remove the group on that path, mirroring the remove
     ioctl's ordering.  Unchanged since v1.

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v2:
  - 1/2: don't assign the error pointer into ppgtt->base.pd at all
  - 2/2: unchanged

v1: https://lore.kernel.org/r/20261104073311.1617823-1-lui2012qwq@gmail.com

Chengyu Liu (2):
  i915/gt: don't store ERR_PTR into ppgtt->base.pd on allocation failure
  i915/perf: remove sysfs entry if idr_alloc() fails in add_config

 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 11 ++++++++---
 drivers/gpu/drm/i915/i915_perf.c     |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.25.1
