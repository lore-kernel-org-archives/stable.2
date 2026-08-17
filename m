Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D334F49F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966373; cv=none; b=DIf6N+mgErImiWyy8ddz1APpEU1tKy8/urhnG3UEXWA9lozYpdwBjd1rpTIi6oEpqRWq4TNsoxzJS84TAcmyzSoiGCXKMLGmrmeJsao927reTN846GJs+CfYfCnm0IqMFxOKdAgLl4QBf4+q4Iz1gwVYBan0FRtylynoSF76cNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966373; c=relaxed/simple;
	bh=jOkqQaDdc4gxbQ5UK3Q9I4mCKGbcFpANG7Muf8ZVpTM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mw8ueSO+vRjPx8GvGiBC2xNfgR5T6GI9uRiwWLigdtbJbswzQHdyErnQq7wuDBqAxqOOcmRkpDixuwvs/D4BUZ4dgGLxpkUL+T9cAXX2uj/N/TQFJ0L52PkyBStdn5seV6M+K02azksQkCeODRB29JQhp3gDHp5lTF52on0NtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vW6VwkR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vW6VwkR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81E31F000E9;
	Mon, 17 Aug 2026 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786966371;
	bh=qVvf4lZaUcuqo9Ix1OZGRXzLWeEI8RFmzKmtY4rfQuU=;
	h=Subject:To:Cc:From:Date;
	b=vW6VwkR6mwBPbU8U1JuYx3Yx9X+HL4jiA+sFjEVzNF4XOdF239f17AsIYKz6NY7oP
	 mOR2CscTd6lGfPIblrZom1RQxyIO6WGABzaaYfVO8enD8htUqkD3Q1o4x2eSlzmmqr
	 PibtOKVgVTg70CSgJ31C0lKef+NjglU6TY22W39s=
Subject: FAILED: patch "[PATCH] igc: fix netdev not re-attached after resume if interface is" failed to apply to 6.12-stable tree
To: pd-lkml@3b.pm,aleksandr.loktionov@intel.com,anthony.l.nguyen@intel.com,dima.ruinskiy@intel.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 13:31:08 +0200
Message-ID: <2026081708-decrease-satchel-2a72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b0ce5fd9fabe7c79463cf4602217d4dfeff5b1fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081708-decrease-satchel-2a72@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b0ce5fd9fabe7c79463cf4602217d4dfeff5b1fd Mon Sep 17 00:00:00 2001
From: Philipp David <pd-lkml@3b.pm>
Date: Tue, 4 Aug 2026 15:22:03 -0700
Subject: [PATCH] igc: fix netdev not re-attached after resume if interface is
 down

__igc_resume() calls netif_device_attach() only inside the
netif_running() branch, so an interface that was down during suspend
is never re-attached on resume. It then stays in the not-present state
that __igc_shutdown() set via netif_device_detach(): ethtool reports
ENODEV and every attempt to bring the interface up fails the
netif_device_present() check in __dev_open() with -ENODEV, silently,
since __igc_resume() returns 0. Only reloading the driver recovers the
device.

This is easy to hit in practice because NetworkManager brings managed
interfaces down before sleep unless Wake-on-LAN is configured, making
the adapter unusable after every suspend/resume cycle with WoL
disabled.

Re-attach the netdev on every successful resume, as igb and e1000e do.

Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
Cc: stable@vger.kernel.org
Signed-off-by: Philipp David <pd-lkml@3b.pm>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260804222205.1580328-11-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 16fcc8cf6191..39043d8ca1bf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7585,11 +7585,13 @@ static int __igc_resume(struct device *dev, bool rpm)
 		err = __igc_open(netdev, true);
 		if (!rpm)
 			rtnl_unlock();
-		if (!err)
-			netif_device_attach(netdev);
+		if (err)
+			return err;
 	}
 
-	return err;
+	netif_device_attach(netdev);
+
+	return 0;
 }
 
 static int igc_resume(struct device *dev)

