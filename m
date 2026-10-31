Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793432838;
	b=Y/FB9RgQBA9/qDbP+LsaFE3ZDp28wFETBXCXXXf4nfk1RuOthqOUvNSYLAHNCSqBGSKu
	 80obGMjUUtZwAxEQiMe1mlji0Orl52MNhC4xcF5uz5osebtQnHa1HuhwkoItfAVP5A6Ca
	 28ctSefvGxfWcBwPyZZ3Tfd+J9q3pkJRUoQVcwDiJmZC5FWzf7dnrTbW8Ueikjbqe/uTa
	 +dzoo4BbFrcue4rPjCaLw1Pu74aABed39qjiFRD1DU/Klxsdqam/DC+egE+T/SmSIjU0g
	 +4t+iWCvKJRYb7STZCM61jGFtBcQPwxHI7QPnU7jvLU1ega+BlavWfQGpOIcZcT6Jwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793432838;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GBaUg8nhg5Dp/odicKAnQbPKQztKEv19Ui9b1WPcV1k=;
	b=QCTmL7jD9XP8Y1abVdPyxeN5HbniWINK22AWTo4gm6eu9Yo/QphDGdf31DzW4L8xisf+
	 stasiz9Je/poCcTq2l74LaWGwsmZrK+/Ug7I06SMf4kvEElZPTjH/CShLq9Lo357dzXX8
	 LfO9goCQqHWgwtxZKsAznpg4TGpZRl/zAwtAtU8tn2Tc4EVoM5tlzV9h4sfF6aZaMF395
	 3oRbCBefWZ2Ighcw0GUPIac2dG78eePpsAi3eRDICkBGw5B36Tvt5Wlc/GlnQ9sX6XMhY
	 JlBddIvbJb+MMFUX2iLihMwjVZlt/zdogUOOmAziH/ywUk3mdi5L/10qT8vhLSmiVQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CdAhnODb;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D90606A31A;
	Sat, 31 Oct 2026 07:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CdAhnODb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CdAhnODblpjQtu/IfDk7hoiEwbG6Rnm3s2ABXRxWr53nET4Ax3dp8wuS3MNm0OHZgvUvIgQ5yPprr
	 QLPBv+G0AFXUP1O6w2a87Eiyq9bW3XQpS9+eouafn5vime0Ps6b1F091al32uXU9jjVerUyMY2DzX3
	 gY7PmVV3Rv6g/Rvg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ae59cf5847-555d7;
	Sat, 31 Oct 2026 15:47:06 +0800 (CST)
X-RM-TRANSID:2ee16ae59cf5847-555d7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[222.93.19.82])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86ae59cf830c-7c9a8;
	Sat, 31 Oct 2026 15:47:06 +0800 (CST)
X-RM-TRANSID:2ee86ae59cf830c-7c9a8
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] tcp: fix device binding after failed IPv6 connect
Date: Sat, 31 Oct 2026 15:46:54 +0800
Message-ID: <20261031074654.73952-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

tcp_v6_connect() sets sk_bound_dev_if from sin6_scope_id when connecting
to a link-local address. If the route lookup fails, the failure path
clears the destination port and route capabilities but leaves the
device binding in place.

A failed connection through a down interface can therefore leave the
socket bound to that interface. A subsequent connect() on the same
socket to ::1 then fails with ENETUNREACH, even though a fresh socket
can reach the listener.

Save the original device binding before processing the destination and
restore it on failure.

Found while reviewing the error paths in tcp_v6_connect(). Reproduced
in UML by connecting to fe80::1 on a down dummy interface, then retrying
the same socket against a listener on ::1. With the fix, the retry
succeeds and data flows in both directions. Tests also confirm that
existing device bindings are retained after failed IPv6, IPv4-mapped
and link-local connections without an explicit scope ID.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---

Tested in UML on net fcc00b15cb21. The complete tcp_ipv6.c file is
unchanged at the base commit. Before the fix, the socket remains
bound after the failed link-local connect and cannot reconnect.
With the fix, all 12 checks pass.

Build-tested on x86_64 with W=1 using configurations based on
allmodconfig and allyesconfig. The corrected tcp_ipv6.o compiles
without warnings in both configurations, and incremental kernel
builds complete successfully. WERROR was disabled for both;
allyesconfig also had KUNIT_ALL_TESTS disabled.

 net/ipv6/tcp_ipv6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360eae..7bb8266d9d1b7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -146,6 +146,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	struct flowi6 *fl6;
 	int addr_type;
 	int err;
+	int old_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
 
 	if (addr_len < SIN6_LEN_RFC2133)
 		return -EINVAL;
@@ -358,6 +359,7 @@ late_failure:
 failure:
 	inet->inet_dport = 0;
 	sk->sk_route_caps = 0;
+	WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
 	return err;
 }
 

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.39.0.windows.2



