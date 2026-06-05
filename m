Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B73F4823;
	Fri,  5 Jun 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664816; cv=none; b=LsdwV9allOSvYWQ51KTCrjExEnSHXZ+0xqTl7MDHIviob9Wy+KOstlcJgprGJkTeNULlK57uJ++k0TiIMo/2GI3QEWTZs8OvvJP2DSMhOzAfilyWJFVDCEBUoDu+m3zM9uG6wt3sjTTM51csj0l5EmpyWTA/SF+ANQfZ5ExVvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664816; c=relaxed/simple;
	bh=XMajIsvHqpv3hmWWRWZMQiL2sHr6MW5RUNsGsl9FiiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hM3mlrhx8qvxxiQBVh2x1FPZllBLQxh2iILZ7yHFj4jdvu4CgMnRjAC371+vPLfBPvXCbTIPvHuM3jAVo3Pp8dhVnmppBg8jRWASIarPcZM6cszoB7D8n8yPPolRjaa8sHZSU1GkAuHhfDA9nNnXMUx8UW8SFC9+4u37ai6zAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loebl.cz; spf=none smtp.mailfrom=loebl.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=Q13nkptH; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loebl.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=loebl.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="Q13nkptH"
Received: from email.seznam.cz
	by smtpc-mxb-55bd7c95dc-fndnd
	(smtpc-mxb-55bd7c95dc-fndnd [2a02:598:96:8a00::1200:50a])
	id 1b24221e00b6afca1fc19b9c;
	Fri, 05 Jun 2026 15:06:44 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1780664804;
	bh=ogwE3fqSYZJi/QI+DqmGkfHwrGgNJVgIJA9enEY8GNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Q13nkptHWkaX2bLvPPjf8HP2ozaHgRtbrC/sJjy+Dkip+M93QzblOfqRKJjZw9giS
	 v2LC8dPzbAYfOKsTS3UWuR1H81vzyTCWLehVce8bIgfqqbZZEtXnc7HO1kZFMeIh55
	 hBO9kKq3OMiqz47SEYtCIbrTUfB0GNrgt0TiocqSp2JJ880GX4P3rla5XaeZivY1/K
	 RiXRNMpXk8tgrFQoT2sEN+NNL0bqdX4fufhtwU+o+pqfgaMddrAMq2TyCTZMPDmwn7
	 plc1H5iEqg0lrTQOXl97os3CiFM7p2vPdVoCsPx9sJyn7wE11+SI1NlXXQ0/qbcrTP
	 RHInxjZYwTBfg==
Received: from localhost (109-81-118-220.rct.o2.cz [109.81.118.220])
	by smtpd-relay-6f9c9f69dc-qpzjn (szn-email-smtpd/2.0.74) with ESMTPA
	id 1b88d614-33d1-4da9-8dfd-02224292b969;
	Fri, 05 Jun 2026 15:03:44 +0200
From: =?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>
To: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-clk@vger.kernel.org,
	=?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>,
	stable@vger.kernel.org
Subject: [PATCH] clk: clocking-wizard: fix integer overflow in rate calculation
Date: Fri,  5 Jun 2026 15:03:40 +0200
Message-ID: <20260605130340.3549582-1-pavel@loebl.cz>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using driver on Zynq-7000 (32-bit) determine_rate calculation
overflows. For instance requesting 32MHz with 100MHz parent clock
results in 100000000*(4*1000+0) 32-bit multiplication.

Replace the expression with mult_frac which is already used in
clk_wzrd_recalc_ratef.

Cc: stable@vger.kernel.org
Fixes: 7681f64e6404 ("clk: clocking-wizard: calculate dividers fractional parts")
Signed-off-by: Pale Löbl <pavel@loebl.cz>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 4a0136349f71..dbef983eb425 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -663,8 +663,8 @@ static int clk_wzrd_determine_rate_all(struct clk_hw *hw,
 	d = divider->d;
 	o = divider->o;
 
-	req->rate = div_u64(req->best_parent_rate * (m * 1000 + divider->m_frac),
-			    d * (o * 1000 + divider->o_frac));
+	req->rate = mult_frac(req->best_parent_rate, m * 1000 + divider->m_frac,
+			      d * (o * 1000 + divider->o_frac));
 	return 0;
 }
 
-- 
2.53.0

