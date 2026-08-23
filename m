Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978E388866
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511517; cv=none; b=jvYgildBqtlSFBnuZ+KqEPQ0UtFgJy4a4KZu1joc2yU9l0LahsIB+wxqh7YFot32HDP5jdAaiqiiYWot2rPWhk216scyJqerDNq/QTAe6cPoN0GdeVvZ/fsQ71vns0m6CQnGDlD25krz/uTLDAu1mkwtbilvGtEJr9VQctTvPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511517; c=relaxed/simple;
	bh=bnE+FSzqjNtL1H7wkLOmQEnV0PRbeLockTJl2iVs8IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVLT+Xsev74dXmUoglb1rbLxChllANp6jpVSOuxjO5ROQtqpNBsl0d5gmKnKL+KW3ptJ1EDy0z48IZxT7R4Mj8VJjBHuPres/nWtRQLiPJmhZ7k0spHf4AheKd4EUhe9fuFc118PxIm+hJRhv859iwjLiG/8HP/gO6CdHmA8NOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4ymDQIf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tTcXJz+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4ymDQIf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tTcXJz+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787511514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc9hSSoUhAGZ2KNjDSvIAWtYSFJOBn5h7x8TSBvchF0=;
	b=Q4ymDQIfcS6WkcEQR+1r/0EzcJbUCQNO3H3v2tPc7KfOQBnBxtrS2d61weF9Ec7TXBljPU
	qLqhLg4qXzz+GCQ3p21CodSdZuosJaIc2B4Z/1Vlg4A3v0V2cunRZEFxwBVKSxsHU5YhFZ
	8BHsm5ef1W+/EwuZ76LwQpDm/Dvwz3k=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-VYOnEHD8O7eTmvKyCribaQ-1; Sun, 23 Aug 2026 14:58:33 -0400
X-MC-Unique: VYOnEHD8O7eTmvKyCribaQ-1
X-Mimecast-MFC-AGG-ID: VYOnEHD8O7eTmvKyCribaQ_1787511512
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4488f192768so4460316fac.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787511512; x=1788116312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yc9hSSoUhAGZ2KNjDSvIAWtYSFJOBn5h7x8TSBvchF0=;
        b=tTcXJz+CmrH7urCca1w/ipxIk6bAsvHOPVhE/HXQOpEseO8djBwxPkEpdci6MOtq6F
         og6mHpTg5IzqQZuWSMon467PBYK8NpCvSrWAOkSkUbbaiMwxKsUgkvNhSZjyiGJuLhE5
         095EupQ4puph+qcaQ7oWkdCT5yqHzIDFJU3jYR4Rjqlki9bNbUdGCfhNgcLOfOqgyLmP
         kcf0HFJ+UDRU4ijKvs16dQGFxctqQN/wCe9bAtJxEyP50O1cIjOeO+98xdZOhLuAFCJx
         QK5wfUeNBE61IKtTTw2H6dYsu/Ex7ok5M9dEa/+YgSeJI5xHwCT0YgDczH4COrD1sSXw
         Ol2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511512; x=1788116312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yc9hSSoUhAGZ2KNjDSvIAWtYSFJOBn5h7x8TSBvchF0=;
        b=brRnRZ5ziVoKorvQidnOxF7CHUE3Wdm9vtdIhx1qdGrmbuq/7Q4AQ0QxJwzbbMYAe3
         TLNNcX5PCMgQHXgQ0GqfUAxYOq92wkfEdoakJKinJU+QJhg3AYta9NyCXwRBDrwd1Fs8
         9Zzft5UsKrHqwoxnABuQfUUyy9SfOUObai3uYeq848KiUwhWDJN1SZq6ybDZA0zKX9fK
         3PWOntCPadWGqtz6osB5HsSEF5djQs/lCIHTzo1H/dqG1sImnoQdmaQ0FqRP/5qphntJ
         iZYk94O8kaR8JVTj8NNJZcFjABhMmD6bhs3RtVouqAgZ3W78Jp13EhAzOjZBUnu8uLn8
         MKZg==
X-Forwarded-Encrypted: i=1; AHgh+Rrs/pK6uf7RMwvAWEqvmUKfgOXLfclHH7+Fu5ULmCpcOfzZsCGCAZY/LQInjKjnBpSYcaX8dIk=@vger.kernel.org
X-Gm-Message-State: AFuF++n1l2ZBAeHGt33XpkruU4/t0cTfpNZ3L6mp4ClyqsfpiaYaiS+R
	lB5CtduvIIkMW3F3PeugpmMrhs5EPYRbhOMWKlXy+wtPaORYqIpOUSLFyv8DjkBalCQ3xfcWv2E
	zXmayKc5Zr5g8g4wF8E1xVakQyY/qHIUxpicw0UIcKoYDDkBH1MqW4fECfd6t57ctVA==
