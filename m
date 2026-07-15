Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223243A16AA
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086559; cv=none; b=JpQzUSBviOFpvpzE3g4cyNorWh6R8pvYu54PoFhZ+AFbuauMT7ZuiWUczuTsiJ+PgTM7xc7XamvrSL5dYuLJ9YMO77HgnFA0DHPv3LlNRInFznx8/UfhNbNa1OpoWdzXk9jsMVqXVTWvgaxN+bbaqDlDaOigB/DXP1CWFyZdlag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086559; c=relaxed/simple;
	bh=tl9QUY60ANTH63SkBkkbYRa0mh0qVb/cgU5n6BRSkZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/6USt3f+5b8aZ02TkisJ535NIUfAnguvjLw76sL+9gIUcy+zLXYwozampLrec9so9WiK7NbUGJwHknozKedS8R3xbXUHtMQg1pdbufgYmd5u1jTHiDjBPRFRqozBGmkvYZ5S0DgPnozFKLhM2A0x0ko6kNoYrcVzSjWdQDIKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNnqsjS/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNnqsjS/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso59048275ad.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784086546; x=1784691346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ymvDeDodxFq3HgKKLyUeM3rErvPvsmK6UFUvd0diOrc=;
        b=DNnqsjS/SImdPVPfjMWu7EObi0d4fFvdi6Qh/LoBCMXyzl6EC2z9KefqXjWnBTBo/k
         49qF5y4HmxaVTxTTsUnDB5CBWczBe9sl0fmax03fbyy1eGd8Wh49AvM5HgoOYXNbC4o4
         bfQAqVsfoksuVfsPqg8SvDSRBlo2UxdqaVuPs6V4LjVhcnNYU+S/RjmwBTNlHCajx720
         5cT+k/4qL+wt+37uCRMQq6+iQ6I9UlQ7YhCJReFrw7mT2xGGoWGRYBzNIJ9ewhodzSeu
         T/B4rZzBzPwxcKVOuHFtPJfBkT3btPaI4TmsBx40K9wJ4/Rw1gZ59kai9/+DHpMXVaPw
         dIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784086546; x=1784691346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ymvDeDodxFq3HgKKLyUeM3rErvPvsmK6UFUvd0diOrc=;
        b=UWi/0dI6j62Ooi6cMZMXPBWW0T1RiRlwJc1iuJBWekwqiPXrdvcD98RngvTZmwtCeb
         jg+wpktLldXA1PF9shIl3kSNEw5AAWuW2wlRtodwWKC5+ETt+iIZZk4FWf43mLJQfW/m
         ujkgr91CXC3a3RbEeHHnst/EoVNnv+TlLJTp4K7/SntuMpNWwvCINFJQy5viupO4l3ea
         /3gSeQkgzq/KN6e/3zkU+bg2475Y/xxWEf+MqVUQw19nChoAbPai+PjSn+N3Z+72kKaG
         Sw2TDVALZDjNblcpDG0dyaPRtMvRdiFDAgRsH7ytErPHjBwPE43RD5ewT66N2RLRRwle
         pQFw==
X-Forwarded-Encrypted: i=1; AHgh+RplIu0Ljk9WIJwN112G65kmtP/adNDk852JZAqo5aJTWwvgyx05Z1KjLZCsbHu3g+kHVEBKy1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4PHqVD2TSyFHo9J8RHAvNL9A4osuivg2fa7SYjnusvP5dvQN
	aHxngpWxABziZJiHNatSjEaKNJjfHifk2EWySclEsgl6jh1EGHdb1pY6
X-Gm-Gg: AfdE7cnA1yOsZX0F+jcWbfIt8XEW5GxFd0A2Dt2ITIYEUh0FeFCqOFBjicFmGZxROf6
	auwXaieC4UWx9tXTSN9yZVTIXnRF46s0eOoZFDrFDs3lR0UnNJ6EjOoXinDSaWwYuioxJ7hjy9X
	vqzlaMfeQSiZc4udc7qCmyQ3/Z+hT2DdCF0bkW5leG0GOTVrkYxn+WPZw1HkKFAdRxv4A52Kwre
	ztQpOFri2LYnM7HVcKe2hP4ETcYvqJOIp6KSLVODsio7VVIlwPbkDDOUw/eHhzVJDxaeBBt5c/R
	Xcfdxx0yvqdPuSgsrYcn/kyHY+3+Z5UpXCMyp/o4/obFig5n6w4za4X8fZC0QGFC6b5tqnfB5PE
	xnDBOWh9Kw3AEeJndgVOBTgBgw5qfkIDHFhE25aRSXiXO5d19Th0X/XaKH8/R2P72kp+3j/rvz8
	47pWceTcGceLVCzBb5LxTyoIupWwLbcKqROkIS4DNs6htN
X-Received: by 2002:a17:903:2a88:b0:2cc:5f9f:54ed with SMTP id d9443c01a7336-2cef12fe180mr53236485ad.27.1784086546202;
        Tue, 14 Jul 2026 20:35:46 -0700 (PDT)
Received: from localhost.localdomain ([2404:2280:2000:8007:d87:748:d87:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm125464325ad.65.2026.07.14.20.35.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 20:35:45 -0700 (PDT)
From: MingXuan <omeux327@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	MingXuan <omeux327@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
Date: Wed, 15 Jul 2026 11:35:36 +0800
Message-ID: <20260715033536.64963-1-omeux327@gmail.com>
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

Fixes: 8f840e47f190cbe61a96945c13e9551048d42cef ("sctp: add the sctp_diag.c file")
Cc: stable@vger.kernel.org
Signed-off-by: MingXuan <omeux327@gmail.com>
---
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
+		size_t addr_len = laddr->a.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &laddr->a, addr_len);
 		info += addrlen;
 
 		if (!--addrcnt)
@@ -113,9 +117,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	list_for_each_entry(from, &asoc->peer.transport_addr_list,
 			    transports) {
-		memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
-		memset(info + sizeof(from->ipaddr), 0,
-		       addrlen - sizeof(from->ipaddr));
+		size_t addr_len = from->ipaddr.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &from->ipaddr, addr_len);
 		info += addrlen;
 	}
 
-- 
2.50.1 (Apple Git-155)

