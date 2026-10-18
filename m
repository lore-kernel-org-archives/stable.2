Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD7309EF2
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288410; cv=none; b=bt3lsWe+t/F+JNafA/C3aQmEww7fK+/0cTgTeZHRYU4ZswGR6pYrw1IyKT6dl4lyzs4pwOXAka6zZ2qhYW70EWfG+hhHIPEq9HCwaC5KwDsxRR4Qj3aOlk8t/JSYAlylCa/KDzPCiKAN8fQBwLSVJ5iOFdDjIFxoZQxcHtDZTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288410; c=relaxed/simple;
	bh=ruRsaHQgJWY/2X0BApxbnAF1DgWl2ZAszA2IYNZfMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwYf9BKaWBEPqp/TLk4pLc7A8ynBIfOVoOmiybMB73q8CWQRlvSRReSuNQXSVOKsyS5VH4TJtuvtyX3I5zq4RyMEn7AD7RsV40aWrbkbHkDk1jv5oQwJRR14YYcgDtVIrBc9oHN+dRrmd+VgqbwIEWVovF+ng+dqPhOlnrAduEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L98OJHSA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L98OJHSA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e3b87ac5so467285e9.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288407; x=1792893207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsYh4u+DYPUqhXBMq03iEnUnM/d2oVIMCY2NQWtGtm0=;
        b=L98OJHSAz0RMguoSxNBlsVQJnEsADr4nmoHxBsfjxi31xmBQd5MCMlaQv/e3zgC3Nb
         vDHrHLRqKt+zq2tMLjA7vpVgjkGY5HvJl42d8hRJhpcUE7zOJpQRHW3Z8UFlFLO5K2nr
         suraLVmeRv4o0PhR6oXgBXq67mJyVMBFKNjNw/Wmeh7+e+aWsuWjf0vyUV8Li9l7doMD
         odtFlLtIhfvhM3e+lwJ3ej5zYRl6hz5LJsAlOkfgOf8nsi+h4ThfHvkUXAo0xVs7E23O
         lzk99z2cgAXp1owAtAAWuWQKJU0nqaIBZcme7xCJjdFSBeLWpa1LigV+oPob4rpuyiCZ
         3G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288407; x=1792893207;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lsYh4u+DYPUqhXBMq03iEnUnM/d2oVIMCY2NQWtGtm0=;
        b=Ju1p+q8j/v14yZVgkYc/UASvxpnVqtIQtDUBL93g0NCpqc5rNo1pflI+s0LRl+rpyR
         1hNSD+Jn/0Ui4LGsgg4kuHy1Us2RsmhhCenyeS44KkRSgyzMyghNzlGThywGZJQbBRh7
         8a3mAQKGemDt1dmaBKCsHNHOeYb047lwqhP9o4K47ygcB5r15Y27wiigYwbgc4Nl/uXF
         7Uj3JuBeZf1h32sDP40IioN2LthgWExT04OliGpVyHZ44iCMpFiuniZskyrWYIBN7Dwa
         n2KePx/zJAXdmOHnMM1mzFz5oMlHT/d8s7uOSjoftFQ6zoK0R1f/hybHBhNo0nqg4n1S
         Y9HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbm1YUKDdzCinGFc6QoEfrTIGgTocLVe4/OUdUMvBMO0t2TQN6mSBMd38wNrsDdeSlYlc4YRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEBq2vIUAhZMxNMRvrDeA4JqHTztdxNJgqguxy4MrfoeK7j3T9
	chCV1LknDDLo/C3Cpx1Z5TAZBwaRlHNchLcQM+73NfJefWSCRUUmMKOZ
