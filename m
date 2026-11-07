Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047802;
	b=rQwDWwwyDRjt3xUQjeul5ivOLjsKjMBn+H7LoI1fQfVTWGuKBYTEd8EDavuZi2YxRrrx
	 hRt5R9yO+5VPcwyZIRePIH9z4sAd8JUHIYP/uW+vE0dV3zNxcuZDsJ8VhsCq3WbgDW42x
	 2B6RrezESj3Y7sDjEuQqjWZSa24ubJ0nFu5fPgwbkj5tPTD3qO49+1+Y8FX40bGWtwKJq
	 CGGbcp5ZG6l7px0fqKDXUswxjbYxacPV04OUIQfi51CdJJoxDsPrkNM/k6Kk96ZiFdW1R
	 ZcF5jjX/X4UqnKo4jUQzRUdxTAG9FmFFpBNAyO7TpJ16Od+xQ0ETIA3pInVwApLPa5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XeYEW68Oys2Tfg/UZ9vzFmjE2Xp/+Qkg4lwTwYEKXN8=;
	b=e5+X2tZre+4UDZ+GvbScf3ZcGavJsn47JaxW20H2m3KwkAi/yDN6y88+cBFMWVkb3TB2
	 jxVx9PQHosxdBRmvYvu5E8DOoG+0fvtGhh2LXJvfq2fe/edZzpGkVrqzx7m1flISUTLVQ
	 otZaVRTEFKzzF2fho5jpTwTszJ3QZSjJVN0ayWU6gNLLQmitGVCxoFtjkr5K//yaeR2nr
	 pWUgqhHRgjZDDQ2yocPXrVa7dHG6TQxvIDYA+uOCCkHLwgjmZy676QXoeWJE/ZfJZgw8g
	 Rb4G6HZ8QE/U4WybDlM+UlDJLayELWhLsfClCsbTZog++xEfqZI2W07oYvb0nrzVwhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0okg3xS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C6606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0okg3xS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2999C1F0089F;
	Sat,  7 Nov 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047801;
	bh=XeYEW68Oys2Tfg/UZ9vzFmjE2Xp/+Qkg4lwTwYEKXN8=;
	h=From:To:Cc:Subject:Date;
	b=L0okg3xSMd7dn0FD9HEJ20xUycJhGPoSLfSaUSAY/dgqkLKRTBwgY1lYVmvi2jaX3
	 Z3trcs7Ki5YZOHB/AaA4vDv8Ze1VDpUTG+dws02Iryt3S05Y9xIUT9zU8oa8/oHcVr
	 Qxtalh308/AnfkIUYXN8HwdVJJXRnkJk81R8VkHnJMTLGdf3Pie0J0v+Nr2a5liRzJ
	 38+hmCI+DmbowXcb1UXGfplexMDNSsR4IYNDh2RXIvY8mgWVK/Z1smM+vy/vnxBUbQ
	 0/3CSx6cjjUpxtcvhJTLASl6i8RyVCRbDVEZ5A1VU3jrhms/ZHubLmhsxNPtv1Bud3
	 RSPG9YFo3LpnQ==
From: Sasha Levin <sashal@kernel.org>
To: jianyungao89@gmail.com,
	jack@suse.cz,
	djwong@kernel.org,
	alison.schofield@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dax: fix wrong error code returned from dax_dedupe_file_range_compare()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:40 -0500
Message-ID: <20261107053640-failed-6.6-9b036546a02c@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9b036546a02c6c9a5133f9c1e93503896595c6ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053640-failed-6.6-9b036546a02c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




