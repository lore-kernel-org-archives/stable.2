Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703373;
	b=1jWutNMtgCZg5pkyHTHMTOpVRFcNLuBVDdpgrgWGbzw0eqD1IHTZuohoGB3SvYgLKa3q
	 YSoDkf51tafa/9v/iPpZyJ2F71p+c7+ZzKhSnvWhEvTxUICeCUJVZ45fFieS2gdGKSqkz
	 nFSCO7uOcBLHBSj9EJXEvKaMaPMhjsZExmarNg5ydA5SEdlc/elyiesB3V3tq+pLUmQmx
	 Z9cIi9rPkmdb4KfuishQIgagjEYzZD9ujFiMHFeKHDK6b7BAB80/W1JI7rHlS4RC+THEg
	 yQSysSGV1UJAh2zwNvh1fg2dEcH8OLQ+g8AGGXerd6ahsJBmM+hW3Nxnh7qgO2rT+JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=o5m6x1zTq9mQX096k7d8zrZcnlgwQ3oTTf7qyiSE3PY=;
	b=07nCA1LjzUHhDvR4F/LIIWr6Yu75dNcNGpmH3KgSnlFt/1TK+ZZGis+H5QXXaBRkQRg6
	 6iD4nxeuyxho9L+NVn0rIwSUBI8TD4eTKn3RLuliLdXmUC4VUR1yj6vOFVK06LA8izEEv
	 DfQVZp3J5wyqLfXyjij2x8blW2HP5YPlWtY36yhfBgBImqUmpfO2P4gOXWXwV05Oem7wo
	 Twzl0zvjB0IzsdMoABI+Bi+UJpWQKwZjL0q6Hjt2DiYwTFat8N2p7k2R1Mr9u9tsIvgAD
	 jvYF+hbzHdIglOghh4vPjZEoHYpuoEFftv0Xf8Nej0zo4sP1BI1rGQGxY2u3pMAlBXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XbLYk30j;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16683606EEA9
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16683606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XbLYk30j
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso649740e87.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793703370; x=1794308170; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o5m6x1zTq9mQX096k7d8zrZcnlgwQ3oTTf7qyiSE3PY=;
        b=XbLYk30jfXunhsEYxjVwplYjk4X+rlhKam6UuehkAzt1FaP3n2VLvzloSSe4MVDJBQ
         nWd5tH69f0pKXulOG8ihw8TZPrCSll9OXe2Mtdu5fz1uZjBsDWZB44nO4YOsbsU7VEKA
         ++XSzzNMTzcWucoBurdROfSfmGsXmuPszhqJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703370; x=1794308170;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o5m6x1zTq9mQX096k7d8zrZcnlgwQ3oTTf7qyiSE3PY=;
        b=CB23fKBVchL8HlkoClLwa9+P/DiubNHn6Tl0F/TcqDRf70IPXXLVzPNYhX/VkY2kV2
         5i92cTchIYphWEnMMhfBAnnSWyYothROSHA1GPRYp7lURINMrYtkDwsz7Qcgh4PCCHLU
         X7vaxvJaR+oGVZWIaoeWOfQdXYGILyugs5HpMmDJKd5gI/np6v5rNEoXkUxyFxGBewMp
         0dRY+Xm1+m7AULcflb0j9d3UtZsixkYhP2kgi+jHeXnvtOPJI6cChNxTBQEMW2ztqDlz
         zL9sOakVDkGEJZmlpHWGhFkSWz0hK6nRZ5eEsiaZt0hErYBJgHqWVL13HgMYCC/Hp4bt
         sSJw==
X-Forwarded-Encrypted: i=1; AKwUvByqXyBJ/1MF5RRtnoqIOJ9SOckGOwL5otdh1tGc/yb1ig4stnpCD8IhZLuecLl9muqQOU58AeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z83W7ULApdafu9ioKRN/7fxM2zlva+h25l4ubfrZrhtrXVgwYck
	PkZYjls7U3uFzedxCttwuMetP0F3P4k72199SK/7k8VQ2LL1M6AfMvVwzmlrZN/kKcK88ab2MmA
	/WNrnytBk
