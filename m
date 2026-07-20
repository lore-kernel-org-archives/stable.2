Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1333EC6A9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544902; cv=none; b=nCI6sJeMYTVmfEBCwNpfOQbJxQXHlmpAGqYo8SWKTOLb4fzFe+ZKIA01UsS3YKFE7xkQDic4vYOovVorGECpqHgqAr69kuMSbYeobUxtO8HpQWJvC6pWdrHjd6+xBjejrw0cdUuQknv+o14LZuFSX+Wujs3JoIZTfy9RXDvF5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544902; c=relaxed/simple;
	bh=y8EHwyzXIrq9vbSWCnAc0wjeozzzJvfLH6n3+ucssDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D90cWRP2TMViVOtn5yjlZ4A7MCcUwQ2Nm+E7lrekhnq2OW+XSmMzgkJmruWDS2mmFbAJzUnghGjwmYJBqvPfYLUrrxvPFQWcEpkO3mGhzLg8A9tQHueL6Uf95ZYPv1mwZzdgwdEFUrwJgV32gR/EwDxjgut4rtpLqNSy96MqJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUtWCsAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUtWCsAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79001F000E9;
	Mon, 20 Jul 2026 10:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544901;
	bh=Qe8rNwlv0k+4oQ1QsQD3yY6/1d0jgoRM0Eq4/rSJupQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUtWCsAVoijFPYfsZlSTXFWGx3/55CfYMZE4V8GAL412aFuF4Uodf2uZSL0ZUplXt
	 4tRrNQdgKo0luAIfcMbE7PAfGn3N7gWMU69AB7hJV2aKg6spCsIqd0zbPoRizaxQpC
	 P9hnJ2JDFgRMc7zwhL6llOieD4aJRylKgtIZCwMt6w4vVrxRqhm9Avf+Iw8QGddYat
	 LQn0MPTvo+KvhSWDC++ROhkM6Xc2Ow393Jj/mK+5mD7Y8IKOMEfjzUQoETl4FdrvHh
	 ckaYJQt+fgxLYdH8+k2j7ZNYTE07AEyJ16MAMziEsaNHgxGK+C+zE1PXUFOvXMuKcL
	 4KoP2FGjm1B2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Yan <andyshrk@163.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: tcpm: Fix VDM type for Enter Mode commands
Date: Mon, 20 Jul 2026 06:54:58 -0400
Message-ID: <20260720105458.217218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071438-zesty-cringe-ce8c@gregkh>
References: <2026071438-zesty-cringe-ce8c@gregkh>
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
index a6ee9fae875aba..762bee67a295c9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1666,7 +1666,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 	u32 header;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
-- 
2.53.0

