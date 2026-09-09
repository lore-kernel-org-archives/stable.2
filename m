Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBC4915AA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950706; cv=none; b=doyXXT8dFv7dcow/bMoQKiUyAmX0wZ+iZRvVAI0MkUX5JV6V4QlTUGxTSdr/Pqo1oYAa43CcWKk2ioi4xP0eqCREOt/L6IFucCw9O5rId3/AYzh1sLYjEHzPtndmF/hjq7VKVx9KePuDxpc676deJ4f/WKqY5CG49uDVIXfiXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950706; c=relaxed/simple;
	bh=q3jmsKTrQCTWFEvi3QIHfR2ZmY9fWimGftedYrwIRRM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QkzXs/l6qZct4H2EeLV+Vp2T+5+KutCXoQMOP5hPbtUPOXZMKWtESMYQgTkJUq+hxW8QNYDGTEEWxI4bTRs/duvdl/BtTO74LOfDDtNjQcJJhHv/0THPOO+j7ZxzKyun2vXWHks4mmvG6IxVS07CMTSGPPGhkPyKzY/xSlfhbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wo+64ppS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wo+64ppS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9E1F00A3A;
	Wed,  9 Sep 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950705;
	bh=X1x02JCgMfLSJtqVo3PKtZ8LWPxhUINlYy5DoOE4OLo=;
	h=Subject:To:Cc:From:Date;
	b=Wo+64ppS1H2PV41elTEZmLp1efpJSMUKpzDFVyhNA36CwYJ8Zx8+Pfle8Jlu/UQqH
	 FDNURkOcqBGJ+sk0ctfLdkL69f5A5aZavlZpwtGIQso1OeogQXup9iDKCWfUs6RgiH
	 9zr40GpZoPGRHyTSn3Gm5C8Q0TUFuqdZHyZGAfQw=
Subject: FAILED: patch "[PATCH] KVM: s390: Fix length check __import_wp_info()" failed to apply to 5.10-stable tree
To: borntraeger@linux.ibm.com,imbrenda@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:34:31 +0200
Message-ID: <2026090931-frugality-bullion-6ea4@gregkh>
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
git cherry-pick -x 4c07680a467e2f7697245bcd11691bffb2a6f0ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090931-frugality-bullion-6ea4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c07680a467e2f7697245bcd11691bffb2a6f0ed Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@linux.ibm.com>
Date: Wed, 5 Aug 2026 13:04:55 +0200
Subject: [PATCH] KVM: s390: Fix length check __import_wp_info()

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

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index f7c94d54efbe..9a6149e310bb 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -184,7 +184,7 @@ static int __import_wp_info(struct kvm_vcpu *vcpu,
 	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
 		return -EINVAL;
 
-	wp_info->old_data = kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
+	wp_info->old_data = kmalloc(wp_info->len, GFP_KERNEL_ACCOUNT);
 	if (!wp_info->old_data)
 		return -ENOMEM;
 	/* try to backup the original value */

