Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598B4E8E1D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449943; cv=none; b=qoWrc2DidrjAUsi+hayA3ggoWkYjW55/dHyPaTyM/+qWQJvSgdMUz8oop754NBGzRr2pnsUnipsdqN8MMTbJZ2MJVUMN5JxawhkJSLnLXirJpwQALRCedBIb3D7mIR9PzYanQM/Qx82JmoiqHT28Vhz7mw2DWZ0J3u8GkQa0VjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449943; c=relaxed/simple;
	bh=6KOFgS0FvpPkGlnrm+1LZw8wnph7AqeLUo3RPen7uPU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RQdqMHISufjn1ZLkynPJpBO530JGiMuniX2gWeO08DLzE2PNN8Yd7I/yHWiShRM+s8T2/UhFki+SSaIKK5zcrXMaNiTtFW2mnklVAcv6YATMPMOjrlpJOsjs32vCQW/gOIXUIIcLsQsJBXPHSNVACS3/5UUfC1Lc3Y9axZ+4xYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnnXm/mM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnnXm/mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF01F00ACA;
	Thu,  3 Sep 2026 15:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449941;
	bh=DjHuBPLSRkRo/yJqdFMbcLdnxHtSNiOyhmDlg9R4bh0=;
	h=Subject:To:Cc:From:Date;
	b=KnnXm/mMBmxma8n3hnRCUdv9Z44e5LKKY+MxCFjlEkguMs+BWSMjKyccFf2g8NqQJ
	 bhVop9TSmsT34mTxdBBdhOtGI0UMmBRcLzmdnLVirRNJOPLaP6fl5oPRBUBmAGG9vL
	 ujG57pVUlYTneauvhozJbhKEX3sOndzIRbCTvO6w=
Subject: FAILED: patch "[PATCH] net: fix spurious TX timeout after dev_activate()" failed to apply to 5.15-stable tree
To: leitao@debian.org,kerneljasonxing@gmail.com,nb@tipi-net.de,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:10:52 +0200
Message-ID: <2026090352-dealmaker-grope-80e1@gregkh>
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
git cherry-pick -x 82aeed2400786bd3f79d88cb8b8f42e6127e5923
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-dealmaker-grope-80e1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82aeed2400786bd3f79d88cb8b8f42e6127e5923 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Aug 2026 03:50:10 -0700
Subject: [PATCH] net: fix spurious TX timeout after dev_activate()

While debugging another issue today, I found out that my TX queue is
reported as stopped for 4294907392 ms (49.7 days), on a machine that
had been up for four minutes.

    bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 23 timed out 4294907392 ms

4294907392 is not an elapsed time. It is the value of jiffies at that
moment: INITIAL_JIFFIES is 4294667296, which leaves jiffies 59 seconds
short of wrapping.

dev_activate() runs transition_one_qdisc() over every TX queue, which
resets trans_start to 0, and then stamps only queue 0 through
netif_trans_update().

Stamp jiffies instead. A queue stopped across dev_activate() now gets a
full watchdog_timeo of grace, and is still reported if it is stopped
that long.

Fixes: 9b36627acecd ("net: remove dev->trans_start")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://patch.msgid.link/20260825-trans_start-v2-1-286b4d6d70cb@debian.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..4539dc2c6d38 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		WRITE_ONCE(dev_queue->trans_start, 0);
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
 	}
 }

