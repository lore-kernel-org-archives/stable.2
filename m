Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197429;
	b=kVO6kvAiBtxl0VnrBeA933tR04U576ORBKcjizDaZahudbw0oA3wGh8dX8eEgisexvs3
	 EZ06psdtMNkuyGShzZ6Ib/fVgw0lcqa8ZIwiAad8FDT+Oh7jlIxZTbDWZ6fkbLAINVH/X
	 wuxt3Evg9kUk7qnrUfe5gYwvmzyrNZuwI0MSve2HFxkHM9rq7zBw5nfYTDPBeEAnIISEy
	 LhTCmpBKUTi/Ipl0qYfyA41UoVYA07ckzqvNw/LJAtlw3IyqpAPTbOAwq/srO5gk1V0BE
	 QvjH8n1Um7DBbzWAi2uLrouMMvBcDiFn8x1kLOWJdp4MmEG0a+AX2bS6xLITrqYjd0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=72nI0VUnworKyC9ySo63hS603nPN0FBwzBwYMgTAKTw=;
	b=E5gQ0nkRjOEQsDf1GMFjO8udqKq7xcU204HMc9+hKBTJDUyO1tpGCc6IirOUy3b0wiet
	 GLLdJL3vNnFoTRMqnGvIx1VbNwZ35kcVwY8P4z1oBmygQfarfymbqojnkqlY3wS6QKshw
	 WIETSAfogngofizqG7JDPRqc5wzQikSLobhlZfICHGA+1EtThoG5c3O/2hJqpIVisZtiw
	 2B8zYaN4NhE/0l4KWNUOxWUnP2bNhJB8he8lwluYlGyq5zF/KdSn4i0Th14oS0Y8pZSyp
	 bVFbJIT2b2BOv4Ql8SlY2N0tFdOnU+sgV+GYBR9Q8KWUCQyiiMea40MfMWbD93w45dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4kYrUet;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA24606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA24606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4kYrUet
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9ae391a05so7371705ad.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197429; x=1793802229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=72nI0VUnworKyC9ySo63hS603nPN0FBwzBwYMgTAKTw=;
        b=e4kYrUetrjcEDDR0lWWg6jQYYYTRRReJDHjeRw01rBebuY3A4xmk/eMjhcqxiANfGg
         gr6tertjrTZLpJiUsQ9y/dIeOtMNk3YCXOQj+eSi0wrGBgJ0Mhr0SbX6gL7a8/4Nanno
         KmEBWupsixusUoZRps1ELLBKHTheeaVo+hbjt4G5eBAxt10pMDMd/9wFL99bQeqXHQCz
         nVDvPExBnLqjF5/DHcS1KXZwfyA0TwA8RdMtyjOnHaPRrh4UVeyAu0OWQxt6vW5FpmBG
         9C6JlC+yIx5i7u8r4ezh+oSEJ/MhTX4ue3EGfTWMOQOmasCp+Q1MvgUmVM/yEwDrZAFO
         b6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197429; x=1793802229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72nI0VUnworKyC9ySo63hS603nPN0FBwzBwYMgTAKTw=;
        b=N01BVEugG6jgXHgU7ufkoHQoI4f0vu6jF59cEo1493n2EA9HGWXInPL5dO3d4MkdoN
         oxpQ34p1LfxhoCKrgbl+70tQysDtRpcSVeWjUdHUOdsDXcDGR8ohw/pHK6G9TQqzAu7f
         86f0Dgu6yFOoxwS3mQwRvdijp3FOXoi6+8/8Lx7FDbujYjPDGCc3crJBmKf1/jcS7aZN
         rZv5N+bLlLfsOTBvrS/s0hr7tmAXmrHaNlfHtsYweBIZYk1GrTVkAAWAB3S97fD7fW0L
         8YMGXekydRrQjhDhYIrv/gL+86I/r/v6CAPfgJDJMW0fTOv7YIZCu2ZHrUl/zTg5+v2S
         3O7g==
X-Forwarded-Encrypted: i=1; AKwUvBzhw2S42lCxaO6+KfU//6Rvi+27vts0Vvob8rI7z+YkCujkCD5YDvmKb5nURG6Hm6rkOUC0Stw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiPobYn63epKoTcsfeWng6PhBB2xTNtF407UY4pJWrRb6dnIx5
	oWboPPexl8d7QgL/BL+pxDUsOk/CEALfAqafFLS0g1q63zZaMqd9WVcrm4y52HVyR9E=
X-Gm-Gg: AYBFou2qL57iIIkuIBAseCMlw6MUUZN0l7jWszOKoCjCX5mQd/8ob+KypZ9IGnRhDwV
	15TA+9mj5pueVmwJ/8FeNKqHOL8V2OYMBskDS99CyqGOaevPOZcO12MCemO51OFEKEwthEAZ4l+
	9WmGn4IMg9++juDJkx/2N0a5AL9vac47MHDXBZkrw5pL1Sb4u23BTq2Wpg/omZyOE0BHIC+memj
	DNqd2N9Syj5fYEJjfTy5gcX7WRvftly0/FX4gTvHgY8Uv7pGm9Z65ppemtBDBHoxZM7sW4kWAGg
	tlMFZ+GHzyHENiSgG+baCd7DxQFWxtsjuwyBosvGl0OqGbB8BPY8GzH+Y819DdY7l5hoRb36TAy
	3wtrutX0JtmcXFS3QePtzXynNra1VCvONJxfdPyxrwUKx8YTZBqr0cu49ZJo51pUzW2N3Enhv9j
	uqMU4RH5XYthJd57Dm9BhUKHNWGMQxGUbIa1mAJO+dGXnQVcKxALNQtci9MwC2ZqowkCCWbhjyZ
	Yq7NFLUN6teSrwAMqq7yjRoUjaISyGcS2bzVAmZKStNUVb4svvJSc/hHUuFZO0iW88FSH+5VeXU
	9GV1RlzTEbDxokBw+0Ez9FRn0yOLWZKmmef605yH1QnyAjQQyJlQ10MCUNNsizujzDMB
X-Received: by 2002:a17:903:946:b0:2e9:4f49:111c with SMTP id d9443c01a7336-2eae3fb7b62mr36528165ad.27.1793197428606;
        Wed, 28 Oct 2026 07:23:48 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b79ff3sm23590505ad.17.2026.10.28.07.23.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:23:48 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Wey-Yi Guy <wey-yi.w.guy@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: iwlegacy: unregister the LED if 3945 hardware registration fails
Date: Wed, 28 Oct 2026 22:23:28 +0800
Message-ID: <20261028142328.18560-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

If ieee80211_register_hw() fails during 3945 setup, later LED callbacks
can access hardware and driver state that probe has already freed.

il3945_setup_mac() registers the LED before the mac80211 hardware, but
its registration error path does not call il_leds_exit(). The analogous
4965 failure releases the driver and reaches its existing remove cleanup.

Unregister the 3945 LED before unwinding a failed hardware registration.

LLM assistance was used to find the bug and review.

Fixes: 5ed540aecc2a ("iwlwifi: use mac80211 throughput trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. Not
reproduced; 3945 hardware was unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index f7ca182d1494..5e11f0597255 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3529,6 +3529,7 @@ il3945_setup_mac(struct il_priv *il)
 	ret = ieee80211_register_hw(il->hw);
 	if (ret) {
 		IL_ERR("Failed to register hw (error %d)\n", ret);
+		il_leds_exit(il);
 		return ret;
 	}
 	il->mac80211_registered = 1;

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

