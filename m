Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581775;
	b=WvpRiBnlO1Uhi0KuMQTzZBmGyeVasbAJ1E2k0eK4SIWzhHyxXJxBPY8Geb0JQe5/TO8M
	 bc+1O8sIbuDF6/IHEh0id3OddkJOI+0iVjz0NroREfsZP5KIaHcxCV7W/lExiUsDNpYnT
	 w5A6i2qY6gBJzxHsDVEgwGDejIIP9+2NoJ+VJ2Qz00/5dxTBjXDZUhU0TBt40HgonNyjp
	 Vk7uDkAXP2CmP5yQT/hvJOxdxp4EWpkMbrzr3u9p70Ll0+WtWYW/lWemfrWxFGcXAUQeq
	 whJuaF9Fk/oW+dlTOT/MDep6MxcG9kuKl72pzSBZmdVzvSh/ySEijw+CnWTu9595uKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HTKei3hMm8BrgIn9MBb98/wkj/SGe/y2Ur5xLD1rNKQ=;
	b=0zPzw3lakSwXgMbvQ15KGtHj0ExOVEefWrq2yFbyvmDyA22mP0l3wut8VqCjg3Er4Iyy
	 UEOMzStzAO/GTA+R3iQgAejhTvxVSnzuPJ8WFEWAoWW9l3nTPuUI1dACmw1gArnHmG3KX
	 07OFZp6NCet4za+FlpVYLbw8v0lNNoHwMHuj6dq46Fm6VT9uwdyAe1p0ciGoNhZ0duv5P
	 RArkYqnr5S2PeBzjQTHTghR8mWuuLKg3ftumqEVUN9y7Qe5fY2BWACxkJPm/XrQe2w7yD
	 qqD1PgiGoekhgkvjLKIjNSZia5wezDgXwqZrGwcKM6BSEVrxbnc83GHEYc6cuASU1Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1m7vzUQ;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06F606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC06F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1m7vzUQ
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-7143451981fso1471961eaf.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794581774; x=1795186574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HTKei3hMm8BrgIn9MBb98/wkj/SGe/y2Ur5xLD1rNKQ=;
        b=c1m7vzUQ962ZBdEwr/0zeh0jHX6t+DLgPr5rDyNH7TyCI4WMFpUjc6STRXXFXdk0bf
         IcMsmCrRV9e+6+6yPgA9cuQM28MDbKvOzqvNz9NM8DBA0x5scmFTU/+L4/fIl30GlAKA
         U+p6CBUDtvGn3GE1ISHUaMGj65YHgVKG4sh71Uxpp9O0+EyxDDNdosZqbTNOAwclNNVM
         u6JXNviREgWf4Ija6P0zPhN8og8TTVDA1+C84ZWqus9/8BNCWguCUr0efo7yJdmXfMt/
         4Jz3p0g0jrS/YX7IKFRU8B4WWEfwakl7qd/lSD6491uV3rZL9a4cyvqKJsy25KwMvGft
         7MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794581774; x=1795186574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HTKei3hMm8BrgIn9MBb98/wkj/SGe/y2Ur5xLD1rNKQ=;
        b=bEQp8efg7oxQnnHpnVdVWyXl+mRi4jpHU3fPzV0uJGieS118LtGaAONBH9dUgIP3VO
         Vui589YzXFLzLhHCdgL3m6GTgtn+qiZobAmJCLNCAaT23dfBEyghhi5tAHn8vGiIPlnw
         2fYU+s6F8JJ6EZrF4H75QRvQJEJCGi2sHiMp+D62ABZVCFN6cmITql8zhORA9ll7qYer
         xNbBbCjlZcy94DJw8lvRodDt2wTDd0pfFZLinSjmEGKddg+UK6moxX7raOT9Uj4i3XC1
         9VvAfXpLpdmvDAnBTywoLgXE536rM0Kwt6jy9IHc2Sdt0rwmLJ9by5CVr0Xgv52v0z9S
         Hpvg==
X-Forwarded-Encrypted: i=1; AL+hErEpTAKO8OAJEO5LcAkDrCtA3n82se8oIt32acghRNGJqTwrOAmxYrw2MO+2zr11h58x+6uzNZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B+/Nmsnys4QxOfp5qhUF5UN/xdsjlgXSqVEa82sBQ3g7cCxQx
	8cGVgYBANIIosyMJ9efMsTqiFRqBVwmnbpLNOx5K92Mu1lOnCcIFYv7Y
