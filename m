Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDD37B02A
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874758; cv=none; b=Gsf2TrfmW/lQsj8ibZvbE24fxj6KQAQhzLwEOMcvKSc651uzLm4bJBh/n4ETM/XXbFtzw48+mLe/foWDh133TmEBXkJXhbgDRABaQ4jiPkhZtMTja04PRBGcSIEaQ4Jo5RKmrb5wMwT8yfqFEVyE8vGHC6qq3IqzRJVvLyhWHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874758; c=relaxed/simple;
	bh=R/T2E3R24ceiWrscXHi19ccUmt/H/KqN545pYvOp2KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLjrx82bKKMEQ1nRzYCLKUxuAR2QjxLDsNky525i8B4qCKdYlFgZz5/01XrXpZyVK1KrbCUNR5YhjaQIb88obDx8PqJM4zDyOetWRxR6wfqEvwEiT3SKESGfmk+Z7WUP7LEkH6BGWkk/Z6yV4YQR/o7nDUmh/CuuMKv38k2EdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5UDEmSj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5UDEmSj"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4798bea72f9so269276f8f.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874755; x=1788479555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jY4A2HRHPLdlxueRqz8ws1TBH55WZRrXuoNB9eDCsvs=;
        b=M5UDEmSj2ACEoOqjwtD4fmjmVQUvqiRVmJMgEHBRIFhzvK42DVe//50De2InfvXffz
         btMRAiVeeGZ8SLmjkEu8xXmrfh61nkiXFjP8HuIuDN46UqnK8lWLGM+pcwqYuHTbRQEu
         7OQu1fpYe6+rd2s/PBuY0RavKKhKsoES1arSUlOK1oDy1MvdDrQrhI7WFj9RZl9zJZ0h
         CYTjeBgE7YupOivX8D0GDZd1nOT7RUZZYtefTJXOGEXgaQYIuG2EI3WXxwqsFb21s7aE
         0CQ+zsAdDzKQK+1uacij8f/4X5HVOiTsp92S1xjpEc/hA7aHqn9UyukWV7KbBFQ/GQwF
         Uj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874755; x=1788479555;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jY4A2HRHPLdlxueRqz8ws1TBH55WZRrXuoNB9eDCsvs=;
        b=cgRVUq/JC80r2Vvxl/na5wYRl54tqRjeP3Rnkrp9ZcpgnWN/h67MMeK2mZvRxXbHZe
         s/rogvmdMk4j+957iJq9WONlu4tV9eLcAYvSaCA/opLghZFkOOSTxCDP6l8UnOjk1oQD
         WY1P9PG/aZP0zo/zjfZ8LTCk18edQEpfMX1lOqaUpATRJ1iWQynMfsQ+VuzxhO1/42Ug
         ckiMog2DyyZpBxtJHC8TpSingg14f5aJd9l3Pae/CswqBm8NsyMRHwYr5+ALtzzlbMV3
         IwEFvBWusMZ5eUsbTKwIGUm8hEhokPULHpcPKaqbxn3rhGmIby9YSqVZeShVOC7+4UdR
         MdpA==
X-Forwarded-Encrypted: i=1; AHgh+Rrgk5ZTj+k13CSONucBrSTGi3l5dViVYzv8q5AKQGxOoUjQtNdeqbUJlTojidSrlkFSE6583XU=@vger.kernel.org
X-Gm-Message-State: AFuF++lJW58i8QQlPz26FHLH0g8Sl+UG7X/NpGaiwxDLkg6x2zuVS88n
	cmFoJqcpAMAW3dZ1LIxqoJs3X8Z9ii9bgjodxKJstjrVOKsV93N9h+7g
X-Gm-Gg: AR+sD126lSrG6L7g+mrMO/58YBFQaDMxGYFx7STblF0zbxgvj5Am6F0RzcDq0s7zckf
	GD7guQ20pF90f7WYSNNtKIMpPze4zKSrcxAHqVTZLJhAAQCE3PMKwFs6OIHX95k6HbRM3GcZEum
	TdW/owO8aRPwyogh+hpytLqEpWgMdEy+jlX9P/mg9RUWuhs2lRsDexfA8IfOYBeE07AaxO5XYQ3
	wB23qSd0gKX6luh8rEba01heDC9TmJY9avMCLc/Yoci6w5n8iwAN+0UuVcMb1EEvDYgyxqQaU7J
	ZlFUtl1TKm8CHlyE4pxlQItrfFF4Sr3KP+6gI33rwYRlECGrnqrJEY6CznsHWbRNsm1dMx8j9qy
	0HX6Q5GqoBJkrdgNkDmP8rOBWv8Beg4IfYmUHUMAtisRE2uJ0Q/oFggu0VHviHHPShCA+NN1cRg
	BXMvJQC4vrmsAQ5tCseVv3RhPE6OhAPTXymK7ZNP2fDgg7JBVKxup1Z2uP7J12ANyNVXQ430/AX
	FL+kGw=
X-Received: by 2002:a05:6000:18a6:b0:482:f724:f4ba with SMTP id ffacd0b85a97d-482f79de104mr3017541f8f.19.1787874755297;
        Thu, 27 Aug 2026 16:52:35 -0700 (PDT)
Received: from archlinux.localdomain ([88.230.97.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279e8b7sm12853191f8f.7.2026.08.27.16.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:52:34 -0700 (PDT)
From: =?UTF-8?q?Arda=20Do=C4=9Fu=20Ari?= <arfeliousheres@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Krishna Chomal <krishna.chomal108@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Arda=20Do=C4=9Fu=20Ari?= <arfeliousheres@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6 board
Date: Fri, 28 Aug 2026 02:51:39 +0300
Message-ID: <20260827235139.154462-1-arfeliousheres@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When adding support for board 8DD6, &omen_v1_no_ec_thermal_params 
was passed as driver_data instead of &omen_v1_no_ec_board_params.

Because active_board_params expects a pointer to struct
hp_wmi_board_params, dereferencing active_board_params->thermal_profile
results in a type confusion bug and invalid memory access. Update the entry
to point to omen_v1_no_ec_board_params.

Fixes: a7320d6eb9c42 ("platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)")
Cc: stable@vger.kernel.org
Signed-off-by: Arda Doğu Ari <arfeliousheres@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index b2773fc1aca4..615b4cf6fc45 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -337,7 +337,7 @@ static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
-		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+		.driver_data = (void *)&omen_v1_no_ec_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
-- 
2.55.0

