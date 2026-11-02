Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628920;
	b=PP3Z9P9VBGjHq0IXD1HpJZuk3qCj0SotuKLCd4D5DWptfp0+9pw33LPuwJAPN3GhennQ
	 wE/8O4Es2+IkJ/F+8feuWPkNSv3DiFysLf5Cot+9C7jh32L/W5u2mvM0Y5jBLg6t78qrO
	 W+Vh/Rn3SoCkZz9/ufAQfjfNnwuzHHXVuE4LmRieaC5Yz1ObJN/Qh0dMaNYjk+2TuqCsx
	 nUBZv7seZ/+3opTA+K0Llk8KtjkILfYm+N7HuOquJoBBNvFzV7QHdjA4dArVUzYwzPwBn
	 GHdJ0ZQD4k2zyEqEe1rsFureLWmAdbhFHUtkXF6YPIl3u4YVX3Hp3IK1VzIvtBeyG2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dJnJAQ1J2840u9KECjcYuFBU8CaqLFZXy5w57Y9rz80=;
	b=jls8oDUy1Eh4r1YCA7NmtW4qZhizmNmVm5vC4hXLTUf4l0ltNlNkifR3wj08nP5Lxdlb
	 YWCgzN25UNpSZKjchisfulvSXiMq8GOq8iArxSyIHCSVwU49c+oXWVCYAKHDg7R3dzrJG
	 xouF3tqHshP0WZojB3oadnPbWDBAS44MNXUYmRHRhp7H8sqbYKhMWmsi6oL5rxx7wDqBQ
	 9xvI0/sEB/2nrAc+e1fEvtiD1Dm5pZMV2lYApaGaZJ32cwt3jSjqpO8ifldEORLnvzYPe
	 rbo+Hn+KhcuOWK6amylmE+VXeRb8dBRmIOs81PMQty/KCqJxHsefxGC0SDtYY1ITYng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GeW8WrUu;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB260A2628
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9EB260A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GeW8WrUu
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3937808eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628919; x=1794233719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJnJAQ1J2840u9KECjcYuFBU8CaqLFZXy5w57Y9rz80=;
        b=GeW8WrUujR59h00XP6jNTP+Wt0lM56WwyHsMC3BFEQTbNiclg6QXY+aB1ec6M/knRP
         UryPPYSl+I+hMAJBIlYiRfueEX9cMTn/3FZsM3TaZOVLiGlurR92qNXQ3iBQqjG8aHmd
         FEGWr2LW7n/vy/5TStf3UVecyBw/rpPLAIXmmwF42qQgRPozqOBPwA5C5s8adMHoHq8A
         v1p75IzDXdUn5W46wZmNe81GOCu6BRdFoUXb1llsAaP2ElDqunp31BhTaoDG/65Y20ww
         PPus7XtRfJda9yGBNpyRJroFWM7A7+afqgiBlXaqxzFCwTgDEFq8ZG0z87b2Tl+Qfef7
         ZpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628919; x=1794233719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dJnJAQ1J2840u9KECjcYuFBU8CaqLFZXy5w57Y9rz80=;
        b=zvX8O/JhzWQwGTO8xvDxeaHoB4K7Bm7c8BHbe8eXQDYiPtrzqXSe8ASsVVdjpqrYDN
         qK+M+OO5bpcXOB2jx/rDTobIz4A0+QsvgzmWkZK484XiVGhxikhZME8wK6oQjHKcynkm
         uisEMzqpQBbMd/mWctEFuUo2t7C4mmHupId+7kLgN9/7LafqZ45wgggPlJrR1AnJrUG0
         fIm84k+lHZ6G16A3zp1by/2xK+rcT7NfWfbrvnt8B5rANg17h8kXq2vh+Z4UNdtVXajy
         7RMmameW/9hE/AmdDXebhUV+59YSkG64Uxi3wkYnM3LkLRCmPREh+hMjkImr5pmfCdz6
         776g==
X-Forwarded-Encrypted: i=1; AKwUvByIsmAJyhvPnyPe4uHMA6iDPTxGGmEREBpiwLlvAnoJNZHwBxiBfy0YsIz/ybbxw0QxngtIuM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHDo+GEIj2ikgMNmY8rHTKiP+NVH42FYmGRmy521pqybUKv9YE
	aLSkH/0122FMDNthpduAeiPzTZ4mpdLvHIcTxptEeGTf6z+dkVsFdVbj56kYsA==
