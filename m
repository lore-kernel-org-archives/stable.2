Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521969;
	b=jIsht3uYyakKnmY3Ii09RGOJDl7w77YW7zat93zzix1Y5wAT+myT+SW11aufZIDDUceN
	 QN3Plid58SHinh2b0fsnOSNRKLqQI5l/m1hX+HS2g99UmFhxMwXSNWWDG7y8d+7wwstrH
	 ynhzD082fcUPzRPSqhPxPk8EWHGIY6iZ8hBrEsMWbHubVu6MLuE0gVA3kdEmDo4ZR4/Tk
	 /N/3ttQETfdvE9ZDkSXIu8/kELOMglu9MQloO6UEoGXfgepjJOzCEqgDATmDmqlj2pi2A
	 P3V/kjSS6Z1rniTlMNli3TffW5uADRrtEvqexnz94WRKj+bcbS+mWpivohPSPe8hPOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=KOl2yz4M7C/s7a2F3laG5SJ8ROMJ5wzUSTSBiLclugA=;
	b=zVQQPZSAaeAARDmym/HVFP1vt3gGE0ADFk+cH0YvQN++h24VhoUqCC1kj+d0Mr6GVJpp
	 TrvTilI5tufweqbiTdqsrgwzcXo7uyOhEmqR0ZqaAGJrRHyxSJmLuVSfMd7fKRkRdfk3z
	 l8TYxJOESzZybr7NcDlfme/oXs72Lhw5NpSfvpVuzkIEsjeCsuX6hv9WRLlbPms5x7j/4
	 Yl0XydOM+C38p4xrJ7PoNdun1dKHQHOvp0Je7hKN8ucbydoJ7+FCq7f5BRUyqyG1jExms
	 qpdDAr+GKCTkzwgI1InB6J1By0i+SYRB30aSBlL6OuDiiySZOtSu0HVKuM5noy1NNCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="MQ/RXhgV";
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185E606A334
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9185E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MQ/RXhgV
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14470729eso4309430e87.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795521967; x=1796126767; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KOl2yz4M7C/s7a2F3laG5SJ8ROMJ5wzUSTSBiLclugA=;
        b=MQ/RXhgVqU5sAcBNnuTQ5U0+AZ6JbM/oIPEOQ2KoEQwTD+GMBeWAGs5HSHWf5LbnjY
         0dlv/BunRCPGkSSliuOGd524M5yxjRd8aHmBHJJOuW5cL9ddleDulX+v9QfPjxrB12in
         pehtr+vEznWV+PMiZ0Vz5rsflnAJ2nOcmL/ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521967; x=1796126767;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KOl2yz4M7C/s7a2F3laG5SJ8ROMJ5wzUSTSBiLclugA=;
        b=XfOEpgNA5mYeEkmh3ip8np7gv0TipTuleelIWZSLsU7TKEjJB9CRZKDNCJZQRFhUtn
         ru4mlHJyklpa5Qcp4OhK/QQX1QNwMYP2kbFCyk+qwcqJMTmYH8f9PW0pdxdM6/mJgvfJ
         rEEZbUK5g9C/cqVMODLbyfjQIZ1egREMDE8S8ykePLBiNvLZO6qbAZIFf26zchJYaeCQ
         w/+94G1O7ucEdJ8e1SUK7nBlwmCjtOHwmRe/+CmbaW27LOW+6QRNk3A5xxy2QJD0DVd6
         ttEuBHV0aG6RdlLqDIZV6gkayuHONP/+5UXaA5v41iZ0isW2vIix2X0HcIPkI8KiMaQ0
         NnwA==
X-Forwarded-Encrypted: i=1; AL+hErHxfeLKQJsbthfkDF9tMrvDfCVCr31PFF6hPwhSX4S9SxNbTeKzSH5Y3rtoWC7bhRZl32xsK+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XvNx+1OWOVfjrZdAH1fIx4axKYS5g5ovyh2/45vke+/RKmfKg
	BqPGkTOLJ0DVISwUzwvkplY9PuPaANVuPe57NkVMTSnGxzxT6m7UNZloxjhSx7y09g==
