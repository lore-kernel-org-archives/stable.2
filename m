Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5555437D7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953296; cv=none; b=DeNC6sgq1T1Udr+4ZHasweowi2auerubIuoT+m+ifqKB2SY4VSedghRpafqpSZgm1bBsj2dyHRa+5vZvdN+J+YFqrBWHl/YpCZpd8pDZ5DiZ7vZqJPyE5ImDVFgVjuHMupCX4HCi/ZC9XRPZ9DQYCXKAHd4rFhDHtWjaUGRhQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953296; c=relaxed/simple;
	bh=7MFBZmnmuax0vNQ41Yl5PvrgL/OrTi7Tx70x0MP7QPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URF/6rqMVo4oJEgXBw3xWEJbHws2V0MgcF074jco7wB0u/J8nm+fGVKOdfF9WcEnNYSxtBeW/wS/XfN6aH2KEwvqGJFUgw26piy4G6zKNIMeIQGg3zDztU0r8iL0DocBtPpSWUftHgNgQNWnZv4cNcnNlk57cczfwRX0xi68id8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUdjoT8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUdjoT8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4651F00A3D;
	Wed,  9 Sep 2026 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953295;
	bh=ckE4+L7aHjg+j3IKOCDO7MHNlrJaJTN0i3oWwsNR78E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AUdjoT8De6BiaNeEJrzCcYnVbQOyWCvCLo2yNsM1OMOXDO3Z+W6VJah3aMe6/7Glh
	 o6oGHPr8cDot5bRciXtzRyZ2oL/k3qi/t+FwocCmjJM1eH0Y9jfbyB3vUahjuGL08t
	 CCY7iL1wEPD7j7Uoul+LodUk5FDckPjrW1/ozN81MVA4WK6ckdM5QgSDEX1S1JEw51
	 BRpo2noxHC8efo86tKKWN4FXUeMqJQa54JKLmyYEoNSNIPt7deha+lR7FDUC6zF4uN
	 LeDIcb2Eg6LChNO7yFzmKr2v7+14+N2tTzSYUnyZWIlO3uIpt1NNOnF8ZK5/OE6pc+
	 9M8LZTHarhxpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
Date: Wed,  9 Sep 2026 07:28:11 -0400
Message-ID: <20260909112812.1847077-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-patchwork-tadpole-ea90@gregkh>
References: <2026090320-patchwork-tadpole-ea90@gregkh>
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
index eb5c1ae68e440..f8f392592193e 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3178,8 +3178,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq[i].name, irq, ret);
 			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
-- 
2.53.0

