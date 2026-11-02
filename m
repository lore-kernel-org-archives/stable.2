Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663396;
	b=UD3+EiFKMMUYtd2RFzhFl0p6vurSBaXM6qYW4e4pff1ww9YW6hGQ/sGxY0dQ25Os5YC0
	 /xf7iwQo/4pxpg0QK/qZneT0WbDBXnBkB2+yzLK+kiVb8kywphc5pQlImmJpCN9CZ5e8Y
	 g0eN6W00FaQsOJ2UmT7Yr9hHqqLhAItu0uUhB7la203BwKC4YHXImksAfrpJQKzp1L+Ji
	 2H7e3+7nQmDrlRXMM1mdLkczqOiZMSRqeChu2BC/ThGCTZH8IiWDZneuJ+J5Ak+DeXxYv
	 T3FD0ErD1BMIyOT5HZDYpE6jSZaprAjIhlXKFcMKLkQVeU+PxgwS7IMvOcwKWUTD9GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zS/70lzOc5uq92zhpWECnTO2t8BcmxJuzYjr0GWM7xY=;
	b=r2kcg4Y8CoFeUW67Hx9jkT4/qhNPRM+yT9sN5VOyJfwd3Jdq/s/2/4wI4gsbB5P5Xljv
	 o+G2uFrP9xXqnG5wOWDo7lujhUZY8NC//YXnmXPldGxRZVVSzJTEWIIq/nvFaSnm5IX/D
	 oRGI6WdtKE7LvrWvyaFwCGLOQAlPjoRn5W+UZpFoGBGqD2mXutPGtJ74PEnTNrgw8PFvv
	 vTQfdwyJFoBgYkxFTpGZJIMTM2e3f/T2xxWs/P4Ra5RLboeiUWRYQFDFkGJD0JFdYacsK
	 xA1NsdYcDbnY0yjmysC0QNQjf6U05+zToLIlqIc6W7c0efHuJUW3VpwRzu0JlyqY18Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUKboSEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD17606A336
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUKboSEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EA71F00A16;
	Mon,  2 Nov 2026 23:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663395;
	bh=zS/70lzOc5uq92zhpWECnTO2t8BcmxJuzYjr0GWM7xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUKboSEQNj4liNC/H/7u10HfHn7/0jaInzmxzMHBDgoDATuMopSrLWfYf5tYADLff
	 Xc17ocSH8SWEzKPG9pZBlhbTg661vrLLM8eTOSzHrGrn53RQOB+FwGO2Cd1HhoP4Td
	 e4rdNc3QNBi2ABXHSZsZYaNTa3+wURBgb0V9uiRDU7+zqFjOa8454nXaEUKkmFtkAY
	 Akfaabh7K3AGky/a66GfO42zAkL0FCtyoRLwKH7jJpGd1cnQoWn2icL8ARowLexxKH
	 2Ey/cQ2pN5mLOZquliYGzRAj8QO0bdBHUGNFMUGLwWKkQoxUp27yHKcYgBHM7vDgqn
	 cxNgLNR4Woa3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zikang Gao <2715417602@qq.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: do not pass a NULL buf to is_oplock_break()
Date: Mon,  2 Nov 2026 18:49:53 -0500
Message-ID: <20261102234412.2560495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110214-audience-apostle-d632@gregkh>
References: <2026110214-audience-apostle-d632@gregkh>
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

From: Zikang Gao <2715417602@qq.com>

[ Upstream commit 2225ab306575e424b3dad2ee1be2521c89249d15 ]

receive_encrypted_read() sets *num_mids = 1 and never writes the
caller's bufs[]. Offload returns -1 with *num_mids = 0, so the
demultiplex thread skips the frame. The inline decrypt path
returns 0 even when smb2_find_mid() fails.

cifs_demultiplex_thread() then treats mids[i] == NULL as an
oplock break and calls is_oplock_break(bufs[i], server) with
bufs[i] still NULL. smb2_is_valid_oplock_break() reads
hdr.Command at offset 12 and oopses.

A large encrypted READ whose MessageId does not match is enough
to panic cifsd.

    Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
    KASAN: null-ptr-deref in range
    [0x0000000000000008-0x000000000000000f]
    CPU: 0 PID: 100 Comm: cifsd
    RIP: smb2_is_valid_oplock_break+0xc8/0x2270 [cifs]
    cifs_demultiplex_thread
    Kernel panic - not syncing: Fatal exception

Return -1 when inline decrypt finds no mid, and skip
is_oplock_break() plus the unknown-frame dump when bufs[i]
is NULL. receive_encrypted_standard() already assigns
bufs[*num_mids].

Fixes: c42a6abe3012 ("CIFS: Add capability to decrypt big read responses")
Assisted-by: LLM
Signed-off-by: Zikang Gao <2715417602@qq.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
[ sashal: adjusted context for older MID callback and release APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 4 +++-
 fs/smb/client/smb2ops.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 1c21ae3d61e24..e56a2501465b0 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1335,12 +1335,14 @@ cifs_demultiplex_thread(void *p)
 					mids[i]->callback(mids[i]);
 
 				release_mid(mids[i]);
-			} else if (server->ops->is_oplock_break &&
+			} else if (bufs[i] && server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
 				smb2_add_credits_from_hdr(bufs[i], server);
 				cifs_dbg(FYI, "Received oplock break\n");
 			} else {
+				if (!bufs[i])
+					continue;
 				cifs_server_dbg(VFS, "No task to wake, unknown frame received! NumMids %d\n",
 						atomic_read(&mid_count));
 				cifs_dump_mem("Received Data is: ", bufs[i],
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index f657d9696d1da..12c6c6f1c504b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5027,6 +5027,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		rc = -1;
 	} else {
 		cifs_dbg(FYI, "mid found\n");
 		(*mid)->decrypted = true;
-- 
2.53.0

