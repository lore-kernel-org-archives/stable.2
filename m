Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596923;
	b=GEkkhkS9dIDtTCVjbP6rQmC5NFgQiCNr1DscN3mDQwAHxa9MM/mjGDvPBXb1DD1SjNBr
	 6DUlBZQFNL/5oj++dRTaQF2bCAb06RO4UrCcokKNs/bXdsLthLX7MrCfNbmE9ihGv6f0b
	 8008Fk6JqzGI4GH6UAqzFVql3tddV+HVVfBJEGfguXlbYjXNXzebOa+dUMDqmgHJdOsg9
	 H9dY66loYZJen84XQSQxw3aNYc202FMLWPgM+IuL4mxC/lpnYgZELCt4siGv53DlidT9A
	 9vzo5hu/c/8YPV3tbymxT/iXEVO7gEJSPpY7B+9Sos/AniYIt6Bu2T2BrOISWn7gHrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O+cYsgzT2IYrnjn4UHawDYzQU1HcpnMtWbFIeQ3G3aw=;
	b=SqxSd+5cMy5hB7nmi0O/ehUsT6P01V7JEkZFTTgLTdv7kEJN5f17jxDUoWOQW5d5Fl0A
	 TsiLgXIbJVmEMdU5BB/dIKxNvIODrZnlFm5JTR67oujJv+qUFy7lV2Qr/dMxWga6fbCOI
	 jUfNl9xW/u1a9F+8UY0EWp41Fw31H+HTkCpi3Q7elukbL9aRvyZ67g9nEssEDGJMXG4Yt
	 W09VQMY8DQLiejrg1lBM6mGDeFNq/9lsQ1cSNc0gEAC64MyChJerPi7/LHW1dLoK3Un4e
	 r/CLzqEMWG2m+mrfPkl41EmRwV86Gy4UpyhbQ/UeHiF4JhgqsqaqYWsUM67/qZCGdAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EwDKDm9n;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AED606A8A7
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27AED606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EwDKDm9n
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so3887673eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596922; x=1795201722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+cYsgzT2IYrnjn4UHawDYzQU1HcpnMtWbFIeQ3G3aw=;
        b=EwDKDm9nSU/jTREYh/cxN3W6tdK7apu5/SNw9Sd8IdmwUrbor7u3aICaiXChfvL9OM
         VQycw7+qsKqg4eC90CZnMTRNUkY62Ia1g0AzusTqzDqJkEiwFzgOv/HLB946Nrhb3tRj
         s7DIXsl4bjbvz7uj6gON8JywTmnjpklHFULgI48JHqjSFlXex7kMr/nHX1qQKZqmhVmW
         GucmXILq0IZe2+Lt8woy0b7GjNUBvXnPu/ni5zSIYu5VPAkDZuYfSCXsgmZRchcH9CoT
         5MIpFADNyJaB+YsYZgQpdupPLYhj7naI4sqtwXUI0Iv00nORkHpOFwTsR2jFwlErKJAi
         gbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596922; x=1795201722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+cYsgzT2IYrnjn4UHawDYzQU1HcpnMtWbFIeQ3G3aw=;
        b=rSyPRL4m3vtjLcYED57VRLdhjeJbVn8spqr+FFKLECgNvw+2hR2RkjhpR9h3V65sUV
         jMOjQuNbpP2MRQ1KhF+RTTY6bvO2vC35gxfxH2yoYCdNmnFfMz79PW/xT646l5NT+y6+
         79Pbpi+OLy0zdxqDxJDaCzelB4V9A+gEGYPu7wSe+WpF5d4wTZrOZwrHswa+5XPQeh9v
         18pKw4C2Ad5S4mPtLqf+SVd3NleiCQy9oTjgHOdFqHk0xIG1Bb1jOKzo66Vfg8Z8rlmB
         Nu3iWMOdT8e3ezaEAUMXDqY4mRCAUfXn380C2KaeU9dcK5miubmFl5OSWmKo+t2mQ1fH
         G72A==
