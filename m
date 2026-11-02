Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660471;
	b=Zn4HQwxkpvQmn+5RCInf2ayE3h7aK9ZK6ofN4X6xmtWG3FReqkF8rl+zMDBGU8PBgDIb
	 p0+7a+F3vK6urVv15qdoNuICcBjJsWWmyJBZpwuqh/uo3qiBRVa1lHpkgojZgZSanfuf9
	 dWpMeQwpuTF7mtqqkGfMdE+aJYozwQ7vcYk5Dsn+1iGjbyKPIq/tQZFqhC2GLlLGlniJ5
	 D0GkkLhdSGPi7UxmPEji0HMO85JVyNBZ0uVrD9fXS9Rr+M5HO37v6oL6BAa9ZuymtMQTv
	 8Ot1Nhqo78Q1WYZ6KK/X8EV0QuIs864PMEA5i0YX8JdE/KRdHHlxPSSseWjel0bWFVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4XyVrUOUPxuyIFugFQA5l5xPOPJxXgUApBtTuONL0L8=;
	b=oI+J5xsx30grKM2jYvdAa71vefCmpD8TGrTYLKpzFk6m7o1LgA8VMhhqJKxXZrj1u1CA
	 08cWG4dHqS+k7o7RFsQ29eDOAzOCjufZCDIatTCMvJQ96/ShJc6S8kthy+MfaUYEpQyVL
	 4VEN9Ag3Gyj4yJreWe1OBX0WxViV/AWWSP+LYqpXqHu8rJp5hRTG6Uwp1/AFPiFwOke2+
	 Jupuc/YcQ76Ggnod3twJnqECnwaIvquMwCy8OGRJZ53vpqgvLmj2EmNUDxsfZIbxU5lZy
	 sWqH891pRV2wCNoHnzzwwpRMfGW7yzpikAQB4feVPi6G8jG1MtlYLKcxzHOMuJMMHiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIaeeUdC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A644606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIaeeUdC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158431F00A16;
	Mon,  2 Nov 2026 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660470;
	bh=4XyVrUOUPxuyIFugFQA5l5xPOPJxXgUApBtTuONL0L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIaeeUdChVI+rKPHxPLrl7x3ODeiNNBqdscQtvT0yZbJdDyFzigOK3moDIFornxOB
	 ns697HOhppkxCZrj9hNLi/C+9cd/wwtRU36cXG5kYKdR49c4+oTABc7nNWdhLtpSry
	 PIGk3QqcH5b9IKZC3EJgOOYqh+nKYMYcKebav4pMlumPtwYNTarirnHkkXhXAwcM/a
	 gzIDTELj78WD2Egx8cMQOYRrbt+nF5+n05tJG2W5H/onTbEcp5lncBAsjtkQOfiB+4
	 lH0CayXATCw7yssDPVTnq9wKBPagPbd0F6RJi+z3Pi3nqvLx4p45RfnbpaqoROeZNI
	 z6Od/VHwwvagw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zikang Gao <2715417602@qq.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: do not pass a NULL buf to is_oplock_break()
Date: Mon,  2 Nov 2026 18:01:08 -0500
Message-ID: <20261102223801.2122711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110213-sliver-doctrine-6a23@gregkh>
References: <2026110213-sliver-doctrine-6a23@gregkh>
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
[ sashal: adjusted context for direct MID callbacks and release_mid() without a server argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 4 +++-
 fs/smb/client/smb2ops.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 81961a54c9f1c..eace4d1a3dce7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1318,12 +1318,14 @@ cifs_demultiplex_thread(void *p)
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
index 8012c9687bc88..f749a25d68c82 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5266,6 +5266,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		rc = -1;
 	} else {
 		cifs_dbg(FYI, "mid found\n");
 		(*mid)->decrypted = true;
-- 
2.53.0

