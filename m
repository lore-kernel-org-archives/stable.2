Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE44446FD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930872; cv=none; b=FzO4vcey8UNQrb/IgWtyEA/Eu5npwtm/cZJH5o1jl/owVwSVEmw51PIeFG9DltNH4SQSfyOI9uINwtpHyNMzabusXSuKDnd4J5ndf6ks+ZFRj1qlgxSQVmeewio3PbyHOjnnsBSeSENWVm/30gXQUnorJebXSZqdjoNNVgiXFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930872; c=relaxed/simple;
	bh=9dnXL5FnIDhpaLb5za0/SJ4Qirn22N/ric17sGe5DQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O9+8I2SpmlQzeTGMhYuL8aL8SLFvwm7BQw14beMb/ZmP/fpyshvJoY5oGhg7xdTtBMhDYA9BZMfhFxvE+3eyMGofHz1l6/Ond3/f018AG7qkLuYbooNCJJLBIusJAPTVGCHLt1FtPdsL38+snX+e6EEOEzUZducR3DQ96vXRagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUhrI2dg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUhrI2dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB191F000E9;
	Wed,  5 Aug 2026 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930871;
	bh=6CFaQWhHtOMRasMC23nnGpN+qLyAMRvGC122Ex6PO68=;
	h=Subject:To:Cc:From:Date;
	b=sUhrI2dgJ8EwtdOP98rXE9azhVrBuURhttAjuB2Vj1rjFM07+UK7FrHYxrexi1mdh
	 +yhUDzqEbAOgUs6ESd3w+VG1cNzhfYMpqm50cdipo/6u3hp9BwVDy4kDdRDzMEcguz
	 Qxx8aiyRvvmFMBveVcUDZpAD9ibQAB+ykI2UpY44=
Subject: FAILED: patch "[PATCH] net: openvswitch: fix skb leak on flow key update failure" failed to apply to 5.10-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:48:38 +0200
Message-ID: <2026080538-gutless-facebook-638b@gregkh>
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
git cherry-pick -x e1cf066244dad576221b7123a0e5005967f25a20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080538-gutless-facebook-638b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1cf066244dad576221b7123a0e5005967f25a20 Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Mon, 27 Jul 2026 20:18:30 +0200
Subject: [PATCH] net: openvswitch: fix skb leak on flow key update failure
 during recirculation

do_execute_actions() returns right away when execute_recirc() fails on
the last action as it assumes this function always takes ownership of
the skb when 'last' is true.  But when the flow key update fails, the
function doesn't free the skb and it ends up leaked.

This is a very unlikely scenario as it requires the packet to become
unparseable by applying a set of actions on a previously parseable skb,
but should be fixed nevertheless.

Reported by Sashiko.

Fixes: 971427f353f3 ("openvswitch: Add recirc and hash action.")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260727181851.306076-2-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 513fca6a8e8a..0118fe3b35e4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1108,6 +1108,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1118,8 +1122,12 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 		int err;
 
 		err = ovs_flow_key_update(skb, key);
-		if (err)
+		if (err) {
+			if (last)
+				ovs_kfree_skb_reason(skb,
+						     OVS_DROP_ACTION_ERROR);
 			return err;
+		}
 	}
 	BUG_ON(!is_flow_key_valid(key));
 