X-Forwarded-Encrypted: i=1; AL+hErHjcyOy9Dm32c2mtCX3x7DOS0dwfS5TE+tKgYRE+q676NoEI7A/b3vumBGmNEur1Md4LTmAXm8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l7UyI86Ae4g2GVhr1n2Nbw954RJvmZEQGre5/xh4kENmRweGs
	aH7KfIk+OxArPhPV8I/3X4tWlNt5FBjZWlb5UvoAFw1cI/DTPcx+P+6h
X-Gm-Gg: AYBFou3lrPA2VSLKH/+91MrcKdUyEr2WomuJYYgkzKuFn+rM/bD4mlJt8zW13fXdge0
	IC9l6c/j3a6w9dVu594pDJZFJHJFME4EBcbi7CpVHmO1OtPuBlj4qK2tmm91ZcBJJss7aLRF3wj
	RZir3B9ER1HqCOaCoVu9km3FnXjpLFtQhEL/xywxI19Qx+H+PeSscB6hGO5g1HhGMGQByFxt5db
	gKlaA00/1NcPMo2PS38YGp+iNUwUxarVuawS/zxi+V6ltwF6R8sNmAgTKL1YV+DJOU62afgt15s
	DiHvsJRegEi37Tv2umBeZeId2Uw3/r5i6glOMJOaFStCcxnH/0DF8Kprv/i4tGVa4A8mrCkSqlA
	Be8Cl3oggeNZnxSUNOKpwo33wiVLL6qmkH3GF2wFWfpTIFmt2EpZG8dqHRlM5t4VnC4I8RPNDDy
	yoGSwC40CVWXTv7cjz+DcOfPJppUU1W/PuF3kKStny0Sa5VmTEfs1QsO0M+hrEx271HCm3yy/OC
	Z3c4Gv0Mn3yRq1IGL0I5ds0UK0grC6FmQIMslRuTT8ITlaKier7qIvX8qPhbvcdSzT6O+9OUCYI
	1CkYHI4u+mfwzuLPRORgaWKjC+dt9A==
X-Received: by 2002:a05:7300:478d:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-379681c6a08mr4217184eec.39.1794596922321;
        Fri, 13 Nov 2026 11:08:42 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm15714037eec.25.2026.11.13.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:08:41 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Burton <paulburton@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	=?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= <zhouyanjie@wanyeetech.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	hns@goldelico.com,
	paul@boddie.org.uk
Subject: [PATCH v6 1/4] clk: ingenic: Poll JZ4780 CPU1 power status atomically
Date: Fri, 13 Nov 2026 11:08:33 -0800
Message-ID: <20261113190836.470937-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113190836.470937-1-f.fainelli@gmail.com>
References: <20261113190836.470937-1-f.fainelli@gmail.com>
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

The CPU1 clock enable callback runs under the clock framework's spinlock
with interrupts disabled. Its readl_poll_timeout() can sleep between
reads, which is invalid in this context when SMP powers up CPU1.

Use readl_poll_timeout_atomic() with the existing interval and timeout.
This is a prerequisite for the JZ4780 SMP bring-up path. The original
CPU1 clock implementation by Zhou Yanjie is already upstream.

Cross-built for CI20; the subsequent SMP-enabled image brought up both
CPU cores. Development and validation used Codex assistance.

CC: stable@vger.kernel.org
Fixes: 6673db4f3f26 ("clk: JZ4780: Add function for enable the second core.")
Link: https://lkml.kernel.org/r/1582215889-113034-3-git-send-email-zhouyanjie@wanyeetech.com
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes since previous posting:
- No changes to this patch.

 drivers/clk/ingenic/jz4780-cgu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 1e88aef7ac0f..1809f8859c7e 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -242,8 +242,8 @@ static int jz4780_core1_enable(struct clk_hw *hw)
 	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	/* wait for the CPU to be powered up */
-	retval = readl_poll_timeout(cgu->base + CGU_REG_LCR, lcr,
-				 !(lcr & LCR_SCPUS), 10, timeout);
+	retval = readl_poll_timeout_atomic(cgu->base + CGU_REG_LCR, lcr,
+					   !(lcr & LCR_SCPUS), 10, timeout);
 	if (retval == -ETIMEDOUT) {
 		pr_err("%s: Wait for power up core1 timeout\n", __func__);
 		return retval;
