Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729661;
	b=MuHOmpZCn6ggxH6sfzzSPdoZz9mYfUoZdy0dhuca6acrpdzDoFFIHXTjuePaXzABdjyi
	 HUoxnWi0MYglfOIe+3h0tudk2n6wGdmMqxMcsrh8wEqbFV2SjxJd873GXI6ZF1x9WQvc0
	 6tTxFi/qscR+nuf4V/iiBSBzcx3xHjXWXPQlRCmCyRJ2XZ6AO9QBvk54aEu3NM1KP2yt3
	 0SicA//ZmFBCwqDbWfbL7thuo6s/nYGWfUusiP+fmqWNOXvGvt3Id77uuHJib/okv/Bs7
	 0sZKst2hu5LzIoCasBtOAuzPmr8vWPYpYFjxrTyThieM9FZofgVYqsZTHV47ZkwbSiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OqWiK66+ITYgEweXXpu9oPRXdnmQupnf0R3lUGvBlJc=;
	b=GHtTJ3SQbpZ+La9SySSYJaYK6tLgksQrLCtKx7Igx3Ixp8u16XArAwPug7jkLnL9ju44
	 5R/f7E90ZZzDfy+1VX/KjaBbE/9yP0vLNxfRObZ8vbzmq5Pb8Ot2t2PIYLp0MOn9epKyA
	 ie47oUlpEYenMPg3l7LcMABXCfc9tmrlROltiE4vbPGOWEMlsfBcBRiG6WeBPK1Lwr93t
	 mIwQvv00WKuaC01Yc0+B4HLUqWAlSXsz05zB/MgtMLv804ChPwY4aetYvBmvTsTNIV7Er
	 G1xkUTcCft3DEfNgOwqw4yiGYi5rTYpHCXYKGSMa9/qAMxY8hqXh3xQto+Ulm3cPmFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bNRyP3U/";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CA606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNRyP3U/
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a6b774d12so362096eec.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729659; x=1794334459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OqWiK66+ITYgEweXXpu9oPRXdnmQupnf0R3lUGvBlJc=;
        b=bNRyP3U/CnE4DU3IS4KQPH9SCFHqw3ogyoj/xzEhUsdCCMtQdFDUiHslJnzgezPCnA
         Jbk0hcOozBvYsPlgQaPaBHQZ0Av4UIZt0mJTnvS++/ZUxjCSrxLCU2ZG+XS0FxnCRbiE
         vDw/anv23miCdy+FHc8LMez/AC0wKMWMxPEgabI7BfaDFNqiS7DKwacy/eJXwEn7+jeR
         rtf9bxr6Y+DBFVfhhM0XTtcV42080oi/35G9AiLnopCLVkcYxVgqq6U3cbJ3xOYX0tQ8
         svjgr7Bhr88FLMfTNxq/naf2qgerU73ObSVko39M6LoSzEljKWjdicPHhslBERS1i6V5
         njQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729659; x=1794334459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OqWiK66+ITYgEweXXpu9oPRXdnmQupnf0R3lUGvBlJc=;
        b=VtJuDbcLCXfFUuZn2Qf1KdUg0+sECkVgi9o0LD+QA5wTJA6EzmXm8J1tFJHJisiBIu
         gUmXFtEvOAM0y3b90s6iIRhuA3TZjeF+GCARe+BktCyJKix42D2hHwqOkHmQXR4wPa0h
         3MRBle0N8F+f9WekVt6uAIZqmAAk9vkavlQfDB8b+ANlW9MabJ5ihTRUDg0Z2qhjTjvR
         9NjEiIJ5kLdyWjV1IEp6JoeDE4tUkT4Y1A3TzEZq6m9YUpq8cYyKKrm5KriDKblzY/fG
         vncqdv4QIgHS5o5W2Z0GtWQTMVfnVYhVx+Hybg3vg13PdH9zflmr66W9lcsPa/L3PglO
         fnzw==
