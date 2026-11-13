Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604593;
	b=KkPzc6fB/NGzEu9jxdYWYON84q0CLHpXJVJLWWbvA893d1bYqC6AC0dfeGyUGieR97Cu
	 bzqlXUPSiF2+b8UojYDC4qi23Q3Y6AKFrS7PR+RHbs41WSigFD98q/aWVWvXOE9rRoZvd
	 O83mB/kyNMjfl//DslcausSGf9w/RMXixnxI24phc5OE7rgs+4sCvRXL43HfNs18DN64X
	 sLA4AKrv9M3PVv6UL4nYsrufOYQPfbg37NhAN587uDiQjnT7uH6Ipkwkq2jYr6DbQ1rg+
	 hnXS7DCuMYD7WckLLyT74jjhsRMkyG5bpZmBvW7yRXC9rHZ17zl+JyhTopZoz0Fv55A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=90W9Qr//iASsQNAQQnw1/5fC4nTcdf0BN6PdDoZSMcA=;
	b=qIllbcM/ielOqBTaSrjCQ8em2O3TnXHTD+qHaCGkDBF7lo/PMu31LIYh9ZBCCM2uNUQz
	 6z8IC60jnZIE+MhJou/SOXISKOusOe86A8u0pIFpzTIkwBbKyhpQQ4pXx6pa1A9NPNmkC
	 xn1NM0zBPVSJ+K5COZ9hwO+Z4itaRrOglu6y0aVw2Q+9knpX1Zskh7nEFWym7ebiYb/aP
	 fm14QRxARxmGVCPajDN0ZF3OsEIvqXsYWLQg0/H0ladtYfmGQtkicZTskA+I08DcfNgkG
	 2gLqhsQ0hmSWmW4/Gr1+ftW3SjVT7+cFTjVtarS524qe9pP5qEMpiIT9hPLTVg/ww+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRYwbQxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3242606A338
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRYwbQxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730531F000C5;
	Fri, 13 Nov 2026 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604593;
	bh=90W9Qr//iASsQNAQQnw1/5fC4nTcdf0BN6PdDoZSMcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRYwbQxtK52ovklHmZymXmOExKnIZiUsoJ/Pdj+b9j3z0pPwgSAIZQiIPz8uBm5wS
	 zylxudc5tlPPeocF+fc5XW2DsxJIGP+d/DiaTX40MaZLtt9JUZeOi5JqBMJnrSnCY6
	 Ncnn7Tj3lmD4snS9ZHu+wn8oKXtQY/ZxkgcU9QXsy/kStnJeiPwYFgw3+bFaniVSj5
	 mVgBA6ifvAdSE5/GjQjX/b/8DwiekWOCGXxLsc9OghzmS6uFzPBcsuuJ+hO7QTusZL
	 17gi8NpRPHgYXSl40MIG6tZopKrsnnS8NqVZHiN8JifXnBlnnH3U+ft/UgAU5Qpda6
	 25yz3FdNX6O2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	Francis Perron <francis@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] apparmor: fix query_data() output overlapping the lookup key
Date: Fri, 13 Nov 2026 16:16:31 -0500
Message-ID: <20261113211613.2682472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055644-failed-6.1-d30844001360@kernel.org>
References: <20261107055644-failed-6.1-d30844001360@kernel.org>
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
[ sashal: adjusted context for label critical-section helpers without the needput argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 1476517ddef11..c92e9517a02c0 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -743,7 +743,7 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 static ssize_t query_data(char *buf, size_t buf_len,
 			  char *query, size_t query_len)
 {
-	char *out;
+	char *out, *keydup;
 	const char *key;
 	struct label_it i;
 	struct aa_label *label, *curr;
@@ -764,11 +764,18 @@ static ssize_t query_data(char *buf, size_t buf_len,
 	if (buf_len < sizeof(bytes) + sizeof(blocks))
 		return -EINVAL; /* not enough space */
 
+	/* buf overlaps query, keep a copy of the key for the later lookups */
+	keydup = kstrdup(key, GFP_KERNEL);
+	if (!keydup)
+		return -ENOMEM;
+
 	curr = begin_current_label_crit_section();
 	label = aa_label_parse(curr, query, GFP_KERNEL, false, false);
 	end_current_label_crit_section(curr);
-	if (IS_ERR(label))
+	if (IS_ERR(label)) {
+		kfree(keydup);
 		return PTR_ERR(label);
+	}
 
 	/* We are going to leave space for two numbers. The first is the total
 	 * number of bytes we are writing after the first number. This is so
@@ -786,13 +793,14 @@ static ssize_t query_data(char *buf, size_t buf_len,
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
@@ -804,6 +812,7 @@ static ssize_t query_data(char *buf, size_t buf_len,
 		}
 	}
 	aa_put_label(label);
+	kfree(keydup);
 
 	outle32 = __cpu_to_le32(out - buf - sizeof(bytes));
 	memcpy(buf, &outle32, sizeof(outle32));
-- 
2.53.0

