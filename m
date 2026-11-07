Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048652;
	b=wcvUJWLdFW8wuC9+Eb5jpdzXIc6F5fXd1EFdQlWc9i1FbAm5CD0rh1tgDsLg8qtYnaY1
	 63Er4naA++WFoes9slKaHQu8q2e1C70JZ/rCs/0YBf5WySUL71qU4+z4zgSAdh0uRihzW
	 JlppLhY1wNkHqAkhfoSlAqf+CjKrKgPBKhFQSlmdQnncEXu9kyieFIjGFZ8PFpPGJIch7
	 rAxJDvMQ2aNUCnm8fMzyrDTjSAmStsbX3tpf3OqOus6EBzvTU4LCpL7RqOc46uLCc3tY4
	 S3X2poFu5hHd2WjoSSK68buG/7Q7HvpoIUsMRjhmBtg+ZfXUaajs7Y0epbg9ngKtX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3ZjdM9hZrOiEg2yLzAmxYrV+4aB/5pDbovNc1cYQCps=;
	b=vQcmkCwsEgbRxM8xP6s1rpOxAWxJmhDrE6tJDaZD2W76MRSa2XgA/7xC38jO8pxjL4Qc
	 2t+c06qRFNJKZ4ZAy5NXXBgEqL0uZVUxkRxHM2+FjOe/xl8GerZ9M22bjUoYAFIIx7N8b
	 2mzuFjtAWu3un+r3JSjI38MQOrXZ8arfMMN6QvZtWs9hZRe3cODXqBpNA40wtla/vcN/r
	 MzxYIhcjYA/WFikjCuuVlYO7popazfVDfXhoV6jo4aLq3veLYxhSnu28vnFcUmJN3jMCA
	 EVhsmZsZ5FOekJvY/+axvs7TyDCGHg7qgzauNYLbeDdtX/lB4lis2uA/QH3xF79anWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="acA/YWxC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48669606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acA/YWxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC011F0089F;
	Sat,  7 Nov 2026 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048652;
	bh=3ZjdM9hZrOiEg2yLzAmxYrV+4aB/5pDbovNc1cYQCps=;
	h=From:To:Cc:Subject:Date;
	b=acA/YWxCUUUmJ7SjOjs48ldyZzKTHX72jGlgyCNH2s5hWSukxe8cfHfWbL/DlS3o9
	 lsvI651/9u4xYX4YidX4OYP7S5XExqpOH/5XxeDsxk0wa8j5J8fwU2lI88qwkSC3KP
	 zXOVFfJHl5Asyy+AIeTViS+2xD36KI8BOb853NgclxvbK731jTmOgeTEIkAqQOGmuD
	 4f4oDoPjo8qucAd+j4TFVdyj8nTVzec6nWkrcZGi3lvyrW+bWGUruNwt6SmVAmRixq
	 Ny7uRh74eOIsOooUt1KCetBaNbSZLxlVRGBTZ7au6kOZftJGUOdDhbjbvLDYeoz+UA
	 XtjZyoKu64BRQ==
From: Sasha Levin <sashal@kernel.org>
To: pabeni@redhat.com,
	matttbe@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: fix subflow bitfield misuse" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:50 -0500
Message-ID: <20261107055050-failed-6.1-7538fa33bb2f@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7538fa33bb2f66b8b809ff39d58308be48e197a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055050-failed-6.1-7538fa33bb2f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7538fa33bb2f66b8b809ff39d58308be48e197a0 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 13 Oct 2026 16:29:20 +0200
Subject: [PATCH] mptcp: fix subflow bitfield misuse

The subflow status bitfield is protected by the subflow socket lock,
with one notable exception: the `close_event_done` bit is actually under
the msk socket lock protection.

As reported by Clashiko [1], flipping the latter bit may corrupt other
entries in the same bitfield.

Move the `close_event_done` outside the bitfield, in a 32bit hole.

Link: https://lore.kernel.org/178959153492.22033.1944011998010756543@kernel.org
Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-2-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0384d6a023f9d..c006110b1c56d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,14 +583,16 @@ struct mptcp_subflow_context {
 		closing : 1,	    /* must not pass rx data to msk anymore */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	bool	close_event_done;   /* has done the post-closed part,
+				     * protected by msk socket lock
+				     */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u64	thmac;
-- 
2.53.0




