Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DB47B435
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580437; cv=none; b=ni96B8DvXzw/65/5yiQmcTWjqsU8syghO6GDTtXrwD5Ny2R5nZCnAfn8xc70MCSma/0qLmD7BphKbWhpiYcDrv1kpNgyMdPx07M0rygaRsRVG5iTpZe+2Tec/zGvq4KFVbuuX0NOq0Iwaoe4rqXFm8pKKNpeTDTmfQlNh6K/LSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580437; c=relaxed/simple;
	bh=q3/CITPsbHycvhvfXWpLkzbmqitx0cxdIPykix5yts8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKPkRt597eY6I7TAUg+j8nniIC921nsjs6FFiyp/+wvqZO159bvaejM3SKvFlyv1Kmi+IQJM5S3HcJMoNJiljsi6xncH42VK/71TYOmW++mPigU33X/gHpv9breDTHZ0jK0yd30AmFIQGZGGxbTzUFX5jwJ5NnktQDzhs/XcOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip/bvAmW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip/bvAmW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so5440465ad.2
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580435; x=1781185235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0tWOa9UJQqyAGS8HaLwmzolHNh+pFxRRNFPs4YNFwk=;
        b=ip/bvAmW7eI8o5AuK9mZWoEVhnvODuv4Lc/PE+KkxwjpcGQnHAyXfE9lqbCDHmHDhx
         un2Fs8gJ869erUYvQCKzzxsTUnr/SNxhCl0czr9vvJkG2r3w/1vvkCZDchf+JU0o1oa2
         hmoc1dm5hGwxTBPPQvVNsV87lT5E2RVQusPDzNq+PZ+n/qyROR1/mgtz65NntYYawk+X
         JRN7GSvh1RwWZ48JAg2VrP9ZEPFXznLx2BX8dn681wLAEpPBpoIx6oK2E1JRZFI6t6yR
         MWzMYbce6rAy6LG4Vrl9l5O7rEY/4lrRS1H24e954OWIn2XIYhwQqcRHjW8HAIbBxBBY
         TcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580435; x=1781185235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0tWOa9UJQqyAGS8HaLwmzolHNh+pFxRRNFPs4YNFwk=;
        b=cQWmVPNrE3M+P4VNKCvM5UPob4imcvbEv0vD2NCSSBrHza2pu7qlDy58gERG+9Zdoo
         I0PFJFWcnJectMuRrrAbMLm+D5Kzp7dZi8wmcPa0OaCNfe2b+CkT4p4BY65+iZaste6x
         hKc1OWR9oJtD1MsKMJztAiWY8Qf8n7Vd6VCu0MGYBp7Ieuoe+AKaivTemwSBPFGYf59K
         kVvKfIotzhosr86FqBO3NIQbiBOs8L42Jogm5vudGhklE4WypYm8LJlcRmVmZvKXG6Hk
         8anr/iNFZPzYQnqXo08dA5eX4owIOrSnq37JtLMff8chobY5+zldnFh3QS2dBK2hG0HA
         7loA==
X-Forwarded-Encrypted: i=1; AFNElJ85IWNVG3CK45592G3RScLQvYMDOyow1UUtRHsKkOGDSBpGS4QGJrylVzSNXaVVBdhQtqAQOLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMW59z+dSjeCKRmvdEFfI8k03fE8pCsuvlDROu3W6RTRyoSvS8
	AnKTj2To3S0hDJOqph6GDjVrCrKw77cYiamVtr8t/uTjWh23St9wVt/w
X-Gm-Gg: Acq92OHoPxo+X1nWQNaTCEKczpfy1hfLtCGuunJ1J/h6iKDfUkUo7jc7GYqH08r3rOP
	KJ2A/dlGvnGNLdnLHaE3Lse2tqO1FXkcYtta0F6s3gb0Em84n2EuISfL3oWGgUHbASAJ82tTWHU
	NLZ0VAJdghhc0/cHafOSB7B4oiopyzuELXaCidfE3uAlvUBFpOh1JBluPbsh04AMTdPtB9mtN/P
	F/mDO7UHqOYBjMyFWWFBt4y85U/KqSeeRGBHDIB34WeuLY8ALpLdffD2oHpN53OFtbKi3eKHElL
	Q+H0S3XB4cq8TNkt6yjfCu5xTXQI6cRJ/Ykv5wFg6SNEtQQxo8SlqCSpFNczHb0oML53FPJ7F2D
	4eU1uAI69Idku6M8vhfEIitkELIsUFPxzKJrkEQWj8UrgnpaQMnoneZk7k+b4pn2C17GT3zPNiL
	+WJnA9hZJLtVXRQtP8PLbp7+sgUJIgN3dFQzDAZ+MpLq3bJqAGMP1lfwIN26TQHA==
