Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339044;
	b=D8eahJMCLRtcDl9IS4N3yGm/KGOCrWTM7NDWlrD2FgQEv6ah0hdz+ep/doArVoVY1tQh
	 Sa3M4MRdq1rypN1sIVXLq3ame+AJWicE7xtth1iv6uCrJER7LpMNzOzACYSp+7zTvjJIE
	 NfeL17TWRm3coSyjm72y3MLiLJ2FGgBKzHDKK8NweIJYULppC5qlmBbgYyNWTulRr1GqK
	 7dtfokIt9o28NIeuh95LpzAnfZNQvfblrvAdgJLgyIUNSfPuMIZXwmb6PzLw0X3+3e2Bx
	 JoCJO5EkEr/SA1SVLtzZRWOxwKF4agTIZKkvbMwi9GeQo7B8cZVMj2ROtQ5mXRxE6zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8XOHJfhlH3wc/sqAlRGdknPsoLnsZr7v7XRfDuWyJ3U=;
	b=AWpFKxLOTHPVOxh3Gpc1OTEDn/0Pbu9GJAaNUCFA9cPNi9XyHPSojWT4lg74EYpZ3hTw
	 JxdoGnhWQzkpoqENxgDOc9pDggo3AHhaDPVmt+ekZ6xFX7EpHYWArX0I/3v9QHYU1DmVN
	 Gph4llJwHmu0xOfX0NVuXVfN8VyPWfa29sJIgipVMYRlFL72Puh+L0An1z4P1DxhodK+6
	 zr9EjPHtlaTF1OmqSiUQMQzcyE+1wBiz1eyGwCtDnr48kE4bGzGPb8Br+GgwHwTQ8sXC8
	 9gmCz9pXDtU9x4KAnkbPCiaQXt2W8/yvT/4v9X/CsnMepUJ10JMxkepRqtQT/VJ97UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6a3MD61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46480606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6a3MD61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3815A1F008AB;
	Tue, 10 Nov 2026 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339043;
	bh=8XOHJfhlH3wc/sqAlRGdknPsoLnsZr7v7XRfDuWyJ3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6a3MD61vqryYggQuJRcRXOgs9InW+eS6qEkUMwFIJFsU+P2q0w51OWb5yYWumUWh
	 gN+H5AZ7LTN8dcgwtEpwp3hLkyrUQmY52MX4oKVrJG/MNH3mvbKslYuiN+Q4R90PpE
	 hgfT61l44rWK7tO31cluTUjaoU1TUINhvn3e+pHypvCSgtQfZ8MOiCQk6iVCRcQd+P
	 BaqpuKgwigLCO7Hi1anNULVT/TKvE+NR6HBgOdvsKnaGj2+ecTLq7D8DeC5xCws17e
	 Yj0v719DW76U3P0CPlgChebsD80QykFLxL/M2OoQe14Z+B63QSd8VaulPa3WuX8cvZ
	 AQ+vGb92tamSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86/amd/pmf: Add AMDI0112 ACPI ID
Date: Tue, 10 Nov 2026 14:30:41 -0500
Message-ID: <20261110193008.3536115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053404-failed-6.6-325bcc126cf7@kernel.org>
References: <20261107053404-failed-6.6-325bcc126cf7@kernel.org>
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
[ sashal: Adjusted ACPI table context to insert AMDI0112 after AMDI0103 because the intervening upstream entries are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 78ed3ee22555d..19dbc189ee17d 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -342,6 +342,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0100", 0x100},
 	{"AMDI0102", 0},
 	{"AMDI0103", 0},
+	{"AMDI0112", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.53.0

