Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5663812F0
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271769; cv=none; b=AN1hGadKNvBPLkA059s677Z38u/f3vBUdGi2oHdB5WoKQYNUjRU9DHPVKtMWKezOb1DbFu46vFx0Z9oQW12DvdzDORpq6d+9ghAGxpVkXGAG10j7HZ2YkKp/3rc9AaFtSDzj6mtdGV9SZFln9qklg/PVrjSnKyr2JhJkwZ8tk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271769; c=relaxed/simple;
	bh=4RZC9qjirxurZ1cUokwzBczc7gFvUblpPKUywrm/9UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQFfzpxipc3NrxqF9J/6y4retCFYYu9Ns32M25XShQCVBPZ306o5cug6BVnbrgVMT3zO5MFJqGCET39eXWrttLRhuucAvxdjOjajduCEfEKHZkz8zMJmrn1krhBKpgf5PeZHahcKmHfB5pgZpj1N01rpMpsTStLKiVFEQKhtVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSvpoIB0; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSvpoIB0"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso91314985a.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271767; x=1789876567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/bUegMRiQaIBYVN9SOaB+81MDliAzdtzoIqgfMCTL0=;
        b=HSvpoIB080jHGhRUnOFSnZToSPdsC1O8l+nn3pZLIlFi43mJAbAG9qdcWgLMAL1i3D
         00Gs0UtcFvJc50jnCzFnWzuqyBMnEaKmySaMtflUWRifDO2HQvlNCNqNFWdeopbFRK0/
         fsKcHNC3dvDt8ZcdjcSdQydAU63EBgo94GT9HzsOe77qP01L8M93vOnTrAGZkmtOkype
         WnesgSx4AmqP8mAJSlHSGkeFmyrBtnpj36+JzgXKYctQFvr3fqgXr2fAqlCZFGm0Hy9U
         S16+r+Zppz8hU4muGk54AkDB9Xf5AiHb4LJYARbMAfkQjxl4ZKccrN3itrqexI1VUIPw
         ScsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271767; x=1789876567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/bUegMRiQaIBYVN9SOaB+81MDliAzdtzoIqgfMCTL0=;
        b=E5xsaCGrGPjA+aTWuhV9/Gr9AEYWSckvlvVOl63rQkyip+kWMHORZVgsgV5HcF7Nn+
         KVh/PNzbIVoHmpUo3iJ/61ACvHiZE8GFcyspH1XOhp8NU72SencE3ObZDOYDnx/da0/H
         exnbltkZoijralBSV1Ui5G5HPUXnqevcqeYwUd4Xtt3MGfQlswtFmmZqJ2WTRe/k7Uoo
         V+ZujeDgh8YfGISsFkA55YojQ3Lkhjg3/jjfPg8iuT1k/5pXgxQfVtTrkmSz1vyyYb82
         LGE6JxQX9mGVgriv9fu7Ioo8ke7TcDmnGBZQuxyqxdyxPT7nY2lXwLN9uv+URTzvmU7q
         VfJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjKiVTYnvLwePlS3riz4bVq59snnvqHskvcBRro/6RcG3zg7QaafS9glftU6YVGUkZHJafLyg=@vger.kernel.org
X-Gm-Message-State: AFuF++nk027KA3UL60bLk2rGPTlM7X7oT0xjWQKkY/aWSFklxrjYYuVM
	6EwJXJdzPUKp7jkq4KAuRwIqzyaZK74knU0RI5+J2Qu50a85rCnqF8c=
X-Gm-Gg: AYBFou31El00swUKNyiLLOLYwJecN1ol+y2k+aTlM20f9X7FE1ok81YVrPVxO9rRtrQ
	8hThvH9QWqGoNNW1UgE6o08839hA44GREzdPGmYHjKehN9+LzU/sZFrt2H2AllkyVO0c/+ZNxra
	Fe9dYM0uufo+xtVKTzEtp3ADxvH+jOjxPLIBSZaQ5rAr94CSx/PiRHcU44kbKDMoNaR2usTR4Wf
	mT9m2CDD9N7QKoPTSjj1jExyA1awbtlUI/i8d7Y152oKW4CbatVapFMVbBgWB+NNEVNyv72y4Ut
	3oZivZ6Ec/Jsnv33o6GnhF5/iTw+A6TihdUD/5bA0t6vZ4OziCpJrBXVU5qMV2s30L5CsX6iv/0
	t4lrY7Zs0VPuJiNMH2B9mY7V0A/jSLwRBA7gAKS8MioE2bTomd92Is+eOZEPOMng6Mt6u21DsBM
	CTD4qPfGWy/9KFHE26UISwt+6vYeSuWYzvDHqgAMosvetzWMIIPR22tjNTn1XNY1aLanmMRmEET
	ztzHJ+g0TZoF7psRjLutuVxegZXVJWuWHZPSS6UVfF4JbFoOWrV4BeUPwY36WXgrkvEqaf07KhC
	c0l38X1aV9v+E9eewzDISuv3wCXjif4CGTCqxy+YJNPK
X-Received: by 2002:a05:620a:1a22:b0:939:7f2f:b17e with SMTP id af79cd13be357-93a0370c52amr793597985a.30.1789271766503;
        Sat, 12 Sep 2026 20:56:06 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a1bf286dbsm17527285a.40.2026.09.12.20.56.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 20:56:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ben Dooks <ben-linux@fluff.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] dm9000: free the wake IRQ before releasing board resources
Date: Sat, 12 Sep 2026 23:55:57 -0400
Message-ID: <20260913035557.19347-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dm9000_probe() requests an optional wake IRQ with the net_device as its
cookie, but neither probe unwind nor removal frees it. The handler accesses
the private board data and its MMIO mappings, which are released by
dm9000_release_board() and free_netdev().

Track successful IRQ registration separately from wake_supported: the wake
capability test can fail after request_irq() succeeds. Free the registered
IRQ in the common board cleanup before unmapping registers, waiting for any
running handler before releasing its resources. This covers both later
probe failures and removal without freeing an IRQ whose request failed.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: c029f4440fd3 ("DM9000: Wake on LAN support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/davicom/dm9000.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index b87eaf0c2..c8ff07fe3 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -104,6 +104,7 @@ struct board_info {
 	unsigned int	in_timeout:1;
 	unsigned int	in_suspend:1;
 	unsigned int	wake_supported:1;
+	unsigned int	wake_irq_requested:1;
 
 	enum dm9000_type type;
 
@@ -802,6 +803,9 @@ dm9000_poll_work(struct work_struct *w)
 static void
 dm9000_release_board(struct platform_device *pdev, struct board_info *db)
 {
+	if (db->wake_irq_requested)
+		free_irq(db->irq_wake, db->ndev);
+
 	/* unmap our resources */
 
 	iounmap(db->io_addr);
@@ -1519,6 +1523,7 @@ dm9000_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(db->dev, "cannot get wakeup irq (%d)\n", ret);
 		} else {
+			db->wake_irq_requested = 1;
 
 			/* test to see if irq is really wakeup capable */
 			ret = irq_set_irq_wake(db->irq_wake, 1);
