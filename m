Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986808;
	b=rinPa5Z0emuuU0tgVuBLtLykb/aXnv1r3b/IscLSjLvA3N1k12GptLiYI/FEDeFE+99x
	 7TD748HQUD7toN2q0AZdGeJnxxbOcKFIpuMXwMWg32MITnNC7GVnLhGwxijK3aqPvJLCM
	 +ZrR2Aau/JJTBnpmG5ntBWsCaHH/wXBpX0QZLYNF5uET9k4jYBHKIdMFT4lz3EP2rpt/e
	 /rLU/6OTApvB/Eb0iK6RkzPJEK82m3/i1nnBNHk0IpUpHAmiorApHYnXYBuAKT+0l+Sn8
	 M9kiCnKZ5/SDXvnn3eCvcwo+93SHrxtfJ0cCEAIqrW1Mg1ygoNc3LDiVWrZCPQI6l+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986808;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=z3ZP6oVZ1OcWNdOE7xEo8+5SCqEaoKkv/Yt2cpff3Xg=;
	b=cfO3xap9GK1NXF8Ktr3XIFuFuCZRoM6fFgXsjXwQmlOgTjhfb9k+Fbe61/XgTZy634/P
	 1zfrXyKuvb5w+cGNfaWb8xbSEgMqYOXuv+hm5cHPJ35j8aemiJd5+A+PeLRhdamCuS/eQ
	 ebbZtCLpQ5ze+LGS3dRJ84LF5ofV6x7uXqzKUTS2LY6S7nAgasLfB+UeWdiX/v89NP/6s
	 p96/kJeJHCG3HSY6fmvQvW13xpqHgTAuOEFPhoThSlNv835AJ5SCFuRz/4miYKG1kN3oY
	 SrckcPymUK/MJBod241fTu2VYY6vdIXPMOdUTGKtOp/OsWMG6JG0cmYsQ+xdv1fZWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=tiGyKf07;
	arc=none smtp.remote-ip=210.130.202.134
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC3606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=tiGyKf07
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794986786;x=1796196386;bh=3wpxiOziBCJJPQwSkTWlDgUYcuQPme5EJKY3L3m3MJc=;b=tiG
	yKf07L/oIEi7PbjpGjCs2FofBneJZG0Do4sh4eIF1acWneJ+85mFs4iuJyVusRNGK2f3nmBNSi4Gg
	XpJ0XuYQeVS6oJJPVsdMRDzwiKbQgGEYAphg8n3BRykYY/kKSCnLDDT16enKONQ5Hh3CkpeGAXCz+
	gZIhE7W10nLfyPz4kJhUCIELmDjwAuT4aFD82KxC8bJ0Fa9OMns9ZqMGGg6WWEdTdr1GwWPGAqgzr
	EfkkxgCVaENqSajE3+DNyPmmAo0SYIL94m/oT/wHPdqhcjBH7g36QVPsgKwKvBisE1L3P1OKqw4Yt
	vYKt0jM3SEXHsADF+jzfyeBvKMiKwVA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AI7QQwd2306111; Wed, 18 Nov 2026 16:26:26 +0900
X-Iguazu-Qid: 2yAbofA4kxyEEKpVjw
X-Iguazu-QSIG: v=2; s=1; t=1794986786; q=2yAbofA4kxyEEKpVjw; m=td+8VKpqhdKXbSP7KW6Uwy061/6BgNW7vXkZtl4Mo2o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jTtSc3yNPzyQ2; Wed, 18 Nov 2026 16:26:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, Liang He <windhl@126.com>,
        Mark Brown <broonie@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y] ASoC: mt6359: Fix refcount leak bug
Date: Wed, 18 Nov 2026 16:26:10 +0900
X-TSB-HOP2: ON
Message-Id: <1794986770-15554-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Liang He <windhl@126.com>

commit a8d5df69e2ec702d979f7d04ed519caf8691a032 upstream.

In mt6359_parse_dt() and mt6359_accdet_parse_dt(), we should call
of_node_put() for the reference returned by of_get_child_by_name()
which has increased the refcount.

Fixes: 683530285316 ("ASoC: mt6359: fix failed to parse DT properties")
Fixes: eef07b9e0925 ("ASoC: mediatek: mt6359: add MT6359 accdet jack driver")
Signed-off-by: Liang He <windhl@126.com>
Link: https://lore.kernel.org/r/20220713102013.367336-1-windhl@126.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[iwamatsu: Drop patch for sound/soc/codecs/mt6359-accdet.c]
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 sound/soc/codecs/mt6359.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 81aafb553bdd..4eb199a190c9 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -2668,6 +2668,7 @@ static int mt6359_parse_dt(struct mt6359_priv *priv)
 
 	ret = of_property_read_u32(np, "mediatek,mic-type-2",
 				   &priv->mux_select[MUX_MIC_TYPE_2]);
+	of_node_put(np);
 	if (ret) {
 		dev_warn(priv->dev, "%s() failed to read mic-type-2\n",
 			 __func__);
-- 
2.55.0


