Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3A49AA57;
	Mon, 14 Sep 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407774; cv=none; b=rRwXStZLC4NLjzKWPpvuWjaz6JxJivZpGSl/xxziG2Qa9qlyfGyzC+WPtJtuhkRFGDRUjhSHRD4hkD/6bvdlzzcXyAKcsGHZKpEe0HuLLEsbOhXbBfn8M1M9jqpNnEz0OgSnXWrjl8uxJbl4sBM5kXgKf67dNTvEb3B4UAmQDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407774; c=relaxed/simple;
	bh=3dbKUyT/iT9G+ofviFIibdhrCXThypSRvaMTCf/plpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKhYijrUr4TpKGvdjroCBN8hDNMiZnqHKC8k5614FB7sKu2tGZQJHyB2WuSMgoe596A22ojlM29PuhqN/3GXj544HCevnM9I6wle2CXP7ryzlt4A4hagMCvFpqLscm61j8WrfVa0bgnmIRUCMzfzvsKCAzvqbYKx1tnyIvCQbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btj/fX1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btj/fX1s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EA27C2BCF6;
	Mon, 14 Sep 2026 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789407774;
	bh=3dbKUyT/iT9G+ofviFIibdhrCXThypSRvaMTCf/plpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Btj/fX1svQ3EYPQSVMTUYDbc6wu3ZvAqQbEU+1qcEEZ2LlEcI0+BSkMpvMCCWfgUR
	 DExoKI3k38m4Y+rlki0Ji8Nyh0gxpQ6DRw8adrZKxJqXxZETyuDcoPqBKGBU5elbgJ
	 VOQrfrBe9SLng/8RXPBWvw0Z+ahI17sQSXpDgx39RGd+E81R+UAc9WjO0kxnC3Xnho
	 HHwXg6s3A7g7dnIFYdrFMIxDOVQlQItoA4Ak9RnXJI67DGZYCGTPFPFCy9374sJNWD
	 AVDDQYSgbCDcJAO+GEoT3QXqodLI0s7XG+MAAazcGaOJO7eiKflj2Y2YlUjtvM9WN3
	 9dWnQNrW4Zvjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF155C88E6F;
	Mon, 14 Sep 2026 17:42:53 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 14 Sep 2026 19:42:47 +0200
Subject: [PATCH v2 1/3] backlight: qcom-wled: Fix WLED3 brightness register
 stride
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-qcom-wled-backlight-v2-1-a908d9233e93@ixit.cz>
References: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
In-Reply-To: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=PsAxMRrlqktvAML3hjPt0kdVxbrGmbj1j8uq3J3KhxU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqDIczKVPe0nj8x6gYBinetl5UNl7M9qN/9D+u
 Huri6kL01OJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqgyHAAKCRBgAj/E00kg
 cpRRD/4uxVlLCDyUgCdbl13H0nFe+KpG/WrmuFvVrcWCoeqUwbyrSKXINFNEGFO2MZguwOaGh1Z
 Qqo0tIv9KFB/iCTMR/oDegM+TaAIeWX0lsI3u/0fse4Mp/iUuolXWm16Vg8VgZIitH5TCpP/4ky
 m038DfnBD0B1efEf1UWHAVjz4npq7R5VSkfmWehv2CHBxooQCtlkPQEYXBtFHFPlJAAvl9a0G8N
 R7EQQQAoJ+33HOKS5Oq4ZWPfIFuaf39ut8Yg1m/rLAU9PMwfr8pBpfoj4q6ZRVPUSPxTUapmf/A
 TeRW9vm8lN5IH+240m+ugggXP8zr6ffLH7yfw7Qcw0gqOF+ZYq+rdj8oPJNm4P7WKDnwVwXboKI
 zeCWyNEGgyQk0Zku/LWwUC14oxfULW5Wp4/W+BcBRF8RQkqI2IJaDcqTe4K4CTMDpTgOwJu6x2S
 xrKTGWmJWvO6aKCd+VQCMHytzQ5kZi22Ii7M80qW8rxdkZU20Pbs7/2zyT40seoq6pd1ZthMVQv
 0e2TT6KgFY3DcEBodKTbKEpxTxGZVD9if7s73YS+p9BVRPcHtrkYE6/Xn2QOVY/5r2OoXYb8O7H
 ZNifwhPBfCA2e4u+JMA0xp+uckgaAie3iGfKpQnIRA7VoMRpCMN5zP4NLpSfsR/a94tPILnWB5f
 XrbZPdxAHtZzCPA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
which is what the pm8941-wled driver wrote to:

	rc = regmap_bulk_write(wled->regmap,
			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
			v, 2);

The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
defined as 0x40 + n, so the two byte writes for consecutive strings
overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
with the default three strings only string 1 ends up with the requested
value.

Use the 2 byte stride.

Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/video/backlight/qcom-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 650dd95f06ef5..22c35da72dce3 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -54,17 +54,17 @@
 #define WLED3_SINK_REG_SYNC				0x47
 #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
 
 #define WLED3_SINK_REG_CURR_SINK			0x4f
 #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
 #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
 
 /* WLED3 specific per-'string' registers below */
-#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
+#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x10))
 
 #define WLED3_SINK_REG_STR_MOD_EN(n)			(0x60 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
 
 #define WLED3_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x62 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(4, 0)
 
 #define WLED3_SINK_REG_STR_MOD_SRC(n)			(0x63 + (n * 0x10))

-- 
2.55.0


