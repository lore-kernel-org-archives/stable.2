Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7940B396
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635006; cv=none; b=WnV6pAA/G7VWwRHgfq44t/IddYQJduqhBG357j3IEu/tXiCWkribof7A0OVrPPSJR73gU78EgqFYF1YYBvTswwrn36zJuyXO9UXVe7nT5xc7LPUqyXve6xbe1IwuMp7bRMmUtVrlEprPSXycvo9VT1b5yNPDWhJL/lGzkJrVMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635006; c=relaxed/simple;
	bh=6A/oEKLYnKPpZA0jI/W65o6JxdDIoxuwaBwvvna/E+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPwF9eSnamysSYWYsn1w5nLt461wrHqOnhFeiF+9gMumslwkAiciqQV/gV4w2RklXJNxxmh9TrOEdiQRKf+R1ZW/tdz2BIwEBd5sr7DuFTrgASB3cg/9MPiRr9lnqt+4rA8U+ZuHoqKIVLZp1Bb8XZzAuyWHfHy6mYDlZezEw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3YWPa+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3YWPa+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863971F00A3D;
	Tue, 21 Jul 2026 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635005;
	bh=D7awcoz+w7Wx1Dk6mImW/KEzUUl+FT3DDM0YNT1nXn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m3YWPa+xgtHtcwXLHUP6WSTmU32A0x/BlkLVCMPOUPzDOEoyIT8bGU5XRv1t4duyL
	 BM6B9lYLH7j3qu7DemH+bk8j/3IpoezEdh7wkJkihs8f3XnA5VVa31hMPTnLik8YAx
	 h0eXHnkSWHEj8L82zUfOq8g1Hvc4E/ULCCujP0zBHvsjx+XJzGGd5yMM414HOwNxji
	 VyStIB/IZRxMKNQF9ROR217SHAonGCQq9QaM/HhYp5eIN7ettFPr3knzyehsQ/h0Z1
	 zw5L5Vb5u/yG5XUonUCHBcNVbxSSsYfAK/zlDpKfBE1A3OO7Mvljjke6ZGuoT3bM1J
	 CXaC9FAa+++wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] audit: fix potential integer overflow in audit_log_n_hex()
Date: Tue, 21 Jul 2026 07:56:42 -0400
Message-ID: <20260721115642.3699441-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721115642.3699441-1-sashal@kernel.org>
References: <2026071527-delusion-yarn-0b07@gregkh>
 <20260721115642.3699441-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Robaina <rrobaina@redhat.com>

[ Upstream commit 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 2d38092a30322a..b8014cfe276cf0 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -61,6 +61,7 @@
 #include <net/netns/generic.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -2034,7 +2035,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2044,7 +2046,12 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
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
-- 
2.53.0

