Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795589422;
	b=WchoJdRzSzUqD4hr8GcZKy0MiEINAARBpZgKf5P7KH7qysf4n5BW6Mx4CI5c64h6ahvG
	 6lYPiSi/AGzgJJBjpYGDt+hwHpct0tJVFTgDbfPv+ODO0COkUW5Pul/WtwxUe8cQZQ5hO
	 zLniY4aDtpJ7vxwtngnGhv8O04k7OCsJAUOCLRjtn46GFfYjPiMeyLNowCSaQGCALXlAx
	 2X6ojzi7UHcrnCUABcvdsSURmTEVvLVdDG91HTv7ZXNoazGJgVflR8EMbsmcfm3v6oqwD
	 2e3CPmvRENhtdBOMvjnTNmI2pvdjeNNlr0BQqXVyRzeW+KN2TSiQSXDPf/nrg6gdOVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589422;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=kbv3clEx8C6dlWAgnv0ID/UYfBXqiyJgr/b5qFCcM/U=;
	b=H+VRqXjPT0Y5Mx08zqh976wiiAyDsH4DRNH0wENdWRUyCnpMihQFABDqXY661q4O6cRa
	 s/D0wUA1WJp1YjQAo/MomfawTeUwEzphqdKmo9sD4oXMb6tROhp80i4aa0VCo0Ptawn2j
	 qaZX1X0Vz31eHCHdIxyEc91qJ8/4eoYjYWJqAlClYabTAbhzlE6MJWmE03suLicjV5HXp
	 RuEI3gaUxVZjZwhCC1+pJFW8IFTxZL35/CUrAg0uGzseqjX0lvr79EWLC6R1/sJb1u7vH
	 l83kXhlqzyw7aZUlhVoZhBfjPlaGWzvmGe27BL5pM9U3d0Oja/BwAYrUfZ7hSkcUZhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CAc99IlF;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="9uvtBP9/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20910606A691;
	Wed, 25 Nov 2026 06:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20910606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CAc99IlF;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9uvtBP9/
ARC-Seal: i=1; a=rsa-sha256; t=1795589387; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KVwDYQtckHEknwH1niSCdYZrEX6y5eeNW0z8UZRi+M6AWm4442gWHwKO78KmyEU2Hr
    ytsZOpY+88jWBXqChrrJEcoU2vMRr2A+q75PB7L+oA/KrjSwjqf1R9TWCOSr0umhalyh
    0HviPCeYdWWB1amFIGBKFFj2D7NTzyrUrPkdEhnmmV6M5D47NITLRtX9BDI8YiRgnWm0
    e6bzYfBnRVCxL73kj8klsLkZUMN4BUfqfTCguFSn+BTrpNUkGkXbvR+IHXr9j//n3Lyz
    XWsBoaHyuqP1A9EaTR8UzhcuFRsRAjQAKQX+C3DF/XXWHQZ/KU2WiF6DTsnrweom3BhB
    6qyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795589387;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kbv3clEx8C6dlWAgnv0ID/UYfBXqiyJgr/b5qFCcM/U=;
    b=CTs/rgUPmseW1yUKhE3QFt4Jhq+5IjHQ1K4U5A+6IakG2/+BeGuv4R8oMrAUJnL2MZ
    67vI2Cmqc/DsYzx5QipZ1auc7hCLjBm5lwnxXVrVhaydnNYTx7C+zIygJEugRaFPHbLK
    n4PxiBIsLZaa/oIg1rOsGAaBzk7PlHkwYVd71jC3hLgIEQ9uhjc8gFSG+z52PTeZJwyF
    1D8PJLhXIcZnqoQVwti6zIIU9YZQUVj913tV00XBDk1u1puegGrLNgz5BsjcLkzdJOfZ
    Jdwev5Dk5vmpFGOxuM9D7jCHtaebrcWGyi2wA50w3oIha0MtagvIO1hOcbaCKznqcW0D
    Swyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795589387;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kbv3clEx8C6dlWAgnv0ID/UYfBXqiyJgr/b5qFCcM/U=;
    b=CAc99IlFRKAIx25v2gIoVXOznIR+cwLB8GMtChF3Owtjeq8apHit4dRKn4qAJbK+f5
    aM7UDYwsVXHDsPCGTIyTcrgkFYpJ+EvguttpbByUW0z7QgL4GgHgv2ZUswBBg7zPmNLu
    De3L+0Pymkw5QK1epK8A81d0p36lJUyGWVesHKdst8xUDg2y7d+YGkrz+0+LQPF3zHGM
    4dm4oxejQybHn0PS4ytA6sFOY33vNfNc9VN5JqqmrDTeliSechfcqzuPzV0bbei9NK/o
    Uoyx9SS1/S9tMBn7z9EMtVBruXdDqW9WJFLdxOwGELDK7/mRZV0rtf+9pv1UNR7o4m+9
    WNPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795589387;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kbv3clEx8C6dlWAgnv0ID/UYfBXqiyJgr/b5qFCcM/U=;
    b=9uvtBP9/Vv9T1/IiSpvoRl+A0GeCEYMe9lY/tmZ+kQ/boXkiPpuUPcaZPYF0MlObJ5
    hNEUqGdoqyrhqoTM3AAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrS25oMlMiNMn5e/Npe6SVDIvzG+5uG4p/zkDZq"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AP6nk5pu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Nov 2026 07:49:46 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	letux-kernel@openphoenux.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/7] pinctrl: ingenic: Fix hardware dual-edge interrupts on X1600
