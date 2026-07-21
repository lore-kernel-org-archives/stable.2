Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31F3403F7
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634428; cv=none; b=kev+Rna8sbnRIys9Z+cu+BGxWsQZLDv7PFU7fShK5JMN7e9Rphf69r0WvyXm4JTIP64AOmkq58/kpX3AzG1HKrYVaxTzacwAhsGHiAdKIR/dVxJWOcUf3HkJrgdqN8oUyeqkyDaBw/hMpNCIA/FHY599evw7WSM8YP049/teujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634428; c=relaxed/simple;
	bh=5DTmFwU1zmGwmurXWBfNr6x7VAHB4MOhHuIqX6lDvPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3hu7+5Ifb6dlmN/7qKKVrQURlVkLpzEg0dau6v3CSwD9n1oE75XAsO0aRr+neIiiPvJelZGkJM/8BCQyBX1cagwD+i18MXaWYqCSD4AQVXegK6BzbUjqu8QIs6CejLcztHnlB3sXHX4/VJR/OHvm9tqyp7KkewQ0NSOru9BnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCQ9EqTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCQ9EqTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F167B1F00A3E;
	Tue, 21 Jul 2026 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634426;
	bh=XbjMLMJbWuyFCvNFvXXqQbH4dA/xwOEXYnTkkQ8YbpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCQ9EqTb2e7J+L6tw9JDErCA3Ej8NNPWJkOdAX6S2hWPjvuM6NK0sZdzIRBo9rU3a
	 +kkAkLcQEqho41Jde/HpC7OwnwuLiUllsbCIks3xVcGs6SrcPP2RFJYXlYly16aU83
	 5CdPHfh/RDGDhesxtBgOAm+u8jQQR/ytz88ojlLYMkoy4Gv9UsdnRsowykfI3wLkgb
	 Zt79bLCuYa9Up37az7mslY6gotbP+9SN9Ig8hR8pSbqSrfAQI3eoJcwofAWOBs8sqP
	 VGpw/MSUCRM2tazuKfvN7IsuLz3RdzDGkyVUgRcZjFwV4m7LL/0i4bFvyYXDotY9oE
	 wwv1b7oto23Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] audit: fix potential integer overflow in audit_log_n_hex()
Date: Tue, 21 Jul 2026 07:47:03 -0400
Message-ID: <20260721114703.3688208-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721114703.3688208-1-sashal@kernel.org>
References: <2026071526-subarctic-bloating-472e@gregkh>
 <20260721114703.3688208-1-sashal@kernel.org>
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
index 6cd9421a5610fd..d1e18676ffa1a2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -61,6 +61,7 @@
 #include <net/netns/generic.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -2037,7 +2038,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2047,7 +2049,12 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
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