X-Gm-Gg: AR+sD112f7ipCZjZvCEX762hJ4IgvfonpYPrx0AWSDXqA+Ss42bi4acGyh5eJUBuc4N
	1zTqEVuBeFLwpgJ5R/RhM05j45EPeZl3RrFqYgGQ7WBRI8EMBqgvaxiHf+rL4zbfMSnmx021LCE
	2n0jyCbMVDidRWRLxSOCVx5ma8x3+1smwqFdynZ45DXhDhsez4a2Nce15MLU4nLTbGdOp1ZrCfI
	hLZByRi5w4CHOibXLXqBwHRqyrKjAbGjfMYA4XRP3Bk49BAr4is2XSTUXCxN3+FCsyHLqXa0ISx
	POWtENRbV2N1bIhYz/ZbZ0yZazwg4pxEUvJgJBvaFFw/C7SRwoR248HLCbr3gcWIaKb9oT2GMYA
	JCtritkKKcptaXjtxfp7FW/l8iWjjp0emK8VK8QaeefIqH4Yzlh+fsYjBiK/ljLrAgg==
X-Received: by 2002:a05:6820:1c93:b0:6b1:4e37:41d1 with SMTP id 006d021491bc7-6b1593ad7c5mr21842062eaf.21.1787511512159;
        Sun, 23 Aug 2026 11:58:32 -0700 (PDT)
X-Received: by 2002:a05:6820:1c93:b0:6b1:4e37:41d1 with SMTP id 006d021491bc7-6b1593ad7c5mr21842028eaf.21.1787511511718;
        Sun, 23 Aug 2026 11:58:31 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fb1db63sm2518710a34.12.2026.08.23.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:58:30 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/11] smb: client: fix NextCommand bounds and aliasing UAF in receive_encrypted_standard()
Date: Sun, 23 Aug 2026 13:57:57 -0500
Message-ID: <20260823185807.3115901-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823185807.3115901-1-sorenson@redhat.com>
References: <20260823185807.3115901-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four related bugs in receive_encrypted_standard():

Lower bound: next_cmd is not checked against MID_HEADER_SIZE(server).  A
non-zero NextCommand smaller than the SMB2 header size passes the
upper-bound check; memcpy pulls bytes from within the current PDU header
into next_buffer, and the next iteration casts that region as a fresh
smb2_hdr.

Upper bound / trailing slice: the original check uses strict greater-than
(`next_cmd > pdu_length`), so next_cmd == pdu_length passes; memcpy copies
zero bytes, smb2_check_message() rejects the zeroed buffer, ret != 0, and
free_rsp_buf() releases next_buffer (aliasing server->bigbuf) while
allocate_buffers() still holds it: write-after-free.  Even with strict
less-than enforced, a next_cmd satisfying next_cmd < pdu_length but
pdu_length - next_cmd < MID_HEADER_SIZE(server) leaves a trailing slice too
small to hold an SMB2 header.  The next iteration reads shdr->NextCommand
from uninitialized slab content; if it reads as 0, the else-if (ret != 0)
branch frees next_buffer, again aliasing server->bigbuf: another
write-after-free.  Replace with three unsigned comparisons that avoid
addition: `next_cmd > pdu_length` to guard against underflow, then
`pdu_length - next_cmd < MID_HEADER_SIZE(server)` for the trailing slice
minimum.  The addition form (`(size_t)next_cmd +
MID_HEADER_SIZE(server) > pdu_length`) wraps to zero on 32-bit
kernels for next_cmd near UINT_MAX, silently admitting out-of-bounds.

Aliasing after goto: once server->bigbuf = buf = next_buffer and the goto
fires, next_buffer still holds the live server->bigbuf pointer.  If
smb2_check_message() fails on that iteration, ret != 0 and the else-if path
frees next_buffer, freeing server->bigbuf while it remains referenced.
Set next_buffer = NULL before goto one_more to prevent the aliased pointer
from being freed as a standalone buffer.

Decrypted extent: decrypt_raw_data() moves plaintext to buf[0..buf_size-1]
via memmove, where buf_size = pdu_length -
sizeof(struct smb2_transform_hdr).  Using pdu_length as the upper bound
allows next_cmd values in (buf_size, pdu_length], letting buf + next_cmd
land in the stale 52-byte transform-header residue and memcpy to copy
stale ciphertext into next_buffer as if it were the next SMB2 frame.
Assign pdu_length = buf_size after successful decryption so bounds checks
and the per-iteration decrement operate on the correct plaintext extent.

smb2_next_header() already enforces the equivalent lower-bound:

    if (unlikely(*noff && *noff < MID_HEADER_SIZE(server)))
        return -EINVAL;

Apply the same constraint here.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7d6738ffcb80..e75420dbe950 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5242,6 +5242,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	length = decrypt_raw_data(server, buf, buf_size, NULL, false);
 	if (length)
 		return length;
+	pdu_length = buf_size;
 
 	next_is_large = server->large_buf;
 one_more:
@@ -5254,8 +5255,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (next_cmd) {
-		if (WARN_ON_ONCE(next_cmd > pdu_length))
+		if (next_cmd < MID_HEADER_SIZE(server) ||
+		    next_cmd > pdu_length ||
+		    pdu_length - next_cmd < MID_HEADER_SIZE(server)) {
+			unsigned int max_next = pdu_length > (unsigned int)MID_HEADER_SIZE(server) ?
+					pdu_length - (unsigned int)MID_HEADER_SIZE(server) : 0;
+			cifs_server_dbg(VFS, "invalid NextCommand offset %u out of range [%zu, %u]\n",
+					next_cmd, MID_HEADER_SIZE(server), max_next);
 			return -1;
+		}
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
@@ -5291,6 +5299,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
+		next_buffer = NULL;
 		goto one_more;
 	} else if (ret != 0) {
 		/*
-- 
2.55.0

