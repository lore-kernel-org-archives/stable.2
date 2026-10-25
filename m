Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946780;
	b=oM+Brs+RHpNK7ahDxMiTye00AlLsAV+fw+IbOyO/8LGZqcjoXZDvoavgGe7depVUP0KS
	 ruKx0T/zh2L/zX/q2M/KLEFupcKcBhLEGhQwDHTlQtuz7r8y2hjAZMvJoyCuyj/VHkZ4F
	 D8fR0uyQAtoVigxkhqMY4kOw7PfiENo10btpDpNI/7fanR2Vf91qLDCCq/fKvDy7kRqdP
	 mxrvdvocaBNBjjqBthzCn/899OwmSNVoenhB5R54QCcCu1CSbd028GYsR/3Eksw8Smlb1
	 m6Lixhp/SjQtq66GrmCNPCv8brIBWhXJYMAd13T3FSCfdc57mjWeYu39TsHqZFCKWag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xG6MrCXFC7R3FF1J0tGLDByvgSJFyVyerh9PIkr8DcQ=;
	b=iSXpSu7TSLNEQzQ2n0hD4LAVPvhruds5z3yUsu/XM8JenmU2RCHneW51J8XpEHRp4NoG
	 pu11BvFiuEDqRqkEoLL9G3DKDg2tnUnHR2zuhLxl01/qKQGAkmBdVNs89uhoR2hy6XEV3
	 ZbBFNe1Oibs7ACOyo52VCNP/vnBtLiYssrpovZOyGJnLLtFlStexEoxkFXtVyImpw1SBn
	 TARHwJcjXCW/WXUngFFEaMM6kMcXHzF8H+U7jvLn/Su9OAbPejT+vhEYDxPKmjL9Z7xdU
	 qCi4mA4z4ooXCfo0S/Kyy8Z00t2MMR1y+8cCgF0cGsCanWb/2Rzt9gRASliSnNLA6kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pDcw8uF4;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023B606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 16:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A023B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pDcw8uF4
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2027099a91.2
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946779; x=1793551579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xG6MrCXFC7R3FF1J0tGLDByvgSJFyVyerh9PIkr8DcQ=;
        b=pDcw8uF4GXPFER2LwaLozrGEMlbRBWKIeeQRXypzbGoXiU2il/EY4Jp8WMYpcRy9n7
         X59rvLqfsIFCCLPxBMo85Scvjnr4hiaVWdq58uNUMRTmui43HzAWTmynNFKl5yPFr1D9
         B7SRvcrdvY2dNLPOj+6zaWnbC68Jp7AoXyFvT9Qv+SB90I9jshGp+MneCKKlpmAwKOw5
         vrh9okELyJboqZNLJ1t1REfejeqzpO+w0XFFfyahdcz7G32t5nqmNQkdedyabXxezkaF
         HlLr+OPZecTXT4yZZSF80dfp2QzQbGu0lSKviqAEjmnTMOw+o/fsxZe/raIIPwalBIt6
         1PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946779; x=1793551579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xG6MrCXFC7R3FF1J0tGLDByvgSJFyVyerh9PIkr8DcQ=;
        b=rFNudFCr/zkeMgyxxxjxb8nCXFDf133pO55YUFsY2YCQL7pyKjG6/9dyMubxJoHTxQ
         jk7UBDlnKPQwM0+ml2j7n5VGum388+7uw6w/xePVByV6P9QEXfBIxS7JFmU0FTbfvvJL
         gggj+rRUbrbJ3Ogd2nNJPqEuH64w8LQEYcXYc0mbzoPCrMVdHe319RqbSEgmuIxZy9ZY
         MQWWNL4gzfX4p4+BTG9n2sCDduFsHf1tep1Si0VgpZtHTx86nTC0sPfC40uxk930Iz/2
         NgZ82vAcoGWX9zz2U+8OaB5/o2G3JghhRK+MnyCyZeDuGcQfKbTm3PkvEgCmv2SK9U6R
         7kAw==
X-Forwarded-Encrypted: i=1; AKwUvBxdZsVGKtW+ygGdx9f2LXJ4yXYr1NCbkqQpKd1C1QAJ322/Gb8VMOlkbvbTURdIPvXtnBoBboM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs+PN6Pq1gZAnuk42zy3F+e0CiqO6Gl5uvU2z5DAY1KDHxJ7Ls
	ixtG0w67hM96bCmSx3XebYmqVICh+QEWdZbNvolR2R3SD04OxorHFZ8u
