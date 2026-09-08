Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE6572677
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883603; cv=none; b=sxWXw2p/PeLkqvrCyZXzi9sFYKNftqDjZZggHyrkFL5ouB4iqReUo5lF0tP9LAEYHEJ7NDc09veFT8ULxIFxN6tKHDpX/UW3G5O70wmUFAg7ad9QFrHukPTt2/L3qPu5qT1YLgfjDeBnVodT1Y+1HU+iDwFX4K4pqB9iuyuiu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883603; c=relaxed/simple;
	bh=RpNnVzV6RRDDQmAbgg9M6Lir+a8+2tyCKX42A1o13ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9e3iC+j0xujGUwj6KozdAL/w5zJ9HVXdWyRnHx+2NDjMlgg6gK4if/U4m4CBQlL4wATFLp2UOfWSbJY+8S0gsjL0nIfeHsQWitXYcPUmnjHdmxHi8I8pCN1OqP6q4E17JHilaUgnD4fElDcFg+s9fiF9Up50PCEIki+/SHvn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG6V3sfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG6V3sfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974931F00A3A;
	Tue,  8 Sep 2026 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883601;
	bh=XOHhyYqQjHB6hHtuiZRTzbHPJV1mpOxl22p/Ut6MK0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG6V3sfHK035ZXTYGZwbVUym1C/s1k4gZFtgaO2xQSHsECnS4ZXrJaAgKF5cFjH3b
	 YtdOvitlplcgbqOBvojBUQWUkrfrKiM2LLpOBtFSLtrnXFAKK67Uj6a7RH4oGZ0CGP
	 VV3jmcNN7LjShj03Qdd9b73yhzAs0a7vQovLlqoM9XsYnsPjdt4loB7o3SV8cXwopL
	 69Dltl9maHPLMdnqVvUyjl+PMkeYJUL9wiRq3/lCLa2otAXVniq/ybNAsKqbE3ElW4
	 NL1HCmews83uwdSeu6sD1ue6g7FqwKfqCA+ad2x51sQxRz6IB5u9ZKEzx60JVpmvLa
	 ByhnkglcSQNmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] jbd2: check need_resched() when skipping busy checkpoint buffers
Date: Tue,  8 Sep 2026 12:06:37 -0400
Message-ID: <20260908160637.2569758-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160637.2569758-1-sashal@kernel.org>
References: <2026090337-absolve-bonnet-5b19@gregkh>
 <20260908160637.2569758-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit f213e12ff5c9590b1034ae8da0e6d09665c772d0 ]

journal_shrink_one_cp_list() skips busy checkpoint buffers when called
with JBD2_SHRINK_BUSY_SKIP.  The continue statement on this path also
skips the need_resched() check at the end of the loop body.

Consequently, when a checkpoint list contains mostly busy buffers, the
shrinker can walk the entire list while holding journal->j_list_lock,
even when a reschedule has been requested.  Large checkpoint lists under
memory pressure can therefore cause long lock hold times and leave other
CPUs spinning on j_list_lock, resulting in soft lockups or RCU stalls.

Route the busy-buffer path through the need_resched() check so that the
shrinker can release j_list_lock and reschedule promptly, restoring
parity with the clean-buffer path, which already checks need_resched().
This does not change which checkpoint buffers are eligible for removal.

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260713102229.1598812-2-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 36c64cf44e005..a888357a29964 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -401,7 +401,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 			ret = jbd2_journal_try_remove_checkpoint(jh);
 			if (ret < 0) {
 				if (type == JBD2_SHRINK_BUSY_SKIP)
-					continue;
+					goto next;
 				break;
 			}
 		}
@@ -412,6 +412,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 			break;
 		}
 
+next:
 		if (need_resched())
 			break;
 	} while (jh != last_jh);
-- 
2.53.0

