Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152507;
	b=nvpl0ld/358dtpj07orXBHYMkSvqi9TAzJJy3r6E4o+4JAtuLwWCV0qLJgc35+kTbQp2
	 Zky7oW+euL3L/lgkC5J3P9eSAdoAKbV0DrgerIWyo5vceyfmIDmoZycgQq0B23n/OQS4D
	 WK6CUbF7g4jKwTOFGCtzRZkzLLZMJTHrvn0rdttj59KDFhoZZNHvXty0wruisVTbMtemq
	 l4nZBgD6J4HIwjCA3fH4Rg6Hvf2pmJTLj++LX/v1IRnhRWWAUwgoLM/TDXOefABHn4PoI
	 d76W2lMJU4fB1G5EP5UwgLS9MZPgaw0Pvcr6e7OfQ4RcwvTYgNdepRISH+Jtokcf4mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7ERUV13pYbEG+uwgbT5jjtIsKXtfXcMiUyjhVeq/SAM=;
	b=gYSYzq4RgSp46vUlvj7tT/A6ZL64RwA3xjWjSIk+O88e/rSrVh7l/5iVgquqZdem7kj/
	 j9JbuEGnGpWlextYrF/LqBQezvgtKDKpK6xXlfL7PZ1FluCLgmD3OgOOvE2lbFqoEUu7w
	 6cBx15yReUTT8VA1lqtQaQrZADiW68BAWbOiTRskIMYVKlBVM4you36nA/Khx2RGpsLf8
	 siYOg510c7h88bJks4HpCl4/AIDk3/TQvc8YR/HCteb3lDLh7G9Iq8CYK+d8Nrwm5vBxu
	 2Un0z/JXffRKecITUG0ZziQozELzHfP7fvkuNAicDG2541skflAgH3nHYC873e2ZDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8iRVHmQ;
	arc=none smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9042606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9042606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8iRVHmQ
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-56820670d00so220632b6e.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 21:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795152506; x=1795757306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ERUV13pYbEG+uwgbT5jjtIsKXtfXcMiUyjhVeq/SAM=;
        b=X8iRVHmQ3vh0feVZlE75fesBZ5nUtfOxSo777VEKyHWzSLiAdqXdAFnTVgGVHsBKnd
         E+bGLbBYkgSPHlB1Z3LyebdJexG0yYesT+txGagYdD+MCQxr0MU1XBpIlO+sjp6POxLR
         HQQcylpCQh/H3S0m60KBB/qLZjNBfoJsKY9QoLLLp6C3Ku4XvLv8er42CXwdQNx3KFZC
         qiD/86BdjCpXlVF3GKeVHgjH54NdblMNOO0iyW2nw+VOeVsGSLnVyV73Nf+7Yx5MZT44
         knKHxOsmfZC0Zir8OnPrQCY6mwsTkCLI/imwvAXlcOtnZZJAtA4m8tUcU1dv0b7qvADL
         roEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795152506; x=1795757306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ERUV13pYbEG+uwgbT5jjtIsKXtfXcMiUyjhVeq/SAM=;
        b=k2h7JACXrvF3RaDANIr40DNHRlk6ukQWQLvfsrjd8aYNdufvfZlCWeq2rWy0+Vj25L
         LN730I0qmt+mqSVEMbyz/JSU0mqDCTILVUApYlxWdrhcxKsWZuAkFvqQVBl9+mtM48BN
         AweEHzdktSzayayeQCj4WcRL/8Ngm0gcUkXjxVuU/YPED+EQxN60e0fRMCXU2/60CiSM
         yzmN5c50smDzQ+jZIWV6dAfyaUVsdKwt/lj5m21OVgwv6mAfdQBoBLGvRaxFHulsdh/+
         wzMiEnRD9b8zQDn2274jkPcs3NQKK7/ynIFGJJHIjjAGpTgM1FkXdO/Fycqn8oZ71JlX
         5Ntw==
