Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E443441C;
	Mon, 24 Aug 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580609; cv=pass; b=kuLVgN6Y8fLKvA5F0CJra7so8HyjjGHzMDJfj7FPXrUNVhShU67QpSfXd0qZn8SjWMe8YSwnPW0pT5ONw2iehNul+RDeC0YjfB4qX/12Z6Hgd0nfOGr2ZNXziuho4szEoMpD4gql8C8IJVAalk7FlzsN5fOSPP5edEpjDX6AKAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580609; c=relaxed/simple;
	bh=gO2QlzyaY4RLJobJKaTT0WJ39uMKgLxWfxnjtNPHa0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+yY4jcHUHSH0TeB8QbW7VBuzasACL+gx2ux1wBuxzDrjOwYUYAGFofcz3CgIudWhP0xvti/mZJ63TGT1/FI0SW3k3fAhnq7XedSVwSrg1/P26w4H5J5Wqi2o9aT/NcARtuddS6EGf0jFTDLREfX4WRf1Gca67INHm1hO5Yr05U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=NsQJwBuS; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="NsQJwBuS"
ARC-Seal: i=1; a=rsa-sha256; t=1787580579; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xs7GQE12vG2J/xDZWnVYI0ICOOtYtKpA3u4jAoCJ3DJWJ/HGcOwBHkZGAMiIhGCi+6CjDR8jz9N0qOX/Q0JMmeJlgT3SP0ReWcGnVR8MeH+VjLKD7EBTABm+Gpbtml9qPeWTOX0WQhKZ4IuYKP53wBnn16hgbewo9rp1mgjE6a0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787580579; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YqE5t8CDTWJv/M+DMvOpZZ0XYqSFISFkIBm+cI8/axs=; 
	b=A9iuqLEyKwqfIOtD+6x333t8sQv5iw4xVqAnRNJ0f6rNK5HRAql15maRew2U92zlspAH3b02f81S9YxXGThZxSADaEdA0uVp4RwYhdHoKxjQCstghy409ZI33yzYW/iW4+E9plYWX2wBTOT/vWta0W5H3gfTbbG4od8Qq/xQPcM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787580579;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YqE5t8CDTWJv/M+DMvOpZZ0XYqSFISFkIBm+cI8/axs=;
	b=NsQJwBuSxj8BJ0czi1c/R29UhQxdo+b6ZwHBMlGQ2QqQo0XgZBsn+lCA3HrZVpLx
	LVODQh7ik2reF/PwCs1SbjpF/c44RoB+bQhELsBBMUQuPXXxJh4482xYi3jIHUhcKSg
	H7xXc5BG/Jy0Z9hIuptdp9wLSHPFWSU60qYt2qcA=
Received: by mx.zohomail.com with SMTPS id 1787580576626588.5393770719288;
	Mon, 24 Aug 2026 07:09:36 -0700 (PDT)
Message-ID: <da6bffba-6c44-4ee7-a1a8-842f9e6de408@yoavmoshe.com>
Date: Mon, 24 Aug 2026 16:09:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718111340.159896-1-linux@yoavmoshe.com>
 <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com>
 <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com>
 <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com>
 <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com>
 <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com>
 <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
 <CAKwvOdnaOy-nyZ=8oLw4N-_hA9JZVdP2BhR8cweCAOhsy4VG6w@mail.gmail.com>
 <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com>
 <CAKwvOdk-JmqjhZWBiLjXTxKhEV+T3BAB6An+3Ara8oybmhAMpA@mail.gmail.com>
Content-Language: en-GB, sv-SE
From: Yo'av Moshe <linux@yoavmoshe.com>
In-Reply-To: <CAKwvOdk-JmqjhZWBiLjXTxKhEV+T3BAB6An+3Ara8oybmhAMpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Sorry it took so long, I finally got it to work using your method!

On 2026-08-17 11:58 PM, Nick Desaulniers wrote:
> Can you share that diff? I would have expected that to work. Perhaps a
> minor mistake in your implementation?

I started with something very simple: using SYM_TYPED_FUNC_START and
copying the 4-byte hash into OCRAM before fncpy(). But that didn't boot
on my hardware (Kobo Clara HD, i.MX6SLL).

I think the issues were:
1. My first attempt wrote the hash to suspend_ocram_base +
sizeof(*pm_info) - 4, which I suspect overwrote the last member of
struct imx6_cpu_pm_info, corrupting the memory controller setup.
2. Moving the hash after pm_info and offsetting fncpy by +4 still failed
— I think because fncpy requires 8-byte aligned source and destination
addresses (FNCPY_ALIGN, with a BUG_ON check).
3. Offsetting by +8 for alignment also failed. I suspect it is because
SYM_TYPED_FUNC_START emits the 4-byte hash after the .align directive,
which shifts the imx6_suspend label out of 8-byte alignment, again
triggering fncpy's source alignment BUG_ON.

The version that finally boots on hardware emits the hash manually with
explicit alignment padding, instead of using SYM_TYPED_FUNC_START:

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index a671ca4..b500922 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -515,7 +515,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	pm_info = suspend_ocram_base;
 	pm_info->pbase = ocram_pbase;
 	pm_info->resume_addr = __pa_symbol(v7_cpu_resume);
-	pm_info->pm_info_size = sizeof(*pm_info);
+	pm_info->pm_info_size = sizeof(*pm_info) + 8;
 
 	/*
 	 * ccm physical address is not used by asm code currently,
@@ -568,10 +568,16 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 			mmdc_offset_array[i]);
 	}
 
+	/* Reserve 8 bytes between pm_info and the function copy in OCRAM:
+	 * 4 bytes padding + 4 bytes kCFI type hash, so that the hash sits
+	 * at fncpy_dest - 4 and fncpy_dest remains 8-byte aligned. */
+	*(u32 *)(suspend_ocram_base + sizeof(*pm_info) + 4) =
+		*(((u32 *)&imx6_suspend) - 1);
+
 	imx6_suspend_in_ocram_fn = fncpy(
-		suspend_ocram_base + sizeof(*pm_info),
+		suspend_ocram_base + sizeof(*pm_info) + 8,
 		&imx6_suspend,
-		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
+		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info) - 8);
 
 	__arm_iomem_set_ro(suspend_ocram_base, MX6Q_SUSPEND_OCRAM_SIZE);
 
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 63ccc2d..c06e474 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -3,6 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
@@ -148,6 +149,15 @@
 
 	.endm
 
+#ifdef CONFIG_CFI
+	/*
+	 * Emit kCFI type hash before imx6_suspend with padding to preserve
+	 * the 8-byte alignment that fncpy requires for the source address.
+	 */
+	.align	3
+	.4byte	0
+	__CFI_TYPE(imx6_suspend)
+#endif
 ENTRY(imx6_suspend)
 	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
 	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]


> How did you verify this? Can you share the command line invocations and output?
I tested each iteration on postmarketOS by building the kernel with
pmbootstrap (Clang/LLVM, CONFIG_CFI=y), replacing the vmlinuz on the SD
card, and booting the Kobo Clara HD. The earlier attempts all failed to
boot (though they worked fine in QEMU, which doesn't emulate the i.MX6
MMDC hardware I guess?).

I'm not really sure which approach is better now. The version above
preserves CFI on the indirect call, but it's quite involved compared to
the v3 __nocfi wrapper. If you think this is the better way to go, I'm
happy to clean it up and resubmit as v4.

Yo'av
