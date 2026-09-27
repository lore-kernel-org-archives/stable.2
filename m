Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A41632E7;
	Sun, 27 Sep 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470710; cv=none; b=bjCkNWUeXkNSjGwAwsGmpK8ErbW1JS5kLrKJwTd0yjHbXR9Q8nKIfszvUBoPHCwsYJ6C9sM4F35X26mTEBoEkF/lPtFUqKHlUYwUKOXGHCEAibUM8Fel8JPzwqA4CT6S3fjcjFyXUrDoM5vtOwe0UhMSx+9xOZAsVqGYefDUMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470710; c=relaxed/simple;
	bh=7BJCB47Gq0g2vNgJwsvIm6n9J1uTRqY4722P6vkiIPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIVnGamq5iZGf2gBm3R2uyQQH2+UknBW2QC7/JXH8pLvMBL3aYhWhahdxT2dBomfJLV5R6K04RsMPOyF7fzLidth+6Vx8EHvh+B3UVtznF/F0rtEIbVPCS8I2Lx5D9YYr1Oq0bMKgnMth1o1q8MhX6eb+IX1JrwKbBSUfnENpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCV5eXmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCV5eXmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F271F000FF;
	Sun, 27 Sep 2026 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470708;
	bh=GV/0J0fsaLYwNY55BdTOmzfH5ds5Rh8DMZH6wqp7dD8=;
	h=From:To:Cc:Subject:Date;
	b=iCV5eXmXJF7WdM2LDvNrrUFZBzeylnI+c9TPwdD3a1SyvClx0lsuy4pzB+RgTe6A+
	 /oG9XsGYAhWAHiUWr3YoB7w2FwqoW8j2GCbH7MXoWRXYv3KT0Z+6SFBx4cq4kTOZK0
	 mGB5KI/09bVT2JjnyoyMce8xbUjeTNwEVdcq4bbbHRck1W8c1F7hobPcHvPdyjEfRw
	 lGBMfd8fFS9uZnUoBON4SeM7qYpiqwfq48W3ZPNJI8Gn11IPLmGbFI4ik2t/GzJUuh
	 lUMfyGT5wU0HPh1gb5iZmznpKkk5Xu75YhW5Kh/GjzFGhho6ZKNrV52MYy95o3ARcL
	 ptSHfDnM0kYmQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH] sparc32: order sun4m and sun4d cross-call flag resets before sending the IPI
Date: Sun, 27 Sep 2026 02:57:26 +0200
Message-ID: <20260927005726.8274-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4m_cross_call() and sun4d_cross_call() clear processors_in[]/
processors_out[] for each target and then raise the cross-call
interrupt. sun4m sends it through sbus_writel(), a volatile C store,
which orders it only against other volatile accesses; sun4d sends it
through cc_set_igen(), an asm volatile with no "memory" clobber.
ccall_info is not volatile, so in both paths the compiler may sink the
two resets below the send; gcc 14 does it for sun4m. A target that
takes the interrupt and runs smp4m_cross_call_irq() or
smp4d_cross_call_irq() before the resets land has its flags cleared
behind it, and the sender spins forever on processors_in[] with
cross_call_lock held.

Add a wmb() before sending the IPI in both cross-call paths.

sun4m has raised the IPI inline since the commit below; before it,
set_cpu_int() was an out-of-line call. sun4d has had the same gap since
2.1.97.

Fixes: 4ba22b16bbf3 ("sparc32: move smp ipi to method ops")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    - gcc 14 moves the resets past the send in sun4m_cross_call() and
      keeps them ahead of it in sun4d_cross_call(); the barrier is missing
      in both.
    - leon_cross_call() needs no change: leon_store_reg() already carries
      a "memory" clobber.

 arch/sparc/kernel/sun4d_smp.c | 6 ++++++
 arch/sparc/kernel/sun4m_smp.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 9a62a5cf3337..11ce613e2682 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -321,6 +321,12 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 				if (cpumask_test_cpu(i, &mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
+					/*
+					 * The target may run the handler as soon
+					 * as the IPI lands, so the resets must be
+					 * visible before it is sent.
+					 */
+					wmb();
 					sun4d_send_ipi(i, IRQ_CROSS_CALL);
 				}
 			}
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 056df034e79e..6ee65c05d089 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -197,6 +197,12 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 				if (cpumask_test_cpu(i, &mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
+					/*
+					 * The target may run the handler as soon
+					 * as the IPI lands, so the resets must be
+					 * visible before it is sent.
+					 */
+					wmb();
 					sun4m_send_ipi(i, IRQ_CROSS_CALL);
 				} else {
 					ccall_info.processors_in[i] = 1;

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3

