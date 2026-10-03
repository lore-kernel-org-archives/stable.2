Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3335E1D5
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036578; cv=none; b=g4xcwZP5PS8LA/7xQo7DRiGH2vmx7GxTTc7h2NYWdyc/xMPqd1hJWyMLcht6r1tkmaZuGx5iq8ziUIrQzYH+6QeCqid0ixqN2p4bUpkcdEJwDuXGfu1+h+mlfKU59loPpECisl0amnvlw7HxRBqLjY9O37vYFVaxab3xNOiw3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036578; c=relaxed/simple;
	bh=YbyQY7JoE6UOw92mTJzHWd+BaqMC9pONrFNAMHRtJ5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXg+0P5cRojnm+mwub3z/LUMlvTRPfHiYmooJHfxrJPEBqbnrwKHH/ft/Iodoku1j6y1TlejmXfuqda0ba3fTve7QZxnOVcrQg6f4tmghyNsdVC1GIzGlgd3E289Pe8PeHa0jc6zGDhxn6biOyqmK/Zs3nbxago/kyIOEfkMgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGCRv4w+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGCRv4w+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so5814125e9.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036572; x=1791641372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rG4jTd4nM+pkECs4oXcMHGsR3oQ3Ii3v3Uq1Mfg9zkc=;
        b=NGCRv4w+emBtEM2pyi1sPC6sQnAPbo63O1BbXiMnUFsqnYmydzQkRg33rqQ/W61KIT
         jYSKHiM8EUUR77NIfW1MMz0J1To3mAvJZz91/FZ/jbg5PRtTP8WJsjA+bjIV+FW3nNpP
         1QYn4w/gxSrNpwUeOw/wvaEtFiq/vxym0Tp24m3Qg4kIS4/eWJSiF+I5QdxesvpcJF1K
         FxNmY3shlVJ43q0g1JG7B2HyIJdwfmgFOl6in7xohvW2AHMHORunDoX+gBkN3vFciGLS
         wt0jZ3wcB6xVvKJp8BmQLxjChr2QTzzL9BkeYzCQfyQi2oxOWkKzqsLZqk0EORxvD+EU
         AWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036572; x=1791641372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rG4jTd4nM+pkECs4oXcMHGsR3oQ3Ii3v3Uq1Mfg9zkc=;
        b=QPVqAnJVzP8BEKCEppJdjt5Xkpsy+C48Kx/USB7EkqEzB0EqDlzZ1Oa4+pmbs//enk
         Yvt1OxT915Oo+a+X2xX6eUPWSpCXoJQCKsa2u8FUxM7SDTHn31nmqfVQS2lllLkqfxec
         4hmc+IhBJO0zdxTCmSfsPSfJGgqJSCkUDAnvmnJl5OGXqIsrask4QSKl40i4514imQNh
         5GznL8CcMqmuRYGgUcbAnFEBC1EoVgBZf1Lm2764GeK9nQkZbeFxWnsVVgkJGdMiL1+r
         zMnmAyyJMhN/gE2K/C1t8WUpYz4nAdwOGbrv9DAYgjQN7NHcxvA50kqTrcEPuk0xSVRY
         nmnQ==
X-Forwarded-Encrypted: i=1; AKwUvBz54rGc6IhLme9c3L2+Mdh4LR17HFmeWcQwmdSUC9AptbyNkDbbzu93MkHjSkINS8deUsHSVpw=@vger.kernel.org
X-Gm-Message-State: AFuF++m3oGKAZ+kfOvkMQ18IJt484KQzjZW3Z5t4i13VencsuJa+3AOW
	E50uNXQ0WpypFkSUvvMa17bgBYjpuvsHf3sjs7jTak4fHmoYkkgL3STV
X-Gm-Gg: AYBFou2bVpVolcW0IdsUcTeWtmPzl+/M7Xr3CwZc6+cToT9LVMfdDBxkvfYHUHCtik4
	LBoflIF0D0O6ZtAUcDevwOQXwds0DmtPTNPoH5wWO3U4JCzQRvcrkWdeflrCg0iGgZ/Lc5FGA5h
	50ccSeBJhgPcsfoiRsVlvlrGwQ0Tvt+AY/I9vQNtU522lq0adVqsWDPREfrvW0tVNX3EOGrLsjK
	PjNyEQAwswQp4acQ2fXZ2ih5+ml+J5u+NwdxhPfbRoNHPn7st2HCbnUJ6n5Ru9vatgudQLi0kkO
	jiuqFfjLgTkh2+pNS6Ko6Y/FVY6DK0sLatPlJ/v3YAU0kshhhOiTbYOADjRuW/jNPkZGx8/4+PE
	U7NvfaGzkzSAXyjnDCi/8ap4HIHfknAnt5yssr4nOPulorwPCajYvq+4Yydwe7192zw15O8XknE
	LEGt6WrCXaFyG77hEIRz+sVaV2DndHII95M6bqBN5hWRTTYhbVv7grN5beDxhf1LmB7iJFYXKwq
	sPiWd4XhFPknH4/QDKXIdZmHkZ8Z6eBHXVEgCVQcbJZCLHxMaZNiC/3sYZz4380zwM7swKX6saA
	HNUuLakS8+IGtQlUNIAQjNku5BAKRXyypRAUq2P6Y8ToymYKe6uTAcOlk0c7AKMJlVCOmqopjNq
	Qvw==
X-Received: by 2002:a05:600c:6208:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a0278d021bmr94872445e9.22.1791036572164;
        Sat, 03 Oct 2026 07:09:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: cpsw: unregister secondary netdev on probe failure
Date: Sat,  3 Oct 2026 16:09:14 +0200
Message-Id: <2f459154f5bca89a07dc978c834e98198c08c331.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers both netdevs in dual-EMAC mode before
requesting its IRQs. If a later IRQ request fails, the probe error path
unregisters only the primary netdev. Driver-core devres cleanup then calls
free_netdev() for the still-registered secondary netdev, triggering the
reg_state BUG_ON.

Track successful secondary registration and unregister that netdev before
the primary on this error path. The pointer cannot indicate registration:
cpsw_probe_dual_emac() sets cpsw->slaves[1].ndev before it calls
register_netdev().

Reproduced with QEMU fault injection by forcing the TX IRQ request to fail
with -EBUSY in dual-EMAC mode; real hardware was not tested.

Fixes: 070f9c658a59 ("net: ethernet: ti: cpsw: Push the request_irq function to the end of probe")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index aa3531e844e8..4fc59f9f23fc 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1550,6 +1550,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	struct gpio_descs		*mode;
 	const struct soc_device_attribute *soc;
 	struct cpsw_common		*cpsw;
+	bool secondary_registered = false;
 	int ret = 0, ch;
 	int irq;
 
@@ -1717,6 +1718,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			cpsw_err(priv, probe, "error probe slave 2 emac interface\n");
 			goto clean_unregister_netdev_ret;
 		}
+		secondary_registered = true;
 	}
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
@@ -1764,6 +1766,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
+	if (secondary_registered)
+		unregister_netdev(cpsw->slaves[1].ndev);
 	unregister_netdev(ndev);
 clean_cpts:
 	cpts_release(cpsw->cpts);
-- 
2.53.0

