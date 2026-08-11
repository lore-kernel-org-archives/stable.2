Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F540BCAD
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485109; cv=none; b=bihztR2pl/UBk9Iu5rf/7crj0RCywFWhyUJ8LzpOyaIGOCtQNe+In9ZUhjTok3WJNthaF2CPibC7zEPH+QAGW9HB5QpPWiN3LG+xFEjhHBORwWvmpVIVgxbSXgXR4ghw3fbSsceWfEAjM6p8Ac+jlxDVRPuuueOtXYpZrrqem28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485109; c=relaxed/simple;
	bh=Azo2sCiZllD4H75gWaBzm5I3JqLlnW6xlX7nRXQnSss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXW7uax1u/Yymr8HWwwOpf4ucs/Dg9hbMPgSN8+a2+HxBpp3eNHXpS7EDRjK74oPQ2oW7INnvDj2Kw2pyrNikvw9BsEejCFCn3qiDimK3OzhqD7mVBhN8J6KU4SCz7wigU1X6vQVLrGf1KuinBY/UhhU74DFIu1mr2eWjhHeP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARAlwyWV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARAlwyWV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc61541f8cso20344885ad.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786485108; x=1787089908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=ARAlwyWVjZdIFHSvnn/x+IxioldlQu+BtSBh2YfKlzS0y/UnVgGgJ0qk2JK1UOIU9H
         H09haNFx2h+xVQivMsq/tA4iMdru9CfA8AHaqZgCvIFundwiezTam+o1+e9ipYMvEcht
         IT7VSYujcvPENfuuARPSUaE/T9Vv2p18MO4hOBgymn9Fg8uTPq9VZHiqPS9L4UQGTu/t
         NvZ3qaBkJ6RewDtejfk3ZWI2PwTeGwYev3x107go8HYT15pDz076+bXXzeRbsKlonlIH
         Bsps89syqT2YD7myxEwrvHa4IHoCg6dMnE5P6vo6MK9hPv6YnBOkRAbJZlbOT8zc6UJ7
         zMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485108; x=1787089908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=a0IkobRSxvNFjbUsFDnlVVroq54UMUW5nibNDDxw87/0BJ6gt8hf4Dgq4C+se5DZ9K
         XFUIdnCXV0OPHUqg2PzljGWyPKKKcJPA/K/lE1NbDeJw/v7oiWa5axPQC8ynCFPSzVZo
         ZudVKs9J7DcimhMtwLUV1G7cPsHUNHbOFI2dPBgepmGC3zcMD6MNI0bTiJy3Q7+ie/ja
         FKuea0GX2UwAcNmNL6d/B05Q8jUXBGb2UTUVHK/ixMl7woJlWxXBdHg6B+dN8DrjOFqZ
         RTDS82vz6xLgg2fIikjMqLH7gv2OjyJYtWU1cU2MC1YKG731qVPtFPDv86Nz1WhwBw1d
         BRhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpcwupj67qa7UinZkoBzCVKpSWpfTwFY0Va/Ts7lOt4l8kgCLznezUAk9mv4Th0OBd4c9deulU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlq0xztvz9RtIuGJns/IOdXtm67XajsSRivo1M+rUQArUnLsO
	WW3g7WdeIj/bMu7dGFIpl7W/tIxgZVh4VjKxE2BUe5hAzRd3jZSoPNfe
X-Gm-Gg: AR+sD10f01xrFyNHYEsMt9MPAv3nD7v+j6RAMThgv3R7CqRT0ZAZAg0X6aOPQIsbOgb
	M7Pf8mNuzp6Bw4JbUgNfj2MbxOkWk+rn7w1GCf+V0928NBpfJhxyvV0h8tzsaIkOO+lWGxC1hS6
	5LkVhfYhm8rOZsdJAJcC/lSSevhmRjF/NmrkVOfjpEuGNwBVEpzgcNOwwu8cN35YN3YbznAxcs7
	P4iYqu8s5UJmxbe4d/QuZalzw83rw598PKKIIWdIxMbY6HdAJ23mb1QBj0xhNBWGNFb4VcZhAIe
	AoTl4QHllDBGxQ11TF/ANfbn6vuUlkeqTsdSotaafEKA66pk9P/WwEsCQ6OcenQDY3ZkiIeYMrO
	cpQ7xPqaTbpzbdld1Nmx2as4JhIQOq6378ENpsHasHmEo0eSUzojFcArQbHQo1B7kip8/Tdkz1W
	saoFPfLToKhdmnCcD+i8517S40RTK2IhkxiNsDM+b9W/Jc/ZVAHtRf7S+1OnANrapemP7KPEivA
	EhsGLzfGW6J+xZ5pmFcDlVhyN4U5herPAE5L7rGN3+VZmI=
X-Received: by 2002:a17:90b:3810:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-392f3f7b5e3mr1932237a91.9.1786485107720;
        Tue, 11 Aug 2026 14:51:47 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.202.115.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141245a9f70sm3672334c88.15.2026.08.11.14.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:51:47 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	security@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp] mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction
Date: Wed, 12 Aug 2026 03:21:35 +0530
Message-ID: <20260811215135.87756-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() restores remote_nonce, local_nonce,
backup, join_id, token and msk from the saved cookie entry when rebuilding
the request socket for a MP_JOIN 4th-ACK handled under SYN cookies, but it
does not restore local_id, even though the SYN path saved it.
subflow_ulp_clone() then reads that uninitialized field and stores it as
the joined subflow's address-ID. Because the request-sock slab is
SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the value is the stale
byte of a previously freed request socket, which an off-path peer can
influence by sending concurrent MP_JOIN SYNs. This corrupts the path
manager's id-based subflow bookkeeping for the connection.

Restore subflow_req->local_id from the cookie entry, as done for the other
fields.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..b5cac5701 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -118,6 +118,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
-- 
2.53.0

