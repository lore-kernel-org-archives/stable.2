Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762227;
	b=NNfRMXBNK0meyosn06F9xZq/ozCu/h8VkZBikL7B91kr+xrMHo3j0+3gY15dJDlk+Khp
	 anrIJ2SkK2tnH58FPO8p/8Ci0HdlX851lRoQ5bZXQ9bJVXZnjiY8P06PizfaUATz33jO9
	 tZ34brgz3UxWXUBSzELK5kTeew8vPlEnhJiNRgCDlCBLCy4QVANwE2JdAsjTN/TFCoCL2
	 B6bal2XNCHfZkLuMg+DGpD8tk4wdva/tG/EypONjTqN0Z6ektdwmAx/z/v9xZSmKHbviY
	 U7gYefU0i4zxAVNmEfRxiCg/fjO1CSYK+IfJsc93VT6Lva1n736eJ5vh0PDwxkcHhHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zkI3ZaCVO6DFWoIiiuuohl1A00TTUY+rHg5pk5A5ReM=;
	b=S2fnXJUqPlbadn03yTxMRyMDVBm7r7k5mEiOWIjSOG9Q1EKsuF/0eKcNGJJhheAoriM+
	 95UkjXuIavAOM2XWs7Y1t9F+ePxkvppnsXiGhH4dt2ov6hgc1Mq3tae4OEEDzF4ue8yrH
	 uh/yPSZG2xwOdBEExCuVVJxmz9y6rteZ6c7QiV5/6YYnGdOS4N8NmJeAToGtREKq18Im4
	 aGYKIGaQ2LoX/764hXxb5TsrZBVn5d074bikmvjK5ooxb/DT7h6TRi+24C3Yps31jxvUH
	 g0iVzgNpCZmRXP63L9vTE0qx0CbESunFe+95XT3wUSCvQYUNlSZZxl5/9XukGGuB0PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N25xEqkv;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2A606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C2A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N25xEqkv
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3b497279c25so2370310a91.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795762226; x=1796367026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkI3ZaCVO6DFWoIiiuuohl1A00TTUY+rHg5pk5A5ReM=;
        b=N25xEqkv5pbmWpcUYO6PxJmIBAx0vL2XhBDLVkL/YevQdZaDsWIB7SomQ43Y1NP4np
         /ncFFwDk+/4rx+47PjGUHKBCG1F2yjNmYsSF07iVz2ZvRkjN2VcR0iQBPyHFMwmD+Esl
         0HEtj8HXHYPGI7wRHBmG820O7YXrZCb8SLFA/1DoekGvX/Ue9xJK4/+ztcrm3krQjJVz
         yM8CIxHEnVE0pJ5M17Sijlg/29qr1EMj7HSQLyAOOlvPGR9aSLb7Zr83QMLPW58w3Y9S
         trstm9drg+JkEQLJ/Lph/1iQwJnUU8BLd+cdtoA7jTc57CofSrO6fVnygCVTVHwz5Lmy
         2SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762226; x=1796367026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkI3ZaCVO6DFWoIiiuuohl1A00TTUY+rHg5pk5A5ReM=;
        b=zp5GXl7E7YCZsXY2fcXRui4aySUCq4w8iokp8J4nFykY9q/GFlHBqJltddNrIvONq5
         zlNglnNsvB12J5afkonBToFSwd+46sQRRqlAF4NMq29ASMg3MWY9OuIUJLXDEuJ2US9P
         hSdQXZc8VURQ0YKEB9VI6jOfqu03EXsOcABzKkJntRHsU1PPMNpopfaNOBBB9qNI4W1j
         uwP1y3LbKIYALCGhwilfZlAnocZJDmoXxyZ4kjdMLhX1/Mjtk6lVubTwS4Anjs46Fw8P
         UqyllZZlBM180mpwfangBaE/eA/6ALBx+bGMroUWa22q0Hln5i08oNrWUhOGNIV4ZYSA
         kriQ==
X-Forwarded-Encrypted: i=1; AL+hErGVuYK48DbKeP/DYsoWtAGaycQGcHvrFv9Np8L5Bt9YrG4aXdG401eaIFxpu+9JXWJZ6b2SbBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dwr99aChGpJdlu2rI6vITLxoNIFgNvFdjNYqZXK91Qp6g/Trd
	P3+KPSmfBnPqwxxRILktFq307OPu5apn0aGn5ASZPlgr7Gb8kfftS2KK
