Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794748383;
	b=RhepWzx/3b+9uB96m5H+GhtFoUoerS8q7Ux0z1lGfnImi4ShGu9WWYHeT0OLxqYPdn4i
	 RfL4m3VwiqileZ3fO/m26tK1tKuHq+MP+uf5MLDws7Q/KEKMndrzPJtzxr/zbRZjX6dEp
	 SQJssW8+D+WSp4a/eYY4e39gjakDCZ7CKcwzirAxbZ3n/+gj3ZfLYweh3QEGP7g1Dh6SR
	 Jao35FxDpkB6RQegtcRsq3CStjeIgvL1JD1Xg3Oo1Hi5E6KKo8Wh8ZIoMWfp0pjVs8wv7
	 GMTADJf8Kseo4/zuu/wO3iMdWP2/sFZkLph6Kisdo4EZEkpH0OerzWblzWELXCrTl7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794748383;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IqR561dWiplqXUp1PMLGBdY5P8lIwtM8j4jl0EFni5Q=;
	b=SE/mz0XFPfSbWK9iO9iDlxxQuVcHnJdM2O0Wamk57e+69Q0N6Hidr2IaeKkHYyu077Ew
	 Yj3m/Tl76YYatkYx5p4vYyclUI0fboen5i+bJlkBo2tl8d9WWJegfXmFOVc1d8PGBssZc
	 RTbGybZBhdEWgpqyo26Zski6oxQDIyhKEIgdmM14dHWLu6FroFdxpGuxy5mB36R5DPIx5
	 BGQ0utdWQhZ/zK7W/hDg9v0Nqi654nubkhNiSG6bKe2xXllO5cs5LjfoK3MBPZV0QJcZ6
	 m16hmidBZ9NkR3bOn+5KVtEj0S1J2se3h/2XpL4kqzHSVMw0X7z04dTmazQN1aSlppg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJAuXMgc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA622606A31E;
	Sun, 15 Nov 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJAuXMgc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794748382;
	b=YUMDaxtYaKnTDtTrUrC8JpkhAfk6EfuC3FcLXU5KbbxxJ+lnVorlsv9saBsddQpsFbSd
	 MG1az+RV5ZIFxYMxoY+eGo9hGlpH2KyU0Z00G9CldbrWuVQWqctofHvVJRDQLlXRyHtjY
	 H5Hc3V2qea+rLnzOwe7We2iGl8yAjQdjsa+rYlWejFCNZahDyeEcRoNqNJzTkZd940xDr
	 BwsdJm/R/J5eYjGcajMa0QbvI25tOO+L2eORNIr0ETe1w23tUDmyw6rcw6DqER84Ns0lR
	 bxibclKUfA0eso0pET45uuXJc5IQV/Ju+5B3pePyO74KjdA+chKTFMWDt2WzqBlU6EA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794748382;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IqR561dWiplqXUp1PMLGBdY5P8lIwtM8j4jl0EFni5Q=;
	b=1yyRud+L+rYKtwZ6PO7D2QJ8P7vTG2Mfx+nijfhYAerqxx4OtSBrOagyfE4QVRmwn+kS
	 gN8lHPHi1otlue1fFiQ6kIoHyJBU7/bOrVKKsKz6x9rQv9k7gVZflGZrCf8JUuAIEp8xM
	 HpOlyvQvi3FUpRCC//FuaUpguLEiSUfceYHjLQqnY1eD3FIMvgbvCEpd0Iotibvb1n+SP
	 8H1MCQsAs34HAErjcMUYMuz4eFsQN/tZnRRGs2VwK2NBPNbhj9yFNuJl5HUyz+DE0wcei
	 +6iXtrcX7rYgbLdTo6IHWwJ2BZExhUb3cVYcAVcn5N2itmQ1CQYJCSmv4jRSIK/WIiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 14F661F000C5;
	Sun, 15 Nov 2026 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794748382;
	bh=IqR561dWiplqXUp1PMLGBdY5P8lIwtM8j4jl0EFni5Q=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=IJAuXMgc3/CrVFvtvJGHJ/gPL2mdVN5ctgD7Lp2r4pLqY2YIWRbpQmQcx5dZSIB6B
	 9L5KtDAifjS4jFFDpJqDGFL6MgcpYHN1T6oVlWcfuNDN1UUZfZHpMXorYs4s4Hh7pJ
	 VBhNS/I3/UDpchk+OS2uOIoCz7QbTQ8slEKNMhw5VA/4hgH4gUGpibYycB+8jAJPAH
	 7LE4yp75z9xbw/gnbObKKVZsaXIteIV2TGFghAr9J+nWrMzp9J9HMQBOyMNURDn6sL
	 eXzcS1KFY4tm317BYu/Y7d97gK7JDVhJPF5CwS5ainxK8hNEIVNbnZ3pJRoCObX/LD
	 E0zvBA7dWlbvg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 99DE44A0A8;
	Sun, 15 Nov 2026 13:13:01 +0000 (UTC)
