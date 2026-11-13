Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604745;
	b=GEtkmTIuRUx9HX+ZgOe99KtcYTA/jRG72aA29F+T4g6f2fRPS/OiWuAzdEy2wsbgmNZA
	 2JRhwG2xaCZcUgeV3Lyni57Z0QWelo7wUm379Q9S65HTuhEsDPNjv8qtI6tikNFyzzVm6
	 xQGjhp1lvz/4LbUnyI66HnyEpl7g58lfV6ZFQENTjQxzs0aposUgyyKyfRfaSe1mcZes5
	 VQhw4NHNnHtVQ/udzOldtBpdjSzHPL6cdSbkWE10y8q+aT+IkBKP5tOKfN/8fW0r7ibFI
	 +bIqkk4WTfsvPjIIvk2dxRzIzuE75Y7gqx1ThTUbWI3tawNcGTY3knPLbK2/JwHAAgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WqMvHAmSulwCsx7vuPVQffQlN0AeXHn5ShvCQcpvhm4=;
	b=lIYoKIiCeIgVIiPvptzsleEpl2vjNCZXIDlu/2vUAasXDW1HXa2TxzQX9znEmjY56pgn
	 sgNCEvp029br4Hp7iRe4rLQB6lC0YmbJQT/MVaLAkIZxD1IbqhHpLZkwoUXeAHZEdrOZd
	 W7h3uvoeMtv/O6mitBMqzjPFiyovJQNvHISo7NdlnsmoipBNruL9rwP1TwoijK3/u9Vgj
	 q8CO11nEfJgU4Iwx0cZ+D2MBaGPvU3wv6WtY5iVieScT5DL8v3EcrWBX5hntcdWK38+rD
	 VcsFwuTYeHNEso7t62BBaU11eEpMK7C85RNrcdVRYOZl7kJc6z7ikdKlisxmGWSkDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSVzEwvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E7606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSVzEwvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E55C1F000C4;
	Fri, 13 Nov 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604745;
	bh=WqMvHAmSulwCsx7vuPVQffQlN0AeXHn5ShvCQcpvhm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSVzEwvdanAxeydZY++kfh/D5TEMdMFq0U1ejFgkVYV0+ezR/IIMHbkCsmKhTMEn1
	 fszANp+iaizxk1uglJ7WN/8TrvgaMjiSU1czGuOgCsCDmsKvUeMOV3jzbSbFiYO3xt
	 ejlmkYTG/RXCVGN9Gd/ZbwjS0EzkU0Q3l1mREUZxYJqVxE7fhp3qot9qXrGIGh0kLG
	 adDPiESHI5dchanCn4iQ/6ekwdePvB0PQbW4cyOo/sdvhcuOw9XOV0R6BZW8kQw8sh
	 VeVXj76p9XKXVHKSHpJBdCqD9OLBJDCrfmzNes1ed6S30p1kyScuoMPgUTg7P/KhS9
	 p4CjS3UtWSvSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	Francis Perron <francis@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] apparmor: fix query_data() output overlapping the lookup key
Date: Fri, 13 Nov 2026 16:19:03 -0500
Message-ID: <20261113211843.2686069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061347-failed-5.15-d30844001360@kernel.org>
References: <20261107061347-failed-5.15-d30844001360@kernel.org>
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
[ sashal: adjusted context for label critical-section helpers without needput arguments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 65b16c6f61b7d..74b85d540d41e 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -739,7 +739,7 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 static ssize_t query_data(char *buf, size_t buf_len,
 			  char *query, size_t query_len)
 {
-	char *out;
+	char *out, *keydup;
 	const char *key;
 	struct label_it i;
 	struct aa_label *label, *curr;
@@ -760,11 +760,18 @@ static ssize_t query_data(char *buf, size_t buf_len,
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
@@ -782,13 +789,14 @@ static ssize_t query_data(char *buf, size_t buf_len,
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
@@ -800,6 +808,7 @@ static ssize_t query_data(char *buf, size_t buf_len,
 		}
 	}
 	aa_put_label(label);
+	kfree(keydup);
 
 	outle32 = __cpu_to_le32(out - buf - sizeof(bytes));
 	memcpy(buf, &outle32, sizeof(outle32));
-- 
2.53.0

