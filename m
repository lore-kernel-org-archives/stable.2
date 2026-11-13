Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575181;
	b=i0rsLmAAl2ZAGeapp5si4+D2blkFDAuwZ87hRj7YTGqLCY8k0SDq9Ixk9dab3WsfH4ip
	 cOl9nM3G4omkzBiRgd0eQ8KYN0KpCunThOfN0/4UsD2S6FoXmU2fAzLsbLI2XU3mFQpET
	 JcY9M0uFvlo65hgiFsVnFxir1RnI2U+e898Xnbo3XtB7rbhBMAzDiVTJnAk//eZCwn3BQ
	 SQDEQ+H9TCYWFJ76LnBGrW7jGmP38OahFm1k4ezpR2zU5i4mPs2fft/yydDFKOsDl57ok
	 31edMKIQf6LeAwxsanQqcOaMJtPc/r46MeAbjIdG9dvg9sR4N/HQw1jzqfEDD7myMRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z4mJF56qyZ7IAtpB06E6YWQ7/rPNPa+Fwwhib6TSnN0=;
	b=4eRbW4pq7n1Qh+ysRD4G1Bovrc59WnaaMNBRkX1Q5se0QVq64btHFi9bdtkRcgeUtvm5
	 Xkg94TCMyEiRQ/SLBGMCf0wj7WgAi93g+zZ+Zl38a2VXNMusgukLQlsFAS8Q8jF2f1smz
	 Mht3+CvnnXUCuzrfztDS4PvY8k+E51RifLjLmGziiWpdTynNLHSSj4DfcC179yQbO/anF
	 xOGCQefCZty6DyWXhOiNvaN35misJ9pMnEC3G1mBir0cuJtYlHAP7tXaJmI0JCsetcC4q
	 Fr0/h4zWWVSmhEx7RmsEAlhWoee/JtsebUdx62EVNJWo0tLqd0l+wkaNDy3AqDDBV7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiQLVc6W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27F606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiQLVc6W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6671F000C4;
	Fri, 13 Nov 2026 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575181;
	bh=Z4mJF56qyZ7IAtpB06E6YWQ7/rPNPa+Fwwhib6TSnN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiQLVc6WLSvnFENuBMRRnXMLg5jxyb3xHmBxlMqAdDJCxeIG8onv/SKBQsytwZpnq
	 uvLIwnKsGTU+wxbcOtEYAR24yBtfOiLHnrv0JX22PbDpNauC9n0qWAJc+o0JrMSkEt
	 qCMtCLoi9i371xVofaDcNYjv8f6eCPdpfgAxxiHFl27U1+omiH0/hH1FnSEHB2vnf5
	 L2dyRduEEt+vfIQ/6ACQAazMaOxBPBYeKMDJO8/1uShm5TzWZ/dk1ejKuq5jxftfm7
	 0+cV/0h+oohfE+oXjnIe8eGDga3T0FMDXji7g37jNSOHcs6N//to+FZv0KyG1Xtv4x
	 8pxYYR50EJVKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nvme: unregister when pr_register() is given a zero new key
Date: Fri, 13 Nov 2026 08:06:19 -0500
Message-ID: <20261113130521.1087085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201627-failed-6.1-a9d431124fb2@kernel.org>
References: <20261109201627-failed-6.1-a9d431124fb2@kernel.org>
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
[ sashal: adapted the change to the existing nvme_pr_register() implementation using numeric values for unavailable reservation-action constants ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 61a34581ca70a..d3f4fd67a0ec7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2236,7 +2236,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old,
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

