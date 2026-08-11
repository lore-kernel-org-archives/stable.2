Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49744607E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458842; cv=none; b=SUkzfntxO5eDSvOW6sr17K7hFRPyyF4EY9jBsJj9PgSFSGOqPDZ2RsgvGS6r5rg0tP1EgWJHpl/MXXnrl7QXui9DEJVMKojaQkvLUmoAOGZEYMQhzdxByn6oT2BGALz0RGOhEUBD4Yvl6tLYStgLEPK981qZhbIZh4nFq2Nq9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458842; c=relaxed/simple;
	bh=DMTuLvZah1C5Q36bwdgckoJtwFu6+C3V0xMq8kfeoAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Acy5q9Lu1sShFru/++pY2c4WHjT+0BXdyNxswlYqJKGfDTKX8RRm/K+eOevp37utcU7KxO5X96ckpOhUpb5ujJHS5jO5t3LZGrQkV/oYeTfa/zwstVER21TNdgyGS8E0rFE2sOD6NYs/kuo9Av4Zu9kvezwB5c+sxfXinjTXdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy+YHAeI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy+YHAeI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso13587755e9.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458838; x=1787063638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GQsznlQLpcSCbR7efR2aiMZyhiXOvWtEGgtbWbncU4=;
        b=Oy+YHAeIER5dV1TVNNHP9hnrwqmcT+WnJaoGU4xPHm79cMfuaTiO9ag1bZvJ7KfRnX
         KLCEqUBPxg5/65GLwXO0GRHivPeI4PxFouZksSV6FaH0SJv/0M476kjodI6x5KcLhh4J
         e9Td30vnjhYzy+9iD/zAjFEI9xn+Z2XW5DtFnRvHtHl78ArYqhhmtiY9Rm8LFofeb3J5
         Uu66sC/I15jdlFNdMIr8bqd6+WWKz3zNpaZMbz3xCjVsbzUsF6/wfYkJB8h6YPF46+3n
         uAGS2MtKjporTufKtm1RENRZSn7C6aC/2eaYCstAw1YAVbnBe//isEQViYnSTMZy6GlK
         n3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458838; x=1787063638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0GQsznlQLpcSCbR7efR2aiMZyhiXOvWtEGgtbWbncU4=;
        b=Y52PUeU9FVHgUDpt926hKbiTEUiNR9hHqboVwPdH8lW1qH8Zp9E7KhNPUFMWLQ+BsF
         aW+0n5ltkCO6QPh2xHtfofLZm09IXpBVBw8yJz4LM0IJUqZ7dLMOtei/TfTht/VZGQei
         NFC1tkncqnF5XDPTRz1wEbyhxbNVqHKtHGYbgAcJpufqsRVKwurjllFyHfNCx9r8ysKB
         lmVjEyMF2U/eDt17QgPJXBeq5jgHvoYkX5Lg+CCygfetuXZvfhgnm5qcqaewngL9yQ0Z
         eC8kKv5c81uUGo+2TbEHjGcyrAVIyfm2+uFOrllWBc8uI3gmRnQ0N9oDi6RcyCzqklW5
         HxlQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOTzh3/wafpryRFHhzERvgAH/ogixBAzFRplKNqJwfDHLGW//3sy5R0hVcBJGG6DJG9Pl2iDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PfG4vjqw7GligOuB+rUeigChlPh8bG/IlXMbUvpJDclgtf+N
	ufMuq0FMHwkYoUKgL3oJ6EDPyCkR9veTio6EqbRfmQNDwmWmYQby2LoE
X-Gm-Gg: AR+sD11QU/JDR3dToyyj15hefyvOpnBirofh63JQQ4ZwuAP+8tBJpDxPgijyAGCHUVg
	pHh5pzaq35WK47YFn5odP2pyMs0T7UTgWHPHNfuPg449KxYfxNjI1zAqR4xv+5ua+YdWZYErZll
	+adQL+ZuFlPbw+/C04o8T62/Ja5dSVhLVOPyDyiiVgwQeroYH02V7aBrNfklgpOfCnLzuaJWEtO
	R3CHrmkcHCHaj/rIFkSosiJC4iaF8CSvb3YloyyVAmuQRV50Zg5PYVlNqC2qBN86bJJ4DTUct6M
	2rQCjYHDxgt6BRR8GNbyV3MxomqzywDcYyFMSlV06h4vo16w53+DLscYgLuoQ3CLMJqlLrZUhup
	xYgG+6LnIXzfRWuCOq2iU28cmE3RzT2kKFqP+qovgft/i/1iYRn2AZ+tVATnKFbDE/8yfik2Kle
	BCmxD0QTKcgEjAramB0PGBx0DS0brpZMjYsAE4t8NVQyyvvUxBK4wvLzlC+Lc5Gr7J9wZXMpjDM
	dR4K8QI6ldVbBEqxuVv8nLSo0QCBXuFcJg=
X-Received: by 2002:a05:600c:8219:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-4997842db6cmr65909085e9.4.1786458837766;
        Tue, 11 Aug 2026 07:33:57 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977ea5440sm24136825e9.3.2026.08.11.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:33:56 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: ignore CS IRQs for uninitialized slots
Date: Tue, 11 Aug 2026 16:33:18 +0200
Message-ID: <20260811143318.46446-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CS interrupts are reported through firmware-provided bits in the CSG
interface. sched_process_csg_irq_locked() iterates over those bits and
passes each CS ID to cs_slot_process_irq_locked().

panthor_fw_get_cs_iface() only bounds the CS ID against MAX_CS_PER_CSG,
while the firmware can expose fewer CS slots. If an IRQ bit is reported
for a slot beyond sched->cs_slot_count, the driver can fetch a
zero-initialized interface entry and dereference cs_iface->input.

Ignore IRQs for slots that were not exposed by the firmware. The CSG IRQ
acknowledgment is already updated from cs_irq_req before processing the
individual CS IRQs, so ignored bits are still acknowledged.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 64749750e6ee..1e230936e99c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1705,6 +1705,9 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
+	if (cs_id >= ptdev->scheduler->cs_slot_count)
+		return false;
+
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	req = cs_iface->input->req;
 	ack = cs_iface->output->ack;
-- 
2.43.0

