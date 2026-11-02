Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614738;
	b=TPdlqUqAYAWacesVWrpyaJshg2FpqbQgyqRSKQtSRbMwm1QcQWGFyuwqTZMDi8eRDdLM
	 GuureRmGkHf7Rty3QDlDAEOIPZho92qQdkWmtgWGwtSfPVQioawEQV/wokGBYlum4zBIG
	 6nGXLzrSKmqyrpvQwsnDSC1zG5z7FdJbFVvFeYGP3LGVrcxjr5djvOUFNGxp5dfp+u7cj
	 DLvH0pil2jgmkL2apLHGW9WWVlqOANA5sBzvOdbSNJz8zOZqjt/OwT8TGEBLz5NglmeQL
	 wWvmycimS0h1XDaDmOjRsSq5Eld0IwfX0q8hA6m531aLTN7pO2IjaXWMFsBx30Wmm0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=8OBOniiOD3/1mcF69iMSsD8cgqxrlh2JCSuj6D5fJsM=;
	b=lWkpzjq1QtGjMctVcoGEgXt2QtL5IBjQA20Dq2Nr/sAtnzItqW6mddK0c2Ymy+2fXafB
	 24QE76FJTyOYc9VchNTsgz7nr6SQhmVphwtNdvKBpTN3mqkIgbK0ArBkAm25BLiAIPd0v
	 1m/fqsnsb1W0kA06vjSiiOx+URaPBFUP5BT7sDWoUF0q7fSTepU8MkOSIG4vFs4zmPaD1
	 JCSYIz1DCyd/Lvmi8W/uIeB+OEJ2XP7fE//+1aYdXRUmSfH6XfboUt6xl+dfhpjM4EdJX
	 kUY0wATjBA4qXsuINvbpAo/drfE6F1CMOJowrFX7H4xJ4r68W8AE0FGozS3nXy9O3Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxRdv5SA;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792060A261D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5792060A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxRdv5SA
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so25998665e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614736; x=1794219536; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8OBOniiOD3/1mcF69iMSsD8cgqxrlh2JCSuj6D5fJsM=;
        b=XxRdv5SAPtprMCixlSykpa9IdCsjIms0i58gM4n9WkmvL8mJ5T7nTQXKs1RGSXZyiN
         yxa/3V7py96cIQ42Lm0vOJBL2LtKqssWb1eSYc9jZmdHxsBDxBc37uYMA/D7P0ZRYn6Z
         lXQI3lnIz2AFJSE4tYTHitTh2GQYrXXhlQRCPTaBsYfV/Tx8DEcDVgyYB5ep45hw24KU
         XpY+P/OTW1FJxkURBHhTBEBWxC9bpjeW6V/X053l5mcsQ5hi/5wMZQDl9kVnGw4FEtSl
         /ZM9mLhndLMyxOkTYUYXS5yQRpj4sKAT8i3hSej5+PF5oW31Kyo6c0SuJg5/g4i/Q3m3
         ODzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614736; x=1794219536;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8OBOniiOD3/1mcF69iMSsD8cgqxrlh2JCSuj6D5fJsM=;
        b=Y2Gr0xeUjWv1bQVx3eIlbTvZ+TSuU0sVz39+KXAmbivUWdZpfnWDOFyXdSHe5q21x0
         ERilgFXtaBhOvYIQ8mCxniTOZ2niTEYiyJsdOo+jXk9utCEhr5ZEcazFUYJkhvLdgOYm
         1fE2Nul41nidq+sGwZo+1Atjz2acVvLHNwdosTmnrp6S6B1cRUzZw2/1814GsNaR1IET
         S55oXzdoUX7Rpz/9rRME2eE4gzyGBsVRhm2SNYIpBxjL0/tfUShWDjFf/0SoyDGSpyAH
         uq8OYaT29Swf9YjTkPBhTCDXl8b8C0mFWAUuDPPVPvPqWm8ezfB04U59de+wezSjmVdg
         BR6w==
X-Forwarded-Encrypted: i=1; AKwUvBy080kNQyEo9C8N3fecsKB7BwRTwcU5qMBCbi4J7EMgOs9xN8usfk/O+1I7+iTw9uedlmOFf4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPUKVx7uDfJhdfWhhE170bXycyEUMaVICyKw2nJ7NmxB4EVfu2
	GvSP2qUozz0E70WcrxzlQDdX57DetbQIXAufakPtAYjNgTCH7/+24IkV
X-Gm-Gg: AYBFou02bwe2Q1Nvhrhk1FSfNXspWRkUKjpAjJUyB8pa8N4ZGq9CDgt0nmQzB1dpWGN
	Eq3reMSBAz+aDYgonKkdSgbVZcWlOv7ABJPs9kH8XoOWKLQMWrLXpqmOF5EeGSmyFo7x0h8/Yjn
	WaWitCf2RdtSLF48aYkxD0LRO4zzxotdsCqpq7jrVkLxjYwxJwnFz42y2wlYLU2h+zfsLnRsjzK
	H3R3N7/qK9T11PYdMGSuY3dfs5Wr65YokI0j1XGJX3UYrqGx3nSLjjCQ14aHKqFuVQJs5RJvqPZ
	0v9gq41TXx0Pm6DBo2Kh9JR24+HbhgDybkMEJrR73MzWLDg6CKt0lOIvr+okBmU7yEscQ57L1RN
	AcpeuLRDyN8g+ksSFvrpyOXLxh1Xl5eN0gz4Vyt/mcXjEGu0f4ZBmE8mdREXunJjG4VtI+HggdZ
	/JDpjKA1AxWFVy8yHhU1mMngk6IWvo2vUiNRoBcGP8o3AVGgkZq02mmzDX2AoiGvT9lEEXzA9MT
	3l93cDAt8Oly6WtYZR0H1TAdXQKvA7FLJiYhBRoi4HIqWflXDBAJauV6pKxDhw+FXrO6J3nGDqm
	hG6+qIB2zxRDLYrTefNWXt9ZRu5sl2EgJk+85O7pdG1XWSkJioeXh/YYOn2fnBEhSivL/WR8mKR
	xLHtvELpCF8Tqlgswm9imZWPNkk40wECohJKELesvNjiuzhSBaJOhnefvBKRq+WU8h/wOeG4K
