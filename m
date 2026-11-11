Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368878;
	b=F5YLk1u+izic9dt9bOW2pD7z9UYgmOGrMJjN54dQvdoCyFsBUEn9ibZBxcIRYl0sHerA
	 H4MaePujlBuSWs6Getr65LsnZ/rKtnJIT3YKIkBnwrq5A0YB/RD/G30XalMv8rRKzmxyS
	 ytsPMTE23MIZTdFQcwpbErk3VEPxivl7b62CcmgwE91spwEiTJ+8cELFkyfRQ8Pe1XIrE
	 OJQsWwv1GJub1loaZx/wuLWNQpQ6Knsaa7eGQTgxevT+qXE5YAYgIZVXe9f05stm3E9NU
	 BR/y1zzc7vqPvTzhGOBI1KcY3+hBssEYZ5VVJ4JgDWr8kuCcQVkcRVx0xGpPbdzCdeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DlQk013GnyiBSXohZUrQBzIRpwpL0S5SgKfqt3AWNvg=;
	b=qc/7vUi3x0uTCXghpUA65aqJuUuTZUf716+cLNi/m0NlDLBzfCF8AqirXU9TgBd/9Mgt
	 U8LcyH1wPfi7m8saRu9o6fIxJP+UhMQRMvxYu3SBgZD7Vw8S/Jn0AhPzh6pnEBFtJDME1
	 0Yf4nNnIMBiqFd1d/YTj+oGqb1Dyv+Ez+S/xb7xV07TJKHRchP9R+atBjIl4/4GABtP4g
	 2/o2uqtsGgElSmvdLWwCxGLkL68XVcYINKpwFI62qjzPmD3n77w+Xb3dfxQkOWzdx7Djb
	 DfXL4N0M1CPfjag/5VZAD/sX06A4OKj2Fg0UrCDbSRIPHJCCzvkgBLpqZ6WYBW0vVNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="krW48cC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F95606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krW48cC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EEA1F00A00;
	Wed, 11 Nov 2026 03:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368877;
	bh=DlQk013GnyiBSXohZUrQBzIRpwpL0S5SgKfqt3AWNvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=krW48cC/p6ytuz5uS5UymlQDbAYvLtQRl6pywdGSOPXRQ5jyWH16nVhEkuOBG54JM
	 fio0pFncEKADB01WtE5uYPg1ADQGC9GUFuel51AK9gsVWFG9DsHfm6xLsB/YtXTout
	 Muy01ko2FlYpPNYDZWVs5CMqLXnveS+dsZ9yoV4yyqmqxisIwErKDs/Lt9uKwWokTM
	 Euwj1ZRwEMeTocqjWlw4PISBBKATVQHCBYDZVfNjPONH8IQefWt8jsujxTI8wSABo0
	 /Wh1LJyrn+s9hZ/TTZS6+TT12/RV7S9gRLWPOjgLyaQeq1pkZqdcVMn5n4ce39WaL9
	 Yu82aQfFsMWMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] platform/x86: simatic-ipc: fix platform device leak on registration failure
Date: Tue, 10 Nov 2026 22:47:53 -0500
Message-ID: <20261111034412.921658-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034412.921658-1-sashal@kernel.org>
References: <20261107054744-failed-6.1-9523698252fd@kernel.org>
 <20261111034412.921658-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 9523698252fd583d6987582b9c34ec6500d10986 ]

register_platform_devices() registers the battery, LED, and watchdog
platform devices in sequence. If LED registration fails, the battery
device remains registered. If watchdog registration fails, the LED and
battery devices remain registered.

These failure paths leave successful platform_device_register_data()
calls without the matching platform_device_unregister() calls.

Add an unwind ladder to unregister previously registered platform
devices in reverse order before returning the registration error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: dd123e62bded ("platform/x86: simatic-ipc: add main driver for Siemens devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260924115617.1578309-1-lgs201920130244@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ sashal: omitted battery-device cleanup because the driver lacks battery-monitoring support ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/simatic-ipc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index c773995b230d4..32c2a733ec49c 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -55,6 +55,7 @@ static int register_platform_devices(u32 station_id)
 	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
 	char *pdevname = KBUILD_MODNAME "_leds";
+	int ret;
 	int i;
 
 	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
@@ -97,8 +98,10 @@ static int register_platform_devices(u32 station_id)
 				KBUILD_MODNAME "_wdt", PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_wdt_platform_device))
-			return PTR_ERR(ipc_wdt_platform_device);
+		if (IS_ERR(ipc_wdt_platform_device)) {
+			ret = PTR_ERR(ipc_wdt_platform_device);
+			goto err_unregister_led;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_wdt_platform_device->name);
@@ -112,6 +115,11 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	return 0;
+
+err_unregister_led:
+	if (ledmode != SIMATIC_IPC_DEVICE_NONE)
+		platform_device_unregister(ipc_led_platform_device);
+	return ret;
 }
 
 static int __init simatic_ipc_init_module(void)
-- 
2.53.0

