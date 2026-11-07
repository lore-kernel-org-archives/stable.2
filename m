Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048941;
	b=YSm9LXSUT0y4J14W7UbfksD4PhJ1uHsPcOSruDXnycpO96rPD1Of1mJNlw6vn4SEuuY9
	 0YBiYlmmyhsgejPzBWe/HDlgUUcEUErGVbfXTyFuR9I8VLyfyiKdh/bH/1yiXaxZhf9ts
	 Xm1DMmMiFOA1KXhA8JxbFB+vpEXFQb/Zc9Ps72w5/d1eetN/p5yOqzrDv4UWSusJVBApF
	 gikt4Lq616ekgR0p18XzAsXlvD7o1bMelOul5ymy8GX1xRxp5unC3PJUMor1RlTnUHmeu
	 zjFkSxbeIcXrZWLqahRAsucWEfWH7/tVp/cD3hDXUlG0G4+vTbVkW1JndtmtP7p8EjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f/BXV1V1XE3wt0ib8WFDXSFDX+MoRDtQZFRTruEOTDo=;
	b=NlFNXJVS2keY70QBL5r7639k197w8b9Bmcwkc87tdHKwSSarxpIL40Rm3/b9G98xH6nW
	 wZXalAlV74fdoa7uDvNgHcI8BCDTxQa0xtLMrlF+p0mvz76o4vHUjoYZehy6ipF1s2BF5
	 wrkNSuHz2na6WeKcQVRokm5vG8CaWE9/k4D2VjZQi7uIhivqANpkYQWjJE/RFznOgNtdf
	 XdQtEv/FFgYgw44xxGloUE1mnxu6gQBalWcXKIM20PVLSrbo7PQgr1wEuwqpvomV9aaDw
	 +gTMCfa0kzNZltCqLIdBxM+cVH7Qo8K3HM0UEZuFxUONb84A/ugWKNXnlCM+zzrtqtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaCf2HJm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35919606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaCf2HJm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F221F0089F;
	Sat,  7 Nov 2026 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048941;
	bh=f/BXV1V1XE3wt0ib8WFDXSFDX+MoRDtQZFRTruEOTDo=;
	h=From:To:Cc:Subject:Date;
	b=KaCf2HJmtNT1qvirzwohSvAGRM7hfGuoPItySotJomk69oFH7T5XXDY3weXN1FnPO
	 qqDdawTYVIls+NOXeDCbnM0sOaCwm5CgB4eYw2guMTgvwGZ6tYhYt6nHX1Tg5z84Vm
	 x/EZDWNvrRDCXyFe1vmtfYoQNnjFevo38Qcpv7/TXOV2m32fD+or28XuTAEQFQyutY
	 84PPO7j/XMvMb1w/botsMSDyMyZoi9HtKWAu/iVfKcMrVZERbKz7V8M+0onNkcdlty
	 nL4ZYCzRtTlO+YmLunJ+gEq8OCbr+Daw0maroUtNDEOFke4+YNWsVkQ4HcfGKLKrxl
	 w5G4W0V50dePA==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Call cpu_final_simd() with pure_initcall()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:39 -0500
Message-ID: <20261107055539-failed-6.1-9b56c3659a7e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9b56c3659a7e5d930ab3c07ea74cc46af65b6d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055539-failed-6.1-9b56c3659a7e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9b56c3659a7e5d930ab3c07ea74cc46af65b6d20 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@loongson.cn>
Date: Tue, 27 Oct 2026 22:51:23 +0800
Subject: [PATCH] LoongArch: Call cpu_final_simd() with pure_initcall()

After commit 35ebc4de105989034f12 ("xor: remove macro abuse for XOR
implementation registrations"), using "simd=128" to limit SIMD on a
platform with 256bit SIMD instructions causes a boot failure.

Because cpu_final_simd() is called with arch_initcall() now, which is
after xor_init(), LASX flavors are selected but not workable.

Call cpu_final_simd() with pure_initcall() which is before xor_init().

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/cpu-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 74d31f260dfd8..629c976c33c35 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -93,7 +93,7 @@ static int __init cpu_final_simd(void)
 	return 0;
 }
 
-arch_initcall(cpu_final_simd);
+pure_initcall(cpu_final_simd);
 
 static inline void set_elf_platform(int cpu, const char *plat)
 {
-- 
2.53.0




