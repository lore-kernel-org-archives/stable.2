Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88183F39CA
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594692; cv=none; b=HOHMIg/YxIufclPf+6W4fpWpYrl0XIKUf4xr6uRUZtijssyz8jS+VAWwRR1R7+yXNbRl8871rwFt2EO2NiWj/4TwmAQitZixyx14JxwuOCVdppRt9w5JL4apOzFezTmGQJMpeoQ6FjpZpv4Ey62A1mwn1L4sgQ0UwLy7pgdjfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594692; c=relaxed/simple;
	bh=moD4yj427AoQ1yUGGencNpiQKREBXelRNCQoonP8gz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnavamR0DQe5X/5yjOd/moqIoP4xCtVN7U6iRtGt8uCEZIQwvp+0FX3mjVZeFnawxXkpyHA9zo5Nmiill1LwIbooFvpKPg844EHxDYoVgcteinQMD1uvMoosgcbqi/uHhVWJA729aVHL4gPF/SY8EXYmEzgeEg7W53KvdWI3GPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni2dN/z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni2dN/z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F421F00A3F;
	Tue, 21 Jul 2026 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594691;
	bh=Z+CEjjhlMgsdqDVehVd1MRfIXwJTxSSFJrrjW7jRbMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ni2dN/z9LyR3QBJ1nDnfkB20JLHK8nUfCqMMbuKJrOux05Js19DWe8fKw/S2yHCLk
	 lBgKMpcsjcul4hup5n+moPpIo0dNnlfRNkgLUhROxbZ+eUSswP1SBQUYBzLAoDvZf/
	 dNQvRtJaN/QeFN/Fc5a/iv9UnfrwitI2GwcCdWOTLC3WWEhTFm0mQQFUQ2+jCVwszA
	 yb8+BGy0vU0CwaBGK0Wz8SVAlirYpmy6+GLs0NYhdbkjAxgZk6r4JENEeZg3s0MB0o
	 x5D4AG1egzij5HHABId04Kp40yN5OI7V6qTHtpjsxzY/A3ZFwBGWXoU7hIrOsCPDmH
	 grSMXdQSDZspA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] audit: fix potential integer overflow in audit_log_n_hex()
Date: Mon, 20 Jul 2026 20:44:48 -0400
Message-ID: <20260721004448.3420885-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721004448.3420885-1-sashal@kernel.org>
References: <2026071526-tartar-ammonium-a9f0@gregkh>
 <20260721004448.3420885-1-sashal@kernel.org>
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
index db783043ad9680..1786e73834d02a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -59,6 +59,7 @@
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