X-Gm-Gg: AYBFou1rtHPBEimigHfLSfeq0MS984NERce4x+QPAvt674gpll252OWCD8GrPKhY7Oc
	p6i0tnACfN+imaXbk/VgGC79RJrU+5HBy1phIvxLY03cxXY9XUzvrTEMkJVUIsWCLZCWuxr/Dww
	gOnYrIaf3tK3oqGfd/CP+PJQzuSSITBezHpMZTaKfpTwL05cymcvKaPTv1XC8x0CRfNHYkwCBng
	9s4yiuPdAX0BiSbXtpUUSM+70GkmtOPQTXbC+Xy6HcxufmVy8p8xie2iI9i0yJRbvRwYI4gw9Cp
	CcPl8qbBtD8yjjKw5+5oZ//DoHEfgcXtJ8/PRIJXtfjeG/Pw0sp1aSzE2ZhVF0RA6AMhFcSVA20
	fuDzYglRDu3mP5fWL1MtqDISRaqyMBIu0zOjixA5s2gKyVO9HnIogJl35yXf4CU+XpbaZod9esd
	IOIAPNWaN+m89wID5FqZ57a1NsPQ7kmhLpMcVVi4MRQRELSPZH8oJFGI6C3doID9rlpmwBImz6d
	DKMf6EaQuzqK7FCrHOGA8ayoaThCI0l5OyzjbeAewaOU6qzFj1O4CmvOnL69bvDbkTqgjLDul9n
	k2DsM2j1j33i2jWga5lI0ri1K3L9ONUBlXUV22raSUL3oHmdqYpqO2TvBHz7DUhVedx1J/1FAKe
	ZBMuJ45HLQjcgTCFwFsES
X-Received: by 2002:a05:6820:f024:b0:716:d5d7:60f3 with SMTP id 006d021491bc7-71ab4cd9493mr1547569eaf.9.1794581773792;
        Fri, 13 Nov 2026 06:56:13 -0800 (PST)
Received: from cachyos-x8664 ([177.245.232.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86288133265sm2844298a34.14.2026.11.13.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:56:13 -0800 (PST)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+1a7507a194fff09e5c44@syzkaller.appspotmail.com,
	diegomancera.dev@gmail.com
Subject: [PATCH v3] media: em28xx: clear dev->v4l2 when v4l2 init fails
Date: Fri, 13 Nov 2026 08:53:59 -0600
Message-ID: <20261113145359.65440-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <CALruWrWRWRU84AkDocSnNMSRp+WQD5ic9G_3peE50BvQR5iGBg@mail.gmail.com>
References: <CALruWrWRWRU84AkDocSnNMSRp+WQD5ic9G_3peE50BvQR5iGBg@mail.gmail.com>
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

In em28xx_v4l2_init(), if an error occurs after video_register_device()
succeeds, the unregister_dev error path unregisters the video devices and
drops the initial v4l2_dev reference, but leaves dev->v4l2 set.

An em28xx_v4l2_open() call already in progress (such as from v4l_id)
that blocked on dev->lock while em28xx_v4l2_init() held it will then
find dev->v4l2 still non-NULL and succeed on an unregistered node
instead of returning -ENODEV. When the device is later disconnected,
em28xx_v4l2_fini() also sees dev->v4l2 is still set and calls
v4l2_device_put() a second time, dropping the refcount to zero and
freeing v4l2 while v4l_id still holds it, causing a slab-use-after-free
in v4l2_open().

Fix this by clearing dev->v4l2 under dev->lock in the unregister_dev
error path of em28xx_v4l2_init().

Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1a7507a194fff09e5c44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a7507a194fff09e5c44
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
Changes in v3:
- Resend: v2 reached lore with the "diff --git" header line split in
  two, so the Media CI robot could not apply it. No code changes.

Changes in v2:
- Drop the non-standard 'Assisted-by: Gemini' trailer that failed
  checkpatch.

Note: compile-tested drivers/media/usb/em28xx/em28xx-video.o with
allmodconfig (no warnings); not runtime-tested locally against the
syzbot reproducer.

 drivers/media/usb/em28xx/em28xx-video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d486..f78325a41124 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -3129,6 +3129,12 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	/*
+	 * Clear dev->v4l2 to prevent an in-progress em28xx_v4l2_open() from
+	 * succeeding on an unregistered node (returning -ENODEV instead) and
+	 * to prevent em28xx_v4l2_fini() from tearing down the instance again.
+	 */
+	dev->v4l2 = NULL;
 	mutex_unlock(&dev->lock);
 
 	/*
-- 
2.56.1

