Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5DA438019
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562985; cv=none; b=sdOMg8+8zymXOEbxv11eqszFdloPg914aEq+2hM6W8jHUXQDm/YP/sJ/qR+yEk4HPeLJhICqWTH/A6wYgeWQQWy+/lesR7uVyD2d1JExaerZ2tW1ivwXTTa+XP5th0xGuevZLqGdG3p42nlqogL80xtsz81Mjt+OO4uisU0hI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562985; c=relaxed/simple;
	bh=o0xQrojXlBGjgY042f/HeFMrvdYc3xX0LifxA1/rMs8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rOvBl7g6X9E2eWqgoE8Ju64IbiCxzIGbtfQp11JimbvKl4YItS5MI/4viVG5Fwzy9dGvWIvpbttJGr7bMWotQMEEQTck5mZmJRLe7LTp0+6zXd5YbJYzPMoL3GkWUWEGfGjxWYOFPyimLZw6ZrA5QrIfZrKH7RzZzmPXWE7PkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLlw5sU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLlw5sU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EA01F000E9;
	Mon, 20 Jul 2026 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562983;
	bh=OfZcnIml9u4GKDfSmeYUIhfmHg/IwmFTps/7KFL3z78=;
	h=Subject:To:Cc:From:Date;
	b=dLlw5sU6MuL1D0wzUHLyaOoeRuRv3xqYavBqyTKafJOxB4gP+eSnoBP+qYrD5SzPF
	 OH8N+XYQlOcEZA5XzNTIDfRePf/PL22nnsy5raBdy33Ao9sW/J699mEKwkv2S18xEE
	 AEcXYuDJLitfTye7SWvnH/S/0Ybg6N2/lSeOVZPU=
Subject: FAILED: patch "[PATCH] net: ipip: require CAP_NET_ADMIN in the device netns for" failed to apply to 5.10-stable tree
To: maoyixie.tju@gmail.com,kuba@kernel.org,kuniyu@google.com,shaw.leon@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:53:06 +0200
Message-ID: <2026072006-purely-upload-afbd@gregkh>
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
git cherry-pick -x 8211a26324667980a463c069469a818e71207e02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072006-purely-upload-afbd@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8211a26324667980a463c069469a818e71207e02 Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 12 Jun 2026 16:59:36 +0800
Subject: [PATCH] net: ipip: require CAP_NET_ADMIN in the device netns for
 changelink

ipip_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 6c742e714d8c ("ipip: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260612085941.3158249-3-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 4f89a03e0b49..b643194f57d2 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 

