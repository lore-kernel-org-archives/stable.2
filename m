Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084501;
	b=P8asLJLjzsVIKMVIq9xAKd33vEmbSYPdOFq0V2acaQeBsMVEj6W0zEeJwYPj4pvnkf5z
	 hSgLiUmS5ggwiOgONW+JAhsYzJ+/WyDjgSdY8TzQUWVPWt8xyryeMH6KnzKNpUJhAOaBi
	 TvcxhLgJz7+m/2ed+UYPmi2FC7Hf8CZD7z3jnQjIu5wK79hStk5aJ2pGV5DmckYcVbuPr
	 UIuv9Zepm313B7XTyPt48f4FXXZ4sq1LPT9QGsk1PzzY+3X/gmNtZTWEpGuFKyZb/TAQB
	 qzCdsJICnBZkKw2YOI6MLwoJOHCQbmeH/r8E6I0qcsnJuIM/dKXTIrVOvXunMTrwdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084501;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5IU7roZYPT73HzaRWYumfNShgGxpbg+rxFWDb1S+Yao=;
	b=rLlnogRSx03+TDo3kZx6OEcZrHd6SjuFTdeJNtNilvQ7TMBELxpmNaJWptdwfdmv65J0
	 b+UTpMrJi9V0384zBaSAuniPFlFW6b1/XMnj51rJjKUU9s1zxKDKD+90L1KEwnduxBVmM
	 YqKrpeJP6ZH3yqVnefIeq71F+mbDMc7saVHXW7/dsVIfBPfzsNJWbre64MX6GmMCg0hvW
	 F0fKk562iZK/sG24mE5N0m5W+CBsDPG15mmtlHvnDethPvaQs5ejQIAmWvOPLfOYtZX7O
	 x5VxU3iIghpiagBGPVatrt7NKOz3VT6u/57fSDMFwqCY2mDP3KgCiFp8Kb+eZruGxMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HIYB2zSl;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2515606A328;
	Tue, 27 Oct 2026 07:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2515606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HIYB2zSl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HIYB2zSlW/XIaO+X/UKH8FB9q7NjFUCOMkWWhtlqd699eQoQ7SYlw5Eh8q518zG07EW+PcGa0JZAe
	 ZbQbW0Xu1JKoZgBCEtRZYezIB6ZAVgZgE+GfdQvOpyXAWlCCzE83cFe3V3IE2sFbLlonm31Ax4ArHR
	 98ns5gNCNC2iIYUc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae04c52dca-21fbf;
	Tue, 27 Oct 2026 15:01:38 +0800 (CST)
X-RM-TRANSID:2ee66ae04c52dca-21fbf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae04c509fb-d0e58;
	Tue, 27 Oct 2026 15:01:38 +0800 (CST)
X-RM-TRANSID:2ee66ae04c509fb-d0e58
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] nfc: pn533: complete failed queued commands and keep queue moving
Date: Tue, 27 Oct 2026 15:01:34 +0800
Message-ID: <20261027070136.1339-2-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
References: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pn533_wq_cmd() fails to send a queued command it silently drops
it: the completion callback is never called, cmd_pending stays set and
cmd_work is never rescheduled.  As a result:

- a synchronous caller sleeps forever in pn533_send_cmd_sync()'s
  wait_for_completion();
- an asynchronous caller is never completed, leaking its callback
  context (e.g. struct pn533_data_exchange_arg, and the sock_hold()
  reference for rawsock);
- cmd_pending stuck at 1 makes every later command queue up without
  ever being sent, freezing the device until unbind.

The broken error path is as old as the command queue, but it used to
require an URB submission error to trigger; a device that stalls the
OUT endpoint reaches it via the send timeout added by the next patch.

Call the command's completion callback with the error and reschedule
cmd_work (unless the callback chained a direct command by returning
-EINPROGRESS) so that every queued command completes with an error and
the queue drains instead of freezing.

Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nfc/pn533/pn533.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index e2bc67300a..3087f4f347 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -572,9 +572,15 @@ static void pn533_wq_cmd(struct work_struct *work)
 	dev->cmd = cmd;
 	rc = dev->phy_ops->send_frame(dev, cmd->req);
 	if (rc < 0) {
+		int cb_rc;
+
 		dev->cmd = NULL;
 		dev_kfree_skb(cmd->req);
+		cb_rc = cmd->complete_cb(dev, cmd->complete_cb_context,
+					 ERR_PTR(rc));
 		kfree(cmd);
+		if (cb_rc != -EINPROGRESS)
+			queue_work(dev->wq, &dev->cmd_work);
 		return;
 	}
 
-- 
2.39.2



