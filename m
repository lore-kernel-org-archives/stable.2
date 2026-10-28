Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179939;
	b=YFy6o8NdD0Z+msHpqskU4b96W3dW9L6m6GeuYJyC6Ghq2DpUeOEJBy+OO8F6jg19gHu3
	 CTpb13RHcKrhrNUKaFvR29hxOwZQrNZNucwH7B0VgyB75bqnZgbluHUdbkFyCWJwe8kb+
	 u5wfT6+Jkej1c2qabYADdMfoiiLF1P281um4iFRfRME33VJVDRLuIq2ix8L3qFoU/n3Fh
	 PNbeNv9hmOylTR2Kcad8hVMhRT5XX4/z8hUEmHA2ilrHcV8umiZrO3fi2gv/QErz/M+Eu
	 CvVdynNcQLPNvwrLjTAMfnpEHCtARuJQslbVPY4Sg2JEXTQew8tyl7yaHvIYok6/2Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179939;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=dgRvAAs+iyfQ3xtuuwMg/qvfxKYNvDAq9ZIFiXETCAU=;
	b=tDgsOmlBFFMvi6O6cNtRWoZ0OtHZw/ggnTmL0+QxrIeAYAdm6tAY+Ud+rXsL/qSZqQUT
	 Mcgxp83Em621YPBbLUzUEtTS2U63/MJPeG3nJDqZPddipQkWsYQesgK+dVAKgn7q19mPl
	 abdGy/ymbO5ELIDKgKY4wixDbLThNi4FNvi42LxdivJydsvoAxJhIOKIUzKASW4IXMqSe
	 OQskNl0omP55k8HBWQkWK9+7LX+iXV5gNjsY+2iHNN89tkFTIzJYsc8AtDDq1UYPtJ+vR
	 l6y95Z4QZIyWU4cIcz9WDoT9pm0n8QMfvP5JGKFW9tMDynK9iEb+YS3ESx/IQn+NYTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=PIDJJGgA;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F5606A31C;
	Wed, 28 Oct 2026 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=PIDJJGgA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dg
	RvAAs+iyfQ3xtuuwMg/qvfxKYNvDAq9ZIFiXETCAU=; b=PIDJJGgAqta+hyodIm
	xPFZEYgJnJ0StM8s9r3ulHDt6cvYWtSgDp/b5PeGlTVYCrzMZBiI/+h8ynlmWC1x
	stGCYMwqlsGJP8phLhLG32yX4sXk5MytUaQyu27/4ujolS7aL8YSMMQC/JivsPzP
	oVtEUTuUGiHfrbiOYB75GLd6I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3l97nwOFq+UpZBw--.58427S2;
	Wed, 28 Oct 2026 17:31:19 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net] e1000e: close and reattach the netdev when e1000e_pm_thaw() fails
Date: Wed, 28 Oct 2026 17:31:17 +0800
Message-Id: <20261028093117.2313438-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l97nwOFq+UpZBw--.58427S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy7trWxWw4DGw4xGFW3KFg_yoW5Jw1rp3
	yUuas8ArsYqrW7Ww17Xa1jyF98Wa1kA345CF12kwsY9rZ8X34j9r4rKay7Cr4xCrWrJ3yY
	qrn8Z348uayDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQd8U2rhwOcPAwAA3d

From: Linkui Xiao <xiaolinkui@kylinos.cn>

e1000e_pm_thaw() re-requests the interrupts that e1000e_pm_freeze()
released and jumps to the err_irq label when e1000_request_irq()
fails, which skips netif_device_attach(). The netdev is therefore left
detached while the interface is still IFF_UP: e1000e_down() stopped
the transmit queue and no interrupt is registered, but __dev_open()
refuses to open a netdev that is not present, so the interface can be
brought down and never up again. e1000e_pm_freeze() keeps it in that
state as well, since it only tears the interface down when the device
was present.

Attaching the netdev unconditionally is not enough. The driver uses
netif_device_present() as the marker for "the interrupts are
registered" - both e1000e_pm_freeze() and e1000e_close() rely on it to
decide whether e1000_free_irq() has to be called - so attaching an
interface whose e1000_request_irq() failed would make the next
teardown call free_irq() on a line that has no handler of ours
registered and trip the "Trying to free already-free IRQ" warning.

Close the interface while the netdev is still detached instead, so
that e1000e_close() skips the hardware and interrupt teardown, and
attach the netdev right afterwards. The interface is then in a
consistent state: the rings are released, NAPI is disabled, no
interrupt is registered and user space can bring it up again, which
requests the interrupts from e1000e_open().

Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ae33273734f..6da613025a1a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6911,7 +6911,19 @@ static int e1000e_pm_thaw(struct device *dev)
 	}
 
 	netif_device_attach(netdev);
+	rtnl_unlock();
+
+	return rc;
+
 err_irq:
+	/* The interrupts could not be restored, so the interface cannot
+	 * be used. Close it while the netdev is still detached, which
+	 * makes e1000e_close() skip the hardware and interrupt teardown,
+	 * and attach the netdev afterwards so that it can be brought up
+	 * again.
+	 */
+	dev_close(netdev);
+	netif_device_attach(netdev);
 	rtnl_unlock();
 
 	return rc;
-- 
2.25.1

