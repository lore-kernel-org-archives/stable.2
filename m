Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F73E275E;
	Tue,  2 Jun 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406929; cv=none; b=kcJ7Qdd84VU+Ueo0q8UX6wUpQj8cqwYjZLsx8j/m5sRxZbd0303P1ELhwxcmTamWvFp0J2myOV7IMtjXtz6YffBJFKHkLwrWzyn05dLEjn8FfP9DHCiERnKLni6oIKduhBUzMeGWp/iYopx2/McyU6USlS0wQozaoALg0BVI0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406929; c=relaxed/simple;
	bh=wLImk5vqFccHsK3MrHUG9UepGlm9irtdb2ohnox9GPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8PcNdlybWirNHU07pQs7q6nShQfYGI6HxFZj8sPGwgJDi04ipBfP42v8lPcp39OjF/gi3ik/aPjYQZ+VhUItIihbRZTfzOjqj6jdzhGMPLCtcZDOJhHrogXfLGmND2hurqDmGu44Pm+zTGtcrHt7d7H4Xc8n11pFJiChxNFfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py4aq7dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py4aq7dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5EE1F00898;
	Tue,  2 Jun 2026 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406928;
	bh=zqUdJFTffah41MiqYor0O0hc6fcUw1Q2v/wZzX4zQWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Py4aq7dZrQ1FCbnEndd+CRni4u0RDiKOUsa6gmolzaKatuU0pCuC2FRpwDaRZfAX4
	 lCP5nZdgFlqNU/wLnNPFDpVBcOda9UpYok0Uef7zrEVWQbJkjFDD1yKlD9qyvhOaiz
	 ZgIhlyucyrd5RmQtP1LWfN806vh9zIfHnDecB5W2N7PGF0D0tD95tFZX33RVPSTHB0
	 AJw7SNGyHSiioOavXAO9WBFKaT7EEqT6J3D+e3RvOCBQL6s2/cB8HW8Ce7FgnP/PXd
	 pPMt4wmtjd2IwY+BUa+rUVbXq/0xcmBvhqiriX1wlYkvioQBQMaK9Uai3yj28juf2q
	 //7LbxAdhTSPw==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 03/17] i3c: renesas: Follow the reset deassert order used in probe
Date: Tue,  2 Jun 2026 16:28:10 +0300
Message-ID: <20260602132824.3541151-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use the same reset deassert order in the resume and probe paths to avoid
potential failures due to ordering differences.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 88a16efe096d..4c86e7257804 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1455,17 +1455,17 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	struct renesas_i3c *i3c = dev_get_drvdata(dev);
 	int i, ret;
 
-	ret = reset_control_deassert(i3c->presetn);
+	ret = reset_control_deassert(i3c->tresetn);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(i3c->tresetn);
+	ret = reset_control_deassert(i3c->presetn);
 	if (ret)
-		goto err_presetn;
+		goto err_tresetn;
 
 	ret = clk_bulk_enable(i3c->num_clks, i3c->clks);
 	if (ret)
-		goto err_tresetn;
+		goto err_presetn;
 
 	/* Re-store I3C registers value. */
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
@@ -1486,10 +1486,10 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 
 	return 0;
 
-err_tresetn:
-	reset_control_assert(i3c->tresetn);
 err_presetn:
 	reset_control_assert(i3c->presetn);
+err_tresetn:
+	reset_control_assert(i3c->tresetn);
 	return ret;
 }
 
-- 
2.43.0

