Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195028;
	b=IxP8KX0xUZ+0E2Ubl2zS+P3v0D6qSLyvXzoQHA+pGPjbXCt/4TP/mxmkU8p6D8PPHoJF
	 GEoxJUzWfd5yBE6c3XPk84I8JCdvTY59YEIVaaKZ1tumnYOLYSmxzbc7RfStLSX1jiamP
	 a+mcya6/yUb7qsk+obLerNcYgk+X6ZkhbozK3EwLFiFO16FB66YlRPrFLY48c8HNbAEtT
	 Tm+X64ftcXSDq1kGSBoeg4wz3r6VW0uM5TQrjn0tFumAdKCjbBNXpwlaz/H5PoFHKeG3s
	 JPB0Ol4gjC5VmVUD4xO5Fl3Pyh9fkgzfAE8QAIknnaC/uG+5/8I5Swy0c09suCtf4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195028;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=GJ7fWzZjQROjVjwVm1/ePM5BAWjfsgHtzb1qQaFNnSY=;
	b=zTfsQyI/6zqsTBvRSF8ZNfRsbTvw+U/DUFd8wehwDVqmTJ56KmOxvH7HPxwv81CNmxKj
	 5REFPyu84Iqtk2BKNE6p+mSMShXK5kh+DKeFObmkpe6fk1ZSaSC5Q51AIFVn2hM0iqu61
	 EyD9wWZFvUVXWRBEKZpAwoEK3G7AqIWLI2qC4vBWw2clkmRwxAxNIE4NOs0jBbKapaP51
	 JbrmNxK+J1fj9qA5xVbLiR8o4mt0EdkQx7B9CHrhdV2lIs60LmpHPEPD9QP+XpjClVT3I
	 +cmv/ogYRhkz19iojWAaV47TxELOA45NMdviefjxvqMKnbRuQsUpPklw2ON8B/PpoyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jZS+7kqk;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB3606A31A;
	Wed, 28 Oct 2026 13:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jZS+7kqk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=GJ7fWzZjQROjVjwVm1/ePM5BAWjfsgHtzb1qQaFNnSY=; b=jZS+7kqkMi+fNXrvDjv3tLDSre
	w8xWeW6sM3Q2m6EyR/FUAOgfMDnZUYj794ggPD0S049iNqz/IKyDCXwdQ/erTz/cmgyA5lYru3W+D
	yAWZT2MaY6hUogPe9iUmcnK7xjP5w5YSBH5o3djZcs+FV52ZuqO4uEcpDMUN+sdhKnAeTTRg/JMlr
	yl7lj01jmMUsLvoubKYrPat6lEf5UIszuMBfHFwMhnYSzvkArj5rQPH2X0aAup43/OnEuqSTJXfL1
	1G8C0ZY67nEngXxDOlNNia8PcbMJ1MUhVRkPjduSBmWrrWQbzuASXl+zssbI+R3R08H3Wlhytbj0l
	nxotNjIg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xM3wO-002HWv-0S;
	Wed, 28 Oct 2026 13:43:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 28 Oct 2026 06:35:30 -0700
Subject: [PATCH v2] mailbox: pcc: Complete the transfer when the platform
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
Message-Id: <20261028-pcc_error_txdone-v2-1-4ca7ba3e45c9@debian.org>
X-B4-Tracking: v=1; b=H4sIACf64WoC/33NQQ6DIBBA0auQWUsD1FB15T0aYwQGnQ2YwRgb4
 92beoBu/+L9EwoyYYFOnMC4U6GcoBOmEuCXKc0oKUAnwChjtTIvuXo/InPmcTtCTijbOtaNt1p
 Za6ESsDJGOm7yPVQCFipb5s992PWv/sF2LbU0sfHRuacNreoDOprSI/MMw3VdX8gRL3mxAAAA
