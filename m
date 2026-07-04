Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA27383C86
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206912; cv=none; b=QHOSfu5aKvPRj+0IEmsBTmpK9J790xAHtOBRvEuwJE6haOBv6y/RQn3VaDjWGS1rpPrRM09sWEySz0IWQ8bePOQienI3T/ZhouJKIH9gZZQpJlfRHCNqYQ5k+IZvxcDznbivCUGZeBO7k1tWHh7YSoNde2F0oU835DoCBqGqb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206912; c=relaxed/simple;
	bh=e2BPamJm7+oCvVkOZXZ7WWzDD6bJtBXALaaIxF5F7ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ws4s2PnshTStScGTN+xtnM/UI636QWHyJLkf4s6Ofu1lf/SMwEu7n7fqR/Fixn0t5ZSsMjy0B+xapvyEf5suKZL+wJehPqu+49H0WUSIPpIwskfruAqR7rZC8ptjXRwMbjguPx1CioOsAzyCrKCp9uDxD4nKsV9MPc6QE+g2tnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay6V5xgf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay6V5xgf"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5b048375so74891785a.1
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783206908; x=1783811708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMpBVokVvC5Invbvqmg58wmiCwFqIiE4NTIeLL0hDKo=;
        b=Ay6V5xgfXffFyf/x7ugdMzpTXbbQ79FB0b4qPW73ULS64HTgYJCgZV4oop0Q6QS89z
         356zNjp6qgYHD9YTFmgnHygODEXtFw0SJlzQ6aPmAMOjBdyadN8nLuY8niF52rGEdFgn
         EmW02I+6llNC8DXh/RqpLYPQn+vp0/gO+Tfkx/2FjUTW6v6QXIsME03EcDPOrGjRaXaA
         KmcB3/FiBIIavxie6Yz1K54U1ogiK41p8592oIdP+LOocXrQIDldt+JjAUCmoqU/J8L6
         taQnc50kgbwY8Xx4fMz34Lr1tE8nTiyuCfSUxIV+PHrtkMyjlP+N5m11bScMKa9RpIKS
         xQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783206908; x=1783811708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMpBVokVvC5Invbvqmg58wmiCwFqIiE4NTIeLL0hDKo=;
        b=JAQxlIGfR9M6KkuATNJTMddJrhcDTTkL2tJ/xkml86Th2qjQpMoUgkq9FzU6Xxjqx0
         0t4wzkmCdjuQ7E148UTMa1emdp1ipnB8NWx83gZAt8I9qEzMTOo/Nmh9Xt+JKqaX48Yn
         Dn/EeGdBmo6E7ElZTu9FwEvVg7MFHXy6R0y8CeKqJVZDCZ4bQXAoN2YzFBw2GivVL6sc
         EOqpj6WCi56pI05igQEoy2qFkBV1qOCYAo8C0tD7NVzM/TzaZKN7rXKG0PTYG7ovXxwa
         jWYMKyTc3J3esyVM2TIQCKFmNB3+qUOkdHY6S6AGL+flh6JFyEC09p8ZeMv4VLztKJTV
         L0uQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Pe+Ylbd32uh/4Rtvtz9MGS1C0p0xpdOAAS2qrp6y5tMOubsTwD+sQ+KOSop2B7kIWolJa81U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrzPXbcAFiMcn3MD76Gd5RBRzcu+GnVDuw8NDxwRm7ntjkZ3m
	i6rx3nzLmGKVO8pT591z+VXEDaX2ePuvqz6ZwgAuSozNxRZ9hwkRUIZg
X-Gm-Gg: AfdE7cko5It93ZXvzmWGo9gigOiPnQYFEhZhrl25Ov0q8xfr92i6cc9A2Gef3LZFF2U
	0FXxCSuBgvSIKTOmXQK1nlmyHTarxcxRTUoY/K6y40AnjqxlnzqbmMmJ0TvL0m4e4xuD3E7gLND
	oSg2cDP6fPeleFRy5EF22xjSiOUAMJOlnd9w06EKREJmQzuKm7dL9khq+mIUMGr5oUb9q1jl03a
	zbc6G1lEU6FOTJ82xaWJ4BQ57mewIUcnE9smU7wMuVJ42Pd0EG2JcKmKCvvnKj0PYxuftmQmWnQ
	LFMCkWPnTwku7HcPK0h2f3oXwloOkhTJil2I7wPNvTq+e8c87YmVhQoTw7BqCqo7th7DYg52cpE
	VaYFjDH3jnT7c2Jzy7/iszaSyE0SOrVjtd8v8LtdsrRAdK8DaOkekXWsba+OZD6ebfsGwOSA6j6
	mHcC5IpNkuuSMsTntIwP1yG5g1Zwk6q/TRAu5DQXHbSMOtCvTVZqXB
X-Received: by 2002:a05:620a:1708:b0:92e:6858:2ed1 with SMTP id af79cd13be357-92e9a4cb049mr704080685a.53.1783206908591;
        Sat, 04 Jul 2026 16:15:08 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c92662sm500407385a.30.2026.07.04.16.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:15:08 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH v2] usb: typec: class: drop PD lookup reference
Date: Sat,  4 Jul 2026 19:14:36 -0400
Message-ID: <20260704231436.4060902-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_power_delivery_find() wraps class_find_device_by_name(). That helper
returns a device reference that must be released by the caller.

select_usb_power_delivery_store() only needs this reference while calling
the pd_set callback. Drop it once the callback returns. Otherwise the sysfs
write can pin the selected USB Power Delivery object and prevent it from
being released on unregister.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
v2:
- Cc stable@vger.kernel.org as requested.

 drivers/usb/typec/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 0977581ad1b6..0595e8cb83aa 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1619,6 +1619,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 		return -EINVAL;
 
 	ret = port->ops->pd_set(port, pd);
+	put_device(&pd->dev);
 	if (ret)
 		return ret;
 
-- 
2.43.0
