Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762073;
	b=FI2v07VvXreCaDjntmcFc2jN4OoJegnIz3uEY0NKgKQ16zBfzyTi/jNbKeM4m97xhJqg
	 JGazbQc41mOAR5RwkuOfbCnaodLo742zVG0mAgB8dK1HKgqSElzB0t8qENItFYLtM9+2A
	 7ryK+cZQDgAQTG6zS1wIB2BQad2BnHr3RlXVVca38JRce13i72RO6CpbAifCfjMt04+zM
	 K0ULLkwwoM7wns+D57jmmWtsTK/PRewMnFXlbWaaRaiqgbAnzSY5pnxUnrsTSl9DLlPYH
	 YnIopnR7wJZsQWHDtUN4oe3znLW5b8Swup4SqCBX9aM/d6XV3hrma3RW5B2JSprmdAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762073;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=F6XLaD65N+3qHf5eA4zz7LWLiBf+2mF6D5WZPA9b5hQ=;
	b=b8sEVtwKJdzkfnIUBf3XFMviGwClVv8D5YGyqwGRqg4FcjHUTQgGrcxhknApeHZ+jJ4J
	 QJ1b1yxNJRITMKKCkSLYehqvgitn5QYxxvkIp1aC0DSbfNkaH6WeOjYnJ8c9sWEPuaJj9
	 khjnEjKdsDJQDfi0KuJb7CC2+5AHPzzlXMI7h9DaDnpgMEKTNNXgDXnBAKGDIJwzaQsy/
	 l2HzP4OPth6InSBfa7GvXZkI0HUiC3ALr1dgFv83C3IuKr8aWLzaAnoNJQdesorl80XHv
	 AqM53mjZHjPf51+JWK+6mPBD3HURmX/ybQGPeVzbH+QR9DQPrJwnHIpJx8dQhLakdJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1DvQxSw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B48606A31C;
	Fri, 27 Nov 2026 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1DvQxSw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795762072;
	b=K8mhJ3H3cELtj86cZMn1g5uAkgiareXJ6RpEhMZn78iEHO3q2ACbW7zHSRZw1HPmxYCC
	 wbEdHP5Esaw0AEz7vU1sOmAMXvW/32Iuff+B4ZUoer22fvztwr/TWevDKeqXpTf/Nq3kp
	 m3QcMFnWcVCCqPOZJO0LlOHGnj27nX+R9exyiyoWXRF2XiuVe8AXM/UELyCvCWQ1s/rwq
	 YfvM6eyohY6XsxoR4RefOauQit3FQrRajgE3XfBC8YtIUvw1D9icBofSQk9lU/6YlZb00
	 Noyi4yFSxggBtXZKgSKUdcy6kzGybkDfIWtSOVhgzpe/xShIUqrUORA1Wfu1Y+VdYAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795762072;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=F6XLaD65N+3qHf5eA4zz7LWLiBf+2mF6D5WZPA9b5hQ=;
	b=MilKia1MLCvsik65zu2H0K8o2XuISJ0NHO/mML0rBmrM11iyJQPskGY30XbzF4kmSBrs
	 ATSRKLoKJZtko7WpGm0gVl5bDfeSJecQtUA3OARXl6HnU4f7R2O1DfNy85cOBPqiQCMyT
	 mrXIA5bjee9jh6DPuE0qZicJ3GG4qmaiJqB7pjx4Eui+LtJyZZ3Hln8HNQz7hHuBiFRoN
	 wJNIjVi6jNaPU3TX8ciRYyflLksxI+2WzzoCP5LPcMXKk+HpAfENIe3uOhYP9MaH7ynVE
	 AKafsF6b72PccAqG56Rw+TLJbYZoM1Uwbd/WLRr7NrGF2MI1fQ5NaRtnSAh5ILQdE6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5CA531F00919;
	Fri, 27 Nov 2026 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762072;
	bh=F6XLaD65N+3qHf5eA4zz7LWLiBf+2mF6D5WZPA9b5hQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=I1DvQxSw96Oywc5PNLieMnpD7Oquu2Q+RiflontHZI+DRF1FWCvPdNCFuopJLLE2g
	 5gQ2Bqfargx8sp+0eBbhWuAFUuiFnTRri45NX35YJswd8CH9pmweqrlSS8tp6Fxg68
	 ncQYp07/665AorVT1XmDSSpxfYBv2E8eHI/bid4OjJDNiMJCAffU3maLplh9OAhW11
	 sOTdoVkyebLmV6nl67jtFnqGzTBqvL19sm8rECvUqierXm0J6ePG9uZ3yujHHeXjOZ
	 vVKAG664fHarEit1ZZCRQ/4xC/y9xCs4e5i1PD+nth0fvv5Ws/qyF0RhflHj2ge7BB
	 sVHkbY3LFumLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB9594B5C8;
	Fri, 27 Nov 2026 06:47:46 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 06:25:32 +0000
