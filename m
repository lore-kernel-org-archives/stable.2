Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439452;
	b=VY2w3BR/yQGPJhosioEZohBtAwdi7CkYGl9/V3SHxGlrzJAf1IhLC/1Ywaai90tfAoQX
	 IgPyIl6AEVJ3HUsKJxG6uUr1YuwRvi01FC3ny99wqZtwKJEk3+DxjVJHrlrBJkFxuIxli
	 wOKCUM1wmD/RnE2ZmtWCKVTVBLx1OC62/Lvbb9eSDmP/09IBvd4pWnrWzT9mmlVmh8Shl
	 Ei4n72UgNzDmagPAh1HkiPpGw2dP3JPgZq8F0C3SPS+8tJXE5we1dsxvrJAyeXH8kFe4S
	 1on1cTubkbJvqy7yW9YvXHOQTknnYmr2xTiMJ1eZXeHrWNOjeBYMj8a4GzIH9tXZ9yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ujJPcRqbo+8RtY1dP0KZUOw0lItPjums4GcCFi/u6GI=;
	b=GUQd6anMJjplvaBJVblvm3zHwHJBbeKVC5l4uJ9PguoTN80m2Mj3SS7VpUoHVqdVdytS
	 hm6E9es0kEcObW8kHUCOLUv+DQwPU5gapozzpIajZjREsf4JfIDEzBBYsLGgDstCqlQFT
	 2D7+1jZNzljSNcekiM641Qva2Zh2tZLHgXmkEAHj33g7pDFmiQzrB3OpUVkNrfOSZIxBf
	 tTZUguUrfPJFxohsLvJstFpbk4i3+H125+TpuGTD28J+u+a47LnGK60rNFvKqjSz8f3/q
	 uI0USZt7TNskH6nZ78SbP9bgWQyGERwrjEkSXQ4L4XOHItMjh7ase4Ygk3R8rxYt8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKN45FTD;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B75606A685
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B75606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKN45FTD
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so32219815e9.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439450; x=1796044250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ujJPcRqbo+8RtY1dP0KZUOw0lItPjums4GcCFi/u6GI=;
        b=FKN45FTD3Ydmz0WsoY+e9wQ2uD3JIwL1r7G1awo5XD9dZozfvJZaWnld2kjAGGaNFv
         7Ft4xnw7mG3l339rbMJ4okalms5kMGvSrXtGJxoRXkSHuo9eNomL3p376icZVniyJLWX
         yjNRxx85oXK0J3KPMVm+Cu7cM5ikEAJkqGr2Tzu/Tgb3ldp3MGcdrwoTBJ3hlBXyI6qU
         VzIl6Z5SmLqdQjRlCClDK6RBZ0K7+zIilGhoaBa+J5aNaVkOmVZecUF7XSiNj3iTShkx
         PJiaHh2IK5+0PZ3LsQaPP8Sabwf5VvgmxlEUD9LdswfhK+CEgUjUezVXVHKjy/+xwHbm
         h+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439450; x=1796044250;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujJPcRqbo+8RtY1dP0KZUOw0lItPjums4GcCFi/u6GI=;
        b=lbgYooeKa4tWicF32JRbzdzas5ZzK5k01L7NCs8r5BNloE3k00FUArhYErUQwukzLL
         6y7few497qgMwV4aFjbdi6CyPuO2f61k/UA4He1WjZpStW9uf7F1X3ZcTutjstSqtlIh
         eFG/WwKtJI4FCemdYW9V+n7imOxz9egOsLcxK/NnCSZ+4Gr0DhWW9hNWI6uk8f9/XTin
         z18b4vHwh3aSQ72LreuR6ZI/KXx41OMPhSPmeoepPvychWLX6+MEXhCozVJ7pCgIYPJN
         yXPQnO46YX6YJ/o98wAXqczpV3IysVWjM0HjvL3dJU9Hm8qiBeB4dH3xkWUm/w+DQmKy
         wF4Q==
X-Forwarded-Encrypted: i=1; AL+hErGFyqkw+oEbjnanCN11uWyeZZZ7/UklxEzaEp2fEbDbyb0Gzz3fZxIiObix8vn9uq0dNNigEa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R8aTt37DmGa+PH/u3UnT6AIdivv5H6KcBVp/666ovG0KQE1tg
	yth1MbY7WwM0Ahu4ovuvs+uwk/FXUJDiKC9SOHtY4gxDBsHfJTksEW05
