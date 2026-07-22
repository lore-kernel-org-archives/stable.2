Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0798220F2A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680039; cv=none; b=tmuRcvjWmPQAizBaEJYA25mlcwDrCl5meHxLFw4IpMoF3ZVEUj5VsTVkwQ3RP72Sd8N0QPw5UcZm5cLwl1S0b8Fv+RH5mrh738QV5+SC80ANAzZDWgNVFaOCQCxRCKIecc3TfEH1rWV6vXeERlv+6l1a9R4BuBktZAKrHu4TI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680039; c=relaxed/simple;
	bh=umvdl0QFLj9ed/TG7sYgUiBcbWbeUeTO9V/esPRot90=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LK+zvarNOMziEodl4y2AgUWlIkMgPaRC5BMVekS45TuTqcGLsYd6Z3yTBtvUC/ydVe8cL42HOSWdBr2Ixz7I1Eem4fRQFN8kGiByV8kvbZPDsSQEjb9oc9/lvfg7svgrgN/HDXYR1dCggr/D5BspFk1xmNab9jdBvXsLcp04bPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pmJ29J+3; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pmJ29J+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784680036; x=1816216036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zVCH3SNvGHAqohIZR80x2UwB+yylCYuM1KcyLhD5R9c=;
  b=pmJ29J+3RpdgfMmiJmEDY6K8Yd2maLvc4RidPG/GgawTTXbIvK4Uvt1j
   rG5AJggoNMAQTlswTeQd6peIJF9B/OFWw2xThtN3c3V1drrurd6H3aEzj
   z7y1VwdRfxBB2D8mooN1waEIHieAbSUx9yHx/PpZgtFOpijkv7+5n/B7H
   PaQ+9+9jvy3tfiOtFUrDpSRoRfQYgIkFXm6gHseqx4dKO8YdT6EtC8wND
   FOk2VcN3SLEZC9BFHPib1vwhA4LjZl4QnMvOXZVDhfeuwyrntqRczq6kA
   T1y4vpQZ/t3DDyOvLyu8nGqKGy2VZ7Hi6+qh7H+bDxWWLy/NYNBUBSJtW
   Q==;
X-CSE-ConnectionGUID: QjK258VHQLOWW6xv5nlCWA==
X-CSE-MsgGUID: ZzpZXR1wT+GWNL/5sBnIjQ==
X-IronPort-AV: E=Sophos;i="6.25,177,1779148800"; 
   d="scan'208";a="23907828"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 00:27:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:3130]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525] with esmtp (Farcaster)
 id 3b3ad690-f300-4632-bbcd-86f16b6e893b; Wed, 22 Jul 2026 00:27:15 +0000 (UTC)
X-Farcaster-Flow-ID: 3b3ad690-f300-4632-bbcd-86f16b6e893b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 22 Jul 2026 00:27:15 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 22 Jul 2026 00:27:14 +0000
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <kuniyu@google.com>,
	<kuba@kernel.org>, <sysroot314@gmail.com>
Subject: [PATCH 6.1.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Wed, 22 Jul 2026 00:27:09 +0000
Message-ID: <20260722002709.12710-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260501073945.1884564-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Add setting gc_in_progress in __unix_gc(). Keep the existing
  set in unix_gc() for wait_for_unix_gc() over-limit throttling. ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 net/unix/garbage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 66fd606c43f4..38c8cae13167 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -560,6 +560,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
-- 
2.47.3

