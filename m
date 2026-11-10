Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275812;
	b=y6+CSp4FZTgq+0t32U11dp8cC7RZhQedCfRFP6n7G1gxR6yqf1w4ZebrI3wiBS7jQrq6
	 kUuk9dKzNvq7D2XKzHPzLONC6nf6tCZbEJAUZdA6bL1MoGCiE5BYvLUY2W6k5soQ0ni7I
	 PDlzcnGxq9U9ybSGkYTimuGgNn3x4GbAxaDfu53TQdDpq6Nnjv1HHa3QWoxUgI3vVW+lA
	 YdPV7nH9H0/wchpycj0lEeU+XGCAnXNaNDcf0QGv9snUxKXxEJ6dl1BwcQahNWRgEgtw6
	 eEilauxfiKptw4Dqy8Q9bJzHIV9GgPMq1VHF+6og00A93mmHzAklLFoXQN7b+5DZqOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275812;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e+tDPAgX7Jc6AnygJexRUn8hbTfpq/wN0Exo0XiOIHw=;
	b=NjoSR+rFwu2nWuMJztBrXYAJoP9iNUrHThYxOMSuXtBDm0KHfTmhcR3t1Yg8VyngvIW0
	 CpjHFVuF6C95w8bWHhfBWs1YXKK2mn79xgnyyCF93Uyb5cuCBAoOsajnScRdzzbXjm0/E
	 ZcO+n+D2hwuqvEp9ILrEJpWjYxnv/VFHAKaKh8nhbK73SqfGv196jxO2BWW3hXHfx4LNg
	 12VWPFZgujUy2xk4fgHVotnSKOdu/8puHG9hjIOJL2lUc4qfQ9r2z5zhetIv5cmssHyfW
	 GOEdEn2xKn0taRlH4+wI7oBkBYsOllrIADYC30yKzs2doW0Y2Pc/ZcIfqyfYDe1fMDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZUqTqdJF;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E6606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZUqTqdJF
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275803; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=e+tDPAgX7Jc6AnygJexRUn8hbTfpq/wN0Exo0XiOIHw=;
	b=ZUqTqdJFF/K2DrxDj/8LEwo1+h5cYaEcxGL8UYXWML+6jfuswWQg2qVZf7g/7QCWXHqAw8iEmdv49jTVfBcfdMDvUQPkJmRyJ4NGBTL5l4n02zIyYQAjkmUbezvqb9iKlcP/dJSaVI1sB1e9VmyqWGF7FDsSGSuDVZenI6LamLY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.104247|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00503485-0.000117359-0.994848;FP=4424367230260155508|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.k-SkfiF_1794275803;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-SkfiF_1794275803 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:43 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.12.y v2] apparmor: check accept index + 1 is in bounds
Date: Tue, 10 Nov 2026 09:56:42 +0800
Message-ID: <20261110015643.469506-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030614.419397-1-zhugl3@xiaopeng.com>
References: <20261109030614.419397-1-zhugl3@xiaopeng.com>
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
[ Adapted for 6.12.y: this tree predates ACCEPT_FLAG_OWNER (2e12c5f06017), and aa_lookup_fperms() here reads perms[index + 1] whenever fsuid does not match cond->uid, with no flag to narrow the check to, so every accept index gets the pair bound. ]
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
index 4642058..684a21d 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1209,6 +1209,14 @@ static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
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

