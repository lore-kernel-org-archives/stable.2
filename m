Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046430;
	b=hFOelxRHZTwPfmK1eiVyOX6C2N9/JEQCEleeTJdpjK1nlO0Vu1BuPu8AEPR/c1Py6qke
	 ZwENFBVLKfkzsmeih4IU6SjXxr39mnM1tIVJBbvJM1crG2vdnKLakql2p8L+rvdL4r0Ln
	 gsQbnb5FPUEl0LCpaNHqVCnsW6ze10pE3yXsksHo5TLLGlYxAq3m+UmJe0spvRRbO3bi7
	 +PCIRHzLBMp41LgvfJz00uxr75SzgkUUuF69o6uVSKA7+eZyS6mV57/9mjVhjGnkQROZq
	 sh58tRbPYyrAkhyTHpqiZww9xo5sTGXaRAq0N9pn+9Tf0rhU8dQz3wvDJZTJqsa3yug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046430;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1x0su3qFIaIhLOOHVTg63Xzz5NRDGI3ilAjVRn4Y+J0=;
	b=hvEjC2siMUQG/YGRfoEWswKqbJYP9JXuOsXrkSF+wERZMPsNKMY/pUlcfIDl3+XLJZ46
	 9pL5auC0WMphveSP8GwclxE2pVCOn5LChTp7a30pwSL53jtfjq678TRl73JxR5U0uSGps
	 SuYoAOjQXqfDPtsM5oDiJZucpEEfgi/gWKDtTX0fT8I+Az7p0qaIYetj6/TTeDrZdz/x8
	 Ky9HQsLkFwJoLkVOPPN2NHUEhYqenu5VN+ZwHIn33Um6n1tILdslaCZQJH3CxZ0x9VLT9
	 ZsILQnwmr0s+UroL33tldwO7q6HH3/VFcW8x0FjxqA91ElG9b34YpzonleEw2dawBxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJodq1ml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AA606A32D;
	Sat,  7 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJodq1ml
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794046429;
	b=BFFzFEyLQlad4lN8VqQPiQP9oB9Z2XmmXQsUhIsTUSdXPmKl6yJAKjCgM6cynk4VQhNs
	 A7wdrZtbV2nCCQNhiPzwp8wRl8kG7JUKgLfqDMZzq9UnLMGkw7+EgYg92lQDsYcZxsaKp
	 HWbzJqX6KCngXz6zl7x44T+P1PJzjMCBF9xK5opvBpaTdaPcYzub4zXanxOZKo7MvwboA
	 jLZmfVdnBOG06whPTNnw6e1fhxfVZmM1CzOe9yaffkuTPBfoFgoRk6uP1qGkGsuHYXVIh
	 m7QmG335LpduEVbmdMH3b8hUqdjOW3EYikgK+Y1iUl1DUeL23RqSwQqu9+HBD0vFNRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794046429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1x0su3qFIaIhLOOHVTg63Xzz5NRDGI3ilAjVRn4Y+J0=;
	b=xr2nd3/g0n7ooPr5PiV1VYx6Ry5aK2D1CQqXEjrh02qcSgN0t2pWfUYYz7ETV7jQ/34o
	 uqfJnzU6R7TpIGjMc4AHz35qx2mI02X2ONvuBy3Z/Coe+VIh78NATsrRb79sN2rZD1drZ
	 r+ks9c4Z7+v6jg/UiTGxhYKem6crjbAoItEPjODEegOQyC050YqexT64oOmcRUeUMTDhx
	 OM3fIHfnM5cDWoXyLPxqMVEtr3YqFKFkwTLDt/GmNPpRQU0NLCM0V+ByUE/y7jAiHqgEA
	 +yRRz0VxNXUzgnzbhHz2d/RvoLkMNMc+E4wD4NaWSpJ8otyoeWZdeTeLlmoMPW4w1lg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5BF8E1F008A1;
	Sat,  7 Nov 2026 10:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046429;
	bh=1x0su3qFIaIhLOOHVTg63Xzz5NRDGI3ilAjVRn4Y+J0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=iJodq1mlSBtu854QVQ9ONyTD8j5Q95lYmdwTqfxnAsksfn20dPcESK1HxVB7tUFK5
	 8QaQrGLUe1AapT8b4xshPMS29njcmVSln4HZzphVip6JHGzMXsh1jrv8hGBhUisJ8h
	 hmDVZczDUcf8FmRlM3CKW3/ivKDGOjmAlBJodUEqsh3PgMdvZOSifiQm/qvt/fQ5jj
	 W1uPPB0wrLYe2rEvBTxPfO6l5/a1GlCknPpDAwv3lKc6fbb2snBCmf00ifLCiIW5Yb
	 3b8Jg+Gghcmo5pYCo5po3Ex7lwIjfWjuqakh0tujF9H1VCz1el5GTupr8F6AKd+z6o
	 eqplaZPvdQacQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E1B2C47B59;
	Sat,  7 Nov 2026 10:13:48 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Sat, 07 Nov 2026 18:13:43 +0800
