Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411638;
	b=eRageADgOQyh6SHBbh8LsOirYcp/ojLE1niDbMyYXpD6N+0qtlVS7dwl2MVWdOsw7uT8
	 sZIgvrpcVU9pg84V+ebfvgHX51MWw2TGycmw1fYYLDn26o2P2Z+8N2H/15AFFRmmfNigQ
	 IBUeZ/jsphPovC1crqMuC1JXXeju00AIjrAtquNWhBavOWWi8D2z9rhE0nabYN3lhijDJ
	 k+gbzuHu7cNySHeBburWO9c1xBlqNbKE9SJ7UOUOY+fLiWxhFRYCDoO5ALKSXgabz+8Jk
	 itGKuiUKrvInQf5KDa9TNwzv6/mNd5hoAavL41zEwR61jVkQUCwcu617UQawiV5DQ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iPK2siaFlf8aHcBvnLwCD8sAPD69lafjqDaWt+tr/Ko=;
	b=HxIO51sDH5kAHPHI+yjsoHAQ5oeEY1XRLF4Av+ecBJBNVh/RzE892lTgQVPmmmVvOAki
	 4d9/el4JlDa/2n7/fWoolk+W/JwY3O12nlRn+J9rGELH+UZhYqp65bsdlQLtqMxWJV8pe
	 ZQJijK4c95jH5kdL1KDQD2GlWbeCwTEcE4NlwPc0yr0sBuITl/DnPXMm8JhUuRhUHMi2/
	 s5lZvqjbfs4LBU2ACJr9pGZdA65VD77Z7VYrXCHFH+wvoyrsrQrABKFzV/lr/xX9mUnAg
	 uOUwNvo+P00XIAVl577+cDYFl9luSPef0/IPunLbmnlLkQk/bRPHQQwKCY2QnaN1WeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT9HNRvW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5D606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT9HNRvW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958E71F00A06;
	Wed, 11 Nov 2026 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411638;
	bh=iPK2siaFlf8aHcBvnLwCD8sAPD69lafjqDaWt+tr/Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XT9HNRvWwSNgjCBTKA/i+WwlZOyQn43XassV72eFjzWlO08+mvMoGT1OjRFYM8leW
	 92B+BwCg3iECLUsTRF1RYRrmpnQydPDgtkSUMhRk0jjUxR7FPxIw9JSlAx4FYNRn3G
	 a45A4XMBJ0WYTlE8/vC5/bRLzcJl+CKPih4Zmvoeh205tIKg7qbR7v5YE60GtxhsbK
	 NfHcbNqdcmAqJoHqlfkzaaUgNfpbaqGp2gspq4UOVpjpXveaJ0CneHL7CgtGC8YRJR
	 8Yw1X7NTGMQ1ghPIyhbR14MhipP+MVNxm+59bJpe0nABJfAreEKBr+HQNeZpvcqgxH
	 f813yv5mG1G5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chung-Chiang Cheng <cccheng@synology.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] splice: report related fsnotify events
Date: Wed, 11 Nov 2026 10:40:34 -0500
Message-ID: <20261111154025.2714356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055657-failed-6.1-79b496ebe382@kernel.org>
References: <20261107055657-failed-6.1-79b496ebe382@kernel.org>
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

From: Chung-Chiang Cheng <cccheng@synology.com>

[ Upstream commit 983652c691990b3257a07f67f4263eb847baa82d ]

The fsnotify ACCESS and MODIFY event are missing when manipulating a file
with splice(2).

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
Message-Id: <20230322062519.409752-1-cccheng@synology.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 79b496ebe382 ("splice: avoid stale f_pos writeback on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index d0230cf8ec571..30b669aca152d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -30,6 +30,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/uio.h>
+#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/gfp.h>
 #include <linux/socket.h>
@@ -1102,6 +1103,9 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
+		if (ret > 0)
+			fsnotify_modify(out);
+
 		if (!off_out)
 			out->f_pos = offset;
 		else
@@ -1125,6 +1129,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 			flags |= SPLICE_F_NONBLOCK;
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
+
+		if (ret > 0)
+			fsnotify_access(in);
+
 		if (!off_in)
 			in->f_pos = offset;
 		else
-- 
2.53.0

