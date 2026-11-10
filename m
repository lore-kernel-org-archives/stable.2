Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275812;
	b=fAmJZR30KhLshfzZ+/AtAqVqAcJa38EEpnc7dFB/RqpBWm4EEX2jJ7lv8H+GCVINU1fk
	 8PiA8aXTSFsjGSAh112kuoxHjpQioEq3gx+A3z8BsPNx25GZG758XZdBRioF7EaaOqH01
	 0otiF8JFEo1xH5Cq22ic0kMUT+UxR0nkGf5zFZp/fbXhVFjzVDXulrPfZDKyopc7cuHTq
	 I5zKGcDWnAbq96qX55xrtA+Aoj19bE1/OgugyOM2C3xatOHWEm7qWrqZKV3jOiLWR6ca9
	 ixEt4/HvkF2dqnAy0Kihh0ilp9c1slBVv6NFGwYa/QAXCTzhY7Y/dnq1Z2ko58yB+ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275812;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5oDTq2OfUlfoRI1bbJGNzuKYrNtXbaS/uqrQjxiFdjM=;
	b=vXDURTVDyqIVV+hTGcajzPcctHD8opcCB34sZOt4C57urJCkq2z/weYb2O8/Mx8lAHiQ
	 R0QbQ1ai94CZxrwjy9twLvD2uGcART+NsERJBV9SxnetUlW+pk8pUZT7g0DUhGufm/0Z+
	 hRRUt7CLZrduCOteCmw9v2haIS4G2o1INdhjkahc+3T3u/ixXkCUP+iDJ3cJAJ9KFwj+2
	 gcKt6KxoWtwBdM80r3TBQokianytSZ4xNV/s5tgj6Tu4WNO+DHhaWd2RLVxXTxGexnsFp
	 EUhNfui/oKhImoNYRjJuFwgO4iyqB/FtuYK5vTLii499vNASk0q/3OxbJP9EIW+mYZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IKaxsMZD;
	arc=none smtp.remote-ip=115.124.28.122
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AD60A260A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80AD60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IKaxsMZD
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275804; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5oDTq2OfUlfoRI1bbJGNzuKYrNtXbaS/uqrQjxiFdjM=;
	b=IKaxsMZDmbGZ3TLNAO48Fd4TnxziYe7aOZD+yXwdba1idamEIH6Wu9DvT6c0mzDaz8/bhrPxb3YdeTLZB7gz/o4LAlrID0mi/Cmrwik3QiKKDhqBCcZ7w/iExLgG2dTBcfRT0PS3KHX0/Jd6IHOYNMYHb4srYNkAdfq4qHoW+qA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1056134|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00517068-0.000127727-0.994702;FP=4424367230260155508|1|1|2|0|-1|-1|-1;HT=maildocker-contentspam033037034254;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.k-WC2Kc_1794275803;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-WC2Kc_1794275803 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:44 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.6.y v2] apparmor: check accept index + 1 is in bounds
Date: Tue, 10 Nov 2026 09:56:43 +0800
Message-ID: <20261110015643.469519-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030616.419429-1-zhugl3@xiaopeng.com>
References: <20261109030616.419429-1-zhugl3@xiaopeng.com>
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
[ Adapted for 6.6.y: this tree predates ACCEPT_FLAG_OWNER (2e12c5f06017), and aa_lookup_fperms() here reads perms[index + 1] whenever fsuid does not match cond->uid, with no flag to narrow the check to, so every accept index gets the pair bound. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: drop the ACCEPT_FLAG_OWNER reference (absent here -
    2e12c5f06017 is not in this tree, so it broke the build)
    and check index + 1 unconditionally: aa_lookup_fperms()
    in this tree reads perms[index + 1] whenever fsuid does
    not match cond->uid, with no flag to narrow the check
    to, per review.

 security/apparmor/policy_unpack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 589b43c..b033a3f 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1201,6 +1201,14 @@ static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (ACCEPT_TABLE(dfa)[i] >= table_size)
 			return false;
+			/*
+			 * Conditional permission entries consume two slots:
+			 * aa_lookup_fperms() reads perms[index] when fsuid matches
+			 * cond->uid and perms[index + 1] otherwise, so index + 1
+			 * must also be in bounds.
+			 */
+			if (ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
+				return false;
 	}
 	return true;
 }
-- 
2.43.0

