Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A832EBBA1
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889302; cv=none; b=Qgdix5suc1c/Z/x6lahsI16IQxtQQk6fjgAkG93fP2QfUrexC74j/0UppphL1n+eqN85CtFBvLRA0Aw3jOwP3Bk+JU6H+ezpohPHnGjBEtyAp4SaoaqTZl4E62D9K+fRENuzZ65SpVofSrBUJLAWAw89ZrymgeP+Z1ubEXSocqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889302; c=relaxed/simple;
	bh=3p21nhULlOFap4CtEJAN7xI98sP0bCHb96zjeXMO1QA=;
	h=Date:In-Reply-To:From:Message-Id:Mime-Version:Content-Type:Cc:
	 Subject:To:References; b=odJEBSlrPDHXtVdpMBVUmf737HoSKeiRFKWv7l3WunuoSJUDOxs+X0DKAk51ihGQRmOX7dFEAgc7dpRoIhGjOUm7CvZZrGGoQj9i+2jWKVrErS0bce9iQniHgyEkLeeRHeDd2QyV0xIgtDHr/aezK22PUpZ50ePQVXCATIJUstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U0hOQ4p7; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U0hOQ4p7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780889289; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BnFRpGMvMTrAbPzGLBDo0aZKDmaAWW1kmVRIz1TflEw=;
 b=U0hOQ4p7IR8Xds0jMGNhepJFq5476BiqnlGgQbtDlwybLaJOkApC/Bwzv4m5Cydjn8n8i7
 o9ywhTOnxuaZfz4gj1CPZukcBwsag6FAn+1sy1qg+YbTyx9eerOcpKfT2Rkgr6iBPnQIyx
 YzdQRCyx4dT/kPj0Nsa8TWxCEy1BlVJit7/f3c7tBtIIhJg4KPUQjUYXxFCJ5eQq3cm40V
 /Ei6SgznzSlqI5ytTYQ2eNC6BAtdSgJsRxkepvRCT688IGMqsLtAvJRw2ixCIFRpeI9QOU
 9Ed8dbbWHlJu9EkZQ1omn/5paqT16uMdMJpb80hj6PHu2+JCvRO7WKKHYvcKfA==
Date: Mon,  8 Jun 2026 11:27:54 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <20260525063235.990101-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260608112000.1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: "Rui Qi" <qirui.001@bytedance.com>, 
	<openipmi-developer@lists.sourceforge.net>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp
X-Lms-Return-Path: <lba+26a2636c7+557759+vger.kernel.org+qirui.001@bytedance.com>
To: "Corey Minyard" <minyard@acm.org>
References: <20260525063235.990101-1-qirui.001@bytedance.com>

Hi Corey,

I'm following up on this patch which was originally submitted on
March 25 and resubmitted as v2 on May 25. I haven't received any
feedback so far, so I wanted to bring it back to your attention.

To recap, this is a one-line fix for handle_read_event_rsp() where
rcu_read_unlock() is incorrectly called instead of srcu_read_unlock()
on the error path, leaving the SRCU read-side lock held.

This patch is specifically targeted at stable branches (v6.12 and
earlier) that still carry the original SRCU-based locking. In
mainline, commit 3be997d5a64a ("ipmi:msghandler: Remove srcu from
the ipmi user structure") has already restructured this function to
use a mutex, effectively eliminating the bug. However, that commit
is part of a larger SRCU removal series that is not suitable for
stable backport.

Since the affected code no longer exists in mainline or your
for-next tree, this patch cannot follow the usual path of being
applied there first and then cherry-picked by stable. Could you
please review and provide an Acked-by so the stable team can pick
it up directly?

No changes since v2. The patch is reproduced below for convenience.

From: Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in
 handle_read_event_rsp

Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.

This mismatch leads to an SRCU read-side critical section imbalance: the
entry uses srcu_read_lock(&intf->users_srcu) but the error path
incorrectly calls rcu_read_unlock(), which is a no-op for SRCU and
leaves the SRCU lock held.

The offending code was restructured in mainline by commit 3be997d5a64a
("ipmi:msghandler: Remove srcu from the ipmi user structure"), which
replaced the SRCU locking with a mutex in this function, effectively
eliminating the mismatch. However, that commit is part of a larger
SRCU removal series that is not suitable for stable backport. This
minimal fix addresses the SRCU imbalance for 6.12 and earlier stable
branches that still carry the original locking scheme.

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Qi <qirui.001@bytedance.com>

 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 188722ec0337..41ae4dac4eeb 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4395,7 +4395,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,

 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg)) {
-			rcu_read_unlock();
+			srcu_read_unlock(&intf->users_srcu, index);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
 				list_del(&recv_msg->link);
