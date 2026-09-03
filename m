Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87914E66D0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449932; cv=none; b=t60oYgdnWb2FvVSUMgRFb7YTAtWlJjyztESAZYq4MhBtHM/0ZN/btInDz80eznzJfNMih4EpW0ogY/fptdvDoU2ucOBNdlN7pW+c+hYvNw0L6iJ3iH24DZsZek+Qt6kMojfwJS/GEQykSPyDPMk6e5oTCd1x1gLOjRGsTtzTn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449932; c=relaxed/simple;
	bh=E0R0UKPZpEoiGbr3IJHimyfk792GJk1ri6TkQ7aZNxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kugfd5uAhnM5VK0bxyscb/oSz2e7OOAI70pfyQFeKm8CRDGUSsdHYSrlzyOe7KGpcbUjbdwgQufiVjN2CTqBAVvEh5p3GXcSIIcwn07HMaNwuTKrvOwR5CH3gFqdE/Ylls2aY8Q1d3aRonw/pFn8LNhn9l9tgU9aP/qh/gkRuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFId4GXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFId4GXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02F11F000E9;
	Thu,  3 Sep 2026 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449930;
	bh=5uo9sY2iit2oojKknk/6vIwTjlHLF+5o8zwZLsHG6EA=;
	h=Subject:To:Cc:From:Date;
	b=ZFId4GXFxF1cpjUX8iim09qzFsRdTfcL3T0ws2xpMt6i6xzZkNDUafc+ivCBNr6we
	 mTN74eothazW5YVLnb2PpySJFTSV30Bhtk+1hPOZ4Obc0/ixuT3Wxh2rHl2Fqp1C8g
	 EEFrDCVodli/etiZIHCJSnh5Ov0CJ/4imUQ4DMu8=
Subject: FAILED: patch "[PATCH] net/smc: stop killed, freed and out_of_sync sharing a byte" failed to apply to 5.15-stable tree
To: hidayath@linux.ibm.com,horms@kernel.org,kuba@kernel.org,mjambigi@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:10:13 +0200
Message-ID: <2026090313-litter-deputize-53d5@gregkh>
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
git cherry-pick -x db51a8658c11a82432b64999519a269c3aabb447
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090313-litter-deputize-53d5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db51a8658c11a82432b64999519a269c3aabb447 Mon Sep 17 00:00:00 2001
From: Hidayath Khan <hidayath@linux.ibm.com>
Date: Thu, 20 Aug 2026 09:46:41 +0200
Subject: [PATCH] net/smc: stop killed, freed and out_of_sync sharing a byte

The three connection state flags are single-bit bitfields, so they occupy
one byte of struct smc_connection and every store to one is a
read-modify-write of the other two:

    u8  killed : 1;
    u8  freed : 1;
    u8  out_of_sync : 1;

They are not written under a common lock. smc_cdc_msg_validate() sets
out_of_sync from the receive tasklet, while smc_conn_kill() sets killed
from process context under lock_sock(), and the receive path does not defer
to the backlog when the socket is owned -- smc_cdc_msg_recv() takes only
bh_lock_sock().

Give each flag its own byte so a store no longer touches its neighbours.
All readers test them as booleans and are unchanged. struct smc_connection
grows by two bytes.

Fixes: b286a0651e44 ("net/smc: handle incoming CDC validation message")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260820074642.966856-2-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..427b6d63b993 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -277,9 +277,9 @@ struct smc_connection {
 						 * 0 for SMC-R, 32 for SMC-D
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
-	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termination */
-	u8			out_of_sync : 1; /* out of sync with peer */
+	u8			killed;		/* abnormal termination */
+	u8			freed;		/* normal termination */
+	u8			out_of_sync;	/* out of sync with peer */
 };
 
 struct smc_sock {				/* smc sock container */

