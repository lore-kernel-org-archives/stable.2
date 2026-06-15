Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09657402B8D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536961; cv=none; b=cwawLnV4G8PPIyWCmjor1JtYPaxo86ZIxDLHG3piRhrawUPw232yV/j8P4EdglmIALwwDRgfomix3k2jc+jBYFNH91l3BiyjFaJU06JxKtmqjWOjiLGOtM9VA3y8QVRcbKvxCldZqSxjLoBD4HVCe07l3Qh7H8vZNYB8SlSpOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536961; c=relaxed/simple;
	bh=TqDF8T6ime7HnJjDdXNkOVS+Vg5lU+ACsnSSpJbsgUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uJCIbUkF05UKiUo1c3bMosveyk2ruUZ1i32j/3UF+Rp4YuWXgLfgoXKrfo6VHgFJuWpI5tQU/3uLJBs9IHAnG/U0gXXduADvIKJm6cpKt6Jj91eD5j0SAfHNoa4Mmf4CyN04gh+WCOZ9NdXomRFGGqRnvTYMBUM8vs/DHPRaGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rk4IVmW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rk4IVmW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9B91F000E9;
	Mon, 15 Jun 2026 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536959;
	bh=B3NcVHCiY3c5us1mbNSQjAFu8nxGKs5RVRUvifNxTwk=;
	h=Subject:To:Cc:From:Date;
	b=Rk4IVmW1X+Kwchn3KRGC2gtOL0PnQm4zYPJmVdal1//f2uZFvyB0FnkThlc0wI0eS
	 QPRRNNdT+3/SsUTPYrKvWSvtyIzlnvLIc6tS9xmxMqoex++T6QJoZZnxAsLgbdCYAg
	 Ya0MOOt/yPJ9l8+vumay17TlcBy1oX7H0D4rUKgM=
Subject: FAILED: patch "[PATCH] net: phonet: free phonet_device after RCU grace period" failed to apply to 5.10-stable tree
To: santosh.kalluri129@gmail.com,horms@kernel.org,kuba@kernel.org,remi@remlab.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:50:49 +0200
Message-ID: <2026061549-equipment-myspace-2ba7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 71de0177b28da751f407581a4515cf4d762f6296
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061549-equipment-myspace-2ba7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 

