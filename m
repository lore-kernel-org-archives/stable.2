Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084815;
	b=HFfrLDDwp6fZEsKCv7+xHKlVnRAuK1KY97IHJmBroHAndesdDgtsvFK0yOCgdFMOZt/2
	 nG52/XDFgftYbGFuNYAoIC1lmtTh9eFP4GmBhEJLKAKyqTYf+ecEPIwYwa+XBdIAUs9XW
	 0c13sO8c6Y3MHQ4n27RmSe6/aG60TyKkkN7jMCL+xShvLwJl007PRG08LJxSrKagRc4Hg
	 3t0badNS2+1vPex4nJjtp2PvDZay84aD1YKQe/c2YTZTnc7lrSNuvv1kuejuXc+c3/j7T
	 zTsgY6zzZ0Ja8QjFH23RIySSuoBigVMaxw3e+cTMEBb4IKgUNHY4bzbwbofopU9WkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084815;
	h=DMARC-Filter:DKIM-Signature:Mime-Version:X-Original-From:Received:Cc:
	 Subject:Content-Transfer-Encoding:X-B4-Tracking:Content-Type:From:
	 Message-Id:X-Mailer:To:Date:X-Change-Id:X-Lms-Return-Path;
	bh=rm1SiYSaCZ8v2XPknfKS2cqm5SsYgR5uwTL8lG+Xc0k=;
	b=jGHB+m6OO4xDbmW1zhrx4mVLWDMFPoDsO43x3U21gOCRgMSVenjfUJe1fo/ES8LCcMVq
	 IFZlGTUBepe+el+0OnytsmXcnzHdEPcR5ef2ZkkBMy5L/mSMNbjKdxmzwjmTbKpI8sVuF
	 qit7T5cz43eXZZCxZFDWp6ssuz22R/9/ZeK2rSf6aVjbzhM6aVrdlMOkn95N6NtYPKQ5f
	 PzQhUAlHKoygPr+9I75vATjRuavuqlaQegAhUER1w+6gAdRdDHWQ/iU69xDvdvIh8iIjY
	 n1OPj+y3xg+OSE4t/mi19fueZS8wT8mscVIZm2DBKAKNl2fjzo6YJa1F2sItxZIX/vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=s8Nw7S1n;
	arc=none smtp.remote-ip=209.127.231.50
Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E2606A331
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427E2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=s8Nw7S1n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1795084809;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rm1SiYSaCZ8v2XPknfKS2cqm5SsYgR5uwTL8lG+Xc0k=;
 b=s8Nw7S1nXUqsQ9btfT4ULm6BdNKbgMyoGgrdcJqMArS4XETqeRBAvxsibizNeoiCx3THdF
 qq+QGGWkHr/VbPW6MsJvEjWK/C+/QATz+hIRSLJUsn+Af1On9CW+eMHiN7iip3ulgNiilC
 KJg1miNMEk5P5reQ9GaGyRAK9GL4HkMUA2NZjMpEFz9UNAFEbpuA+hyAOdSXqn0g8D0zto
 6aR7RC1xZTyYTqkFtlU2gpZwh2qwHovmRXFWF8uiMCq8PLMgZy5SYYWo35vdG5/ObTMbgV
 C1ALH4RfNvPh3fBg1DvMJlhv9Z1gMpBSqoTyL9XFJ2jtBbwZfBo0xuHvXuIOew==
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
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Thu, 19 Nov 2026 18:40:06 +0800
Cc: "Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Rong Zhang" <i@rong.moe>, 
	<linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Mike Yang" <reimu@sudomaker.com>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH 0/2] MIPS: kprobes fixes
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBA0as0s3YSNFTAq5gugE51NLaE0aYJ4 e5FXb7F/wWEMpPApSuQaWXhZW44HjqIdz/fCHlshqi0M+5k8MVJ8JnyEkgwJKRgR+0n5c+2h1a lTBNvv+N1+Fs+4UHx/d1ArTuqwgHFcwAAAA==
Content-Type: text/plain; charset=UTF-8
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Message-Id: <20261119-mips-kprobes-bp-v1-0-eff03ea13503@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"David Daney" <ddaney@caviumnetworks.com>
Date: Thu, 19 Nov 2026 18:38:59 +0800
X-Change-Id: c0497927-mips-kprobes-bp-eb8d4af0a685
X-Lms-Return-Path: <lba+26afed207+b41071+vger.kernel.org+rongrong@oss.cipunited.com>

arch_prepare_kprobe() writes the copied instruction and a single-step
completion breakpoint into an out-of-line instruction slot, but does not
synchronize the instruction cache for it. Due to arch_arm_kprobe() only
flushing the probed instruction by calling flush_insn_slot(), the
executable slot may remain unflushed when the kprobe is hit. This
becomes critical when get_insn_slot() reuses a just-freed slot.

Fix it by calling flush_icache_range() to really finish the preparation.

Additionally, the breakpoint exception handler executes STI, which
enables interrupts even when the breakpoint is located in an
interrupt-disabled critical section. Such situations usually correlate
with kprobes, where breakpoints are used to trap into the handlers and
single-step the original instruction.

Fix it by building the breakpoint handler with KMODE to enter kernel
mode with interrupts left as they are.

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Co-developed-by: Mike Yang <reimu@sudomaker.com>
Signed-off-by: Mike Yang <reimu@sudomaker.com>
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
Rong Zhang (2):
      MIPS: kprobes: Flush out-of-line instruction slots before use
      MIPS: Keep interrupts as they are in breakpoint handler

 arch/mips/kernel/genex.S   | 6 +++++-
 arch/mips/kernel/kprobes.c | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: c0497927-mips-kprobes-bp-eb8d4af0a685

Thanks,
Rong
