Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022745;
	b=t43Gk8FaLhfOee4z8MpSnQeK9ySy369ZM14PMBoJZpWjbSAdpSPl729THtZ5rjRWZPhB
	 d9C6RlZwJpjYxO/lJJi8ssN6G6G3Qb0rHmsTSrcoRvf8+TxHJMTQoXaWZG5SSgKiR5j31
	 Ht5saeL4ZBrICpBPQknJ7Tl/mUb73dwZuSrnV5Kmjjt4i6ba+Uip69L/2Yr2t1sTQBvR9
	 s45aEGCYXVnqylscH81pArTE3wWyW/yS1x7yn8Z21kJ7NSxeQjChUq6E26I6Z391WEk7d
	 qw8g0mUDgZ47s0m5aExxakiH+1R+PA+UFlx1aCWrF4LG1+VrMPeMc/tj5vITdQMksBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022745;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=N+ZLUTfEpjO5oUNCth3iHY0m+60IhVuCjuhmSxCyjJg=;
	b=GZSvJQ21ltr77OzsmNWbTIvKt+zfqOVSvID1kkK6e1SSBe7thaVzz4Nz2IwjBNgJ3wVS
	 GZwhTSnQ1caRwutW9yM3Aqcc1834NvTe+muIu8TRi7EI52wX2CeFVk+0cvyQa6L4ATvut
	 WnSgj5bhNUgGi81X9vyZBST/uQxacXe0vzAZ3huuoW7ktN/oyEjaxasmpxrAyjIaFTZPP
	 7S5bpNc70yFm0rWdtRyQwbxfa4iEZ23AAvfvfktIG1C8VVytJxELpp/mnUTN74GCOmjdi
	 sXtYHIvTJCluql3XiSDg8AyV26iHFYyepBdyismU2h3S4lGhATaFp8rEixgR3bn3sow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=JHhRuAT+;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=5DD7sqL7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5C606A31C;
	Wed, 18 Nov 2026 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=JHhRuAT+;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=5DD7sqL7
ARC-Seal: i=1; a=rsa-sha256; t=1795022740; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MbKJMsphile9weZ+pK1vUkLFTRnbQyJMdp+1CQrcDcRawmP9XBigR6T4AmvQmerJ0o
    3AmoPO3m53YWMo9eMrXtHTHlFVB56eWzCgjTU/IXTSu3VitzUbyQwLzidRIihsXLSaK7
    6O3qwofefRiYsUxsVsXmeeQYFsYwlN+h4wtKIU40MrF8Cmw4kLZndkMhGaHaBxjSU6kS
    PBtKTcNCF7G/FG81xvic46xFBKcv8SFioyia8hL7zAhf5LyB06OZnI22FnArdDM77y7h
    EubwfBWl4M0RrOVSsmeRZf9jzm1JvbyFIUMs5HX/OFvaomZIrK5kEjdkyBBpw8jRKNX2
    gNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795022740;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N+ZLUTfEpjO5oUNCth3iHY0m+60IhVuCjuhmSxCyjJg=;
    b=KBxATpE7lUZZUBUPP7e3T5Kkfdl1+nNnZkZPysRMvKg4KU43+4BTqxZeqDBLs93wdE
    mMNz5wl7C5p0HmEpIHWsxYYRLUpD3+JaSvYpNiYlKhxKojjsmgMEp0ViJVD56LH/PPPO
    3GoB60AZXqYc0HXY3NyBdKarufgW0Yyp9pB4ASMRGQfAxUlzSUk0rCv76s2cy4ppRPO4
    7z5k0z2Zp7etprfLX0Aj8FQZOHh7Fr/6Dxwclp+RngRIEREvUNa9IGkRJCQxkRabht8J
    JUkZnRqmUj6ROYPVeuBqPYDlrqw9X4Ol2dxJnJf3XFvIzat52z8KqbTJgRK5He+EDGaV
    5rbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795022740;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N+ZLUTfEpjO5oUNCth3iHY0m+60IhVuCjuhmSxCyjJg=;
    b=JHhRuAT+AAdU5kOcMr4OmJ75TpvcwdZa9RRzki+gFKzMsiCnUiUFgje0uaiStyaH3p
    8kv9H4VSk7VyopJSgSQ8s8q5DBSvYbJD0LvtxcWaA3YarKbdtgglew4BrUwIlBarq3TM
    hQ6NVqyTn+Zq73CCOawbAO8gs/K6V5D3sToRCoV8c00d1f4Z50XCQ7u0NTVfUgnHhKxT
    0MjFsKGttu+w4ye1hDVy9vOShAdoD3j8D+w47bHY8n1dtdDu2eA+l2K82CIYypKgWvFj
    e1dvzg9Cb4l4qCYzCyBPbphi/eJ0QjadUSgk8HRpMQ/Lx9J1CcCh8ao97iBxhqJsHX62
    nkAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795022740;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N+ZLUTfEpjO5oUNCth3iHY0m+60IhVuCjuhmSxCyjJg=;
    b=5DD7sqL7flN3HAglVVBF37wTpZvIqG1k8Wpnl88U3rioEEvQeqiWHhJhL93C2lq1VH
    pqVWYQxAp9VKJ2TWJ+BQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2Jpcm8iNZLZ2IBizV+3wFb55dglUeZzcEX9J"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AIHPddiV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Nov 2026 18:25:39 +0100 (CET)
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
Subject: [PATCH v4 2/7] pinctrl: ingenic: Fix hardware dual-edge interrupts on X1600
Date: Wed, 18 Nov 2026 18:25:32 +0100
Message-ID: <12e66f571e8765b1eefeab5939c2c874b71b28af.1795022736.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795022736.git.hns@goldelico.com>
References: <cover.1795022736.git.hns@goldelico.com>
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
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
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

