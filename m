Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD341D202
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830370; cv=none; b=DuFCPN73AfA/zjAr5XosHlwsDxQt5UOGfTi8BskYhLgDT2wWznwE3gd3xJyOl7SVu4Xz30hJKwGqq73qrF8OGMr43Pgj2i2z4G2OzjEQXwTf+X/VsVpt9KQjON8PJq3vZC3qVjEaE3hqpM9HC65U5xVahdqYEEZGTFERzL8dwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830370; c=relaxed/simple;
	bh=u/DdGpOIlKnTXpsPJIrt8ZAm4hJfB5V9dK9ZJXLZSEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doiRssjE4a/VGlQXuJxohiHMKbHqZG9O2y1FNXx84A+9gFg3ige852EVkxvRnmRyBU/pN/zeZTAFu0wBQRSES4Jl6Cd3Ef7qAP2N0S6+7SCEbxK0nafYwPzkMFpI7pQa8KyYN+uYZoVQnQLwD6HJk+IafSE3LAVoDoO9V05axM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E068D1F000E9;
	Thu, 23 Jul 2026 18:12:46 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <quic_mojha@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] remoteproc: qcom: replace kstrdup with kstrndup
Date: Thu, 23 Jul 2026 14:12:39 -0400
Message-ID: <20260723181242.3433785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072052-islamic-scorecard-54c2@gregkh>
References: <2026072052-islamic-scorecard-54c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <quic_mojha@quicinc.com>

[ Upstream commit 9d5b9ad97f83b2390a6006eeb5ae5e48ec4298ce ]

Since, there is no guarantee that region.name will be 0-terminated
from the firmware side, replace kstrdup with kstrndup.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1676383691-29738-1-git-send-email-quic_mojha@quicinc.com
Stable-dep-of: ecf9fc18e62c ("remoteproc: qcom: Fix leak when custom dump_segments addition fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c9eafa1e..5d49d1e76f6a89 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -124,7 +124,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 	for (i = 0; i < seg_cnt; i++) {
 		memcpy_fromio(&region, ptr + i, sizeof(region));
 		if (region.valid == MD_REGION_VALID) {
-			name = kstrdup(region.name, GFP_KERNEL);
+			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
 			if (!name) {
 				iounmap(ptr);
 				return -ENOMEM;
-- 
2.53.0

