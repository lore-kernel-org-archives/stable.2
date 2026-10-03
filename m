Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A6239E60
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033509; cv=none; b=E/6AtYlP0CWjhHE/g5V/ZEbfoMZJGof3K2F76jispvB6a4Tit5z2Wos+/2u7mjjvBdGXsN60KSey5vCpfZ1qNUx9GR8Meo/6ykfvK7M1c6f/kW65F9uZA+xKnN1ZvCPCuJIygOWPl+OBZo7bKLa4nHlId4dv9q5eyES/SFh0SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033509; c=relaxed/simple;
	bh=xPqRgncZSEyr4PNWWHihBrGCjjcB3Rhy2DIwCd+CA8I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JY32TtEOOIrJgN72sF6XeZau+FFgI2GZOAUcPzyAFvF+DlxR748wp/gQUZIrkAE2I3eSzSytHLZUAKFzPcnbO6Tk8oloXE5RjmrnTAbYdWvXjwk6E1JsMBMAKDQFGZBWtNJwo/KtJx2Mt8p6lbF2uRmyCMTy5+wvasWR8+RjUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxFT1jqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxFT1jqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A11F0089B;
	Sat,  3 Oct 2026 13:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033507;
	bh=LHOQJVJtMUMxOdNRI2DkgVOHwKmUppbvsAI1GWwHYvk=;
	h=Subject:To:Cc:From:Date;
	b=VxFT1jqtdORac8g0/xSMIFvMWKYxpjicCeJLZgdfPOOKsjsDdJ/mGwcKcGwj3b37j
	 Rw3dumG2C4UU6eiOhuUu2bKX5cv1/gs+fcR8ZD320fhdryK9IVI6Sm0BbI02eAVWp4
	 nYIsm+HTnCsOkgoPxS1RQ2V/5T4Qw0o0mea/ES+Q=
Subject: FAILED: patch "[PATCH] pfcp: fix socket lifetime on netdevice registration failure" failed to apply to 6.18-stable tree
To: luoxuanqiang@kylinos.cn,horms@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:18:24 +0200
Message-ID: <2026100324-detector-remember-9bba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0f17d2e3dd9cda3ee6d94033d5e5489af168920d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100324-detector-remember-9bba@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f17d2e3dd9cda3ee6d94033d5e5489af168920d Mon Sep 17 00:00:00 2001
From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Thu, 24 Sep 2026 13:52:52 +0800
Subject: [PATCH] pfcp: fix socket lifetime on netdevice registration failure

pfcp_newlink() creates the UDP socket before register_netdevice().
If registration fails after pfcp_dev_init() succeeds, the core calls
pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
The newlink error path then releases it again, causing a NULL pointer
dereference. This was observed with failslab fault injection:

  FAULT_INJECTION: forcing a failure.
  kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
  BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
  Read of size 8 at addr 0000000000000120 by task ip/1037
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x78/0x90
   print_report+0x468/0x5cc
   kasan_report+0xa4/0xf0
   __asan_load8+0x7c/0xd0
   udp_tunnel_sock_release+0x1c/0x50
   pfcp_newlink+0x128/0x184
   rtnl_newlink+0x848/0xe44
   rtnetlink_rcv_msg+0x468/0x514
   netlink_rcv_skb+0xc0/0x1f0
   rtnetlink_rcv+0x18/0x24
   netlink_unicast+0x4b8/0x558
   netlink_sendmsg+0x2b8/0x584
   ...

Return from pfcp_del_sock() if pfcp->sk is NULL.

Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260924055252.33488-1-xuanqiang.luo@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index e1cca779d2ec..3ecd43cafdf0 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -105,6 +105,9 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 static void pfcp_del_sock(struct pfcp_dev *pfcp)
 {
+	if (!pfcp->sk)
+		return;
+
 	udp_tunnel_sock_release(pfcp->sk);
 	pfcp->sk = NULL;
 }

