Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB863A7F72
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602022; cv=none; b=hO4CImKdreNtKyQHyfv/iDpY/Tjf2O3omfPnZ5cnQmgXJj60+tAzSLAbznUONbsRz/cBGCN/f8/heSJy+f/VJqMztq+Yae207KvbIiWjt7qDVN3wL5FmsqqNejGvS9nNZKNSMi8Al3WyBY0F+98seegqRurhWxNw3kGZkgS4SXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602022; c=relaxed/simple;
	bh=/4xkadzyMpNBPh7LtuPXdwwOr29e8GS7U/YbxymPKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8RC1VpvWpGFPsUQ5HXczIIinjzpQNuQoz/iVPhD3BLgQEnip8PAWafDR+VXcuXOP/oGEY1OpJa6wnAqN7ZvSMnRyplvqyTq7RYRDzM5BHuvyFkyUCSBkg3tUqNNiPOWZPzDyIbMAKDSQF6n+n29OD3p36dadJpqZdLAUtsRoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S33BFZ03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S33BFZ03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100F71F00898;
	Thu,  4 Jun 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602021;
	bh=FdtEjzAPyzaRGmptOScglPtFP6cN3p8luNKvRDfaCZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S33BFZ03hNPbei+PYI00eLFMIZhAAtBAisj1JCw9Amv+gsCyRhjeET8KjkAXqfi/m
	 pcuNElpS3VrWPuXXQnG9VnG+2xQRGupX4q10R8J0Cf902iOJmDz0FXrbEO8DV6uxcd
	 t6EJh/Rn9vG4kiWLh+BKKfOZEMAFFSTAUhe3oYrHp1pME8OpMU/9veWFGJL76WA/Oy
	 nk2b/8yBfo5Yi7wo/XB+GJfl2+ai5B8fNO19p8El9zDInbaBXGSwpFdLBAB+yA76Sx
	 LRnwQMj1YB9f4m1/V5OO7JQDxpKGOUwSJxt+xvcVuKnmr9ziHOcR5JJv83bLJUY0/9
	 byU2wP45JbGog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 15:40:17 -0400
Message-ID: <20260604194017.889785-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604194017.889785-1-sashal@kernel.org>
References: <2026060457-coastal-washable-cab4@gregkh>
 <20260604194017.889785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 5aba4f94b225617a55fed442a70329b2ee19c0a5 ]

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a0a1f89deba913..26216154c8591b 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -257,7 +257,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
-- 
2.53.0

