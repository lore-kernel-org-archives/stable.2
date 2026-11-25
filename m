Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795589415;
	b=nrvtgCne/nrC57wTUG4QboGiEXdrLzeGtL8DwYAe58i0r3fXNuwTQC31Sxb7H4E2ZxnZ
	 wRBBc7pq1dljBihpELMtq/97CvLlyfm9P9F2M8hgvH/Cs90W/OrN7g5iXY+yHb3mArBxP
	 lAq4mHDPg2MTFJf91VwKoW5OTCrXQIWBjr3PKWBhfPe+RdylKmky03JkfGjRXKEV05J/k
	 K2vX7AswsiUOQhzvOrJZAeWMFXcvugqAWBFji84UGCwDFq7V0gpET/HMpcM5VmeIuGHyu
	 QSyce6VfU+jKEb4UMQUnDv6q/HbxA0D1fNZy4GTe0YhYVmToB7XJOnZdy/ug8kZ+agg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589415;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=jQbWwtW7c6zJxS9K3xhG92j7QUM43OV08IzqQDH1bvA=;
	b=wCz3FTHOLWjN/wj4TfOaq35XQqvlxqEM+3BvCudhTsxErRUpJ7HZvI5tAlQDFx5KMp66
	 fSYy1GXbFKJmo5h1D6vwZSvIwmPtfVwzrWRwDqPWDDhFPMIm7zw/FcLAdYppD+J/nh4Wv
	 +C5Nx5YvHVjFL32pLiG3H3eJRKteTvZE+4uYD0IORu70tz5KphQOpneVfyxqH8LwFQvZH
	 Ap2Vmk+4YDLZ6dEST5CulrhcLENH2JOa1zWyyIXTCm1kIgthahcZClae5EhhtAyNBgvth
	 Jbw4xfAk+4UuwPFEFeePz8fbUNcbGimCJs18a5OTf+7yGmMSYBxwdyFKYqn2m5TDkUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=QaMzMShe;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=phjWVDlh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D3606A686;
	Wed, 25 Nov 2026 06:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC9D3606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=QaMzMShe;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=phjWVDlh
ARC-Seal: i=1; a=rsa-sha256; t=1795589386; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FVtj3d1H3i5Yw7A9+ndDu3o0vGw/mngwgROB77uo6fJGqFD5mQ2u2yCeROJTVNmUFj
    yC+0G/jAFNald3upUB4QTibSzweRl8uiuylN36Ievx1ZvVA1yABShUX4FEi52A4n3Cov
    IzNTjkZDb6GsrnrCF6HBCCW/7R3Iu2sWBnn2+eDYjnMA9LcYHvsTnwb2ROy/slljP//E
    yZfcjazaD8s/r3pfkGqtjKsaYyXgGGOy1FLOYxn4Aj9C1ai9indpTBiBLgS23j3p65mg
    iV0/ypIOzH8Xkt99o4E6QcOU1m/I1whVGAPlO0/csD5LE/C8qG4E/4r7/d1s7B5e9HJK
    BROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795589386;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jQbWwtW7c6zJxS9K3xhG92j7QUM43OV08IzqQDH1bvA=;
    b=kO/RZJ74ntfOlUeXNxUy7CN+nMCcljYlOeHBpvBHdCWCbXMFb86tghjpRdEN1d3YDZ
    EdkI+Wz629jiiB4YadifmmWT2VF/I5/CVils/5P4fnMp+USDk3ZdIXh7i3om5ulRjs7Y
    h7jKZILVnqIgKuKLjZwvBV2OxqhWDj9tYoQhcdEMNYGMgkqbuvUKP4poD7kMWp4fxLvG
    rWba1jui550ZQn84He67BBse7/y//gPxwycI0jXVgmHD+tCPQ45gF+H5gc6R0ClGCA39
    Xt6YtA45BJpQh+CJ07Yt8yJX4iSOzetuecZ7dSYiCQJEDTGeRI6ZsT6jQgXKQLlm8KJD
    SXEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795589386;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jQbWwtW7c6zJxS9K3xhG92j7QUM43OV08IzqQDH1bvA=;
    b=QaMzMShe9g0i9RntSqnjVZ7u3BTv4aRsnAVVkVSwbjm5qbHa373nWdI06jgk8dJH6h
    kr9tf2Qk8S/tB9n2p1HKP5ilxJWJzlE+U2Ej2u6Ea0gJiqQu8JmZdAtj4jfspPUebICr
    Bt+Rzh4kwUSINQlctq5xVj3XRHJWbReKQEono46GxoRAsaDSKfxu/OjH6of+xMYXCBzr
    /Nb6q1syDLnbEvlLyibf2T0lXNhp8pUH73nj4vlpboRcIcs7bNiKrYZXJFbsdqbSrqKj
    EEk8ci11/BHGQubTI8c7+hkeangSi3p7Uj6ahqOBl+c+ezaAjgGkFVNE+ncMYKA2NooX
    YYGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795589386;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jQbWwtW7c6zJxS9K3xhG92j7QUM43OV08IzqQDH1bvA=;
    b=phjWVDlh+ihj4kbLNe3OW0zwyyUG3n51w7Ecrf6ZmCRblM8u7crFeiOecVdlxomWxw
    tC2jrK7D6dXpGWsx26DA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrS25oMlMiNMn5e/Npe6SVDIvzG+5uG4p/zkDZq"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AP6nk5pt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Nov 2026 07:49:46 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v5 1/7] pinctrl: ingenic: Swap ID_X1600 and ID_X1830
