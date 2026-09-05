Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DA23E33D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578907; cv=none; b=XtJncPI19z0JyfK6d+cGo/HcJFGn5eh3GFt9gonzdGEkNLcG57I9K/ivFdmGS0Ze9b1gL2hXaErUhdrA8ZO5jXMyX0CtPEKHpmyKqNS7vswfVBx4tQlnQ8q+m34qbK014h+nZ5XuFngDi2EB3ksCP58f9cBNsqxQtSc27rczndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578907; c=relaxed/simple;
	bh=AvIo+M2530K/XadxkWZdwtzV30MOXGnB3euHYPTJGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTbxECyXqTWa68FEI+1Uqw+4Kg+5RtWiCrut9qJW3g3il9Hg0LxzUWH+BJnw/WBRVCq2B1s8b9Rq04YaXvyV61sYjuImUXFayl9H2EPvCzeosKtvp4ETGQq7u/jmIz1qJAtlSd1jfLQw9tgY1JnAYUj7rXvz3j5KC7+w4zdViI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feWMaNAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feWMaNAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D341F00A3E;
	Sat,  5 Sep 2026 03:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578905;
	bh=Ao7NgYJN3NjR/+t6k3HrBfm1B8GXMLEj6QS+2j71tRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=feWMaNAPVaZJIRdjVZZlQ2QSRlB7KtMa/NIXbfrZJeUeNx1DO+h48wqhWOyOiN/hy
	 eS5zb2F/Q9xA+YAqTs69u2AM/OB9BNSXqqqKtMib5qULUmRnjHLqW8bmWsLt8YtUE2
	 gWrx9gWR/OX/hHaHZL1+eqMipEetYK/rH/ic7CvEYHbc/8q8Ef9F7ySphwJS93UVQk
	 I5umPXR/3k0ilFvcM43gAvtKpI3mX0KRUqbDMKxVWk6lamS99P6fuTWxunnxNCO3oA
	 DTDkgmNoMig/WW/zVxUAdwGoaY6qLZ1esz7tFOqNOF6vCbTiQaWNaXX18omS2qla2h
	 FfdfQMN/tnMAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	tianshuo han <hantianshuo233@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND"
Date: Fri,  4 Sep 2026 23:28:19 -0400
Message-ID: <20260905032820.1914550-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032820.1914550-1-sashal@kernel.org>
References: <2026090358-starry-expulsion-6b91@gregkh>
 <20260905032820.1914550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 3e7f011c255582d7c914133785bbba1990441713 ]

I've found that pynfs COMP6 now leaves the connection or lease in a
strange state, which causes CLOSE9 to hang indefinitely. I've dug
into it a little, but I haven't been able to root-cause it yet.
However, I bisected to commit 48aab1606fa8 ("NFSD: Remove the cap on
number of operations per NFSv4 COMPOUND").

Tianshuo Han also reports a potential vulnerability when decoding
an NFSv4 COMPOUND. An attacker can place an arbitrarily large op
count in the COMPOUND header, which results in:

[   51.410584] nfsd: vmalloc error: size 1209533382144, exceeds total
pages, mode:0xdc0(GFP_KERNEL|__GFP_ZERO),
nodemask=(null),cpuset=/,mems_allowed=0

when NFSD attempts to allocate the COMPOUND op array.

Let's restore the operation-per-COMPOUND limit, but increased to 200
for now.

Reported-by: tianshuo han <hantianshuo233@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Tested-by: Tianshuo Han <hantianshuo233@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

The 6.12 tree already contains the functional changes from this revert
and enforces a stricter 50-operation cap. Retain that cap and use this
dependency to relocate struct nfsd_genl_rqstp into its sole user so the
follow-up address-width fix applies at the same location as upstream.

[ sashal: Reduced backport -- upstream 3e7f011c25558 touches 5 file(s), this
  backport carries 2. Not backported here:
  fs/nfsd/nfs4proc.c
  fs/nfsd/nfs4state.c
  fs/nfsd/nfs4xdr.c
  fs/nfsd/xdr4.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: a99d720ed2a5 ("nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 15 +++++++++++++++
 fs/nfsd/nfsd.h   | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 87c27ad447b75..3daf3993c7973 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1492,6 +1492,21 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+struct nfsd_genl_rqstp {
+	struct sockaddr		rq_daddr;
+	struct sockaddr		rq_saddr;
+	unsigned long		rq_flags;
+	ktime_t			rq_stime;
+	__be32			rq_xid;
+	u32			rq_vers;
+	u32			rq_prog;
+	u32			rq_proc;
+
+	/* NFSv4 compound */
+	u32			rq_opcnt;
+	u32			rq_opnum[16];
+};
+
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
 					    struct nfsd_genl_rqstp *genl_rqstp)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index fea716bbebf1c..6665285ede353 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -70,21 +70,6 @@ struct readdir_cd {
 /* Maximum number of operations per session compound */
 #define NFSD_MAX_OPS_PER_COMPOUND	50
 
-struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
-	unsigned long		rq_flags;
-	ktime_t			rq_stime;
-	__be32			rq_xid;
-	u32			rq_vers;
-	u32			rq_prog;
-	u32			rq_proc;
-
-	/* NFSv4 compound */
-	u32			rq_opcnt;
-	u32			rq_opnum[16];
-};
-
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
-- 
2.53.0

