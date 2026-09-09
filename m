Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D2548544
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954043; cv=none; b=rhW6p7IF7fCNLOvP5jYZb6UfV4DpOoYsCmXz21KU5CnfFKDZ3gOD2J5kZcKpLzRmq9g+7olzFeCFEsFjyiYpLas/+gjXZ0TUVwxScOGK2OxFZqp606PCRMc4StjKW/jFfTqjWyXmMbGZe3f6vGtJ/yZUgBiRv4K7FSsfecRRww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954043; c=relaxed/simple;
	bh=6Ly0oobq43Ut7yn1KhDLYQrHF841ebOtWcUE8AEN1Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsJ9Ud6S2TRNk8XMghbiq9mvagxxHSqRODyE6DeL1D0lcElDjzn/GxtWXY2BMtWCWWqIQ0qDcefpAjGkdZsk31uVMNL1VEdMrL2UUg5gc9i8dyssClmmJgKg91d37I2nZLy4yzjCWJQipp7FGQY1O0ql4ql8kBH3o6CvwMGsD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMLkhYPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMLkhYPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722011F00A3F;
	Wed,  9 Sep 2026 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954042;
	bh=zJiLSpoHZ3Xy9hL4iSxvr/eeTnla9R9Vnrxnf2dJaig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMLkhYPOtXd7eyGrTDLdGvi1zHZv6oIWQOw5tXsKBSYd8cp017Hxe7Mb63Bl7S70o
	 dZjr5M2NyidbY3Ay3tZnqB/ffl5b+HqvLTnJ7dbPNTnA4dHS974bHF/U136h+iPt8J
	 bd+t/B/j8wESlUTHKR8iIo6jP9Jh7ZfVDltkCnwgW2LCK54+pNW/wXFQZMowtK2L4W
	 ReN4F5bxypRahelOsjIy1VpSVvsV9vlzkZK++XBwefuDYxrnCpUa44f81+C/RBkSIO
	 71aAIPgmdsgNW5qlENuylRriZkeNUDN2XMO45Q1IVHGDU7a32GSkB7euwhJQeLSMc+
	 jXwYE0PFvwHyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
Date: Wed,  9 Sep 2026 07:40:39 -0400
Message-ID: <20260909114040.1915800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-spotlight-grape-ad40@gregkh>
References: <2026090321-spotlight-grape-ad40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit aa5f4decedfb4fc5cd0fe49ab256ad4304d192e4 ]

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260709033428.362970-7-panchuang@vivo.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 75b1e88d3425 ("power: supply: ab8500_fg: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index a71903b1bf781..c2fbba1b7085a 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3179,8 +3179,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq[i].name, irq, ret);
 			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
-- 
2.53.0

