Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047782;
	b=MRmi1eKpT4s5xPGddcaYkI0ekL3cR7Fq7ytyMeQrGPcXmrG98N4HyyxMdH0H6u+1dxmg
	 /tWMY+xR3raWNnsYMgot7VpP+vgpfPCpj5pIbJS0gkiC+q8rGTPbmLJQydveUkko8Mwg5
	 atuUtCN0oNz/h1jbNpPrPY9m9clw48CTZ6aI2SZAyq6HKAkP57CeDd3M9jbaMWALB8Mil
	 PkJqAkR83hv0t35Nom0RxdVn8zNc0OKLj3raZWyGfmc+YBNTRaTipbG9ubtiwYeKIn4ja
	 ARDXLBSWeJA+BRHBotnRnOu002XlMcLDqyhMnEwHKccfblIQDZxl6KWpR37tKlKxRzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QR6r/kGT9EsJ6iPXKh/tM+rWeKJOKiJtB1Vm792O0Ms=;
	b=hOT8xShBKaCBUvKgIqZ3wajXt3QfVo8UPLmBFbf5rPPiK5ASNfxS6S4w4vN+cLJ8VSW2
	 c67P5VAU3t50+RmbsBTaonKAx/IvVaKFbzElxx0fpaweTeVqmHZH1neJC2Ys70VePUCr2
	 RRAi2NnNER79TDe11O2bzGzUVUOTS4u7qBHQ8g/x8Vwv1UxWm//lolumnNBzePnysR5cQ
	 pIBhCB4/HNA362zVvtAhmfjieU08bOVfwudxhTC8+zNx5QMcM2gXc4Up22P00qUvqHK21
	 RK8ZNe0RaOejTCIbl+4F+lrUNPiblGBxsRDLk8vNJsqN63yd8Ib5YuJbEOutO3guYIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5yMhe1E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41882606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5yMhe1E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D6C1F0089F;
	Sat,  7 Nov 2026 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047782;
	bh=QR6r/kGT9EsJ6iPXKh/tM+rWeKJOKiJtB1Vm792O0Ms=;
	h=From:To:Cc:Subject:Date;
	b=C5yMhe1Ez8lV0VVzu23R3qQ978vKQj6KAYCHT53IuPwmT46VOQR6a+sHmrBt9E0gp
	 O3t/c4Xe7dab5MWS9k9WBleR4jKDxBR6/g6CW8g//tDB9YupBW7Dl6QO+3NPsasjq9
	 xmgpkDJ8tBV8060DY3gHb2rvGkgC+HrBz+S5WTGJzOrXxjl/Pu8CniIeEzxq+7nmAL
	 oZto9hCELbMZJmFlVI3pZjIAJUDqTvSv/HLZ2zoiPCxIA95eIddtCOuY52vrqKI4wI
	 HU28WT7URb09UHMlzCQd64ooXjVnLsWWTAfk2T8ITRIHwArVJkSSl0d5r6OOjJaAgb
	 SJnSgdzyL9Epg==
From: Sasha Levin <sashal@kernel.org>
To: pabeni@redhat.com,
	matttbe@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: fix subflow bitfield misuse" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:20 -0500
Message-ID: <20261107053620-failed-6.6-7538fa33bb2f@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7538fa33bb2f66b8b809ff39d58308be48e197a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053620-failed-6.6-7538fa33bb2f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