X-Gm-Gg: AZFdTZdYRTBo4J/vGhy5uogssPmkCa9j7HK1qJvAJDFZPPhruRRHaIv4B8PaKvpiOIN
	nzhdS3OEsrsoarTZh77zByP+jSA3TejYtTObGX1wcIqVSsZWAycH/3ib4Ag53eM5s22+rRouBeb
	lmySvx3ZCxjqh7AdMIBOSnFnbNk1GzCkJmtCIsyqlb7e1tk5vf5wtnr6/u4OvqebWgcv7OjY9r1
	mQ14hvQCFY2vQ2iagOAQnhy74UhWkvWVxL0R4vxk/Uqs6c9i65NxqRFLTUZOGaNp3g1q8aPvcb2
	mjVHs2DZ8D5mxYJ+dfjcsWrJWJ8gffcSX7vIED89KkOF8SS+3P7++gE2gIWeq5kIPwu1HHGRThh
	JoB510gNocqNhylZ+5mLwXLWg09iCIIdcdqiqyQHySDNfPiXduWI6J5X1xqrzUbl/AZhRbCjiVZ
	Ygdz6F4RRPGxFL4UNpyEHaIVfTuwmz2BexCaxk8y0WDMhH0F01FEIkMQFGzLeFhpvLCB1xoUSfk
	ZMAJxoeWdUJ2e6da8kQ34/yfWBVOM+T1bionGWVq4MobXbIFyz7ugDiYBvhLWR5LU/qm6G1Vd/3
	xaO7AAqdBxCL2dBJE1c3i9WCJrhf1RXCkFl7SutJ4nJ/8u5y0nq7WYQ4R3NBxc8oSHdMV/UeK0V
	OQLsogKIJNw==
X-Received: by 2002:a05:6512:3087:b0:5c1:4a42:fb17 with SMTP id 2adb3069b0e04-5c1bc89ed7amr4414564e87.59.1795521966845;
        Tue, 24 Nov 2026 04:06:06 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd01772esm3654675e87.39.2026.11.24.04.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:06:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/2] media: uvcvideo: Fix race condition on metadata
 buffers
Date: Tue, 24 Nov 2026 12:06:03 +0000
Message-Id: <20261124-uvc-racemeta-v3-0-f82822cbadb3@chromium.org>
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
X-B4-Tracking: v=1; b=H4sIAKt9BWsC/3XMQQ6DIBCF4asY1p0GsNLQVe/RdDHCoCyUBpS0M
 d69aNKNSZfvJf+3sETRU2K3amGRsk8+jGXUp4qZHseOwNuymeSy4VdxgTkbiGhooAnBEUlSum2
 dsawkr0jOv3fu8Sy792kK8bPrWWzvHygLEFArbosnGtR4N30Mg5+Hc4gd26wsf73iSupDL4GD4
 KSFleha5Id+XdcvXrJgeOsAAAA=
X-Change-ID: 20250714-uvc-racemeta-fee2e69bbfcd
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Georg Neis <neis@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series fixes a race condition when calling streamoff only on the
metadata queue while streaming.

The first patch fixes the race condition and the second patch replaces a
busy wait with a waitqueue. It is probably overkilled and this is why it
is a follow-up patch.

Feel free to apply the first patch, both, or squash them into one patch.

Regards!!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Fix race condition in uvc_video_get_current_meta_buffer() by checking
  stream->meta.streaming under stream->meta.irqlock before peeking the
  metadata queue.
- Introduce stream->meta.streaming set in uvc_start_streaming_meta() and
  cleared in uvc_stop_streaming_meta() to prevent URB completions from
  acquiring metadata buffers or starving stop_streaming.
- Add Reported-by: Georg Neis <neis@google.com>, who also reported the
  same bug internally and pointed at the race condition without
  meta.streaming.
- Link to v2: https://lore.kernel.org/r/20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org

Changes in v2:
- Use a new flag in_flight to avoid keeping the spinlock for long
  periods of time
- Link to v1: https://lore.kernel.org/r/20250714-uvc-racemeta-v1-1-360de2e15a9a@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Fix race condition for meta buffer list
      media: uvcvideo: Use wait queue for metadata streamoff

 drivers/media/usb/uvc/uvc_queue.c | 27 ++++++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_video.c | 32 +++++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  4 ++++
 3 files changed, 59 insertions(+), 4 deletions(-)
---
base-commit: b7ac871daee981f1963f632586ff9b9d898ce5dd
change-id: 20250714-uvc-racemeta-fee2e69bbfcd

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

