Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B202C1788
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070166; cv=none; b=iRmnVVFNYx3+z3u/hsPaS3MwqQgy8CU1Xbzey5hiPho8SeRtQKGFyUbg0eIm+ms9R5s2C1YpkgO5pldNJPG4yEHQvUlZnJoMvlm/LPm8fL6zNKeeZpbSNMuBwQqNWyHnJh5ugvlFspGrtnn9YEkhW5s5MNTBIrdYPtd6/9y72S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070166; c=relaxed/simple;
	bh=0uE5+Uc1NjxszxItTNMxYFb1EMiJnfT5mJ1WJK7B9oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAP5XBwE0QRTmtW3hhaRyn2Id0ygKVeaCj3jFXjlClkgwFiJlB4LJLWFyhASraaXl/OgGGoLMpyu2M2Nsr2S5PCBruoq1Ci2uKW25f7UHvnaS/Yt+KijaULzqpKCKOJu1S/OC5u8JiaLOIgl6TOd/n6DweMbDhYEXIf5JLIX6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB1SAd/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB1SAd/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A4F1F00A3E;
	Fri,  7 Aug 2026 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070164;
	bh=qVX+qewFU7gZRBBXeKz3txbQKMIG5Vh7D7iGt9ot6bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fB1SAd/uKgsOdcHcXtlZROnIdC08jpkkk6/+FcmSJ0QED0bCJEdXyrW6p5owYQT//
	 AjQito/mI1nWAIAaiEqPaCl+C6Ojxg6XprsINWSXzuSxOebtSAjDdRdWSmwG8CznjL
	 gebc6i5lLfJKpL8qLtqdMHso8iUxs3bRrVvEZHdpWMYxZWugS2/H90AztlM4Lx83+R
	 x0Bob3MW2quag05KED33qcB648N2WXUS8L9a4bujfCUpTR/hxHKUmx4DGAOdsxRD+2
	 YCOGccGoMRGMekWQebRqsSek7HEI4tkmNDibo7kVrsvoSxpMXf2VGKHy7oYxI947Hb
	 hgKsDiXsJQrHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] serial: sc16is7xx: remove obsolete out_thread label
Date: Thu,  6 Aug 2026 22:35:59 -0400
Message-ID: <20260807023601.1683108-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023601.1683108-1-sashal@kernel.org>
References: <2026072914-stainless-finishing-0e3c@gregkh>
 <20260807023601.1683108-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit dabc54a45711fe77674a6c0348231e00e66bd567 ]

Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
in probe") moved GPIO setup code later in probe function. Doing so
also required to move ports cleanup code (out_ports label) after the
GPIO cleanup code.

After these moves, the out_thread label becomes misplaced and makes
part of the cleanup code illogical.

This patch remove the now obsolete out_thread label and make GPIO
setup code jump to out_ports label if it fails.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230807214556.540627-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af071d9e07e5 ("serial: sc16is7xx: implement gpio get_direction() callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 81407e1c1f015..177e9eec21725 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1399,7 +1399,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->gpio.can_sleep	 = 1;
 		ret = gpiochip_add_data(&s->gpio, s);
 		if (ret)
-			goto out_thread;
+			goto out_ports;
 	}
 #endif
 
@@ -1425,8 +1425,6 @@ static int sc16is7xx_probe(struct device *dev,
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio)
 		gpiochip_remove(&s->gpio);
-
-out_thread:
 #endif
 
 out_ports:
-- 
2.53.0

