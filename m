Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A709481FAE
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126333; cv=none; b=qNK7nFNf42dL7upD8HwElcodnCac1vGoVz+aPaII8ntN5FOswxXNbsN04cF3r81znnj7hOUhQLbGcARpqeRv00rEUOagqpzBTFz/kbSIX4LYORj02iG/lOwEjq3dUWuhFiYUEGNIqvvAO1lXMF5zkHM424OEqjaWVrXd3qC8hjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126333; c=relaxed/simple;
	bh=r4iRi+/edrNTYe2nr3k+4/KgzRZeuowTs427rKMvpiA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uy4+zeO07+4T+ovhM2zcWMKpq6rM/aL08zkROwt0FGsjYBrzh9QMquJt6vjAX014ulQBv/yYXlW+Gcaas+cbFyWtSs0DQMnvoVp0uG3eJr/yLnw/6a1VUOF6inUEBA+CfRylvIPskKJHXSKF7y761DBKyFVaW8SNb8hhHrX3F80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wYTU9AJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wYTU9AJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E151F00A3E;
	Wed, 15 Jul 2026 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784126326;
	bh=e99waatmXBXyul+9lV5v8F1snlG8ADFNYu/VncdTF6k=;
	h=Subject:To:Cc:From:Date;
	b=wYTU9AJt6xtAKYfQhH9dodP03lNXXHcuk+J+eN3TMCrcFcE1bhIFP4m+8pIBkocxN
	 tpTMG3noHl10AP3vleBTs8pES933iz3U3xJ7lpwM1pb8yJJiTDdyvwenXBdEbc55xY
	 7pRHc2c7JMsNQaJvHKbtAjuqn7yMJL+F/gu9rZQo=
Subject: FAILED: patch "[PATCH] audit: fix potential integer overflow in audit_log_n_hex()" failed to apply to 5.10-stable tree
To: rrobaina@redhat.com,paul@paul-moore.com,rgb@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 16:38:27 +0200
Message-ID: <2026071527-delusion-yarn-0b07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071527-delusion-yarn-0b07@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

