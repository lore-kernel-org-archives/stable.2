Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E3286D56
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004133; cv=none; b=ShRS8En76mS4UHUGMGblLz6CGHnV0RWq4xLC8G85c9wveZRaDuixfGeKvHHOz7LtVRp1YjI6B9SG2Gk0+ifxkZXUFPzUf1zmhnwI5U1NzD6ESTtqU1dowj2xqEHvU8UhKYsdzKiZTGEi9dT6g3KLco+d3BTfQI1yOX+7t6linZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004133; c=relaxed/simple;
	bh=Yt3FPJC/2/25KvB9wn1PfZdZeCwifezoV8YYlfLgz9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdOCauxhm6i7wR9bIBDc0y9y5LCyVyDmd8Se8k27A8D1MHe8l21RTZa5shZegLqceOdHREsB9I/hN9f9NoNB5R6J034FJQ7h7H9v0lxAJwClcJDn9iAax/Q/n2IHxosDEyW+lSR9EKnQkbWC2xWirCmuVmVKDmsKzJLcHDZugkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2t4/AQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2t4/AQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4971F000FF;
	Thu, 10 Sep 2026 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789004132;
	bh=8sMVF+7JsYTfQtF8Fv+hqzhpr0klhuIZzQLGhXB0sac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2t4/AQo6YNK6Imn1euElipTgRC1puQebBPqPGYaFYoOE1QAsNQTbAfHx1N+l8Tko
	 BdbinlzkptcbpiOKwoEoeqf2p8+ivPLakBwroMLOivp3csmDxfOY5B5kcPbob2to7C
	 DuJAz5sDQRiRNEpweGvlS1JsT8+h1YV7WGyTpxE5ObdQ+HGM4rYIH6R+sBDBp//clE
	 5rDHb0BZvHJcV6MJkvInwcJxgAB34pIRTbbgl/8kozvnNrhkYkyzCHc+Rh1RoDktMs
	 FXrRm1APS51y7elxXOgjM12IrytojVxSoKjow6qGyX5vvLwiq0f7mAijJqZuguP6Ui
	 H1gTrmEzn9dMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] wifi: rtw89: cleanup unused rtwdev::roc_work
Date: Wed,  9 Sep 2026 21:35:28 -0400
Message-ID: <20260910013530.3901662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090433-armed-frequent-d9dc@gregkh>
References: <2026090433-armed-frequent-d9dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit c281bdb8821461047d3e74206afbff190d1f7846 ]

The needed one was moved to rtwvif::roc_work. And, rtwdev::roc_work is
unused. So, remove it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250120034004.21135-1-pkshih@realtek.com
Stable-dep-of: 667c12782aaf ("wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 36ba2ca255bb0..6d9365332174b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5604,7 +5604,6 @@ struct rtw89_dev {
 	struct delayed_work coex_rfk_chk_work;
 	struct delayed_work cfo_track_work;
 	struct delayed_work forbid_ba_work;
-	struct delayed_work roc_work;
 	struct delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
 	u8 total_sta_assoc;
-- 
2.53.0

