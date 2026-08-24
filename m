Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D27349CEF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579782; cv=none; b=QMU0b12DFC8lTFgiovyT4RzKqOLNPjWNCrSXFlEe2LlV4qOZslBEeK7kdgzccX21Nv/wGH45UEmpkGR3MdoI0Bdr6SaZg+HomcXzfOQYfHd2rGXJ43ERtZbO+2L9eq6rHynhh6MnHU/3IDhB1rfzlzk4UIIGJY73Utn3RdHOXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579782; c=relaxed/simple;
	bh=R4LheTB8H+yd3eXJ8K3Mg6V3c8kGBnC0FJux5QRiPbU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lEOjn/y0knf1+04rG6eiv5DJFUu3KwrFrpY2AoZt4+kjydybvoYKD77iWShGyd4fGb17f8oyuQyQDFxNU+Tmn8b54c2NU+Yp3ZgYBAeQsF8ckTUEZEgrTCBFFDS51Kr4jg0U5e2hCMNJNJGMV4NbkliDiAwQTc23dF1ecx1lsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7JNS5uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7JNS5uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4907C1F000E9;
	Mon, 24 Aug 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787579780;
	bh=L5O3yEioq1wPKzW5XsiFVxQi2dgKmfUk+zwvywLsRq0=;
	h=Subject:To:Cc:From:Date;
	b=P7JNS5uhnAwiiQju+QWEByG68VbROnXE6O/hEQO1gGCyOl0wTvChdCqJtEbpw9UoO
	 DfRfMnQQDlg37S1co0flYmVJscaX+LcuKQJmEedzdRgMeJ0hjDEG0EsjFHee0d6BG+
	 1BQp0WpDWmHm+jJyGgdM5RRXy4eTcxwD3BfeHIIM=
Subject: FAILED: patch "[PATCH] nfc: nci: fix uninit-value in the RF discover/activated NTF" failed to apply to 5.10-stable tree
To: sam@bynar.io,david@ixit.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 15:56:17 +0200
Message-ID: <2026082417-repent-kilometer-e0ba@gregkh>
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
git cherry-pick -x 8cbe06c1e699c0a165dae5093a2550e65f914818
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082417-repent-kilometer-e0ba@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cbe06c1e699c0a165dae5093a2550e65f914818 Mon Sep 17 00:00:00 2001
From: Samuel Page <sam@bynar.io>
Date: Fri, 26 Jun 2026 10:03:01 +0100
Subject: [PATCH] nfc: nci: fix uninit-value in the RF discover/activated NTF
 handlers

nci_rf_discover_ntf_packet() and nci_rf_intf_activated_ntf_packet() each
parse a notification into an on-stack struct (nci_rf_discover_ntf /
nci_rf_intf_activated_ntf) that is not initialised. The RF
technology-specific parameters are only extracted when
rf_tech_specific_params_len is non-zero, so a notification that reports a
zero length leaves the rf_tech_specific_params union uninitialised - and
both handlers then pass it to nci_add_new_protocol(), which reads it:

 - discover:  nci_add_new_target() -> nci_add_new_protocol();
 - activated: nci_target_auto_activated() -> nci_add_new_protocol().

nci_add_new_protocol() uses nfca_poll->nfcid1_len as both a branch
condition and a memcpy() length and copies nfcid1/sens_res/sel_res into
ndev->targets, which is later exposed to user space via NFC_CMD_GET_TARGET.

  BUG: KMSAN: uninit-value in nci_add_new_protocol+0x624/0x6c0
   nci_add_new_protocol+0x624/0x6c0
   nci_ntf_packet+0x25b2/0x3c30
   nci_rx_work+0x318/0x5d0
   process_scheduled_works+0x84b/0x17a0
   worker_thread+0xc10/0x11b0
   kthread+0x376/0x500
  Local variable ntf.i created at:
   nci_ntf_packet+0xbc2/0x3c30

Zero-initialise both on-stack notifications so the union reads back as
zero when no technology-specific parameters are present.

Fixes: 019c4fbaa790 ("NFC: Add NCI multiple targets support")
Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Link: https://patch.msgid.link/20260626090301.2139500-1-sam@bynar.io
Signed-off-by: David Heidelberg <david@ixit.cz>

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 87f76a29f0ec..f5c9a8ab7ec1 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -440,7 +440,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	const __u8 *data;
 	bool add_target = true;
 
@@ -710,7 +710,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 

