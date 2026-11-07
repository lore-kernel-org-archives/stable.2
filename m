Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047986;
	b=bP/VWrkroJ1L7iOxMNynxlXf0aA1VeHh7+rUDJHneuPG6Elcz+yjCTduRpiVimJfGmLx
	 yZkYhuc81Yq2hh6eqYK8sN3gQ+Qv9xrHADjepwIvuT/KjpjlgJmZUjS1lxkMi8rhan2Qt
	 GHKR98rYMRDMDwmepLCsIwqlx/kIes6TcBTZrcD0xa2fQyTiVas+vjI7qQBok+m/0d2AR
	 RIDqE+umWq3GjGvNnmSkhgo3oaCUSNALGP4Hby9OPBgO6jAuBmjKp6THnszdi2UWV2L+M
	 IzF9igiEi16aivRsa5RWZJUnJdh17G7J2yKK2J7ktuduZ0rkpYgK1NUAwygnrfoVcHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RjEdMRmJheO3sz5qMAOG+ucqlCZhnhOtW2tbv2bDXjU=;
	b=CMS6FDE0K0+zHz3haUp87pwszpSP1N4F6o2IXXPTA66O6YsRKNtDYTU8PJIx9Km0ddKw
	 X6McsAJKFaGb++9KPWaSWIy5xx5BW5UDS7JMHfbCZmUVQ57BqNv2aJGBVNOZE9w5BMSP3
	 YuxqraYKFvs5VhMrOhTedzMiPhfxnO7pKDRxOV/mB2yN9TbBW3IcinKmYw1RUqY2N21TC
	 /4Jn3HIpv996oxleHq5Ar3kIWMm1+DL2lzQ02V1MyaMol3Fxm04N1KmEo5yAe4wPaXj+o
	 qaBJA0aiqCYFtJZK0KfRR81/DClHw4pAuPsri4Tw4gmOptJ5bAeLYw5xU1FFjPRs3Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LGYYV/V8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA72606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGYYV/V8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0AB1F0089F;
	Sat,  7 Nov 2026 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047986;
	bh=RjEdMRmJheO3sz5qMAOG+ucqlCZhnhOtW2tbv2bDXjU=;
	h=From:To:Cc:Subject:Date;
	b=LGYYV/V8UbInG0lWWbLXPADBbtKjNOGVSSu2PL5g6r4o8HLZglK8UOyVjSZMKEZGs
	 8UDd52H48CLmkJ769DZY+GZTr9TsGfWTzc79idPeDFh3ECT4qyL48c0GB9/qcJJnVV
	 VlfMC0x7wmnnDJunAWklXpWDjVAiDBB5cEKYJ+llXPZ48rrVHS75z2dJE/7kJQLWh5
	 X6ET19wxRv2CaI6ebSUjgOWANxUiIH+1V/cZUZgkrRppszc5dHYaNlZkEE5CQJrgX2
	 FfspiDUSjZVLCS3yCnTGehxUsVcSR6ni83/DsjOfbbe7hRRVQ0p10fpIiQqnxpADAl
	 uSlHAsM3sfxDA==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Call cpu_final_simd() with pure_initcall()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:44 -0500
Message-ID: <20261107053944-failed-6.6-9b56c3659a7e@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9b56c3659a7e5d930ab3c07ea74cc46af65b6d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053944-failed-6.6-9b56c3659a7e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




