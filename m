Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082571;
	b=Epl966tQphZwb90e8a+96PazAcyRrkClQ4I9ZN6YFiY3UnTwG/nk2C4K+L8R2lB/mCvA
	 4lqG975STd87Ezntm80ThbSjXB6zo1NrGE3XuggFIWuX/j4VaHu6oFPzL3iUW6Z3ESCE/
	 JVas+spvMK5p+GfSkPA3y3S7ECRVVZ+s6BGxBYP1qmZLdxVzgplqMPoseYcLpIYINMcIG
	 S73MmTgwU3vgbO0yMDs/H4pvD6ZX+JJS8gYjxs6GphPJ0uEthvJCdoYVZFVn6DfLnGbdy
	 wEPW2JjDeYTCNRaZYALJ8Rww0uDrQv70QUf/xCKFTm2KqyXMUHvtpQ/Z64nuzbLrGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MRGtR/xM2hkitb9/TQ1LM0e/3K3eoc1ThDALVep6pH8=;
	b=GKl+e4vuHRWFrT82xN8nqVu48zkjDoRx2P1KPjHfuc7BMzEuYfyKX4a5SFe1PhD/oneE
	 4jsaBA8vSfaslhGHjVRn93VaI6dhKpEVPYGmtCT8OvvyxvQodp/E/O1JzfDHFk814PUW0
	 rJhSQzE0Jux4xKWGLmJadDaR3KCtZRG6K3VI2Xz2dXnxX/mhOOoH31SGX5XXSttrRh4hO
	 Nan7c/lbGKaYZbQw58O9RDXzEOUuypscQBm8A3yzm256VmOZhBnzIoJ9lFZOHcoS8sQP0
	 /CkQ0LsR3HSdvwMRhhQ99mIWaOot+3Xjvp7cUx+XtD2ygyM0en1LFikx/Wbcsa9tU3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZVhQxWN;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54430606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 20:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54430606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZVhQxWN
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so15275765e9.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794082570; x=1794687370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRGtR/xM2hkitb9/TQ1LM0e/3K3eoc1ThDALVep6pH8=;
        b=MZVhQxWNfMYU5hB8FHNQ2thbUux2qMhFmANkktLXSu0oY+V4uh5CcMcXqT+dDlQ/ix
         en5kHuRMLHLDnHmK1Y6M1Lc6Tli0+2hKtnNnmOEToXp8AWy3HbaUP8u3adql60MovtwK
         oOIXtCDeYKxdnQ3au4PcWTtrV+FOpAm/pHTvSs4egqY+RqwRAxCiC09beKmeq4VpzBX+
         zresHB3NeTfWKhhg4PSnRaq9E70uuY3l51ZjvqVJ5RGHaRPq9hrM29vznWVI4eRxpMPo
         of9sq8+UBA4XsXdkY09BKnZn71uknKv9e7koMO8jbe2dc604VjdmtTce3h5aO3jEx+sW
         g1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794082570; x=1794687370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRGtR/xM2hkitb9/TQ1LM0e/3K3eoc1ThDALVep6pH8=;
        b=gFnUuFHrP6YE66dZ+QEuQufOiD6FBl1Kji4ULV1qmtuHdhDJd8e8RXYBDYIDZ9Cm+p
         Kc3U9PMSxJxF3FYdAb0GFkwHK/PTkc/KT4+uonHaCHb0OB+5vW9OKL60q0tMi2wJ04vT
         ypB+02RwQg0HEiQPcJotlhQVhDrN8WDwsA4LDXGC9TLRWIwxSW80tcp4/2ufI/DP/TNa
         0hBpELliOvkECuM3RWbzcOrGCAd11Db59x9diftz+9J8wN5YXaO+v/7ubEectRsKnoL8
         Fgwik1QkbFI2w4keVDAqmB2mXYcG81vLUqrefeEC9W0NeBLXQl63HfdmqYdiw+VWrb8F
         qKxA==
X-Forwarded-Encrypted: i=1; AKwUvBy7vmaSIL5TdyRyeHYwbaKyLH4PG7/Qx+/gNTIxP8G5vUd+dFqen0yvgFYrCrOV2VRHBirRiw4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CfFgmF7t26LDAJvVWviy3cHS3BgoxJ14xbsoNpO8TQuxplgcV
	teJ/xadMz4qqk2BeDhoxNAYQHX20FRbF8pBe3MgKOawfshioNbQiHiTU
