Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608390;
	b=n+pRmMmxamld8O+cU9sQU10NEuVjxHiU1ixwjyMYfBlbjdRq13t1mYtR6Tz/rOzBxRcg
	 GnyBWcNcD/sjxdmROrRGgiekPVsF0Q+6GCpy/kl4CLaBa6MXFteBZ3+bi9p9tJMRsEt5Z
	 jv0T4BqSU4SSaiBlhqFGfYNt+NUBGqGa6gyx2B/3GJv2EP4Jm4ONFxuO4TbJodgjop2zQ
	 C0xdXpqrzlYNdl47SEjaQFaTfICa/NMs8wrLMrkjZZ4DofX+pX1VD6Io++Dh9JT5VQslA
	 D8fLcwwDBuiLsI0j+hmc8F5be+Sq9gCAoX0XBgPCCwUaqiVwYTBKhDDOqHjFWwQ2HtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608390;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8PljwAoXo1yVVZTGjshLRIAMHmnGcaAnPYnUQLVyOUk=;
	b=dSHg9Lknl/dEBLXA9zSAorLQ8q78u+oDYyz3cS3sGhwuLzqyxLU6c/Wh4X7gPr360qpV
	 Bw1jMKPiIvX/1XdydRaylBbsjLfr+KwN8nZTiFp6nrTOiXR1NE23yeGMsExXIwQx0iYzK
	 yXaO7KedUJWqVIIE++5NdKLynh9xqmuuVAIrHsxMEECUw4TeMUBgnrQVckxAme2yV3nYr
	 pLAlMjWK13q6LTbyclAUMGrZmN4OP0HENCDoBJrm2Jd3oDKTUqiodS/CxDPv/0/dWILis
	 b/58x0JeOUWItoMZJSW9AiXB6ZkLerAfykbO/v8TMzEgFmigFo5mFfbyyrz/iCCy+HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FFuHeE8C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DF606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FFuHeE8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B0C1F000C6;
	Wed, 25 Nov 2026 12:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608389;
	bh=8PljwAoXo1yVVZTGjshLRIAMHmnGcaAnPYnUQLVyOUk=;
	h=Subject:To:Cc:From:Date;
	b=FFuHeE8C2IxudNJ0nZ5DQpo2pdWhnOKdbAqZw/cmyy7KCs/d9D1wbQprhqKU0VuLg
	 Qeho6aptj4DorO/FqXjrtGPU7/ya6SPNwwGF+fTv0AsK5/u+maPJWIW5eQqElCiHIC
	 4LVyMMsAgQp9OwZq6gY+CjCVq/4IuZAgdeNCVWvg=
Subject: FAILED: patch "[PATCH] usb: xhci: disable the correct slot on alloc_dev failure" failed to apply to 5.10-stable tree
To: raoxu@uniontech.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com,niklas.neronin@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:35:04 +0100
Message-ID: <2026112504-tradition-brigade-4312@gregkh>
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
git cherry-pick -x 2f2fe3201029ffc215b46ac40a0a9587715bc43a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112504-tradition-brigade-4312@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f2fe3201029ffc215b46ac40a0a9587715bc43a Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Thu, 5 Nov 2026 19:51:03 +0200
Subject: [PATCH] usb: xhci: disable the correct slot on alloc_dev failure

xhci_alloc_dev() stores the Slot ID returned by the Enable Slot command
in the local slot_id variable.  udev->slot_id is updated only after
xhci_alloc_virt_device() succeeds.

If endpoint resource reservation or virtual device allocation fails
before that update, the error path passes udev->slot_id to
xhci_disable_and_free_slot().  During initial enumeration this is slot 0.
When reallocating a device whose virtual device is missing or belongs to
another usb_device, udev->slot_id may contain a stale Slot ID.
The newly enabled slot can therefore remain active, or the wrong slot can
be disabled.

Pass slot_id, which identifies the slot enabled by this invocation.
xhci_disable_and_free_slot() already handles a missing xhci->devs entry.

Fixes: 3ffbba9511b4 ("USB: xhci: Allocate and address USB devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Reviewed-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20261105175106.241182-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b50a582be1fb..94da0268b7b3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4301,7 +4301,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_and_free_slot(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, slot_id);
 
 	return 0;
 }