From: yzddMr6 via B4 Relay <devnull+yzddmr6.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 21:12:57 +0800
Subject: [PATCH] ASoC: qcom: q6dsp-lpass-clocks: Set driver data before
 registering clocks
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
Message-Id: <20261115-upstream-q6dsp-clk-drvdata-v1-1-4d7dbea52e52@gmail.com>
X-B4-Tracking: v=1; b=H4sIANiv+WoC/zXMyw6CMBCF4Vchs3aUVgLiqxgXvQxSL4Az0JgQ3
 t2CcfmfnHwzCHEggXM2A1MMEvouhdpl4FrT3QiDTw0616VSqsBpkJHJvPBdehnQPR/oOXozGqS
 89rpq9Km2R0jAwNSEz4Zfrr+Wyd7Jjau4PqwRQsumc+06/e3DtsdqXyA7DcvyBbn5X9OnAAAA
X-Change-ID: 20261114-upstream-q6dsp-clk-drvdata-e09d27f289b3
To: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, yzddMr6 <yzddmr6@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794748380; l=4515;
 i=yzddmr6@gmail.com; s=20261028; h=from:subject:message-id;
 bh=IhpdDzjG8SfUTWw69Q02/8xD6GDVJahHeSuoz5N6di4=;
 b=1VjHJ+3hckZdc0O+FuL60XGYogx0ZxwJhD+VOXHMKTe3EPdoyEnpqTWiIqO8cOPhscKIRQjan
 UBcaxw7PFcQAtzV+3B+D6bnxJHIYHcKVusuuFUHGEN5vOJxUKkfxkEN
X-Developer-Key: i=yzddmr6@gmail.com; a=ed25519;
 pk=QLT2mwairk4R38oU379hkHynqjoLrlqd0Cl1ERUqIqY=
X-Endpoint-Received: by B4 Relay for yzddmr6@gmail.com/20261028 with
 auth_id=1489
X-Original-From: yzddMr6 <yzddmr6@gmail.com>
Reply-To: yzddmr6@gmail.com
Content-Transfer-Encoding: 7bit

From: yzddMr6 <yzddmr6@gmail.com>

The clk ops of the q6dsp clock controller look up struct q6dsp_cc with
dev_get_drvdata(), but q6dsp_clock_dev_probe() sets the driver data only
after it has registered the clocks and added the OF clock provider. A
consumer that gets and prepares one of the clocks in between
dereferences a NULL pointer.

fw_devlink does not keep consumers out of that window. The q6prm and
q6afe clock controllers are described below the ADSP remoteproc node,
and their devices are only created once the ADSP has booted and its
GPR/APR services have come up, long after the remoteproc device has
bound. fw_devlink therefore makes the remoteproc device the supplier of
their consumers. A consumer such as the LPASS LPI pinctrl then just
defers until of_clk_get() succeeds, and its retry from the deferred
probe worker can run while the clock controller is still in its probe.

