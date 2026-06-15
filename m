Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28D3FD12E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536925; cv=none; b=f+Fv7+ttGFDW4Bs+rhIjLBJBBLcjGys1glXe1DYOLGHqlwu/c9u8Xq3hoVoaR15WCpj/n/2VAqJE6okag3Iv1r3MM9DmvH1Xx8q1q0DbHT48Bfk6ZLC3phVjGw/oQAPoHlrmNH+iglF0r8WtboF/6P6yEVigV9HK/nZSgcanDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536925; c=relaxed/simple;
	bh=E9oFvwq0T21gfJ4uti+2uqmpiOTon6ioSMdLeYyoK5s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pc8+fK3qGCvJMLXyuPY5pp618aahZtz6cZYfbPjM399MDztA7TsRprRVPExq/WLWj8bKNmNNmTEXbIlTex/RIH23hEue13khbD/qdYV9OY1HabmCQnlQ1QcL1yzd7iumiBPnfNCSFUw8ujdosOjKhEwQtVuHrR9vHvkyeEelbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gs9UPARf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gs9UPARf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4171F000E9;
	Mon, 15 Jun 2026 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536924;
	bh=5KNxwz60NnVpw9plyCBUPigx8d/nG1x43wUaisNL6aQ=;
	h=Subject:To:Cc:From:Date;
	b=Gs9UPARfqTrxtjFNtwMJQJtOHbuioRXoNB/jDF+lY9gT7mWTVAr0Z5iW+T+C1KqMS
	 aXHl01ip839xM12KrxRX6QTS8GIzqIqfrHPg9U4+Jn0qrJSMNKeZ+oDHfacROryNUo
	 Ybj0qplRpDx6tqfT2vJ3h91NSywZzvEMZf3/ZkYE=
Subject: FAILED: patch "[PATCH] net: phonet: free phonet_device after RCU grace period" failed to apply to 6.12-stable tree
To: santosh.kalluri129@gmail.com,horms@kernel.org,kuba@kernel.org,remi@remlab.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:50:41 +0200
Message-ID: <2026061541-expanse-aloft-6b99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 71de0177b28da751f407581a4515cf4d762f6296
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061541-expanse-aloft-6b99@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71de0177b28da751f407581a4515cf4d762f6296 Mon Sep 17 00:00:00 2001
From: Santosh Kalluri <santosh.kalluri129@gmail.com>
Date: Wed, 3 Jun 2026 17:08:43 -0700
Subject: [PATCH] net: phonet: free phonet_device after RCU grace period
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

phonet_device_destroy() removes a phonet_device from the per-net device
list with list_del_rcu(), but frees it immediately. RCU readers walking
the same list can still hold a pointer to the object after it has been
removed, leading to a slab-use-after-free.

Use kfree_rcu(), matching the lifetime rule already used by
phonet_address_del() for the same object type.

Fixes: eeb74a9d45f7 ("Phonet: convert devices list to RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 86325b7fc1b6..ad44831d6745 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -108,7 +108,7 @@ static void phonet_device_destroy(struct net_device *dev)
 		for_each_set_bit(addr, pnd->addrs, 64)
 			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
 
-		kfree(pnd);
+		kfree_rcu(pnd, rcu);
 	}
 }
 

