Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAB2FE56A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333224; cv=none; b=pSgbmHxDJdY8O4plH3grI4XvLmZfsq+hdXG9uIr4AzuO1K1rRtSfMu+ir3jFxIepzwT/Ns+aMideGaEGuPxPM4UXssQ7vckBb/QgIGB6N9aE5qbSwpz/ydW4pAjyYLUIhA+EIY+1CBIWKDHeUUev4C/UgSqpqtVI7Rur5mutRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333224; c=relaxed/simple;
	bh=IR9RgDelTAuYZ9tgimUZmNESahbOgSgcF/GU0KLrTJM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nG9G5nMZwLRLvMSSfyi29EmcXbYmglUWKCZUqfUV1nB2YL5fmZOwmYz9RzgZuczj9Mxqvlt1wRpu3hKlVBhQzbZteKpkDziDu/OzWjFbSOA7+2rQn934jVfhkRNNhOMgrEEqloQ600GUZXSkGPOxywNfq5IWLgoLlhzgz6BX+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqO/9PEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqO/9PEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C741F000E9;
	Wed, 29 Jul 2026 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333218;
	bh=2LBEYoAOoJBD3GzBLhRetuCCDsK3LwD2R+cUJrHnqCw=;
	h=Subject:To:Cc:From:Date;
	b=MqO/9PEcjYnGi/4+DZpwEStx8KO4V2dRExmDQBglSW7I1/H744ApoZSMUabPvJSGY
	 uwm0YfwXUM6bazkTSdw/jkvgJCTU4BOJE3rjskWdXNIH0Kfw9ymZTNbjjX7zsRaSAh
	 Plls6xLU6dn+Iz2WfmOJkUtlwo6XQPibMwxRxDXM=
Subject: FAILED: patch "[PATCH] net: qrtr: ns: Raise node count limit to 512" failed to apply to 6.6-stable tree
To: youssef.abdulrahman@oss.qualcomm.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:53:18 +0200
Message-ID: <2026072918-freight-unsworn-15e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ff194cffd586cbd4cc49eccb002c65f2a902a277
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072918-freight-unsworn-15e0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

