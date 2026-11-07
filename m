Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049006;
	b=QaSk+qGEQAVFpbXotrILCewXsRmF2Akg2LomayODkTsWfa7G9bwpdgnirjVOVzTPve/I
	 okAwEGT8PaBA+15NlVpT8oP8m+ITPNIaWdg4ke+PsVqxdd4Q+5Jmwv1lcWrZSGpYsqP/G
	 S1oQLh0AdAiFHauZilCc8MNm9e7nyApf24KdKXLw54kJgRa5eK+2+djhjUSEYgTfudxww
	 NqIHircwLkIwp0eEZixyA4R/CXrcNtX6jnUwkq/o/ElOVjL+rIwVH8Vv0Ax4SXgDXMI9W
	 pDWTXYP89wFo7k4087hb8kyipy5GQvgZ79It9TmLbKwpFVlK0/b1UcG3J2VrcZhUXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Qvhw/fmBUQGoePEDktPTViH8qyP+u5b2QXtq3K8eAXA=;
	b=uLibWj4A6euTAu0hiUYZf97+mZoBiXrIByzYm28KUliMSQZEBA7r/VTHBY2bNZHmNBdx
	 ion7v57+6bTktfT+nrF3iVm7h0wyMpxwNKkqYprdXp4PuD2Hsvf2egLUb2ru/E3UqCswF
	 jjYGdgPRVCcTjE2R6+QwFM7K2CtE3Q0F077PumM1Ptxmd6LEOb/Mo3lVYdxpzv06L2xtF
	 Cis7AXqV+xUDVao4o8ojWaAOQgx1IUvOt3nxmXiJ1lTCRI+O0t5S5XzgqhDCvk3QW32DS
	 xN9NpZfMfvQgPNZQ/pkrDVWD8xiwejnFHSpsRBWCzaHExtsTSFkXHkrPLwYfdadoHmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A47YVuPT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A47YVuPT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C496A1F0089F;
	Sat,  7 Nov 2026 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049006;
	bh=Qvhw/fmBUQGoePEDktPTViH8qyP+u5b2QXtq3K8eAXA=;
	h=From:To:Cc:Subject:Date;
	b=A47YVuPTa1YVgvUmXCB/ldwUjRVqfasQc5NoxZ66m4XB/0ZS8RktDY5GtTJVb6wLH
	 4QLiDggmMvKzEF3/d7YHDHTpdSeSIhxGdBJTpBjCO2FY53RoJStHJP1ckb87QFeip0
	 fQse+8t+kfRKaIRpsRR1LGZ5Wdngvn3X41PGDi47usom40QHzU/44xrbOfNxCIiVWb
	 vxlGbvbQefc1GBe5vCoA2npLo3YpG/ytWXbU9D44O0BZvfEEn33jNxF/Fylja6Kit9
	 vwr7aS68ImxgemeEVZaFsVbFzyPUZt7o+t5SlsuUr4Rux9uENF9DoLtN8wqBegV3p0
	 uLJOlbEwmylgA==
From: Sasha Levin <sashal@kernel.org>
To: cenzhang@linux.microsoft.com,
	francis@akrites.dev,
	autonomouscodesecurity@microsoft.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: fix query_data() output overlapping the lookup key" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:44 -0500
Message-ID: <20261107055644-failed-6.1-d30844001360@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d30844001360a403a511cf24fc75ecaa6a7a7544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055644-failed-6.1-d30844001360@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




