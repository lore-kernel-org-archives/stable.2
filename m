Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121303;
	b=bOdutgjc5JGMMWHOZuX74A2w6gowozWnyVZmiaf4QzD9KRFk7m6ftJt4F6PEc+Cam0ig
	 wmudzjcvphZYMLrlnWH38d6FULwaL6Qrzqqqx+Fhbq+VbChBju/+DamaBrIREEUJDdU2Z
	 YxejiwZr3AUXYq9WVL9SF0fmu/4SR/VtgTwSUxpJdY7XEoHuDKZVvrZvQH/Mfjj0VbYt0
	 Q3DqBlsTCEyV/16ao4cAMm/xacRbEELhL0LAMfHdpf+oSIEpxup5xTERslLeM11kCNNYE
	 zXSb0eCnlY7JKqIKidebpJ2bb28zfx3jbR//hYHtNYwfMbu+T1aJQCKYErVCKzCSXMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EndSbXDsC0y1ohJLGeRrBlrjI2WFQTAdaGmEEeAXUf8=;
	b=TXwrkUikdGqm/PhFcK4Ub6QOjY8cyZVAzWOe53XqoUQbGwBOiE4YYtoyZq7+wSjPjQK5
	 ADIABJ2PETDZkYH+JUmS3KCXd7OZJOZyCHOe6V1gge/RC7e/qSmaRYyB9qiUpFVBiPZp5
	 zDz3mwtro4gAVzGF0ydGuygjV2dc3cH+v15IJ73rS3+BI5Wyh5fRgu84V8x/RmCOrpAxn
	 J+yu6rgHqivMUSK22DeoOGjQcsTStMZ7EgPoKx+PM0bP7dZevdzZ3izVmTUF9Roq85YiA
	 JfJ7cdL8pGTa8T0o7GIy7q89ms3inRjj1N7hn+dppvhMC7zztv6ilgkREdaNa3h/CXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EItI03EO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF207606CC61;
	Thu, 19 Nov 2026 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EItI03EO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1988F1F000C0;
	Thu, 19 Nov 2026 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121303;
	bh=EndSbXDsC0y1ohJLGeRrBlrjI2WFQTAdaGmEEeAXUf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EItI03EOLoaZUJBsGnIempT8JfESUSibqtx3QFNiORQYCOtFwBKn3cIOmHem25V2G
	 ioqYDVHI4Spy+O37sYF6fl5immdCW9nggS8BzQzsg7gLbmfTd/UR5zQmWGHAC3iEJW
	 DVGP8ThBAFdQEV0KmT4HrC3bgvh2lVoEzEu+akT1bWF+hsNixqG+28ff/SYbkMtzVV
	 545QugZgLpja1i3aW72iJn/TD5JNZvKZcBK2SskNsu38NEp4fPiawaL36i1aTljOT5
	 RHWwoN3wPOXLxo/oKoJyduO5YY09RWL2wq4TMhsetSEpKU0D+l89E9Kq0netIxGBK/
	 XtNO+3wawbKJQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maoguang Meng <maoguang.meng@mediatek.com>,
	Hao Chang <ot_chhao.chang@mediatek.com>,
	Qingliang Li <qingliang.li@mediatek.com>,
	Nicolas Boichat <drinkcat@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 4/6] pinctrl: mediatek: Guard against NULL eint in mtk_eint_do_suspend() and mtk_eint_do_resume()
Date: Thu, 19 Nov 2026 20:47:19 +0000
Message-ID: <20261119204748.2558209-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119204748.2558209-1-lee@kernel.org>
References: <20261119204748.2558209-1-lee@kernel.org>
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

mtk_paris_pinctrl_probe() treats mtk_build_eint() failure as non-fatal,
logging a warning and completing probe with hw->eint left as NULL
whenever EINT initialisation is skipped or fails.  However, the system
sleep callbacks pass pctl->eint unconditionally to
mtk_eint_do_suspend() and mtk_eint_do_resume(), both of which
dereference eint without checking for NULL.

Return 0 early from mtk_eint_do_suspend() and mtk_eint_do_resume() when
eint is NULL.

Fixes: 5c0904488a20 ("pinctrl: mediatek: Add pm_ops to pinctrl-paris")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - New patch, avoiding a NULL dereference on suspend/resume when EINT
   setup fails (Sashiko)

 drivers/pinctrl/mediatek/mtk-eint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index 827231dc0d24..ca47a416c666 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -427,6 +427,9 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 
 int mtk_eint_do_suspend(struct mtk_eint *eint)
 {
+	if (!eint)
+		return 0;
+
 	mtk_eint_chip_write_mask(eint, eint->wake_mask);
 
 	return 0;
@@ -435,6 +438,9 @@ EXPORT_SYMBOL_GPL(mtk_eint_do_suspend);
 
 int mtk_eint_do_resume(struct mtk_eint *eint)
 {
+	if (!eint)
+		return 0;
+
 	mtk_eint_chip_write_mask(eint, eint->cur_mask);
 
 	return 0;
-- 
2.56.1.750.gf70dc682cf-goog

