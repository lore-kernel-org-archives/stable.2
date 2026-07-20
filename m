Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DE21CFE0
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514347; cv=none; b=aVsH+uDPXSii28EQpnviAQHicJX3BK8cvQtfLB1ZO71LRboOZLcPrWoYjXSOSrv+et+Vcj9e+xyr5dALBI1m/RfA9Og62DFoCa/eHUNQ6jbY9CXOsaWyMBA8+9HUNdpSEe4NWfB1MaZop7k4KbSYiiU9QYYX05tZobV9eh1Aevc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514347; c=relaxed/simple;
	bh=8sLkInNYG8BOEbjE4fpJ+awtUBadfA1BTpC99NrVIec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZNyr3l3wNJcHYmKYGUWtPQpXFDrzz8hLy/c2ATUzRU8HqVFKZjsCF/zKdSsoXOWvN047fGDKF5Al42IMP34l4D4vHJsDrnQdBxbOkM5uqeA7D0TVwV3GumcHdeQOKe4UvFimdNy8bOM35PmXuXmcCiF+rnAv7kVRmVp1Dxq26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkoHT5tY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkoHT5tY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDB51F000E9;
	Mon, 20 Jul 2026 02:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514346;
	bh=wd9X3TUSKY37N42u2o724eeC9d4flqFv/pwQfHq52RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lkoHT5tYKUrBkswof9PLbCv9zNdw/8nfXJiWdZrlzvN2opug3yCDhLEIaQcYdFM9O
	 KViw6kV+y/2jEc7RPLCyiGJ6ST0HvYx3GmsmiRquJSNmYnEV8+C6v10BkGf8yolA6x
	 TqSZ7mkqg/tyMZj5gwrrMi9Ulrkg6qCzSfz6qqZ4UeXKuGLPYrewa/aWza+Bn4d8hW
	 KzROxd+x+r/R+v+6t+8GVp4NK/RY4fzPjzv5/adjxoQcvac1+NI4himpNYEeha9Kd3
	 KAG3RXRowX2G9UdxYwjJUPG/YC+0Lwz02qabdQJQ8kygq0SqIxUgzrmn2eL5FG6h01
	 3yFUdg6eE6CzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Yan <andyshrk@163.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: tcpm: Fix VDM type for Enter Mode commands
Date: Sun, 19 Jul 2026 22:25:44 -0400
Message-ID: <20260720022544.2927635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071438-guileless-shrine-ee19@gregkh>
References: <2026071438-guileless-shrine-ee19@gregkh>
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
index f8ef556a795d6a..dc57a5efd42d6f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2218,7 +2218,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
-- 
2.53.0

