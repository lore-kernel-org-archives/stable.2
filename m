Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114802;
	b=alNkdVTzDamDqIewsE6u8y5TYJHtExhq1I4gQa2EZ4nT0e15mqqE0+kTxqiBTMTDvR7J
	 t2JzWcL3J61UM2EkRdCXzFUpjh/M99XJH99/Mg174mGvmtnbVc3tmsqfnnWS7nv+Bi6yX
	 rfJitsIOH0tIbDE47Bs0r8uKCuVjN2EY3TU0ASB7dt/1kZ+klYM8uLmNWodUl4s23RWIs
	 bKt3g3Dc107AqkLU0AdCBVZ9pQhxBk2SGL5+dFm9NhKsCTDixZmdeWQRpDjrYUKpldhx2
	 5mrHH9Ikew0du8JLpeGe16TSHDvQo3aDFogIaVX4yVUReHgJSuAvz/BxIK5TT9BJbJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114802;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=8rPXHlRjc/KL3pUvSAM710RL9aTYgfwMkHA+b32wY5A=;
	b=M7uNi/afQNWC7JGU9TRGFhRgG1mUBHdcCPVoxKqOWakR37s8XMGqEE78ZVKpDT1bFZ/m
	 dQajB660a3emZgPEauAjuiOre1bHUZNlEc9c3jKmBvRssp2aYAIq2yzi72+lVKYa0l/4E
	 iEVXmXf81qwy6wnD6dpXHuJYufieH1kq1b6VP8KKbPKg9c0UNWwXVZXui+GBhsYMI9UUR
	 cKKPep3oNmL07QuPOO+GPKRojxK77NxYAz4qQfOH7vkuw2+imm7pMjuEzXSRzV0D7Pqmf
	 NZYVylPxtN1mo1OAQoJdPvSBkEA9Nin5xEz+H7VgB/+2oo8xznDoX8vA9Ik5zpAH24w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fhFulz9h;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CD606A320;
	Tue, 27 Oct 2026 15:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51CD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fhFulz9h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=8rPXHlRjc/KL3pUvSAM710RL9aTYgfwMkHA+b32wY5A=; b=fhFulz9hNNpsZAjM0R00zwyio5
	/AgtiXls3rwE6QSoIm2STvTJvie5vRJfNClxneCGVRtHmcKh51lUprwG9QckgrkKX7fz8g3y1K4hL
	edbinFr1KB/gCzUjVQfTDDL+oHdcQ5EzjXVcvOmZ5QxuHDgbsEHDi6gHW6cfxcm5jv/ejTCF3AruS
	FR6n0/8qR8mmt6lvfUvM7vBzTGHkFM6bFg1/4VJiZBg7gQHrVeLggUg/UL1oBdnHbmEV/lvIX7iyM
	PwA0UdxQFGZ1NQTZPGxOsZs/n/jOJjnBHWcTboN8Wg4Ll0altWjlRSBmFPupVfcYP2Q4xmqhLCQMk
	h703HYZQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLj4P-001YPI-2w;
	Tue, 27 Oct 2026 15:26:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 27 Oct 2026 08:19:14 -0700
Subject: [PATCH] mailbox: pcc: Complete the transfer when the platform
 flags an error
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org>
X-B4-Tracking: v=1; b=H4sIAPrA4GoC/x3MQQqDMBAF0KsMf20gCTJtc5UiInHU2SQyKSKId
 xf6DvAuNDGVhkQXTA5tWgsShY6Qt6ms4nRGIkQfOfj4cnvOo5hVG3/nXIu4T7/078zBMzM6wm6
 y6Pkvv8N9P8JiFm5iAAAA