X-Gm-Gg: AYBFou0EQ+iALgesmoGjghK2WVQSkpxHu5Mz9O5uL4uWjV4OJpvYmk9T+cFmGl8kV8b
	9qnS8LuH3K++fpL+tOe2uOsDwCQODYl2bcMyXw02+qbxH6e9p8UVOZJ1k/Z64+9vPgHoTMjr9SI
	UEHorRnF2xWznzG1cGzEXwFNCNCjulI3FRnIbvp2klj7UFTSMEjPySbrsXKgjHrWvNTANPxnQdV
	6AThG4j5Ffv4Xmyg+guYP5/Pra2gGGGv/RKY1Q4zn+GDL8+mV9pqbcU0YntwNG7G9AExgEuyYHO
	/RD57zuI/hmASiyIv1tKxJsg53CYVOVU5TW7Kh0R2FD1bMDFCZeNYP5N3todbRH9lWfLV3ubNuh
	j0iWM/Hq2ONO46IwEYp1lOcK5Wy3Gb55BiYA+7tsCAUjsDcKNRzxH/m8QIVSFk84yuyfbm0U7n9
	m+Uva1lzHeNnZeiZHoCE3/OM7N7cZ4ZAiCQmza0+kK8IaeLVrtZEfaV644hwEB74lAUOz3YsXwF
	e8SmUebH0A2L0nFmGvlYPkv7KYcIOCVClqJAsI9Y7XtSlzyuYC9osSbzDL9R/rWeThDb9DeMRIZ
	OlOqi+L78yjcpUQ4frdxbffpC76GTxbj5h3JL/nC3F20U1A=
X-Received: by 2002:a05:600c:138c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4b6df6df5d9mr103278195e9.32.1794082569692;
        Sat, 07 Nov 2026 12:16:09 -0800 (PST)
Received: from Amir-Yoga.tailec48ed.ts.net ([143.58.202.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm230762005e9.3.2026.11.07.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 12:16:09 -0800 (PST)
From: Amir Sabbaghi <asaba90@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Sabbaghi <asaba90@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: EC: Add quirk for Lenovo Yoga S740-14IIL
Date: Sat,  7 Nov 2026 20:15:53 +0000
Message-ID: <20261107201553.9268-1-asaba90@gmail.com>
X-Mailer: git-send-email 2.54.0
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

On the Lenovo Yoga S740-14IIL (81RS, BIOS BYCN29WW), the ECDT
advertises GPE 0x6E for the embedded controller, but the EC is
actually wired to GPE 0x43, which is what the DSDT EC0 device's
_GPE method returns. Since the ECDT and DSDT EC share the same
command/data ports (0x66/0x62), acpi_ec_add() keeps the ECDT GPE,
so no EC events are ever handled:

  ACPI: EC: GPE=0x6e

  /sys/firmware/acpi/interrupts/gpe6E:  0  EN  enabled   unmasked
  /sys/firmware/acpi/interrupts/gpe43:  0  EN STS invalid unmasked

GPE 0x6E never fires, while GPE 0x43 is left enabled with its status
bit set and no handler, so each SCI it raises is counted in sci_not
(about 7/s, 1.4 million over 55 hours of uptime). As a result, EC
query events are lost: the brightness hotkeys and several other Fn
hotkeys produce no input events at all, and battery/AC notifications/
laptop lid event are not delivered.

Add the machine to ec_dmi_table so that the DSDT GPE is used.

Tested by overriding the ECDT through the initrd with a copy whose
GPE was changed from 0x6E to 0x43, and later by applying this patch
and removing the override. With the fix the kernel reports
"ACPI: EC: GPE=0x43", gpe43 receives events, sci_not stays at 0,
and the brightness and other Fn hotkeys work.

Cc: stable@vger.kernel.org
Signed-off-by: Amir Sabbaghi <asaba90@gmail.com>
---
 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a89f10256..7c0643d5d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2007,6 +2007,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
 		},
 	},
+	{
+		/*
+		 * Lenovo Yoga S740-14IIL
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga S740-14IIL"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.54.0