X-Gm-Gg: AYBFou2KcKK+/4iJMyapmgmHOXTj19K5K8Z9iXuaSyEAC1TsdlLC3+U4OAgkeBIwqFw
	/ea4Soz5N4KwT2s50+ZEkiUHu6w7+CFEqWrlkAfiiXYhmE96q8EPQxb8IZn7UdvGgLXs0TXtYQt
	QoJBXHlQCIkWdWOLf34a7+P19LTh8YNRvRu9Jesj5ZIvOpcEEDUF6Wpn1wVSnNM/aspgh3mWjqN
	BZwJdGo6SPnqW/3LNy7SwhcsO02YqIMBOJSMllz19IhX6k7WfhmxTeK42BMaIVNi+H1/NIgnNW/
	XzN55XvxMgQ6gL0W3k0LppOXsxbvs0dVF809Qup711ptAlrw2l+78ekK30n/rLhGY7IRVxdrjIS
	Sbs0W2MUwHk5tl2+mi5F+pEBIkLjenpF1e/lY9N46PIEwLea/Q/bU6oYAdZPpDYhxs65hNth50L
	k+ZHy6CRqO/VmAXSF3RM3T91xXdhfODiReh/GxZbqGgAt2xvCWyaGRA45c3Gt8OIXTyvOasd8Db
	E9u8Ywpeu/8zbdrlDu9XH/DZrQADGPJtkmV3LcWvNc3Pm/TCcMQ4T9/X1ZxwCPANMPVIyDIP6Rk
	jsPxBG+KSeslngW5hFZydsPSsuasM/QQdZ5RX1cwC7R7/djgeZXplTEWMUTvo68sldIa8jknpMf
	Z6HaUxPsvOSxg9ndUi4LnLyjHvS43z9w=
X-Received: by 2002:a05:6512:1325:b0:5bf:a34f:14ce with SMTP id 2adb3069b0e04-5bfd11e9f41mr4389560e87.11.1793703369932;
        Tue, 03 Nov 2026 02:56:09 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe0754779sm2103257e87.82.2026.11.03.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:56:09 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: videobuf2: publish buffers in bufs_bitmap
 under mmap_lock
Date: Tue, 03 Nov 2026 10:56:07 +0000
Message-Id: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMe96WoC/3XMQQ7CIBCF4as0sxYDVIx15T1MY1oYykQpDSjRN
 Nxd7N7l/5L3rZAwEiY4NytEzJQozDXkrgHthnlCRqY2SC6PQnDJ8iiZ98NyewR9Z53qkGt9QDO
 2UD9LREvvzbv2tR2lZ4ifjc/it/6TsmCCWVSKW+QtmtNFuxg8vfw+xAn6UsoXYTpcyK0AAAA=
X-Change-ID: 20261102-vb2-mmap_lock-959e0cc4edb3
To: Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

vb2_mmap() only takes q->mmap_lock, not the main queue serialization
lock (q->lock). Commit a286b0837e13 ("media: core: Add bitmap manage
bufs array entries") started setting bits in q->bufs_bitmap inside
__vb2_queue_alloc() before buffer memory is allocated and without
holding q->mmap_lock, allowing a concurrent mmap() to access a
half-initialized buffer and hit a use-after-free if allocation or
.buf_init() fails, and prematurely counting tentative buffers during
partial-allocation .queue_setup() re-checks.

Patch 1 fixes this by dropping set_bit() from vb2_queue_add_buffer() and
publishing the range in q->bufs_bitmap via vb2_queue_publish_buffers()
under q->mmap_lock once allocation and .queue_setup() succeed.

Patch 2 adds smp_mb__before_atomic() / test_bit_acquire() ordering on
q->bufs_bitmap for lockless vb2_get_buffer() callers (such as
vb2_find_buffer() called from stateless mem2mem .device_run() while
VIDIOC_CREATE_BUFS runs on weakly-ordered architectures).

This series was generated by an LLM, but supervised and reviewed by a
human (not the most handsome human, but a human).

---
Changes in v2:
- Keep vb2_queue_add_buffer() without set_bit() so __vb2_queue_alloc()
  stays unchanged, and add vb2_queue_publish_buffers() using atomic
  set_bit() (rather than non-atomic bitmap_set(), since vb2_get_buffer()
  has lockless readers).
- Split the smp_mb__before_atomic() / test_bit_acquire() memory barrier
  pair into a separate patch with an explanation of the arm64
  VIDIOC_CREATE_BUFS vs vb2_find_buffer() race.
- Drop lockdep_assert_held() from vb2_queue_remove_buffer().
- Simplify the !q->bufs guard in __vb2_queue_free() to 'if (!q->bufs)
  return;' (still needed as a NULL check now that __vb2_queue_free()
  indexes q->bufs[] directly instead of going through vb2_get_buffer(),
  since vb2_core_queue_release() and REQBUFS(0) call it when
  q->bufs == NULL).
- Clarify @bufs and @bufs_bitmap documentation in struct vb2_queue.
- Link to v1: https://lore.kernel.org/r/20261102-vb2-mmap_lock-v1-1-fe550fe03ed8@chromium.org

---
Ricardo Ribalda (2):
      media: videobuf2: publish buffers in bufs_bitmap under mmap_lock
      media: videobuf2: order buffer initialization before bufs_bitmap publication

 drivers/media/common/videobuf2/videobuf2-core.c | 74 +++++++++++++++++++++----
 include/media/videobuf2-core.h                  | 14 +++--
 2 files changed, 74 insertions(+), 14 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-vb2-mmap_lock-959e0cc4edb3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

