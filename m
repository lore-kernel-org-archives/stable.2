Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046561;
	b=VDjlDZAm2iZyw35Va3c+6vBKvR6ztSyVepukcf2kW3KKAc23iPJqfFkS1Zo6UkwhEI0S
	 Rafv9kIDsES7p4Unz4TtCk7RDabP81m4kaYehtRsFPvgmvPsnicxoFZh+AbTTUEPHQtGq
	 ap9B83VW47UPoEkVSXavB8RFsGy9mss/y7opttPGSweDyaZ/FdFzyu65S9Xx8epTyh6Bt
	 0GE8gzrGpWCq0rutu8EBxBU58ik1qNzNTAq8TWd6I77Rc4RllhPPYh5HA3BMzuAk+6/K8
	 DvVvj86FV0+h+2W+YP+aaolt093LqWixZs8J+W9co+7j+6zpexwUl1ctdqmHSmurWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M9CBZmBCw1N5TUSi5Qh4bR170wdT6zZEFjtdbxyuGNQ=;
	b=sZoiQkxaB8i9eK6KJ5OZ8dFv8TFqI22r8Lk3BnF/+YLloDDmUWLc1K8S67mzKJJBJ4L0
	 jUNDnq1I4zo7pnVyRrpbYK4TyatSKZpQSK1ShEkSMLU+2EdKRFZSYXSOFeNAHxNb2V762
	 Ypf3EYOOLJnQtKte6KpVpskm3tIrBttsM4nVuqfyV5vjb0KreXo8JMJV1geBj5jD86Cek
	 DTam1ZhmoEJKQhgtjta0ZVckA6OUnt9wUR2aiO6hv1yeY7fx5YgsL0NX4UoWkbE1zhuao
	 jGBTumfOBr8H9V5gGvRB1jkGiVDd+MRo5KfpGCOGFB59vEaelk5a76LEdPP+2gNWrUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRIGx9q0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C88606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRIGx9q0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A711F0089F;
	Sat,  7 Nov 2026 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046561;
	bh=M9CBZmBCw1N5TUSi5Qh4bR170wdT6zZEFjtdbxyuGNQ=;
	h=From:To:Cc:Subject:Date;
	b=cRIGx9q00AQPMDxgEmwytJNAxoE0G0lC71st6+NYW8GlkaHCBLGB8mwkv7FGVHM+s
	 F2EmjS7F9oEf4/flJ1Zs8u0P8CVQQyZM1a8FHsQ3cId63VnfrWGpBobo4BBvXZip0W
	 whXoc0GGB0mbBuk7h23vJcA3WSIA0r6gF59ypaEFPoqIvT4UyOeC5sn1rKUfT3yWCc
	 6w1o4KpiwQWoq7U9wJ6CZFv+MTW68vOWL8nMlm/W2U4CdaqGXs1apYDqlqnZxOUowy
	 CC97xroSZbbzvAZk+wXlX1WzWr7CwSMk3bIf6cxhgjQA+ifugpGCshJcOFQcc+WI5f
	 BUC3mn+1iC3pA==
From: Sasha Levin <sashal@kernel.org>
To: cenzhang@linux.microsoft.com,
	francis@akrites.dev,
	autonomouscodesecurity@microsoft.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: fix query_data() output overlapping the lookup key" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:59 -0500
Message-ID: <20261107051559-failed-6.18-d30844001360@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d30844001360a403a511cf24fc75ecaa6a7a7544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051559-failed-6.18-d30844001360@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




