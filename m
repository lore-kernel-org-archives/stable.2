Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714021;
	b=hBQb7B0OzZc7XFq3/GaflZ9NHCe+e1FRcESvHpDWSOMdwcboY8wOOqzLbypIgISpERJg
	 994g/5MBopZ1/mtuoEy2VZLF9OqXGM2nAdXNzs5CygOx+wkKaLc2Cb/T6YyHLueuxiuu5
	 OytDfGJWWVqxOir1iH20JS6W7G5ESiB8X3IkNMTUUtx3bhYzoZFHTO8+rCEgUCLsASOdt
	 +zsidQjqXTwU0j8FpEu/qHh9tPIS1+r2G4jISuOs1nPo6BTolqH+GFFnrlCsY1j299aM0
	 74+bbLJ2GioOdc5qUuxjjwzr68IHXPGXM+HGRoJUJmC2vMkWULptsO/SW36ZqTLNvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9FWLJNkDlXd9NUb4dKDgKB0zpdOqIjFEDR2F+Aj2jQQ=;
	b=iE1yNz4R0gcOyAyhoLw2YcNrGldb8nIqOEZHMFZMJql0DzpzJTvdf/+ghBMzIMCxzxad
	 UOHtzGBMl2TUub6TlfvfvZ7z8eK+X9bsleXHW1OKc6aw8S/hHZgUdprvlmaKXJnGaGFMl
	 J9mfb2BBkqxLcLwgIe2vbG4R+3zG56d3dNptezkkbCe+xNAGY/iEkHnVNV9WEqgvmvwtl
	 0VdKsE4aGcfzw/7g9dSrAeuTLEB8ACRVsHRAfcIQOR2+mZuxL8JYQUknMvpTfmoSnfiV/
	 MNQiyz7pFF7TbvJKnttwS0GqS19Rt49QMdtVU0TfGWpDKMtt7dEPJ1vsT3BZQ9qzCeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqMbdFsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A923606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqMbdFsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367AA1F000C1;
	Tue,  3 Nov 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714020;
	bh=9FWLJNkDlXd9NUb4dKDgKB0zpdOqIjFEDR2F+Aj2jQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqMbdFsVIOlAX8AgQSYzsfk1B4O6zvXV4PdOPgc26/J1EMfUlPLOxTHqGYDmxFMex
	 4rLCjDko30t6zTQjgSvbgEPWBZ0lfc82ILCgxqaWh/VXcT8UljWKauy+qVlKT29/Vf
	 TZybZy+QQaS6ulURDY1g6HWx5pcnWMTvKmZH6YF2QMuRhuyEigBy58ndiNzUksxZG5
	 OuCfAoxFKS0dDDI/YQkKmcQN2VEY92ux9kw6ay7tGtMEEEsqT5XfiJ3DSiHjDnrnQK
	 K7p61ISYD0fbgUvGh1fze9aib3dYUFbMUa8D57Oo56ocrp/Se11BrN2h8/P7TjfFtL
	 ocIC6d8yB3lPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zikang Gao <2715417602@qq.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: do not pass a NULL buf to is_oplock_break()
Date: Tue,  3 Nov 2026 08:53:39 -0500
Message-ID: <20261103135309.3953134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110216-shindig-consonant-aa4f@gregkh>
References: <2026110216-shindig-consonant-aa4f@gregkh>
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
[ sashal: added braces around the previously unbraced mid-not-found branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 4 +++-
 fs/cifs/smb2ops.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index db54cbbe8cc5e..6ff0eab0be81a 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1191,12 +1191,14 @@ cifs_demultiplex_thread(void *p)
 					mids[i]->callback(mids[i]);
 
 				cifs_mid_q_entry_release(mids[i]);
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
 						atomic_read(&midCount));
 				cifs_dump_mem("Received Data is: ", bufs[i],
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 0e95065ae0767..2fe90bcc44b84 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4946,9 +4946,10 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		goto free_pages;
 
 	*mid = smb2_find_mid(server, buf);
-	if (*mid == NULL)
+	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
+		rc = -1;
+	} else {
 		cifs_dbg(FYI, "mid found\n");
 		(*mid)->decrypted = true;
 		rc = handle_read_data(server, *mid, buf,
-- 
2.53.0

