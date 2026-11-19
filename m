Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084816;
	b=EnHBBj6x2nKZsc9jIM9eonaYEizo2HSz2Q1J9E9wNlN5mOFOz0qynWCEMkPAISdNjZ8Z
	 SdlFJBCQBdWT6l7FtQQJq+vEVP1bdijJVGds6PfQq8zfdAOmVndNqOP1pm1iBdMATFCCI
	 QZL8XF//ZNs+sgfZDSpPrjIIXZvuTqm662STaDEzxaNHOZAmhATPibSxT2U4egdnDdF2B
	 oq8Qy+e6EB0ir+HJM7pGrDTrknQaBzuRS5Qe9bNWyWWPzLAY2SNPItEgjWB8F27K2JDqE
	 5arvn+xyUjE5tLe+CQs0Z7Jsy1CGTwNV7DDZU/E4ee3Xf90Hubv8QGjYxNfKZE8CN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084816;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:Date:
	 X-Lms-Return-Path:Received:In-Reply-To:Cc:Message-Id:Content-Type:
	 References:X-Mailer:To:Subject:Mime-Version:X-Original-From:From;
	bh=pKhM2GMzEPBOe2U6z5BoSaANCjfVu/7aWvEopFUxvPo=;
	b=mDzvZFCFIM/chP/EYk1dHD7D/zviNUm3CCJJlvZiT+Bj3OOwzq0zU44IIP8/IpHURUig
	 2u5w1ynNbu0WyiivgBVXO+UuEXpnEhJroWXLX99zXtpU96yAxscOJvh44mpxH0yMagEqS
	 8lNhAG2sfPoohl3o+OJTX6EGX3UntUriCeuI2fa1A4U9FDDu5TzW1ZLwazcF4vElQ3TA0
	 kjFpGztxQjyQ1pQzshN21gC1C2Q1fvs4SCYGieqqhdtTm0KEXt7YrwA6e6W723OJ/T6Uf
	 EyHNKFZ7m7cFGIqM/cxtMEDOEnCJ5/Ce7JntsuR6dC3NSAO97CWqrfXfJw76x3u3uaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=enhDNKaS;
	arc=none smtp.remote-ip=209.127.231.59
Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647E606A33A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0647E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=enhDNKaS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1795084811;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=pKhM2GMzEPBOe2U6z5BoSaANCjfVu/7aWvEopFUxvPo=;
 b=enhDNKaSPIsxI78sgK1pXTqE+aTRkhT6iWpiViNX5/llXgN34ax6y8XD4mM3IJVSJvo4rg
 U4xIh2v2dt7hpkn3Ao0aHKkrLCUHRBaAujZtmsCUfvuQ2kQHXO/hpPgDVOdtNotMk1LGNl
 Tne9WT8t2/KtLb3CyeHps3WFxByT8xSVt0UyB3C+RQxSIDiXtFJrcUmI0SRv91JWrHNXr9
 I9rabgriPFpmDcALwTHVC1+Y8UnSp/gmwc0wOd8WZlAH/jST52X5qNp+ZIspgT2FCpVfej
 cIsgb02OSEj2C8panzYOJtXSAH2ihpAL7jo7Fow7nxd/RbYwNUW/1CinNczSJQ==
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Nov 2026 18:39:00 +0800
X-Lms-Return-Path: <lba+26afed209+ae431b+vger.kernel.org+rongrong@oss.cipunited.com>
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Thu, 19 Nov 2026 18:40:08 +0800
In-Reply-To: <20261119-mips-kprobes-bp-v1-0-eff03ea13503@oss.cipunited.com>
Cc: "Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Rong Zhang" <i@rong.moe>, 
	<linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Mike Yang" <reimu@sudomaker.com>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Message-Id: <20261119-mips-kprobes-bp-v1-1-eff03ea13503@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
References: <20261119-mips-kprobes-bp-v1-0-eff03ea13503@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"David Daney" <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: kprobes: Flush out-of-line instruction slots before use
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
From: "Rong Zhang" <rongrong@oss.cipunited.com>

arch_prepare_kprobe() writes the copied instruction and a single-step
completion breakpoint into an out-of-line instruction slot, but does not
synchronize the instruction cache for it. Due to arch_arm_kprobe() only
flushing the probed instruction by calling flush_insn_slot(), the
executable slot may remain unflushed when the kprobe is hit.

On machines without coherent instruction and data caches, executing the
slot can therefore fetch stale instructions. This becomes critical when
get_insn_slot() reuses a just-freed slot. In this case, the instruction
cache still holds a removed kprobe's copied instruction. Such
misexecution may lead to obscure issues or kernel panics.

Call flush_icache_range() to really finish the preparation, so that
both the copied instruction and the single-step completion breakpoint
are published for later use.

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Cc: stable@vger.kernel.org
Co-developed-by: Mike Yang <reimu@sudomaker.com>
Signed-off-by: Mike Yang <reimu@sudomaker.com>
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/kernel/kprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index dc39f5b3fb83..058f230d8faf 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -131,6 +131,15 @@ int arch_prepare_kprobe(struct kprobe *p)
 	p->ainsn.insn[1] = breakpoint2_insn;
 	p->opcode = *p->addr;
 
+	/*
+	 * While arming the probe will flush the probed instruction, this
+	 * publishes the copied instruction and the single-step breakpoint,
+	 * which is crucial when reusing a slot.
+	 */
+	flush_icache_range((unsigned long)p->ainsn.insn,
+			   (unsigned long)p->ainsn.insn +
+			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));
+
 out:
 	return ret;
 }

-- 
2.55.0
