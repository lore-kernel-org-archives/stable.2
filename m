Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817617;
	b=kzlnhSwwPW7/iyWm5zN9orwo2klOOQU2N0wiMsOKyx/o0MmPPnDo0hQThhQFIXgMsJxg
	 0VoA/nRy7r6Hn1TEMKZNWPws9GMujZIVUyqxx/HsmSHlzqNSuiP9wwrAZSdL9cGv4Sag9
	 SLnDBPoVd7/oz/d9G5AnUtbQr3ENMR1otPU2jhqWrYA+1RVBgAAefvSLXqSukqQ5gWYCy
	 Ijyka4f6Cak+4d65sr+eYdcFQ/0Dg/buplW/oZxIBFEfB721DPKaP4jrBYZJk/Wgw/FXW
	 GGt8xECERAo9G7lS8jtSWzfzp4Rz0oTISHaUw9TTFaACgIegEGvXUMv5vioUdKIOH3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0ahLYAFU+clP2QENSRM7LilInaXH9CwvLAvnJgnkbwA=;
	b=o9JVnGYP5FtBaj2KeUEyy/Gx8p4ANj8GpYXlL2X0TLiyzOeWpv+D+HmTnpT133Gz37SM
	 XiVeaMuu95xK6uqga0F55kdOva/xkA3PvzkKxY9NsCVkpeRW/1CIxU50txIjUyEWDwUSz
	 BDseEcCo1Z5zTdRYIgZbfX3MzcAWVvDGeI6WmCHrPNWFicy6jW5igXZD5VlR2Apt7adH2
	 500h8mGxHmeyGRweOMu0Le1Ja1b5SywHrrnVUk9mkeGSfcS4XK3M88z5q054dS7drJt4v
	 Bjlxl5QZSoaemZe9D2KntVyS/BEboUM8hawbTpcp1bhN3qtHxCYGxOiVTxMn8YkcqWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkT1Vx+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE908606D829;
	Wed,  4 Nov 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkT1Vx+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D21F0093A;
	Wed,  4 Nov 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817616;
	bh=0ahLYAFU+clP2QENSRM7LilInaXH9CwvLAvnJgnkbwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SkT1Vx+Cp6MB03+7BN8eBEoe0Ft40UTU6swhn0LECT8KdLw3rlG+i/+PSrLrOYKbn
	 GmP6Wc0XMlHAkgXuTCql01ROTGIEdS2u7QV26B6yklRZn1wNn1Q+RvqPj5Q/YXjF9n
	 Z0K4WwHnJosYGsBsioGBc9aTvaflmGHDkcsldz/WE9QNE0N6jOlOwICbb5zBo0kZ5I
	 zXnd0tGJYgfqf4iI5WNarx5MThiJdeYIaETfMcC/RgtFlhQ2LF+/mBHw9FamRn4I7G
	 IMBCbOXls7tiWh2hhBskNhOaJFOFoabylwJB4nuvhzlMM/wJ66RTSV5m1Ngpf9ZYhP
	 9UMvclpxXE9rw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
	Kiran Gunda <quic_kgunda@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Heidelberg <david@ixit.cz>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 5/6] backlight: qcom-wled: Check for auto-detection callback in wled_ovp_irq_handler()
Date: Wed,  4 Nov 2026 18:39:06 +0000
Message-ID: <20261104183935.1214630-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104183935.1214630-1-lee@kernel.org>
References: <20261104183935.1214630-1-lee@kernel.org>
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

The wled_auto_detection_required callback is only populated for WLED4
and WLED5 hardware, remaining NULL on WLED3 (where automatic string
detection is not supported).

However, wled_configure_ovp_irq() still registers wled_ovp_irq_handler()
on WLED3 when an "ovp" interrupt is present in the Device Tree.  If an
OVP fault interrupt fires on WLED3, wled_ovp_irq_handler()
unconditionally invokes wled->wled_auto_detection_required(), causing a
NULL pointer dereference.

Verify that wled->wled_auto_detection_required is non-NULL before
invoking it in wled_ovp_irq_handler().

Fixes: f16899a6a7d4 ("backlight: qcom-wled: Add callback functions")
Closes: https://sashiko.dev/#/bug/linux-d3eba287-2af9-43fb-851f-78ab3df0f35b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

 drivers/video/backlight/qcom-wled.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 8d4d7fe5e84d..06300d403f8f 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -917,7 +917,8 @@ static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
 			int_sts, fault_sts);
 
 	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
-		if (wled->wled_auto_detection_required(wled)) {
+		if (wled->wled_auto_detection_required &&
+		    wled->wled_auto_detection_required(wled)) {
 			mutex_lock(&wled->lock);
 			wled_auto_string_detection(wled);
 			mutex_unlock(&wled->lock);
-- 
2.56.0.385.gac671c819a-goog

