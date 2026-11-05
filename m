Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857824;
	b=I7JG/tj9fGcU4m0iWny7oqlPQWaGFVLNhmHW6CsQKDdRIFW5p8u8hLog90VMS/87yFAv
	 4aqRFWMg5BgJIbxog9emDtkJWUPZUaqIJjU94DKEY+UylHzSmMpyQuydm7QM5bM9wP67A
	 w8aMqT/XZ1Ve7K2zg4rOnL6jsM5pVhRmlQ3PDi2Ns0K5izZibGeG5BtpUp9NrT5wuZlUx
	 /qb0SQOhM0ut5puft0Sun3zW/y9MN9EvBfHfYhPYaBvqTyemhN0yWJB562XKg04M0gwgv
	 bH7+8gZ+4pSO0ozsLlUEzbJu+Onw7rPQL4TLF57PuzdVIsPmgQUajZBHoqsRTe/CMng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
	b=GkHBt6Z8M/4qJqRIxETWHCMc4kchKXR+PGATOENRlVYwqdvyyKeh+5C1gUbehHnHNvSZ
	 Fe622msPkNt9f3nGLEkeBZCxF6wdRuAmQb4g1oWCk498D2o+UGBGg81WNfbU2V0tjM7sc
	 r1dIGuH3mkdckOe+ykSMppUMb581hzeberGzDxS5occZ9O4NULBT5E6TaWzthN0qIbajo
	 DP1KtZbl/V7bP5qzhoFy6vr6GM7WAXYQ6MEZmh+nJIC4Ym4YEXYAhWi61Hhrwj9EiijFz
	 rxZz7gVw/JvNMvdrbfmOGz1URSc45UkUnBMhCMfcOMxC/8aWsgFrZbJgElgylrmtB8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7onWOzj;
	arc=none smtp.remote-ip=74.125.231.131
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E4606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7onWOzj
Received: by mail-oo2-f3.google.com with SMTP id 006d021491bc7-6f436312596so633216eaf.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793857823; x=1794462623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
        b=O7onWOzjsuEnDLg4/mm9LN+dwnOuJIJ6TlmvN0CDVQRKe9VqzO8uwugEfWetLXiAFj
         DH1BtRCu7FefJRt250fTr1x+UiIHkrtf0snEB/tKlb1pyg7gy2RlL4fyc4tkqjlIrvgY
         OXvja5HKfKWkkhAnsRlNxUWQ//NMN4zIPUzx3sfp9uDdwYEVBRomwCDHMXKOpl5SqoBY
         fSDikrjiAPraCQLd4db5+v8/YYs3ufUabHv4LbZz6KYbHZDRv8GJGWaPq8o+ps4rH9r1
         /uVQ+GiM/sPtlvUsUCytaDABrVddYXRS1lGn5ys4PrssA9Hbo+epcpGsUgMTQv2x2qB4
         a9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857823; x=1794462623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
        b=ZKaaocDoB4HO1EucdJQ8AMJXIYsbCUJcmH0ZEzHxmtMDnbifVYd1iiUtr1EcMmXDjw
         +VWIGkV09xnzv1kIbwGGG+kNRK9QPdd0vtrvPgXp3jxBCPknTf6gdiyD/8ghbqOMU0wn
         AWZ96KYf83B8uIe3Nom1w/V0twAfq/CMEIA1HbopMIKDP5HxuN+Fej2M9PJ2EAf+6whq
         osBAcCu5+P5K/HP37l6kLlNnjWr0sZjhnJE+SiKKrMtzDm96D2FzAUyzjMnSccORqNUJ
         p31hrIPg+0YAsx+V2hxuOiKKpOQRl5kBa8S1qfSziUWbrz6fhZReS333MWMgsMuVdCNn
         hxHA==
X-Forwarded-Encrypted: i=1; AKwUvBySZ5QWq5cftzbTByKKFW3gMkmD2FR1nkVIs3iolfZm+fYR2Y+FNnf/1zojQ1zecZsdNeJ/IiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cSXWI8lOoVcKgDAVtbBhb8793o9DScRRUuJZAr9YRHM1ICh7o
	aGgrSn1oISy6YccQgKaAqflhS/M5a90GtWUo6EQ0k0o/z7u4glulkNn1
