Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368990;
	b=M5zROZ1MScw2BtPeD3rQc65kc5ZP/lzJk/1STm0pxGRQsYIgTGFrOJ/u73puqPajwdj8
	 wOnu1D1tmPyy1k+2pB+pK9mA1tuxW46bBsC1uS3TwUYd/FPVL5sSZT+sjf0+dPRhgWbln
	 tkLev5tWMeCqzAHOZYYlpfu0YokL9mqZTpYvodWtSe8V/SzA0rztMvT3iT+pjwNhJmE0P
	 TlRf3M5DsREq8lKcM3qjNrTta+yq1nytYWDbBr1RAerYq8y0NJ9iq+1ZO+Fl47aq2dxua
	 Z6WPhJiLRk34DCp2tS5o1PZVjoIbExvT2sIrRHil9EKwnz6ePzu7V7DpKv7fVsDYqNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9ZXMsLPTsm0GOQLCtib9nfmjdcHkbejoTfcfCndgpuI=;
	b=Jk1YRPKww5lPQ5W1KM2rka6aj5efh76GJxrqz/6viyDpXakZHl9ZGXt/MQ/INl/eytQI
	 IUHmaEsP8y7A1MPRd9NlsV8ni9vxkgqd/hwtl4eRbc5JpS453jlCbRHml20JIUPemf5mG
	 gawvMX4qQnGtw7xL+pmHYb3mA+mhvzuSXsPiOJ79hWfWNCuVYUD4i49UvfXrluZxyd0v3
	 H9YhWIP+zgBM7dGE1qgYolEE4OiJZrtj2K0QgOiXYaAxziXRHRnD68hpD2vBXn2KO2Y1g
	 8EZ2NpXPfOrY4XgTPx7LyJZrrsPKGBAoo/R3ihkcA7YPnkwwjjbGyOVztv2AyJKu3+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmR+INDr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B84606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmR+INDr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B881F00A00;
	Wed, 11 Nov 2026 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368990;
	bh=9ZXMsLPTsm0GOQLCtib9nfmjdcHkbejoTfcfCndgpuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fmR+INDrAWWRy7CDjOToidg6N+pCCMfZUV5WApOaNBfLVRiiI+Vj5CyVXK+SZuVJx
	 JV30VvAcMypNXvvK/S+7ySNbJvWPvNui99q6HZ+YT5nTJEsQo4diqkPkGMEVqJnLBA
	 tbj3iD1ZFc/SPdd8yUc94Y5Oi287H1b9oLhPlL59wDyESU4Ai/kHFl1mFRjYSczPdA
	 PncQD/fwYfBdneOA14T5Qr22wGtnt2JzqKHxnhDY8818tHbr69R65+4qnJptd6+lo8
	 Y7P6SZQ2KcJqSNjaOaO0vAZyvq2P1KrQ/MxU3l3Q6D9NCMKJNDh8fYYhX0K7IVVzAu
	 3nArAydCK1tKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Elia Devito <eliadevito@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] platform/x86: hp-wmi: rename "thermal policy" to "thermal profile"
Date: Tue, 10 Nov 2026 22:49:45 -0500
Message-ID: <20261111034941.936350-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062147-failed-5.10-6dea092b261f@kernel.org>
References: <20261107062147-failed-5.10-6dea092b261f@kernel.org>
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

From: Elia Devito <eliadevito@gmail.com>

[ Upstream commit d7da7534272f7b42629042a5b6fa51debca9201e ]

rename "thermal policy" with the more appropriate term "thermal profile"

Signed-off-by: Elia Devito <eliadevito@gmail.com>
Link: https://lore.kernel.org/r/20210221210256.68198-1-eliadevito@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 6dea092b261f ("platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp-wmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 6642d09b17b55..370f74fa4a9ab 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -87,7 +87,7 @@ enum hp_wmi_commandtype {
 	HPWMI_FEATURE2_QUERY		= 0x0d,
 	HPWMI_WIRELESS2_QUERY		= 0x1b,
 	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
-	HPWMI_THERMAL_POLICY_QUERY	= 0x4c,
+	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
 };
 
 enum hp_wmi_command {
@@ -875,19 +875,19 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 	return err;
 }
 
-static int thermal_policy_setup(struct platform_device *device)
+static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
 
-	tp = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
+	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
 	if (tp < 0)
 		return tp;
 
 	/*
-	 * call thermal policy write command to ensure that the firmware correctly
+	 * call thermal profile write command to ensure that the firmware correctly
 	 * sets the OEM variables for the DPTF
 	 */
-	err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
+	err = hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &tp,
 							   sizeof(tp), 0);
 	if (err)
 		return err;
@@ -914,7 +914,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 			hp_wmi_rfkill2_setup(device);
 	}
 
-	thermal_policy_setup(device);
+	thermal_profile_setup(device);
 
 	return 0;
 }
-- 
2.53.0