X-Gm-Gg: AZFdTZdCgH4k/2RwrkJJI2yVWusBm1jR2eMO3vjNzPu0h4nvdZRpw87rd/cc62fzvlA
	a4ZLKGchgl8MAvi1HBIe8Eh+B/4x9IYwgc7A3Cj8/U1CRnm4SXQlFdzoNLoTM3KUBYuKLe4ZXMH
	4a4qYj4akuK3dCx8SZO4CzhugZ24vPHWBl0yqzUwc7NsARqpGb8kF/F69tZhkMPpIk+jLU+Dvxa
	dz/amiQ/JFjKj741XRujzJ7YL4aHJtnNDv9q+a4fMbuLr9iCQMMq/BQX5RZw57lGkhmwhHjSnJy
	gdM2dlUyi2Pk23TvzO0r85tmiTV88BqYoD09X9FyWtoEXIZ48KMGmsWfEwKUHNkGh+ulwdrHuBm
	WuD46cmyOrm6/MCm9x8eCGZ4gid7jYfPvaVVrSLitaIgz90SDRSbSjwcy7TTbJdEcr7gWNEAoBI
	HltG+4GgGZ94p81btdIKb7z4H7EkQcU6WnpndlQUn6TKN4Um06LPwUmii8sTps/FwOgpfB0FCuw
	x8mrS6xn3sNsZBVZ6QlmrJrVuRd52Ti2rNgbIQ6vikoTkfNJ9XNnvzZp0CeqniAraY/1e0hqsgH
	iYAC7S6bcmeJ3te7uZ2JsYZbslRuOEcSLgSNIHM2BTJnuczRTPCap3aAbiVCfqWlEFnLhskSHrG
	n3Zvh0ut4MWIaDaZK7r6y48Omb+7q993ree58F4I5D09ygxUNZ+UupdxnUVhTjokKfgaOlUJQzw
	==
X-Received: by 2002:a05:600c:5303:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4bb88807d7cmr225458775e9.9.1795439449739;
        Mon, 23 Nov 2026 05:10:49 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:f273:2c28:9387:7d5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm400714065e9.7.2026.11.23.05.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:10:49 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH net v6 1/4] net: dsa: rzn1-a5psw: Fix LK_LEARNCOUNT write mode encoding
Date: Mon, 23 Nov 2026 13:08:49 +0000
Message-ID: <20261123130852.3420491-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123130852.3420491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261123130852.3420491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The LK_LEARNCOUNT register selects its write operation through the MODE
field in bits [31:30], with the new count value in the low bits. The
driver writes the raw A5PSW_LK_LEARNCOUNT_MODE_* values (0, 1, 2)
directly, so the MODE field is always 0 (SET) and the mode value ends up
in the count field instead.

Add an a5psw_set_learncount() helper that places the mode in the correct
field using FIELD_PREP(), and use it for all LEARNCOUNT writes.

Fixes: 5edf246c6869 ("net: dsa: rzn1-a5psw: add FDB support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Clément Léger <clement.leger@linux.dev>
---
v6:
  - Added a5psw_set_learncount() helper function
  - Update commit message to clarify the purpose of the helper function
  - Added reviewed-by tag
v5: https://lore.kernel.org/all/20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/net/dsa/rzn1_a5psw.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 13c46cf2c420..4c32e06a3cd2 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -5,6 +5,7 @@
  * Clément Léger <clement.leger@bootlin.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
@@ -120,6 +121,12 @@ static void a5psw_port_mgmtfwd_set(struct a5psw *a5psw, int port, bool enable)
 	a5psw_port_pattern_set(a5psw, port, A5PSW_PATTERN_MGMTFWD, enable);
 }
 
+static void a5psw_set_learncount(struct a5psw *a5psw, u32 mode)
+{
+	a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT,
+			 FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE, mode));
+}
+
 static void a5psw_port_tx_enable(struct a5psw *a5psw, int port, bool enable)
 {
 	u32 mask = A5PSW_PORT_ENA_TX(port);
@@ -544,10 +551,8 @@ static int a5psw_port_fdb_add(struct dsa_switch *ds, int port,
 	if (ret)
 		goto lk_unlock;
 
-	if (inc_learncount) {
-		reg = A5PSW_LK_LEARNCOUNT_MODE_INC;
-		a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
-	}
+	if (inc_learncount)
+		a5psw_set_learncount(a5psw, A5PSW_LK_LEARNCOUNT_MODE_INC);
 
 lk_unlock:
 	mutex_unlock(&a5psw->lk_lock);
@@ -603,10 +608,8 @@ static int a5psw_port_fdb_del(struct dsa_switch *ds, int port,
 		goto lk_unlock;
 
 	/* Decrement LEARNCOUNT */
-	if (clear) {
-		reg = A5PSW_LK_LEARNCOUNT_MODE_DEC;
-		a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
-	}
+	if (clear)
+		a5psw_set_learncount(a5psw, A5PSW_LK_LEARNCOUNT_MODE_DEC);
 
 lk_unlock:
 	mutex_unlock(&a5psw->lk_lock);
@@ -963,8 +966,7 @@ static int a5psw_setup(struct dsa_switch *ds)
 	}
 
 	/* Reset learn count to 0 */
-	reg = A5PSW_LK_LEARNCOUNT_MODE_SET;
-	a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
+	a5psw_set_learncount(a5psw, A5PSW_LK_LEARNCOUNT_MODE_SET);
 
 	/* Clear VLAN resource table */
 	reg = A5PSW_VLAN_RES_WR_PORTMASK | A5PSW_VLAN_RES_WR_TAGMASK;
-- 
2.56.1

