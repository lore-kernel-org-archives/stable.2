Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048913;
	b=ODrI5ynjWLNAX1KIxuoDYwR8tA9tn8JJnUZ6/kI4MgXug1F6wTY39BZ7lxpXpicsEUfv
	 Eu2G4tYWOXDRvMS681H6J6h3FYeC4/Ma0+VFleN2FyljHXVD6tvGkds40nsTNavUFM//W
	 X7uyuQEj6DdOPfIbbcUa6lJj2TyDv8hxB1LapLUqF7l6HSY4cBJA9vM8y9KYdw2a4cqx0
	 fJ7/XcheXew3c9tO//YhgNwa4ZDBbM/LhNT/OhPCm0fGyobpgLz+T68LzG2BaNpF5hpzV
	 AwDVYdfxKIAyyhS1yFi6do2MLUaJpf58X0kxcRlOSHqVy8kWe4xZr+jdGMBokSI42Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=chXUY85yae0SKSJ2DHrjniaLMgqhRvQm3tjwgz1Yl3o=;
	b=V5au4xLm0OEOATLD3JxhH1El35E3dYcoRct4ChfyGRPB8+1B7XScj5rxYRHcDRKcoOph
	 mR9v6NYjl5AzU1ZOhPAg81JplzHp+QleD/4U3hU0stUp2AA9Hc8oMun+flgFYsQfWvnMa
	 TA20wf7jTWe+ifx/PNQkdonXphPJrpDXcI/4sOzYifwpwFQExrCvJR0aAMcb3dg0YbNCI
	 Q0ArqSRq52uKj5ichQPQDDzLFULxWGIK7uXMrpJLDwGUpcC4aRSM+9nr9bOrv5N4fr+uy
	 KZ9zxlKgCeTKaUA78za9KFIENwwvqEzD+tQ1oqqpgATyUtEGPWJIm1WYVljZs8NJTLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W4/5wxfg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F70606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4/5wxfg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D3C1F008A1;
	Sat,  7 Nov 2026 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048912;
	bh=chXUY85yae0SKSJ2DHrjniaLMgqhRvQm3tjwgz1Yl3o=;
	h=From:To:Cc:Subject:Date;
	b=W4/5wxfgsAEKjznKx1WcvtGR1SnxaTSSeih4HYo28mahPF0r50uQVymyn/j0PBxC6
	 O2y0Luotk+sskcKe6YR+KXChWBwZdW6l78kMH0OETXyVdhcnjJwn/C07qyZSdETk18
	 WLNGzNumbL/ekwUD71vUS0FWGVNs77Ac4NJJRzhfATjKuJ4CcC2gwHLv+Q/v/wDPVj
	 gsww9aZupHlT2AnPOzAoJt6U+Fz3Q3iFY5v1pOAvA5TlXPT3N+1BXpMxu7GASfeqvq
	 pT2AwjiNKTlbX7Zieq2VlK9X6mpTH/Wwg5EklAe0zBfFuwml8OQXo4yCZaKgfHqZfl
	 bOtWhcjcOL6cw==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:10 -0500
Message-ID: <20261107055510-failed-6.1-9c1d14d3b66b@kernel.org>
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
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055510-failed-6.1-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52 Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Thu, 10 Sep 2026 11:00:35 +0800
Subject: [PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then copies the data into a single folio
with no length check, so a malicious or buggy MDS returning more
inline data than the folio can hold writes past its end.

Clamp the length to folio_size() so both callers, handle_cap_grant()
and fill_inode(), are covered.

Cc: stable@vger.kernel.org
Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ae6aa9db5eb24..86fe0e76cdf07 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2245,6 +2245,12 @@ void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
 	      ceph_vinop(inode), len, locked_folio);
 
+	if (len > folio_size(folio)) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+					   len);
+		len = folio_size(folio);
+	}
+
 	if (len > 0)
 		memcpy_to_folio(folio, 0, data, len);
 
-- 
2.53.0




