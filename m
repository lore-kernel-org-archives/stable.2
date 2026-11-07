Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049955;
	b=WdjhJaeR650GyoBYzGuvlrdPMY3JBtlMSW6M0AQciZ8H9yRd0rDGOfhanNFfTHxTdi1L
	 kBJ8nbtTLRJywQMzQ735GMcZg5OzLBAy7M2ZicoPFLDVHdYjjt9f9s444WAR8Db2ZTPn7
	 VHmd5gRyrg88MRsrqLKQNVUiihkVO1+UoxUCoO8cEBl/R4gDGLPIIYJRrV7M0y+gc8yE2
	 r+IN1h2vgh2iC89tKxr1MPMd4Yn6/wTgqWr+Dep34PA5TAB1Qwcnc2Iv5soIsCDTBoEEh
	 sI6AI1VHBvhJqLp0+PZNcYsUqkUjErnKfnRqj+fBM2A4e0XIy1E/2ZGy3DP9NZDYTew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049955;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P9wVIAd4NwEYJQvhTVJ28BYmorf3oAZrTe8cI5AXdXE=;
	b=oBDxiYqSYdRstA7OBk2LuqQS7Z5uooIvW9KEhERKetVmuVCbhXTfk31M0sexdwD3WcgN
	 I5nUfyGkJU3yEIIWKR69xfUmqGhP15DAOlQgROaY86XQdZy8Ow2IM/SSv0P2BchhIalmv
	 Ef+N0nOAnVuLuT4W/agX3xUD999ErdJ9fWI9PNv5ShJwiL2lW8GwVT9ONDotrVlX0oWLc
	 OyIs6Y2shLGhfIG4fRT7uVwPfoIWmTXeRh0XpVpKnobLbNePCPTcNkknHE+IhJTcSSunt
	 qNTU2RZCM32nggTR2OeVnNXa9IRN88973vS9GisgsoppMOH+daemYAhyKyqlFL2Zaig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/RRrEbb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9B606D806
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/RRrEbb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D7E1F008A2;
	Sat,  7 Nov 2026 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049954;
	bh=P9wVIAd4NwEYJQvhTVJ28BYmorf3oAZrTe8cI5AXdXE=;
	h=From:To:Cc:Subject:Date;
	b=T/RRrEbbpWyfg+Ax7gkmyiXwgfsEn6ggQkEPFOpHJnANmYVPh4QZiQDtyXfH6GPmT
	 urZjR0dtPaeryHcjAE51gH/jkKZ+Lc63uYCLtGRpGtu7Kt0evIgaemyUdLfivCJmB6
	 qvxWxYH0EIV+Z+BU4f5kjprN0/vi7RYGdz86lMO9fWOSfJ/dmy57H94Bjs+lfdkCVh
	 sO4V5PmT0VfBl19SH1GNMDJx0Qhxk7If8d86ZLBMHRXLCZP1PNgvFl21DoT1UfR4qu
	 7yTjkvbvGkvACrnWknFivVxA6o1PMf30MG2jdZyjeDLGRVBxuUE2tiP6lkoUoR0+SB
	 LtluvsXUm0L5w==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Call cpu_final_simd() with pure_initcall()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:32 -0500
Message-ID: <20261107061232-failed-5.15-9b56c3659a7e@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b56c3659a7e5d930ab3c07ea74cc46af65b6d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061232-failed-5.15-9b56c3659a7e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




