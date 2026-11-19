Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084817;
	b=GyvCSK5omMxuhQPjMuDBEr76PCgQdtVqXbL1zTL9ppuX6jpaZ/D9cP+ZRsYMW69w3qYG
	 q7wk76woAifouVBI5gJ3DvvGNPKoc5Zdd0Flze/lwtEbVhm8T8oiFnNqD9RPUGTxgwNLQ
	 cmsFL48g4tszn6ivha4F5K1fOBUc3KQlRIpmr1iN7W/DskPvHzAEXkDQ7GQiMZgRP+1b1
	 Ydq+aVm/eA+9dy+M7gXAbKal/wJt169ciLtvwRtv+GMkJg8vMVvLrSDHVfFV1A9p0c7FR
	 ixrs8CUQNlFx/CF3c51mjQDgEqrTZlRlP5J85KwvqjUolsdVhlzz2aDdXrnv+zAXpCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084817;
	h=DMARC-Filter:DKIM-Signature:To:References:Message-Id:Mime-Version:
	 X-Original-From:X-Lms-Return-Path:Cc:From:Subject:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:Received:In-Reply-To:Date;
	bh=KQPOp4xGjwuKezWUr9bZK0W9R/4TtsXBaWa2PNO2Dyk=;
	b=QZWkwjx9lm8TjlvcqH6et6kkKArQAQkk7x8Fw/Q9/q4Wf36fVt779NwOd4O/K7C3G7nq
	 S+hb1T56t7MrKhxWwAwsZdieDoJWoXNe5perHp+y/BE5MI0e9e9Z6KRwe4FbjGZO5ykLV
	 BdLCluJbO2acEBNIMcVUyb+rMYyFPlZEH/LDo+Bh1jJvmfKIfKZW0Uf7MQJGMogZ0jvub
	 i6hyoewgfItmnkq/KdtIVFDJqpdJa4aiv8JfV/GfIS38GIz71rDQjgkiuteEcDFwAOwwZ
	 6RcLbFKX0nxSTbXDm2i+sb8DWmG9Co7wQLBUv/rRGzBbcGqBKOLF0MMLGnu7qx+PAXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=5Jz8veAu;
	arc=none smtp.remote-ip=209.127.231.18
Received: from va-2-18.ptr.blmpb.com (va-2-18.ptr.blmpb.com [209.127.231.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102A60A2608
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7102A60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=5Jz8veAu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1795084813;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=KQPOp4xGjwuKezWUr9bZK0W9R/4TtsXBaWa2PNO2Dyk=;
 b=5Jz8veAuxn827m3JVjhj7Bqy+bSgYnvslsKCWHpivzlNMD+bnI7/y9MmscgkyGNWzn0N6J
 5RLnqhcDCMx0JSucuBwMxp3uEk0W2U7BEE6IFfgnsgh6/jvMpORVeBtzFoFLYYhHO7pUWa
 TlGR3vI7DdalPmOtFciSRXt8c9rz8QoDyismUFmXVcO7YNceXBP58+tLHx3dlcPc8X0FH0
 nSuObBM11OGqS1JC4iJk1YQPAum3/ON5UfLgsOUDAPVuuz+ZBsIQKS+b3FggVrIH7Msile
 ClDmTaRoMSSE8FNq3viY8sWvTiSv1iia5WwQpkEEnRAKb+k8NFM2D1+UoNjePA==
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"David Daney" <ddaney@caviumnetworks.com>
References: <20261119-mips-kprobes-bp-v1-0-eff03ea13503@oss.cipunited.com>
Message-Id: <20261119-mips-kprobes-bp-v1-2-eff03ea13503@oss.cipunited.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
X-Lms-Return-Path: <lba+26afed20b+591aa9+vger.kernel.org+rongrong@oss.cipunited.com>
Cc: "Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Rong Zhang" <i@rong.moe>, 
	<linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Mike Yang" <reimu@sudomaker.com>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH 2/2] MIPS: Keep interrupts as they are in breakpoint handler
X-Mailer: b4 0.17-dev-ce4c1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Thu, 19 Nov 2026 18:40:10 +0800
In-Reply-To: <20261119-mips-kprobes-bp-v1-0-eff03ea13503@oss.cipunited.com>
Date: Thu, 19 Nov 2026 18:39:01 +0800

Currently, the breakpoint exception handler executes STI, which enables
interrupts even when the breakpoint is located in an interrupt-disabled
critical section. Such situations usually correlate with kprobes, where
breakpoints are used to trap into the handlers and single-step the
original instruction.

As a result, registering kprobes into an IRQ-disabled critical section
could accidentally enable interrupts. Though returning to the next
instruction will restore (i.e., disable) interrupts again, it may have
caused irreversible consequences during breakpoint handling.

Build the breakpoint handler with KMODE to enter kernel mode with
interrupts left as they are.

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Cc: stable@vger.kernel.org
Co-developed-by: Mike Yang <reimu@sudomaker.com>
Signed-off-by: Mike Yang <reimu@sudomaker.com>
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/kernel/genex.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index be1b049d856f..e7a5f6bc31ff 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -485,6 +485,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	TRACE_IRQS_OFF
 	.endm
 
+	.macro	__build_clear_kmode
+	KMODE
+	.endm
+
 	.macro	__build_clear_fpe
 	CLI
 	TRACE_IRQS_OFF
@@ -569,7 +573,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER ades ade ade silent		/* #5  */
 	BUILD_HANDLER ibe be cli silent			/* #6  */
 	BUILD_HANDLER dbe be cli silent			/* #7  */
-	BUILD_HANDLER bp bp sti silent			/* #9  */
+	BUILD_HANDLER bp bp kmode silent		/* #9  */
 	BUILD_HANDLER ri ri sti silent			/* #10 */
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */

-- 
2.55.0