Date: Wed, 25 Nov 2026 07:49:37 +0100
Message-ID: <f1a26d0a353e7d05b86fd407dd43ff002810066b.1795589383.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795589383.git.hns@goldelico.com>
References: <cover.1795589383.git.hns@goldelico.com>
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
Content-Type: text/plain; charset="us-ascii"

From: Paul Cercueil <paul@crapouillou.net>

The X1830 predates the X1600 and uses an older GPIO register layout.

Swap their IDs to reflect the hardware evolution. This allows
is_soc_or_above() to distinguish newer X1600-based GPIO features
like X2000 (and X2600) from the X1830 register layout.

Add an is_soc() helper for features specific to a single SoC
generation and adjust the existing pin configuration checks
accordingly.

Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes V5:
    - no changes.
    
    Changes V4:
    - Add Fixes and stable Cc trailers.

 drivers/pinctrl/pinctrl-ingenic.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 37310d9679457..88c5edeaaddcc 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -110,8 +110,8 @@ enum jz_version {
 	ID_JZ4780,
 	ID_X1000,
 	ID_X1500,
-	ID_X1600,
 	ID_X1830,
+	ID_X1600,
 	ID_X2000,
 	ID_X2100,
 };
@@ -166,6 +166,12 @@ static const unsigned long enabled_socs =
 	IS_ENABLED(CONFIG_MACH_X2000) << ID_X2000 |
 	IS_ENABLED(CONFIG_MACH_X2100) << ID_X2100;
 
+static bool
+is_soc(const struct ingenic_pinctrl *jzpc, enum jz_version version)
+{
+	return (enabled_socs & BIT(version)) && jzpc->info->version == version;
+}
+
 static bool
 is_soc_or_above(const struct ingenic_pinctrl *jzpc, enum jz_version version)
 {
@@ -4090,7 +4096,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 				!ingenic_get_pin_config(jzpc, pin, X2000_GPIO_PEPU) &&
 				(jzpc->info->pull_downs[offt] & BIT(idx));
 
-	} else if (is_soc_or_above(jzpc, ID_X1830)) {
+	} else if (is_soc(jzpc, ID_X1830)) {
 		unsigned int half = PINS_PER_GPIO_CHIP / 2;
 		unsigned int idxh = (pin % half) * 2;
 
@@ -4142,7 +4148,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		if (is_soc_or_above(jzpc, ID_X2000))
 			reg = X2000_GPIO_SMT;
-		else if (is_soc_or_above(jzpc, ID_X1830))
+		else if (is_soc(jzpc, ID_X1830))
 			reg = X1830_GPIO_SMT;
 		else
 			return -EINVAL;
@@ -4153,7 +4159,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_SLEW_RATE:
 		if (is_soc_or_above(jzpc, ID_X2000))
 			reg = X2000_GPIO_SR;
-		else if (is_soc_or_above(jzpc, ID_X1830))
+		else if (is_soc(jzpc, ID_X1830))
 			reg = X1830_GPIO_SR;
 		else
 			return -EINVAL;
@@ -4190,7 +4196,7 @@ static void ingenic_set_bias(struct ingenic_pinctrl *jzpc,
 			ingenic_config_pin(jzpc, pin, X2000_GPIO_PEPD, false);
 		}
 
-	} else if (is_soc_or_above(jzpc, ID_X1830)) {
+	} else if (is_soc(jzpc, ID_X1830)) {
 		unsigned int idx = pin % PINS_PER_GPIO_CHIP;
 		unsigned int half = PINS_PER_GPIO_CHIP / 2;
 		unsigned int idxh = (pin % half) * 2;
@@ -4298,7 +4304,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-			if (!is_soc_or_above(jzpc, ID_X1830))
+			if (!is_soc(jzpc, ID_X1830) && !is_soc_or_above(jzpc, ID_X2000))
 				return -EINVAL;
 
 			ingenic_set_schmitt_trigger(jzpc, pin, arg);
@@ -4314,7 +4320,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_SLEW_RATE:
-			if (!is_soc_or_above(jzpc, ID_X1830))
+			if (!is_soc(jzpc, ID_X1830) && !is_soc_or_above(jzpc, ID_X2000))
 				return -EINVAL;
 
 			ingenic_set_slew_rate(jzpc, pin, arg);
-- 
2.56.0