X-Received: by 2002:a05:600c:350b:b0:4a3:2f35:38aa with SMTP id 5b1f17b1804b1-4ac1932bac0mr190329705e9.29.1793614735583;
        Mon, 02 Nov 2026 02:18:55 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f322c46sm321930265e9.2.2026.11.02.02.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:18:54 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 11:18:53 +0100
Subject: [PATCH] drm/etnaviv: Flush the tile status cache through both the
 PE and BLT
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
Message-Id: <20261102-etna-pe-ts-flush-v1-1-e4454ed86f85@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0auUrA30A6JeRVxUTTUgVZoqgnh3i
 8u3mHlAKDEJdOqBRBcL77HAVAqm1ceFkOdisNrWxmiLlKPHgzALhu2UFUPw2rjajW0zQcmORIH
 vf9kP7/sBFDvhz2IAAAA=
X-Change-ID: 20261102-etna-pe-ts-flush-ffa01363b98c
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

From: Christian Gmeiner <cgmeiner@igalia.com>

Since commit f232d9ec029c ("drm/etnaviv: fix TS cache flushing on GPUs
with BLT engine"), jobs on GPUs with a BLT engine use a BLT command to
flush the tile status cache instead of TS_FLUSH_CACHE, which is broken
on most of these GPUs.

GC7000 r6008/r6009 and GC8200 r6401 are the other way around:
TS_FLUSH_CACHE works, but the BLT command does not flush the cache.
The vendor driver handles these GPUs using TS_FLUSH_CACHE, but the
etnaviv kernel driver has no way to identify them.

As a result, dirty tile status cache lines survive the end of a job.
They are written back by the next cache flush, using the page table of
the job issuing it. If that job belongs to another process, the write
goes to the wrong address space.

On GC7000 r6009 this causes MMU faults and GPU recoveries blamed on an
innocent process. I see around 1100 per run of a multisample
depth/stencil test running alongside two other GPU clients.

Emit both flushes at the end of every job on GPUs with a BLT engine.
Whichever does not work on a given GPU is a no-op. Since dirty lines
are only written back once, this costs one additional state load per
job.

Fixes: f232d9ec029c ("drm/etnaviv: fix TS cache flushing on GPUs with BLT engine")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c | 40 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
index 03b2576af67f..99c91a9eecf1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
@@ -168,6 +168,17 @@ u16 etnaviv_buffer_config_pta(struct etnaviv_gpu *gpu, unsigned short id)
 	return buffer->user_size / 8;
 }
 
+static void etnaviv_cmd_flush_ts(struct etnaviv_cmdbuf *buffer, bool has_blt)
+{
+	CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE, VIVS_TS_FLUSH_CACHE_FLUSH);
+
+	if (has_blt) {
+		CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
+		CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
+		CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
+	}
+}
+
 void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_cmdbuf *buffer = &gpu->buffer;
@@ -191,7 +202,7 @@ void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
 		unsigned int dwords = 7;
 
 		if (has_blt)
-			dwords += 10;
+			dwords += 11;
 
 		link_target = etnaviv_buffer_reserve(gpu, buffer, dwords);
 
@@ -204,16 +215,8 @@ void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
 			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
 		}
 		CMD_LOAD_STATE(buffer, VIVS_GL_FLUSH_CACHE, flush);
-		if (gpu->exec_state == ETNA_PIPE_3D) {
-			if (has_blt) {
-				CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
-				CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
-				CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
-			} else {
-				CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE,
-					       VIVS_TS_FLUSH_CACHE_FLUSH);
-			}
-		}
+		if (gpu->exec_state == ETNA_PIPE_3D)
+			etnaviv_cmd_flush_ts(buffer, has_blt);
 		CMD_SEM(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
 		CMD_STALL(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
 		if (has_blt) {
@@ -400,12 +403,12 @@ void etnaviv_buffer_queue(struct etnaviv_gpu *gpu, u32 exec_state,
 	return_dwords = 7;
 
 	/*
-	 * When the BLT engine is present we need 6 more dwords in the return
+	 * When the BLT engine is present we need 7 more dwords in the return
 	 * target: 3 enable/flush/disable + 4 enable/semaphore stall/disable,
-	 * but we don't need the normal TS flush state.
+	 * on top of the normal TS flush state.
 	 */
 	if (has_blt)
-		return_dwords += 6;
+		return_dwords += 7;
 
 	return_target = etnaviv_buffer_reserve(gpu, buffer, return_dwords);
 	CMD_LINK(cmdbuf, return_dwords, return_target);
@@ -422,14 +425,7 @@ void etnaviv_buffer_queue(struct etnaviv_gpu *gpu, u32 exec_state,
 				       VIVS_GL_FLUSH_CACHE_DEPTH |
 				       VIVS_GL_FLUSH_CACHE_COLOR |
 				       VIVS_GL_FLUSH_CACHE_SHADER_L1);
-		if (has_blt) {
-			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
-			CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
-			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
-		} else {
-			CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE,
-					       VIVS_TS_FLUSH_CACHE_FLUSH);
-		}
+		etnaviv_cmd_flush_ts(buffer, has_blt);
 	}
 	CMD_SEM(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
 	CMD_STALL(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etna-pe-ts-flush-ffa01363b98c

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