X-Change-ID: 20261027-pcc_error_txdone-94f48c610666
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3443; i=leitao@debian.org;
 h=from:subject:message-id; bh=OUVAYiBxG/JtOW7bltAxN/aVOspjsMK+9JAaRy9VCqQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq4fwM1m2m/NqqTPukd69I5GFS8N9nToFJgJfl3
 6uqnxkAXN6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauH8DAAKCRA1o5Of/Hh3
 bWYHD/9miD71JkvzDNVdcdLHgWW08e8NM6J1bMnJOMc1vA+XNu72QXjLemFovjtkv867H4ZkfSA
 WERNtqHVl2AVKCcL3qxyyhUrbZ++FiYMiZCNioTpA4FJgyOfsP495nmhAtNLbzcILrL01No7K2S
 rDf9kR8HiHUGpwitfG0Ye/ET3g5wfsU7XcjuZFGTVr1VXnBxv3NRJS+GAW16/aGlDdsgJBX4MpW
 saAw96iW9IGwVjFXFlxfSNnCxbkcBZ6+qrJOd0C1C+0aKln4MGadvg3QEC/Q5fORECwI+BGE0bJ
 UhXp/8rQ71mpg4Gpg4BWZXqIeDBCzLZittBlXXkOkkUNiIOyAGYn8OsUFHA9WiSwdZPWFqcfXSt
 TWEkFqFmdhUQJchdz3OkqHiAjNqXjddlkM0lFz8BHhr6IQyIgyl/WnhYzTI3pjC41HZsR38vUxj
 GIRkSganp3In+qDpkA/wVkVltn/8I/sTZ506rk009IJKi3W5NGHhPwXscJThg18eXi2/HHGsSZk
 YV1IFPJdZwpv0bCC/yqAacgEhzqbFXtd7/YR4Yc1mFX5e8s6dk7VQJ15CZnCvwJgngkFgQN5Blr
 qw8pkwbBa2g5M9LA1ba2nCuS1EJhksH2f/9G1D3nRhWPpL1AISLXIEqP5DTNczjh5bnd83nFctL
 YQkSHku52BB9AGg==
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

Log the error and fall through to the completion code, which clears
chan_in_use before calling mbox_chan_txdone(). Skip
mbox_chan_received_data() on error, as the shared memory holds no valid
response, and complete the transfer with -EIO rather than the helper's
return value, which is a positive acpi_status when the register read
fails.

Falling through also runs pcc_chan_acknowledge() after an error. It
only acts on responder subspaces, where the platform notification is
now acknowledged but not passed to the client.

Clients that wait for the rx callback still time out on the failed
transfer, but the channel works again afterwards.

Fixes: 9c753f7c953c ("mailbox: pcc: Mark Tx as complete in PCC IRQ handler")
Cc: stable@vger.kernel.org
Suggested-by: Michael van der Westhuizen <rmikey@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Fall through to the completion code on error (Sudeep)
- pcc_chan_acknowledge() now also runs after an error, which only
  affects responder subspaces
- Link to v1: https://patch.msgid.link/20261027-pcc_error_txdone-v1-1-2f8cfbb36d90@debian.org
---
 drivers/mailbox/pcc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 14dc4a187bfc67..0d36aa511a9d02 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -315,6 +315,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	int ret;
 
 	pchan = chan->con_priv;
 
@@ -333,8 +334,11 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
-	if (pcc_mbox_error_check_and_clear(pchan))
-		return IRQ_NONE;
+	ret = pcc_mbox_error_check_and_clear(pchan);
+	if (ret)
+		dev_err_ratelimited(chan->mbox->dev,
+				    "PCC subspace %td: transfer error %d\n",
+				    pchan - chan_info, ret);
 
 	/*
 	 * Clear this flag after updating the interrupt ack register and before
@@ -343,8 +347,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * the lockless update observed by the send and interrupt paths.
 	 */
 	WRITE_ONCE(pchan->chan_in_use, false);
-	mbox_chan_received_data(chan, NULL);
-	mbox_chan_txdone(chan, 0);
+	if (!ret)
+		mbox_chan_received_data(chan, NULL);
+	mbox_chan_txdone(chan, ret ? -EIO : 0);
 
 	pcc_chan_acknowledge(pchan);
 

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261027-pcc_error_txdone-94f48c610666

Best regards,
--  
Breno Leitao <leitao@debian.org>

