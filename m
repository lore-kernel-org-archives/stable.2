Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF823BCEE
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758342; cv=none; b=a+fzTCgt8xOAIahalO9wsghW2BWs9ntpi6RD0/xNuKohdoNYJcX9E28QKvkaGHdA794xdms9gq/ANDzSdLh0i/hNnWTJ6YOvtEs4OOS44D1P0Nc0TbSYOo6buct71YkVjdJqAdY7ozQRy6XritN6+5V4Zvww/TDIw0+SaxV/6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758342; c=relaxed/simple;
	bh=cz//MR6BCZ92O7ntoCM5s9znOTvSVl5Y2EGxYEP/01o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RswyhO6PkxQWlLuHkBmyZCFivrVQ9bdd2xap2aaSbNJHqtVfgSFiUfRPh7THOwr+mO2LXxgUtFaK2xrorUntTaIArEUI/3vbSOmQ7otOYc8SZQdoMMszyTqrcLlkNj3aaKCrcxRLLmC9BLRUCki23fDoy95jyxz2mKw2rNLSPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkK5Ncy4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j/4qA5OE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkK5Ncy4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j/4qA5OE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+4uO3I8DglwSkcrqXQh9lvjjvP5CVMo2VnfzN++ifA=;
	b=JkK5Ncy4+gS/qHPGPssJ5/hI03drPEykQKUewx9wIcHA1c3VgdNKjBunHmRtKzKqpEeh3x
	w9/V7LGjdjWlRn8O26eY6bQgxqIdDhx3y/G+SZHuBzmrv54oanwQnwc+SasRJ15ZhHAs7v
	V6HtoESEemgrD8eQwjjyxzsCrvtuatg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-JIX4ClUJMGqTZRFrwYjGew-1; Wed, 26 Aug 2026 11:32:14 -0400
X-MC-Unique: JIX4ClUJMGqTZRFrwYjGew-1
X-Mimecast-MFC-AGG-ID: JIX4ClUJMGqTZRFrwYjGew_1787758334
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66cbfb7ec42so3102587d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758334; x=1788363134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+4uO3I8DglwSkcrqXQh9lvjjvP5CVMo2VnfzN++ifA=;
        b=j/4qA5OE8j2b7/Oz2lQ6tHXP2ZsG/334MTIkx6w34G1jxLQBJI13VJ8zpYpQVxnO59
         mvAKijizmHZV+cGlSBMBuj0wNacnEXHJkwTji/X2S53IBChzmDnnPXONb99WcqnqakWv
         EySlCKrxVdc3O0ovmxkdRoHSIBAGguRAvyFl/uxY8yS1HAgMuu6fI9h87168aZAFyf9e
         cQbI05j9u6s+sNpsTJilOswyBYd/Ccux0bmmHRsHQSWTsN6YENGJRsPvHKPx7P1BLu53
         C8C+BgCcIFuLLRUXDMsETE9R4AuGMpApIHRnCNx5ynKrGFPzOlO7o+cct4Y66KSs/AD+
         ZVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758334; x=1788363134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+4uO3I8DglwSkcrqXQh9lvjjvP5CVMo2VnfzN++ifA=;
        b=S6YNY3n+k2EmTuNEzYpoz5wj/qaspuR1jXimaNz59OmESssjI6BAn17nJXIS22UytD
         nRsaY0G+I8bbjPcOC/1tp8txsI9ufguiyfROPBtqblSNKhfTrjpyu8DiQ3w6zaKd7yiv
         v6prHnEXdyQ6Ls2qzPE3MHn8auuyMc+lal22JYxkJV5ZTi1yEYyp2k30K+WeFW1QvVTO
         f2sHMcAygR9iwmAlnswntuJQL8to6tNBeGCmeIMR6+H6jS6glaNUxtiZxPJdhHK7Mcf6
         gLTHI2WlRbgNV8MPTwOicrFFsoNkdGqk7eQeplBS2xnVxgqp4YZC+nwMvCKyRwRCO/tP
         G2SQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwFKAIWnNKTHy3hUg1c5hTQW1SmesV5n7NYv16NWRhBZNW+OJUxuPPKWnROPCH4C0hOBSoqf8=@vger.kernel.org
