Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621954;
	b=TI6hn+wXd0sfrAv0y+qXBX+1GMUP2eN2Uo7jijzDStiS84aLq9iFbBxHb2cBkJe6bs/n
	 wr70YnJbSxeiyoNZKWOQSoEhRolY/SFrJvzjHxwwkfFilJ23jfwx2E289PwUn5x5ShW4v
	 zadvSgxB6x8FbQftB7MV9VLMXM8QiBjZzyx+zDBsjIjLSOIfczvEYDiNCba7LtkTicI97
	 7Og/iXRPrKH6fSO3aeE0meqaI+Zi6Alinzl5MGMzEJ/23tMFRIEI5QI8NvsHKGdGGAirF
	 If26SElLTsRFrJI5rNqsbvtqgs9SIpp7IrB6yK1sxW5WqNVrTg0cBKL7BDM8zeadadg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621954;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qf+xoc8dXL4YXhCtAx8mfpZvw/SJHhVMGYMJCjCcTFc=;
	b=tmGx+BsrN4utznV4qssqpeNOVxNUnicaL1J4hqKsMJ297v30gbfrSCI6g18GLlaFUf9j
	 nGLZlA01AcKSRTwUVIbVXRIBS2C+V/EhvyjDsff8XFFWRRyQyjXFHAsC94AIyC9X40QBJ
	 uKfMImRnN4XvGc8Q8D+J9CWF1c662m2qyH3F6m7MffQ8DYjtEkDvLdGKDQ9EK/i5S1Es4
	 TNt2YFmbOro8JO7jjO+OGKDSPJhh+xTeTHe4xWIwo+cQ08tubfAF7/Ox7gRQZT+RpUV6C
	 z1iYmsu19pMB2gH3MxyeXqXLqAZGNy3uSWlH9WzFH6c8i5BHoWe7MsjSvxrE2PFWSTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idSW7IUE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF96606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idSW7IUE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99C41F000D1;
	Wed, 25 Nov 2026 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621954;
	bh=qf+xoc8dXL4YXhCtAx8mfpZvw/SJHhVMGYMJCjCcTFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idSW7IUEU9/NJDPyH0OgUKKC4Fqukt2uPF7T0XEnIaingxK8AZ16NYMzVs3gQAIF1
	 zSHPrDInGaXklwXGdSv9zfxzb3+549KHo9inaf4nPllrW4K/j/ypEuGnm1zFjeepI/
	 OTv3aLnh+LMGb4by3UpblSS4B2Y1QonBUwiFuFux0YtH4AIXUym1R2JZyZur9HgVIk
	 4vnVLNcJVEFogMYhGW75cHyzpucmeamOPj+3iIKd419ev4Q2p2dNtSoN8sdDu3uqsQ
	 dzb822DMPOax+5VFTbCfL/zyiFPS/sGlND5nP7TRGBnoIdmlQiz+c0Txc54q7OHMln
	 +r1xzHCpbQm9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSv4: Prevent indefinite waits for out-of-order OPEN stateids
Date: Wed, 25 Nov 2026 10:52:32 -0500
Message-ID: <20261125155217.604733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112553-vanish-hangup-421f@gregkh>
References: <2026112553-vanish-hangup-421f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Menninger <tmenninger@everpuredata.com>

[ Upstream commit 151d95a1e696979a7d54b23c96338754be2fcc1f ]

When processing an out-of-order OPEN stateid on an NFSv4.1 or later
mount, nfs_set_open_stateid_locked() waits for stateid updates to be
processed in order. A five-second timeout is intended to prevent
indefinite waits when preceding updates never arrive.

However, each iteration calls schedule_timeout() with a fresh
five-second timeout. An update to the shared open state can wake the
caller without satisfying its ordering check. The remaining timeout
is then discarded, and the next iteration starts another full wait.

Under sustained concurrent OPEN/CLOSE activity on the same open state,
repeated wakeups can prevent the timeout from ever expiring. Some
tasks can remain stuck in update_open_stateid() while others continue
making progress.

Compute a single deadline on entry and pass only the remaining time
to schedule_timeout(). Once the deadline expires, take the existing
timeout path rather than starting another wait. This prevents
wakeups from extending the wait indefinitely.

Observed on Linux 6.8.0 and reproduced on 7.3.0 with 96 concurrent
O_RDWR|O_TRUNC open/close loops on one NFSv4.1/TCP file (nconnect=16).
Ten workers made no progress for over 300 seconds while others ran.
With the fix, all workers resumed after transient stalls.

Fixes: c9399f21c215 ("NFSv4: Fix OPEN / CLOSE race")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
[ sashal: Dropped the && !nfs_current_task_exiting() term from the if (!fatal_signal_pending(current)) context line, since this tree lacks that helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 53e454a3194b8..0a4f8862e785d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1704,6 +1704,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 {
 	DEFINE_WAIT(wait);
 	int status = 0;
+	unsigned long deadline = jiffies + 5 * HZ;
+	signed long remaining;
 	for (;;) {
 
 		if (nfs_stateid_is_sequential(state, stateid))
@@ -1737,7 +1739,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
 		if (!fatal_signal_pending(current)) {
-			if (schedule_timeout(5*HZ) == 0)
+			remaining = (long)(deadline - jiffies);
+			if (remaining <= 0 || schedule_timeout(remaining) == 0)
 				status = -EAGAIN;
 			else
 				status = 0;
-- 
2.53.0

