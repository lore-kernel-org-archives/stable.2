Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06737F8D7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124266; cv=none; b=PuKWOkfqrk05toaUDc0eLHGSl7xeire44wVpVoy/Mzveyj/F+K63/6iWy2Z5W9XewTL0DgI8BaCvt0vB4tT5RQ/ZOuy6esJSfY9snFLzO6rZzjNB6NcUqPGZl3d4cTvCcYzUADf6t072y9IuoQcHg8ct2H0kMhZKknTCyMnLiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124266; c=relaxed/simple;
	bh=hjj1QZcLqivtadCWxI90zf/7AaVPBU6XkJM7tFbH0jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K71CTb91YEYjBelu8MXik7pJSjDG+RrxXZHnTTJW2yeXNyeI8XB4PLRrbqla6gEpahw0lFFy9j9E2gS8Oj33DoDjG1Thi6n4UWLETOFMJYAs7BKErX9UbkC0svf8d1J4n5jp0dcQocWr87KaKPXmusaRVuGy3jbUfCqcigom/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMNruXmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMNruXmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CD71F0089C;
	Fri, 11 Sep 2026 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124265;
	bh=/ufsRI20wEKjgI1CK6ePzkxQ+rgQ1Dox/kTmM/NQe/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jMNruXmAMyeE28qoI9VE3sutZTprmpWuVq349JFgxVC4Mfsc4PRNiy8Jc6EUbnYgA
	 VXKDikSzjCdeEmVswst3Gqoag6G5CiKDzFuZtamJU3LWlvY3zAWR1zBZVJeaTela/F
	 dDkpdCS0cz83ZPo/6Venm2t4kyyobN2wNR4wnpqxHgm0kumLLdkyYN8VlKHML4o6VB
	 MGY5c4alkofd6lazUrMjWUuRM5Cv2QkGfxPLWIVwfbtxCJl1ug3x2JBItaI6Tgp1Fu
	 V9a0t9lvHluOX1eFwUvD9Zg1xevrIsULmqQdUZyMCTJh38qAHokAymbCxsBHtyLO4L
	 xkEKdmZG/NcHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: s390: Fix length check __import_wp_info()
Date: Fri, 11 Sep 2026 06:57:43 -0400
Message-ID: <20260911105743.292963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090931-frugality-bullion-6ea4@gregkh>
References: <2026090931-frugality-bullion-6ea4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Borntraeger <borntraeger@linux.ibm.com>

[ Upstream commit 4c07680a467e2f7697245bcd11691bffb2a6f0ed ]

struct kvm_hw_breakpoint::len is a __u64 that is fully controlled by user
space. This is then assigned to wp_info->len, which is an int. The bounds
check is done on the truncated value while the allocation uses the
untruncated one:

	wp_info->len = bp_data->len;
	[...]
	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
		return -EINVAL;

	wp_info->old_data = kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);

Use the validated value for the allocation as intended. Without this
fix userspace can trigger >4GB allocations which will fail and result
in a WARN due to MAX_PAGE_ORDER.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260805110455.7200-9-borntraeger@linux.ibm.com>
[ Retained GFP_KERNEL instead of upstream GFP_KERNEL_ACCOUNT in the kmalloc() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/guestdbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 394a5f53805ba..de3fa79fb0751 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -184,7 +184,7 @@ static int __import_wp_info(struct kvm_vcpu *vcpu,
 	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
 		return -EINVAL;
 
-	wp_info->old_data = kmalloc(bp_data->len, GFP_KERNEL);
+	wp_info->old_data = kmalloc(wp_info->len, GFP_KERNEL);
 	if (!wp_info->old_data)
 		return -ENOMEM;
 	/* try to backup the original value */
-- 
2.53.0

