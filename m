Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793383327;
	b=0KEYtrPVkLSxbDXelXbydaPz2YD2c4pK+TloDCxMs1B3244KGJW31GaYq6MgGW+jAPGu
	 wuFwPzGrNVY+5wRRju+uqPA4zIr8RhzdilKrmG8ORFjgfvPHOlvnsSW910zR27F7wquqi
	 7SJvfEUQWEFqNSvtn1Sc3NoKZYwj4eNqqfh0gEHnJCnl9Jxu7zqz45gvRWNNwa8JUbz/d
	 r+dJ4N95cPmAjv5/5QwWotcpfkRfTmQlCd6Zi50bXcUv3f2zv5uQYioCUVmKzSQuCp424
	 ppPsuIvAs9SuaAQ1N/2yIsQFRGHV6WpoDXBR6tEejTkT+TVGl1RoMIw9u5crK9L/c3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383327;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r3mesjXZpMq/QbEmw5EflPGX4n+VcT5zdLRzDbA874g=;
	b=BSuHdLg0aGpMJnOeU+hoaeJsZMvu8Ulzzlsd5E6xA3HpFAoTupJbp8dIt32GsvLAHZTF
	 S/EI6h2LczznRkZn0f1F0o9IHo66qszoG+cxQ2uHSBruF+vZjlQPSVNAKVsY8pY3QkjWZ
	 2CWOEtTEMq+PsifWJhf9w4mS8yGLMAwJWNwOjtVnsqE1Mp0Idcc2sKYkjQNmiGzEtBHOn
	 /j9gSrvDvRZ9YRAy/OuKfisMIxU6//bOSXAvUcsHPBXiW6wute1UN26SQ/mOemm98xUmY
	 ioauhcrQRR3e8P62rh4yuUXX3bPIcWo2mdngu4P/ZpyVRNKwIvgKgu0OralNtZhzSSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdjlzgza;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F093606A31A;
	Fri, 30 Oct 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdjlzgza
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793383327;
	b=SyF3OcjX58kElkpQXoic3U6BdE+HTImqvZT6BTI0niEbUpi46Da2FvzKlYF77lgXUot3
	 HXL3oWFQs2oVLfdS/0J5caac496Br/R/il32DUpT4AC2j7tQFGOnZew4cP9a0DbJZxNSY
	 O1iwsjLhBxnzGb6djs4LyoNlbhI8tOsZWGygV2gTzSIViZowa/9t8r9NfoVWsGi1PExWc
	 NGKqzn1uIPT8yL4fIWDwkxbnlEaXqf0ubpypEXTfrvpHRAAcfrD1F3Q5sWTvC763kuK/e
	 BIUrAQuo1DnYMwRyoPp8/addvAigS3r1v7QthT4hQw/OH+T+pDmAHsMhEuuK+plVUFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793383327;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=r3mesjXZpMq/QbEmw5EflPGX4n+VcT5zdLRzDbA874g=;
	b=XljPRJxZs+BdfpKUujWfuwq8tSA/gza4WGlrOdotv6HDvwfFi5FEvG4KboNTeOotQOCR
	 TXmq4jGQFqpnfLAckvamP2QjkJWhx5wW9yB8hA01YWCID4Z0Zq/S5TIQ7y5pt2eMPIcLo
	 IaCB49L/bV6P/lXAfXw3n9fAJHPqiJ6U/DUfykX+d8D8T1fYTxcrpbmc20Sb+spqMZ4TW
	 oLxoGLxmV7C0YbxTlsG8/tyyLumGvT+AAQIjmXmEWMgsG7WuZUsEC976uyTEHW1I8oOfH
	 LI8VTCvpl1GTXhDEfTY8pRTJgSwR62kG5O7dBmbCBYVqb/dg17sXjsAgFULIfiXAARw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A7BE21F00A1A;
	Fri, 30 Oct 2026 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383327;
	bh=r3mesjXZpMq/QbEmw5EflPGX4n+VcT5zdLRzDbA874g=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=cdjlzgzaKbrq+Ptz8+KPtXCMEA2reLNc0TFTY/eaUK78IhPMnbhuubDVCJs7b3n3G
	 q42TUBvD4adGVTlrho7mKSeVKctaLBTGVEHwkSzluNwCOLhBX7ZWZBg+DWCrf3F3Wa
	 xu5L3CUHzzyGvW8WJKlbPwWhBvA5+/2/fT32vgHmRcPDjyb9V2wLujl1AWA/lZo9ti
	 KVgU7tVxQXHNOOLwsmXAaRRukuu/H1+q5O1CY/6axImqgZgStAuU+44Wecyiaryxri
	 4hiL62vmpYa5ltEqimBWi54NMv/k2mN3e44vnmBoACTwXbx7B/8f+9AEBrrOSE4B4t
	 NwFewo7TWLmBg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3416443F1B;
	Fri, 30 Oct 2026 18:02:06 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 30 Oct 2026 18:02:04 +0000
