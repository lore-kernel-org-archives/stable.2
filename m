Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2737DEAD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072054; cv=none; b=tIsO7ZYajCMt54O2PhYIGIr1SMZCpEPk0b7tftmPKgZQXnAP5peh305yRc57JukQqz2npqP6Qc9b9jsOmv2ZjFV7m4jQln6hzvr1ROUAKLHMqvlXP/kl4eORiiMvi1U00Z9GyDVsOoEw0JtNdGRck/L/lZ+oUCJmXzkUmRq1TQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072054; c=relaxed/simple;
	bh=Ft/EE2noUwMqo41LHFZG8y2oNsWQ0DlDXomW0doFW90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hw7p97x55eaHdya4usvJfEzTLd6a7Zw67Yv1g5XdmYnOfhhsymQzpv68Uy3120q7e/Cud1K0v46sp1fVJVoba6ypvIrPx1+I93T98cJugLUlmIcgpxO2OAp+zJMbvbCFAj/VbjnXKAT8kgUhqR9mc7x+KHR2jf3osEVkeG/BEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTTBQ1e4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTTBQ1e4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B31F00A3F;
	Tue, 14 Jul 2026 23:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072053;
	bh=jHS0mA3TcaXaAi9qV0QBH0CvhDworYXHqOGXny3m8Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTTBQ1e4ZHBtoF4L74P5Dp3wWhHrq9u2tyCg6Jbegyd92qq2clRhMHHkjfHtU8zgp
	 WOlqS7A1LOR/hy8uXCbcpl50G3lgSvOfYXsN8ShFEPg+d1Ywh6mIvdHZWdEIk0BNW9
	 ZwR6ilJFS0jQB1n8Px6DD9gbv6IkxQy0oGTt3DK6sswxkdNt/XNKqaMhGVo4a29tiQ
	 MWth2in/DHvA8Ut6gSnGpJVFqe6kNM6gFVZs0dN4cqqbnXhC0lN39R/mK7qSfi018n
	 UmBmfaN07Gkt/cy51rEXK89Wl6pvpbYplxg+nIknwjXh7fXEmNrTCvblNDvzuHu3ot
	 TrtPTTniMSUXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/8] staging: rtl8723bs: remove commented out condition
Date: Tue, 14 Jul 2026 19:34:05 -0400
Message-ID: <20260714233407.3591885-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714233407.3591885-1-sashal@kernel.org>
References: <2026071352-wreckage-humorless-3481@gregkh>
 <20260714233407.3591885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 2a62ff13132a22a754d042b2230117bbea0af477 ]

remove commented out condition checking channel > 14.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/83762719c0c13ac8b78612a32db26e691eef17d1.1626874164.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a1fc19d61f66 ("staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e9d006cdcde7ed..f7908b6ba16e18 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -165,7 +165,7 @@ static char *translate_scan(struct adapter *padapter,
 		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
-	if (pnetwork->network.Configuration.DSConfig < 1 /*|| pnetwork->network.Configuration.DSConfig > 14*/)
+	if (pnetwork->network.Configuration.DSConfig < 1)
 		pnetwork->network.Configuration.DSConfig = 1;
 
 	 /* Add frequency/channel */
-- 
2.53.0

