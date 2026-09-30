Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665E2BEC5E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736414; cv=none; b=ttQYAxnS23KW5nQ/JruvU6USwKAkTE4tgv3LGdqD3HyP6j10tOE6K1w3k3eB1v4eMVdKS4U/WWPRURz7t6U6o/r5gLWZnupIvDdYxEZEi1+NSwGZxlfJfvIQ78kHYPT+Ndohdg2Zh2ivdP6MRBaM/1BpLRmXnMxLp7gXad1Y7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736414; c=relaxed/simple;
	bh=UXD1S75khvSt0FgsLz/T6uzhAE5DrMjJOyelj7NaGl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vc+mmtY0ROSyx2aeALuxBs7G7U10aoRtv7VlG0XGRjZujAX5D6yvneCK5kSmpBO0C5yabq3CmLmbbSpV5wxkgcwElUXyzPDqckrpilqEHE1+W+K/KvPMPj97oNJEDqZ6ge8Sk9J5hof+exaSPU0KVLcl5pUPXVRGy7JQkrt8a9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=UQLu1cve; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="UQLu1cve"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1460bcc512eso2828348c88.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790736412; x=1791341212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lomeLoiz+N4sTQlSWuotqu+7Ex6081P2NAVD9CMpcWc=;
        b=UQLu1cveLUz2BkGx3Gu1vf12K8ngme6hyxwM8iWrDEgk1I0c5eKf5TAcb2WXNrtf1t
         QY+HX6LXwIiZjTwyhnhOxr0N52rP3rTcFATh7kE0bEC3m/HIKDXy/OGSzP+CAuImD00B
         AoeBe8WfZoHDvt+UmRGe0qXdV4h17dqTaWI3c9PS3EGZrTFplqaLSnw2kswNWUnuhGlj
         ImTruf5XuUvFeMyOKvi0xs/gZmcv3SnxaLMkMtsWMgf9ZCqCV5j9Og8BmSmwXkhDcjur
         0ShspzcyZz6SNHhvo517wRZIPmlrFR43EyGy2frHKenoPx3oT2uQn3vNwzb0Crurr4uT
         YIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736412; x=1791341212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lomeLoiz+N4sTQlSWuotqu+7Ex6081P2NAVD9CMpcWc=;
        b=IBiJk4kfV7yXBlzHIDD45GSuWF6SZMFYBDn55q/SVcZ/QjSqFvLmmTNStBQ4QJFsR0
         Xqqqf4MGrhgsOntDc256uhzWY4kdUIOcg3PjSCGGd4S7FV6eqA4NWbnpTbr98GabV5PB
         uhqe9dX4gUl/M47+og7FYTYTrp+C07rlo8fQlbYzwUjPddih2pN9CqjmmWr6wTxRWZ8S
         hT6DWvutdUekZtUJWRkFkeHs+JP4cAxIVEyjqMr6Vo5QecA+kxhu2psIAeU/myM9u0nG
         82WDDHJ8kLLD4f0nKI7r6oQMQVsB/7di3JSYSaBO2ov1npw1VAqXGQIXCqRxcKBBSP5v
         nqFQ==
X-Gm-Message-State: AFuF++nG6IpG2OG0JrMuwCKHwQwHyLj+iMht6WAmML5c5kRuY0iGqfiy
	WKfBjti4jduGcuB/wZrvJQWSodUklofUndru16ajiZWqgHBy9GyHPNAs7Hx6m8crE6PGS/ylEs5
	pwn60QVo=
X-Gm-Gg: AYBFou33oEVzfMiSiO+xZMIdqqTfnU8lvakiOJEhailv2L6keiwfTysDLgsmw5knsxY
	dl2rFnBmJ7f6bqCSGn6Peg1ByokjghggbWKfCEOiq989GpK2FiTjOzY5iNzE0PIwBluBqyDY+11
	8N7xaB+K19B34MY2OiO+dal1D9hYKQl/Vb3udjVKYK0K2xdLfgNDNKKmbTBNdjqXRsjQrQihDXK
	3XNpfrzDvC/0FLw0/g4O++c5UT8bUmDA4uAm4YxSGu7gxWLl/4izUcH85IS0d9E5dlsP607uSAY
	Iio4WkLDKzTfjvreaoSsThNc6m+/+X3cuFEoRraGYCzTkb77zPYFEW7Aavk3nuTahR64ch2s6NC
	SBpDPTyz07kruF0GzkKwiTeYBlazUhmjKPUpPtM1bcTeHPnUUVy2V1SdNCyMbeFjfWah6NTw97O
	8RVAdmWD4dMr4z2z43puVT8Cs5K3Z4/2P1Uc80y94P6fkSpdEDMcyVNwTY6hvYvOW8PQIdgYVbV
	9zAwRaFuGwbXW3M2gY0nr7qHyEi1XoCQH+9RpmLmuwys6s+WQO1FVIKI5Nh63TxL0j6+9g=
X-Received: by 2002:a05:7022:7f1b:b0:14a:583a:8ddb with SMTP id a92af1059eb24-14c9f219854mr1348062c88.31.1790736411597;
        Tue, 29 Sep 2026 19:46:51 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d08fb50f1sm226271c88.13.2026.09.29.19.46.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 19:46:51 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 6.6.y] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
Date: Tue, 29 Sep 2026 22:46:45 -0400
Message-ID: <20260930024647.96625-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0 ]

A number of Zen4 client SoCs advertise the ability to use virtualized
VMLOAD/VMSAVE, but using these instructions is reported to be a cause
of a random host reboot.

These instructions aren't intended to be advertised on Zen4 client
so clear the capability.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219009
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and x86 amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-53114. It clears virtualized VMLOAD/VMSAVE on
affected Zen 4 client models.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The code change is identical to upstream.

Could you please queue it for 6.6.y?

CVE: CVE-2024-53114
Upstream: a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 arch/x86/kernel/cpu/amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a2313fa8a0729e..955da4c2385fa0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1196,6 +1196,17 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	/*
+	 * These Zen4 SoCs advertise support for virtualized VMLOAD/VMSAVE
+	 * in some BIOS versions but they can lead to random host reboots.
+	 */
+	switch (c->x86_model) {
+	case 0x18 ... 0x1f:
+	case 0x60 ... 0x7f:
+		clear_cpu_cap(c, X86_FEATURE_V_VMSAVE_VMLOAD);
+		break;
+	}
 }
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
-- 
2.39.5

