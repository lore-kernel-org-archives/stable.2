Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B90330B07
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471189; cv=none; b=lPLlgoZS4Cfo2IIQAp+pPy6F/XK3L1ofo+rdhSSydxg5QBguU6ZQMaB+8ONi8vAUcngVClOnOdMuSXhRj4SGPLcN5dw55bz15QAVSDJ+NmZtI5C0PXectRcI7mgBz/XqYLjwPVEEb/KK/LgU+t7efvJwFTZzemq78zvXWKTTyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471189; c=relaxed/simple;
	bh=T3S7mGE2dmx0pn6MJPdSh8dkPns/6Vb8QQGnuqm1lSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZDS0GttZA9TKxBprRqb5mtbALBhPQam6hlz2BsDfxLoeTyWYEEuQgVwkITWSHRhFoLEInS3Cy1CaGy65gXQfGWZkKx5pcSuJqYvSMvvX/ofQZgFW+8ZSdfrdEesnPC99qDZ7YGNz1zcc2E7fX4kq6jg3WHC7c1KnvTwZdhlT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7lEOi10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7lEOi10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8338C1F000E9;
	Sun, 19 Jul 2026 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784471188;
	bh=5JUF41dhjDns1uGWMoZVEfibGI4ajL4PCEoL1/0PmdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7lEOi10298+Os6jKFtGuukJYAurKO8K0Dd66fDPWI5qik/9y0mxeGWTapDv/6OCd
	 qO6h3Jf3nirdUlivASnSEKyjF5Q9q1ArcM2XYbXi0WASAhDwSSiiUS0fiAlgt/Jm8s
	 1noIiCEoQlcjgnJaICx6GsJMcmj3IRut5ev40Wj3HFI1daUk47MMdb7tugOqF96ayE
	 sTdUbD72NecBYz/UiaWXkN6JjyicEyg6OYY/hgfg+XszL5Sgm+N+EpUXs6Z5Obz9cz
	 Tj89SPMFuHdA3fOZBliqQ0OedOkT4JBgL15ZSmF3Ajb+naSHbgtD54edjhj/GXy9rG
	 +FnDta4+OaImQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: free iso schedules on failed submit
Date: Sun, 19 Jul 2026 10:26:25 -0400
Message-ID: <20260719142625.4094867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071434-steed-earmuff-b781@gregkh>
References: <2026071434-steed-earmuff-b781@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit b9399d25fbb34a05bbe76eeedd730f62ff2670e9 ]

EHCI and FOTG210 isochronous submits build an ehci_iso_sched before
linking the URB to the endpoint queue, and keep the staged schedule in
urb->hcpriv until iso_stream_schedule() and the link helpers consume it.
If the controller is no longer accessible, or usb_hcd_link_urb_to_ep()
fails, submit jumps to done_not_linked before that handoff happens and
leaks the staged schedule still attached to urb->hcpriv.

Free the staged schedule from done_not_linked when submit fails before
the URB is linked and clear urb->hcpriv after the free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
EHCI host controller with a USB isochronous device to test with, no
runtime testing was able to be performed.

Fixes: 8de98402652c ("[PATCH] USB: Fix USB suspend/resume crasher (#2)")
Fixes: e9df41c5c589 ("USB: make HCDs responsible for managing endpoint queues")
Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260630071419.349161-1-dawei.feng@seu.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-sched.c  | 11 +++++++++--
 drivers/usb/host/fotg210-hcd.c |  6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 0f85aa9b2fb1a3..3e636fe5b056ca 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1625,6 +1625,7 @@ iso_stream_schedule(
 			status = 1;	/* and give it back immediately */
 			iso_sched_free(stream, sched);
 			sched = NULL;
+			urb->hcpriv = NULL;
 		}
 	}
 	urb->error_count = skip / period;
@@ -1655,8 +1656,6 @@ iso_stream_schedule(
 	return status;
 
  fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -1968,6 +1967,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
@@ -2345,6 +2348,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index b0b6caaa29bd44..7e088f7d93f8c0 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -4275,8 +4275,6 @@ static int iso_stream_schedule(struct fotg210_hcd *fotg210, struct urb *urb,
 	return 0;
 
 fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -4570,6 +4568,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
 	else
 		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
 done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&fotg210->lock, flags);
 done:
 	return status;
-- 
2.53.0

