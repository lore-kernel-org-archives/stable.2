Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDE3B0AD4
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926187; cv=none; b=MnNu4N/XduUslzkpV/F1yCiBBZLZ+881I+D/osLJ3yA8nygXsd+X5jVSBWEQkkM8jiDIrnHjTzaeYavtMvEVmYBeZFAe1sqzTz2fubJKOa9cT6ioBTmZnPrDbdkx1d8KnU55CfvkHM7cRn8wyxERWj9ocDYpDl/V4JDHTsG1NnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926187; c=relaxed/simple;
	bh=p8POFC0Q1WkRp8Ka1VTVl3OVHKoj5phUJkevGRLYJGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YEzMxSIVulmHbplVuq23gQlimXWrk1YtB6I8nvKaxD5SF+htM/jn0H5s/CGqvwoWKJGfF5G0amfAc7U7Vn0gATMpNNEHXNzclhI+ByHNrDLWwjtrG0FQfnJQDeBte3rx/HBhR5x0tt6iz4sErH4c6rpawXdOpEv8f3hGNj522d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWvkEbe0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWvkEbe0"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c858014845aso1721961a12.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926183; x=1781530983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHzbcFreo9ZiUMP3qqPWdb9beXmFTCbf1XOZjKPDsxI=;
        b=oWvkEbe0NjSqMj9HHlkSQbZUUE+yrDDJ7U1stiLtfy7mMIErSEfyIvpg4KOJQ2s3vW
         asEJ0bVY/nv9FprR0hJf3m1W3/C8cW6NxUYayyoNYoA7Y6lLUdWQqTNHB1AgV7BYMnoj
         x0PxEQhPYgqv0dfzuh1wt8sThyCTCgU0WMYyWjqDhHH0sP3itcf/ZhSj6NXduoeiY1rA
         aYewVyD5V36qVYg0Z2R9DA7lc4Ydrb4mRuMafNdd7DGknZwDHJ8R5wdKeC4t+Ci4KQQb
         BO7scbH9f0ecdjx0EZfkugQSpihNjcJm33CTlzWOh3/VKY2+W/vx32JgvVfXTQgkkSys
         jsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926183; x=1781530983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHzbcFreo9ZiUMP3qqPWdb9beXmFTCbf1XOZjKPDsxI=;
        b=XrDpuUDoTBP+MswIXdWiDBCXx++GxODbjTf09HOXUJaOiPNNOGBljjHy4mA8mJDksv
         LMxWybpJAdmCEqhHvRWVRh8muwx9NlRDTv16JbJrKzLG8DWtIXerrPzwnjwHkvId9YOt
         LRufodCFRWlrE2PTxvXJzO75WZABpVbwYrVOhQfJE+zAgDMX9rcMnpF8p84XAVO5SeYY
         2XEz/heWR/+ozk19xzod/xL+XVnrB1PcNdhdGQw0wWm0PN6pGboyLTaSU4//MoWnh3wU
         l3xUmqnnRMbRe1eKuSRDVx20UlOUO7KdfgbvvZ/8zgp3cg/gJ7IU+bXSizCiUWnHYkTy
         SVBA==
X-Forwarded-Encrypted: i=1; AFNElJ/cABaWu5thQOu9hm8olSFpCi1rw1ebTTEkArPbssDSb3K/Wm65HhlhmBTkDzkqymeiFfupwcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHV5GiYo7sQYg7vDfAM5jp7LFhW6yhygBp676EgmzOPAjRq0d
	iWHy9SLKV4jbIxvEe07pC4PWZMnis5lK29vDVaHEyY5b72gIWqOxpgmx
X-Gm-Gg: Acq92OFkogqxR3bysEqyiz23YvBafwvRWzcgoUdixdleP4vsstI2XUbxQ4StSWzCUw0
	aJbryOmpaydBkAGW0XxRVA4bjvibsVIMVADthVtcgN2mPEcoxuUE3OKiDD44Xn9mZwX+rRiy4RA
	2RTtEaW9Ie19P/ABG5mlXP+As5jQ/pMZvVQtGc3rYzZ4wMbb8KzYHRm0LIvXmLoQtWHl4/wqj16
	Xp1bY4EQ8g91nKNApYpkCfAPlfXG+QNs1XuG8NzMbWDkBbjhAnjlIwjyGQA2qRLuXo8p5QeeFOH
	09ZtTfFPuTfMiQwrgSOcWOO+uY8j7Jd/o8yjh+XZyy9JrDhmbIM8K8Ncj/BAYTNKJEroXjgrIOo
	E78lEHyDFyMjEQ5nHr4tgpL/M7e0lMlBJv0G8NBeUMw7JbWPylChOaBhMc7nGcEoHLPUpKenHg2
	9EWBxno7YPzKzvwrWEoOH2pYt0VAqvP47yvp/8AWiNFyqGozjQRtaHIsW2NQoYh/xXNdtdWBB4W
	DL3awimxDHibhJljHg0uWfwRB4pYf4=
X-Received: by 2002:a05:6a20:3ca7:b0:3a2:e089:ae4c with SMTP id adf61e73a8af0-3b4d39f5912mr12893900637.5.1780926182745;
        Mon, 08 Jun 2026 06:43:02 -0700 (PDT)
Received: from archlinux ([2405:201:1b:225f:72b8:b88f:97ce:a863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85deeb2bdesm15664248a12.0.2026.06.08.06.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:43:02 -0700 (PDT)
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chomal <krishna.chomal108@gmail.com>,
	=?UTF-8?q?Ahmet=20=C3=96zt=C3=BCrk?= <sivasli-ahmet@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8E35)
Date: Mon,  8 Jun 2026 19:12:55 +0530
Message-ID: <20260608134255.36280-1-krishna.chomal108@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The HP Omen 16-ap0xxx (board ID: 8E35) has the same WMI interface as
other Victus S boards, but requires quirks for correctly switching
thermal profile.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_legacy_thermal_params.

Testing on board 8E35 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Ahmet Öztürk <sivasli-ahmet@gmx.de>
Reported-by: Ahmet Öztürk <sivasli-ahmet@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221523
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index f27d82258aa3..e94df6ca39b4 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -265,6 +265,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D87") },
 		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
+		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+	},
 	{},
 };
 
-- 
2.54.0

