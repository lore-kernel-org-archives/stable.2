Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12063921F0;
	Wed, 26 Aug 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724659; cv=none; b=GQkHEcUacAUn7IlgewEMuID7sFnuWryp731dl0JgSbKXzhvGD0MDdBxPmkzbpKDe6659ArdVENUsD2XdpHRrEzKs9dat+uyNJJwheKE6aZU9io6p8NmVjdGYOUWaf4/RP/EQ3TOqS/ee+I5RU/VsywWNakuodb/idWMNOCrE8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724659; c=relaxed/simple;
	bh=ujK4/NiuUC9QhHBjBN0d36zpXuFTlzTDNWFU3djNxEM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ne2qsbUZBkaMy1WzZVfn9yGlylmoYXCO0int+tLmffasG2sXZU2amcjEi1ehwGUwZKSV8MAPRxQ9hWcydPCVRvEzV3Knhs+CWFyLJvnvpIRQQt36l2EPfp6nhYhpb2JKCECnWTtspijTPkKtg3bESrwz8IT/+71FDWwepyMezzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=S7ieZpMU; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S7ieZpMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787724651; bh=Yt08dDNIfkLzpE1A0YPNqRX/RvvI2SYtuHSEmjrkRhM=;
	h=From:To:Cc:Subject:Date;
	b=S7ieZpMUt2zupqpl/37TqFDnRhG+AmgJc9eIJDzW/aktQTGxD5j4u3vh/bvc2KwoE
	 NXNFd4gHgfTShB0ZfP3FzXtRj9FvyVZSV+mbWpt8cywA/jfK0/8kXUXZ+lWFnSLyit
	 zxyXhZorR1yxz8UQg5YMNsDD6h/y0IcJLqLTkFfM=
Received: from wang-VMware-Virtual-Platform.localdomain ([223.104.134.142])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2B18CC3A; Wed, 26 Aug 2026 14:10:49 +0800
X-QQ-mid: xmsmtpt1787724649tb6f34k04
Message-ID: <tencent_0D48FFD2E604EA5FED532748CCAAD5139905@qq.com>
X-QQ-XMAILINFO: NPa98HB0c72N6FWbEn+EAaLCYJU1v1bqaMPmZvCoMC97FhWh9SJM83WPIbcjgp
	 PM94bQ5yuUS4iXjwdlu95r/kSSzF3pIcwtMF42Rv+Hi++LOxYxqjCwcT14iyxaM5+ACKZsETCz93
	 zMVphwBRz238hhL0d9XYKomBWEwRBoTw3bUKebMB7uXhqajfE4tW8tf3awP9MN3xmTdcE1TAU8P7
	 dJYbbltKi+PWNonG78DYWFs6GqGqjxltHqQJaAHN+BZ4dWneGSJlo7nxe+HjKA424S5h0Fybw/6a
	 0Pc7ZG05vx+G0OzzCbZQZyWm9lMxTo/ICk9tyKljzB+8uUFyYfMAVbpF5BkRm4nxBFCTBxf+dgFG
	 ldplNO+2lC668LOV5Z4ggI7Wlop1C5OH/VS6OGO1Et9JMhgtXogMg8OpaEHgprYTpVU3rnBHsF7Z
	 5/YZNLg+tJ9hCDm2VaC4fDMa910aNiPV52BqEMJVjLQNp0uqJ+PeN/Hz1Hvka2n/dfY1xSaTgu24
	 eUCx40Xc7fpJyJMM2SMq8eEFWLw112tC0f00rtZ3N1YVPht0JXMM9eWk4hKY6ONhe06BXcboZFu/
	 PIufj80ggEuZFIKnkrs0P9EeVLO7u578FzraWvH44W8p2AWzetcyeyCT3toZLMNxQIVG1ZW8HLlx
	 GVkKkW3zAyIDErWJbD52AeUefVHUziYoQh4I5KdYIdoYPHt0jVk0SNcxml94A06NgDe52mmd6PuO
	 IBtvEsHwy7TmXmtD2iIJh9xWiuhJ3wDq3ePMKh7AqzgxUsW0HoV5LBMg491g8RQujc1PaqVRU6k7
	 hCDe/8jnaXrCd0Gv4IHa6qU2bSGcyoyHxhlhH/FFVH02k5t05sun6l/FejRFnBWQJeZUCLL5umqW
	 hZbmARsCkRCp2giR9Gs0ut6EaIHa58/DlNEB97q046Sh5hcpJ8v5ZXi3l4QIfBdk/EfCJ94nMeOT
	 gG2NPxQPm1gN9rDT7Ry3JzDNbrKNF8BSU2AO+uRKjxyHBWvsxI2+PdnSs2CN4/k7g6Jg+sQXdmV/
	 n9eZwsQyD0Z+ApTkvKql37cwPIdHtDR5ta9nZvGg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Yingjie Wang <1075151112@qq.com>
Subject: [PATCH] ipc: mqueue: reject negative queues_max values
Date: Wed, 26 Aug 2026 14:10:40 +0800
X-OQ-MSGID: <20260826061040.238673-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs.mqueue.queues_max is documented as the maximum number of POSIX
message queues. Its sysctl entry uses proc_dointvec, but its backing
field, ipc_namespace::mq_queues_max, is unsigned int.

Consequently, writing -1 is accepted and reads back as -1, while the
stored bit pattern is UINT_MAX. The admission check in do_mq_open()
then permits an effectively unbounded number of queues for callers
without CAP_SYS_RESOURCE, rather than enforcing the configured maximum.

Use proc_dointvec_minmax with a zero lower bound. This rejects negative
input while retaining the previously accepted nonnegative signed-int
range, including zero.

The issue was reproduced on 6.12.80 and 6.12.105. With queues_max=1,
an unprivileged workload could create one of three requested queues and
the rest failed with ENOSPC. With queues_max=-1, all three creations
succeeded. After this change, writing -1 fails with EINVAL, and the
finite and zero-value controls retain their prior behavior.

Signed-off-by: Yingjie Wang <1075151112@qq.com>
Fixes: bdc8e5f85f9a ("namespaces: mqueue namespace: adapt sysctl")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
---
 ipc/mq_sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 0dd12e1..7c4f9d0 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -26,7 +26,8 @@ static const struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_queues_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "msg_max",
-- 
2.43.0

