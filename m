Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657699;
	b=qZ8mEd3rAks1xURYlMLf05DkooLZPm5vyS66m37Sc/V2rvK3RgxkkdsphSSyPj2lxbPR
	 O7TQ2vXlcK/wtNuJTy5/r/i02F6wWs4CiwhvyniI1h2VI8sK+av63Z9ejLJxpuVv3fk6d
	 UZ/njHjL4aEFMk4jl8XWybGn5Ru2/LcsK41qC2Tbea6ABMlRVkGhumE4nuzo1xmAh5iEC
	 jBHAPA5L7WoVEQ0HtYOuJu6mj0IODOQnhhHJgqT/8OZWDz3pzHT6TNj1b96Q1HiFpG3rX
	 6qz6ik+64WqKkWGXQJPoEwjKVYn+Ob/qYPe0h/1feErx7IJi6t7bYUNlyOG4duicz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ug09H4cDoBD1zxtG7vKcaZPU7V8kruIfW1s/zcIR/lA=;
	b=pNieUJ8pMc+zcar0BO5HLLX67m0lQib1AA80QjCT9phcqE+JJjEIx/3iKjPLT9ISkMXa
	 RlZh+7ia8H2TMHYr3vkTQdRJsO1+z7cNpgm1qjFtJCbZvAqh7/P/xlIOhFEo42SLg5Fw7
	 YuWKDJEmeuFvpNufFLQgjJ/rwSwcTvEQYB5boTfsSjadBmXNqAjABKuzcx+w+lDMwSKDB
	 G/gu0uR99n29pmQQQoGQ2aIlQs/kyvGDUK1yYWPBQzKwatwGNwiIRjXP7qRDQju9T+3fr
	 kq2x08Fha0rUfCwyBPO2QvLY3USxVF7Ako4AEJbRXi5lmnY8ntADBWqJu1tfH294Gjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4tbfCOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F90606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4tbfCOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8821F00A16;
	Mon,  2 Nov 2026 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657699;
	bh=ug09H4cDoBD1zxtG7vKcaZPU7V8kruIfW1s/zcIR/lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4tbfCOLDH6eABrIadcN9+tGltBbmSNn0N8GPxlx7AEq1Cz26cktHk37dS47yYloL
	 VUJWdQfNtU0k/94Ya9GQkY1BmxnUHicJjjJ7jCYH3d9xAIKvA3Ma77oW0TrwsBcAf4
	 0fqbPvZtIWZ12YiR92OTBjJjNClBvekmZG7mXHmTMTo1rYXUtHq3tEaiLpwHn1zA3A
	 ppBkqjPG77bnvQEKR5lKqLh9731vRG1u6hytTc5xuvXlUuXFuvHUcuC0bNeHzRaGp4
	 UtPl7TuHAG9UMSvk4DsoHs9LGD2bzs5/nbhydNAkJdRhLjVuBsYgaluQ1aEoBTdF7d
	 3+d9RD2aTovCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zikang Gao <2715417602@qq.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: do not pass a NULL buf to is_oplock_break()
Date: Mon,  2 Nov 2026 17:14:57 -0500
Message-ID: <20261102221432.1933275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110212-catfish-confined-03b8@gregkh>
References: <2026110212-catfish-confined-03b8@gregkh>
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
[ sashal: Adjusted context to retain the existing one-argument mid_execute_callback() and release_mid() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 4 +++-
 fs/smb/client/smb2ops.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index e908d522920c8..ca71026799e0c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1400,12 +1400,14 @@ cifs_demultiplex_thread(void *p)
 					mid_execute_callback(mids[i]);
 
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
index 5ad3804826d9a..702e32e0e51ad 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5357,6 +5357,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		rc = -1;
 	} else {
 		cifs_dbg(FYI, "mid found\n");
 		(*mid)->decrypted = true;
-- 
2.53.0

