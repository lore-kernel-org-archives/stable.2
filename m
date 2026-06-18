Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA340D56F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742698; cv=none; b=nj7Wp2jGTi8fEilvR3Da3oCFwjLRR6hspZoQ62kz3cEjd09MDLH7DXK1Pg7DFXyB3sStdy/2AgPN7ceoejmyC00amglxlyF7pNP5JnOzSStKrpVd526jd4X/v6i9ypQwq5HW/L/t4PbjSoXkWHuh9729KEB+3wEVMn2fGax71aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742698; c=relaxed/simple;
	bh=FrJkq2QFQB7M/HFuHF3aSRJbOTQURhInvvOWzxIsOnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRBQoJMvBf7kITCoKnmf7tKXQrPRxitTNQHjWawQZPhNzAgn4tC3PgI5zZMZu9GEbBttjIGd8o9g55EpywLpkhzrtkQjO7jhzbCxDPHkFFvZAi6JU0eVy/A0ieDnU4tKZ3lRygxxfY5t22JXWQcF/qzew7yAcAiPgFp/4Vn0H5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ffAY+xdk; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ffAY+xdk"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-307d0405e07so516444eec.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742696; x=1782347496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYgrFV90OhxUZExH+iBjabROwPBanLgjzfUx0ElNjL0=;
        b=ffAY+xdkzGe8o5BLXs6u3wk8AcsMY9OLwkGAGEYdaip5XtmSojI+A+Z0eGFRVuFWJy
         U6QInWRCnCBzPUarSa36Ys9DseoTm+PLGjd8axDqbVUjMCL+RbHV5WRxHCgKjJOoS2pm
         EtIxsMv8m9T6f+SWK47mx53HUCuVGVxUMw/eIvXWOAqPyUQsh/HL1RgYJ0IS9Wen6gDq
         5Cw6mkqHSva7kBqcqzBQDsAQYaAzpDymWHD/y44f5xVRcTD+NxOaMK5DAucJxQHj457n
         gBIqPUew/jL+zsJvfFqL/O59wl5q2iVte9+E4SwkL2nhTxjLcAAPZvKuGbsOKPkI1GA/
         oXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742696; x=1782347496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYgrFV90OhxUZExH+iBjabROwPBanLgjzfUx0ElNjL0=;
        b=XRBNdjPI04usfubc/Ht62PROe5JDU1Zu2bie4v0vgEEkwpRepofel3JXqf3pGBA06R
         8y5h9eD5dgXwXFNXvQfSrYmzUrQbQ6xwiFHJ5sX6cLLI+2QSbxy1fImckDlsiqOK2bKK
         VlUenrHiFOnaM+7xvFmBUEYcPojiw4+IzReY0vRDYqQBKBj5I94JiVoEQ+l0I++EhPfg
         RKMj9AQjtVgY25nawvX+2use/XsQ1KqSQc0bCzeAa1gB3Enhw2cKkpTB3g5/LP2bY2vb
         ftC/QvXgLdyB0mt9iKhbEGHkXeGkObumXQZ63mALiyZbK0VVatj7tEeNem5l/ALuIHQE
         eARg==
X-Forwarded-Encrypted: i=1; AFNElJ+kEUZjJ5YfSGWp76UzXnqpusztl5VYBsvZp40cvQwkSUKzvdUt7s48qFZmfqcmfKuZDZrJy+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/11gBZEpnpisGqBF2q0QbMCM8RHdCClq6rq2MTXDlcYyQWgDa
	pmnkV9O+PHWfxeSn0fS+49mYQqiwxrn8NVg28wp1g1HGXVyEpWtp9wkD1db3Tq4C63E=
X-Gm-Gg: AfdE7cnpIn4WTGMZK2pUPvYdzC0AUJ1dDTiBl/buHspGzZbcnBtBcC9Z2ABbmb6Oslq
	YvlVUAjsvcpabGec/bXb73oQXypRaLV1VwmeOvIGbJJebalwdrIc0voKPmtUi+1hVB7OGAGw7Li
	miaepGLN9Veq8DX9thpH9Em4Ox5BdjMoEPCuzLd4Uy/J/GBbu6//XLrZOlHYYT29ezPYEPZt9V+
	59Nw0F/e14vz6CQXFqI8/LvGtzTA7xn7J4GBht+1jzs7aoGMu/kOQJ84wRbkF4lCyCrE2kyno2q
	/kvOWXgPF1+KKgjQ/L977RhXXUkxfuu2eI2T4GB7UGmHP798BzyDV6oE9NL+JRV3RDmjFjG384c
	GgfVB/Aeiv6KMNDtjJVmYNRBzQ7RIJq5C5PJgOvW0J4jgTzZuVUwaRYWmBul1/sh3oMxQ0/oufw
	UXFDqnV/scM4DVPT0bP0EZdCLvIZAeEZnd6A==
X-Received: by 2002:a05:7300:7243:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-30bf071d0c1mr805283eec.3.1781742695753;
        Wed, 17 Jun 2026 17:31:35 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:35 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Libing He <libhe@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/38] x86/CPU/AMD: Ignore invalid reset reason value
Date: Wed, 17 Jun 2026 17:30:52 -0700
Message-ID: <20260618003128.3112824-2-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit e9576e078220c50ace9e9087355423de23e25fa5 ]

The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
commonly used error response from hardware. This may occur due to a real
hardware issue or when running in a VM.

The user will see all reset reasons reported in this case.

Check for an error response value and return early to avoid decoding
invalid data.

Also, adjust the data variable type to match the hardware register size.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Reported-by: Libing He <libhe@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250721181155.3536023-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/amd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 717e928b4ed5..60dd651c1b42 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1415,8 +1415,8 @@ static const char * const s5_reset_reason_txt[] = {
 
 static __init int print_s5_reset_status_mmio(void)
 {
-	unsigned long value;
 	void __iomem *addr;
+	u32 value;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
@@ -1429,12 +1429,16 @@ static __init int print_s5_reset_status_mmio(void)
 	value = ioread32(addr);
 	iounmap(addr);
 
+	/* Value with "all bits set" is an error response and should be ignored. */
+	if (value == U32_MAX)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
 			continue;
 
 		if (s5_reset_reason_txt[i]) {
-			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
+			pr_info("x86/amd: Previous system reset reason [0x%08x]: %s\n",
 				value, s5_reset_reason_txt[i]);
 		}
 	}
-- 
2.54.0

