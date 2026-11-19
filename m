Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106998;
	b=NlJ9X5uK1CnfbAyIEwW6fENNBAItB2c9B9zyIKN6EGNLqAnjknZ0ioGXvs+ko+EiOQXM
	 Hu83Loo1xRfTini3cOHCSmGDzPifneOV1ALf3Rlg6fYr9Wxa+OcNUVQ9SoQR4kdccPQqx
	 KzQhboZh2Kv1UuccBlvuF+bVWPRthh8SyEV6AehKyUDkBfhptCJEJwz0JR3qs1umFESNY
	 3rDePhpIymFc+6mC8VTu9PlEdVGBnSQdykYbmR9WSM4QEEPGbFTLZpU6Q1OjHrb+N+7uP
	 r7kXYWaH6YhJzuzj0vSZ3nerzT8KSFQjWMGVTXEuO4rEW8zpwv0wcYfEHtRUvy782Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106998;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mAqiKgS+wwdvfgXgvcuSoH83FNvbFLBFfGQ6xTqp5ow=;
	b=KqqFzsKdW0HNCI/XpkOBTYLlZdMrZ/WK93DAT5pm24LLwib9DDf3wfNrHB7M/dwkfSuf
	 HXuyhYBILTNM0NrumBYHxtfT+eiN8HjseqML2KgtuWFYCpW7haCJEcC4Wzpli5gzoxvsY
	 8QdiLUm4H6Sj+mqRahucYWaHqdcthohWP5XTmChK0mdenpyNPn2pWdlDuUoBJzPWqvp2H
	 3kFomycT1J8StTcS/Xnml8IH4/dnDiwk6QhN9DtVPV7KkvWK6mASBPT60RU0z9ZgTG5wa
	 DGvJCf3c4DulMdmKapRChyzvHuIAzPhVLoRSwEp3OZpEJeeNYuOCUla79ZUorW11/gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhwhXNHd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE90606A33F;
	Thu, 19 Nov 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhwhXNHd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795106998;
	b=eDqxqAtRqDVW8gwrSnOK423WiWrzjSXDlXGJK6D9E/GTW1fDfijdLhBKmof7+YJUHlB4
	 xXmFsTl++KdhrHXExyl10V98gg/1Bclww4/tioTWnl5DesXl1/8lxX0j0+dsl65UBnZks
	 i/1t6OCGV45/Ysna/3Dv3yssbGGQUdE4ZNExiiNusdAIBXo5/imTQMNBXverH+SQ3AL8o
	 t0x030OEYI20whv2sK1BXEKCTqKjFtxMwQlwN6ArIvsTqJt9QRUGfOAfa+n4IoAe/kq7K
	 K58TtNZ/oEmEaDNy25GWcYOP8eDH0b87odh+kDekUZc9iQ6H5x3YZjkVq7pusvFG6qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795106998;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mAqiKgS+wwdvfgXgvcuSoH83FNvbFLBFfGQ6xTqp5ow=;
	b=xu3pk8C/EIvj93driW32R/rKvxw8UbAMRSpW6ojdTeCNTNFe+uvZ7QEM7QwBoIA9n5KF
	 ul79pHWjWnX+z2caM8xqd18aFPvXuYJKdCAfIN8vAom/xlaCSS4soSlbxfoOzvGEzuYso
	 T5iXluN/d73yhepxldc8669TNK8iEJ1NCYHYk8HgZ45xNEXeLaSjUqVaKCLHL9jy2UrUt
	 17zJ79JywglhpfjZX492zwzagLGMjITeuH0GLwHbvp6FXTOSWhhnkGbZfxE39G+0GqvrE
	 IHNKtUfHLL0NORWZpV2bySdLjvUh7CukseowwLTXY5V1QIdTjIXDx/0jtdGUeE1Mwkw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 79A401F000C7;
	Thu, 19 Nov 2026 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106997;
	bh=mAqiKgS+wwdvfgXgvcuSoH83FNvbFLBFfGQ6xTqp5ow=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mhwhXNHd28S4hqgXDUZ8sqZXHziiHxz97dozbCZ8WlPS5/hVl4tOHnprVoEAmM0h5
	 lncj1xXm5IUgYPLCDLbeDSKrimMTjUa1bbeFkhDCHCHfoXi/q261ccKufEaX7MFajw
	 Kj+k6vrdBFMA9ma5BFZXM4nrJhjNI1LdTqAk+miQgYiNtBh2nzMKzL6fbMI1jUujRj
	 DraGoaurYnDtW93PWDFP+0NoJUS/BCX+5ouA+FDRuGUAUudJw5pEnPZ3g/3codVRc/
	 Fr7mg0n16AsFsxhhipQGaFKdjOtehsvZTHtnietZw98rdniiUSL2YfYXDEaYaZgGe3
	 S5DsLAoCLKtTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CB21E4B35E;
	Thu, 19 Nov 2026 16:49:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 16:49:56 +0000