X-Gm-Gg: AYBFou3klN4lsHZ1Wb5h+uN6i7OKFhijpd6WXRBGVV8B0qXYvh3R+Q32iOcKCM3hORh
	g/CXZ0mfQdIUyFu0H+8003sBHFdOqaIxnN0tUQQPq4mP7cqPNUHrNOqsHcCcYQRwPCv2sWAWIej
	NZxefcV6B0IACKPUajwkYYA1yDqqiKmuB1lk2m+1Ip+NQy45PnnY2UziTy7NqHaOgtONhH525t6
	wVptgA3Wp+PMHGl4U9nl/4xNEX7IXulVjffL0bVUed9oKF2bIC+IK2PI/2L6mWzLE7C4u1RgxhB
	7CR5Gu4vYtlsKSMmGpHtnqGntdDalK8EKX46Kg7+AShRwYWAJgsWR9jAN+2w1sIRE1AQxmczDtY
	Lm3jFDyI5wKlz+EoP2QU04RvinK347ko1WnLxMlThRnroQU8PUPkg73O+I2y4QoKOsHzXsAVynX
	2SVR+63p2RUzYQ3VylvBSJ8GYojVhZVfQhzLmZ8+6+1gunzKkzOKIZRpitQVhbJnw1VeK32O/YH
	jDlWmRgii8NqxpFH7JI1dXK+CgnN86t7AFzf82znrSBiv6zmySon2yHFi2yHy1gaQlz1qnSIhC+
	WfTs13fxj/UkTnLWXB9u4YGhKxjOYv5mgQIIXIAjsjuz2yZup4hUxch7KJWntPNTnThAdbdo3cc
	DQUee4+CVmChoS8FI2bt1xJ8=
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1d7604051mr83202275e9.22.1792288407109;
        Sat, 17 Oct 2026 18:53:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz. [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5957sm13802245f8f.9.2026.10.17.18.53.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:53:25 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powerpc: dts: turris1x.dts: Describe switch PHYs on the MDIO bus
Date: Sun, 18 Oct 2026 03:53:11 +0200
Message-ID: <20261018015311.4822-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The QCA8337's integrated PHYs are visible on the same MDIO bus as the
KSZ9031, at addresses 0–4. Since they are not described in the device
tree, qca8k accesses them through the switch's MDIO master.

Describe the PHYs and reference them from the switch ports so phylib
accesses them directly through the MDIO bus. This fixes intermittent
WAN link recovery failures on Turris 1.x.

Tested on Turris 1.1: 40 WAN link down/up cycles across 3 boots and
10 LAN link down/up cycles passed.

Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
Tested with OpenWrt's 6.18.44 kernel.

Andrew asked in [1] whether the internal PHYs show up on the host MDIO
bus: they do, at mdio@ffe24520:00..04. The same workaround was found
for a QCA8327 board in [2].

[1] https://lore.kernel.org/netdev/20250425151309.30493-1-kabel@kernel.org/
[2] https://lore.kernel.org/all/ao8DqOFZJkln4pvh@larwa.hq.kempniu.pl/

 arch/powerpc/boot/dts/turris1x.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index dff1ea074d9d..977f9f9c63c7 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -143,6 +143,27 @@ fixed-link {
 		};
 
 		mdio@24520 {
+			/* Integrated PHYs of QCA8337N-AL3C switch ports 1-5 */
+			phy_port1: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			phy_port2: ethernet-phy@1 {
+				reg = <0x1>;
+			};
+
+			phy_port3: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			phy_port4: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			phy_port5: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+
 			/* KSZ9031RNXCA ethernet phy for WAN port */
 			phy: ethernet-phy@7 {
 				interrupts = <3 1 0 0>;
@@ -174,26 +195,31 @@ fixed-link {
 					port@1 {
 						reg = <1>;
 						label = "lan5";
+						phy-handle = <&phy_port1>;
 					};
 
 					port@2 {
 						reg = <2>;
 						label = "lan4";
+						phy-handle = <&phy_port2>;
 					};
 
 					port@3 {
 						reg = <3>;
 						label = "lan3";
+						phy-handle = <&phy_port3>;
 					};
 
 					port@4 {
 						reg = <4>;
 						label = "lan2";
+						phy-handle = <&phy_port4>;
 					};
 
 					port@5 {
 						reg = <5>;
 						label = "lan1";
+						phy-handle = <&phy_port5>;
 					};
 
 					port@6 {
-- 
2.54.0 (Apple Git-157)

