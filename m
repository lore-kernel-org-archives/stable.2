Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134364;
	b=5C9aQAMSPpaPPVkVaBpcfKKkAlnuPCna8OjU4hInlilcdXnLfpZZ66wcJH7vVR/ZOUcs
	 dAAGGVO1YQODWeLiqJouWj3UF+jizM2m3nfo4ekwHbTJpJculilwS9O9p8s1h1WZVjOtz
	 ZlHGL5kzNx0r/amHTffUYxrhbOt7BPgSLUKeLmwFU93QMLpDnrJ37vv7wJ9HHrT0K7kND
	 hHrg0nnKulXV1xJDeA6WldT5mcohWevTsKvbo67PYamKJo4nA7M8uFPk5qJrTzur9WLDk
	 vtKV35AKm3pzsnrncMzxgNPUftzp+zdJxQYYnYpZYKxdH/XAOrFVWkvy382tADmdF2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BxV2zTydEE4k6FT+/UqpEKJRz2u+2cYDgcocvttPorY=;
	b=jy/gx1Tez0nv3nKxRavpHMuhDyyvywpsnyUCgJEn5yUCcI66mjwhVYdD8u92cJtSaIbM
	 W4BYtw/CwuAV4DEee/ml41fcufR6an9NOOZldT/3GbSYJsjkIQ/Yhq04+PDfylrWoXLem
	 1lpIgf5ruQO4MTaERlPRreDIyYW+NMw7Oi0fkjo72kEzDhhAWqSAnDt6PLtpPizftbfgK
	 jlDxULmQ5Kq3zbnlgCY6UYnIvd0hvEdIvYxHfRaeAELziz3E+b/QTmPfK2vUf22pd3gVJ
	 DU3TCFFyYahrK0OBiz4YWgh5eHDhxamvBachcxxFgI3ikrfjdVNuhDxvoFF5Py60wyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9MqcPLt;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796060A3816
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8796060A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9MqcPLt
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e3b22e971so153339f8f.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134362; x=1795739162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxV2zTydEE4k6FT+/UqpEKJRz2u+2cYDgcocvttPorY=;
        b=v9MqcPLtxE53SbjN64oHKP9t3rCkg88Zes1tVNDU+ofhyrQCe7iAjOqyGgwoAVAPyB
         74RlAfCImWW4u3EDJgGcEgjAiFs4MrtoR0odM43Nci/Lq5HaIRvqBDlFNbttHaKnzku9
         bvgg/zluqtZ5RKvErgFdFnt6f7vI5DzRhSamnmWF9enY8PTOkPLVNn1Uk327j3Gv0Dvz
         Uc0gpHcmKZClPKqOMRZ8DNI5DhyyGBcDwGGNYxRYkffFwL1VudZ5IVkNevBJEBNTP71U
         u+AVVz3mizW1JfQOmIXe3NZ5ttsOXZB8x9NJVYpIUYbvDBz4BCj1YyYuoJHrAxE/ZTJ8
         5/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134362; x=1795739162;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxV2zTydEE4k6FT+/UqpEKJRz2u+2cYDgcocvttPorY=;
        b=oKkUgs8PI3Oay/PcqjIGDDJdHoCjWhAzrScJEM43wnZHfhayJWjziBVtpzFCVU5oDM
         c3z5GcelgclDdA5P0jd3LBkwVsd16hQy5BdTFT/vGJlPNXOmFoeGfWtaCI3zfz3/xF6r
         5wHMMmb2rZIRD8xCh5jgwZ4hF3d9ctofgQbMTV7eo9BkP1Rohv73lQPi7DLO+7X0WLcV
         3imAx44VAHCd70HSMj9aJhxLrMVffTLrKFDMUmKinGfK/hqkZ0IOee5iXSAfXMO/q4Gn
         4Zi1oyVgWMD45OQzGUOna5KUN74cequZ2GtXdqNXGbWS26uD7sdw1s4jWY1IkhnF6BXM
         sVhQ==
X-Forwarded-Encrypted: i=1; AL+hErElUK2of4J+pS+guRh+eGl8IDAo+Ja0c8WN5hei2fmxSSDLPPsgyeE4G2Ui9IVD3eVIsUp12uU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4EUnBVcFl9gRz7KglF1007PHhV5YZ0kyto+3B45IRUSq+FlbL
	Rkqk/UV1JZAVKXj/k5RmiBnVM1wqbVZr2wj60auQqiGn5cG8HILrKhfu
