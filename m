Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F644963C7;
	Fri, 21 Aug 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320234; cv=none; b=Uy3wlU73d9hrXkiSb9ykWKialHzFY2tjleJxKIuycSvaKyWtw6fPFXrEK3UQ4OWZMsUSTQFOeEbkb5j4aKDjsRbseiqwq6EeQzqqf/xUTigU2nQf7GVTPw58P/zlB3bQOkvXOlHo0Ppa+0nXmwRU6UFPqfzr9iRyCxTD5W0RyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320234; c=relaxed/simple;
	bh=mSWx1NCoUEXQwAwUZ0o2hB/XTB0iO2k+EF+a/falyL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iqfMfUQvyNkf4s6YDxLW2R1aDQ3ykS7xDbDWyu28XnEqpgb7XQZyVknUwAgblAJbwCfZHF2I/PAw1sE6xT0B1ne1Q7jBlvccB63ypCdDO0IIlTZdrIhqeXIyHH3ZaNoewej8ifKlgvIP9yFX8cP5YibNFmjIUMwvndExSNtC3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxcydG9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxcydG9e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C36E5C19425;
	Fri, 21 Aug 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787320233;
	bh=mSWx1NCoUEXQwAwUZ0o2hB/XTB0iO2k+EF+a/falyL8=;
	h=From:Subject:Date:To:Cc:From;
	b=AxcydG9ekc8CpckRJjPgIbd6h/zPAucpsHUxEDdaXgklU6PVqe/yFxuAso0M9ATsW
	 3t4UjjCv2ELSqbmfoSWgVhb2oI36Xla8RA8fKUEzayN62VPnC/5qOCRlUp1BHdJWWr
	 6B2fLCrCn1PJnPdZEdXkGbZF6aNwNJvTDShyaI9I4sZIJ0EGELx7Ef/0fvtZDeJfct
	 2R4RbsWxKBmJk3IyZ4k3vhnTQpogRzKEHlD/sCe+HcHZ3ur+gDpD2Zb2d/iU0oo1EX
	 QrXohoAr/tCDaknhaJKSCiHWPYgROZGICjgSxZ+gdqmmdJ6dOZplEIw2sDnrDDw2Ln
	 nKXsjpJ5aUKMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A970FC5DF7D;
	Fri, 21 Aug 2026 13:50:33 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH 0/3] phy: apple: atc: Prepare USB3-via-4 tunneling
Date: Fri, 21 Aug 2026 15:50:26 +0200
Message-Id: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVpG5FyFbHQmjIWSAchjbsrd
 u9bvD8CYyBkqLMIAQ9iWuYElWfgxm4eUFCfDFrqUhqthC1Et7l1vMTOaXvjKykNeqt6SKc1oKf
 zCzbtb97thG57K3DfD4G6K91yAAAA
X-Change-ID: 20260821-b4-atcphy-usb4-f8f9008efb1d
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>, Paul Cristian <p4ulcristian@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=mSWx1NCoUEXQwAwUZ0o2hB/XTB0iO2k+EF+a/falyL8=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1ZH+JLUjq0vpsevMmM3en3Byt2qQ+nux96JvjdOZd5Nv
 sR46dOVjlIWBjEuBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBE1hQxMuxvUL6Z0ilr+sA+
 tP7XEXmpVNaZNzTZL9fu6/v2tZ514kxGho7EyQeVvlR/qsrbZnrY6PS6iba3a2acyMoVWHR6zzW
 DBCYA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

This short series first fixes an oversight that prevents USB2 from
working when DP AltMode with 4 lanes is used. Then it adds the required
sequence to point dwc3's PIPE interface to the USB4 Native Host
Interface which I plan to submit soon to support USB3-via-USB4 tunnels.

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Sven Peter (3):
      phy: apple: atc: Support DUMMY PIPEHANDLER state in configure_pipehandler
      phy: apple: atc: Factor out the PIPE mux sequence
      phy: apple: atc: Implement the USB4 pipehandler state

 drivers/phy/apple/atc.c | 91 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 32 deletions(-)
---
base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c
change-id: 20260821-b4-atcphy-usb4-f8f9008efb1d

Best regards,
--  
Sven Peter <sven@kernel.org>


