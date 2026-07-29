Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3F48035C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333226; cv=none; b=seHnHtmenjHgtXUdlKTele6VSI6FAdXfNBz2YqZWi+aLvAJvKcUgbbr8pppTcPQVsoZ22F/1ViEtPCxjXyUJU1gBES8eQzPTwsLdpQbJLYIl9RXG9h9WK5n738Z0iWWnw+ztkssjH/H9Bc5ztDG8StwjjOdIbSNgT2h0fzF7igU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333226; c=relaxed/simple;
	bh=bblJ2BG7+EGxKrmUw+w5Bk7Rwbr+XFlFQHXRIgfT+20=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xucu694hRG5na0KAuJGzhKziyG1GW0Z8/nXeEuq6pZqBto0zy4hNPArK2Dhfkol83zfqRI/0GAJGPym31w1prTJxUCdBiS1Ex3IIREGJLkBZLheanN+i7GLP3S+RD+31EVzDKIr+dJ1OdAFrgA0PTNKjZ4EdbE2Z6abbXsTJAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lLe9G+RK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lLe9G+RK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5561F00A3A;
	Wed, 29 Jul 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333221;
	bh=BPB+hjjOpDWMfgi5vWCsA0begyNyF1H93jTWhCHx9jc=;
	h=Subject:To:Cc:From:Date;
	b=lLe9G+RKusWA8rDo94s166zUD5hdnA7E09yOkN21gOapPUWaWdrPGqYABUDQVpQ5s
	 MiHkM30bS/EveK2diygGHVdOjRRGTzY7oujYdE3wrSoB7CE/WlFM+IuJyd4Y3jNmsO
	 xCueTmDhZcu7/rmJQ5Ifv5D7mPnsOpqUcMM4Z8Ts=
Subject: FAILED: patch "[PATCH] net: qrtr: ns: Raise node count limit to 512" failed to apply to 6.1-stable tree
To: youssef.abdulrahman@oss.qualcomm.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:53:18 +0200
Message-ID: <2026072918-throwing-steep-c08d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ff194cffd586cbd4cc49eccb002c65f2a902a277
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072918-throwing-steep-c08d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

