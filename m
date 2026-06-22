Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8D382F2F
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114825; cv=none; b=GZ//GwWPbW5C0/Rw5JxtVlyAoWYie6+Fd5IoG2Dvnk0oneZQ+UBjlXcHoFbfzlMMPO7v6PuNbMAiVg5bBpsYLOguGQq05cl4bw9Yn9FyRypZAXLTpKurZs87rt5DjUvKgbhrQJNPOa0wZ5JpPk+SYQxQuA946lUIxX5LAifTxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114825; c=relaxed/simple;
	bh=kwPAUQHA46UWAzKtvEAsrpO6XV/aeWY/zPZEW9c3HjU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tSjWLrO40sLjg7/1ZjABRYD7MZ/6+C6Pp3lWUUcWYf3Qo/7In2DKOD2P3jBcUOQs90AWOLQIOcan6flAxJyjUCqCVAfBG4JqDa7u0btHhIKCLrHIArYt9ZtPdCktKrywyieDvpaOTBpIJP737ZFmslRkRluRQos72LvHh59TajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD3D6mmw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD3D6mmw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c379e8ffso33215185ad.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782114822; x=1782719622; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muhh0ZwVTyB0/KcADVsIhtg8n2TSc3l0G+5X+uSwFu4=;
        b=SD3D6mmwLaW3/dquDGLd+NGimfScOJx31HW2jKD/HRtxxPDZnm+mR3e3VGES1vhcH8
         4G6XmMfp0OXA8YsYn1gZ+Hn3+lA7xal7d0nBM4VuKENrUPqlXN3RBKvL64WMClSG5QOe
         azd/gmtNV9vpQTOUbc/O3kXiHyXIvOP+nu8Z57el0up11+Jh9UtmFCCMhXC9QUefj+Pd
         P3UfrCUdVlRnd3G056UZIAAGyGGPdgVGV9pVOX6yQMYzCVzywUYtqgio08asYaeIw0Km
         TaE04696N5j9kEeqrUJdMPwYVZIDsb6RhNAxkDdItq0Yrmq/pMooEhtfyhTm0e50kA49
         kiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782114822; x=1782719622;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muhh0ZwVTyB0/KcADVsIhtg8n2TSc3l0G+5X+uSwFu4=;
        b=UaYPkk3zwVsMO+MxVnPokWFuCLy9SIhtLxhj0PPRrR7NNJ1JnmEh9+qcEkR3Ogdw0c
         2lwageAEWdpW2e00bmTfTm8bKHQQeqF532QgrrUl3r7wWH7zSgMxw6cTJgPxqMd2NLvW
         z6vcPnPyDKA4xfGxTiV6IWnWb7RXGxhSaKH4bS2MqZf+G7+AFVNhUUIX1fUXquOVyHM9
         mcL/2eWhYI2by8282XDQUGuIjMAesnbuCfCzZQPWxnQx+J4um1luzZqmP6r4Zpu5Yl0Q
         1OI4q3fpSp8+689xe2ce76YiK7BcHWlIT8fXEH6y43yO16QMxS1L01RYG7vxq4Lcs8Qp
         G/Mw==
X-Forwarded-Encrypted: i=1; AHgh+RqkQcjtbvbvnjapSrbGGieIacFPFUC+6r7A+e2Qoift8rxQuYhkOeYTjYKeqChFU3N4VYQihsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiqWwwvqTeZUb+kgW1QytBv/Scw/2UGufZNAPk0C7gdHuWcdG
	ZtvczAFFMKNk8BN4w6VSAbA7huD2O9kitmGBBwarWifnzTLItKv8HQ6E
X-Gm-Gg: AfdE7cl9Bac+al0fE80sn7EGsye67QNjdoD/zXr3jQqi7xWIOxmn1r08LRjV+zQOha5
	w2L3aSLHKigrCsJclQdX7owKiMhAbriEwON1/ZfxyVrkkTIXFV7PysIdn9LfZ09zrVvTuI1UWyM
	Np+tCpjSl8frKpclp6QU4fdI5wsDV8jPBv93yr3Lj6c/ZSsUKZjuD8tUJxag9nfaD11n367QjT5
	MeGIJiNmLumyD6rWR/dr4ugNOTrH9tsi2ZBs2MLgOFgDVdkLHH3XzI9XMFI2FEXSQeqjH/Nz+4l
	FNG1RXCrdev1pTyOm01V5c24nMI4eSO9R9XhGqrtuIn/gSb0N15TRYKzUSwxrlsXOXw7T7h+KnX
	IO0HbHHnliYsZ4lsy3XW5z94othznbEwcF0ziXrDvMUkPh4k3dbYlRtWET90CYd+3U0YhjhRUVV
	FqmgK1fUdvOwyFY7Eji2ONTOwQmgm1RA+vJmbovA==
X-Received: by 2002:a17:903:1d1:b0:2c6:d70a:92af with SMTP id d9443c01a7336-2c7190576c9mr133110835ad.37.1782114821743;
        Mon, 22 Jun 2026 00:53:41 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm79786155ad.78.2026.06.22.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:53:41 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org,
 libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
Date: Mon, 22 Jun 2026 15:53:38 +0800
Message-ID: <178211481807.2212567.8773346114561900100@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

lbtf_free_adapter() calls timer_delete(&priv->command_timer), which does
not wait for a running command_timer_fn() callback. lbtf_free_adapter()
runs on the teardown path right before ieee80211_free_hw() frees priv,
both in lbtf_remove_card() and in the probe error path. command_timer is
armed by mod_timer() in lbtf_cmd() whenever a firmware command is sent.
command_timer_fn() dereferences priv. If a command times out as the
device is removed, command_timer_fn() runs concurrently with teardown and
dereferences priv after it has been freed.

This is the same use-after-free that commit 03cc8f90d053 ("wifi: libertas:
fix use-after-free in lbs_free_adapter()") fixed in the sibling libertas
driver. The libertas_tf variant has the identical pattern and was left
unchanged. Use timer_delete_sync() so any in-flight callback completes
before priv is freed.

Fixes: 06b16ae53192 ("libertas_tf: main.c, data paths and mac80211 handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I asked about this on linux-wireless on 2026-06-15 and got no reply, so
I am sending the fix. It mirrors the merged libertas fix exactly.

 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index fb20fe31cd36..42be6fa22f9c 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	timer_delete(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
-- 
2.34.1