X-Gm-Gg: AZFdTZcLBPuB5IvjTUOlpZ0QNIW6zEbbntD5Z9Rc7C+goaTJRhKTab/PXYMlDwjZTbP
	Jefw1fTzEPievsTSlmXeeH/RlGwcTiU0QsJcdM7PMsFF4ewDTIDsZxi0a/YRZsSeImyUy19QdGY
	18K6nCRgAV151hjNGr9jL9yH0MsC+gZir484NEpP15KmRp0ukBvcwqNE6PUkZvMrL5q1Rjfkhb/
	McllFvQSg+mRIkJcNC1Z9FrI6PWYHckfxzV0fxzqyzWearKmk/TdfzECeSN3UPaN48DZTLviGt8
	nxiqnH1GTjy15KJljtfG1h45nbbYqpvV89iu7G0Au9VcjScQmHxcP2AtA6A9QkZSLDD/g9bHCvQ
	3ixELoZQ6xKJzAIsztzKGsH8pXfqIS2oKXwHTW7DRrR+yqiKfOOGVSIiit1H71TBRQ8No2JsvSf
	i9jkk9i5u9vGh2pSLFopmqHBQZvoWN3eiS127j+6fGk9B1ZC7Wrhq1Y/cRhBdWKD1XZLSnerLI8
	GAGjaOu8aX2TtPXixii5AAVXBUwZ94C4W6eTMEiJccBK9af3fTW8HkuuxWlD+1nK1uWkCL4+v0l
	aJOOHBK7MomXjKjDD68ZNfuB3oTR/8pyRSKLP6Y5R8a/K6JbcJ3DYiIrrj1KtlpPbIZvjzggAdZ
	j
X-Received: by 2002:a17:90a:e705:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3b41c7e118emr23007990a91.5.1795762226024;
        Thu, 26 Nov 2026 22:50:26 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm39498980a91.12.2026.11.26.22.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:50:25 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: don't count pending-deleted addresses as survivors on bindx del
Date: Fri, 27 Nov 2026 14:50:17 +0800
Message-ID: <20261127065017.2922776-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sctp_send_asconf_del_ip() uses sctp_find_unmatch_addr() to make sure a
bindx delete keeps at least one address in the association.  The lookup
counts entries that are already marked SCTP_ADDR_DEL by a previous
delete request as survivors.  With a peer that holds back the ASCONF
acks, two sequential bindx deletes each pass the check while together
marking every address for deletion.  Once the peer acks both deletes,
the association's address list is empty.

An empty address list breaks its consumers.  SCTP diag reads the list
head as an address and returns 16 bytes of association memory in
idiag_src.  A following bindx add builds an ASCONF from a bogus address
taken from the empty list head, whose address family matches no sctp_af,
and dereferences a NULL af pointer.

e.g. on mainline v7.4-rc4 (KASAN build):

 Oops: general protection fault (non-canonical 0xdffffc000000000b)
 KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
 CPU: 1 UID: 1000 PID: 81 Comm: poc-crash Not tainted 7.4.0-rc4 #1
 RIP: 0010:sctp_make_asconf+0xd9/0x280
 Call Trace:
  sctp_make_asconf_update_ip+0x243/0x540
  sctp_send_asconf_add_ip+0x366/0xc90
  sctp_setsockopt+0x1986/0x9410
  do_sock_setsockopt+0xb2/0x160
  __sys_setsockopt+0xdd/0x140

An address that is already being deleted cannot serve as the remaining
address, so skip SCTP_ADDR_DEL entries in the survivor lookup.  The
existing keep-last handling then holds the final address back, same as
it already does for a single-address delete.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: f57d96b2e92d ("[SCTP]: Change use_as_src into a full address state")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/sctp/bind_addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 31737f144c7f0..e20006b9f12e4 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -445,6 +445,12 @@ union sctp_addr *sctp_find_unmatch_addr(struct sctp_bind_addr	*bp,
 	 * can't change.
 	 */
 	list_for_each_entry(laddr, &bp->address_list, list) {
+		/* An address already being deleted cannot serve as the
+		 * one remaining address.
+		 */
+		if (laddr->state == SCTP_ADDR_DEL)
+			continue;
+
 		addr_buf = (union sctp_addr *)addrs;
 		for (i = 0; i < addrcnt; i++) {
 			addr = addr_buf;
-- 
2.39.5

