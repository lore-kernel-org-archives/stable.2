Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA961481649
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126320; cv=none; b=SgCxhT9a2GQ4DqEllmuW8r6kNCc1G/r/B0T1gscCMM+x2sCE+8tRg4XYTfgXh5P7t7y4DYuPRpwYj5s3+ss5dECki+R70+iACyF3UCrZcqHOJPPnJig+WqcMlJM7xc84QQrMaIAcgtpWw6yvTN+WzxxKfuDDGPTw6GammHbOfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126320; c=relaxed/simple;
	bh=QW/4UVIEkNAYS9RckfHW/LmvFIMYUAjFQLOi9PNML/8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sl0ibF4bAoxErT0nTS4eGpAMKeEYk5bE+Pp2WqNqD4ItWy5Ct8lx+c4vBOoaTkxo+Npe4o2NII8ADTcPz7GVILxAtMMKYz3db3bpNMBL+zmkUKk+0B2QTeJ7XiUu6uzyZ0RbLPkLMCGdu3EZJbRCeEGVRqxhdyQ73BW1WI5hkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w5/0NSI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5/0NSI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C121F000E9;
	Wed, 15 Jul 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784126312;
	bh=2sCp64bTFxkyVKmb6n8srrjUx99WHs5k/Sr8wKbI1dc=;
	h=Subject:To:Cc:From:Date;
	b=w5/0NSI62hHTl/DQIYcaz6HSYSBia94jAwjGSJcrKN6p6sTeV8EkLUV5otIUp5JdU
	 DihUuxJ+kl624r1od5q9AsnA4+DAcS198HYFPrao38iqIGzHG9IqmmGLb2ezn7RdE9
	 5Sl4g5+YRdECXb26OMs9Q+OKy564LiaEUDoA4eMM=
Subject: FAILED: patch "[PATCH] audit: fix potential integer overflow in audit_log_n_hex()" failed to apply to 6.6-stable tree
To: rrobaina@redhat.com,paul@paul-moore.com,rgb@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 16:38:26 +0200
Message-ID: <2026071526-tartar-ammonium-a9f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071526-tartar-ammonium-a9f0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0 Mon Sep 17 00:00:00 2001
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 11:04:11 -0300
Subject: [PATCH] audit: fix potential integer overflow in audit_log_n_hex()

The function calculates new_len as len << 1 for hex encoding. This
has two overflow risks: the shift itself can overflow when len is
large, and the result can be truncated when assigned to new_len
(declared as int) from the size_t calculation.

Fix by using check_shl_overflow() to catch shift overflow and
changing new_len and loop counter i to size_t to prevent truncation.

Cc: stable@vger.kernel.org
Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
[PM: remove vertical whitspace noise]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/kernel/audit.c b/kernel/audit.c
index feaa4e2271d7..562476937fa7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -62,6 +62,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <linux/sctp.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -2080,7 +2081,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2090,7 +2092,12 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = len<<1;
+
+	if (check_shl_overflow(len, 1, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len >= avail) {
 		/* Round the buffer request up to the next multiple */
 		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);

