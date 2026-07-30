Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708633750DB
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378802; cv=none; b=nxSPW9ob2y6GIVMD5qH0cEC73fNWUi0+u1h3Em6x9Q9Gpsl7Zq2yK5+n00qWFDqvPQaD+TDlb0cr4LLD48+CWWRsvBuuSR8IfVHaonijcyEgIf6Na19ibg5YTcqv/DvaD0TR51VMew3vrxB+IatUwOPiggPdDioe5ntuD312g3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378802; c=relaxed/simple;
	bh=Iwuc5U7WKBARUra/t58c0cg7GS28SQYw+Sv3GNlpazA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbfoP7y8XNkWWhurQ71facJ7jtWM4LjnTtgLHCtka+9gFndKP+M2iIQfDX2JYrZ4rbUhoEB9w5E6iEqo8emzQiE5b82YQrGMZFBckFJv/QZmFcSDsxpHMBG5pKjA+1D7HpkilfKfIxYvUaD/YcGpZ4RuP9zcnIXdtHEW1dGGkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f72tui43; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f72tui43"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1876994b3a.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785378801; x=1785983601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFQEZHCieGUxsn8s5z6wQ2LAPE8dpKhgSk8OBI83lDY=;
        b=f72tui43FmpwdjvBsOGZUJzIa2/++in76kjn486BW8vMrizSYgvaVnggRbNq+Jhkg+
         heAPVKXYalqWjzYgfDOJ09GMrWqPLbebkScjfVjLLPtqfDMQB6FjbxLTmQadAKeJBcL3
         cZGiDdCF87XQsLVCJTZ5Wb6oMHmtgLYWCU0h31vhiV6DWd1iutTNLShv3snCWQyzX+rU
         Eoelh/cDFPTnMIGsywfXU9nwG5a+erLYAgkk2lT6862g08rGzM4rT4cCEMFLJWIcdJIe
         KTP7MtQjQqjhsLLuQBai79Fm1Xd7J4Lq5Ei1N3CCoKo4sFNprGjpaklizIKzLnIw2AJK
         GBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785378801; x=1785983601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFQEZHCieGUxsn8s5z6wQ2LAPE8dpKhgSk8OBI83lDY=;
        b=Gc1/W6DP2dbpnN7Ad8BQr8xPbqqnS0hngVh4KIC/EbWRWWvoL27N961Q5qtJi88dk7
         8a6C6xDUwTA81zv4aP+T2rQ4aOmxN/Fq8rBe6GGMUgNszFjXO57pV5qaWzd2yOlSkb8X
         kIYp+NSvbp7haXxQLIUIftJgyp+3+rled68hCkVybbcmkUAGqV5sSihA7KkVKqR5sDkU
         Oqq+pehG4bb/dIpLZdHgZbirmXg1Zwivg7iYVjGGY/zWIW9kIbHSuL8oI7IkWjFDxqqw
         PBplf9BxFy6/Oujb9q3ShZo0p1A/UTgdC3VBCbnH/S304mHhF3+1CLX+WJ8zkIogPws8
         YTyA==
X-Forwarded-Encrypted: i=1; AHgh+Ror9DJS9K70lqZ31J+WL9SwoQu2B0FHk1GbouWSvl9aYP3K/M00YkGmls1oPBaQlorFyodkop0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0Lx+fF8qwld05XygQq/FXDJEmdWWZ34ZL8VcEdrl+5pxaecr
	6VMLZEvnCcdSHqbstJ5yKT/g2A/0qmb4Bpn1KBmczG5uf4PJFrrXX9BS
X-Gm-Gg: AR+sD10FZXgJbZwME9E5XirbxSH3IWEZWKoJ4Ry1bTPrB0cPHRI8EiCIFM6WXFN6dAy
	khmu/mkyCA9QSnWak0jn0dZQNK1FyzLMyelUvIZvC07QPGXZCqkSg65HETXeu5PQUECMI5DBj4l
	Ces+YqJnXAUK6nJRZxjHg4NrLmYGcHL7+cp8MlFYx8gZrNtabtstBNhhH6L5VxucOWYAVMEAgX0
	8xVWkI6wQbxOqOjcRTdHWAxPctEAw6dc0k6D32hS16kOIhlNL87UaaCm4T76oxxI5EhfZA5ck0Z
	eYmODWBUlN5JX3w97o2prwlFqVn03ow8JxMRr68hjk11CTPL4vJQEO1VK1/nCUGmKmlqmAFt7ow
	dgdqNI9VA4Pi6wb8etlqUqT1GNuCI+8pGW28FQ/5tZd+llUQ5p+L+CQTJnyp2wOZ6go/ud+VuV6
	sQS2/MHAgAFux5TtDsrLxXrZjp4fsYJg6luzITfFLaoz/oKBMwSUDQRgUGAba4k+Aapvvh9uv3U
	BuB6IBF1QBy
X-Received: by 2002:a05:6a00:414a:b0:848:5540:2377 with SMTP id d2e1a72fcca58-84ebc24e899mr865101b3a.17.1785378800736;
        Wed, 29 Jul 2026 19:33:20 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe2153csm2179348b3a.3.2026.07.29.19.33.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:33:19 -0700 (PDT)
From: MingXuan <omeux327@gmail.com>
To: marcelo.leitner@gmail.com
Cc: lucien.xin@gmail.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	MingXuan <omeux327@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
Date: Thu, 30 Jul 2026 10:33:09 +0800
Message-ID: <20260730023309.21654-1-omeux327@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 bytes,
the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the netlink
INET_DIAG_LOCALS attribute and then only zeroes the bytes from offset 28 to
sizeof(sockaddr_storage).  The same pattern is used by
inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.

The IPv4 address-filling helpers sctp_v4_from_addr_param() and
sctp_v4_from_skb() only initialize the sockaddr_in portion (16 bytes) of the
union sctp_addr; the trailing 12 bytes (offset 16..27, the sockaddr_in6-only
region) are left uninitialized.  Those bytes are propagated verbatim through
sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=28 bytes) and then
copied straight to userspace by the diag fill functions, leaking 12 bytes of
kernel stack residue per local/peer address to any process that can issue a
SOCK_DIAG_BY_FAMILY dump for IPPROTO_SCTP.

Fix it by computing the actually-initialized length of the address from its
sa_family (struct sockaddr_in for AF_INET, the whole union otherwise) and
copying only that many bytes into an already-zeroed sockaddr_storage slot, so
the uninitialized tail is never read and never reaches userspace.

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Cc: stable@vger.kernel.org
Signed-off-by: MingXuan <omeux327@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
---
Changes in v2 (per review feedback on v1):
  - trim the Fixes: commit hash to the recommended abbreviated form (12 chars)
  - rename the introduced local from addr_len to copy_len so it does not
    collide with the existing addrlen (slot stride) in the same scope

No semantic change relative to v1; Xin Long's Acked-by is carried forward.

 net/sctp/diag.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index d758f5c3e06e..12557e924cc2 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -85,8 +85,12 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list) {
-		memcpy(info, &laddr->a, sizeof(laddr->a));
-		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
+		size_t copy_len = laddr->a.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &laddr->a, copy_len);
 		info += addrlen;
 
 		if (!--addrcnt)
@@ -113,9 +117,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	list_for_each_entry(from, &asoc->peer.transport_addr_list,
 			    transports) {
-		memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
-		memset(info + sizeof(from->ipaddr), 0,
-		       addrlen - sizeof(from->ipaddr));
+		size_t copy_len = from->ipaddr.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &from->ipaddr, copy_len);
 		info += addrlen;
 	}
 
-- 
2.50.1 (Apple Git-155)

