Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317C456E18;
	Fri, 21 Aug 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303903; cv=none; b=FL5GZeXMn/9T6eBcPMapZp2YgxLGaUGVKxer8jO3qEp3b06yVXfi/4G3dvC38Udq8hQ8n/fDNws/44s5ONEJKWpK25rtNJ6d+lD0WslWtho2Qp9k4K8piD7sTBJo/J17OZRWx1BoBxQTTdToB4UPbem+zVmP0ffQj2I4CUQp9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303903; c=relaxed/simple;
	bh=F2SMTyyvLy3aywHNtMoE0rAmososBvQplAmvV3UeTb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbXuBn4LE0AgV0bnx0qQ79Rskmc13LO1wXv4X1mpiMM6E7q40gET6WEeDBAV1mTdZDfftRW/rNZwU7M91g28IjjQdNEv5rWiQeA2PXuBVz9EqwHTFzaEt8xIeKRkxEDj6QhEK/+lj2yKGV7+cH1/lj73qDElgL10GAVT+5iQ6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Qlb9o5FS; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Qlb9o5FS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787303859;
	bh=GkCAaFuqzdFGwk6gUhRz/VdWVViseQciVSIzJUKUrTY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Qlb9o5FSM1eH3khEHtySQOifbrSo7lxRlTxBYC6W/bfwilJbE8NFGWjfaUXd6XW5f
	 QFLvB7l9JJn6X24MJl+autHqIVBTd7ZKAn1gQSwEFU4jQSpVZJPKnXAVfXoNOJjZhP
	 bFhgi7IwgZI4s6PCS6UFaKCqDIgUktj7Nz1LOmro=
X-QQ-mid: zesmtpgz5t1787303846tb5068b45
X-QQ-Originating-IP: vHhfDuAI0HXeyPLGfP/2JycYxzu/GsiSdSVBcddIkq8=
Received: from localhost.localdomain ( [1.85.7.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 17:17:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13173029870418661409
EX-QQ-RecipientCnt: 9
From: caina <caina@uniontech.com>
To: tglx@kernel.org,
	maz@kernel.org,
	radu@rendec.net,
	zouyipeng@huawei.com,
	guohanjun@huawei.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel@uniontech.com,
	caina <caina@uniontech.com>
Subject: [PATCH] Revert "irqchip/mbigen: Fix mbigen node address layout"
Date: Fri, 21 Aug 2026 17:17:20 +0800
Message-Id: <20260821091720.16665-1-caina@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <8633w854yk.wl-maz@kernel.org>
References: <8633w854yk.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MSyoPQEuxKCu30MW/y3j60JV6kfgwZXKiReF0o5LDXY3FDIEIDYV3ps9
	URQAtXy2+Aa6rk1UX8SC6Zhzn9DWgTLKSc+8Uy7Nzj9ZaTNJEQoz75254ZNFZiVpFks5UE3
	M0TsmpnWA7wSbvNrgtVKM2ciSJgF9ONK7OdM2X30fEKQd/QuUaQHrw/66wxlpVmKGfWPY6A
	SmtyQ2MPomMo3K1xcFxDW7/RTSBJJWO+//BWhp/WzAB1v25grrXiVx7Mi/irzXMSzsXx45Z
	2ZbNLMw3cg5Bq16yxNAccXd50aSEtPfBFNKZ7Avp084UF/wwKaw8Bzr/z3qGGbJAa3EHOAT
	th/hATtCEnHAexb9udqQcSCAOF8lraci753yFlceOvoB/cB5xcFbagij8paaBX7rIp8BOIE
	u/PGS5uvC1ok+d4eIk4b0KHsnAij1KmSSbUZIw1NFElsfdyTCaAW8o7xdtx0doB9aVviBwp
	Jgu4VtiUpxr5wThc0HbdfgdJKrpuR6CD/PLB2/bWf/YS/XTIFMQC4DdnJDblLw+d3pos4TX
	A5xUdy6mPV0t6aMRynAEXW76aSQYhkP0LaE+jj3OmXL5rWFDomuCr2dYv1+Zj8SOwHUJsXL
	xDwhgrosOxxS6lrwP8P/offUjjJzOatUr8fauDBmJUEUI2rA4W3TbkoJZYPgYbkw8hCpuqF
	rnRbwINStUQB9RkvEYSqdaaqhTA5cWQzGX7HxW7bq8ejtVrjiHT69g/EG1I74hS4VvgWrby
	J0KFYWTwOU+HVjCQEf4vvcFzWmy4Kcb+TEruQRoD3HFcBJS0ThawwnbHi09bGl2g9H6dxGO
	ca2TlkO1MiynyrI5ZTGxdTbGPdRk1wcEOpmjgyUrahjaXTxuLaINVnl+5a3nJJoFZmQr+r+
	syvlq2Q71YgkqsSC7AAO419957I1vTW9rj4WiNW4rsfNC8/e5HBEVerjRtZyhPZcU4vwar0
	kkDThJLRHorJd2XKP8Y0x6KFT9XPw0BWqumfhHv4IJIJW/7mQRMuAS/x903HnpSl5D1jafj
	Oz784c+GvQRwkXZXlTp/Fy4r7GFoqNTxtGhWSMPw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

This reverts commit 6be6cba9c4371d27f78d900ccfe34bb880d9ee20.

Commit 6be6cba9c437 ("irqchip/mbigen: Fix mbigen node address layout")
appears to cause a regression on Hi1616.

On-board hns NIC has two ports, enahisic2i0 and enahisic2i1, both
behind mbigen-v2.  Port 0 works; port 1 cannot pass any traffic.

Their interrupt pins fall on different mbigen nodes:

  enahisic2i0: pins 1152-1198 -> all in node 9
  enahisic2i1: pins 1200-1246 -> node 9 (1200-1215) + node 10 (1216-1246)

  (nid = (hwirq - 64) / 128 + 1; pin 1215 = node 9, pin 1216 = node 10)

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

    *addr = (hwirq / 32) * 4 + REG_MBIGEN_CLEAR_OFFSET;  /* 0xa000 */

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

Suggested-by: Marc Zyngier <maz@kernel.org>
Fixes: 6be6cba9c4371d27f78d900ccfe34bb880d9ee20 ("irqchip/mbigen: Fix mbigen node address layout")
Cc: stable@vger.kernel.org
Signed-off-by: caina <caina@uniontech.com>
---
 drivers/irqchip/irq-mbigen.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 6f69f4e5dbac..12919836dadb 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -64,20 +64,6 @@ struct mbigen_device {
 	void __iomem		*base;
 };
 
-static inline unsigned int get_mbigen_node_offset(unsigned int nid)
-{
-	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
-
-	/*
-	 * To avoid touched clear register in unexpected way, we need to directly
-	 * skip clear register when access to more than 10 mbigen nodes.
-	 */
-	if (nid >= (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
-		offset += MBIGEN_NODE_OFFSET;
-
-	return offset;
-}
-
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -86,7 +72,8 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
-	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
+	return pin * 4 + nid * MBIGEN_NODE_OFFSET
+			+ REG_MBIGEN_VEC_OFFSET;
 }
 
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -101,7 +88,8 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	*mask = 1 << (irq_ofst % 32);
 	ofst = irq_ofst / 32 * 4;
 
-	*addr = ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
+	*addr = ofst + nid * MBIGEN_NODE_OFFSET
+		+ REG_MBIGEN_TYPE_OFFSET;
 }
 
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
-- 
2.20.1

