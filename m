Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379151;
	b=cWlUlvdhe3zLEGBNDKtddptNjURBXlGcQHVH20VDANRlKehmy5cYIzxTk4cEO3QlL2aY
	 XdOSyHNlak1ZdZHxcH0jeZIcJPfNuRH5ELEpqsBcSH8jSOiG7RPmMWt08/51dqu5HVhsx
	 Vo7NM3YUy4YNnUQPn50aA9Ux6tgYOPyRcpG7yhZv9R1a8UVsXFDQiJvcCrsGPLe60oCD6
	 FI/hiLp+4bXvnUBiYFhHH+AkMaCTpu1YQxmiDagLHeQrVxaDiiHhzOdeOHlbyhk33cTnu
	 9c4V1qECkOvm7uoUSPgrbdOvcANr+jctZFejyIqySkKF6c1qzWQR7Zc+e1VFoTO5P+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379151;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e108LuIQcn7vIGr70Sw7SpNueBBvXrGZxtFexmtHxhk=;
	b=yeTptcrcrpBaBh22OV9ciXFCxEeVhZHbroKYo1xL/NtQFpoUTJnPaFZs+Th7BDjId7kI
	 if7Bv99DTFjT19ohpw/WYt6bZtLJKhJpw8QcpskoVue4eevHYRsDSF8sSovt7bz3GRx4r
	 YvgBmSKUcS2Qa4GV/knjMpAHjnC8SklwRbySXIe3B/luGWzJmiO6y/vTwrsbV4f2WMKVy
	 D0A0PaRZosePQV/eMWa/zljKk61jP7lIVxcBl4//J6ZqwxlNh5KBqDii+mPod01E+MrcA
	 bq6ZU1R4GCwP9iS/kj+5mWMChH2Qromv32YRtFroCtuhcYGIAUx91XyCkUfE1UtfzsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MgLRrv6b;
	arc=none smtp.remote-ip=115.124.28.77
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EA606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F18EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MgLRrv6b
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794379141; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=e108LuIQcn7vIGr70Sw7SpNueBBvXrGZxtFexmtHxhk=;
	b=MgLRrv6bpxCVhH4MEEvTeCklpFvaxTnqn/YAiTuV+joql9lYCoPE0bjJeoZ1UCDFWVkCmJ8/CzC8bEFjZGNcxY1nKGbjfh9lrFjMeTCnu5gnQmAyhKYr8YF507KsPBg4R1jbWWFghMxitg4h5QDgPG8kyQsOpl+/iUcyKNcws2E=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07449642|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00436172-0.000129257-0.995509;FP=9040451327469620886|1|1|3|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k.b5PEu_1794379140;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k.b5PEu_1794379140 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 11 Nov 2026 14:39:00 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y v3] apparmor: check accept index + 1 is in bounds
Date: Wed, 11 Nov 2026 14:38:59 +0800
Message-ID: <20261111063859.496645-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110015643.469519-1-zhugl3@xiaopeng.com>
References: <20261110015643.469519-1-zhugl3@xiaopeng.com>
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
[ Adapted for 6.6.y: this tree predates ACCEPT_FLAG_OWNER (2e12c5f06017), so aa_lookup_fperms() reads perms[index + 1] whenever fsuid does not match cond->uid and every accept index of the file dfa gets the pair bound.  The policy dfa has one perms slot per state (accept[state] == state, table size == state_count) and aa_lookup_perms() never reads index + 1, so verify_dfa_accept_index() takes a pair flag that is set only for rules->file->dfa. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v3: limit the index + 1 bound check to the file dfa.  v2 applied
    the check to every accept index of both the file and the policy
    dfa, but the policy dfa has one perms slot per state
    (accept[state] == state, table size == state_count), so its
    last state always failed the new check and profiles with a
    policy dfa were rejected on load, per review.

 security/apparmor/policy_unpack.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 589b43c..cfc23f4 100644
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
@@ -1265,14 +1274,16 @@ static int verify_profile(struct aa_profile *profile)
 		return 0;
 
 	if (rules->file->dfa && !verify_dfa_accept_index(rules->file->dfa,
-							rules->file->size)) {
+							rules->file->size,
+							true)) {
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

