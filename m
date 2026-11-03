Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672541;
	b=N82aFyh4RI1PGrTnhyimbXw40hPTy7MpMeyve0S5QrR5ql3DGzulMDhAJfN59Pz4Q7HG
	 lOr4Jmgg7AuLJJFuVl6t2ZhPMVzyzZE/AjQnXSWjZx7WcD4kPU6uf7tSo7jTIx7w4j9ZK
	 aiey6d3w/U7X6mgZKUbQZW5UPFlWN6i9AKf3rbfBhvWSO5+87hehiz8T97fk79j6nOmWQ
	 aDcA0kmQNSGoDQ/8NiDKaAaKHE/YjN9zHlKmDk+wMnKoozhYbpyToQ23opYcoltQSMuJ1
	 g/3C5uZIfhb2oueOLJpevJKmAQdKRv83xk2Pph3DI+n6X4i7hlPw7Bcs570j0zxWfqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b2YL294FU9QpZFiKRZDyCeHsQ5/dyMnUVgRpiRhxEPM=;
	b=dd33Q3KERqqnM3HmT+uahDiG4/4+h4q60SNZgFlqJ9zwEgwR2u9zWcf1bxBdcIAvRN48
	 hdjPbwoDX7uIS6lTngUlOKhxCqH30U2ihVcgL6zP0uHhUlb0p7V62mOoxW296rkz277IX
	 SoE6jIOs2EK/eYoLDgZqtUo/pw0IYutVFPFCuD5vRZLccEUUSR/QwrbjZvZMTtSMzBNuz
	 ZA5CIeDObfDV8Y2yvTmw8jSMQrr63B0vtUL+/66yCPtT8+DV+FkUhCKVssNa2h3ParYzP
	 dH8w7ximl90g2Vu/Ipt7JDJvwN9IVxCgn4KVOUtXW7TmzNv4nTN/pA1EjRmNscRWS1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOL3M1mb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EC606A337
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOL3M1mb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D811F00A1D;
	Tue,  3 Nov 2026 02:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672540;
	bh=b2YL294FU9QpZFiKRZDyCeHsQ5/dyMnUVgRpiRhxEPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOL3M1mbDUYM6eDIWSSOmK1rMZIM/KPqwKORy+xE/TYskTMU6k2g80QSHVn771wG+
	 ZiTL77egILfJ/G4Cg2XJvknuX0/Ie78xqqFBKB2Wz0OcGbnB6WiFMZ+HDKi8FjI9Bl
	 1KRkroevxvAhDXEFstG7n6735ur1KoFjS/gzXSedDVhi7dx/LjM6mUICPd/3Mzpzzr
	 +7N8hKohsUTZ/Rq7KvWkyp0DP3RIP1PfggKUetvlclrbyTSnL1aIsbz8UQuGg7EZv4
	 fLy++cu7tRfge5zTbY1GKF06fs//PUHa1fBvq3p2lUr62htoVNnHqqFWkLRfrd8R7o
	 a9Tw0fTP0pSIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zikang Gao <2715417602@qq.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: do not pass a NULL buf to is_oplock_break()
Date: Mon,  2 Nov 2026 21:22:19 -0500
Message-ID: <20261103020041.2819615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110215-underpay-cassette-20d6@gregkh>
References: <2026110215-underpay-cassette-20d6@gregkh>
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
[ sashal: added braces around the existing NULL-MID branch to include the new assignment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 4 +++-
 fs/smb/client/smb2ops.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 157d947846d9b..f765246fa57c7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1324,12 +1324,14 @@ cifs_demultiplex_thread(void *p)
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
index a7b884e8c3412..ab7ed90d6fb2b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5219,9 +5219,10 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
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

