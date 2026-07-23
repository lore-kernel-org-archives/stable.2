Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123004E3778
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826226; cv=none; b=E/tRv74o+Gcr5HHzN/+YObAQtAajqWTUZt2gHNpcq2S2fZIuVWjyVN2gZmtSH5ysIbLH5nndh4sFK55ypyfCBJfdsMS/xw7h9PeoMbin5mnPYkfoJWk2OcT9eGGmTaGXTLiCqt78eBP08vixWw5d4m3ZJfCrQnLtm6wmb/LH3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826226; c=relaxed/simple;
	bh=u1/1doUTAJtAw3WApxgMzOxJNDnBx6/JDvKS1fz2c1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syFouAM+DKNTZMuL7ErCZ4ABKFwQ9dkSufSLHMivZYzr2bC80p75MMYDzZGjgMptocSeV2ADNPEzT+RfXIFMZsXZ8Z8Em/n/1RvpT1LOqg3VphHhf/4USZpet4RHcdX2mLbfdZBJ/I/hkdjrl9Cmtm0gqhbXelraX3ie94H4UuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfAKqLWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfAKqLWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EFB1F00A3A;
	Thu, 23 Jul 2026 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826217;
	bh=I0WQnV1awbh/vIH0HTlDChCP4D0sgpomcAcAg17kpC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfAKqLWW8u8J6Mv68ZIjCYKTWuxreH5S+Sw8cD8mtU/ECubvAutGLzT0PVN6bDdeP
	 w0jCkvwvF+lgtqL8BDKyHYYf4iPS0zhP/UhqNeXXlud/mwddyaX/oeCF5tMSsIfXzV
	 DDB9l+mHYkQq+FPJyZvUYU8+veoQPj2WFPqQEwOURzSV96aZumwXoOGc5guS24LlJZ
	 Y9cz9JgRQtirObGQNCJiMtEB1FEkdgKKDm7mv0HogyDWQkLuisX1QGps3+EY6LRGiI
	 S++PZQMys71uulgcdjz7AZRrk7eJEXnY2aQPrjmTcww+5+kWPY++/JnLmEeXXe6xfB
	 ZaChSgFaVu1Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
Date: Thu, 23 Jul 2026 13:03:25 -0400
Message-ID: <20260723170325.3399838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072004-whisking-poncho-be11@gregkh>
References: <2026072004-whisking-poncho-be11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit c1492da3939c89372929e062d731f328f7693f1e ]

The pinctrl and GPIO core code make exceptions for the -ENOTSUPP error
code.  One such example is gpio_set_config_with_argument_optional(),
which returns success when gpio_set_config_with_argument() returns
-ENOTSUPP, but reports failure for all other error codes.

Returning -EOPNOTSUPP from the pinctrl driver on the unsupported pinctrl
operation may lead to boot failures when pinctrl drivers implements
struct gpio_chip::set_config, the system uses GPIO hogs, and the
struct gpio_chip::set_config implementation returns -EOPNOTSUPP for the
unsupported operations.

Return -ENOTSUPP for the unsupported pinctrl operation.

Fixes: 560c633d378a ("pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks")
Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260515124008.2947838-2-claudiu.beznea@kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index aaa783c79e6dd6..e8cc83029db339 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1097,7 +1097,7 @@ static int rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	int bit;
 
 	if (!pctrl->data->pin_to_oen_bit)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
@@ -1115,7 +1115,7 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	int bit;
 
 	if (!pctrl->data->pin_to_oen_bit)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
@@ -1552,7 +1552,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
@@ -1634,7 +1634,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 
 		/* Check config matching between to pin  */
 		if (i && prev_config != *config)
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 
 		prev_config = *config;
 	}
-- 
2.53.0

