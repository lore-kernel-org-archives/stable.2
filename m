Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D573C2786
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032139; cv=none; b=tgOdpbntN2akP2iBXgFhhFCl3/6qO17LxOUAu4ejz//lX8ywEOoTBuDteNm+HbHtbj7zqC1dXb78BWNqLwd3iYgUtv8yGag72lM88QZfDIYWogQrp5HvXyh3AZNNaHUt9bqrju6oMLnRQBDkTN7MhfQCVBpCFMf/mmfvVjre71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032139; c=relaxed/simple;
	bh=FjE6m4Wu22yRUqg3eOb2AwP40X2TKH7xNOyBefmJeU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U38TYCX0YrNK1tZy7W3gEVYQVeqSjHefPluEBihG17bb/A8so4XuWbWkpBkl+7TDzjIyxoJvx7w0B/ClutqLGSgxIXCqO9jzamPE0ibvvlNGOSE5LCXBs22A8bhZw6lI/OL3ptBqqhJ302DCkHg2s5CcmYxjbJWjKRBJXg+xleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4E1Ym6e; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4E1Ym6e"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so394969985a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790032135; x=1790636935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V+7FtZo0KfJZuE7MAZ0TFcA4sMr0zM/AKrTXBM06+cw=;
        b=E4E1Ym6emMwVocXYNi+rPgWOOJKOZ4J06QPIFyy4mPzFOhLXcdda85G8rlxZQxQTtv
         wIY+2w2zm+vfv/7DdXkF3MAh0Iybkc7bEEv8gj19wEHBD19srwDS+ueb4dbxcWZcdhvz
         eq5DwOrvSLQ8x3s6S/7aOZp0o7BNjLSgb2U4IHTwcsWQRyySoazNHDynQILNlVLIJ/dV
         f+vI9J9PctGd0hv7pNUuOV5C4ulykOknlLzx3heTi8knqcfEu+z18aqdibrLY//bEblO
         0O7jsirA2TiQEYy1e28J81p1BaOD3swJZD1PCcy21xYWgtomwimoRzsnBfXo/mXJpHbk
         ZOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790032135; x=1790636935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+7FtZo0KfJZuE7MAZ0TFcA4sMr0zM/AKrTXBM06+cw=;
        b=WzAw7avhTn4Z55Ns4SRkwcdd10NuyvZED3voooBupChz61RbXZ0AGb8qYvI9q2mxiN
         4trUcpw1WIi3/D1EubyvIayVmzFlRPqay1M0qRrkXTEL4wN8k1+oloSuIkC6cjS9PiAp
         jc7bYeVJXkpOVPA8LvVO4oBD3kX9v8rcdO7vd2+nscw3ZRgEks9RWzBHqg9lojduSPM6
         pC4621eTUZpw8LDLFEE8WnvjSJNP/TFwrLtWg2O3NRz4Vnxwr4ZG6mWkexxsnLgFVYyq
         elNXboLU6W312EX1KoWneGzGrs/CbBwONGuJIuM3FiFjeBSZU5qFKhMfqbcXD/CXt+Hw
         rGEA==
X-Forwarded-Encrypted: i=1; AKwUvBzowP39LmUIUULSACmljBJY3809CJy+Yw521bW70/oVPYNovyn2eQwWHIhsYSTRaLWvJk0KV1s=@vger.kernel.org
X-Gm-Message-State: AFuF++kiNuXPmqYdiPnfHZLcUrwWofmRJBdQL1X/2xsK4skMxooxoW3G
	6g1HI8cLGFog0wLciiFPaXcp0oWI+lc6gR2jQstHJsVJgaPFU8HFOj8=
X-Gm-Gg: AYBFou0OVgpjVr7kC9CAW2VG+y6YlAlY7GW5x1G+yrWfhB31mWOaIdNRqDnT2awAM8H
	FTDKLQG8ftR8b6NcjxJw+kZ70zvO+7JHkJ6oasu6RSB3QwpIfiQlIfToXjovXHKholA8/+fWdZd
	7P7HujDBdCt5B1EW4WGHS6j7K2OQbaOZnB56OKf+CXzhM6jeb3Ts6spFO/89rliMawrwLV7Xtve
	BSJbzOnTRaZTkLIodtae0iuyfRsYJfQD378L7yqcByjJHJ2xjSrkgVGp/NnvIL8YUFNgRYG1GzH
	QuEbDcdatTA6ALQEVS3PS3VtSuvPwkFRd+xekvc/AkuvzS0DvQ2nLTMQmD090P2v0qjv07Vx/wA
	1csuSLvBkvTOB482IhtwvuKiXWVyuD0GYyasAbVtgUxIbjiUoqfURJ3YrEizuZmo8qoM8tDCG3Q
	/PTmREhrfCZhXfzbSbxFpSoDSnQVERGVxVNGzg6HPPa78GbMbGpcojAI9ojRDkl0AISiEUM24lm
	+JGH3GfuBzbQIh6gwFkA5rcgWEQ+5sUMmj1okGORb1pVyNZk3qGqNzW54mPgSCn6bcNCHJSi9MB
	oRnqDHeEJkRTgtPKlOhEPIL4IX61
X-Received: by 2002:a05:620a:4008:b0:939:6dbd:de57 with SMTP id af79cd13be357-93c198e81d8mr92373885a.32.1790032135435;
        Mon, 21 Sep 2026 16:08:55 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19a7f592sm39933985a.17.2026.09.21.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:08:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] usb: gadget: tegra-xudc: Fix removal-time work races
Date: Mon, 21 Sep 2026 19:08:46 -0400
Message-ID: <20260921230849.502492-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two producers outlive tegra_xudc_remove(), from different commits.
Only the delayed-work fix needs an API added in v6.10.

The devm port-status IRQ queues port_reset_war_work and plc_reset_work.
disable_delayed_work_sync() rejects a later queue.

The PHY notifier queues usb_role_sw_work and is not devres-managed.
Unregister it, then keep cancel_work_sync().  That applies below v6.10.

Changes in v2:
- Split the Fixes tags.  Only patch 2/2 is marked # 6.10+.
- Keep each Fixes tag on one line. (Thierry Reding)
- Disable plc_reset_work too.  The port-status IRQ can requeue it.
  (Thierry Reding)
- Unregister the VBUS notifier before draining usb_role_sw_work.

Myeonghun Pak (2):
  usb: gadget: tegra-xudc: Unregister VBUS notifier
  usb: gadget: tegra-xudc: Disable reset delayed works

 drivers/usb/gadget/udc/tegra-xudc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0