X-Gm-Gg: AYBFou0WYn/ITKNMM7D2rZbpOkzvMUgKUa1wZFGvu1f++AtCK1a3vRdaHXxvabc2ACN
	O0uIHev7Hzzk4BjppjFQO6/PTvKOkwfP/zNDxzNWd/7OUK+30PMUQJvo0ov0BZQTUy4UxVVvK/O
	SwFVIVEZ7em/5mYdT3DBP42mD1mluRyP56cAHBcNQdWUFOSX5RzNT4r/A0hWYmFAnsaHqVBEqb+
	bY8IWANyQAJYH9bmrbzlJ7fBMUqIHzgxKBQQ9Vcb5mHsfNmz1F3+InqC/jA3kFvuCLlFM72qfJS
	U3+/KGLJINsnVq4UUcn1Cs2gAQCQmemUDYfUrpfSn9RCbGMJ95g+/NkYIMkYVp4MCktLP9ZFqBx
	HGlC+5jq3zwFkIqK92yEpnLtdkXkzGlTSXNFabY6QmENZl8s8u9vVvtdZVznLqp6CgqLx4FRfsT
	8UD8zVNN6282uNnU6jnguYuDiBuc5K/HH8Jdrh10U9qnNJ8VaRwR1UQSWP3AhR784tTvkIjUxT1
	JJIPpsXe2sCRkEGD3H2KLX8ULG8TGvs9opgI5DY5Aq7+VH9oP0Ex3l2vTcfVuIZvagT9CwoF3Dm
	tixvIyAfXUsEnClr1nD35jXNsYJK
X-Received: by 2002:a17:90b:1c0b:b0:3aa:6b5d:a018 with SMTP id 98e67ed59e1d1-3adeb104d43mr3872406a91.67.1792946778932;
        Sun, 25 Oct 2026 09:46:18 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm5285671a91.4.2026.10.25.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:46:17 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Shilovsky <pshilov@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	co+3a967895833044fc@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: handle unmatched encrypted read responses
Date: Sun, 25 Oct 2026 09:45:59 -0700
Message-ID: <20261025164559.439328-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

receive_encrypted_read() advertises one MID before decrypting a large
response, but it does not populate the corresponding bufs entry.  When the
response MessageId is not pending, smb2_find_mid() returns NULL.  The demux
thread then passes the empty buffer slot to is_oplock_break(), causing a
NULL pointer dereference.

Initialize the output count to zero.  For an unmatched response, account
the credit grant from the decrypted header and leave it unadvertised.
Publish one entry only after finding a MID.  This avoids sending a partial
linear response through generic unsolicited-message handling.

Cc: stable@vger.kernel.org
Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Reported-by: <co+3a967895833044fc@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 fs/smb/client/cifsproto.h | 2 ++
 fs/smb/client/connect.c   | 2 +-
 fs/smb/client/smb2ops.c   | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 00168839c..fb181e727 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -88,6 +88,8 @@ void cifs_wake_up_task(struct TCP_Server_Info *server,
 		       struct mid_q_entry *mid);
 int cifs_handle_standard(struct TCP_Server_Info *server,
 			 struct mid_q_entry *mid);
+void smb2_add_credits_from_hdr(char *buffer,
+			       struct TCP_Server_Info *server);
 char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx, char dirsep);
 int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
 int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index b6e98eb31..d47f166e2 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1221,7 +1221,7 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	return 0;
 }
 
-static void
+void
 smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 {
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buffer;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index cb4fd09f9..6f75e6620 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5236,7 +5236,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	INIT_WORK(&dw->decrypt, smb2_decrypt_offload);
 	dw->server = server;
 
-	*num_mids = 1;
+	*num_mids = 0;
 	len = min_t(unsigned int, buflen, server->vals->read_rsp_size +
 		sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
 
@@ -5306,8 +5306,10 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		smb2_add_credits_from_hdr(buf, server);
 	} else {
 		cifs_dbg(FYI, "mid found\n");
+		*num_mids = 1;
 		(*mid)->decrypted = true;
 		rc = handle_read_data(server, *mid, buf,
 				      server->vals->read_rsp_size,
-- 
2.56.0

