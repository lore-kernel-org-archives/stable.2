Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193585;
	b=hgHIDZkxCSEc005JJoDu4ppT9tmK6vGPVZhDHsMZrXeGmHw/l7Rd/zoePnvHwIYoOpXP
	 g0a6mFJznffQILrU3kZ/iU8EtIKC2Sq3MD/r24D2asas46bv59iv2BaZ1vcLqNGggrfx3
	 V3kio7sfGILF7KjGesumBTVFXbr9q8PCU1S+SQqF2ntv/RLqoo2Hc71xcPwq/76d2ejQq
	 wH3DOKsrBZ3pyWdUj0R23UFrV3DSQz3yMvau/zvBG4s/cSQJzihXRK+pME7rusCPfY2VY
	 ha/b7xf4HhUsAnKtlvJlOF0rMVmGZduLS/iuv6HwFxPGBQFvFy7HV3wirmtj01hJKVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193585;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oE+pfedSZ3GW1yW3O4bceNqbVjctFTYPo2SmzMUWU9A=;
	b=tJ8WEOyI699iPwQqOQP2O/FiJZGps+YJM1MfYUCeMZTskyWhPFmlYGfL/GXznI7swM9Q
	 7DzpjQBlNEPqQtlLBPa1cw5LKE4iRW2FAB/oOXrU8PFuUtCyFoqmBT/P0hrqVbdpO3d0A
	 NcEjWbr9lRhEXyxkiSBgLadwzuZX83RCeQ7cN04n9zEdY7EH4oy+ekumehcZrWnvKbEju
	 wFO9IJJBQJu2A8ZrEcyOfqTCPDib3YQx8tSx7U4grxZtYGfqVV38r5Kt8ak/W1LO5ctxp
	 OjnRara6EDvTaX/5YozNwDAz+EflhYd8awwmge/BpUWYAJFBZyNbS1mg6Shsjpli1Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=O0oQ+iJx;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442BF606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 442BF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=O0oQ+iJx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193575; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oE+pfedSZ3GW1yW3O4bceNqbVjctFTYPo2SmzMUWU9A=;
	b=O0oQ+iJxK+5F4Ga+z4EyN1z7f9miSlinJmgpwNopNS276Ko3KYvgP3TrKeLieMsCg7zn0qfP1MmE9m8/a+sEKIklTDQwcEoeSSsTa7IaGVqWwj4ST/g8Cvtzq0XIMzvJCUpzxsB5ih2OLAGFgb3u/DxF1zBSblkFEIVbm4xQz3k=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08280249|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00323688-0.00020055-0.996563;FP=4424648679000448758|2|1|2|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.jzhB24W_1794193575;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzhB24W_1794193575 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:15 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.12.y] apparmor: check accept index + 1 is in bounds
Date: Mon,  9 Nov 2026 11:06:14 +0800
Message-ID: <20261109030614.419397-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107052758-failed-6.12-afe5d5a74739@kernel.org>
References: <20261107052758-failed-6.12-afe5d5a74739@kernel.org>
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

[ Upstream commit afe5d5a747393cb3d00795db31d7fce5108a766a ]

aa_lookup_condperms() returns perms[index + 1] when an accept entry has
ACCEPT_FLAG_OWNER set and the subject uid does not match the file uid,
so such an entry consumes two slots in the perms table.  But
verify_dfa_accept_index() only checks that index is within the perms
table, so a policy that sets the owner flag on the last entry is
accepted, and the runtime lookup then reads perms[index + 1] one entry
past the end of the table.

The perms table is allocated by unpack_perms_table() with a u16 size
read from the policy blob, so a crafted policy can place the owner flag
at index size - 1 to reach the out-of-bounds read.

Check that index + 1 is also in bounds when the owner flag is set.

Fixes: 6f442d42c0d89 ("apparmor: fix profile verification and enable it")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
[ Adapted for 6.12.y: verify_dfa_accept_index() takes a non-const dfa here. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 security/apparmor/policy_unpack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 4642058..ffff8d8 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1209,6 +1209,15 @@ static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (ACCEPT_TABLE(dfa)[i] >= table_size)
 			return false;
+			/*
+			 * Accept indexes for owner-conditional permissions come in
+			 * pairs, so the non-owner entry at index + 1 must also be
+			 * in bounds.
+			 */
+			if (dfa->tables[YYTD_ID_ACCEPT2] &&
+			    (ACCEPT_TABLE2(dfa)[i] & ACCEPT_FLAG_OWNER) &&
+			    ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
+				return false;
 	}
 	return true;
 }
-- 
2.43.0

