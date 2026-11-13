Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581376;
	b=wlBlLNCLlUfUORThUKk+fSXQvsKOZYr+fAmelT3Jsg/o5MgmBpnSH6GxuTGlZbKU2tiu
	 ftGsna2lyNBUu1K8M025WOkTM03Kgu/xSAAK/JxdFSiKtSIvfBa1qQx1VKHlqF2XUCIVY
	 3JMmI7UIV6CaEDRb/VSQa5CNNKtcTdOhWGYoZiXF145er4LiDWnlLf8sU6MMnCtKUZtlc
	 C7MhnEVCI5JGO4z92otJaCVGHS8FG31Q0PfPAWnAEAtq2aGppXOMkpj6bQ4Ii7THgiJfG
	 ay/iNjtCy/P6969qH5s1QfmuVBPyBDrsIAhxf2nmBazyIR/XFUIJUQnPJO8QPPl0o0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=srK0w/cmw2mJNexBx8hSGmi5p18Ny6faLXC3JZaczrk=;
	b=REHzMg3p6sRAjc/yxQkb+NISUeSAwHARgWR5ShHSOYTwUXYCzUZmamm2hTdQ1ddg/wyk
	 Rr6FYLdoTm5tYqhnBd7z1Pb2KgBlOOM44VEqpRez7x1RZvlbRAiaFw9WIJ8SjdmpMG8fV
	 kPD1VVuyJFRWgX8yS7+LCT6XQtiT6SebJAQuPenPdQvQhMQGLFk3yQU39uxtUOOlbB9ex
	 yzPupLO33//WNXu7ccsvNgLdH7+qR5XlRoR2VkkFrmlIybCth9bZAU5PLjtFuhFK9reAE
	 YApv74ecygVWnCOUyGiunChGjmlbfio4hUmhNsA2AoZN/Nj7XXpAPCiRnSBjuYzoahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5itCGuP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7732606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5itCGuP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9FF1F000C4;
	Fri, 13 Nov 2026 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581376;
	bh=srK0w/cmw2mJNexBx8hSGmi5p18Ny6faLXC3JZaczrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5itCGuPApvbMz2z1QrRFJB2AXHYWGgChwJMfJqum7x4Ta+hOuNFdX1BSGZuKExxF
	 mzch6O6Jg86AejV2A5L29lFFxt9OVe9JYJbVs6Bf4m3tEBSpbbwM4AqflzS2o6Rx74
	 +yoUAFDnmkY4BxPMuSsXoAQ1b8MmgZoixAs5NqHhvGu60hZiONDJDq1CVic+VCy+iZ
	 uTtTk4dIf5nyKfVYzMb70pVUtNS/TbDvoQB0V3CGtigffAMfTIY43TTHvZ7CUfzRrx
	 0ne4sP51V0nk+z6Qhznlropf9G3CZT4OG24SruCgub2wVlcOuj22JsSCzxia/vaGTO
	 l/AwPbJeD+awA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nvme: unregister when pr_register() is given a zero new key
Date: Fri, 13 Nov 2026 09:49:34 -0500
Message-ID: <20261113144740.1216543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202150-failed-5.15-a9d431124fb2@kernel.org>
References: <20261109202150-failed-5.15-a9d431124fb2@kernel.org>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit a9d431124fb2e58215daf0299d6fcf47bbc2d6b1 ]

The block layer PR API defines a zero new_key in pr_register() as
unregistering old_key. nvme_pr_register() sends Replace Reservation
Key with a zero NRKEY instead. The host stays registered with key 0,
and its next registration with another key fails with Reservation
Conflict.

The pNFS SCSI layout client unregisters this way at umount. A later
mount cannot register and sends all I/O through the metadata server.

Send Unregister Reservation Key when new_key is zero.

Fixes: 1d277a637a71 ("NVMe: Add persistent reservation ops")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: adapted reservation action selection to use numeric codes and the existing old/new parameter names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae98572008370..9d6cb96f70784 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2089,7 +2089,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old,
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = old ? 2 : 0;
+	if (!new)
+		cdw10 = 1;
+	else if (old)
+		cdw10 = 2;
+	else
+		cdw10 = 0;
 	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
 	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
 	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
-- 
2.53.0