X-Forwarded-Encrypted: i=1; AKwUvBx7xZ2BSo4SBzzjst7EE7CS8rLYdYNuHLyiI5537BfhJL/s69ApRb0TM9TMG0SyI4AyXriGQx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vusX2yr3nSMhviAFUKNkGnRN8tljsT1ovvw8zrhwik09k/XQT
	mL5S1vzY/KDWDjzPR/VzTc/Qi8nB8bI+pvVhcVFZH9Jg1qBmCP+ShYLGsS5Cn9d32XM=
X-Gm-Gg: AYBFou29i/hRiwaXLnj7zKKTk32xhupLtvdVsKImsxEYNcDRWtorEjXN/YGHhHfq8uU
	0+6vfWVUfPZgNW130wlG4Wa8Cl4ivEo9S+ujb5EkYD324KMk/m/ffzvcL+3U8DZmlqF+nj8XxVO
	FS8HJtIhMayw79sAzfoO3Y1VI5CPU7CP5R0bINeiOy5m/+ovtkGauDpZcSdSY/+SV0BvhjZpKki
	R73zR2Vm+GV7kglUQ1fIe2NNHYIR/Yu1+gxQ0teapr2GV3OPUec6vNsaBZ8mRUb5UBCtrDNQUvq
	IQEMzWNn9m2x8Rzh/UNtVFZJUIMPJigYP1u0E/HtJ+CccewGxutDh0ERlW+qfNpszjh6u5xL1V+
	XvM4OATzNadeI+fjbi2ib7EKt6nsDng0c2hbgO7xk+bTNSdNx0ARlyETL5P3ZdP3NKO9niPH6IP
	WUGZANEz+wapvS0wBk7UfDVi3PBLexo0Y3qAJJ/97XVJGqNH9tSQwIFCkOCD4pwafdYYi0GZV/h
	2qsy4+rLI06AYOxb1RzKVJIjT+0NFXwcESbQTNx63iWPTpOpiqCvbbCne14Nqz3neRaKuq2AsbY
	Qx5rxuk07DEfCzILOh2TojOAZztLYVQhaTa7y7JAsA==
X-Received: by 2002:a05:7022:eb46:10b0:14b:edb2:c3bc with SMTP id a92af1059eb24-1ac4fd01362mr32675227c88.0.1793729659320;
        Tue, 03 Nov 2026 10:14:19 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm51929768eec.7.2026.11.03.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:14:18 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: cel@kernel.org,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfs_common: release decoded ACL on nfsacl_decode() error
Date: Wed,  4 Nov 2026 02:14:10 +0800
Message-Id: <20261103181410.1601083-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

nfsacl_decode() is used by the NFSv3 client to decode GETACL replies.
xdr_nfsace_decode() allocates desc->acl with posix_acl_alloc() before
validating the entry contents, and the out: path of xdr_xcode_array2()
only frees its temporary element buffer.  If decoding fails partway
(e.g. an entry with an invalid id), nfsacl_decode() returns the error
without releasing nfsacl_desc.acl, leaking an up-to-
NFS_ACL_MAX_ENTRIES acl (about 8KB, a kmalloc-16K slot) per failed
reply.

A malicious or compromised NFSv3 server can repeat this for every
client GETACL (getfacl, getxattr system.posix_acl_access - also issued
periodically by backup/scanner agents), slowly leaking client kernel
memory.

Release the acl on the error path; posix_acl_release() is NULL-safe.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 fs/nfs_common/nfsacl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index e2eaac14fd..e7ad47e2ca 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -353,8 +353,10 @@ int nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
 		return -EINVAL;
 	nfsacl_desc.desc.array_maxlen = entries;
 	err = xdr_decode_array2(buf, base + 4, &nfsacl_desc.desc);
-	if (err)
+	if (err) {
+		posix_acl_release(nfsacl_desc.acl);
 		return err;
+	}
 	if (pacl) {
 		if (entries != nfsacl_desc.desc.array_len ||
 		    posix_acl_from_nfsacl(nfsacl_desc.acl) != 0) {
-- 
2.25.1