Subject: [PATCH] spi: mt65xx: Remove the CPU latency QoS request when probe
 fails
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-mt65xx-qos-fix-v1-1-9d9c16a584e4@udp0.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNz3dwSM9OKCt3C/GLdtMwKXWOjZBPDtBRjC9OURCWgpoKiVKAw2MD
 oWAi/uDQpKzW5BGSKUm0tANz3mEtyAAAA
X-Change-ID: 20261107-mt65xx-qos-fix-32c41fd385da
To: Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Leilk Liu <leilk.liu@mediatek.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, Rui Cao <i@udp0.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794046428; l=2424;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=J9ck0Rmxdd1nbYdPYBN9FG+4oXVrAofA+j7Izp5hqPk=;
 b=REkzO9qjpDLtQwUJ2L7TcXugkI2yWMutN5NdD7o8ySpatBLXAbAjyDeG80TTMDedIQn2d/x9A
 T87E08PacYsCghHh8+DjFlPTrQv5tXsVOQTQ3KN19p0+P+wXDg8ZjGo
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

mtk_spi_probe() adds its CPU latency QoS request before the chip select
checks, the interrupt request and spi_register_controller(), and none of
their error paths removes it again. The request is embedded in the
driver's private data, which devres frees once the probe has failed, so
the global CPU latency constraint list keeps a node in freed memory. The
next cpu_latency_qos_add_request() from any driver walks into it.

On a Redmi Note 13 5G (MT6833), an SPI controller whose probe failed the
pad_num/num_chipselect check left such a node behind, and the UFS host
adding its own request a moment later oopsed in plist_add():

Unable to handle kernel paging request at virtual address fffffffffffffff8

The same happens whenever spi_register_controller() fails, which
includes -EPROBE_DEFER while the chip select GPIOs are looked up.

Nothing needs the request before the controller is registered: only the
prepare_message() and unprepare_message() callbacks update it. Add it
just before the registration and remove it if the registration fails.

Fixes: 632556d5799a ("spi: mt65xx: add PM QoS support")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Cao <i@udp0.com>
---
 drivers/spi/spi-mt65xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b845a599f7c..49c31d4bd71 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1295,8 +1295,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
-	cpu_latency_qos_add_request(&mdata->qos_request, PM_QOS_DEFAULT_VALUE);
-
 	if (mdata->dev_comp->need_pad_sel) {
 		if (mdata->pad_num != host->num_chipselect)
 			return dev_err_probe(dev, -EINVAL,
@@ -1323,11 +1321,13 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register irq\n");
 
+	cpu_latency_qos_add_request(&mdata->qos_request, PM_QOS_DEFAULT_VALUE);
 	pm_runtime_enable(dev);
 
 	ret = spi_register_controller(host);
 	if (ret) {
 		pm_runtime_disable(dev);
+		cpu_latency_qos_remove_request(&mdata->qos_request);
 		return dev_err_probe(dev, ret, "failed to register host\n");
 	}
 

---
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
change-id: 20261107-mt65xx-qos-fix-32c41fd385da

Best regards,
--  
Rui Cao <i@udp0.com>


