Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616771;
	b=33izZgr4Lzi0m5nTUA5sJhqE9+GbdgDvgtWmqCD1L+eb1LjoolLyLpQCKQqPu0ect+Hs
	 MFeSRqAfVJw1ssyR0kW1EVbthp057ZH3MC7/D27woTuZBEPhC6V7r3bDMyULzCO8gttvv
	 lOo5eVlw8nvl1LkpA1jXH+T7jnCnYi5dOdWJZOWasdPPMP4stUSxgbpiU/DR1oDlGhesV
	 DW9pW7Y8GK1srjpTgoWgRdMKAe/OhjRveJ4RUMASYBIbAnqkDsWUu2B9LJ9h3L9ltG88D
	 RFqp7Y/0NCX5kRWjBUMxSWzBy1pZ8LgoDpMV4ifCalU3U0ZRlCAcpG96RndAfUdMUCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616771;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bc+IWZN5YAPHoOyo+1Q6E67EjvNIQ/K6Eb9HQ1yxorE=;
	b=lZB5rfxGjTv6NwaCbolsJzGZWPL7a1l8MrxRVD9kh14LVbXVLTjFMl/sAEgkLZhKNHbH
	 qi2SWbhJnk0kLmbYYNdMRWx2yJn5716oI/VcVCj1nwhrh6G3H/920Gj3CKVv+p1iKaMX1
	 vWofcaQWAY+GVbxiLVYbdUUTy2rN2gpOd8/Jc4OysBokdchc2xmIIVXBUDMrQnquCrahH
	 ds0sKUziYxmFQ8ooBzf85qoMNWBEYdXrx7eHxtGtobfsJRaUQGvwSb1P1Gc3ruLE18wm7
	 JBtZo7YitdMugBLXJIgmj91gB/XHdE9NsXgmUurid/ZdHH5NfSqvNWm87JXYG+pCrug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GdOry0jt;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97917606A338;
	Mon,  2 Nov 2026 10:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97917606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GdOry0jt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bc
	+IWZN5YAPHoOyo+1Q6E67EjvNIQ/K6Eb9HQ1yxorE=; b=GdOry0jt/55ENrQlHu
	hcJ7XqfBcyL8qVPtoRbwe3fLmQzeXE3BVYJs4dXjpvV+SpJNcGKgG61igEkPVon8
	8okdxVxV7plC0brAbCTipBTV/LgfShP+yUsSZsb6ymgrZQyyZKc/QcTAOvaDFziF
	hWxFoyU4JRvSk5drSy+zwYKu8=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHTpdWa+hqVQKEEA--.44730S3;
	Mon, 02 Nov 2026 18:52:10 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] power: supply: max17040: preserve alert threshold on write failure
Date: Mon,  2 Nov 2026 18:52:05 +0800
Message-Id: <20261102105206.1587-2-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20261102105206.1587-1-m13940358460@163.com>
References: <20261102105206.1587-1-m13940358460@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHTpdWa+hqVQKEEA--.44730S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw4kJw13XF1DKr13JF1UWrg_yoW8JF48pa
	9IkFn0yr1jva15C34Dta1UAry5uw42yrW2k3s2y3s0va17AF4kJr1YgFy3K34UKr1fZF4I
	qF4Ska43WrZxGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU9a93UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC3xrFAGroa1rCcAAA3B

max17040_set_property() updates chip->low_soc_alert even when programming
the new threshold fails. A failed write to capacity_alert_min therefore
changes the value returned by subsequent reads despite the error reported
to the caller.

On models with an alert interrupt, max17040_thread_handler() also uses
this cached value when rearming the alert, so a later interrupt can apply
a threshold whose write previously failed.

Return the register access error before updating the cached threshold.

Fixes: 2f38dc4d9190 ("power: supply: max17040: Add POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 16e42de..f415876 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -384,6 +384,9 @@ static int max17040_set_property(struct power_supply *psy,
 			break;
 		}
 		ret = max17040_set_low_soc_alert(chip, val->intval);
+		if (ret)
+			return ret;
+
 		chip->low_soc_alert = val->intval;
 		break;
 	default:

