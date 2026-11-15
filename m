Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777503;
	b=bv65qTfhwSb7dPQwLrw+Yst1yhlFWcOahGOhbZFj7j/PK6K0LCu51qFLtW2DY9Ce3ytd
	 +hzRVV/aDxFz48U/C3QWj0c2rK2qn1kMKWKW2WzqwUGQS2uCiOvtC/1NIGqTqSm9OaOE+
	 lfLOmkdo5Ut11E8isvR/D09MdEzMN/dhmPt4gR6+RR/uAu6EpvemdKByl0urgsBfreLcn
	 kLBsV2jmS84wJN+/FXrDt7EqfmEME3QK8z7ZAYXY6FnajiEjlXnDZNRuZL7c56vwmbkRy
	 vkCta3YRjleyDob4E90OnK3O0DbcUIaYiVF3MMvQJyGg0bSf466jvtY0kbiw99zcp+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777503;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4NmVekp5AF3TQlvKfhhoRjPEWciyBwoXsOkkxZlyMuo=;
	b=Zixe/hV+EdkILhAyiU9JZZvMDw+8FqFJMj2FOe3sBiZkYf/b8WsWRTIGXo688RSjaplm
	 KQ3Gm9816PHj4S9LZ6poZoUjz8FaV57ppsyLt8LW8sbZwoFu2wDIqvrBeTjf2fo8lAjNF
	 Fcvclc7a7LtBG0pDh2F0RdUIsJPgaG7yrRRP7cdXxWirXPmFAMWagai51CBCYv6hz1wPy
	 4hERNxVSpg5PBFYpv90fkzLivFx3hNv6cgaJn509wCoQd0tqAJHUzpl8N9D9CwUdCC0CS
	 PC5690OjinszKbMEFFQ+C9ew4ZsWgM+ckFQ1guy3t5k7Ouoil4WV1iGXymXBvRrJTpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EwsrI/yS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7AF606A32C;
	Sun, 15 Nov 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwsrI/yS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02E61F000C4;
	Sun, 15 Nov 2026 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794777503;
	bh=4NmVekp5AF3TQlvKfhhoRjPEWciyBwoXsOkkxZlyMuo=;
	h=From:Date:Subject:To:Cc;
	b=EwsrI/ySyvB20G0OXm5ps0iHqCR5WTS32bYIMIkp6kAmcrqApUPqMEqq+cvOy00uX
	 ho4vyv2AUSFdsaQKdjVayMoQTcfrB2xGxXN0Vp4peDzCY5TJYQI/eBXKlFblLqQmt0
	 KckZyexpMFRvAR69YKm3wSJvWv1t2w6N3uZv6OppxZOw4UpobFwa2tv7WeOXTgLIyA
	 Cxo02L3wPE8NOgJ/ynLbsnCI+iNFz9fa/IC8fnU2wrGrux6Foj5P1tJ/d4POnE7C/k
	 7uhcJ9BKJJZA9zrKIor1VA+oNivY260M9LERoMcVdvJGdzk1Ad/pat33zeEoN7bUvg
	 pmMteI/xmOSxg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 15 Nov 2026 14:18:07 -0700
Subject: [PATCH] powerpc/xmon: Avoid unsequenced accesses to tsk in
 show_task()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBBG4auUWRvoRBrBq4iLmP7VEZxqptFC6
 d0bdfkt3lvIkAVGx2ahjLeYjFrBu4bSLeoVTvpq8q0PzNy5+TGq+xQ1vAo0oXfs24iYhkPYB6r
 dM2OQ+fc8nf+2crkjTd8RresGh06aTXUAAAA=
X-Change-ID: 20261115-xmon-wunsequenced-120aeacf7636
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438; i=nathan@kernel.org;
 h=from:subject:message-id; bh=n3wmVZOyMNsX0uk3IiniOVaUBJnF2oOZEtO24z2uNpg=;
 b=kA0DAAoWHWsmkXHAGpYByyZiAGr6IZihRZbffcT0Cn4l0kQ9p2gOZzFH1xiWaOwkQ4z9Dio1B
 Ih1BAAWCgAdFiEEe+MlxzExnM0B2MqSHWsmkXHAGpYFAmr6IZgACgkQHWsmkXHAGpZYQAEA+JcF
 h7PyeMAe3s4nhbTb5HJ8VLD36RDIdTWqIVyIciABAI7Ee9Nul+Wz3OwRJenTiDaR5Ht50X9ChFl
 /YY2LYwQI
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in show_task(), which can
break the build with CONFIG_PPC_WERROR=y / CONFIG_WERROR=y / W=e:

  arch/powerpc/xmon/xmon.c:3262:3: error: unsequenced accesses to volatile qualified 'tsk' [-Werror,-Wunsequenced]
   3261 |         printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
        |                                                         ~~~
   3262 |                 tsk->thread.ksp, tsk->thread.regs,
        |                 ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

tsk was made volatile in commit a2305e3de819 ("powerpc: mark local
variables around longjmp as volatile") to ensure its value in
show_tasks() was properly restored after returning from a potential
longjmp(). Aside from that, the value is not being modified through
other means, so rename the volatile parameter and add a local variable
named tsk to hold its value throughout show_task(), clearing up the
warning.

Cc: stable@vger.kernel.org
Fixes: a2305e3de819 ("powerpc: mark local variables around longjmp as volatile")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2199
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cb3a3244ae6f..90a8d7a8f42d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3240,8 +3240,9 @@ memzcan(void)
 		printf("%.8lx\n", a - mskip);
 }
 
-static void show_task(struct task_struct *volatile tsk)
+static void show_task(struct task_struct *volatile vol_tsk)
 {
+	struct task_struct *tsk = vol_tsk;
 	unsigned int p_state = READ_ONCE(tsk->__state);
 	char state;
 

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261115-xmon-wunsequenced-120aeacf7636

Best regards,
--  
Cheers,
Nathan