X-Gm-Gg: AYBFou1l034CrggEG95MWsfq24d5tjppDpCfa42b6WmUXJUfqwMkvpwkvBnBEUYmJBa
	M0RDXTx5b+UCHuZaUWmxNg2Olh98eP1JQO+8gzoPRWbsHA6LyWbL1H82Y99fZYMgDYwb25L7H5H
	zvgLxYDl8XY+6OtMLMB9Wkp1GctiaaCQKK2wUHqdyqQhSHiFGH0m6Cv9mmmqV5rPeiYBrgovq5p
	FismIyQ0mmOLhtRcHhe9LsllxMArirxm7dc3wfNDkcvbAwZ/JZnCAgmx2bk4hlvacC5SolEriRy
	ZXBlr1DXqgrwjjFaNgaq7Bs5/B8PcCbUmBjcoIXLczGJpO08wcyeeF1/SsOC/fxpWiTXmQDW0+A
	Ooqohw3XrpfDl2YmoKme7ZP6xGXSGKdk0k8FmROaOIY17dLsPD2i53I8tKC5UyChmKXK2jczn5j
	IMkUR8qvhh2ohd5/pkkdwD0KsjXDQlNQdgkqCnhQCn/5+ddSnAIECERI56LxFPIEN/X6IcL705u
	lh5iqyVVpoE3fgRGEpuuGul3u+eGp+0K3c4Lb4/IgFVgwu8pGXmRO8HCAqKh7uBBaoRqFWhpW5N
	/yzN7GSZ6gRkuZ2dB81zxUJo5H57o2gFGaPtBvCtlQYYD0ahqhtVWsVwIXM+ZVLYNlOaHgWe6Zs
	o/s1xfpEeNgSe6AVc9/0kaK1fL7bjh5fSDY8uJ92SzeUAm0Vjgq3mhg9on3CRsBu24dYRtAH0TN
	pl
X-Received: by 2002:a05:7301:1a01:b0:369:f85c:787c with SMTP id 5a478bee46e88-36a4236a1d9mr16692157eec.10.1793628918760;
        Mon, 02 Nov 2026 06:15:18 -0800 (PST)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:9626:1a7c:c4cf:3e3b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm33556442eec.10.2026.11.02.06.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:15:18 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	hverkuil@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] media: mc: fix race in media_device_unregister_entity()
Date: Mon,  2 Nov 2026 19:44:39 +0530
Message-ID: <20261102141439.13505-3-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102141439.13505-1-kartikey406@gmail.com>
References: <20261102141439.13505-1-kartikey406@gmail.com>
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

media_device_unregister_entity() checks entity->graph_obj.mdev for NULL
before taking mdev->graph_mutex, but does not check again afterwards.
If media_device_unregister() runs concurrently (for example on USB
disconnect), it unregisters every entity and clears graph_obj.mdev while
this function waits for the mutex. The waiter then calls
__media_device_unregister_entity() with a NULL mdev and faults in
ida_free(&mdev->entity_internal_idx, ...):

  Oops: general protection fault, KASAN: null-ptr-deref in range
  [0x00000000000000c8-0x00000000000000cf]
   ida_free
   __media_device_unregister_entity
   media_device_unregister_entity
   v4l2_device_release
   v4l2_open

Re-check graph_obj.mdev under the lock and skip the unregister if the
entity is already gone.

Found while testing the fix for the syzbot report at
https://syzkaller.appspot.com/bug?extid=54648a6c1187a7ef46a6

Fixes: e2c91d4d78ee ("[media] media-device: get rid of the spinlock")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/media/mc/mc-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index f8ea7cfe10b2..039ef7d04ac7 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -674,7 +674,8 @@ void media_device_unregister_entity(struct media_entity *entity)
 		return;
 
 	mutex_lock(&mdev->graph_mutex);
-	__media_device_unregister_entity(entity);
+	if (entity->graph_obj.mdev)
+		__media_device_unregister_entity(entity);
 	mutex_unlock(&mdev->graph_mutex);
 }
 EXPORT_SYMBOL_GPL(media_device_unregister_entity);
-- 
2.43.0

