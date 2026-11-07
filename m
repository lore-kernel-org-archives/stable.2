Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047045;
	b=vW69VQq+UUhc52sofM4/tGEf8vBL2wGQDgRgifkCFltRDK6I5Qn6qeTWCH3RdgmD32Ng
	 2gge9Y+ND5BFpddVZam1Xw9lNxVEBLXP5lrw9w/7h37k1ehRYStvok4G/NShAoFAfhjjZ
	 5gVkzzOgSii17iOya16lb45FcDpk9iwWPAVqWpoeOsrSiT1xYqhdWXQ3rX3eRFeXDuL0e
	 hzzENLDL3VVbSx6fMDNFT2kzzSouYE1i5ZraD5qYzErZUC0qcYKSmD4lT0hYjYx5asMGh
	 78fsTL74yPBWb0M+oLwf1WKhcYbuT/xVI3TPBpabIXLICBcgJ2418D6edOodSGMLKug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GtuL4uje55KK5V9kIktk2zznIDI2aBzcTOOW2SRGUsI=;
	b=OLxpADfjd+L1xkP2rD52gF6CHXthxWoUGpqkDHutANsyYHB8m5u01IE9haSwktiKmG43
	 hghANSB6x/gntvlr5jfcLCiNng0WFOtHmHX4EI5BfFIMx3YP3Def7KzNvRIWEMYat/vmX
	 55FWI/VpjH8i7scxNNnmXQH/oabHP8TnXwlHElKvzSdTyGcy5fV1qsHtlIvZ7zEZJ3m7Z
	 YaHqpXLwIkAkvKhvNnUcWE3ELb0JE3SO45EYDTV7j0eSQ8JnhVwZ6GmOPytUQ2JsG1GzB
	 By0nctiGSzTI61nccBgl4lWav9h2bQ12fSYsocoKoXBSgLI82AP0J01OmMByRWGCswg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMEekeeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A615606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMEekeeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA31F0089F;
	Sat,  7 Nov 2026 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047044;
	bh=GtuL4uje55KK5V9kIktk2zznIDI2aBzcTOOW2SRGUsI=;
	h=From:To:Cc:Subject:Date;
	b=PMEekeeTvnQo5nYxSU2Y7bu5EQ1XgNWBuKFQUcGmzReTX/kwWp58Z9iNf1ZPfAHCs
	 xqhoLevYUqSQtupbqPOJLvT1bp9d26DNvHt8ZueeAqq6xGAWDUbucN7o/fJ+6XDdTm
	 IeGkthszIwJX4+9+60Y3SssAWi7xRa67S5F5s+clhjSMtwtZOV1LqY4amU30Toxl6U
	 jXMuVRfCgtq0eR16oqKuXdvuz3TnYpTJ2dCNuL7rjjzVIg7AYHX8lfVGmiJjknHBz8
	 n2PhzHL6jIJN+WgkJrKzfUYNKFXlVbNSUbKPOSOpmE5B2/iof3JwSz1cqVKVPj0dr6
	 lDgnRO1oKHZ8g==
From: Sasha Levin <sashal@kernel.org>
To: jianyungao89@gmail.com,
	jack@suse.cz,
	djwong@kernel.org,
	alison.schofield@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dax: fix wrong error code returned from dax_dedupe_file_range_compare()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:03 -0500
Message-ID: <20261107052403-failed-6.12-9b036546a02c@kernel.org>
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
git cherry-pick -x 9b036546a02c6c9a5133f9c1e93503896595c6ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052403-failed-6.12-9b036546a02c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9b036546a02c6c9a5133f9c1e93503896595c6ba Mon Sep 17 00:00:00 2001
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Thu, 15 Oct 2026 22:34:25 +0800
Subject: [PATCH] dax: fix wrong error code returned from
 dax_dedupe_file_range_compare()

When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
positive return value from iomap_iter() indicating more iterations remain.
This positive value leaks to the caller, where vfs_dedupe_file_range()
interprets it as success (bytes_deduped = len), causing userspace to
incorrectly believe deduplication completed.

Return 'status' instead to propagate the actual error code.

Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Link: https://patch.msgid.link/20261015143426.17620-1-jianyungao89@gmail.com
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index dbb58692efecf..61dce4601aaa5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2266,7 +2266,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
-			return ret;
+			return status;
 		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
-- 
2.53.0




