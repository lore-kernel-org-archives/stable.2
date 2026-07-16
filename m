Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC737204C
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234109; cv=none; b=aRLLXn7Up/mfSXtc8uqlG+B3J1xn2sEIDxiWnnBm6Tq8BgFzdiaCnGKj0Gwk6FvMEjWdVmBz//iaSZ0JZkJX4NglGFP7vt+e4K6hz11GUazbMENd3CvbG6IuMDCzYXw/sUBJVvn22Sz/Ss5nqj8E3Z3WPijbFAX/MX8QFwCJ43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234109; c=relaxed/simple;
	bh=Q/XwJn3N7sbVhwP2i8d4DE4nh1H7M9Rkrz42kIVBVIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8nwkgVnhervk2zOzPQIZzHbo1UkGgnQJczJ6Wn60LV7UqdFc4GvyNxL0zrG1eKUcYOIyxFR3bChRLrYE20oIikCPPrHu9vGdY6riwOFz/i23AeCaN+p+z2soAE6UIGgl7RbHdVNpe56RK1xsqVDAj7pXRXWbUdc+eKM3pjffLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=jD6/UkwW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="jD6/UkwW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49548e01d02so477655e9.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784234106; x=1784838906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QQAjFNHULURUxSmt1j/8JCkMYnUwWWzf2sKXPLOVu8=;
        b=jD6/UkwWShmjem3JZtOPdbsInHPv5UIkYyG1zh9K/ZdbVd8kLLQVzTAl/YbJEEHaX3
         t3SjWBQx1JOsja/oD9C8smf7PN/FgdDGVyDAX9Mq+xKcIJ+VC4ZFCwb0dTyP1qjk7EuP
         Oop7gU4ySNq94CT28y9+9/X/YSZ9HiNGqIHpOHjRYd62uYa2SwnhvRCf+Kn/czsBpEvi
         euG64O22kcMo0KsrmBJHS1SdEjqaYCEBkjFmW1pSiVSsxmhjutEq19xzQ/d0l2IcbkBo
         kCSh2YHiQKNnguiS4lOpyfqhiiUwVgV8wpPyflQJaQxkVbxM0yXXAIe4cCAB9ZbubQed
         J0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784234106; x=1784838906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4QQAjFNHULURUxSmt1j/8JCkMYnUwWWzf2sKXPLOVu8=;
        b=g/4WzlsAhR8V1w+iFgLq7/7bssagUpFg3JIF14qZR/j+0oXQucjKy39n0gW2O7Pvyn
         8Vgze9anqriwCB9U8iJXQdsrnNHUa1dbaXQPqGnO6X1izjovLi/U6jXS7jmCqTyxkdK8
         kW+TNxhpFHcCC1vqdwrfNGel7CrfjPJqomZq4edT//ii0Ku7PH9xQbZLUYgqFX8OtP2R
         /hoZrOX4aezRFZ+79R/0SOivd+dsDWIwoWbuvZa6pgcZunP+e9X/dkPKQzGEpHkMmL6S
         N257EPAMEjOKhCIXV9O6QdX6GYAlugNPNQ5RXDTgmi8Z3UvnRJ76WGwU4zYXPO/Y+vLA
         41ug==
X-Forwarded-Encrypted: i=1; AHgh+RoYQPGPcx64EbeelRx1oiaL4lLO5p8nQE9OrTFsoEeDoHqGkXbenf4CJxeERpuAz6/x6bExnqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXV/L4AekoiN/Na8Y0Z5gMar7C+FMBXz+IO75kB+LjUF7FWil
	sePsSXuHk91UTOy31QqGUq5hoFkk0pijIP5mS8/EArYbHomhDBRLlV8KwAtLt5X7iCac
X-Gm-Gg: AfdE7ck9ANr4Ee/H8QITsoV65qlnnkw+GpBEpoAHgyp/usRXPx28gh8C9OQDMMWy1I9
	AJpdkzwOiLoKNTbpbWzMSnBJB6VlYUK8JFwS0t0Uomkj79IM896+VdyUAHygO1iJKLDqjuPCBEy
	OALI3tFhMUtTQxcRortQ8PvbBSeVpRsngDqIEI9AdBpynpXg3eq/OqA7pR7nCuvWypX5e70MknG
	KR6TM4c19AJDNCsBByvGKkg5QoOEY1CSgJHYl/X0FZe0XFU21n/iZbmdjQQOHPaKUNnnwwTJJbb
	yKfDQuFggQAsin3X9U+ttTBGzjQtTKjDJIJtjhxhuwuNtp2ZcHShC+ve69fxnU0OD3oOiBm8Ypa
	K8uji4rsK1esMninR5YG6LMHm4+01nBLLCBil3ICbN8qL0WBfTAbdSXmayyJqyd5rbNMeqJMt1M
	7P5z+USrM+ZP5YevNjzHP2Vs1G7yF6rX/U20B8R4fUIQDMWrZXWeiWU2M+G6ebunGzAYDdfw5BM
	m++4qKVKE4LvMh4In2YFC9C
X-Received: by 2002:a05:600c:8b6d:b0:495:3fc4:81b4 with SMTP id 5b1f17b1804b1-495403fcaadmr67069805e9.30.1784234105873;
        Thu, 16 Jul 2026 13:35:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm4602835e9.1.2026.07.16.13.35.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 13:35:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: fmancera@suse.de,
	sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] vxlan: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 16 Jul 2026 22:34:59 +0200
Message-ID: <20260716203500.70573-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716203500.70573-1-doruk@0sec.ai>
References: <20260716203500.70573-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the sticky underlay netns vxlan->net. They differ once the device is
created in or moved to a netns other than the one the request runs in.
The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
so a caller privileged there but not in vxlan->net can rewrite a vxlan
device whose underlay lives in vxlan->net.

vxlan_changelink() validates and applies the new configuration against
vxlan->net (vxlan_config_validate(vxlan->net, ...)) and can reopen the
underlay socket in that netns, so the same reasoning as the tunnel
changelink series applies here.

Gate vxlan_changelink() with rtnl_dev_link_net_capable(), at the top of
the op before any attribute is parsed, matching ipgre_changelink() and
the rest of the "require CAP_NET_ADMIN in the device netns for
changelink" series.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: correct the Fixes: tag to the commit that added changelink (Fernando Mancera).

 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc5662..d834a4865aec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4421,6 +4421,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct vxlan_rdst *dst;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
+		return -EPERM;
+
 	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
-- 
2.43.0