Subject: [PATCH 6.6.y] media: verisilicon: Fix kernel panic due to
 __initconst misuse
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-so5-hantro-66-v1-1-aba19fe8802e@certik.com>
X-B4-Tracking: v=1; b=H4sIAFsiCWsC/1WNyw7CIBBFf6WZtVOBKE38FdMFj8FiDBgGjabpv
 wu6cnnPfa3AVCIxnIYVCj0jx5yakLsB3GLShTD6pkEJpaVUE3I+YjNqyag1SiWMDX4Sh6Chde6
 FQnx9986gRz2+Yf5hftgrudq3etAaJrTFJLd0xJR8zfmGne//PmDbPkbY7DGmAAAA
X-Change-ID: 20261127-so5-hantro-66-120abfd704f6
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>, linux-media@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760731; l=3408;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=Ad6RJTkF+6/+3vTssn3nKs2XylgDjMRr7Z2PcXcc+fQ=;
 b=zCmTakDP5f5qErT1jAVzgJt63slLKKZE/RkO9ede/VeTk+aop/XfnX18h4CGob6/xdxSozWUt
 Avz/YI5aDKCDNX/hXxK1nGOJLkz+G72BidAQ88FDtBcPzMHbx8jTzOS
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Ming Qian <ming.qian@oss.nxp.com>

commit e8d97c270cb46a2a88739019d0f8547adc7d97da upstream.

Fix a kernel panic when probing the driver as a module:

  Unable to handle kernel paging request at virtual address
  ffffd9c18eb05000
  of_find_matching_node_and_match+0x5c/0x1a0
  hantro_probe+0x2f4/0x7d0 [hantro_vpu]

The imx8mq_vpu_shared_resources array is referenced by variant
structures through their shared_devices field. When built as a
module, __initconst causes this data to be freed after module
init, but it's later accessed during probe, causing a page fault.

The imx8mq_vpu_shared_resources is referenced from non-init code,
so keeping __initconst or __initconst_or_module here is wrong.

Drop the __initconst annotation and let it live in the normal .rodata
section.

A bug of __initconst called from regular non-init probe code
leading to bugs during probe deferrals or during unbind-bind cycles.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/68ef934f-baa0-4bf6-93d8-834bbc441e66@kernel.org/
Reported-by: Franz Schnyder <franz.schnyder@toradex.com>
Closes: https://lore.kernel.org/all/n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp/
Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Suggested-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@kernel.org
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and newer already have this fix.

Tested on v6.6.163:
- x86_64 allmodconfig W=1 build of imx8m_vpu_hw.o with
  VIDEO_HANTRO_IMX8M=y, base vs patched, no new warnings; the table
  moves from .init.rodata to .rodata
- booted the patched kernel under QEMU/KVM. I don't have i.MX8MQ
  hardware, so the G1/G2 probe wasn't exercised.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index cdaac2f18fb5..de27c142b7fe 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -361,7 +361,7 @@ const struct hantro_variant imx8mq_vpu_variant = {
 	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
 };
 
-static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
+static const struct of_device_id imx8mq_vpu_shared_resources[] = {
 	{ .compatible = "nxp,imx8mq-vpu-g1", },
 	{ .compatible = "nxp,imx8mq-vpu-g2", },
 	{ /* sentinel */ }

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261127-so5-hantro-66-120abfd704f6

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


