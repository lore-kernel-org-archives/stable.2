Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A91E47209D;
	Mon, 12 Oct 2026 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842245; cv=none; b=mwYT0AdRlc/U9GF2Ju5scTMnLjRXQQjS2kIGe8BzKhA744NGNgwddkk/4AeNwlXPckOb3i40vE2XN/BnCMTHVwP8WIOqeSJZxquBpNFIhDKbmFod9+pzjDp+TBn5u6X7y27JemU4qU6rOrMGSQrYvZ+7sbxM3ah8kL49rNrojR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842245; c=relaxed/simple;
	bh=aCs3DO9bJi+Jg3rfsha+cbRjn79iH0l7DpIL3THq6Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ixpvu6qsY7kYqaWpgt6cNLmlhywcmzNKQTrg2ytUlCzqYZn0ki1OjBoiKaYgXfqwqyDPe4QdDtsV98eQ8Q3c+3uZz5WBF1BLLTT0ehKVkguD0mt4dWtwrS8dntb1LMEgNlYDNY3erPpBel+nRvXvY3DKLQ+VvZiT3QXZLiAr+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YNLD/nl7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YNLD/nl7"
Received: from mac.lan (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5290920B7166;
	Mon, 12 Oct 2026 14:57:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5290920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791842235;
	bh=sAcevL3agJ7NVCdbTZ35FN4zIGdW9XvO0Fip6lIwkuE=;
	h=From:To:Cc:Subject:Date:From;
	b=YNLD/nl7Nl9aac/wgHGsxEwCTHbK4NfaG+EIihCqjxHA0pRMtj8LubdkJt7blMiNi
	 oO1E/1/oJMew/ClnbW3UbYiJmyRMlYo9vHm58m6wQgS4mILiV99V2mpr4iCNpQEn1Y
	 KKabXWcXmggR+SBILssE118VpAwqhrK+cinN+7gc=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Francis Perron <francis@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH] apparmor: fix query_data() output overlapping the lookup key
Date: Mon, 12 Oct 2026 17:57:03 -0400
Message-ID: <20261012215703.30592-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 security/apparmor/apparmorfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5b42140e12e8..9df06fdd894f 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -919,7 +919,7 @@ static void profile_query_cb(const struct aa_profile *profile,
 static ssize_t query_data(char *buf, size_t buf_len,
 			  char *query, size_t query_len)
 {
-	char *out;
+	char *out, *keydup;
 	const char *key;
 	struct label_it i;
 	struct aa_label *label, *curr;
@@ -941,11 +941,18 @@ static ssize_t query_data(char *buf, size_t buf_len,
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
@@ -963,13 +970,14 @@ static ssize_t query_data(char *buf, size_t buf_len,
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
@@ -981,6 +989,7 @@ static ssize_t query_data(char *buf, size_t buf_len,
 		}
 	}
 	aa_put_label(label);
+	kfree(keydup);
 
 	outle32 = __cpu_to_le32(out - buf - sizeof(bytes));
 	memcpy(buf, &outle32, sizeof(outle32));
-- 
2.55.0