Date: Wed, 25 Nov 2026 07:49:38 +0100
Message-ID: <b8405343457802dd8228d0b5fc2017e1f0d0d960.1795589383.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795589383.git.hns@goldelico.com>
References: <cover.1795589383.git.hns@goldelico.com>
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
Content-Type: text/plain; charset="us-ascii"

Use the hardware dual-edge detector on X1600 and X2000.

Set PAT1 when configuring both edges and program EDG on X1600.
Keep software edge switching for older SoCs without EDG.

Tested on X1600 and X2000 using GPIO buttons and register readback.

Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
Cc: stable@vger.kernel.org
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes V5:
    - added Reviewed-by from Paul Cercueil
    
    Changes V4:
    - Fix Fixes: and stable Cc trailers.
      (suggested by Paul Cercueil and Sashiko-Bot)
    - Merge the common shadow-register paths and simplify EDG handling.
      (suggested by Paul Cercueil)
    - Retested hardware dual-edge interrupts on X1600/X2000 after the
      shadow-register refactoring. Verified both button transitions
      with evtest and confirmed via devmem2 that PAT1, PAT0 and EDG
      remain unchanged across GPIO input transitions.

 drivers/pinctrl/pinctrl-ingenic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 88c5edeaaddcc..7f65f3abf05f5 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3601,7 +3601,8 @@ static void irq_set_type(struct ingenic_gpio_chip *jzgc,
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_BOTH:
-		val1 = val2 = false;
+		val1 = false;
+		val2 = is_soc_or_above(jzgc->jzpc, ID_X1600);
 		val3 = true;
 		break;
 	case IRQ_TYPE_EDGE_RISING:
@@ -3635,15 +3636,13 @@ static void irq_set_type(struct ingenic_gpio_chip *jzgc,
 		return;
 	}
 
-	if (is_soc_or_above(jzgc->jzpc, ID_X2000)) {
-		ingenic_gpio_shadow_set_bit(jzgc, reg2, offset, val1);
-		ingenic_gpio_shadow_set_bit(jzgc, reg1, offset, val2);
-		ingenic_gpio_shadow_set_bit_load(jzgc);
-		ingenic_gpio_set_bit(jzgc, X2000_GPIO_EDG, offset, val3);
-	} else if (is_soc_or_above(jzgc->jzpc, ID_X1000)) {
+	if (is_soc_or_above(jzgc->jzpc, ID_X1000)) {
 		ingenic_gpio_shadow_set_bit(jzgc, reg2, offset, val1);
 		ingenic_gpio_shadow_set_bit(jzgc, reg1, offset, val2);
 		ingenic_gpio_shadow_set_bit_load(jzgc);
+
+		if (is_soc_or_above(jzgc->jzpc, ID_X1600))
+			ingenic_gpio_set_bit(jzgc, X2000_GPIO_EDG, offset, val3);
 	} else {
 		ingenic_gpio_set_bit(jzgc, reg2, offset, val1);
 		ingenic_gpio_set_bit(jzgc, reg1, offset, val2);
@@ -3718,7 +3717,7 @@ static void ingenic_gpio_irq_ack(struct irq_data *irqd)
 	bool high;
 
 	if ((irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) &&
-	    !is_soc_or_above(jzgc->jzpc, ID_X2000)) {
+	    !is_soc_or_above(jzgc->jzpc, ID_X1600)) {
 		/*
 		 * Switch to an interrupt for the opposite edge to the one that
 		 * triggered the interrupt being ACKed.
@@ -3758,7 +3757,7 @@ static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 		irq_set_handler_locked(irqd, handle_bad_irq);
 	}
 
-	if ((type == IRQ_TYPE_EDGE_BOTH) && !is_soc_or_above(jzgc->jzpc, ID_X2000)) {
+	if (type == IRQ_TYPE_EDGE_BOTH && !is_soc_or_above(jzgc->jzpc, ID_X1600)) {
 		/*
 		 * The hardware does not support interrupts on both edges. The
 		 * best we can do is to set up a single-edge interrupt and then
-- 
2.56.0

