Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FD26E71E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758340; cv=none; b=hbfBvDNqw05iQ3dRZTloxkZ0XB5JXVcQ0z7nYDjJgk2Ut8Cmai1UzjbmteWPjAevGcxQVrlyd52UhszXCB+68duI7D9wgdtuBvf9pkWqMZqiQ6YGnyOiA0Js72AdMCdw1lBCOGwRESHrmDz4A6oiC82CK/yxeEjKDseenddejS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758340; c=relaxed/simple;
	bh=bnE+FSzqjNtL1H7wkLOmQEnV0PRbeLockTJl2iVs8IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naOD8ABVfxPh0TdvQusg0nZRjqBmfSfrWrxAmes5nf1NeJkvESIR/E9Q0Qf5P5OTkG7L4u6qy6EZn3s6AJuZSCfWhY1rG/g+zNQ00RWWkXiEXLaqf19eG5n08Ubnlv9J8Ogeq0IqECyX3s28qBRPFrsPJwnuQhvIfNUrG47mfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0F/Ed1/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o/dMjbno; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0F/Ed1/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o/dMjbno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc9hSSoUhAGZ2KNjDSvIAWtYSFJOBn5h7x8TSBvchF0=;
	b=H0F/Ed1/gLdI/9WRORiT8bay9Imbuo4VPsAwdo4VX0CK00EruZ4c5v5KrTC2v+nLjBo3SQ
	Pn5ixS5hJGJLNWmYplKju2pvZKWZC2aSgvmNecpnoPuYzFqEbdSmrYwmmAR8q2DgrBWlEU
	n7FYWmM3qqHE4HtfhWXtc+e/uZDenKw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-bxRLlTIePzWX5Wr259Cpdw-1; Wed, 26 Aug 2026 11:32:13 -0400
X-MC-Unique: bxRLlTIePzWX5Wr259Cpdw-1
X-Mimecast-MFC-AGG-ID: bxRLlTIePzWX5Wr259Cpdw_1787758333
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-845cc1ab48eso35717977b3.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758333; x=1788363133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yc9hSSoUhAGZ2KNjDSvIAWtYSFJOBn5h7x8TSBvchF0=;
        b=o/dMjbnoaBTeVN0LHFAOzF6FspEQXz3wjY5qTs88juwCaecH959BDBf+NRIUCqbOOo
         Ug/6mtl+nUc2B6/EZqWKnKc6wifHOUDqkulPfRjrjp2MQ+vaCw8ztIUL3ImT1fWaq/aV
         Oe0M3Cjommh1oJ3Euf4PDp3KHHM9sDyIJB4SvfeweVBw1+NqcTKk5jZFeX4g0S6Lw17R
         czar7tYjVe1iyoBh2N1zcblyAtmBcxoeP+bnYMqz0gZsHjg1lVRAmNQdbHA42JkjPOna
         TiuXLY1bUQCGmCbHJ+gjo041xn1T1rZOsXRcUJkagKS/gPvkjKlFNOoZN9TEDDpy8xTx
         qgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758333; x=1788363133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yc9hSSoUhAGZ2KNjDSvIAWtYSFJOBn5h7x8TSBvchF0=;
        b=hkoUMpHslg0zWPbG+5/si5sIzvt+ncjhrY7TjxN5rNrGrnwGBV1kVwBN9C5UM4Tts+
         GaH6ctEGSPXlsp7a5lASKYsNxWyB5AceN/C6Ks+iquovOvkvYSAAbXGFWIAuLxLXfWSj
         69p3brXs1YhNP82U1tk4GnB0ReloTNKSJrMZby8U8cTCr4XImISM1fJJ2JpTzEJS4o6G
         sccll5eDL5F+m1RlPxeyjjciJBAcCw9jkPkh1lkhFqTUCue+5KJ7AH0BcKBGMTvM+pR/
         ktOoQW/lM8Gkmcu76NgQKUh5o2Xh1g1nFiVXDWuiUC8rxfkIFTIIF3JGp7VZcP5/00qO
         ojow==
X-Forwarded-Encrypted: i=1; AHgh+RpDs9HJZZ0zcH1vDkzGTEea0TXnTn5mmk6/4abVWQGcSShsRMfKIedu/DhMEHD5FWP3jFZdWls=@vger.kernel.org
X-Gm-Message-State: AFuF++mp0cPr8kuVynpiH+pFtbCf4hbqkyxMKmUyTljL186GtdODUwlM
	+iVAhEA0WapMmimSjJbbjjWq7sFvLAWAG7rGxdAzGTfkoDCiwmULJCrVISmferwyAIN8xDVBScr
	m3H4URXJ8w9oXMth2laMQdvL7uox0MP79jjSaqLouUZ5XhvejSCVcWzzorg==
X-Gm-Gg: AR+sD12hEVgmZsv42CJDmDT7QsOGny7wrm2lEayduvWxAgXS4gxqQFN6JmKrAsiNInb
	z2Tu6O5z43wi2O8i4oOwe8DfYy/Zm4bS1/1wssyoi+ZOcJf5dWcSGtiBxS+KiRYQBjH+QlwN3mx
	s0ndNhxZMAIWE0Ki2/qRL40Hl3/i4YQM1TTSuC1gr0ocZX9n4FHSg0YYLOSnO3XGfxxjDvDAh/h
	d1zANb3hwHCBKS2iL3fTo0MXBrxkuK0nKaiKUYFTuFSOAt1yj9+y6RVebInDmD1eF8gewksVO9U
	rp/aOUEL8nvDPn+WnASTZhIrUfF76HXvYq+FZAZw0ZTqMPChpFGFKvqlKkhk5Gal2exXsi1+DWi
	bmVrlYF2w4JjEqjlmlGaR03JBFRMg0qjOgDuE2jdF5YMaJTyJxhp60to/uw+Y1eOtDg==
X-Received: by 2002:a05:690e:438c:b0:668:43f8:a83a with SMTP id 956f58d0204a3-66d256f88eamr2159813d50.15.1787758332410;
        Wed, 26 Aug 2026 08:32:12 -0700 (PDT)
X-Received: by 2002:a05:690e:438c:b0:668:43f8:a83a with SMTP id 956f58d0204a3-66d256f88eamr2159768d50.15.1787758331480;
        Wed, 26 Aug 2026 08:32:11 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:11 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 01/11] smb: client: fix NextCommand bounds and aliasing UAF in receive_encrypted_standard()
Date: Wed, 26 Aug 2026 10:31:37 -0500
Message-ID: <20260826153147.4112943-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826153147.4112943-1-sorenson@redhat.com>
References: <20260826153147.4112943-1-sorenson@redhat.com>
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

