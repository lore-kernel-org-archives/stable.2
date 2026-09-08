Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829B32D0E3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883280; cv=none; b=imdQWcQ19fHfFZgMkpKO4DAX9P0Bkfv7os07BL+ZW1KpsngSNOx+Da+oeZ1Gw1eHBLfdRco9mPQonGKv0OvgHjMAAWuJWX1YTOUg1MM50gN0Pe7hYM+5B+nBQKlJq5hLY+cp+MmXCJl83l/v+gDS11EqpJn6zVbVRQM1RAsvRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883280; c=relaxed/simple;
	bh=RpNnVzV6RRDDQmAbgg9M6Lir+a8+2tyCKX42A1o13ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFfJ66xdqV/qOUGm6ehYGh5BkGrMsTfml+3HcKdMM9N/8hbaQgcxp3/XdHlUn+ZS3opmvu1LixM1DFlyn7ewLZ3YnF23bY2jA2d906qRfGiKPHBHhsvYhlYeWlVry0kmzJbqnMeNxHo1+8VNwOr1q+KudzwSEz8W8HjENfy2htI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEhRSpWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEhRSpWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC91F00A3F;
	Tue,  8 Sep 2026 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883278;
	bh=XOHhyYqQjHB6hHtuiZRTzbHPJV1mpOxl22p/Ut6MK0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEhRSpWrvYqRYABsQhKDMbJzcJyU+pz1yhYkCJM/hcvwFNtFj290eXEaSlArv5en0
	 RKqVH+qCQ8rb20Wgl3uP25n+NZHCElbL12sAOdk0J9QVRxbx7vjx+ssomuRS0lExnV
	 iqGJoJbWqRG3W/wGLxv/tifY7mcNx9rwduPg5CoGdqRsJ1EnVv4Cha0awa/IvVVJLu
	 Z/jML1FrK3h/ajBZ71C7xIooly3PPVcZQKMyIR1BsGhikSAR2Yb7M0/Pg2j0iDLZwT
	 PDqzK2dglahFHD+jDhw+oO78qntUx823xp/QHEHB6RDLRCfpjzXdJC7kry62Q6u8d0
	 PrLY1aiM3FB8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] jbd2: check need_resched() when skipping busy checkpoint buffers
Date: Tue,  8 Sep 2026 12:01:14 -0400
Message-ID: <20260908160114.2547081-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160114.2547081-1-sashal@kernel.org>
References: <2026090337-idiocy-unfocused-cf1f@gregkh>
 <20260908160114.2547081-1-sashal@kernel.org>
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

