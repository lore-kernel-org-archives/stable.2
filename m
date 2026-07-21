Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BB3F7875
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597275; cv=none; b=onZyb2fr03RuNR1Rxx8mrqXr1sB5skDBDZD3jqAStJ9S3xjjsW8OMq8z32CeeMTnsSicFRoaMUC7LGHA6ujX1jW826ABnjRzJ0guFs5INHZu+I/UCWEiz6eZeA+sy2i4ynvxomJerTY7gaRbHj/uUJxhuPCkCfKRWIDZ2iB0KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597275; c=relaxed/simple;
	bh=fkLtKZddg+yYZB0gbgQdV74c8ziZVDZpkWZewtoy25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEew4QaP+lWnzS3N1m30FnuRaTOE1+izMowPCO4kXc6gDA6sosFBCJ74UrVies/xztFiPqchcmGFhut/cVdOVvHf0SMFttEQCjiTfcfcsza6o7Jl5WOWC+6NDLQArdjX/9vLANVQcox8bctVKaRzPb9p0UMhI2Q99bewRhF9tcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/Gd3yeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/Gd3yeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C571F00A3A;
	Tue, 21 Jul 2026 01:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597274;
	bh=E6H1eUwTxcJjIyQKiwIoQoybAQCRhtZO6+jUx5eDALQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/Gd3yeP3hqtUlV32SjPQYmZxWh9VlAApBw+DajuRHdKkYZWmXuPZDRtcadp5Cy/A
	 hRf3bjljY22mbhTdItgYn+LMgkcMWbNpZZNWktichcNysFgQNmWrSsezjxFgnDC/TA
	 fgvzitMGebhU8vvLtQBQ1qe0vqAVKewq+V2uwQo9FeldGP0juAPpR3MPeigPB6ZGym
	 g8wZpVFTd86ACoNrNnlixUKluXOlqh4sENDzQZvxiyAIZAAVAVMnbX8ix2FrJzHwpW
	 vBQX0qfnVIyIqk07bcFNynFIZTdEz6iWaFgr07ViCScYe8UH7dPI+B2lgNzLgdewUq
	 eaf0P38dsdH4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] audit: fix potential integer overflow in audit_log_n_hex()
Date: Mon, 20 Jul 2026 21:27:51 -0400
Message-ID: <20260721012751.3458464-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721012751.3458464-1-sashal@kernel.org>
References: <2026071526-proposal-crusher-04da@gregkh>
 <20260721012751.3458464-1-sashal@kernel.org>
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
index 48f8824cca491b..60931d9fe33fcb 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -61,6 +61,7 @@
 #include <net/netns/generic.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -2035,7 +2036,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2045,7 +2047,12 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
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

