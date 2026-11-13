Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597044;
	b=llccZtq/Mh92F1YxnY05XaDc6qq86XEtHysQ0duG/Teh86RpJ9kxNSqttfdlfw5Gxxb9
	 fKYFkDsf+hA64iNSRNdToHYOtPMy8lLQ0abDw1lw06DlGa2GCGwb+2e/x7K+36tpHpUEr
	 9dykyijfA/BS2SSsbkPxfexd/rvZAL3Mx7XldnCgE1BcPMkDPPBnFbOYVGu9yWz+d1Y0m
	 m8HW7Vyg6X3kJGCIjqS3jiPpkuspFPBq6hzAmRhHXWuhaVwdvOFW24p70Cd6ex3XPDbiE
	 Xag5R0xMYkoXs68mWwDLkLJh/QvAkfXijJlXCA5mcrTvo2ScDSOY+bhvVGC5tsUA44Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/xF4JAFPrHoD4B7tBMpeul5O4SWAvzuqRHJ5BG6SXgg=;
	b=UWReSnbvbQCF3b/jysW94rHk8K281MX12mLY9HtWbBParLy9X5Itr1ypyUeqVeI6unMD
	 Jg/SwEzOtR85674J8eYicaYvpo6roH4moT2gXccIkpjKC/xNgrjwpDDvhiITuXxUKNcXU
	 1aKxodgPVekRogpkmHNFd6YIscy0MlZ0DkS/Pb5fzFV5BVkV8CFUvFhc5SKMmGhTp+IP9
	 UQv9ChfBUuEIRCIZeZIEMwtb9AewPi5vCEz3hsNyxl9jt/lt6kQW20KeF7+fWhvupvLLf
	 xPwU9cFHq54X3xEUKPeqzjn3GhIxY+OF13bDXCtMWx6lciwNAWXvh9ijsz9Xk1CQNjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOsgtZi3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD939606A885
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOsgtZi3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308391F000C5;
	Fri, 13 Nov 2026 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597044;
	bh=/xF4JAFPrHoD4B7tBMpeul5O4SWAvzuqRHJ5BG6SXgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOsgtZi33Zf0O5IpsK584aW9+G8ZAvrXQoqqpIXy6V9hhG/ZBTmi0pSw4stEDQjJS
	 JCbhBObXPsNntbDC55xfoOCpLo/NmtT9GfS4OMqnEQV0ZwUzFQhmFT9T4DO5yO/EOh
	 N8pz9BLRHy36j8m91P+4IBODfRhwb8bC99LQNNEmKRlEArTOdv4mEkMK5Nvt0p/JVD
	 X8jm8kvEGgsxWyZzC/UAhd8adjO+BiXEk49Ynfh35PAHdSJUL/mUdS93YCvWH+dMVa
	 E9VazEzVoQkSRs46bcIfdPdyAfUckxhl20E56FO+t9OW0nQUc2Jy1WIN5KaFwmVMlx
	 BoOmRBLb2yXKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nvme: unregister when pr_register() is given a zero new key
Date: Fri, 13 Nov 2026 14:10:43 -0500
Message-ID: <20261113160253.1860258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202641-failed-5.10-a9d431124fb2@kernel.org>
References: <20261109202641-failed-5.10-a9d431124fb2@kernel.org>
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
[ sashal: adapted nvme_pr_register() to use the existing old/new parameter names and numeric action codes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11d7ef36f9670..70784bbf21dc1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2286,7 +2286,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old,
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

