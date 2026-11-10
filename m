Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339902;
	b=VreVxRfSG2VL1N46QRw9CqslkeZDcCrAjO/gEyZS/tk5+ISxTfAdbiIMGgzg9iUlHUbS
	 bc/5PaYw02b0DtLaUnNTYXWhMGrYZqQOLSvaBKyt35oJ+X4862Tiq80KFKbvY2n1YsX77
	 78fBE2zfZPgFooh4HxmyO+5BADoOFM1etgt5qeeBo6/DRzd7BclwHsOdxWTCgoA+d4MJ5
	 Voi0RyaqdfJUOfnp7KaU9u6JOOiiI8oNyIPiTJG6IQDN7Ur1MwRPjQLm0TvjOkFch2gXV
	 Wt3xpbP1YUayRg5vCjCUhLyJIaQHuNJtE48bL3KllOCPlcFy4e87DGvc4lIorlQXhng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w3N08lhk5jNp+8S1Q4KGsHv03lISJT9xIWvPJ7IElfQ=;
	b=hw1kdeY2pNVCQvjW4JLPDJ1jlSCybp5CX5wXLitQ/q0hmBJjpc0SC7dMNVfg22GNPHiZ
	 BPLrFzRbXB+Pe/aZJiNaJEdK3ilzLN/beyARD2gTjUXWi/aPfL6kiSQv4m0YroSXW1HrT
	 DFJ3q3smnsvczVhkvjPH8WkvbFBPxPAQz3FKNslvl0Rp/N96DDg18scITaDQOj9OKr0bC
	 NbC6Txu4K9MyqT5+vN28cn3Me+rgiEgm99A7SK+EhZ2e5hZAh0EWFDDHiO/Wepf7sDvQK
	 ChJcKirq4kAAyvZ4e5+bid5QIdoZK4Ueqtcze3qfKKrmRSHy/sIwv3SJUZ0rmODcb4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzh7U7nM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB50606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzh7U7nM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C661F0089F;
	Tue, 10 Nov 2026 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339901;
	bh=w3N08lhk5jNp+8S1Q4KGsHv03lISJT9xIWvPJ7IElfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzh7U7nMt29PPezlZAmZV/Tkf30voNi4z8l4VU/8vCirUhAtdkow9IrSN9dFsqxjw
	 Tv4BHOagJ/QANgudLuc61y/TzaQFeuz7np/cZitX2uPEQPQwCotzKWQrVhTIdHEfJC
	 05ftHUtrzu/mJpS0QY+YePATBNeVN2nTu/rMpffhp6b/ag/mWOasihoNa5JaD6gKRF
	 hR8LyYYwH+WjRFsjuhEeozG2CesKP4VxseipGDQRaMnWaQ5FO9MiWNNACv5i0M5WZL
	 0Q7CKAJfHhgOJ3nyqNgn5DNJfZz8LB3SZnbpKexKt+06AKje9eEmSRs7zWUH8/23SU
	 LEOsBMm8oUdKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] platform/x86/amd/pmf: Add AMDI0112 ACPI ID
Date: Tue, 10 Nov 2026 14:44:59 -0500
Message-ID: <20261110194419.3606698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054724-failed-6.1-325bcc126cf7@kernel.org>
References: <20261107054724-failed-6.1-325bcc126cf7@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 325bcc126cf7a512a0e2da0efddad665f69badac ]

The AMDI0112 ID is used to bind the PMF driver to some platforms.
It doesn't have any Linux side code changes relative to the most
similar AMDI0105.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260826163611.2268377-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ sashal: Adjusted ACPI table context to place the entry after AMDI0102 because AMDI0109 is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index d10c097380c56..ca08a659c1606 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -339,6 +339,7 @@ static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
 static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0100", 0x100},
 	{"AMDI0102", 0},
+	{"AMDI0112", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.53.0

