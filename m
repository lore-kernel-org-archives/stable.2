Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099B3C1411;
	Fri, 31 Jul 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486253; cv=none; b=XOxOp4gLyJd5LOkcc88VnCcm81g5F82WTyw6QR+SEYroyRCd6hYSIzeUAUHB7+3nJT3lNVXe0SNL4ekR8veuM5B5Hh2clSjIdqDLNbOxR4SW4lATNYWoia7BYAmfi5r4mZbyY3dqbrOV97KUFG4gnwlduA+h2oUKfiSeipHz6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486253; c=relaxed/simple;
	bh=QjE/5Ri9rA7min8L3ABV/RhqltCO6MPulLnMsFygcSk=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=YmktS/JdPSBN4K1EN8xqdGHVwkTKyCqfrgKh2hmDWKWRVrWrv7TpGsTm4oA57AuJeKbwHHUDlk74+2muoWEu9AVhbOTVc8b3CT8rXEhzZgK9uTJ8G7aC7QCQsrNp7yh/BP+TopLn47T5nEGZPscszGEhzR8mxucUyL+KYSMDPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QGJwDG0m; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QGJwDG0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785486239; bh=fp7mOKZAgaHng9InskXsuyaog+V0herwoNoxjkXgfHc=;
	h=From:Subject:Date:To:Cc;
	b=QGJwDG0mCDtxqNa4YIeybh7w7BgwDj7SmmiLp03bnW88xscIBb1zC5CWaYwrKc7L/
	 mSqygqhsWI/HD//ZVzWEILi83I/ztmJkl3CSo9TiMg6GMUpcEbmPw7UoJRClqJR5id
	 IJWRn8kd1vP+/+FHRnIxNw4fS7wGecOxBJBTwKdM=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 5F91AC69; Fri, 31 Jul 2026 16:23:57 +0800
X-QQ-mid: xmsmtpt1785486237tw4nhql8f
Message-ID: <tencent_549A2499DA04F6919D002944523FCC267D07@qq.com>
X-QQ-XMAILINFO: N7bhA2KEQ6kKeZlVG0gBwdF3r18HV4dVbFIvGrtYRRrzYeI7nKkhmV+uytTOyB
	 85hqN7fvoXBa6rK1LobmdsSkLick84Vn5MWnM9Spui8hHHBP6zqhw8NN3vwtPaMjJF7UNBBMsUoR
	 oW6qP9fTbJwluNE395M+GAW2dcmuoR9nob5yHmYWDbCWxzMPb45MmbnVx17t3XVoF0ckRXGj9r8K
	 n/d4JHJUPK+iYc5e1a+4reJ/9izMDRnrJ/Wkjx5bNBnBa2Az/aO4Dk/x1Hf/d3zvcmQqNruwE09r
	 DSe2bnKJwCeMQCKi9AAfL1uYhj0Y2C/NzXt/y+kd8QhlLwJHBeXPNnRu2d+vS8LD7Cxkb4WeanAc
	 ipzRyTjQxM/zs1cL2J17hC4n9x7XR1iEow4apxezaPZFUMCbBlKyKxoLgnb39mSLxnbq9epPLyJ0
	 voDagIOdHZsdvbrIRDFJk2dSSqbLu0EqsfoOkvCcCOWghzlPVsTaV5V6/d+rN1NtkEMqVwfsxYuJ
	 5WmwSsN6Ro70WimPPr684kW1DFpYc3oo6EWKbRyjGZ0iekJ8Tm4RDyvnymE2XPmErt4V/b4FQQvP
	 iojzEpE3+DiBDvlj+hHMtjAEaCqlTO+rNy050w7c4e7DwJ4Rh+mz3L4a5w6asc/jdCmpoP81KNlN
	 buFL6rz8gMiOaze6/FtNMiFOm84QUUyH4kvNfvogalxj6SOD6yprxoOLZ7lEDksWwl5NEIkmSQCw
	 0Ozx3qT+wX+m9tyWBCcbMuWYCUkvqOpeD5bwidZuKZvEf8zvHR3c+Y/MQLXUWoGnui0Swtg8cSQS
	 +17M75rczHoGuRewZJnSiQ67DuGR0+bxNYMTJEOtN9C56dyO92IJHDervX+NgarGrZXcdQGxckxw
	 VE046zLtqN0Kn8642+12prTAwDRstMIPJryINCQFiZDoQVrdABnVyWQckrXCad+phDXWyFYwxIB2
	 K1qDYyntpVaXOnsRq7GRdtbkb5y4a48VY48spkxTjWEFEf73m9hQrAFa5q2hvgv8UIENwIrwzxYK
	 8ResYpA29Q6nGfDwSALZ4F20Gm/lrHXj8uxxciwUwrx2gDaID1g3lrgThDp5wLWKrdT951YRG24X
	 mSTNQvlLSrg6wU3mdp2/yFwGbDNNACKuSpBGcz+W9sIlxkG2Cbcng4+s17nXxSWk6+9iHl
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 0/2] can: dev: make can_put_echo_skb() skb drops safe in
 any IRQ context
Date: Fri, 31 Jul 2026 16:23:52 +0800
X-OQ-MSGID: <20260731-master-v2-0-204d772f2e36@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhbbGoC/2WNwQ6DIBAFf8XsuTSwGjA99T8aD6hrpYlSgZI2h
 n8v2GOPk8ybt4MnZ8jDpdrBUTTe2DUDnioYZr3eiZkxMyBHyVXN2aJ9IMd0P9XUcKmoUZDlp6P
 JvI/Qrfuxf/UPGkJZF2M2Plj3OZ6iKN5fNAomWEtCoh45amyv23Ye7AJdSukLi/DEwasAAAA=
X-Change-ID: 20260730-master-abf3e4067e47
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

can_put_echo_skb() is a public helper used by CAN drivers.  Its existing
skb drop paths use kfree_skb(), which is not suitable when the caller's IRQ
context is unknown.

Convert the existing drop paths to dev_kfree_skb_any(), then make the
invalid echo index path consume its skb with the same helper.  This makes
the ownership semantics consistent across all error and drop paths.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v2:
- Add a preparatory patch replacing the existing kfree_skb() calls in
  can_put_echo_skb() with dev_kfree_skb_any().
- Free the skb with dev_kfree_skb_any() on an invalid echo index.
- Collect Vincent's Reviewed-by tag for the binding patch
- Link to v1:
  https://lore.kernel.org/linux-can/tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Cunhao Lu (2):
      can: dev: can_put_echo_skb(): use dev_kfree_skb_any()
      can: dev: can_put_echo_skb(): free skb on invalid echo index

 drivers/net/can/dev/skb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
change-id: 20260730-master-abf3e4067e47

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

