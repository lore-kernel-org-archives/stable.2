Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608425;
	b=H/fd85k8MaKxYo2/nzrcO4PvnqbRSPqEZfv5bU8IBBZ8gsU96YsWBedYqTrgwaX5qV+V
	 yIILyUBRN/xTs4CqQlHaR4KSLNo7G60TtNaSD17Mje1Kiqh4pl2M7d2bCBgVeFdn9ejA0
	 m5E23z+s8kqRqK7mc61HwkIyedKbj7odsvaU1tqrWUx6xGOTLvaoAUYf2TFu8ttvQTQEj
	 fGQWGwkPQ/Bd7YXVlCBCSLoqoIC5+bJKhexOsqIwoUsFzbTOtTaeLWqqdR/lJ5aJgJ8ZU
	 wmRRObIQolrQKikyew1wfOTBRtNAfQINVBkugBZw+pRwEXhME05TlSvSgWwvYIPeYFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608425;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M2d85pdpEl6MwT1Dzjdmf1/FtLsxGEq0QUmnyMoAnKA=;
	b=DE+dDLbZ36B2nn57btfLtWW4V0seOMjzoo8gKGt1dwnd7OzHXBO4NbWG/VE6y5mBXVZw
	 FrV8zFc/MTVsaDHJ0saVrQvr+Cmmb4HkUcdc+4+cyf9ZvDKjXUWs6CX0szjXuCZ8dC/ax
	 MyyMXRylDm1U2xBrNFuelgI55fxus9iOyw0E/zB6xXc7Cq5ZI5A4f3J6grUvdExf8j+4r
	 rJ2bv7nqxD3SfS3JglQkDw6aWPSJvsNcoBP7Fcm9ZzO2itI3xyHDQsCiIJtBAnLuFZMNb
	 pPkAJ/Gw+AQjajlAPQMwNw/a5JKX/WiEYX+okxnMZ8I4c1kvugqL9oDRFiBnJ7kYblQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K9vQmJeF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B5606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K9vQmJeF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1F91F000CF;
	Wed, 25 Nov 2026 12:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608425;
	bh=M2d85pdpEl6MwT1Dzjdmf1/FtLsxGEq0QUmnyMoAnKA=;
	h=Subject:To:Cc:From:Date;
	b=K9vQmJeFne81mPsgRS39fhgYuadXlYw+p3qhccR+aVYeDW/WrxAYalpX/YCIGPTQH
	 Kopqtre+GFvBOuISXX89W8cZWeenfiH8G8+B5qwhgy9LbsYL0rWLwG0eH1Em8kkiot
	 zKo8BJrCP3cZUZ6XCFwRbFASkGL0ZBWUXj9teb48=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Track a timed out End Transfer" failed to apply to 5.10-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,selvarasu.g@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:41:21 +0100
Message-ID: <2026112521-mating-confiding-a0fa@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x af91c6322e633504aa45de278f5d520f39d127be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-mating-confiding-a0fa@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af91c6322e633504aa45de278f5d520f39d127be Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Wed, 21 Oct 2026 00:37:56 +0000
Subject: [PATCH] usb: dwc3: gadget: Track a timed out End Transfer

If an End Transfer command with CMDIOC times out, the driver clears the
resource index but keeps DWC3_EP_TRANSFER_STARTED without setting
DWC3_EP_END_TRANSFER_PENDING. The command is still outstanding, but a
later stop issues another End Transfer with resource index 0, and the
next Start Transfer fails with "No Resource".

Mark the timed out End Transfer as pending so that no other command is
issued to the endpoint until it completes. For any other failure, there
is no outstanding command, so clear DWC3_EP_TRANSFER_STARTED.

Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/5815c41a7e7923edb114741f29697cf0161f523c.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eb6666b7bb98..df5407e75788 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1798,9 +1798,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt || (ret && ret != -ETIMEDOUT))
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	else
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;

