Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047282;
	b=Z8k/BVI69ugYILV2QJc3e7BwjrJs2g3nSAnciMfpbw98QxYpusCeXBGWa1n9CWlH2fFC
	 7gozCgIDCLdaf585BKQkxX+7tCMvkWMo7FsD/W2TSHJriykaLwVFyy3RYgEoXWTqNJ0J3
	 SkRV6W9T8Vjf23P+tCHl1wsWNp5vjYwajlPdqctdWUgw7IkUJRiLRQBZ2xCFFl/lU9hHS
	 8dq/CBR1cRHyAE2i23tLszgBaM9kcfi7Qa8ZM8litA9OcLhAZ9L6GieXEUrerEtc+s1yY
	 RGyT6mFsBJ1DR7TlAwZe/fDGAiwmqXeih9H5c435VYaKuxpEqjlB1rHjhAiJohZT/Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nog+CVp0Bqjb3OEJnAVFkSM50FwqZUEOorb/wTxvUiQ=;
	b=FvcMwN8cGeRtj+SR/M+wdskql3yDyi0uUDkLFoT4qwTyQhGmpgh1RitAocaIywvNBYbR
	 QBef6rRWmT7MVewD3KC+B3asItSNB17TUfiezo826adbdbVThziu1cvfXEQpw55sk7UWB
	 O/nCv4enCjG2eEl99bX8GWH9ojfwRHXug9PlGJvdHHVwNtDTlFVfFrUTWNsYprB7Hm/Qc
	 plT5y57SmtE5jZrAG1eKBKtTHq+PeUPb6uZZkr+BPrzjVsdnh2sLZb5JkOmcnuyD7Hsf/
	 zHIl1nXC8dpAKZOlg3VpoYDTZ3WSgjacce8IHpaaUgN4aXjy+tSFUdERwiQ7uHECVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xn9JBgcV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xn9JBgcV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BCC1F0089F;
	Sat,  7 Nov 2026 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047282;
	bh=nog+CVp0Bqjb3OEJnAVFkSM50FwqZUEOorb/wTxvUiQ=;
	h=From:To:Cc:Subject:Date;
	b=Xn9JBgcVzC8EECYc/kwKxVSooUavCyRW31X/1hCCGev8Ef5aYcOBT5x+xXTYUrejK
	 /5TWeKtsyXrjz6cJVMOwuCRkCREAd4CWGvt5lMT3KkgNd38zXYzITyTD12Jf4kh8qL
	 Rxn5ptaU9YcNe7+sxFmE1rUhmQcGGAM/hKelRkjrYa/RfzgR2X1iR72YbBSsKNMJfH
	 UqyieCpZS475qPPAXk5+7tDiwrDuLokOQYjU2jRlTrbzwZRLR4Via9EwZoage7d60w
	 cPLOoEoyLmWP5p5x7q5XJTxGsTDH6pWvGRqBWL+QWDuDvcNsGjf0UQ+S/QPP/Lm2V/
	 HbmyypE7tbA3Q==
From: Sasha Levin <sashal@kernel.org>
To: cenzhang@linux.microsoft.com,
	francis@akrites.dev,
	autonomouscodesecurity@microsoft.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: fix query_data() output overlapping the lookup key" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:28:00 -0500
Message-ID: <20261107052800-failed-6.12-d30844001360@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d30844001360a403a511cf24fc75ecaa6a7a7544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052800-failed-6.12-d30844001360@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d30844001360a403a511cf24fc75ecaa6a7a7544 Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Date: Mon, 12 Oct 2026 17:57:03 -0400
Subject: [PATCH] apparmor: fix query_data() output overlapping the lookup key

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
---
 security/apparmor/apparmorfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5b42140e12e87..9df06fdd894f3 100644
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
2.53.0




