Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0D4F6469
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369580; cv=none; b=iCrHD7qej/UWr6+vVOm2KMMDas0F5pg/qNO7js3FW7PEKp0BwJuAnAEVnuQc8cKUuarqVyZOa+UDrmgE183yt335LGLc3qgbPN63qz1CgJDBRnLMx0A5Q8PK1pWNzQvXxtl5mjLtbPcKPB4XScpx0LKEXUQ78eIBktQEBaotHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369580; c=relaxed/simple;
	bh=V3+yZT6YgVYUQdzB9TmvQNwHwQAuLA6xbe0leH+6ANM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrOSNZLYe8e3eHa9aalCJ51GCPmlYrj7vxDXMu1e+eudUaZShvvQ8h3Xe8w3szDOk4STopfY6Nhhy/IWn/TB9lOnOErCAQQwMbMo+/MqVgnqYb5IwSXRDG+PrTQa/I0o1yFQS9+1lmfuSY70h6XhSJOJdmcxpLa88ItEGz91bIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxudg0PB; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxudg0PB"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-341027843a5so850426eec.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790369577; x=1790974377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hILfYSx6Rwo5N+DFRo2zikr7W+nhdamltoaH7/MZZ8=;
        b=Lxudg0PBKwp3TkGFWH+jnoPkEYXRPzkBciKOhNDAdWp+8FspFJZllz99/+7RAVml0i
         piwFFRPrPFvWgxL3MXp+p8mqJdjP3RXnylD36IvLR6VSsQnI0mjswWOYJYNRmKPLAAEh
         nxMVPw7Vv4C+w8U+VY6GHgaPFEfKheJFwCv5clXkiPy594UNtJxQ+HDdUwF52ZW+8mIO
         N/EbZucLx+4hkNnrHdr0ArtuuBOGOYOgZ79KIF7+te107j/Hl/k1ozzUqwKwF8J//cKZ
         GKnYXx1rUhJC8ZO23BFUjLKdL4UJxcq3Dj5UetFh86ERg01Px+kFTONXh2//9Od5fvh1
         dZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369577; x=1790974377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hILfYSx6Rwo5N+DFRo2zikr7W+nhdamltoaH7/MZZ8=;
        b=j+9X014APRHWavEHiT3hm5OH8P/XQoQvjaMySCgVOrY2es4pMG3u6tGEc3o8yahI00
         cz+VpRgv0hl+Q77n0dNzSj37sXdiZ5daWLp1aEpP73TKSX3zr67RJdOzcIuOM42LGGpJ
         pLlXThBFDvhn7tRfKgUNdzQ9s8YuimoNlLhRLUPJJ/p62dEfbPyI9rLjKzeJY3LT2scI
         1+ZMv+o1cmJKcl832GgfjogUobnsyp/rbdMF248vf24enZIxShtSHL07pii9Hx4U4NUv
         C4N3vnq/o403lhQlXZ7bsm9cWNR2O8O59DF/d5WCxV9btcHXVjqyFFUN1Xw7N3BfNjJX
         JWyA==
X-Forwarded-Encrypted: i=1; AKwUvBwQYjHHle7KDZga3sb0imtDDwXfsAUY7sLcXD8LZnymcQ4D2nuhIaZvsd1rUGbeaIsogcGYOzk=@vger.kernel.org
X-Gm-Message-State: AFuF++kfdOC1+8ddeBtOjxqVGWcsLLh2xlA/Deh56N1rqwJDL2lJdJbN
	kAaMGUhttq8OIPqJmCEZSsdYlDEP6vUgp4xfAedTnX2kuuyJNsDFfgi8Gyxyujc2
X-Gm-Gg: AYBFou3wacE4F2hX6IFy0hfFQlWSmldwWPURt88ZdPNMsxoIAFq2x753kasmd3/QbJ3
	B3CNwOebW61mBlNxGA/017kffkjk8LLqhK2l/M3zjA9jdDCytbA/xDEMNOSW3sKcfn4/iTaYYbD
	GUoHeHJfXsBtJyNuf9yXeyt/3RkkR8TO0ntnm4YSaWqaIswqu8WKFg/naJnilOMt9Jw4cyQcLRY
	zUMmRkaKp34JPYR8e+NYQr89cliCSIwBDgjSHSnvHPSxe8eE73R6O0pi0z7c9+TjcixtAG/H3k+
	/qY9Nq5fr4uAflM3cBLc5vOuSZV3Fso/Z/ged2Qeu8B1g0oyl0BleeSgdZdk+S+of491BqFxgud
	v7aJdKHpaiEms035W5eBAP0OyfI1yeGHKhzG4rSDYcAQzL3cGyo4WH4WXd42xHougbVOlE8BdTp
	M73IbQGGiB9Z+UZS5+jUeh1FCkgZjrn5UL/Oxn1xBaFmdV44D84XoMPZ0j+yG2eIuiPNT/Z8wRe
	095XPOUuwS9wffl6nHS2fF878u383Q9vyyd+0Mg
X-Received: by 2002:a05:7301:dd97:b0:341:8e9e:28f6 with SMTP id 5a478bee46e88-34273946002mr1097965eec.41.1790369576952;
        Fri, 25 Sep 2026 13:52:56 -0700 (PDT)
Received: from CP-Notebook (host8.181-2-204.telecom.net.ar. [181.2.204.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141d2fe4bsm8673833eec.4.2026.09.25.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:52:56 -0700 (PDT)
From: Ciro Pedrini <ciro.pedrini@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ciro Pedrini <ciro.pedrini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
Date: Fri, 25 Sep 2026 17:52:26 -0300
Message-ID: <20260925205226.883724-1-ciro.pedrini@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP OMEN 17-ck1xxx (board 8A17) isn't in omen_thermal_profile_boards,
so hp-wmi uses the generic thermal profile query. The firmware only
stores that value and never acts on it, so the EC stays in its default
mode and the CPU is held at 45 W whatever profile is selected.

The board uses the OMEN interface (mode byte at EC 0x95, thermal policy
v1) and also needs the timed profile quirk: without it, the EC drops
back to the default mode about two minutes after each profile change.

Add 8A17 to omen_thermal_profile_boards and
omen_timed_thermal_profile_boards.

With this, all three profiles work and sustained package power under
load goes from 45 W to 56-79 W.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
---

Notes:
    Tested on 7.2.7, whose OMEN profile code matches for-next. Without the
    timed quirk, EC 0x63 counts down from about 120 after each profile
    write, and at zero the EC resets 0x95 to 0x30.
    
    8A13, 8A14, 8A16 and 8A18 appear in the same DSDT. 8A18 is in the OMEN
    list but not the timed one, so it may have the same two-minute
    fallback. I can't test it.
    
    I used an AI assistant (Claude) for the ACPI analysis and to draft this
    message. I tested the change on my machine and reviewed everything.

 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 7ab81ce5f..76f489d5d 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -207,7 +207,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
-	"8A15", "8A18", "8A42", "8A43",
+	"8A15", "8A17", "8A18", "8A42", "8A43",
 	"8BAD",
 	"8E41",
 };
@@ -226,7 +226,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8A15", "8A42",
+	"8A15", "8A17", "8A42",
 	"8BAD",
 };
 

base-commit: f475845eaf3d749114a63270bf2efea459e14dd2
-- 
2.55.0

