Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628735;
	b=Wvk82hhs1SZqaqdrKnVEWzZ2w3JczKVxh98WSZbSnMCJihZotvYmuPvk/Dn20kphC0lD
	 2T+O2gaY4EHV2h88pxJssh5shCIfXCgV1wTlM3IjBXP+mqJRN0oz65ZNBZf5PEDMOqztO
	 M6luQqlcECId/0+6YPzUwr9YW+g91+i7yyYcOhbAN+n+E0sWMfFPYEe6DFTwAZQyJjGO5
	 2Xt6ikpq1yGOJRboGPhMP3AoF8YXFbl2zW6YASLJ7M8AuK1vJNNBAz2/vNwe5rqkt9c0n
	 LwMt+LzWTR0gzPPpq5vQ+ENgQFmpePPF2xb+LKHA+GW9Z+x1evlrbOK3O8zMfRgi1Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628735;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fCNIhSMP2bqpoACDhzZHWkXrMD9P7u0i1H8rwrc45lQ=;
	b=j2feYIlR80vTPSrVlMFqFacj1TBp0R7UBImIP6Gkjkbrju4Mtlmi4rnoSaTLnCy1TyyF
	 s3lBL8ONv3d5DYWSfikOlmEo7j787FerWJDuFlDv0v0GF+NL5RVXr8JTtvFMy3WK4T/wD
	 AE3VlL+rvv4NAcuZUtp36L1W6SYf+FujO84H8GcqJMLtc7BGzolCcDvdoH9vHWtxjPhN6
	 II/+LQ8oLGy6+C9hnMu4pOUxSpq7u8dt9grI88VbNZX3Q0LGA9kZGHb4PLYq5Q87/X+wk
	 8cgi/9xHiaNHmS0KSGWyUCpXSYYQBKyquktgkzcOnuwrOAMy+OvuTZW2ulohVXuMxJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5EKhrF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D038606A33C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5EKhrF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4251F000C4;
	Wed, 25 Nov 2026 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628735;
	bh=fCNIhSMP2bqpoACDhzZHWkXrMD9P7u0i1H8rwrc45lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5EKhrF8wS4N2kLZhwuZXDqHI1LGEDCwqwhUULbwmlxAUhQ6PqtvhxA1AkHPZUses
	 Vq0fEy/GoXGP2iTvY0OphffLlmSkcrLo0A/lRvvqX82f4DslhzPuMLdUFjeuAQx6KE
	 uvxxpqxZ3ZJT87VmBHddMTr2+pw/uHUP3W1uiWyMeGDPpndrL+nb20MWuEAIqgI7qS
	 6n6UVvABkotslZmJQOIA6KeCY25AFWJZGq5mXXPIoK+vUw8Q9xrJONvGl8KetMtt3m
	 7Fe18d5Ytef6YOCrueoJAZr/46XNxEtdN9iNIbuits64J8YnaFGScOoPm02kZogyAa
	 kPqVnaI5mtIzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 12:45:33 -0500
Message-ID: <20261125174526.1035570-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-reemerge-surprise-9a4f@gregkh>
References: <2026112509-reemerge-surprise-9a4f@gregkh>
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

From: Anton Lundin <glance@ac2.se>

[ Upstream commit ca1abdd1a9b9ce51713a18c8905bf10579533c3b ]

The REG_TARGET register has different meaning, depending on if pwm is in
thermal_cruise or speed_cruise.

This means we can't assume it's always word sized, so we need to handle
it differently depending on which mode we're in.

The code already does this, but the register was configured as word
sized for the speed_cruise mode, which would do the wrong thing in
thermal_cruise mode.

Fixes: 6c009501ff20 ("hwmon: (nct6775) Add support for NCT6102D/6106D")
Fixes: 29c7cb485b32 ("hwmon: (nct6775) Integrate new model nct6116")
Fixes: 437b3c2a4bdc ("hwmon: (nct6775) Add support for NCT6126D")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Lundin <glance@ac2.se>
Link: https://patch.msgid.link/20261109082511.851377-2-glance@ac2.se
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 6d28cf101f5f1..3afc76762856c 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1152,14 +1152,12 @@ bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg)
 	case nct6106:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  (reg >= 0x59 && reg < 0x69 && (reg & 1)) ||
-		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 ||
-		  reg == 0x111 || reg == 0x121 || reg == 0x131;
+		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4;
 	case nct6116:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  reg == 0x26 || reg == 0x28 || reg == 0x59 || reg == 0x5b ||
 		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 || reg == 0xe6 ||
-		  reg == 0xe8 || reg == 0x111 || reg == 0x121 || reg == 0x131 ||
-		  reg == 0x191 || reg == 0x1a1;
+		  reg == 0xe8;
 	case nct6775:
 		return (((reg & 0xff00) == 0x100 ||
 		    (reg & 0xff00) == 0x200) &&
-- 
2.53.0

