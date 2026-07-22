Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625B3F23B1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741110; cv=none; b=BRXQsp51tEbpASo4RU4zX6lCO8GstXwjjr7DDn9mJ0NfERwtSUCipcyIMJqO1L47QJtvrqUQjp1rVbXje9WaSoNMXItXLetb/QNoNVxGoREUHi2mNtIpLLhdreVENl44oZmh9ygp4rgC+ssgfuLNjnuGwAUseRZ3nZ0HJJiLM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741110; c=relaxed/simple;
	bh=zWRJXCy2wjVlrC6Ts2vSMU+M0dIL/NNVsL3qymVX1C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FazlAc3fyxZtmviZlBDEDnEy7lkLF4qJowmLhhgm9+LowWNBLk0GHhCPqRY1szuiXrM7QIFt/1MlJcULBf8nw3vQb2pDOUl18SlpBEX6tQHzc5zz1u5h4zBBlibPjBUz1BW9BOz3SUXBv0kCsNcM2GkLVavUsQaTBxPMGUqOfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI1TTx14; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI1TTx14"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485b358552so376058b3a.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784741103; x=1785345903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1w/L0JEj1tAoEtTkbuyiqxCj7tfW27Vj36Bhq5Zj1YU=;
        b=ZI1TTx14I27Jz50NAhBWwfgqwjODBEH0yFMOjHjVy8QsPkDvgat/m/bEeuqjPKOFg5
         J92NDjMwPye609/PvnWIZL8Bb7tCRKTwmwNG/jKProFwE2Tl5YiN2g7TRjjzJNVX3Omk
         7333heX9woDqPV7DiD5vZjy99cKhUU7NbEVlHIRsIb26j+2V+GYcgc9k4ykyv4NjgwJY
         IRQYkDdt7W/iWU+fXLK0anJxIOLL2I75TuoTE3s6fnlWvXM+8WtEJBXds2w1nDVhXx36
         33vr/+ibGuUxk1T8dla3KDt6RtFzqohmOrZCCkLbxhM/R8YDz1C5IUBDEJ1Xh8e2GDMj
         uVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784741103; x=1785345903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1w/L0JEj1tAoEtTkbuyiqxCj7tfW27Vj36Bhq5Zj1YU=;
        b=mrJTkrweB1F6xu5zC0Iq7Mgt4up8jKHGLiYpAWmoLNcU21pJJfjgKof9IF0bwrLuzk
         VJWJbuWhXY/Hf9MATL0YwbZC/jkkAVQi7DhaLCgiRmGsmeQey/t6FEBW15J7sK5lBNbV
         FZF9Wr8tvPGQRiF1lDkPrbhwaFMgwYbOKj7jz3OJ+XwHeyqjoxRAqqndOx5H194qasDS
         Zu/sSl8+tFWxiMRm/z7DfvqetaHvRLWMW2hcX20fubLfR/BdXpezNeB5NodHz0A1q3Id
         ETdKnPG0cBvFJDaG0ATDe5EF0IducsW83AFxeNfrvsMzuJ4uuvqSGwrBv50GELhma4SJ
         QvEw==
X-Forwarded-Encrypted: i=1; AHgh+RpnXsaxFjH5gMz1SuymEb0jcwwMFIlJXS16NQ2IGNWtlUUe8Cc9oo7pZoGgg9QcKhIiieXsEv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkz1fSg2sUtPkZy+B8zFcScZwk0iBbfAC0eiJBM0lie1cxz1C
	tLhLU/qPNVZssbUOsFNgkMJU5uS0qyHFiMl46FBMqjZcm8O2e6H2vAAP
X-Gm-Gg: AR+sD10+9dPTFCsfYblo2Azu5+Pbn+pl1y1v+g7P+Vl8r0wlEiM+TxeGxTQULy+hVhA
	5BRVE3+vz6WlnEyqIQLkoyfUUjE3w5IOI/IFxy0XSy+lam35b/vhfPNXmsWV50wv7UWgwid80nf
	e7P+5H6xhCZdO/wSZ3KJbTnRhdKYQ2FEwYKaqtEWCQrsmpYHoolBWBwcoQf04+F/f+ER+H1J1t7
	grfaf2w/sisWsMRDWY/6VjNGD6NcdnED5f1xdEcYurpsUBr93KF8GC3wJYMcz9JUUUmZiUFjpJs
	bXPe5YttTD4lQeH20mqoKQ4o9Vt/ZR100phXKlQ6M1R+8yTpCrRJMZxFmReJyGHJEB71nXd70tq
	9bSTWnsDF1ydk/ZX2z/DvAciEy36kJWjHxZ4Iq1lpAlnysVPtR8cDRnxkKnoU3tr5tXQWa5QlJj
	pqbp6tF+5f7XUt9PVRo26BCkFWTGnEJmiU4Rc2tQcTJNT2
X-Received: by 2002:a05:6a00:2e07:b0:848:2f84:730 with SMTP id d2e1a72fcca58-84c294e6a56mr23499585b3a.67.1784741102709;
        Wed, 22 Jul 2026 10:25:02 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1757488csm1645603b3a.33.2026.07.22.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:25:02 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b),
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels with Clang
Date: Thu, 23 Jul 2026 02:24:43 +0900
Message-ID: <20260722172443.534251-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with CONFIG_THUMB2_KERNEL=y and Clang, secondary CPUs
fail to come online with "CPU1: failed to come online". The address
written to the jump register has bit 0 set, causing the secondary CPU
to start in Thumb mode.

secondary_startup_arm is ARM-mode code (.arm) and, on a Thumb-2 kernel,
expects to be entered in ARM mode in order to switch to Thumb via the
standard sequence at that label. Starting in Thumb mode causes the CPU
to execute ARM instructions as Thumb, resulting in an immediate crash.

Clear bit 0 of the entry address so the CPU always starts in ARM mode.

Tested on Lenovo YOGA Tablet 10 (Wi-Fi).

Fixes: 0cda07001a94 ("ARM: mediatek: add smp bringup code")
Assisted-by: DeepSeek:deepseek-v4-pro
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 arch/arm/mach-mediatek/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index 6b0943d95555..9a7c65fc3ae1 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -124,7 +124,7 @@ static void __init __mtk_smp_prepare_cpus(unsigned int max_cpus, int trustzone)
 	 * write the address of slave startup address into the system-wide
 	 * jump register
 	 */
-	writel_relaxed(__pa_symbol(secondary_startup_arm),
+	writel_relaxed(__pa_symbol(secondary_startup_arm) & ~1,
 			mtk_smp_base + mtk_smp_info->jump_reg);
 }
 
-- 
2.54.0