X-Gm-Gg: AZFdTZfpzQ1F9oUxrsJ0hGZVFuWQJbbU6ltCoMpQKh91prNfgQ6BpHbQ4VqbppbYUaX
	NgNMPSRzhzogvIZOHifODHO8q8Fx/jW/c14x/D/QyPh3LJHmc7vvNM7fnPzVCCTHMfBoUso2NBk
	K4BxcncMH4i5bS1wnkcuPtFMZbrg4yZqn1m4DxAGq8XHdxeg8kXbnqRoMZ/raWq83yHowwrm1AF
	aPHNkdVXPCHMFQHaXAv9TfT/GAMXjZDCaYZJLcjj/jYd01hAluuaT6VaEajXk+sk1ysguVm0n5X
	X8Q8qHmb6e9qTuMkMq3VV19lOsNtpJfbOYSrdclXXjVk6CpJgUZxniqzzJ77HsCK5Lfc4v6xq30
	+fa6CiutwRorSvFuoSxlr82JcqphLypdWt1w93CthGB3Cs7DUxaDb42kZKYT+TY03xHhpEco3X4
	SN81kW3XHAV8mIBb6AvSKuHR5AJ0BDS0IIMwRrbeK38P1FiZVC/LQgmD6bDAKzUvlJZurA+WTzy
	zjp5ApYT5tIjAV4rEzT0ck7lty/PaAtqWvQ7lqTFtbE4A3FBXJRuhgE9t54nHawN5LkJMdKbs6q
	qS9i1kilZw0kyHWzJmKXlhDFJhqCi7DTMi38w+mlOAtGFBLucy88ewC1zNO6hjiX/5tYxCC44jB
	XYrE9l5C42483qJlA8CwADa5RqFVCqq3EZvKxUQIctd0nBme9Tr8d0Y4SKQ1eaGUl6aEeDqCM
X-Received: by 2002:a05:6000:4916:b0:4a5:e50:ea5e with SMTP id ffacd0b85a97d-4abaf64bdfbmr1921927f8f.9.1795134361869;
        Thu, 19 Nov 2026 16:26:01 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:c5c5:590b:f4b8:3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm2629998f8f.55.2026.11.19.16.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:26:01 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v5 08/24] net: dsa: rzn1-a5psw: Fix LK_LEARNCOUNT write mode encoding
Date: Fri, 20 Nov 2026 00:25:18 +0000
Message-ID: <20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The LK_LEARNCOUNT write mode lives in bits [31:30] of the register, but
the driver writes the raw A5PSW_LK_LEARNCOUNT_MODE_* values (0, 1, 2)
directly. As a result, adding an FDB entry writes "set LEARNCOUNT to 1"
and deleting one writes "set LEARNCOUNT to 2", instead of atomically
incrementing/decrementing the counter.

Use FIELD_PREP() with A5PSW_LK_LEARNCOUNT_MODE so the mode lands in the
correct bit field.

Fixes: 5edf246c6869 ("net: dsa: rzn1-a5psw: add FDB support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/net/dsa/rzn1_a5psw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 13c46cf2c420..7fd2652813ac 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -5,6 +5,7 @@
  * Clément Léger <clement.leger@bootlin.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
@@ -545,7 +546,8 @@ static int a5psw_port_fdb_add(struct dsa_switch *ds, int port,
 		goto lk_unlock;
 
 	if (inc_learncount) {
-		reg = A5PSW_LK_LEARNCOUNT_MODE_INC;
+		reg = FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
+				 A5PSW_LK_LEARNCOUNT_MODE_INC);
 		a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
 	}
 
@@ -604,7 +606,8 @@ static int a5psw_port_fdb_del(struct dsa_switch *ds, int port,
 
 	/* Decrement LEARNCOUNT */
 	if (clear) {
-		reg = A5PSW_LK_LEARNCOUNT_MODE_DEC;
+		reg = FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
+				 A5PSW_LK_LEARNCOUNT_MODE_DEC);
 		a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
 	}
 
@@ -963,7 +966,8 @@ static int a5psw_setup(struct dsa_switch *ds)
 	}
 
 	/* Reset learn count to 0 */
-	reg = A5PSW_LK_LEARNCOUNT_MODE_SET;
+	reg = FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
+			 A5PSW_LK_LEARNCOUNT_MODE_SET);
 	a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
 
 	/* Clear VLAN resource table */
-- 
2.56.1

