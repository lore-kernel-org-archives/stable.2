Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B183B0AD4
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484105; cv=none; b=lHJEa4adDlQVOC5je7zZViSRkR4QWTBZrUHffWwkGpgMb8R4nZmsySq1KbjEYmufrS7PQqPpZOQ2mKSmYEdgup5ifJjd26zKGyBf06OtBMD6IiFU9MOZ12RsbXcnK+NEma4gmpczYmakER5VJxg4HGA23kZjNEuVPreED8IIrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484105; c=relaxed/simple;
	bh=j/nXUV5vdfXnI/lL2HrtTwcFaXZCD/tbktet+3inSX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWlbsQ7G+GsVsEQsBWXzgcDEOKWxJcWRjIVYbUyi6azKctAQwye1o38MT14QRin3a/neohtoShP9Oks79ke/owaAfniJQm1tBtq8xLeF4Toua4gO8B+mld+wtBBYHzNyU4z6iCLhH/02I7AImGo6k5NltT7oEnom7vcsnTDnekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIkjBwUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIkjBwUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F61F01562;
	Sun, 19 Jul 2026 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784484096;
	bh=njvr54StkxfZ8XkcM5OnI4fAQt6o3CAE0YSSri8GqcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mIkjBwUcQgG2xRE7o6hCduNMyopQZFVWRbwYwtecOH5PwO9c8K9ymVpzXboXPo90L
	 l80rIhEUrQNzQwteUxKd7FpTLTJZAthiKlmTAVFYyrJxsxqS2YwIXOrmknqf3T4Q40
	 MthtLWwJvEnAhPP9ny4Drshg1v1zLPqoOxNKyeCbAUqR83CNEWu6eLr/HarF28vPvz
	 M6VgSbRr3Kw9txleoXe1Fs7GmN30jiWVWWOYUGK/A8KYrDj3GVLDEW1VvnMKhR5nBC
	 Vk18XcTwh4NtuR8m8cDw3KWRRkXYtBd/gIkeHNNKMxi3tDutHVsYpiAao2D/g+kBco
	 RuxiC8cf/m+tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Yan <andyshrk@163.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: tcpm: Fix VDM type for Enter Mode commands
Date: Sun, 19 Jul 2026 14:01:34 -0400
Message-ID: <20260719180134.1055370-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071438-t-shirt-chest-a453@gregkh>
References: <2026071438-t-shirt-chest-a453@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Yan <andyshrk@163.com>

[ Upstream commit 9cff680e47632b7723cb19f9c5e63669063c3417 ]

VDO() second parameter is VDM type (bit 15): 1 for SVDM, 0 for UVDM.
Using 'vdo ? 2 : 1' corrupts SVID low bit when vdo is non-NULL
(2 << 15 = BIT(16)). Enter Mode is always SVDM, hardcode to 1.

Fixes: 8face9aa57c8 ("usb: typec: Add parameter for the VDO to typec_altmode_enter()")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260604105059.18750-1-andyshrk@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 60bba8501532df..d0e5bc1433e70f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2226,7 +2226,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
-- 
2.53.0

