Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046909;
	b=daE4IXXj/aV9BXprVLepY9nb0lOUbuShxD+lpFjUFRMeh34yPoBwtSRJLaeuTwdBN+ie
	 u29ybyMXEWlBTvPps13EctfxkxiUhXvRxswmLY4Td5g4HGtoNzDVPoGS/biyg5N9IP5QZ
	 paPQhQZYJHbN3OynsiLQpr7fYHyms6J5spU8pqpx8Tyea7angQ5Bx2FbzHnYMXrzEtO8j
	 /Bg3nn9akQSKAGMiqC90TaAMQy9CTqwz1J+4Uy1IFgtU7//22SSJaci1IBzOVgz6zJedQ
	 T6RNj8gw4noxgSIsWG5t6ZArAwHelDJW3ZDcL6K+EeJOnPq+BnfvCMZc6xzUSZVXNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UBxHgvkgJJ+EWBZapawlFeBsA4lzzOyT6HgvJMnk4pE=;
	b=PkQCaThO1+34VHFZh/fEZLWyf057MaPdxOT5hPvh5MqoEtFm08QuXor1CTUA8KWTjfSp
	 mMycxLPuaJuWjevdUTHI0XEuhL0+fMjdDxz7MkGN4Vk+GY0hxMEXmCPq3Jd8WSr4qw9SC
	 6nSlTu3dFZUlQLhqkbjatgC/oruq5amSd4c3HB86McXRbaZljmApCk5KgIW7z4M1hhX91
	 +gMi7j44eL3dRmoOH7XOL7289yZW984UbdQsQ3iZd0ToyI5EJ1oJITlOBPrhTZtYpYHPC
	 NwovE1XpgNH1iCjcn6M5/AXGjV7SeOuY0H8aZL6xC/9Xt8A1xKikFJS/AozwZkCw79Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ornA2zsS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731D606D81B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ornA2zsS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6191F008A2;
	Sat,  7 Nov 2026 10:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046909;
	bh=UBxHgvkgJJ+EWBZapawlFeBsA4lzzOyT6HgvJMnk4pE=;
	h=From:To:Cc:Subject:Date;
	b=ornA2zsS1uo6Y1OHiU4bAZy9ARKVOnqrCM/e9421GpEdIxj81xaWlyWV3gD524MII
	 /yKnUIudJYd1dIf6L2UKJoCD/4xCCwoMf6/fJtGp1wjDwGeOq6A8/cOsInO1FJF2E4
	 IH1XNJT0YNw1gW0TpnB/LEwoRQ12F6/oSskytys2amjQ1WGrRQuF3itNu5Bc5lUB4j
	 ySPL1AKgIjLz678SSfZkR3dbnZw+8dU9c/05691VSRJILICRc7xi+AVkWrqnAZecRC
	 dDJ7GfEYDv5nepKDkPfCZ4p9QGsvHQj38JHS/AZmHnoKgOopRjaZemwu4CNvpeoxxQ
	 2x1AJAIYxX6dg==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	daniel@gibson.sh,
	acelan.kao@canonical.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd: Stop counting intermediate cycles with metrics table" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:47 -0500
Message-ID: <20261107052147-failed-6.12-0c2c928ea7d3@kernel.org>
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
git cherry-pick -x 0c2c928ea7d33c8131b0785bda4e26a32dce5caa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052147-failed-6.12-0c2c928ea7d3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0c2c928ea7d33c8131b0785bda4e26a32dce5caa Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 14 Sep 2026 09:17:32 -0500
Subject: [PATCH] platform/x86/amd: Stop counting intermediate cycles with
 metrics table
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The metrics table doesn't increment for all cases that can cause an
intermediate wakeup if the cycle is very fast.  This can make the intent
from commit 9f5595d5f03fd ("platform/x86/amd: pmc: Require at least 2.5
seconds between HW sleep cycles") not work properly.

That commit originally was measured to work properly, but it was
accidental due to a logic error.  The logic error was fixed in
commit 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at
start of cycle") but this now masked the table doesn't always update.

Since that code was introduced, Daniel Gibson added a number of changes
to the logic which includes a state variable introduced in
commit 037f0b03c663a ("platform/x86/amd/pmc: Don't log during
intermediate wakeups").

Utilize that state variable to instead decide if a single sequence has
started.

Cc: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org # 7.1.y: 037f0b03c663a platform/x86/amd/pmc: Don't log during intermediate wakeups
Cc: stable@vger.kernel.org # 6.18.y: 037f0b03c663a platform/x86/amd/pmc: Don't log during intermediate wakeups
Fixes: 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at start of cycle")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Link: https://patch.msgid.link/20260914141734.2703545-1-mario.limonciello@amd.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 6792aa2c61874..e384b56d67559 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -701,19 +701,6 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	return rc;
 }
 
-static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
-{
-	/*
-	 * Starting a new HW sleep cycle right after waking from one
-	 * can cause electrical problems triggering the over voltage protection.
-	 * That is avoided by delaying the next suspend a bit, see also
-	 * https://lore.kernel.org/all/20250414162446.3853194-1-superm1@kernel.org/
-	 */
-	struct smu_metrics table;
-
-	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
-}
-
 static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 {
 	/*
@@ -804,7 +791,7 @@ static void amd_pmc_s2idle_check(void)
 	struct amd_pmc_dev *pdev = &pmc;
 	int rc;
 
-	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
+	if (!pdev->is_first_check_after_suspend ||
 	    amd_pmc_want_suspend_delay(pdev))
 		msleep(2500);
 
-- 
2.53.0