X-Received: by 2002:a17:902:e786:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c163a54bf6mr97328975ad.10.1780580435021;
        Thu, 04 Jun 2026 06:40:35 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm64870065ad.5.2026.06.04.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:40:34 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: security@kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: keenanat2000@gmail.com,
	yimingqian591@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/tls: preserve sk_msg sg.copy when splitting records
Date: Thu,  4 Jun 2026 13:40:11 +0000
Message-ID: <20260604134019.39161-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_split_open_record() copies scatterlist entries from the current
plaintext sk_msg into a newly allocated plaintext sk_msg when an open
record is split.

The scatterlist entry and the corresponding msg->sg.copy bit are one
ownership record. Splice-backed entries are created by sk_msg_page_add()
with the copy bit set so sk_msg_compute_data_pointers() does not expose
them as writable BPF msg->data.

The split path used memcpy() to copy both partial and whole tail entries
but left the new sk_msg copy bitmap clear. A subsequent SK_MSG verdict on
the split tail could therefore receive a writable data pointer to a page
that was only supposed to be copied, allowing BPF to overwrite externally
owned page cache.

Add a helper for copying one sg.copy bit and use it for the partial tmp
entry and for each copied tail entry.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 include/linux/skmsg.h | 9 +++++++++
 net/tls/tls_sw.c      | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f90..f3988ce2219db 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -283,6 +283,15 @@ static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
 	} while (1);
 }
 
+static inline void sk_msg_sg_copy_one(struct sk_msg *dst, u32 dst_i,
+				      const struct sk_msg *src, u32 src_i)
+{
+	if (test_bit(src_i, src->sg.copy))
+		__set_bit(dst_i, dst->sg.copy);
+	else
+		__clear_bit(dst_i, dst->sg.copy);
+}
+
 static inline void sk_msg_sg_copy_set(struct sk_msg *msg, u32 start)
 {
 	sk_msg_sg_copy(msg, start, true);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee46..434753de8aadd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -623,6 +623,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	struct scatterlist *sge, *osge, *nsge;
 	u32 orig_size = msg_opl->sg.size;
 	struct scatterlist tmp = { };
+	u32 tmp_i = NR_MSG_FRAG_IDS;
 	struct sk_msg *msg_npl;
 	struct tls_rec *new;
 	int ret;
@@ -644,6 +645,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 		if (sge->length > apply) {
 			u32 len = sge->length - apply;
 
+			tmp_i = i;
 			get_page(sg_page(sge));
 			sg_set_page(&tmp, sg_page(sge), len,
 				    sge->offset + apply);
@@ -675,6 +677,10 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	nsge = sk_msg_elem(msg_npl, j);
 	if (tmp.length) {
 		memcpy(nsge, &tmp, sizeof(*nsge));
+		if (WARN_ON_ONCE(tmp_i == NR_MSG_FRAG_IDS))
+			__clear_bit(j, msg_npl->sg.copy);
+		else
+			sk_msg_sg_copy_one(msg_npl, j, msg_opl, tmp_i);
 		sk_msg_iter_var_next(j);
 		nsge = sk_msg_elem(msg_npl, j);
 	}
@@ -682,6 +688,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	osge = sk_msg_elem(msg_opl, i);
 	while (osge->length) {
 		memcpy(nsge, osge, sizeof(*nsge));
+		sk_msg_sg_copy_one(msg_npl, j, msg_opl, i);
 		sg_unmark_end(nsge);
 		sk_msg_iter_var_next(i);
 		sk_msg_iter_var_next(j);
