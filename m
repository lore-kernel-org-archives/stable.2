Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC5395ACD
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830041; cv=none; b=q826nDDg0g8ImUY39I1KKZwVB2E+9joZl8L9V6OsusFjZsZLze1wYzVJBqWWfpj8BaoynzQLAodXIUVUxecBF/wb/h6gMVSa7RZHX7MxcLg4g/u4Glci6j7bwjV1qeVA9MxmBvjwzBMlKmPBnCQDOfWhhKLV4NyEYJ+hRvUK0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830041; c=relaxed/simple;
	bh=WcMUsweIRMFJ1t7hb9jFO2t1AqK0dQVjfi4DNxzZslY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1o2eV5YY9JTe0mwg4sQrRdzCSO8rGcwB0VgNQZEg/jxeTXhFIXwjqcuoLMDjJ/P1RvHvYRYYi/15JRzzJZLXsZaquOfmUtnzZv205Tl0DAt2ssm0GyTK5E9ZmufxfC6ShZawASr7As3QoMimfZX+YwCXJ1yO7cd/3neQ5R2R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1C11F00A3A;
	Thu, 23 Jul 2026 18:07:19 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <quic_mojha@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] remoteproc: qcom: fix sparse warnings
Date: Thu, 23 Jul 2026 14:07:15 -0400
Message-ID: <20260723180717.3431408-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723180717.3431408-1-sashal@kernel.org>
References: <2026072052-revenge-discount-456e@gregkh>
 <20260723180717.3431408-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <quic_mojha@quicinc.com>

[ Upstream commit 2554dd0ac362738f588ba073d8333eb9b14f9587 ]

This patch try to address below sparse warnings.

drivers/remoteproc/qcom_common.c:126:27: warning: restricted __le32 degrades to integer
drivers/remoteproc/qcom_common.c:133:32: warning: cast to restricted __le32
drivers/remoteproc/qcom_common.c:133:32: warning: cast from restricted __le64

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1675180866-16695-1-git-send-email-quic_mojha@quicinc.com
Stable-dep-of: ecf9fc18e62c ("remoteproc: qcom: Fix leak when custom dump_segments addition fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 7810f91d3080a2..abf66c6876df4f 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -123,14 +123,14 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 
 	for (i = 0; i < seg_cnt; i++) {
 		memcpy_fromio(&region, ptr + i, sizeof(region));
-		if (region.valid == MD_REGION_VALID) {
+		if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
 			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
 			if (!name) {
 				iounmap(ptr);
 				return -ENOMEM;
 			}
 			da = le64_to_cpu(region.address);
-			size = le32_to_cpu(region.size);
+			size = le64_to_cpu(region.size);
 			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
 		}
 	}
-- 
2.53.0