That happened once on a Xiaomi Pad 8 Pro (SM8750). While the LPI pinctrl
probe registered its GPIO chip, gpiolib read a GPIO direction, which
runtime resumed the device and prepared its q6prm vote clocks through
pm_clk. The prepare op then faulted with a NULL pointer dereference at
virtual address 0x350 (trimmed):

  pc : clk_vote_q6dsp_block+0x24/0x58 [snd_q6dsp_common]
  lr : clk_core_prepare+0x7c/0x298
  Call trace:
   clk_vote_q6dsp_block+0x24/0x58 [snd_q6dsp_common] (P)
   clk_core_prepare+0x7c/0x298
   clk_prepare+0x28/0x44
   pm_clk_resume+0x10c/0x188
   pm_generic_runtime_resume+0x2c/0x44
   ...
   __pm_runtime_resume+0x50/0x94
   ...
   lpi_gpio_get_direction+0x4c/0x8c [pinctrl_lpass_lpi]
   gpiochip_add_data_with_key+0x7b0/0x10dc
   devm_gpiochip_add_data_with_key+0x38/0x8c
   lpi_pinctrl_probe+0x2b8/0x320 [pinctrl_lpass_lpi]
   ...
   deferred_probe_work_func+0x88/0xc0

0x350 is the offset of desc in struct q6dsp_cc; the driver data pointer
it was loaded from was NULL. The oops left the clk prepare_lock held,
which blocks every later clk_prepare(), and the system did not finish
booting.

On mainline the window is short, but it includes a wait for prepare_lock
in clk_core_reparent_orphans(), which of_clk_add_hw_provider() calls
right after listing the provider. The kernel that hit this had
out-of-tree changes to drivers/clk/clk.c that do more work at that
point, which makes the window wider.

Both q6afe-clocks and q6prm-clocks use q6dsp_clock_dev_probe(). Set the
driver data before the first clock is registered.

The oops was analysed and the fix written with the help of an AI coding
assistant.

Fixes: 9ab71ac37240 ("ASoC: qdsp6: q6afe-clocks: move audio-clocks to common file")
Cc: stable@vger.kernel.org
Signed-off-by: yzddMr6 <yzddmr6@gmail.com>
---
The kernel that hit this was v7.4-rc2 with out-of-tree board support and
other changes, including the clk.c changes mentioned above. The oops
showed up once in the 23 boots of that kernel I have logs for, and I
have not been able to reproduce it on demand. The patch is build-tested
(arm64 defconfig, W=1) on the base commit below.

I used an AI coding assistant for this work. It analysed the oops,
traced the probe ordering and drafted this patch and changelog. I have
reviewed the change.
---
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
index 94d96130245e..c3628f90fdb2 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
@@ -146,6 +146,12 @@ int q6dsp_clock_dev_probe(struct platform_device *pdev)
 	cc->dev = dev;
 	q6dsp_clks = desc->clks;
 
+	/*
+	 * The clk ops look up cc through the driver data, so set it before
+	 * any of the clocks can be prepared.
+	 */
+	dev_set_drvdata(dev, cc);
+
 	for (i = 0; i < desc->num_clks; i++) {
 		unsigned int id = q6dsp_clks[i].clk_id;
 		struct clk_init_data init = {
@@ -174,12 +180,6 @@ int q6dsp_clock_dev_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = devm_of_clk_add_hw_provider(dev, q6dsp_of_clk_hw_get, cc);
-	if (ret)
-		return ret;
-
-	dev_set_drvdata(dev, cc);
-
-	return 0;
+	return devm_of_clk_add_hw_provider(dev, q6dsp_of_clk_hw_get, cc);
 }
 EXPORT_SYMBOL_GPL(q6dsp_clock_dev_probe);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261114-upstream-q6dsp-clk-drvdata-e09d27f289b3

Best regards,
--  
yzddMr6 <yzddmr6@gmail.com>


