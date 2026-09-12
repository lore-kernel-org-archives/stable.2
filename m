Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F93ED5C9
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246744; cv=none; b=S/2rB/cIFvLixo9r2Q+h7LR04N7lYo4QmuOh+t/hmWQhcoX0Jf+BgjhvhVMW+5DVvGtlk/E7M9BkAqxsr+xGg+y+sfmorXA6MaFIXZ+stN8152XpzIGW6sReJTjxjC1yb0HVN6Xe44YBGLQ4zkrsOuxn56nZ3tK4wSPAs1vcp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246744; c=relaxed/simple;
	bh=CM/SZlCMyUWdhem6eFQujkxIJFQ9oso5bltG+mD3DDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4Z0IvKOPdfncVudKrTWJE3IfNEdAAp8UJd8q1+rvtCkAjzeRc1gayb0DLTA1ExEdGjIP8xPn5MSuqs0VJCtBUDelUXksMJnYA0KN0AN+zVpe84/o7ZW6h375DrzP48XrevhzWHGSHemCbu1okIkENoKyPQ/POfSTc58S5GrT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1w92YYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1w92YYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB31F000FF;
	Sat, 12 Sep 2026 20:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246743;
	bh=gCZpj8jKunnCsPAwAWqM25SOn1f64oV56k8y9JPWQK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z1w92YYCHxdHUYgGc6K11C6/gzYAfK7nw61Yz42gdrc7NtYCa3gI26MiRK9vtrFmZ
	 DVIUTixtR6043GyJHibUq1ry4l7eSpjYFZw3bM+WON6JBX7tqK42NuD/OWXKxw2tIs
	 kUgBOANaHGOJxBSqxHgmE1QwMZ0Wgd657kyKN06CrmfuO02UiI9to1kYNOnIHMB300
	 LMm8IDClnqEvKLALLicy+8Ou7SnF+k3wDqAdEKqWQWHtYMXjCBMvBPlezXe6E2c5Rj
	 ISCjh9rwI3lNGEzIWHifrE1S4pJcAW78yY6MaO2gwqE8gUg482QZZw4xZ+8AQVUSsq
	 00Y7KRNLAf8Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ksmbd: use __GFP_RETRY_MAYFAIL
Date: Sat, 12 Sep 2026 16:58:59 -0400
Message-ID: <20260912205900.3933723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091124-spout-outward-c397@gregkh>
References: <2026091124-spout-outward-c397@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0066f623bce8f98b69b752ee03d46a5047c281b8 ]

Prefer to report ENOMEM rather than incur the oom for allocations in
ksmbd. __GFP_NORETRY could not achieve that, It would fail the allocations
just too easily. __GFP_RETRY_MAYFAIL will keep retrying the allocation
until there is no more progress and fail the allocation instead go OOM
and let the caller to deal with it.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

[Stable dependency adaptation for 73f860489e3be2245598d1819226304fc5b87291]
Retain only the KSMBD_DEFAULT_GFP definition and its use for the existing
smb2_read_pipe() payload allocation. These two hunks provide the allocation
policy and exact patch context needed by "ksmbd: zero pipe read compound
padding" on Linux 6.6.

Drop the other allocation conversions, which are unrelated to the target.
This preserves the stable tree's IDA helper, RPC locking, preallocated lease
tables, ACL scratch sizing, and network-interface lifecycle changes instead
of importing obsolete upstream context. No functions are added. The target's
aligned allocation and padding initialization remain in the target commit.

[ sashal: Reduced backport -- upstream 0066f623bce8f touches 24 file(s), this
  backport carries 2. Not backported here:
  fs/smb/server/asn1.c
  fs/smb/server/auth.c
  fs/smb/server/connection.c
  fs/smb/server/crypto_ctx.c
  fs/smb/server/ksmbd_work.c
  fs/smb/server/mgmt/ksmbd_ida.c
  fs/smb/server/mgmt/share_config.c
  fs/smb/server/mgmt/tree_connect.c
  ... and 14 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 73f860489e3b ("ksmbd: zero pipe read compound padding")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/glob.h    | 2 ++
 fs/smb/server/smb2pdu.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/glob.h b/fs/smb/server/glob.h
index 5b8f3e0ebdb36..3ce12b60e46fe 100644
--- a/fs/smb/server/glob.h
+++ b/fs/smb/server/glob.h
@@ -46,4 +46,6 @@ extern int ksmbd_debug_types;
 
 #define UNICODE_LEN(x)		((x) * 2)
 
+#define KSMBD_DEFAULT_GFP	(GFP_KERNEL | __GFP_RETRY_MAYFAIL)
+
 #endif /* __KSMBD_GLOB_H */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d97ffe3d2a710..93185ea112014 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6717,7 +6717,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
+			kvmalloc(rpc_resp->payload_sz, KSMBD_DEFAULT_GFP);
 		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
-- 
2.53.0