X-Forwarded-Encrypted: i=1; AL+hErGnotbavd5oQMQ6gXQI3mqhbjlmyv2iERnJGVx75iqQDIVpi2mMMvG4wb0lsOEv+gLxgnPS2WM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ALzrcEUREdhldg4C7FaBoj3CIubR6Ag9di1NtJDuS3We7ti5F
	hI6rWyQjpKkMG3mJPnfAYyW/NOV1ObbZ552nVB8Vf7L88k0w4+E63gizkOcu2AtY86J2MQ==
X-Gm-Gg: AYBFou1jsFmx4FJ2tP/4cU08dBlqlo1OBQOEtcq4J78VJa3RgxZ36MSd08RtFIrzIf8
	aCRHvlQz1c7UwoZ58aa0wne9wzJ00bUyZmz9/ioPtPPRoKEMqXd4ySJyGxW9esywXOITruYuRW4
	MjHYAGCUi42t44CQf2hnpY5b8sA7uCq9Y23zxpLm2Ra/Ft+EYXP0vElhiJngIgeaNXgxlnMzbIf
	deE90dF90DepYpen16600ZmHhsCS0CGiFYORFEumCZaY8wU04BWXXOQPzz8KPaYQrZzFRU28yjH
	1cBAF9o8Fg4zWZJ5UKVoc9Lon4qrs9jAYpRstXOJFH52B1T3b4Z3n1oXOQ9NqOpBwzBHuuRbmAC
	XRvNkEZ1g8+mKSAMiW5IegTCGzz/KQ398gISBNv8ZK6JP+bYbXL6Z9kyrHRl1eSzDg9P/dS6DLZ
	aiVhsr5ZHHgHWFf4FVROanrz+6XlnSXq9MNMHrUF9FR/E3Ar5UogvJXB6VN6gQFLPzDZY88e8mD
	ynDGc1o9QgITYQ+HN3LA/cKW6BCtMkuzAlet8krEh7Z3z1+Ys0QA+ElgZlmXVsyjKvNLBcswk/G
	bF3Mbctw6UUb6L1nKZouyDz/YzJTsdytba9x4kNKXDN0nErQk1aNnLlz2G2ANC5L3ZQ8xG8xmAZ
	1ZD3Lhmz48Xe+3A==
X-Received: by 2002:a05:6808:308b:b0:55c:836:5950 with SMTP id 5614622812f47-57a0a91fc0dmr2909965b6e.27.1795152505746;
        Thu, 19 Nov 2026 21:28:25 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm1289912b6e.9.2026.11.19.21.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 21:28:24 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] pfkey: fix kernel stack leak in pfkey_migrate()
Date: Fri, 20 Nov 2026 13:28:14 +0800
Message-ID: <20261120052814.3686573-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

pfkey_migrate() declares struct xfrm_migrate m[XFRM_MAX_DEPTH] on the
stack without initializing it. For AF_INET endpoints
pfkey_sockaddr_extract() writes only the 4-byte a4 member, leaving
the remaining 12 bytes of each xfrm_address_t as stack residue.
xfrm_state_clone_and_setup() then memcpy()s the full 16-byte
new_daddr and new_saddr into the cloned xfrm_state, and a subsequent
XFRM_MSG_GETSA dump copies them back to userspace as-is. Each
migrated SA leaks 24 bytes of kernel stack, which can contain kernel
pointers. The same uninitialized bytes also feed the 16-byte memcmp()
in xfrm_migrate_check(), making duplicate detection unreliable.

Zero-initialize the array, as xfrm_do_migrate() in xfrm_user.c
already does.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index d215b33b7492..6d116862b20d 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2571,7 +2571,7 @@ static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
 	struct sadb_x_policy *pol;
 	struct sadb_x_ipsecrequest *rq;
 	struct xfrm_selector sel;
-	struct xfrm_migrate m[XFRM_MAX_DEPTH];
+	struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};
 	struct xfrm_kmaddress k;
 	struct net *net = sock_net(sk);
 
-- 
2.43.7