X-Gm-Message-State: AFuF++mE0IesZldmR+Bh0ndXiyqUW2iRtASrOMH0Z9VKtdsSapUHwmu8
	tisBHnVUPB4bWlGixhfArkQRQYz8oGR0CFNqZugqIGx9xMGCOPQM7nBrpeqwktG8+0tGBXqun1G
	3utvV6FfcT2ILID4wQpITCVtQHcHOy8eCsIk8J6pNNZI4qhWwIXVts0gYNg==
X-Gm-Gg: AR+sD13kwHvPp4RmNt4HZ8OGcyyyrEqpqZ5jZpKXSYJl7JpI56p5cfRsjIblgeWqxs+
	6Fh7+fJKRlLVsZHzmn9RLybpeqJzumSk/L/rBLPmRA4EdO3s2ZRKroocCGLTK2THc6BimSprN1Q
	En9KL11YkiQdIxaEKJNrfg3HnnCIoU80WEviBfl4QO6SQ6ADqij1au0OeaIpW5vl7ni6LojREk1
	qBLHSDyGqyfspLwnrHhjTGg3O1Kb1EkYu0ynGvdvIdm4YqTYGsyEk4umlQXs+TMqLJ/590/Ju+c
	5OjipBGPJBFm7aV1y7urXFgoSaBe8gBXtXUhTMoQVVwt3+UI+imdvnCj9FMxZ3Iqh7Hlawv1gmn
	r0rTeVKeGja25//t6AxdX8wz6Xtfywnig+gTu9j+ijakyzU9yrdHh3WYaabjlC6+VBQ==
X-Received: by 2002:a05:690e:c45:b0:66d:236b:dc75 with SMTP id 956f58d0204a3-66d2584942emr3038323d50.48.1787758334117;
        Wed, 26 Aug 2026 08:32:14 -0700 (PDT)
X-Received: by 2002:a05:690e:c45:b0:66d:236b:dc75 with SMTP id 956f58d0204a3-66d2584942emr3038294d50.48.1787758333663;
        Wed, 26 Aug 2026 08:32:13 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:13 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 03/11] smb: client: fix server->total_read not tracking sub-PDU size in receive_encrypted_standard()
Date: Wed, 26 Aug 2026 10:31:39 -0500
Message-ID: <20260826153147.4112943-4-sorenson@redhat.com>
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

receive_encrypted_standard() processes compound encrypted frames by
iterating sub-PDUs, decrementing pdu_length by NextCommand on each
hop but leaving server->total_read at the original full-frame size.
cifs_handle_standard() passes server->total_read as len to
smb2_check_message(), so every length guard in smb2_check_message()
(smb2_rsp_struct_sizes[], smb2_min_pdu_len[]) operates on the
full-frame size rather than the current sub-PDU.

A malicious server can craft a compound encrypted frame where any
non-last sub-PDU is shorter than the fixed response struct it
declares.  The oversized len bypasses both guards, smb2_get_data_area_len()
reads struct fields at offsets past the received data, and the
data-area length arithmetic produces a spurious pointer into
uninitialized slab content or the next sub-PDU, which a rogue server
controls.

At the top of each iteration, pdu_length is the full remaining
compound tail (current sub-PDU + all subsequent ones), not the current
sub-PDU alone.  For a non-last sub-PDU, server->total_read must be
derived from next_cmd, not pdu_length.  Read next_cmd before assigning
server->total_read, then use `next_cmd ? next_cmd : pdu_length` so
that smb2_check_message() sees the actual per-sub-PDU extent on every
pass through the loop.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index e75420dbe950..1bc3f8266eda 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5248,6 +5248,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+	server->total_read = next_cmd ? next_cmd : pdu_length;
 
 	if (*num_mids >= MAX_COMPOUND) {
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-- 
2.55.0