Subject: [PATCH] mfd: syscon: Put the clock after regmap_exit()
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
Message-Id: <20261119-syscon-clk-uaf-v1-1-dc4a4c1be353@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAyA4VeRnA2YQgfuVcRD7ZIt26jSqGyI7
 77qjt/h/zcwzsoG12qDzKuajqmA6griI6Q7o96KwTXuQkQt2tfimDC+X7gEQS/ifMuNBPJQoim
 z6Occdv3ftgxPjvNxgX3/AasTtmlyAAAA
X-Change-ID: 20261119-syscon-clk-uaf-5ff259e0fa15
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795106996; l=2258;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Xle/0X0eA0Wa8LPqfRsJuOjguZ9Uh3tFLZYrD/TPVc0=;
 b=CSfb7vPXlkbnKosHL34ELamSXGEOplysb5QTiVCvPbHPMuJkNOoLYHgzqU5XwlnEDa9kflzrR
 tEPKbFI7j9vBF0OOASG/uy9G7lt0p7E2xUVIEsYLHbr2QX63JuvTAI5
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

On the error path, of_syscon_register() puts the clock before
regmap_exit(), which then unprepares the freed clock. This happens
when the reset lookup fails, e.g. with -EPROBE_DEFER.

Put the clock after regmap_exit().

Fixes: a00406b71c5f ("mfd: syscon: Add optional clock support")
Fixes: 7d1e3bd94828 ("mfd: syscon: Allow reset control for syscon devices")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/179493691305.3136.16311404541139130213@kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
A related regmap patch ("regmap: mmio: Don't attach the clock if
clk_prepare() fails") is sent separately; neither depends on the other.

Tested on an Orange Pi 5 (RK3588S), 7.3 with KASAN, together with the
regmap patch: with a forced reset lookup failure, a use-after-free in
clk_unprepare() is reported without the two patches and nothing with both.

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed every change.
---
 drivers/mfd/syscon.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 21a7fcdd2737..3ff4e024542b 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -132,13 +132,13 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 		} else {
 			ret = regmap_mmio_attach_clk(regmap, clk);
 			if (ret)
-				goto err_attach_clk;
+				goto err_clk;
 		}
 
 		reset = of_reset_control_get_optional_exclusive(np, NULL);
 		if (IS_ERR(reset)) {
 			ret = PTR_ERR(reset);
-			goto err_attach_clk;
+			goto err_clk;
 		}
 
 		ret = reset_control_deassert(reset);
@@ -155,11 +155,10 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 
 err_reset:
 	reset_control_put(reset);
-err_attach_clk:
-	if (!IS_ERR(clk))
-		clk_put(clk);
 err_clk:
 	regmap_exit(regmap);
+	if (!IS_ERR(clk))
+		clk_put(clk);
 err_regmap:
 	iounmap(base);
 	return ERR_PTR(ret);

---
base-commit: e5bcc8e02e570e3eee46d4cebefd552cc7c9e843
change-id: 20261119-syscon-clk-uaf-5ff259e0fa15

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


