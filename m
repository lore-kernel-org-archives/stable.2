Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603715;
	b=WdY2uEP7HzCXtMvY24Kta5sisBPwueu/vMGcT7TdTGif8uuEfJG394SJaef1cuvp3Jq4
	 fFIitlLp9bM4LqjnTAi2uZF04oVlhf2bSrvJDENJUV7/OA76HrewfSevRFWCd49gBZFwW
	 2VjgOe47SYD0YvCwcpHJBA7RO9b/BZEgT2VtJ3ZCmSIH+08ZrpUoty8jgrvFvQT0b4qb4
	 FnorAFkFSRu3p9NMtTF5X5Ty5Z3k2pL4ibLdXJKd3eCoPE3Ybj3F+O8Kb80YqhRvNRiaz
	 eDL9w71QIRzczB4cqFMWgYq9EteQHwQ2rXgwIC7/il10lRCQPQL2gY2csK1FYRlE9QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603715;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a07pJz5ZIBuY6WuW+x0I9vpqN5yr0zh02iIRpUVghUY=;
	b=YaHC8c72lsMz81/ZNAtep1zVQ8rtf4lTv4EVm6/h3tJtL/F//gDhLnQScKn7Azt7B9ko
	 78bEMRGKIS7p6EbSUY4OKGOPYvdII4ZGmr0Otu9xehzLmvN1BH6qj9ZQDNdQ5/Q6ZYQwL
	 10UP5qDN7ue63b09nekci3E0DGlLMVZEntrDAzJEl6IHt2JEDgHmBznapUWwEAWYKXKpd
	 hbjAsMvPFbQlr0NiyE6T4IvDUpmNSP3NnJs7vutZNiVhnS1mx85bEH5jp1AwV4UHaAHL5
	 k+JaAcXnOkQMGQCqSIjzUqW7TLIT161JUXb+ML27mFF6hCP8LmAo1DnveXtV1b79zPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWwE7VJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6358606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWwE7VJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15AD1F000C6;
	Fri, 13 Nov 2026 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603715;
	bh=a07pJz5ZIBuY6WuW+x0I9vpqN5yr0zh02iIRpUVghUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWwE7VJPYBxoXLLbQ1Ontomy8c+9f7QLFKHjbBkjg00OLQZw6Zj5U2Qr/vFbUEZvM
	 KnpTGOxPlnFKFQlfbll5M2iFSN2kiMVV4oFQynY8I4sUV1hbpz3g+TVMXTvNpwKk3Y
	 nfbEqklTYoYpL/sM7841/D+dsRbL4icnPUZ2oU/8MUMWrCCffIUuq/+K+I8c6ZpSqx
	 T9HO4k8zr846tYrmSksPO2XFHjEl6D9MV0UZw/ZpLbMY7vBor7hykebL+NgbV2Gonc
	 4DLzJZ/RNETC16un/6+eW/75gkFj0yrl9z+fD+S2ZMq9lrx8lhjZOoTih22Lbv2w1V
	 kMq+YSrZMLHlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	Francis Perron <francis@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] apparmor: fix query_data() output overlapping the lookup key
Date: Fri, 13 Nov 2026 16:01:53 -0500
Message-ID: <20261113205818.2480014-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113205818.2480014-1-sashal@kernel.org>
References: <20261107051559-failed-6.18-d30844001360@kernel.org>
 <20261113205818.2480014-1-sashal@kernel.org>
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

From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>

[ Upstream commit d30844001360a403a511cf24fc75ecaa6a7a7544 ]

In query_data(), buf and query point into the same multi_transaction
buffer: buf at the start, query a few bytes in, and the lookup key
right after the label string that query points to. Reusing the buffer
is by design and is safe as long as the query is fully parsed before
buf is written to, but the key is not: it is dereferenced on every
iteration of label_for_each_confined(), after output has already been
written. So when the label has more than one profile with a data
table, the data of the first matching profile is written to buf while
the key is still needed, and overwrites it if the data is large enough.
The later lookups then run on a corrupted key. Besides, if the data has
no NUL byte from the key's position to the end of the allocation,
strhash() -> strlen() -> jhash() reads past the 4096-byte slab object,
triggering an out-of-bound read:

  BUG: KASAN: slab-out-of-bounds in jhash+0x595/0x5e0
  Read of size 1 at addr ff1100001159d000 by task exploit/155
  CPU: 0 UID: 1000 PID: 155 Comm: exploit Not tainted 7.3.0-rc7 #1
  Call Trace:
   jhash+0x595/0x5e0
   aa_write_access+0x880/0x1400
   vfs_write+0x26f/0xd20
   ksys_write+0x115/0x210

Writing to the .access file is unprivileged (0666), but triggering this
requires loaded profiles that carry a data table, which needs
CAP_MAC_ADMIN and is not the case on default distribution policies.

Fix by copying the key with kstrdup() before writing any output to buf,
so the key stays valid across all loop iterations regardless of what
gets written to the overlapping buffer.

Fixes: 317d9a054e1c ("apparmor: update query interface to support label queries")
Cc: stable@vger.kernel.org # v4.13+
Cc: Francis Perron <francis@akrites.dev>
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 765812092cacd..48711167956eb 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -755,7 +755,7 @@ static void profile_query_cb(const struct aa_profile *profile,
 static ssize_t query_data(char *buf, size_t buf_len,
 			  char *query, size_t query_len)
 {
-	char *out;
+	char *out, *keydup;
 	const char *key;
 	struct label_it i;
 	struct aa_label *label, *curr;
@@ -777,11 +777,18 @@ static ssize_t query_data(char *buf, size_t buf_len,
 	if (buf_len < sizeof(bytes) + sizeof(blocks))
 		return -EINVAL; /* not enough space */
 
+	/* buf overlaps query, keep a copy of the key for the later lookups */
+	keydup = kstrdup(key, GFP_KERNEL);
+	if (!keydup)
+		return -ENOMEM;
+
 	curr = begin_current_label_crit_section(&needput);
 	label = aa_label_parse(curr, query, GFP_KERNEL, false, false);
 	end_current_label_crit_section(curr, needput);
-	if (IS_ERR(label))
+	if (IS_ERR(label)) {
+		kfree(keydup);
 		return PTR_ERR(label);
+	}
 
 	/* We are going to leave space for two numbers. The first is the total
 	 * number of bytes we are writing after the first number. This is so
@@ -799,13 +806,14 @@ static ssize_t query_data(char *buf, size_t buf_len,
 		if (!profile->data)
 			continue;
 
-		data = rhashtable_lookup_fast(profile->data, &key,
+		data = rhashtable_lookup_fast(profile->data, &keydup,
 					      profile->data->p);
 
 		if (data) {
 			if (out + sizeof(outle32) + data->size > buf +
 			    buf_len) {
 				aa_put_label(label);
+				kfree(keydup);
 				return -EINVAL; /* not enough space */
 			}
 			outle32 = __cpu_to_le32(data->size);
@@ -817,6 +825,7 @@ static ssize_t query_data(char *buf, size_t buf_len,
 		}
 	}
 	aa_put_label(label);
+	kfree(keydup);
 
 	outle32 = __cpu_to_le32(out - buf - sizeof(bytes));
 	memcpy(buf, &outle32, sizeof(outle32));
-- 
2.53.0

