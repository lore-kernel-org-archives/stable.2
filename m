Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622333;
	b=Gk+NWEZXCP+KIyaj5zXq9ETmu24dx20bOXIhOtxReyQvxxzidtVL3fq0d3rUEZNEhzke
	 e4NyowLHUxv7R3IFTjLk68GZFPVAaKcVaJkLbmdsuARd5FFjJek+lR8WHQZljz9c1GRk3
	 wuzM5IuieuXUkAuc2feK+e3hGKePe4emXXbRosjFjtraNYOaiMKdCMr8nxA/g1ElIkZbg
	 WY5/30OE+2UwJtXH4utHmWwm7tz0IE0ZcaZ2Q7x796nCeBRRelKWC4PCptqf1QpPKvC9m
	 VwTa804xHKzOkxOQI2zsbf/d59hpfBp87dGKFhA9tIOTls9KWuLc72FY6gibBcMcVug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cfzs1v8i6CBkf5MXbCeFohvsxIop0AgVO+m3xXw2wes=;
	b=p3+4QmuNS/ocqF7fXQ1BOZcjTpd+qN4vgPs1RAguzX3cVtdzo7j/Gi28h42248FjGIE8
	 qIBkH/UJU41xqXAD+Tcvp+M4jiupWBQRhz0OUJE2iEaXNZgBi1gHDpRwRhahiNP/aUtKE
	 6chNBtIVhon9hJQ9OYXyiwetgS7U0FGAwGMEY9l30PlpwFMc/WzpDxFhy1+FHOBfSo5Is
	 XTNnQQdJvLTmWoSHSXkq3NtoYPKRcw4uOjiuuh3PMgzxFm862uF1wkANwY3GP7/3QBJYO
	 SBOpCRfnt8ak9rg/VuiWPXu4Scqq3pedYsoXzHej2vONMZ96IU1iq8q4ZNb/6dffAYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIS6EG4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B43606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIS6EG4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9822E1F000D0;
	Wed, 25 Nov 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622333;
	bh=cfzs1v8i6CBkf5MXbCeFohvsxIop0AgVO+m3xXw2wes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIS6EG4yCxF18WvRYP/XZjuRQf5G6QKZHSI03vkaqveXuYjwvnQWK4l489y9FMHDR
	 SNBoiPcDpu0vFdDGioQFV9zmhNpYHyWDwGw8aYhmfPr0KmEAq6F9tmi8QRHEJVX9iH
	 tVAPZguEEnHHNQyT0RtML4fZdZJEeipscR8AaMIB02IEHdisZmeEN9Mu24L/JqfJfY
	 ES5pojtKALrJX33/or6jev2D3EQ68iUizy6+Nb4mcdT75ZZGIMBfoykUEEKqc8ortW
	 b64nxDMkZtjDRpIVW2WRxdinOPqnAoY07KxOFzS4Nz4h7TU0TLdZegdMJ05kGua0XM
	 DuzEFWGPG0sfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSv4: Prevent indefinite waits for out-of-order OPEN stateids
Date: Wed, 25 Nov 2026 10:58:51 -0500
Message-ID: <20261125155833.635502-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112553-underarm-mama-755d@gregkh>
References: <2026112553-underarm-mama-755d@gregkh>
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
[ sashal: Replaced the nfs_current_task_exiting() check, which this tree lacks, with a plain fatal_signal_pending() check, and adjusted the surrounding context lines to match. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1b5c236437b38..a45eb47d68a87 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1683,6 +1683,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 {
 	DEFINE_WAIT(wait);
 	int status = 0;
+	unsigned long deadline = jiffies + 5 * HZ;
+	signed long remaining;
 	for (;;) {
 
 		if (nfs_stateid_is_sequential(state, stateid))
@@ -1716,7 +1718,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
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