X-Gm-Gg: AYBFou1400460q8SfxYvmhubTi5Ia1gl/3pDoi9qdyPinjrIVKHcOLj3OHWMo0KbhWF
	4Sg0DV8M7rkQpACaUu89TTePGZo4KriPLXaL3ZyWAvv8CmLID5/8McOIKE04ONIyI0hs3WTLV/O
	mm8IXWhhDM7ITcOnU6TQx78I5MMdQ1QxfmiGIMDsIYASPyiodBvVt0ciepewBCgH4yN7yxBfTvG
	fLyrhAs+o9m3MsXVlDLpINSOZTx2f6bz/vFPIY4dBAAM4s11KPyhfX+VrNs+cTtQ4mTtCou3RnQ
	1iC28CztKLLDObjtBxLW/PGteE5suzF4r3h8a7b3UziolmjtsewjHHa3OjW/HSNj0pEWBH6rQzX
	SHMbgRX2O5K710pdVveCHX+1zcuS44oc1XAkVvkIFPtsK/Cfy/vGGnhvwBsxXCdAjC0otPHSaQP
	xMZc/u166rPH+YhB5YcsVU9UQfx84Oslex3A/QUo4xQYgH4mRsJHJ1ftPVjRZpj4YpXsjG1ota4
	iR5W31d6beuGaa4xOb6jid1nMekzNkQnh5fOKFVxVLOF1qHV2sWCwDlxzV7aj+/V8LBKbJr6o9I
	pUGW80nJdqpRxGKjanOEMxBPDFjEnZOcgXIeV3s9ezBdNbMbaxkjM6eAeA7a0moh/qjcSG84GJW
	FI7GQBM5jQTaR
X-Received: by 2002:a05:6820:f001:b0:716:caab:5347 with SMTP id 006d021491bc7-716caab604dmr2386765eaf.75.1793857822678;
        Wed, 04 Nov 2026 21:50:22 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea48fd55sm3919776fac.4.2026.11.04.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:50:20 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: kraxel@redhat.com
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	zeroday zhao <zerodayzhao@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bochs: fix VRAM out-of-bounds blit with oversized fb pitch
Date: Thu,  5 Nov 2026 13:50:00 +0800
Message-ID: <20261105055000.1873029-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

The primary plane's atomic_update() copies the shadow framebuffer
into the ioremapped VRAM with the fb pitch as the row stride.  The
blit offset and length grow with the pitch, but nothing checks them
against the size of the VRAM mapping.

Addfb2 only enforces a minimum pitch, so userspace can pick an
arbitrarily large one.  A single atomic commit then writes
framebuffer content beyond the VRAM mapping, e.g. on mainline
v7.4-rc1 (KASAN build):

    BUG: unable to handle page fault for address: ffffc90002800000
    Oops: Oops: 0002 [#1] SMP KASAN NOPTI
    CPU: 2 UID: 1000 PID: 1258 Comm: poc Not tainted 7.4.0-rc1 #1
    RIP: 0010:memcpy_toio+0x22/0x50
    CR2: ffffc90002800000 CR3: 0000000110f75000 CR4: 00000000003006f0
    Call Trace:
     drm_fb_memcpy+0x37c/0x6b0
     bochs_primary_plane_helper_atomic_update+0x36c/0xa20

Reject framebuffers whose pitch * height exceeds the VRAM size in
the primary plane's atomic_check(), same as the hyperv DRM driver
does.

This issue was discovered by Tencent CodeBuddy Security.

Reported-by: zeroday zhao <zerodayzhao@tencent.com>
Fixes: c3ac343c14485 ("drm/bochs: Use GEM SHMEM helpers for memory management")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8192decddbc1e..527ddd8bcf369 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -422,7 +422,9 @@ static const uint32_t bochs_primary_plane_formats[] = {
 static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 						   struct drm_atomic_commit *state)
 {
+	struct bochs_device *bochs = to_bochs_device(plane->dev);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
 	int ret;
@@ -439,6 +441,15 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	else if (!new_plane_state->visible)
 		return 0;
 
+	/*
+	 * atomic_update() blits the shadow framebuffer into the
+	 * ioremapped VRAM with the fb pitch as the row stride. The
+	 * blit offset and length grow with the pitch, so make sure
+	 * the framebuffer fits into the VRAM mapping.
+	 */
+	if ((u64)fb->pitches[0] * fb->height > bochs->fb_size)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.43.7

