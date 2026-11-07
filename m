Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047223;
	b=PnxdIDAp1nlqR3x/IoD+i+C7pf7cCL/thtmYgW9zKs/ogR3bIm5rRvQieSQvttAOOf5A
	 tpWyErIr93ZDaqdSfi3Bqw1fbussNeTWCj6jaNS5qb9prXPIkt1XxGxpdTwbtEyaaPODp
	 +iSX8h0GOpnT884+qj2GcjSBjEhlTtRPm86D4nUedqrW427GRnl+M0oc8UkDD3ytBwh4w
	 27wgbCzl00/bXLv75WzTcUAB+U5oEpheUT+lYNbLLqFNalDWpHToQ/QoMlA0PiC66yqG3
	 pqf4TCTk4ntY2bjjWsByw9rNndjMobNfmBXGmoq49BKzPrz7Dj+7kXg06qEOrSVsw1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hiijY7RdmoSUNOoPADyYwAV79kRuGGZLeV7/JPihqrs=;
	b=5EIhx6vFF1Qqlg5QAOhk3hwASUJofJaeXB86nPxgxlxtVt8LOe0nGKJjrS7Awv4///Fk
	 UtZT9MzMxOxhKHMCtbwIN++O/kWbeK9Uvsg3hY7jpREbcDqucYqVs4q7k8hjS6q21iA74
	 Ob0sSFTojocLBqtVMEXYWLhjPWV+nEeOT+U0zqrj0I9XxEeePyAbEQG7FTV/pHZqzL4E6
	 fcRxTgWxX9s3E7BqwemEQ+roEMRMhzmKhIPEaSENE7w9/NcOX3ngidQ/PZmGjNiq+Tu6D
	 1yNgaMUbe1uOvNK2Cpp5ZWHKIb+8NHPTLdQITtCRkkvA898RktnN0RunX+ZzJ7nt88A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WamGwqfu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A87606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WamGwqfu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B11F0089F;
	Sat,  7 Nov 2026 10:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047223;
	bh=hiijY7RdmoSUNOoPADyYwAV79kRuGGZLeV7/JPihqrs=;
	h=From:To:Cc:Subject:Date;
	b=WamGwqfu582FHS45xmLePLoGlpsEmqbdTf4sFxTxKO44RfYvDX8Ri9vZVf1hM7tXL
	 O2gVB7dnbBeocpo4rLzC2g+eTWFMrtC3NtdbeA41QKrTGt++BhVBuGJo+o7UGHZNnI
	 iWXBxcsYImkIoM5e4b3J6nyEJQbnQ4S1qy+s8GsjopluQQAcHu59dcL/9x+CVlkbHG
	 EZV4peJrEDrCcNKToFC1vZGN1s/1tmX9yIxHUBDNRtkUHGcEIRbvQmcwL05ZL08E4z
	 GcSlOXbhX11545noFaOt8LFL+wpnDWh4JdKLAnf3pC+qOq3hT80AxFfSHVdTOrFa5m
	 qxaVJWufN3xAg==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Call cpu_final_simd() with pure_initcall()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:01 -0500
Message-ID: <20261107052701-failed-6.12-9b56c3659a7e@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9b56c3659a7e5d930ab3c07ea74cc46af65b6d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052701-failed-6.12-9b56c3659a7e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




