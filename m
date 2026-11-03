Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695321;
	b=EmmNovrKSPELEYs2Eoo5n3ueCk5XAvW7kKIZ+xPNbfl0YNuGYnk/G0Ao8Yn0GMAMWwtp
	 nG/g4F0ZSP48s9cjt4LaJZGRhoRrouHzhjE3yHpFgYxrLl2/OoR9z6v/6VfT+YWZ0zgky
	 q4KM64RMWgrWJe86e+7c2G2MwBISnJnPDQ6ynsg5t6Qvsc2XChJjfIwpF8EymuCtoaPM0
	 AhzhhUvkNK8rsbNiSsHMK2Yz9bdQGFdBN5s8qHHHKIaHaxruyHLLkqo+khpAUPXWgHNJR
	 O7pG6JZjwPQnHJtOeY+xPLAkLN7q7diViGyZPGP0f1jOq8/te3vOhH7SeN0Rnsj3adA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695321;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eCqW7Q3ZNY5z9Vfz8jumrGbHLoTH4qAh2fcB1dgiNvk=;
	b=LCdyWGF7ve7Km+9dJo5EiDACsnKRdJe8CQbkBb+9lL38yNPrzMmZa4sGhDOiTZwOxsoe
	 DzNCxguVXzYfg8NuIqzk+yfq4x0lGfEZR7VlgRDqt442tqr7XtckVIuAjA6sox8M0V7yp
	 8XmFcAJTq+aEh6YP9KcHjS85GElxlcWZ5ppprqNjINiIaDpzX5E5x+ZOAO6WTy4XVOsa+
	 6qrSdGHZWrulJye6GUCiamgs+mbLhI91fujvpEflZKEMfNpZeDve/A7l1NxxsWNEMU7Gc
	 McUMvUjbBsfbXM6gpd/3/+fzAYyRcOEnhmKlg4gntAk9fBeh88DNGpCtdiZagTFWBKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hvqs12+j;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5F606A326;
	Tue,  3 Nov 2026 08:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F5F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=hvqs12+j
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695318; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eCqW7Q3ZNY5z9Vfz8jumrGbHLoTH4qAh2fcB1dgiNvk=;
	b=hvqs12+jO7DD22b0hS9Yc/jZWUQ9X8nb6IbC1pDxRJyel6nYSmS3Ob+eM3Rb/X+WDGPf6K5aUtcOfCpHVlqpYJoOiBPcXJ0ONbX+IIUJpvxWulDPwtbzle4EJXuHh/onPInnrU1bzprliTlMD6z9gjpZvLsWv24WlI1majOa2rY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07659294|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00649487-0.00207021-0.991435;FP=13138527801659950782|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jvVDfhS_1793695317;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvVDfhS_1793695317 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:58 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: luzmaximilian@gmail.com,
	andersson@kernel.org
Cc: konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] firmware: qcom: uefisecapp: Fix overflow in GetVariable response check
Date: Tue,  3 Nov 2026 16:41:57 +0800
Message-ID: <20261103084157.426838-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
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

qsee_uefi_get_variable() validates the response written by the UEFI
secure application before copying the variable data out of it:

	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length)
		return EFI_DEVICE_ERROR;

All three fields are u32 and come straight from the response buffer, so
the addition is performed modulo 2^32.  A response with
data_offset = 0xFFFFFFF0 and data_size = 0x20 wraps around to 0x10 and
passes the check as long as length is at least that.  The check on the
caller buffer size further down only compares data_size against
buffer_size, so a small data_size satisfies it too, and the memcpy then
reads data_size bytes from rsp_data + data_offset.

Since wrapping around requires data_offset itself to be huge, the source
pointer ends up far outside the response buffer, typically in unmapped
memory, and the fault takes the kernel down.  If the address happens to
be mapped, kernel memory is copied into the caller's buffer instead.

Reorder the check so that no addition is performed: reject data_offset
larger than length first, which also makes the subtraction below safe,
then compare data_size against the remaining room.

Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index befa68d1dcaf..0dda09ad156a 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -387,7 +387,8 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	if (rsp_data->length > rsp_size)
 		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length)
+	if (rsp_data->data_offset > rsp_data->length ||
+	    rsp_data->data_size > rsp_data->length - rsp_data->data_offset)
 		return EFI_DEVICE_ERROR;
 
 	/*
-- 
2.50.1

