Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD34476689
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718164; cv=none; b=j1g7lzlkPSWsNXFP4OByAW1pPNCkC/8L1jayeGkusOFCn3zK/Lv0M9/EI5R1yn+8hl4XzZ2aSIfmgtUwdB5ManO7nA21VNZRlF70N1McPN4+kCPb2qis41co0Hhh591vuyiIjhhW0utmG+zg0BmLvaVRqaJjtw0Xs+nJbN+W5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718164; c=relaxed/simple;
	bh=sUTqIRZSbvA13/+qD/gSKcn2ecGzfR4G47NCjt1iUTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViomYYuvC4GjVvy+P3XEXBKT6LCoMppT+Pqj6x+qFBZKM7GlH744VBrTfThPJpZ5oDzOt1+jr7h8gR0vmWKpRJtDPBcRvHfvFLfOkwBKUZrYyybwOm4dcFX9wM+TSgrQb6L3lTY42kQFUXiuTAhR7Xtrf6x0RzN4csz6pSKZ6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C398A1F00A3A;
	Fri, 14 Aug 2026 14:35:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH v2 6.1.y] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
Date: Fri, 14 Aug 2026 17:35:51 +0300
Message-ID: <20260814143553.2949913-2-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814143553.2949913-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260814143553.2949913-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c1492da3939c89372929e062d731f328f7693f1e upstream.

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
[claudiu.beznea: fixed conflict by dropping the code not present in
 v6.1 stable]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- mentioned target stable branch in patch title

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 1304ab0bcac1..85bcc9bbe677 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -708,7 +708,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		}
 
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
@@ -757,7 +757,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 
 		/* Check config matching between to pin  */
 		if (i && prev_config != *config)
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 
 		prev_config = *config;
 	}
-- 
2.43.0

