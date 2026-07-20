Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E3428485
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554937; cv=none; b=qPRbF6CztzAQPtVYxhpJAtpv6zP/I3rpMdrbLbi8/EAVlmBPafUhoDFdNSXAdrYxDnZW/KQPoyNH0AEII5a5FId5k2UXcwneqfiuJD/jbqdC2QWNwZ0+LQRJCRlxHcPPN89lEitKGtNWTQGMmeKrdNFKXcfDidH6ui3/3FZHlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554937; c=relaxed/simple;
	bh=88r5Ndq9EDZSoiuw9bYNi+5VrT/2F0kZeyGL7sNQ+LI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mYM7r35sF9oUCNuoWSEbiLuaixvHBFGe3WXTKnk8uqqmAS1uVK5z2nj1quixgTVEnBdZxXBgxUeMV8gapRd5BssDQh2oqwr1Qv++4e3f4LkB2Y56K35qNGDE+L2/QcPuhSFEvqXywHSk7EgHVxGhvfF7PO6bWaD+SFrJ6HSvpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dw4ggapl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dw4ggapl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A9A1F000E9;
	Mon, 20 Jul 2026 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784554933;
	bh=+HmTtptAYVgSPw4oB7HZzBr+w8DrPHIy/NVQfIHgawo=;
	h=Subject:To:Cc:From:Date;
	b=dw4ggaplXIw2tQi1P6EYM26orgmwDTJSWr4KEKaWUq2qHQakOhBeddYf1qt/xsat5
	 1M26mqpHJZWPJKohd0Z8zo1o14w6tkAuMiUTtIeOoxF31iCVNcosy5GSSgTaF7pwIt
	 rhTao5/RGRs9k3kE1a9iJWB5HMlvDf0c1hWq5rIY=
Subject: FAILED: patch "[PATCH] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP" failed to apply to 6.18-stable tree
To: claudiu.beznea.uj@bp.renesas.com,bartosz.golaszewski@oss.qualcomm.com,geert+renesas@glider.be
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 15:42:04 +0200
Message-ID: <2026072004-whisking-poncho-be11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c1492da3939c89372929e062d731f328f7693f1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072004-whisking-poncho-be11@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1492da3939c89372929e062d731f328f7693f1e Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Fri, 15 May 2026 15:40:07 +0300
Subject: [PATCH] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP

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

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index a106e087c224..05a33655e6cc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1281,7 +1281,7 @@ static int rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	int bit;
 
 	if (!pctrl->data->pin_to_oen_bit)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
@@ -1323,7 +1323,7 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	u8 val;
 
 	if (!pctrl->data->pin_to_oen_bit)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
@@ -1754,7 +1754,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
@@ -1837,7 +1837,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 
 		/* Check config matching between to pin  */
 		if (i && prev_config != *config)
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 
 		prev_config = *config;
 	}

