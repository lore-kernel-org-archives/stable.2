Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D23E49FE
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138032; cv=none; b=YQeaExVs8JIzx+XLoNwfOC2KIua4ZNwFfpmZ2wh+ha0EmRce3HP+ZJxM/Pg7Nql8/HCZD/J9RgUwxTXzXqGEW95i+ORXOLX3D9yCAOuQaHvfC0mdVNzzDcSeAbGOFv/lafxzF1OkmBiZkUYapMheYMIS0tQEq/bYUwOtiRtqtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138032; c=relaxed/simple;
	bh=LZZj8EbkJxePHcJk6g7+hXx3EPc2QneIFCk15fTpCcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+Y04wGkPlYsv6d+lrQhMCyAEU65HL/ggsC6RXervA++qSIy20go1ASJ/CJO8i3s4r7ORKs7fjZxesOoSmDKQj7Dy1VFvHNr44EWXhAvdJCmv986++Sdl6H6ZEYeUe2a9rfaNECSTlSElHa3Y81gExV7skrNsrdC9JU6SVnG5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiWsvQYS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiWsvQYS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1af482519so5530155e9.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792138029; x=1792742829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3s7Y3rGbVQHjeQTGR22MPi3o+zLfgdO+VLKMqYAthE=;
        b=jiWsvQYShhF1RCEkGK+Jt03icI+0SY8Z3+GWoswmVjwiXAmbUvyjW+Am9OfTb/Z18Z
         93ad0wjZ9EFf2GiMb3MIYYAOMAhSjN4e4s6Ij8FZyK1YDz5t5vwC6dm+XkxJ0lb+G8MJ
         +EnFz+VgbYDrVBnAwbiMSi8QgywgbzqHprbXk41da7kS6fKQx+1dKEOTXK292tyISPAS
         PwG05aTert/xwsXgLuTYOtqKkrb8ZE+JDl2Xp4t08IHxS4f4eTrYNAGIQCsGZMdKglzG
         Za8EZ2OKLlpwSsNUKEZ5y/blupofEecf73lYMrwh6EaebcBqQywygnPk18+DySSEsHJC
         SR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138029; x=1792742829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3s7Y3rGbVQHjeQTGR22MPi3o+zLfgdO+VLKMqYAthE=;
        b=Azz813u3UywkyTKC/mEWLGTZ+IujlNccgwvuYoOU79cG6JwXSKAN8HD9JZ2g6Xvx/m
         YBTni5HxYFGEAsbkH4JwPsigZIvNQmq13TpJYBflptDiDBGQ+f+q+gSDCOmP6PUl/0tl
         6x/Wfse9pX3uLVcZRHkJLLj4bX9GDPuwMrYoPIa6VHyKDUd22O66FAfdOLDxEiiYqC64
         HxfGKuT7x4l8CnzeoAIZCvWAnvsT7O8mjSRnDeUyn565w8uRNKCoGojCCCHK37zY29H6
         TFyQP7p5fJrUactP5mHcL1FeeyHi4qL9gzj291R4pRB5Zq4yoSciYhr/3R17aVG4MDh3
         eUZg==
X-Forwarded-Encrypted: i=1; AKwUvBwD5adnieRf427qPt4lNjW2AtNSY/aKNWgMDAPvEEISY5MwKfl+z9cmgLcAV0JgvXi10R+vREE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIggC2yKiBrwXhKfy2pN5BoWy2jiAeKmfKlGOdMC+Yl8kPb8QJ9
	+xIaGCMI02RI1GNWzisMjcjPUOK8IfJL9eWSnqTJkQpVRepDqCkBt1snLY247naG
X-Gm-Gg: AYBFou1CWYrLFq1tlNH6hIgHgIH6IlOiIPTAM7wukd3MISsBIE2Y62cVuXecw4jteGB
	GXf7+i43eo1YyhYInru9SZaE8Ok3yX7YYm8gSSLrBMBJmINMzMueDjIvEV9r7ukqVaRWSl5kGWs
	XISqQzVXCwTHdFUPmhuoXuc8JjTkDfBr3mcV4FW6V0HMDIlz0aUsPbdkSdELBqQDiHx8AaUWOtx
	Bn2/U39FEhDQnnKZ/lcwAlmsdjGW6X7H/J0U+fD7KGmfKxHlcUG6jxd/FZsSGIb/pwWUN6nXpy7
	mS1SwhzPiJ45a1wv8XJBRdmQGyLWbWLkA8yftI+rY4d9yGgM9pw578psG0461351fI0qJUumbUN
	6dJgMXZu0nINRM8ksyV13I2UywGN4WuT3g46v1IZxoEivyRdRelzQCGNRmTEF3kPxQEYim0VEqZ
	7E9GxBpt4vh4wl9IDDGiD/8MFs/q60UNCmN+jcVoid7kFMGe+gql5zBWF6zIA22Vny+a6oxiopD
	Ameu+GfDros4elq+HaHQPZ6hnr2msFa+b5jR2plolNNL/oyWRXdTu1PhrGVWINnR/rmUloT2YOq
	FKuztVrYgWnkB/Lx3W6EtAvj6sCGJ06b4LdmveizPw==
X-Received: by 2002:a05:600c:2154:b0:4a1:ac66:604b with SMTP id 5b1f17b1804b1-4a1c6635d20mr38433285e9.1.1792138029035;
        Fri, 16 Oct 2026 01:07:09 -0700 (PDT)
Received: from cachyos.tailab2f6.ts.net ([217.180.53.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c91c68b4sm17340125e9.1.2026.10.16.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:07:08 -0700 (PDT)
From: Chaz Bailey <charles.s.bailey@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Chaz Bailey <charles.s.bailey@gmail.com>
Subject: [PATCH] usb: typec: nb7vpq904m: Set client data in probe to avoid crash on remove
Date: Fri, 16 Oct 2026 09:05:17 +0100
Message-ID: <20261016080517.156248-1-charles.s.bailey@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nb7vpq904m_probe() allocates struct nb7vpq904m but neglects to call
i2c_set_clientdata(client, nb7).

In nb7vpq904m_remove(), i2c_get_clientdata(client) returns NULL, leading
to a NULL pointer dereference when accessing nb7->retimer or nb7->sw.

Set client data upon successful allocation in probe.

Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
Cc: stable@vger.kernel.org
Signed-off-by: Chaz Bailey <charles.s.bailey@gmail.com>
---
 drivers/usb/typec/mux/nb7vpq904m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index d1fa26ff44..52e3c9db35 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -396,6 +396,7 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	nb7->client = client;
+	i2c_set_clientdata(client, nb7);
 
 	nb7->regmap = devm_regmap_init_i2c(client, &nb7_regmap);
 	if (IS_ERR(nb7->regmap)) {
-- 
2.55.0

