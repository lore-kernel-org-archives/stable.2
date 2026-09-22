Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181648B37E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101280; cv=none; b=Ngf+E8TlLWTvKT3pv3fxWRlFNF3ZSAn/D1bQN2O+mTjyZMCIne3Ol8XH4qVRDFAtK2slZkJ3iC+YbZxRMgI+kffphFxTCh+ZKuLoECUKJMHU8/Fq8fyu9a8oEURkHaZBuFp8AfhazlNOZt1/x5g381GgoEce+qNenSwRHwksklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101280; c=relaxed/simple;
	bh=q08bMm6TKEscGDYXEC/TAix9da9PxlKDkHBqxe0uSEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uINQEtVBJLvfInl7BOGVEDqL92WDowr7fkGwq1ihEJ33qv3Dw8jogr4XAxsA6JYiqWKYpa75x72gIBE4XDm0361EVxYJ4pe2pIfIsgifhXIR/6LMKLitXT5NFAiZnnQ3TDiX3bKCeZ+Bq9aLhBXw74xMujFi/nEZUSDXHcfh4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkpO5+e2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkpO5+e2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824791F000FF;
	Tue, 22 Sep 2026 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101279;
	bh=OT1MHMkc+zNCW5lT7wfagicsSw2C47Qozr7XQC74Rnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkpO5+e2LDuakPTSskJ//YuW6cOs7NkdO0SMFSCFP1qS3x2+varxLqYW7ZrfkfsfQ
	 OzeKM6W6kfpT3qYrSo6cFPvN0GTfFfF2IvxMH3JKPwzsnryNPMVv9Dxx/MAxTC5bSn
	 HVEPS4DWwcu/mSSFRtP3lgcBdFeZfCQRourJNnTLSy2Oonqb7NcEHtjY62+55vAqNL
	 6382HNayx/vU4ijgNudJ1V4PjlFDYCOaLkWqT/TJ/BaHIQen5K4hTd2OB6Ilkiqa6m
	 BiNSFOLPACcTwJFA/0GUPehMd4V2dni4QpwVf9dCEGElHXTk7LH/3Qwei7n1yp9XyP
	 q5+qOi5vQHjBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (pmbus/core) increase number of phases and add new mask
Date: Tue, 22 Sep 2026 14:21:17 -0400
Message-ID: <20260922182117.3569426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092214-quotation-winter-5dc8@gregkh>
References: <2026092214-quotation-winter-5dc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit 06bd6794b5fd2163880ac3bfe973d4cc61f359f3 ]

Increase the number of phases to 16 as a new upcoming device supports
such a number.

While at it, add a new mask for controlling the source of the output
voltage.

Note (groeck):

This patch was meant to prepare for support of MAX20826 and compatible
devices, which support more than 10 phases per page. However, Sashiko
reports that the mp2975 driver already supports up to 14 phases, and the
mp2856 driver supports up to 12 phases. This already has the potential for
out-of-bounds writes when probing the affected chips, making this patch a
bug fix.

Fixes: 2c6fcbb21149 ("hwmon: (pmbus) Add support for MPS Multi-phase mp2975 controller")
Fixes: f9e5f289b686 ("hwmon: (pmbus) Add support for MPS Multi-phase mp2856/mp2857 controller")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260911-hwmon-max20826-support-v2-1-5e30cbd97d84@analog.com
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ Adjusted the PMBUS_PHASES hunk for the branch’s existing value of 8 instead of upstream’s 10. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index a46c479962b05..b4bc3e4d94d03 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -241,6 +241,7 @@ enum pmbus_regs {
 /*
  * OPERATION
  */
+#define PB_OPERATION_CONTROL_V_SRC	GENMASK(5, 4)
 #define PB_OPERATION_CONTROL_ON		BIT(7)
 
 /*
@@ -376,7 +377,7 @@ enum pmbus_sensor_classes {
 };
 
 #define PMBUS_PAGES	32	/* Per PMBus specification */
-#define PMBUS_PHASES	8	/* Maximum number of phases per page */
+#define PMBUS_PHASES	16	/* Maximum number of phases per page */
 
 /* Functionality bit mask */
 #define PMBUS_HAVE_VIN		BIT(0)
-- 
2.53.0

