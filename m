Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10032D8767
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784480236; cv=none; b=kh+Sg9hSX7OysukMIx14DAGJ771VunnSRV+R5lBwGcTc74VLuKpOAx60nvmuF+t9sui2Aos2i9jVlp5fw9uhVkR6dSpezYvg7Ctkx5BKidyHJqlZeb/pgp/2402JMD+BN560wM890x/bPcl6F3PsYRYFnVR3jAABA4vKRdjQR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784480236; c=relaxed/simple;
	bh=B8Lm3Phf3qJN1Ffd7TRTKLFTC6+BLOtiBfb3LStl8tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7xS1Uya9tJ5Ct2hOrFwGBezc0zh9JbVa1sUB9BdkWJ7TI0TZICR07xdzj1Yie0Kg20vTe+jrb7sNyx+EDeFZqxw1NkOJVfmchX2o6o0R08z9Be+UFVDwC5c7aUEuepkAKnK5VDrX61t8FS4FjXLtVoKDy+EqdMCtFNr9qd67Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1q1H2aN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1q1H2aN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6CD1F000E9;
	Sun, 19 Jul 2026 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784480235;
	bh=NCTRPuvUvbAW34keIqtAAtxFNdepX3Dmt1HGwjJl3tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1q1H2aNFloaAlfrQweSuqdn6TdyNLy8yrpJ4zTGm3d8siz+7UWPqvCFsAHxIf2e2
	 lvd4z8TR30PE+icBf0sNA9PM11rOXrUk+5gVyeYSwcm2QLL6+4DHZ2OzEnK4pQRyZJ
	 Mp1+RuCvsURHeuDu0+ESbU+ZjAZWg214MZSnRiLoxZWgJczOKrwFnhsopEsBqQY77X
	 cguHRpCdFs1Dyln2zaJg+fmxd93o5yxlJHoIzQWz4IpDgn9QsAfJ/vB1k3QlbZYAdT
	 HW0tnQtNfTVxAM9tDlrq8oql+afyIYdB5rH1j2ISSSnZCpsY4LpAUqKnKKsMqN78dp
	 pkVTXaxchZbKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Yan <andyshrk@163.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: tcpm: Fix VDM type for Enter Mode commands
Date: Sun, 19 Jul 2026 12:57:13 -0400
Message-ID: <20260719165713.748572-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071438-irk-imbecile-3d77@gregkh>
References: <2026071438-irk-imbecile-3d77@gregkh>
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
index c6330084d4f6de..806f6057009343 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2232,7 +2232,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
-- 
2.53.0

