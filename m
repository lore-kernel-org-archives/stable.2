Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086649219A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333230; cv=none; b=u4/FOYju5A4pDYxkXgDbHRXOpj+YP4AVQpD25QtMaI1QrF/UDXNJoQCXXhNWFEJ0VB1MeDkqqLMp0M2nviMlDhC/cvSuFsU2Qahb2WOQYR5eIGLkepzMUX8Bfs9wo6IVxnntnUyM3FjfmX7GF2hVjqvbyC+9Xz4F4eu6FiOe9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333230; c=relaxed/simple;
	bh=zC1KEbInX7Lsl4P1yQz51sMSc/cImC+Nn+lIyoyBzQM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oJ2rewvlEDD1IbMPtdQPOwWpjuWJ40MCOlnOzl5cDTToMFQN6cmuDBTaxAXXBBh4PWoOeMXGZTq0Me1vgIkpvoA6LxlUdxDBCzDpNoc8Kave0L1ap2q9NrJQbN0qUeNyLc9nr3Ijc4v2MDF33OWryi9vIF7B/LBH/bbWGDhPrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl4BY4Bh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl4BY4Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560221F00A3E;
	Wed, 29 Jul 2026 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333223;
	bh=N4cdkQVKdhSqaKLaoj2Mgpc/9io+JmVMOzPeBdPdiP8=;
	h=Subject:To:Cc:From:Date;
	b=Yl4BY4Bh+mkBjQU+Xy8/CqOfDZCuluwnVH3V13iy/tpj0AQ5+gVpAs//E0NgLHYTm
	 9uIdnymOsR0FgyyCSZ4obLU+yHKgZd8nNKoGs5e2eQXxC2fyBDhc+cLFZBUHYzRken
	 OO2FYIVLP4HR+LPIdFApsyfCDjXfq5q7mg5BbYek=
Subject: FAILED: patch "[PATCH] net: qrtr: ns: Raise node count limit to 512" failed to apply to 5.10-stable tree
To: youssef.abdulrahman@oss.qualcomm.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:53:19 +0200
Message-ID: <2026072919-footpath-target-57cf@gregkh>
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
git cherry-pick -x ff194cffd586cbd4cc49eccb002c65f2a902a277
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072919-footpath-target-57cf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