Subject: [PATCH v2] media: rkvdec: Do not keep the clocks enabled from
 probe
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
Message-Id: <20261030-rkvdec-runtime-pm-clocks-v2-1-8ff510a231de@iav.lv>
X-B4-Tracking: v=1; b=H4sIAJvb5GoC/42NTQ6CMBBGr0Jm7ZhORQiuvIdhAWUqE37TYqMhv
 buVE7h8L/net4NnJ+zhlu3gOIiXZU6gTxmYvpmfjNIlBq10Qeqi0A2hY4PuNW8yMa4TmnExg8e
 cms5YykmXBGm+OrbyPtKPOnEvflvc53gK9LN/RAMhoW21ubaFrris7tKE8xigjjF+AZc1RKO9A
 AAA
To: Detlev Casanova <detlev.casanova@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Diederik de Haas <diederik@cknow-tech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Francesco Saverio Pavone <pavone.lawyer@gmail.com>, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3311; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=zsa4RX1c/nbvAozgmcN/IU1qGvXJqkjP4BnsN43BGmQ=;
 b=kA0DAAoWMpeVi+pfeQMByyZiAGrk252g3CU8c3IdDSZpGQ0cK1tTF0u77/pNmEQE36uaSbo3c
 4h1BAAWCgAdFiEEkMIo2mik1f1PSDfgMpeVi+pfeQMFAmrk250ACgkQMpeVi+pfeQOANwEAoGgF
 h9OSXorU/sv8C1ifnWk32p5bhPxWTAmx/o+j6ZoA/3SCrX77lyVxa9AxhduIM5mMv6+txRaDQFe
 LTFYIq3EN
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

Since commit 6a846f7d72c7 ("media: rkvdec: Enable all clocks without
naming them") the clocks are fetched with devm_clk_bulk_get_all_enabled(),
which keeps them enabled from probe until unbind. rkvdec_runtime_suspend()
disables them on top of that, so their enable count never drops to zero
and the clock gates stay open while the decoder is idle.

On RK3399 this also breaks restore from hibernation when the boot kernel
has not enabled these clocks, for example with rkvdec built as a module:
the gates are closed when the restored kernel takes over, while it still
counts the clocks as enabled. Powering on the vdu power domain then finds
the count at 1 and leaves the gates closed, and the first QoS register
write of the domain never returns.

Get the clocks without enabling them and let runtime PM enable them while
the decoder is in use, as before that commit. Without CONFIG_PM the
runtime PM callbacks are not registered, so keep the clocks enabled from
probe in that case, as etnaviv and v3d do.

Fixes: 6a846f7d72c7 ("media: rkvdec: Enable all clocks without naming them")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on ROCK Pi 4A (RK3399) with v7.3, rkvdec and panfrost built as
modules, panfrost not loaded:
- idle decoder: the vdu clocks have enable_count 0 (1 without the patch);
- hibernate, power cycle, restore: 3 of 3 (0 of 3 without the patch, the
  restored kernel stops after bringing the secondary CPUs up);
- H.264 decode with GStreamer v4l2slh264dec, 300 frames of 720p High
  profile: output identical to avdec_h264 (md5 of all frames).
The QoS hang was traced with debug prints in rockchip_pd_power() on a
7.3-based kernel.

This is separate from the unbind leak in Jonas's patch that Francesco
posted [1]: here the extra enable comes from probe.

[1] https://lore.kernel.org/all/20260717154505.83935-1-pavone.lawyer@gmail.com/
---
Changes in v2:
- Keep the clocks enabled from probe when CONFIG_PM is disabled: the
  runtime PM callbacks are not registered then (Nicolas).
- Retested on the same setup: idle enable_count 0, hibernate 3 of 3,
  H.264 output identical to avdec_h264. Builds without warnings with
  CONFIG_PM=n (arm64 allnoconfig + COMPILE_TEST, W=1).
- Link to v1: https://lore.kernel.org/r/20261030-rkvdec-runtime-pm-clocks-v1-1-fb2c5b629e79@iav.lv
---
 drivers/media/platform/rockchip/rkvdec/rkvdec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
index 061281f903f3..81cf3c1ba7fb 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
@@ -1788,7 +1788,10 @@ static int rkvdec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &rkvdec->clocks);
+	if (IS_ENABLED(CONFIG_PM))
+		ret = devm_clk_bulk_get_all(&pdev->dev, &rkvdec->clocks);
+	else
+		ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &rkvdec->clocks);
 	if (ret < 0)
 		return ret;
 

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261030-rkvdec-runtime-pm-clocks-41adcf141271

Best regards,
-- 
Igor Velkov <iav@iav.lv>


