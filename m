Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5A30D3F2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954338; cv=none; b=nuUS/AdRf87kdcZTDG72/CsPNe4LHp0wJ7D6SlRrnGqqyQwOLshcRjxYPKuezjA+YEDJmMw68cnXUnXg3DpEF98r8d0fb4rIJ1s2MYuwvA2ymwBAgqU+wKIPs5PqzmdfbaOE7YmQ2zwY54jiYUApc2jcB16jAIC1biUqhayB6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954338; c=relaxed/simple;
	bh=2xkEdGCGxIQM3M62zyik8zeH4OtsX6n/me8wVLnIUZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7LlgXjexnenDK8MKCPYUslxXLCjaASdI8F2pf8Ok3xIUCmyZ/yzmJAfSK3BXUq1HhfO3WDbhQgGlsmW67ugRRcoSsjIdLDxxhjNWBynbpQJivqCFuLosaYQaS2BsBvAZ8vVHiQZXMRZMW9x8fSxWX8d1W00ZxJQjbk/OJeFLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqWu8OZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqWu8OZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AE21F00A3E;
	Wed,  9 Sep 2026 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954335;
	bh=pZpRtnZk6JdwIMZ41tjHnxyfOTuPRRNR0yMUh7RTy5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqWu8OZz4VFg0IUAvtZc4foBFQ9qxfolDcXAFxvllHTrJsN72oD9nllBIFFI5TBTj
	 tzHSaliuhuzxJABNP2I69WI+j0dR7VN4xko8o3LSQcaNNDJjBt1JvXAXXXdVyULfbl
	 i6dSGTg0YKEBXSWTxQZaLB/l2UPs6uZO5ju1Yo/QG4jhcpYd5AgqJvRxvNKbVKAz7E
	 J3ZkBry+OOz9gUduhd/3a/6NyvBbjgSD1JpGFF5guaUU+zdFMIarZiAC/XmDmMNGiJ
	 Qa4wtqtczNY81NBWwdKbWgO+KFRnIJdQZRQFGGWiHWLNGU99xWRf2Uf3MgvLzGLH4b
	 XEVDZUGavhYew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
Date: Wed,  9 Sep 2026 07:45:32 -0400
Message-ID: <20260909114533.1984024-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-morbidity-steadily-bc7c@gregkh>
References: <2026090321-morbidity-steadily-bc7c@gregkh>
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
index 53560fbb6dcd3..0bbdd532775c2 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3185,8 +3185,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq[i].name, irq, ret);
 			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
-- 
2.53.0

