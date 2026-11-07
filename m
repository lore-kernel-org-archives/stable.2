Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050973;
	b=TJBy1M1CpQjqE1BzwuxuzfT333ZBsQYcNYNrvIsGcNivaMh5xOUHK0b86iGiLTb/4v/n
	 OjPMQk349xdlM6YaE5elEbsDvp1f6pD/wIEZemBAKqh12z7ZJq40zy5PPPfaHP8uaoo0V
	 ekGu0PO9UFdpKa7alTmAbbC57S7Dlo8QZCEKHTPYJWDPwJrxFXATy5Yu8s4flvYdDlmI2
	 uggs9qJ46ZxgTrkM0m3rB+TTuDUKs7SqXgelgxQZLSAjBzy1J5lKAZUD00nUDlKwp/RFx
	 HFv79Jz0E1Aa+lv91uEgDtJyylZ3OwmQlVmz9zK5FeFWbp8iP0KcMxdQwnCF/fp4z+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lIH4FYCZtH5fCQWYYnY0ToH4NTmSSalmbtKyn6GUd3o=;
	b=jpOMuNY1EZ4dXSVvIcx3rIhDj2B53lJkcJowrh3zWOAnZjjeB8TSD9pktXGvFHmpMzu2
	 DOmrD7Pl5xASL0aZtw3hjb7h+CpbKMG9f9R3jI66JOe8cazBN6DHatyEuCfN6hoUdyCCD
	 7vG8Vc26THF8PAmt1rnT34jWAmhF4bHK9WEj+9OoeeoZtrE6u/BJPFSWZsnP9LOCp7ZDC
	 2a3jqn5QkubzY2LKLCHzGgk/GlgX6nf4xwUUo9YEFfF94BV+LCWALajC6mSsjJ0AbfD3y
	 /HwopIPvUNdxkyl1xyW/zPyhPlOzJhpZfY5nEuUD8ywXgi74wClzYPIhM0KsvwQfAJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaHdDVHl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaHdDVHl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011411F0089F;
	Sat,  7 Nov 2026 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050973;
	bh=lIH4FYCZtH5fCQWYYnY0ToH4NTmSSalmbtKyn6GUd3o=;
	h=From:To:Cc:Subject:Date;
	b=QaHdDVHlJeSWC2XyqlekOdekCGF+2DhRcBYG9TSqK9iXglAZ4wdjs/VxN95/Qd7vf
	 NgJfAaPNyWFBqvOK8o4nRtMgUQbTpvkiz0W/4n+JbPM+4cSNrLSqOVWsHIn1Gwd5Ed
	 MdRe7wYRUsBF9dPdvUeyTvXZX6mxP7QBDBtr2QDZz2l6qeuyYR0v032FYpti1g2bTS
	 9Dj7dNVajjXzKxZllLfbGh9ePFNYbwA4OS6q8/reB0TKdWWaCqYF3qDM9CISeoZ+e+
	 8CpnPNwEuvmgkL16RRIa1KBZezwb573xwUV5fHaTPr9O4pvu8FipgmxyaeCV8TeJf7
	 m2M0qrNlwCWOQ==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Call cpu_final_simd() with pure_initcall()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:31 -0500
Message-ID: <20261107062931-failed-5.10-9b56c3659a7e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9b56c3659a7e5d930ab3c07ea74cc46af65b6d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062931-failed-5.10-9b56c3659a7e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