X-Change-ID: 20261027-pcc_error_txdone-94f48c610666
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=leitao@debian.org;
 h=from:subject:message-id; bh=8VvKEi077C3DgqMyLzbKzwZn1Bd27N9nRzv9ISQrZBE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq4MKpArfCfIRsuX+/OQTkHBl1ORnbLpkYmdHk3
 cXvOGuIIBuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauDCqQAKCRA1o5Of/Hh3
 bftDEACP+IJOfNEijl/sIWguAToYBtVx7TXpboYtbGXkiVzg6UpuNLpUJ7ru9Qej7tLAvWMvohx
 7IHg1nOZ2TvYxDYhXx9wl31H3ZYM7u3lLhMtIHE0vAJFyRLLBDL1NaWpA/XY17XWCQTMcbXPvJY
 19D5eKG+mxEQOUAefwylTYRMOWpXAGA4S4b6jh7BE/knu2DmqD6rzUEXWkUcLZG/gxAURvyYYs4
 vIWgNN11FnWZs7eTwxuUdSmcLU84rdI5+/EHeaPiJzU/pKcqNE1KxOiGDNIjoTlmQtEtT15sdXB
 lF13kHnzAnJeLrY3WmO4g1yjyzNB39Q2j/Eg3dGCE1lQmcgOAAzG9jTRM3QzL7HKkB6rjDcTL32
 ahIU1IEBagRcvGY+E7mz3RXx0mqXU6nqXiZrHOp01pbCBxpwJLr4HrTWHuA4bQhEtazWg/k16BD
 R+SWap7uuZb2YF2jUxLEym1rDlrGGc1JEXBAXR6XGt4F8eufEflTL54k11jx2th0bll5ovox4IV
 v42s9kfy50ifEazJ4A8zzDLr0FRK6I5FKYFm57rY3Z5FJGedSQYesuL5mNDJhU9GEKK+2COQeq1
 pNSX0M2VUDlFPVMPDT0ULdc2UhaDIujwhtIC1mE45HeXI7XDeJYb6qWk0d5exRCGiCy/bxiuf9N
 5W7jFSMXWsjDwDA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A single error reported by the platform stops all later traffic on a
PCC channel whose client relies on the controller to complete
transfers, such as the SCMI PCC transport. Every later request on the
channel times out.

When the platform completes a command and sets a bit in the Error
Status register, pcc_mbox_irq() acks the platform interrupt, clears the
error and returns IRQ_NONE without calling mbox_chan_txdone().

No other interrupt arrives for that transfer, so the mailbox core keeps
it as the active request and holds back every later message.

The chan_in_use flag also stays set, so on a shared interrupt line the
next interrupt raised for another subspace passes the checks in
pcc_mbox_irq(), since Command Complete is still set, and runs the
success path on the failed transfer.

Log the error and complete the transfer with -EIO instead, clearing
chan_in_use first as the success path does. Skip
mbox_chan_received_data(), as the shared memory holds no valid response.
Use -EIO rather than the helper's return value, which is a positive
acpi_status when the register read fails.

Clients that wait for the rx callback still time out on the failed
transfer, but the channel works again afterwards.

Fixes: 9c753f7c953c ("mailbox: pcc: Mark Tx as complete in PCC IRQ handler")
Cc: stable@vger.kernel.org
Suggested-by: Michael van der Westhuizen <rmikey@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/mailbox/pcc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 14dc4a187bfc67..e5df604b367a4a 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -315,6 +315,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	int ret;
 
 	pchan = chan->con_priv;
 
@@ -333,8 +334,20 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
-	if (pcc_mbox_error_check_and_clear(pchan))
-		return IRQ_NONE;
+	ret = pcc_mbox_error_check_and_clear(pchan);
+	if (ret) {
+		/*
+		 * No other interrupt arrives for this transfer, so complete
+		 * it here or the channel stalls. Skip the rx callback, as the
+		 * shared memory holds no valid response.
+		 */
+		dev_err_ratelimited(chan->mbox->dev,
+				    "PCC subspace %td: transfer error %d\n",
+				    pchan - chan_info, ret);
+		WRITE_ONCE(pchan->chan_in_use, false);
+		mbox_chan_txdone(chan, -EIO);
+		return IRQ_HANDLED;
+	}
 
 	/*
 	 * Clear this flag after updating the interrupt ack register and before

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261027-pcc_error_txdone-94f48c610666

Best regards,
--  
Breno Leitao <leitao@debian.org>

