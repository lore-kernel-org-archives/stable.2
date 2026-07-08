Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32404292B54
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504116; cv=none; b=tex5KXRrhqMm83hMHS1E4bCvVMVK4oCCt6X44occp+WebeN58jY9dd3PFeFhXqa5qWwd/g7nHkuobztBwzobp44FIgHyl87woMoFBFzajUGqMbxRAdhdCCHJ7CCAGC0jgjzvSjVLJCMYBOicb/VLZdgUZKTs+C5V/895b9dArVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504116; c=relaxed/simple;
	bh=/wchz7OqFpIayMSWzIlyXQ6ouE64L/rQXOUfyIKLHoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=se90Np35bMhs/VPZ4CNcBVv5HE3XZP0m4GfjpENVOsyEJZqZS6Zm+5tB/xsjQs8Yb7oA1M/cXM+0UDH4vdLcRNRtNl+cnDLig+UoZ6daLBVPsa7UBc2PyTGPoBwf4BXUONfqTXLOdqdzDjiqtHUHeinNK0WG2CX/NeaOnXzcm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cMGKY6or; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cMGKY6or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504071;
	bh=oN3SGYgdd7AW9uyxNh2x0zsb5yfRBIq0qWkD+P1vfvc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cMGKY6orm0WNCQDx7zJR72Oy4hA4Q4jvIK4YpuNx6dLbLy5eKPyP1E/nGD3zCRmmB
	 Zs261K+2opJvQSGGyShKL6KHZv0rqYpWEWl2bCesSjw9GTve5S+D1V87S7ckpR7TkH
	 qJMrAQfvPNg43yhaJYFHh9URr5kjxyEcZculhvTk=
X-QQ-mid: zesmtpgz3t1783504052t346ac606
X-QQ-Originating-IP: DptUHW1WdrQu4JGDpUH17SxJSgzszZ+8MS4YIA8a7as=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:47:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9151960503526144487
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 01/11] net: team: rename team to team_core for linking
Date: Wed,  8 Jul 2026 17:47:01 +0800
Message-Id: <20260708094710.27047-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MpO6L0LObisWXA0XFTNJlXO9k/mB1UT9SEXGFxfTBYnmexdUjB0o+XqT
	6o7Yd7ViZb+CCHlbO0+6dEcuArT/7KqdqMqkqtBH2udiUJQza+dDbS1hHDSwdqqRwFAkHdl
	rTRyu0M75HgLD+U3dNUKe+qVzGd8ub7iVXQlOxefuOOiz1hNj8HBq+s+nGk81upkVUqDcgz
	kAH7wKACOGKLj3O8Eo8A9gKFTjh2FMwYF8UoZ+wbJa7d2ZyFhVzNa7SFyVmJRBpRAxjju72
	jrJlQqV1pp+JMMx1YMioWlP5DlsHWP1ufzrTbI54Ljy0+zgIgBZG84e5BXkNqqwy3krIDF7
	K7t+kZdqyyVI4fMJb6OEUjQfJ5qR2N5MwUCq1DPihzwvnYtOUN8GjevRHDvYYlN3BelRavN
	n7LPCnU2vkINIJN2qIGiHx+13c3XB7RfW4+np7DVg3fQ4WtI9bk8N06vEfDi4OvAjJlWi+Y
	Bt+2fCcEZ1kQgxAyI2wwsbJZtSAe1d5Cqdk9BkjvmdmfEnYjRsCAvFNJ5BTJUHrwmXh6XbB
	oayM8KI04F3s56sjJOu8fK/aE42sdTcNXlHLfq7a4g9yJZhbEKjDgG9lc93WwbrZrfVG/m8
	7hHY9j3qfEeHInDqBDg+Pv767KKPm5KZfu6DyZGnH6O4Q5QDtPjT8lO2mTjHStilqfL4TNG
	VKRYxGgamAV7ZqighfCLmEknwZYSCGsShMC2h5IkhQKibNf8esd1anm3xE2V4XGd9aoQ/Ax
	550IP+I79wFk3C4EVPRhdhsJ1uYkk8kkanPl7GtgR+f+a2tTLvpBr9ymZM5uS5cWK7k1ysP
	w8HsELNezgVXvOUheH2cCbeLeZ8mEv9wAh6z02AWMTOxlGeIO/uQpTH7JdYN+x/DqdGn6qt
	crdBRaICKdHiGXtQMPTPl0z9DhP744Il00f8IFUfyQrFoLEtQwim594BFXgxCD1NuKqO6H7
	AlO2aoaH+rIZnS+HoySTp/wyY8mhV3NS2YW+KanohKH2rZp7+D3mUzxjxlQa/VixPnQFCyB
	zHsfVdncIcnQz4sU5jbL/Wy7zNLhieKA/v17A+jbm/uog4QpSvdUf9mZzr6JDbOKfATzijI
	NOWUWphkyyWLzKTl9ArOFU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Hangbin Liu <liuhangbin@gmail.com>

Similar with commit 08d323234d10 ("net: fou: rename the source for linking"),
We'll need to link two objects together to form the team module.
This means the source can't be called team, the build system expects
team.o to be the combined object.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240401031004.1159713-3-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit a0393e3e3ddbb177b25f0a978c72f5efe942fe7d)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/team/Makefile                | 1 +
 drivers/net/team/{team.c => team_core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/net/team/{team.c => team_core.c} (100%)

diff --git a/drivers/net/team/Makefile b/drivers/net/team/Makefile
index f582d81a50911..244db32c1060e 100644
--- a/drivers/net/team/Makefile
+++ b/drivers/net/team/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the network team driver
 #
 
+team-y:= team_core.o
 obj-$(CONFIG_NET_TEAM) += team.o
 obj-$(CONFIG_NET_TEAM_MODE_BROADCAST) += team_mode_broadcast.o
 obj-$(CONFIG_NET_TEAM_MODE_ROUNDROBIN) += team_mode_roundrobin.o
diff --git a/drivers/net/team/team.c b/drivers/net/team/team_core.c
similarity index 100%
rename from drivers/net/team/team.c
rename to drivers/net/team/team_core.c
-- 
2.30.2

