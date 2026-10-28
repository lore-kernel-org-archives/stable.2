Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193748;
	b=BmFXFyTSNZqlb4bsplzrA/gfte7+Nt4xrXCNwhyVg1W12a96EQxt4DVnLOyR5uoha6/t
	 GjEXeTmvlxfjoD/nOsK6991RGcKKwnoqUUdxfTivTWmQ0gziE39lVk1ozoO2pBtqOXI9g
	 9nQqR0GgAmxlZyx4fMSK/MpC+AGdvgY/rG8ckrDUYS7fRRZOpJTxp5Xm9q+xnqhotuY2h
	 NRl5DNqSlK9deq76KRs08uAmGTKYYuV7dut3H1wwRrEixZPFkDBBoWNDzA9z7pzICHNY9
	 3pPKg9mbCEL5DTfuzhusfCyN6eVf1pkEbwGMkYZ8QfzGBHFeBQkGN5FHPzH1zaQpJNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193748;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XOIpWApm+1y0y5e8wWUvnK4ebxNnpBPEyp9x+DwkePw=;
	b=ZRKC1Uh8KsNPO3By8kWX6qdajI0LIftFVt65uLB/mTW931fJBsOSVZKr2+0lnxyQClP3
	 iPt7Wv9IC/zoiXnmW+BtOf0rCPmfVbexU8nhqmvCwZ4lwfi3M/c0ipf4lagg5IFRisNOo
	 HpmSMopXxiMgRN1X7HKwMPxmRh5w3YqwmsWeLrjUMJaupJgMu33si7KCCkSp9ivNk2IdD
	 QaWLkRmMKESnz1bpj2jLW8Qium9mSTgDov+kW2xuF2QnEqIwxfiFRdnF620ByD39BmLIY
	 4OcJqvJW4dNy/uNSvs0JzCtF7QKfJwTJUCPyORKgMKhpGfddpaWnWV3piHBP+PbCrag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr+nW6UM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07213606A31D;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr+nW6UM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADD71F01828;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193747;
	bh=XOIpWApm+1y0y5e8wWUvnK4ebxNnpBPEyp9x+DwkePw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cr+nW6UMQyT7j2NM5iRb6iyhZhxKCeyBRLSyY6k2LR2cLNslNqQ+ehBRPc8TX3hri
	 RVIrIriDmrxkA/rhiegv4ozLswc4cgS9lqntczP1U6WPfE199YaG3GgbrkMXvpM2YP
	 mhCTMHwc98lFFifeHpn4fXn4nzaLi24ATnjHY3ZqibN+maj5+QCBXpQF9eLp0YB/Rz
	 Gu+1PEH4tUbaB8IegPJ4pxi1evVluNDAdtdyjZ/bOlpLVHItkKk1PWhDBDYt9qSkcd
	 ro/tQIfjjNXUo1Db7O1mxEnPv73DD9N7hV7WJxroSnxGHUCeG28O5hi80CruOn82qW
	 IB1/v46wk3OCQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xM3bl-000000033X9-2bWx;
	Wed, 28 Oct 2026 14:22:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] tty: n_hdlc: fix read() hangup race
Date: Wed, 28 Oct 2026 14:20:48 +0100
Message-ID: <20261028132049.728457-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028132049.728457-1-johan@kernel.org>
References: <20261028132049.728457-1-johan@kernel.org>
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

Make sure to set the task state before checking the break conditions in
the read() wait loop to avoid missing a racing wakeup.

Note that before commit c96cf923a98d ("tty: Don't block on IO when ldisc
change is pending") a racing task hanging up the tty could get stuck in
uninterruptible sleep when there are blocked readers, but since then
read() incorrectly returns -EAGAIN instead.

The false-positive stuck hangup issue was flagged by an LLM.

Fixes: 1035b63d3c6f ("n_hdlc: fix read and write locking")
Cc: stable@vger.kernel.org	# 2.6.38
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/n_hdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 0fbc44968a44..02676ae9b112 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -431,6 +431,8 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 	add_wait_queue(&tty->read_wait, &wait);
 
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
 			ret = -EIO;
 			break;
@@ -438,8 +440,6 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 		if (tty_hung_up_p(file))
 			break;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list);
 		if (rbuf)
 			break;
-- 
2.55.0

