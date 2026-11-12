Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464968;
	b=jGH9Rf1jPLO0xVb4kuMF4OGtNjJreYe+VN6jW0InAr3zC0gOADo/iKTyqNLBtntfGuq5
	 RL8o6VrPGRe+2d+Fs6RI5yFRh+TMZ0HL4nbAI4M/BNKumw+gn+cV3BHClrzg7X8P+/EWV
	 MXZtgGV0lSlFN+mofeDDYe1RdZ6LwciMpBDBfuFVtI78FCYZSCQpOa52+IUTNTiyOEOFZ
	 WotKP+vLjGWjo22j4gp43WUSU8aNjF6TtMtVC5XeaDbIe7eFQ4uS3IPb8J8Xz5LrAxz5V
	 FWN31vSbQ5WGjckpoBnvTWZ7WIIat+26YTY2LK8mJqfRf6LUVzW1+V9cwELl5wE+o/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464968;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QUtPnHYlnt0R1nzUWPR+lt8Jd6d0FvQLBNzTCZroS2s=;
	b=wPhZJMP6kbdmZ8ZGDMZUdGHdP05Ne5w6mE83DCaC2tz5lIDiVmas6Gb1kejvXELxBUK/
	 ue9OI4/yFtw9n6WsEK/TGM2WgGf8kWC1ttgpvLg+l+qTiKQkWo1hzJCCLrNZwV9jaqP+G
	 HiGMBODuW+5AT/AxTFusIeusSPOitwhEUhF5ubda+FS/trBCPcwkD1Pj47a/VFE32T2RX
	 i9QvC3kYJ/7Srq/Y/xo3ZeMNNcfhI88S3NOc/4xpdepahZKpLmiRrnhGOh2SzWSxj5Eqj
	 anwn06U4f4GwpcRl3yF94EePP9FdPsYeVBbE/ideRS1LC9c92AhkqJJ2v7K57HFYZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=q53HxEfg;
	arc=none smtp.remote-ip=115.124.28.101
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E270606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E270606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=q53HxEfg
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794464958; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QUtPnHYlnt0R1nzUWPR+lt8Jd6d0FvQLBNzTCZroS2s=;
	b=q53HxEfgXbkqB5Xt/1dkVjqcUdqNq2/4cW5Z7AR/U/ByTaUQZtq3g1fCuDiq2X0QbpPhOg3YSrUSy9MUoNzNOdNB9S5wNsSjovWHup0HjfiorFz770IzdaXke8B0i9+Yey0XJ50VbbWbV955E49XIlU+/VvzHndxz030C/eMLd4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437308|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00321527-0.000134495-0.99665;FP=9043054999978446486|1|1|3|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k0FE8rr_1794464957;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k0FE8rr_1794464957 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 14:29:17 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: john.johansen@canonical.com,
	sashal@kernel.org
Subject: [PATCH 6.6.y v4] apparmor: check accept index + 1 is in bounds
Date: Thu, 12 Nov 2026 14:29:17 +0800
Message-ID: <20261112062917.663882-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111063859.496645-1-zhugl3@xiaopeng.com>
References: <20261111063859.496645-1-zhugl3@xiaopeng.com>
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

aa_lookup_fperms() returns perms[index + 1] when the current fsuid
does not match cond->uid, so such an entry consumes two slots in the
perms table.  But verify_dfa_accept_index() only checks that index is
within the perms table, so a policy whose last accept entry is reached
with a non-matching fsuid reads perms[index + 1] one entry past the
end of the table.

The perms table is allocated by unpack_perms_table() with a u16 size
read from the policy blob, so a crafted policy can place an accept
entry at index size - 1 to reach the out-of-bounds read.

Check that index + 1 is also in bounds.

Fixes: 6f442d42c0d89 ("apparmor: fix profile verification and enable it")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
[ Adapted for 6.6.y: this tree predates ACCEPT_FLAG_OWNER (2e12c5f06017), so aa_lookup_fperms() reads perms[index + 1] whenever fsuid does not match cond->uid and every accept index of a standalone file pdb gets the pair bound.  A compat-mapped policy dfa has one perms slot per state (accept[state] == state, table size == state_count) and aa_lookup_perms() never reads index + 1, and unpack_profile() aliases rules->file to a compat-mapped rules->policy when the profile has no separate file dfa, so verify_dfa_accept_index() takes a pair flag that is set only when rules->file != rules->policy.  The pair check is thus skipped whenever rules->file aliases rules->policy, including when the policy pdb supplies an explicit permission table; unlike upstream, this tree still uses aa_lookup_fperms(), which can access index + 1 on this path, so this backport does not address the aliased-policy case. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v4: pass 'rules->file != rules->policy' instead of 'true' as the pair
    argument for the file dfa call.  v3 rejected profiles that have no
    separate file dfa: unpack_profile() aliases rules->file to
    rules->policy for such profiles, and a compat-mapped policy pdb has
    one perms slot per state (size == state_count, accept[state] == state),
    so the index + 1 check failed for its last state and the profile was
    rejected at load with -EPROTO, per review.

    The pair check is now skipped whenever rules->file aliases
    rules->policy, including when the policy pdb supplies an explicit
    permission table, so this backport does not address the
    aliased-policy case: unlike upstream, this tree still uses
    aa_lookup_fperms(), which can access index + 1 on that path.  Please
    let me know whether this partial fix is acceptable as is, or whether
    the runtime side should be closed first (e.g. evaluating 2e12c5f06017
    and its dependencies for these trees).

 security/apparmor/policy_unpack.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 589b43c..2514672 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1194,13 +1194,22 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
  * verify_dfa_accept_index - verify accept indexes are in range of perms table
  * @dfa: the dfa to check accept indexes are in range
  * table_size: the permission table size the indexes should be within
+ * @pair: the accept indexes reference two slots, index and index + 1
  */
-static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
+static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size,
+				    bool pair)
 {
 	int i;
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (ACCEPT_TABLE(dfa)[i] >= table_size)
 			return false;
+		/*
+		 * Accept indexes for owner-conditional permissions come
+		 * in pairs, so the non-owner entry at index + 1 must also
+		 * be in bounds.
+		 */
+		if (pair && ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
+			return false;
 	}
 	return true;
 }
@@ -1264,15 +1273,17 @@ static int verify_profile(struct aa_profile *profile)
 	if (!rules)
 		return 0;
 
-	if (rules->file->dfa && !verify_dfa_accept_index(rules->file->dfa,
-							rules->file->size)) {
+	if (rules->file->dfa &&
+	    !verify_dfa_accept_index(rules->file->dfa, rules->file->size,
+				     rules->file != rules->policy)) {
 		audit_iface(profile, NULL, NULL,
 			    "Unpack: file Invalid named transition", NULL,
 			    -EPROTO);
 		return -EPROTO;
 	}
 	if (rules->policy->dfa &&
-	    !verify_dfa_accept_index(rules->policy->dfa, rules->policy->size)) {
+	    !verify_dfa_accept_index(rules->policy->dfa, rules->policy->size,
+				     false)) {
 		audit_iface(profile, NULL, NULL,
 			    "Unpack: policy Invalid named transition", NULL,
 			    -EPROTO);
-- 
2.43.0

