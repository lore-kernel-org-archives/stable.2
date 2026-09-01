Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22F399899
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240509; cv=none; b=fU9V9vcJzkQWJFzTaYu3HrEFsHQwRvuGGWP7Fnng9HM83uShVSoQ4i5FNi8dsmwGFMLaxdKZGGH6Mx/zdYEUFYIlRiy1wCy9imFpm5TIAPmJ7NlXRN8q38KrliG7627ugrOc2UjnFvcpq5o6xPOWZGab4NcHz1Z89NDFO6CLJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240509; c=relaxed/simple;
	bh=W7Q8xg8BSAYA2tpHUW+AynBJ9lC5DWh80C8PRS4kSR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0QFBz7o07X6TH+yBC0xSOf/DgBmZOVBdEWfgqBS+v3Faw7rUxbD/T+9d3ZxSguH1htaGtOdHKRdj0xf6wSUM6DttgtyVEdxqfUgtf+B91ZpsF9DXx+d9magcpZ80iR8nJ5HZRqebzkFOI8F5/Tr9i/1E2wg61HvWZCAmMS04Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw/5LzLC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw/5LzLC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso49394855e9.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788240506; x=1788845306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7Q8xg8BSAYA2tpHUW+AynBJ9lC5DWh80C8PRS4kSR0=;
        b=Mw/5LzLCzbYfkO9cFPvCiEqpRFxM9o0QArFK+sAPSbBonMM4mGhvT5+QrE4N5GerAZ
         5mkg/qPAl6C5gYKmIrYFV4eKFr+7aJYMy6Eh+X+8/ma/G+4GbKKfWDy6HCJGLeF4aO+M
         5VCbtcope+RPL4XfvwZ9xeCdDkyakwIKzTWF7v6EUanez8v6YKt9PJ+dikMHU6z5e92O
         AVPh671sq+hYHpK474d2daYWRMcEaohSquAQTsmJ/G7aQwhCwp1K0/SdE6w1SQXWsI6G
         yT8l4k69nLhJ3TBK+Sj1AN/+3d3Dzg7Y3zzsLwR5JNHb5RYVzLmpD7QeCLNP+lxSzAWI
         vXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788240506; x=1788845306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7Q8xg8BSAYA2tpHUW+AynBJ9lC5DWh80C8PRS4kSR0=;
        b=Guf134Xlb+4mjV20LIGSwDbH+HSnJkj3NMM8A+1hLbw7MBRQ6epvoR5Hwp1Ucyq+ta
         7HYlF+pYJgq/mJ8q9q7LOd61gd7dKcAbJEF95LTApPrUf06zgvv3s/HgenP7QBCfr7if
         58FLv+UA2qMV3EuGHb8IehjPVkdIV91bR9tUjZTlxke3mmTOE1plyUfLvXHzfHjcevT9
         sdPxxcT/sSraDOoZ7q8bR+3JH3CSZHq3oGdRJjOuIc3AXOB/snQNeTrWqkm+PXg36zf6
         NmeGr6OB3ULLGlPNKhd86tnp/oNgveUV4Cdn6ztW9KGp9T/sVdTwe7FnxChcEz72WfIe
         4tFw==
X-Forwarded-Encrypted: i=1; AHgh+RonbRcsKhDatrmkJLY1IAJ8KBuIyr/Tf0PLcRYybrnT9HCDI7ph1VIBYMfYFmugWawLQ6FqvMg=@vger.kernel.org
X-Gm-Message-State: AFuF++kTMKl1sMD+v3tEgI2NxoPvQEF0saHN6C5ozAe+OebSkLelBlhA
	3W8bwLK7nSJ9pT72JFbFe96ReIV1OV4fJfCcFTS4K5+BCGvvNSUrVZFh
X-Gm-Gg: AR+sD13HtuR+9c+lpzYmw5q8SLC3qY+LxYaUaObX1lJC8FcxEwTZ3mzTDEOYPopawWu
	WaQKfVrqdZVER+zo1aoAZj7YgANn2xTgjewT9ODCtf0nCzLiwJkm9Xmrdz4tBUesDEFMggojYVh
	l8FmsmUq9hlfKA/MRWT964GDQ4NUPP7g5YEpRN6IFTgCwrcnJX1Hs6YIbOBCT7Rhe6zZ0I/pO/X
	DCGLjjyFh+hjL+sJ2JiQ5eBVonvPCUfq73VaSRjzPiZGIasxsQuEiEAmuo9h5hPeT6et9A1bsBu
	XwYHnQPENHr/454tVfIszh3WHvw5gO5Qy+Rj+tQluOE7Umg7wz4eRFtszO2ZDl5cGE1qOabUXc4
	2hZ2I8uGQSNVW+SBxzT+gqdyPcAvwx6SAsoddnctg5isgKS9Dseo2cYTv6jr4+w7fARZSM7Fva9
	rwZScTf4gXbsZwVjoyQ6GR1gAswsLxaL3EJ2aqy1X0qpjz52NgcyLKsIT3olM2P+O1K9XUIa8lW
	2BvCInvSDfJ3ysH62KrS2yEtDTkkQ9xHcsNNsawG5XBs2edYj2XMtzGudB+kPXA
X-Received: by 2002:a05:600c:3e18:b0:49a:77c1:d246 with SMTP id 5b1f17b1804b1-49b91c4e073mr525091595e9.15.1788240505850;
        Mon, 31 Aug 2026 22:28:25 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8b9a2efsm140752035e9.3.2026.08.31.22.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:28:24 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: sashal@kernel.org
Cc: patches@lists.linux.dev,
	stable@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.1] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Tue,  1 Sep 2026 07:28:16 +0200
Message-ID: <20260901052816.3815-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260831133314.4125787-466-sashal@kernel.org>
References: <20260831133314.4125787-466-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this one from AUTOSEL.

8fe125892f40 was reverted upstream on 2026-06-29 in b521003c27eb
("Revert "net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in
mdio-i2c""), so it is no longer in mainline.

The probe it added runs in SFP_S_INIT, before genuine RollBall modules
have finished initialising their bridge, so the bridge does not answer
CMD_READ/CMD_DONE within the 200 ms window. mdio_protocol is then set
to MDIO_I2C_NONE and PHY detection is skipped for modules that worked
before the commit. Maxime Chevallier and Aleksander Bajkowski both
confirmed that on hardware.

The timing is per-module rather than per-PHY: the FLYPRO
SFP-10GT-CS-30M they tested carries the same AQR113C as a module here
that answers within 200 ms, but needs seconds to load its PHY firmware
from SPI. A fixed probe window cannot cover both, which is why the
commit was reverted rather than adjusted. A proper fix needs per-module
init timing, and per SFF-8472 the host must wait at least 300 ms after
insertion in any case.

Backporting this to stable would reintroduce that regression on
hardware that works there today.

Thanks,
Petr
