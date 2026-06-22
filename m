Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC2313545;
	Mon, 22 Jun 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142953; cv=none; b=kPEJDYMS/ebAlD5DghPGuEElrl5LNETrap7sRiBdx1C4cWjym0xZkRqS9Pdegiy+vD5ALAJWG52DUu+8u8sSUDrL2/0pUxGZTDMqnnIlAVDD6uwMwwr1LeVU0FFoUBgkKt45rZir5M42LbpamQ6W++TiO1eAzzlpTvMN1Eh2h1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142953; c=relaxed/simple;
	bh=w0CF9D7qA0+TFxzuaf5uEQDES1j7coKNW/VOdu7PohA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iG0bfkZJ3R5MDW9SFxoH4hilCIeFL4X7FUly9/VYa1eFiso4tWBfqa1P9Xxe3oTzeF3bHWjmdU9yoHCHqhtLM2KsEVanbCrEWr2Qjm/QF2tTZmuJdduVVBW1OOwZHVHD7nAvDw4rFyFJEuwfIFyAcJTxHHFcX/uqGnxsnVG+7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=qU7OXhdU; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="qU7OXhdU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782142949;
	bh=8HvyzZuawri13YB92T7bVnVD98DHY25m1Z90Cfn8Rdk=;
	h=From:To:Cc:Subject:Date:From;
	b=qU7OXhdUfBzV1ZdAqfTngw/0Tt1PJ98cDMYL326oOpbGQ3+D9EKirxvRLaRdF3G/3
	 X78z75f/wognEhYEARNF72oK/8QQXh8ACuWz6VIs/9/toMgh7aQIWWO4GGyzjd/X6S
	 1KAOPtevmTVRz0xexT+VPKHp1f4EqgB5RolNo2KU=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gkXWn4tnxz10x5;
	Mon, 22 Jun 2026 15:42:29 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gkXWn0tthz10x8;
	Mon, 22 Jun 2026 15:42:29 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matteo Croce <mcroce@microsoft.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH] reboot: keep parsed reboot CPU in range
Date: Mon, 22 Jun 2026 15:42:16 +0000
Message-ID: <20260622154216.10064-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reboot=s... parses the CPU number with simple_strtoul(), but stores
it in an int before checking it against num_possible_cpus(). Very
large values can wrap negative and bypass the range check, leaving
reboot_cpu invalid for migrate_to_reboot_cpu().

Keep the parsed value unsigned until after the range check.

Fixes: f9a90501faac ("reboot: refactor and comment the cpu selection code")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/reboot.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..a1ad6047b14a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1134,12 +1134,11 @@ static int __init reboot_setup(char *str)
 			str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
 
 			if (isdigit(str[0])) {
-				int cpu = simple_strtoul(str, NULL, 0);
+				unsigned long cpu = simple_strtoul(str, NULL, 0);
 
 				if (cpu >= num_possible_cpus()) {
-					pr_err("Ignoring the CPU number in reboot= option. "
-					"CPU %d exceeds possible cpu number %d\n",
-					cpu, num_possible_cpus());
+					pr_err("Ignoring the CPU number in reboot= option. CPU %lu exceeds possible cpu number %u\n",
+					       cpu, num_possible_cpus());
 					break;
 				}
 				reboot_cpu = cpu;
-- 
2.53.0

