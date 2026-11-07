Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047018;
	b=A5c4hxDZX2ohFKIwQUa/FWTSkKU554+wVQK/aZLprYL1mgupxZdtuXPq7iFW9R6wJEIa
	 +6hEtizgrS9rTOaTUkd62y+Wdj8PFhND4DBzQedDLhXrmNLNoX6VMmksKX9FlNegugjD+
	 jYkyOQwhmNXSD3l23O1QkMg++Q2Em80gFRP8HZphvjkizDg+qJXm20ef9usEn2c127XLH
	 QPlxncKajLYr0tfdt/6ZpBvHrAfTZKauNRiIk2MvmqPaxrzrPMz+Fb5cHOmiOD324nk3s
	 M4INDFlLznmm9jumG24C8XSnAR8j6Ys9DBd5Bk/zYc3IBkV5aXG690sETtd0/gx0xwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wLkbaWW/pP6GNpBTUAvSTywvjVIwpxlDAT9eiqbeCPU=;
	b=2U1oimJWfZSL2LbwmqQMdhtYnZ3KFuoMVEEwHF7x70SVqV0Zn+Nq7LQjQixWtNKVFDWk
	 /nO/EKxBAKdUEdk+j9GZYl/dic0h1RHdrLNHw1qncTHJNwysxEcgAeG27F9fTq31z18JI
	 zKjg4UmpErF4y3lzSdoVdeIH1idEKYGH5jPBXFjmKGkWxmrsdAQfz312c21CSeCwEeFPL
	 D5RvbTERFkhzkb3Bc/1TWqqL82LJa9jDHSWUvXwpNGJ6jUp5e4B+8A0/E/1wL9dRF7BXc
	 G6L1RYscoqNTp718DE2CeGy7iLpouLZqhfN/a38+yR4yax1dIHTk5SmoA/1PvFVKVoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsSbutBK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F2606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsSbutBK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9661F0089F;
	Sat,  7 Nov 2026 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047018;
	bh=wLkbaWW/pP6GNpBTUAvSTywvjVIwpxlDAT9eiqbeCPU=;
	h=From:To:Cc:Subject:Date;
	b=YsSbutBKmaEhF0KDp/SMT4+OE7w/PxriMfrDgMGjE/VBP36fAyeENVKtKBnT0DSv1
	 AdaZWCI6G/sXNIJd9imdxa84U4UpQ3uBnQezpd3KuGhSRaeovsTkI9oYZUXyDYrfVX
	 z8fKmFB0P0KZDroR2Cscoz2uK2diSL1VmyGk44n96WY0S+H0VKZ+LeN37vGsyLqg6W
	 vVLim6hFkp6FkNIXSdJljq4ptsLLx5J1aWT/WtEMe6TrsudKGvUFjm6CLU1ZeEE2sw
	 8KlRzq7pg9xEg297DcYGKmbe8AIzkT55p1IOejvCfRxpKAPVrtEnUJv3IA+YjvrFbS
	 9xPHDXniUarAg==
From: Sasha Levin <sashal@kernel.org>
To: pabeni@redhat.com,
	matttbe@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: fix subflow bitfield misuse" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:36 -0500
Message-ID: <20261107052336-failed-6.12-7538fa33bb2f@kernel.org>
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
git cherry-pick -x 7538fa33bb2f66b8b809ff39d58308be48e197a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052336-failed-6.12-7538fa33bb2f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




