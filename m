Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542404;
	b=u87iZ7yuF6SZ4+AZF97iBHtsyceLt7HAm/MtAJ4JfOtc1RSEIk7IBEMjHmdL4ATQw30p
	 FF9LMkLjdsWoU3WYOE78yKyYjfqD7zp/Iu3T/Kw36gr9xfH5tlGD6MBS0ICUTcpV2RS1k
	 jA9fVl3Hg7aPpEKe8/DkClL8KyrOR5j8oWur8S2udGGnjzydcbkDgeXZVegzdKr+upZb3
	 LZDwWxupgenmXz+bz3jdwKQH9BuBR2O7HiUxAA2LkJA3ec+i/NIaSFfS+RVnPLbRGzR7q
	 qJTOzmu1vLrBjHpAirlDrFLkMgqqGBpBT3WHgDvCfgHZgbifZ7j/YO5YThFrmHqcfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542404;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VTfeZZUSpdFRfoIIBlf15XcWS696F3bp7k41siReJbc=;
	b=0iMzjbeo7ENjTL7lbI7srdG3k9ulDKFjiu8mJ74WGqf/O9eE9rAizz5rxQcYOh7SRSJO
	 ESjwnc9lSw0qzYlNK0icCBCb0xmQByL0YR+EsrLQT/5mklGQL2082SQw8+GHMgUeoAtpv
	 2XLK8TLdZBVFArqbYTimZhy5FnxnVT9NPfa2T9aUsoG6CiZ5LEw59UAA/X+O+OBfQzIxm
	 s83LjY38l5K1Czf/QAkDrM38+rkwpgoxZOtnyWEZ24uxlJcwODKTQmzMqSufi04GwQt5l
	 1a3C8iKlfOhol2ToAloOAxkwcdc/YwvXWC02PqQICwM1SBSIgeZyh0XDkJIwJ6wDFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/ZOfVYy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EAE606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/ZOfVYy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780CC1F000C4;
	Fri, 13 Nov 2026 04:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794542404;
	bh=VTfeZZUSpdFRfoIIBlf15XcWS696F3bp7k41siReJbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/ZOfVYyZR7lmJyp1Ge/hKeG23vup+TEDdm1upWe8MYO9TiMsWLc9h4q/ALd/9iks
	 r+WWPvl4f4YM/QAKqY6ytHbyXsIQEp+xVZuPssJpqhpGy8IUzcqFAxv+PVjCSPZZ8x
	 Fl+L5VIp9GE8zEFOLuiZAxjimWNhM4Zygbwdz1AYmKvf2sV9TBI7IebFWPiM8+Jz+Z
	 IXgkH4LW5HFMsjnUJ1eBX8W8dzCRgpt3d9xy1vHSUEVoiESXWCmF01IeJfHv7H61Mb
	 pD+HPK1nyKcEIFJJGP8NANostllUi+tl0ftNNNbsYtMAtsO+h5/CCzgo+kTiMCaPxU
	 DIerF5GlP7Fcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nvme: unregister when pr_register() is given a zero new key
Date: Thu, 12 Nov 2026 23:00:02 -0500
Message-ID: <20261113035945.1065258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201154-failed-6.6-a9d431124fb2@kernel.org>
References: <20261109201154-failed-6.6-a9d431124fb2@kernel.org>
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
[ sashal: changed old_key and new_key references to old and new to match the existing parameter names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 566a04290e550..a6e563adb7017 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -133,7 +133,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old,
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = old ? 2 : 0;
+	if (!new)
+		cdw10 = NVME_PR_REGISTER_ACT_UNREG;
+	else if (old)
+		cdw10 = NVME_PR_REGISTER_ACT_REPLACE;
+	else
+		cdw10 = NVME_PR_REGISTER_ACT_REG;
 	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
 	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
 	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
-- 
2.53.0

