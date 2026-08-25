Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4541A92A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663886; cv=none; b=B+wLeECZQW6XJAQHpBMXIo56rKBLbgtmKa3SlwUbAzYjXqWsALxaAsU+XBfzgq4pMHI9FdPG25JktShIzrZgPnhNOxiCrtK1u1qUI2/9Q2FcT5tGoQmoc/VwAqjCQG6BdaT4Yv/W4jzJii1xmWxZ5AvtuhcKjnCORzfBtV2IFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663886; c=relaxed/simple;
	bh=Yd8cqtgc9JJskEwY2WkYm1FNwlbEvj9UVKtuKt1C3Vw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TEUgYpMzfYASRKxy3m52jzDlAaeJZ3sm74mpq7RdPOo0CZZG9rhMPn4c0x9qRpt+hvG/uNBtSEfuxD9cWHzpTCfJzMLQ7O19d1igEMdyiSyRWLMuWCS0eDDFenQnvh5T0HO80inwwQvFryaLXYYeqo2j59MbvzG0+h4vzRfxXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SLfriYda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SLfriYda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2471E1F000E9;
	Tue, 25 Aug 2026 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663885;
	bh=FJYFDqikEjDeOD7+vGpOSnr8zX1Xk+3RSNGxmvL410I=;
	h=Subject:To:Cc:From:Date;
	b=SLfriYdaxX9oiCn70MutB/UWaue/aHyW+vTRKXW0VBaZbA/1VfPrP3iuQ78e/DupN
	 pvm0jC6dPwzXvENJl3pblXDV8UVHE5DFwW3AU6lJla77VzdvSVqqAMUIKf+9GOcKGX
	 CayI6O6CaKX53dXH+4cB3e0cA0ndIoLwrlMQK148=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_event: validate LE Set CIG Parameters response" failed to apply to 6.1-stable tree
To: acharyalaxman8848@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:17:59 +0200
Message-ID: <2026082559-suspect-staff-6aaa@gregkh>
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
git cherry-pick -x 0acd4eeb4b225b9bebbf9ef96cc10cdd79b94899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082559-suspect-staff-6aaa@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0acd4eeb4b225b9bebbf9ef96cc10cdd79b94899 Mon Sep 17 00:00:00 2001
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Sat, 1 Aug 2026 23:54:52 +0545
Subject: [PATCH] Bluetooth: hci_event: validate LE Set CIG Parameters response

The Command Complete dispatch validates only the fixed part of the LE Set
CIG Parameters response. After that part is pulled from the skb,
hci_cc_le_set_cig_params() trusts num_handles and reads each entry in the
trailing handle array.

Matching num_handles against the command's num_cis does not guarantee
that the response contains the advertised handles. A truncated response
from a malfunctioning controller can therefore make the handler read
beyond the skb data.

Validate that the remaining skb data contains all advertised handles.
Include this in the existing response validation so malformed responses
also follow the established CIG failure handling.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9c8bf6708356..6890d60ade93 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3865,8 +3865,10 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
-	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
-			    rp->cig_id != cp->cig_id)) {
+	if (!rp->status &&
+	    (!cp || rp->num_handles != cp->num_cis ||
+	     rp->cig_id != cp->cig_id ||
+	     skb->len < array_size(rp->num_handles, sizeof(*rp->handle)))) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
 		status = HCI_ERROR_UNSPECIFIED;
 	}

