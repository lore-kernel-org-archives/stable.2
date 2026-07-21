Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F31E531;
	Tue, 21 Jul 2026 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611857; cv=none; b=QWSdnCv9YLRElU0MB45GamPONprD7VBB/qScWRl5Dn3hqaouZ6q/D9nEjzO1sI+8RtiX9XB/4gndVBOfEIU6pDH7+dEAsR6hiprl2cbYUjzux45IHG3j2EYNve30G6Ah4GzWQ53V8hiiG9iPoUdeBazxXBzXBgm5HDsQnmVsxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611857; c=relaxed/simple;
	bh=OOEQyFHqhc4S4+0dsOjawSWc2OPyvAVPOOBh63XOS3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWbgFoyT2f7HqJNSgPqJv8XeHXp7ExB7suauPXQjsMcXCU7cDvR3DLrVouWz0udfE7Xmo2x9SL/QZRTCUIPnTugmMIAiZ2vW/Rfis5E3H7uEL1RvwliSmdhavyAajXlV3UPqECfWzf8zXP0f0zCmQGAoJirO4gWXU0JHv8Kjj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGSq/kjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGSq/kjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34251F000E9;
	Tue, 21 Jul 2026 05:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784611856;
	bh=gNIPW9G/CKQZDhpJcmDALl7VZrSXYPWTv0T0hhzWc0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGSq/kjv2tT8Jsl9vLbgjhiJjJ5Bt8bzaZAZW4vHHd5fDnXVGtqksc3UhtggmPHr4
	 ZfcO0o22/DeKvqXUmSzMzuC8IzaBWqhCjYYkPcaXKrZSksDlXD4F2KgQW+6zsqDC1n
	 +xjMN6bQKAUDWB39VPhgampuF0Wxqsny8JGbf2fmFVbpI9iGlJcRvpt8PfFbtAJ/Ub
	 W5TVS4/32BPbvzwPSjUtjSrq/2SnAp/a/E8iZQCXo48nARm2Y0IOHPPIthnYJKmWwy
	 6dbXgZsO2oNAhE/NlqB7ChA17jil7nmWew72bz+EK+v3j2G77a4XMgkUeCeNRhMLrh
	 vtJD0XZt+kbfw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ronald Warsow <rwarsow@gmx.de>,
	Brett A C Sheffield <bacs@librecast.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>,
	Ron Economos <re@w6rz.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Pavel Machek (CIP)" <pavel@nabladev.com>,
	"Barry K. Nathan" <barryn@pobox.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.1.y] Linux 7.1.4
Date: Mon, 20 Jul 2026 22:30:47 -0700
Message-ID: <20260721053047.170233-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072015-wilder-coastland-ba7c@gregkh>
References: <2026072015-wilder-coastland-ba7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Link: https://lore.kernel.org/r/20260716133047.772246337@linuxfoundation.org
Tested-by: Ronald Warsow <rwarsow@gmx.de>
Tested-by: Brett A C Sheffield <bacs@librecast.net>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Tested-by: Ron Economos <re@w6rz.net>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>
Link: https://lore.kernel.org/r/20260717101912.682013354@linuxfoundation.org
Tested-by: Brett A C Sheffield <bacs@librecast.net>
Tested-by: Ronald Warsow <rwarsow@gmx.de>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Tested-by: Barry K. Nathan <barryn@pobox.com>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 11b44c8a72235..b3496dd21312c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 1
-SUBLEVEL = 3
+SUBLEVEL = 4
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
-- 
2.47.3

