Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FB48EBFC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333232; cv=none; b=Jw6oFt5O8DCAFGX/ie37ZWIvqAEChWU6jVsM/yaY/ghkEBJ8qbO5XHxkn2r/luSDHdSFGQVRbZpPpOn4lWE1VHc9J/NQ3mvrW7tDjrg7bJs5EHJvu02gqMaXz+pzwZQWoFvI6OyDoG7OYKia4t2khIzcoMTHRHjeuQAa92oU5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333232; c=relaxed/simple;
	bh=ZTszzNu6lt6Ogd0MGzzTvV4EdxzY81MJO8InvHnPyaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Dytnrszhz4W6b1focb8vC4fYIT+9Yg/B9h3ohikT2eGu3em1y17Gt1sJ2Cb0C2Q6Nj/ePjsy15Wqsy6cIfONFy7SvJgkpXbPNPfLIaKw+FMPqGwQ00Wg/opiDhwFNl4Yf43eR/YRnGGabKkc4EiMO9wbKX1EjlD3RSKz7OJCh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bu8Q+6E5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bu8Q+6E5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236331F00A3F;
	Wed, 29 Jul 2026 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333226;
	bh=zjKv7xdpSKY6Ay2jXiLuCqBXiaPTvAwnDFCl2FHTfyU=;
	h=Subject:To:Cc:From:Date;
	b=bu8Q+6E5kNIyceUyjMUBHGW0e82iVs4ya6hoVVXarUKb1QaiCQOeGmwcnn/GxOAO3
	 i3nXloI6s22aMFcEeRyyBU2eC+XQ/ahDLPApNumFQb+YSLdN/Ycldhdeq6TKUApu6B
	 oeevrKo539XcfxuUVA23mFZmSofL2vcmZA+yVq9Y=
Subject: FAILED: patch "[PATCH] net: qrtr: ns: Raise node count limit to 512" failed to apply to 5.15-stable tree
To: youssef.abdulrahman@oss.qualcomm.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:53:19 +0200
Message-ID: <2026072919-duly-quintuple-1304@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ff194cffd586cbd4cc49eccb002c65f2a902a277
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072919-duly-quintuple-1304@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff194cffd586cbd4cc49eccb002c65f2a902a277 Mon Sep 17 00:00:00 2001
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 16:59:01 +0200
Subject: [PATCH] net: qrtr: ns: Raise node count limit to 512

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Link: https://patch.msgid.link/20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b3f9bbcf9ab9..e5b2adb161d9 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -76,11 +76,11 @@ struct qrtr_node {
  * requirements. If the requirement changes in the future, these values can be
  * increased.
  */
-#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_NODES   512
 #define QRTR_NS_MAX_SERVERS 256
 #define QRTR_NS_MAX_LOOKUPS 64
 
-static u8 node_count;
+static u16 node_count;
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {

