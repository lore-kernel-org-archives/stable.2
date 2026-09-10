Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389E3B2FD0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084487; cv=none; b=cZMpbOtUGRu+Bh9+nimtSuwaUi8KGR+xUC/+c6pAzFKW5hViFZRlh8GmGQF9LN8u6Ye2yv6pRkxVPGb3ObE9ky6nrcegAdSkZ8Mo/cIWvLt1a8/S4L5ZmCcF1fNoJlNHWY8EI1N5yDynVBADR+ApHLrilUDg+w3bVGmISdD1hic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084487; c=relaxed/simple;
	bh=zm+IFtkQupAeQomjz92QbxQc3kRIUVTD3HYLMJXnvk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3PTQW94mj44nDzQkbKooe+UFTHJO8lLN5IqTszvNUV/mdyWGG0HE/+qe8xKoNJJyCGy65WTILg9oKW9DUqs8jaeYkacTRhcUe4Bp2aEWoDxpA2XuLgCMyeUvl5cy4yfIuINkoRgm9209N/WBdEFjJsHy8zQ+6+PgMbdBybofqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYsHGmaW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYsHGmaW"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5306d609317so4035751cf.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084483; x=1789689283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
        b=pYsHGmaWfpAa7B/bb3mYdm5drZzeM+BProUz2kpcOi/3Vgg9ndxcOP0Mp44mkatWB7
         D0HGHWdDa6gYAwCafifcG8uG4iuZwdOm/SNXdLPRB//DNw4zm2yg64ItfI/A2NOdkru4
         Tmb7GbZHFDMcMFWkBwiT2nDv9UJgnBjgMCTgQ587a+vnDlbKzhYy4ADdEFwpwoQ0vY1+
         5lEnl77ZWAuYCfHoVTKdP/go8ai/yqrgqJdbuleQ/ra3O2qxP3SgGc02W5Bxmz9r811W
         +sgbi/cJ1+2s234y5rgNQfPXH37fre77wtK3cnS0uikdOlXYZL2ot8/0wFJaFRosLY5E
         BMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084483; x=1789689283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aXOUF/0dKfcL9nM72QWKoaIot6Ph6ib6YvMRCU6EYeU=;
        b=DsLwrfIwlZvOPaC7w1QtX+D4QWCWYK7aPIaQRbkUnQrkbb0kRUXskIDCGKr8FRAf6a
         89k/yPmu+FQs39VOqj9uYaQnhso4KKY+mIZJqjgE6l10YKGC3+4Ky3oXQd5FMHxMc6aQ
         h1YxdQsdkUCx9CI1YbY81MWrF4Y5vuVRhWGO6lgZSDY6pvL+IwV58ktwQ852JqmvIgqH
         3GsSR5k7uyTMmQ0ZC7yCMqF3BafAxkvdubf89UX1a8IvOxLZShC2+QIIN71Ba0uG75or
         BOV3al23v48lYEKm7WnkT5MIkoVjqf/XHx98nw9sO1naEFizP/yvaVrq0beV4X4OINOZ
         WtKw==
X-Forwarded-Encrypted: i=1; AKwUvBwF6nK6LPeDYgaTaqdDqDxvhCTE5Lpdw3erCpjfpjNyoN9VATD5acwnfYqLuhVi9NRjeWH1+lI=@vger.kernel.org
X-Gm-Message-State: AFuF++kpsmXgQBBcuWKaGcBHboYVgQrdVuKqAfx8s9CeHsUBh14tyllq
	2JF7bxa6VFLoX0Ec+QvWUJi3vFxXC3/UzwsgEJsRw4Rzou7YCIxXan0=
X-Gm-Gg: AYBFou2seqWsqPW7GpQfe+sG0wvAGEBV5meZHPHhTGIDaMICemuTsuRb8KVa3yi6A3g
	JWNvGBsoiIhWr7Mr1IuR94n7YDZNaO0PHWl4+k3MFwPkf0UXTDZxeNZeMD8+FRIyHUREz6LaT8p
	7oI39Wh/V3/Q2rJKzJsioZ7QPXbvSptTru3AQEKfv2psLxVMVjQxwQQbc3dTj87A/KR88OCqC4u
	bRzQgSPH+yCgTcV2zZhbx5WZ1IMd5S8lbA/JENYnEMQMNGWbFEgYw78n5ylhGtFNOVpmFDfGGNz
	SUeJ/fhhU+va2owMxPBZVDZgVriDg+4uHuPS+CFXfUh3J+W8qY7IvwHv1DnsHSkUZlCanPMiqIu
	UyoGcorqzCbw74ki5TX+8HW1L4MK6rBx8/KDXIjTEOUUzf+iwyA7s1C0F+eOCz6Za4gzQCxYKVt
	Od4eiIr3tGebhUVcVvq0+IHuAaS3cHbc00Zuk47z9BiNM6P0e1gfvNjglNzdKsUk8F+2fRNOb7s
	zpoDYkCAUIMSxvSi/QnmC5qAzLp5RDwMdMMmwBYfFYSiUl4cru0aowKLU9FZRZJCKWZYYjNuxg1
	KX542adjaFgjcX47ht+sKLlAu/pYATn9bjnliym8LXQREA==
X-Received: by 2002:a05:622a:1a96:b0:52f:ab8f:43dd with SMTP id d75a77b69052e-530c871239amr28491771cf.38.1789084478245;
        Thu, 10 Sep 2026 16:54:38 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:37 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] net: wan: hdlc: close active devices before protocol detach
Date: Thu, 10 Sep 2026 19:54:29 -0400
Message-ID: <f5f0519e82a7b8bbf314dc137470f7cf931e320b.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff3516442768 ("WAN: HDLC: Detach protocol before unregistering
device") moved protocol detach ahead of netdev unregister so detach could
still use its state. However, detach_hdlc_protocol() calls
hdlc_setup_dev(), which clears IFF_UP. unregister_netdevice() then sees an
already-down device and skips ndo_stop, leaving an active HDLC device
running while its driver releases resources.

Close the device under RTNL while its protocol is still attached, then
keep the existing detach-before-unregister order. This runs the hardware
stop callback and the protocol close callback before their state is
released.

Audit all current users: c101, n2, pc300too, pci200syn, wanxl,
ixp4xx_hss, fsl_qmc_hdlc and farsync unregister before releasing the
resources used by their close callbacks. The farsync probe unwind can
disable interrupts and free its RX DMA buffer first, but fst_close() does
not use that buffer or require interrupts; the card is also in FST_RESET,
so fst_closeport() does not access the port hardware.

Fixes: ff3516442768 ("WAN: HDLC: Detach protocol before unregistering device")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/hdlc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index cbed10b1d862e..a38f90d3006ed 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
+	dev_close(dev);
 	detach_hdlc_protocol(dev);
 	unregister_netdevice(dev);
 	rtnl_unlock();
-- 
2.47.1
