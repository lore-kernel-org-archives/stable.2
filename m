Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12024E4C6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447328; cv=none; b=jueJ3B2RQTn06M1vgITovcvctXdkB4kud3uRisEBu07bKycNi+aNW6cmCQZAKIrs/XyLq60+NeKBCh6K3FvchNZaTPEPoi6cZX3pXpdrS6EjaEKGuyHrqn64/lSjeQs6vrPohR3kEDdoSFo3ecuoN4q7INSAS8AN65HkkRmST9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447328; c=relaxed/simple;
	bh=b0hwOyHZBQXBuXPleLjrOyffa6xRckVe1PzWDbLAWrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XozGO5fMjEiCcpDczJjpifP4+672OMvvQVttI2113RVLw5B2miA4XLTCcn4ujUWjeBheFFIdfxYEudjGUlR542SiwWoQKHV8vUlTir3PftvJe2EBXoJCGYm2tK46+jm6cZa1BsfOytxiZG/HqjkBE3iWoBgfU5AiXAoFTRWKoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e9yBbd5h; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e9yBbd5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447282;
	bh=ZO0vYdG8+zInot9nuVfLo2AsAw1+BulTmqCbYLPKuCY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=e9yBbd5ho0S3UJ+9+64Zin8wr9O7ardhywAIY3tngtcuEaW5ICfgXGmix3tSh443M
	 amiR+nJLdohGVvUD1oiZzWUO6yBTXL9+sVRWkyJQRdUjL6BWlTpw1usmat6JSn1HMf
	 k00JsUuLXiyl65gbHwFgK5kxkQpzvJ4yWmIjC01w=
X-QQ-mid: zesmtpgz1t1782447263t0acdc1f9
X-QQ-Originating-IP: PF6cpuBJGM44mDSwuuqFk91hSuRF5oj+Z8gGBBuAnvQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4374435766956898301
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 1/8] file: add fput() cleanup helper
Date: Fri, 26 Jun 2026 12:13:56 +0800
Message-Id: <20260626041403.85968-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OcJU98wqb2Ke9iBTwsHPFiCiFNJHuyzXfRbLZac/qSrzsd9+M9PqSoH2
	OpR/Sn7MAk3847uiT3snYfabC4POn4CnawHsrrR09gPvnXLEYqUHCa4DEZt1lyJ3z6A2tHU
	IrG6Ai0niX5nRi97DDNh+HVy9hByGcXyPDnl4RdLv0v+5oIu+d1wLN8PnNwC/ILGfAiGv/P
	XQpQ4n9H+ROKpLN+mqkAAAbcvYEQbQQRdOm8ivKh2rT2H7sEv/BdTQz5WAyoc04zIbgQEWk
	M6HoeKiQJDQu8TFDmagUAQlxKR5KoO8Erl8fqwsBEUnkFcHqNPvc+lNk4LFdTRi1fXp6A+s
	N9U/2fRXSO93LieCtgYN6Doyyx0vsdRebVearR1chVDEEyJ+348IcULH8p7yESHN8m2i91+
	lPv1xT1oRI8it9RSRFFXMEe+Mb9kA0KhuAJmodHCxFeXdbQkGDyiiSfTTDJGaQ9Ply29heH
	Iu9y13sGg3xc6huq0iTlkUQtH4FzjsShLc/5mUdDNqmj+y6AEIjapKiUbG6Mns5K8FURMmS
	YKv2lsoYuXoX7GDfuVH5qAqD6xsSv4nn+W86KWhgLrIkxaK70grDOP3MmyrQJMsOOz7X6sN
	empmyorrRNLABObSbP/6+gON/MTsstU3pZoudpWwzRuIeDXw9ZEVkKN2SVCulc6Q0ROUnEu
	2mxDooC8ILegogK+25umcpFpTCVRggDGFJJbMJ9yVeOP0vGXsS81pwbfFBD/SbE1VEP5oqy
	pAywNe3RpaEtyRYBKtB7l9FZkdCYTx4ugCVmU2Y5jxer6x/7/AyE4UEgIo14oWxAR5NA67A
	guHRY5cprLP+7utF6PvyG32BaNkQzGDdru2QPuRqQ9IBbd+7L/Swmwe54oMVOqMJm8PZX8G
	dEG10rvLXy3gm6OWH4+c5PwwBKmRuIQAFp+SHyjSIq9P581JkYIg3WKBLwocwNMwIHrrPGT
	QtS4vuTQrzawLpFYDcHgoR4uykGoYiPKWohW1WiBEMXkN2Ebd+taWDFI0ehzcQfjY0NT5Rn
	OgVbQ9YAkTQwRhx+NXZs7gseMbhgDEAjIAOubLpWkG4gBYevQMEXnNfpjAO+JRW/YJVlI2W
	3HGD4p+h8pZ6RKHFIerX8c97ovaNSVFu//8aX2ve6o3
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 257b1c2c78c25643526609dee0c15f1544eb3252 ]

Add a simple helper to put a file reference.

Link: https://lore.kernel.org/r/20240719-work-mount-namespace-v1-4-834113cab0d2@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit 257b1c2c78c25643526609dee0c15f1544eb3252)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/file.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6e9099d293436..221ba0888107a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 #include <linux/errno.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 
 struct file;
 
@@ -93,6 +94,7 @@ extern void put_unused_fd(unsigned int fd);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
+DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-- 
2.30.2

