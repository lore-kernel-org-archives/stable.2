Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338158;
	b=BWrkeztYQhsKfUzty2BIUnYbIvKPveoVoZ31AeFaLyRoiY605lsvHrPtxvtpwR+XvgyI
	 j5ABLCnD1XdE4dEQjOvJ4lElG2avLxD4xRNpGUxGRFvoI45muYVqAYJUXqUywIvlQvJcI
	 AcV/nt8tSK9f8n3V0hwXjp0zSBnjLPaqcdv+YMdkN5lLYlhYnQtOrvCjUsavaZ7RZZi9s
	 Zw9/npcrm7/wnEJ5JDZLIrZe57zGIXtWcZ5U6PaZoo/IFViOVoG8CkPWQpZkupJCu6Kpk
	 o22kxslYOObFwLJA2GEGchuPLS4jwaLnuGlOyj9u5T1BQIqaQ1gsR2MRmyLTMPUkHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OJwL6nJ7HVXcPnIpV+VZoPcr4MATL4Gx5fVb6hh1bwg=;
	b=aXHmS6/0G4EPF7Nrfoc8W5jlHSwLCC7CGj9tM3QarqrRjZoWlwLW02ySK19aT2PEwyQN
	 TBbf7pxaHMChU2MqLHXqBvD9h2a/fg3P9DINYYzkfKEbYwJDKh2Lrk1x1hHWJ8UQzopcc
	 tJuPXhlJA6gb8jDy8uWjPJbK6cjdkB06GBnb4OC4uZKWuN80W68iYrfVx55P2XcHuCQ/3
	 0nsoX8THl1/h6VBMEqbrcug/pLqLV2Bj+4FnOXx7WVrCZ06/kruB7wJsvOPq4qljodopc
	 0UKr1ZlegYeicVvxLsdaEl1sc8bdvXMofYdZsuLOliuG0SdDkiY8YcIhTZ16BMSGBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcsqU8Rb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5092606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcsqU8Rb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0571C1F0089F;
	Tue, 10 Nov 2026 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338157;
	bh=OJwL6nJ7HVXcPnIpV+VZoPcr4MATL4Gx5fVb6hh1bwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcsqU8RbTORQsrXtKvmyL5+ZFdoTW2e2BIFNh03V3+xAdQS8+09OgCpQW2txLM9Qg
	 Ba0zEYpPPHSHWxYQVnNhWm9y2v8pi8LPqfuTX6pe6Cu7vXmfeQxkSXpzGpf7Po8GCh
	 nIlJXevGScD9XNPXxldSCmqyDuUWuE+NT/Dz3DOEDTYJOG0JpyOjtcKxoy9pknNr2v
	 F7iFeaB4r0AbFu9CYjIhw4Fr4Ea1xCLDalhJ4orAbLOl7Yiz4BNPm6KW1hQi5rzQJQ
	 pDFGm2GrrQVlx+u4aLORCK77EHWlTWLvUqfHiQHw8rSJ3ONveuMDIUd0x+xDoo+frA
	 bkQWVIMn7sIiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] platform/x86/amd/pmf: Add AMDI0112 ACPI ID
Date: Tue, 10 Nov 2026 14:15:54 -0500
Message-ID: <20261110191413.3511149-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052137-failed-6.12-325bcc126cf7@kernel.org>
References: <20261107052137-failed-6.12-325bcc126cf7@kernel.org>
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
[ sashal: adjusted ACPI ID table context due to the missing AMDI0109 entry ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 496fea1389fca..2039c9d90f87f 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -467,6 +467,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0105", 0},
 	{"AMDI0107", 0},
 	{"AMDI0108", 0},
+	{"AMDI0112", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.53.0

