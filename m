Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A062DCF61;
	Fri,  4 Sep 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531519; cv=none; b=fDUYdsI+98mD5Q2x2uAqAKb1In/7kRJZo1lzHGe6jaLYyGpnttQQMs65nKfbi4pQipofaWO8PRh2tHPIn+llvi2W+yS4E/hhpzft84F1XnJEexXgqEB6GGywgDN6tbaOUQnVdoWlUP8IU6vZET2LogD6U3Og+06wJ8JXUcAqR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531519; c=relaxed/simple;
	bh=YDV6+Urer6dQz9ZVee0DKss8kRohdqqQNbMFoYHCqt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i1AT6GQ3kkaXnKtjlI+eHs9tFdFbb0B6wWHuC57gBeTsoSo8mSYDmmg4f++kDut4jOkXy5VQR/PjUElJOuyzANFLDBYMfKf7mpBllm/l7s2GghYcaU8/c7iZls3gBgrQ3qVbh24DSmbsU1E+EMrgujayrbUG5JkkLBjALdyj3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jkvNrvzX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8J+n8XAp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jkvNrvzX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8J+n8XAp"
Date: Fri, 04 Sep 2026 14:18:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788531514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyy2VA3eCSIDSnJNYcuLJmk1QFeKZzfBOjKvD3RmaHg=;
	b=jkvNrvzXBBZfiFn+782umxxO3Ksig09AuIhf69UCL8du0T7X2uZ4G+LqgBRYph1etHXuVY
	AOssODM0JEn+WBgPUwKxcbb3vj+wGOEhQOyabs1qwhqFhK/dk6rND1p6NcDZGvyVm9m+KK
	jFME6fdotXEcWmoG9bOF6OVWNRByE8r79zvxgCnCdnz42twvDzzfpo9yh/2IC+8LXwm27a
	ZnDZG/TP/+JQS7pDoXVyBB2/EAnKhf08BsfRgqhpkq7QBdJdAmU7mRQozsGMEPqAiBgZzw
	X7V76FWJxJ3wUiAiYKjcYYByzWQzMCixetY78O1qFa3Nj64AVoM2IEBmCPwEyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788531514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyy2VA3eCSIDSnJNYcuLJmk1QFeKZzfBOjKvD3RmaHg=;
	b=8J+n8XApJ7NmK7un2+/yPOjSBcjwz6SAl7YKbp5Dm3AzJD7UWlCUaUzQ4xaU6nQKATeVEI
	OMg4Ljpd5AWqhcBQ==
From: "tip-bot2 for caina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] Revert "irqchip/mbigen: Fix mbigen node address layout"
Cc: Marc Zyngier <maz@kernel.org>, caina <caina@uniontech.com>,
 Thomas Gleixner <tglx@kernel.org>, Yipeng Zou <zouyipeng@huawei.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260821091720.16665-1-caina@uniontech.com>
References: <20260821091720.16665-1-caina@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178853151291.3717435.6977380266521464965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e67091609cf85962f64391c1b0f93d4cbfcd4e22
Gitweb:        https://git.kernel.org/tip/e67091609cf85962f64391c1b0f93d4cbfc=
d4e22
Author:        caina <caina@uniontech.com>
AuthorDate:    Fri, 21 Aug 2026 17:17:20 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 04 Sep 2026 16:12:53 +02:00

Revert "irqchip/mbigen: Fix mbigen node address layout"

This reverts commit 6be6cba9c4371d27f78d900ccfe34bb880d9ee20.

Commit 6be6cba9c437 ("irqchip/mbigen: Fix mbigen node address layout")
appears to cause a regression on Hi1616.

On-board hns NIC has two ports, enahisic2i0 and enahisic2i1, both
behind mbigen-v2.  Port 0 works; port 1 cannot pass any traffic.

Their interrupt pins fall on different mbigen nodes:

  enahisic2i0: pins 1152-1198 -> all in node 9
  enahisic2i1: pins 1200-1246 -> node 9 (1200-1215) + node 10 (1216-1246)

  (nid =3D (hwirq - 64) / 128 + 1; pin 1215 =3D node 9, pin 1216 =3D node 10)

/proc/interrupts shows the break happens exactly at the node boundary:

  enahisic2i1-rx0  pin 1200  count 102   <- node 9
  enahisic2i1-rx5  pin 1215  count   1   <- node 9, last pin
  enahisic2i1-tx5  pin 1216  count   0   <- node 10, first pin
  enahisic2i1-rx6  pin 1218  count   0   <- node 10
  ...all node 10 pins stay at zero.

Port 0 (entirely node 9) is unaffected.  Reverting the commit restores
normal operation.

The commit assumes CLEAR occupies a full 4 KB page at [0xa000, 0xb000)
and collides with node 10, so node 10+ gets shifted by 0x1000.

But get_mbigen_clear_reg() uses flat, chip-wide addressing -- it never
multiplies by the node ID:

    *addr =3D (hwirq / 32) * 4 + REG_MBIGEN_CLEAR_OFFSET;  /* 0xa000 */

Over the valid hwirq range [64, 1407], CLEAR only spans 0xa008-0xa0af
(168 bytes).  Node 10's registers are:

    TYPE: 0xa000-0xa00f  (16 B)   overlaps CLEAR by 8 B (0xa008-0xa00f)
    VEC:  0xa200-0xa3ff  (512 B)  no overlap with CLEAR

Shifting the whole page moves VEC from 0xa200 to 0xb200.  The hardware
reads the event ID from the fixed silicon address 0xa200 on interrupt
firing, but software wrote it to 0xb200 -- so the hardware gets an
uninitialised value and the interrupt is lost.

The only real overlap is 8 bytes of TYPE.  It can only trigger when a
single mbigen instance has devices on both node 1 (CLEAR 0xa008) and
node 10 (TYPE 0xa008).  On Hi1616 those nodes are on separate mbigen
instances, so it never triggers.

Fixes: 6be6cba9c4371d27f78d900ccfe34bb880d9ee20 ("irqchip/mbigen: Fix mbigen =
node address layout")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: caina <caina@uniontech.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Yipeng Zou <zouyipeng@huawei.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260821091720.16665-1-caina@uniontech.com
---
 drivers/irqchip/irq-mbigen.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 6f69f4e..1291983 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -64,20 +64,6 @@ struct mbigen_device {
 	void __iomem		*base;
 };
=20
-static inline unsigned int get_mbigen_node_offset(unsigned int nid)
-{
-	unsigned int offset =3D nid * MBIGEN_NODE_OFFSET;
-
-	/*
-	 * To avoid touched clear register in unexpected way, we need to directly
-	 * skip clear register when access to more than 10 mbigen nodes.
-	 */
-	if (nid >=3D (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
-		offset +=3D MBIGEN_NODE_OFFSET;
-
-	return offset;
-}
-
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -86,7 +72,8 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number=
_t hwirq)
 	nid =3D hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin =3D hwirq % IRQS_PER_MBIGEN_NODE;
=20
-	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
+	return pin * 4 + nid * MBIGEN_NODE_OFFSET
+			+ REG_MBIGEN_VEC_OFFSET;
 }
=20
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -101,7 +88,8 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwi=
rq,
 	*mask =3D 1 << (irq_ofst % 32);
 	ofst =3D irq_ofst / 32 * 4;
=20
-	*addr =3D ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
+	*addr =3D ofst + nid * MBIGEN_NODE_OFFSET
+		+ REG_MBIGEN_TYPE_OFFSET;
 }
=20
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
