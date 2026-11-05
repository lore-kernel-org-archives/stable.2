Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851312;
	b=tdUZ3c3cylaN8vFRu/JGwH6Zn1I8Pc1ocsVdp9eZlGcHyE7cSGGR+qK6QEEbi2zu6AOJ
	 2C5fOoS57+Qx2dDDk2RE0GMmVoxknpPeBS3R3CJYYIs20dAPf8b0Z0twPiXtd6KYE5Ldv
	 sXwK3hcjLwolETRJNIUoX2xo/r/BfHz4GUZmnmk80lvwnADtb/qY1NUoYYqiBYqoyVyqQ
	 m7JCL6ERdvolWWME7wXV6D/gskuoaDLpgRE6g3NvYCc17V/JEH/I1RBuoS8lFH/CyGl4S
	 821smvyEqcgwR9AKnKf01PkMM1VRcTg+bp5aVnOAS8FpECE/OLvBB88+mma8dTVcV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851312;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+1XhpDMLS3N8b4rxkcQ6ba1FdRhZrMu8bFDnS6EmY0=;
	b=zmkGsTRrvMx6xUTDhMDLmk1/bqIZ9AnR7tlK6rouLzlX4nv2g4799Q2QEl6/D9u42VRl
	 MOXgsRk2yv5vHJciMo0RqM2e4fgvnDGa3eL1CnzuqIbhD7tjSTZuJA9o2JXNn6CvxlHON
	 mhjnyktDq1ju/xjhU4VLf1SS1zvEfWpkG82mVDgi4Y0y/4tyx7u4n7XRcy+i3h4mUAjEY
	 hwNJAJjazTBLcv3KmKXfxqrvI2JbrZuoVMLgjYVrSzl6ll+jmP4LxMATD7oB8UgncmgXg
	 opyj5i6NCWhmeeA7e8gOdSZ+blaiMDiGX0oiqYfKjEYIaO80YGQl86WDcAr/zrogo4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FZcfmIsH;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83383606A326;
	Thu,  5 Nov 2026 04:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83383606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FZcfmIsH
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793851301; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=G+1XhpDMLS3N8b4rxkcQ6ba1FdRhZrMu8bFDnS6EmY0=;
	b=FZcfmIsHWVcYiS7W3YOaaq4pBuRc2IsMOeDa/PRdVd4vb0mL24BeyOszH6AcroAkwGMBcj7zkOaSHdcFENlvel8xqQirzQxAisdQIgBlG/j7O5lz0IrR8pkQfnUeQYOH5T3iZ+9PxFLlKCnhE9sja984YfZuwSqBz28aNnMCn+o=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08232305|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0173496-0.00129538-0.981355;FP=13138174583549466298|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jxHFe1Q_1793851300;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jxHFe1Q_1793851300 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 12:01:41 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhugl3@xiaopeng.com,
	Weibin Liu <liuwb@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: qcom: uefisecapp: Fix GetNextVariableName overflow
Date: Thu,  5 Nov 2026 12:01:40 +0800
Message-ID: <20261105040140.66496-1-zhugl3@xiaopeng.com>
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

From: Weibin Liu <liuwb@xiaopeng.com>

qsee_uefi_get_next_variable() checks both variable-sized parameters of
the response before using them:

	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
		return EFI_DEVICE_ERROR;

	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
		return EFI_DEVICE_ERROR;

Every operand is a u32 taken from the response buffer, so both sums are
computed modulo 2^32.  A response with name_offset = 0xFFFFF000 and
name_size = 0x2000 wraps around to zero and passes the check; the same
holds for guid_offset and guid_size.  The name then reaches
ucs2_strscpy() as a source pointer far outside the response buffer,
which reads until it finds a NUL or exhausts the count, and the GUID is
copied from such a pointer as well.

Because wrapping around requires the offset itself to be huge, the read
lands in unmapped memory and faults, taking the kernel down; if the
address happens to be mapped, kernel memory ends up in the caller's
name or GUID buffer.

Rewrite both checks without an addition: reject the offset first when
it is larger than length, then compare the size against the room that
is left, which cannot overflow.

Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
Cc: stable@vger.kernel.org
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---

Verified the wraparound with a userspace replica of the response
parsing: name_offset = 0xfffff000 with name_size = 0x1100 passes
the old check (the sum wraps to 0x100 == length) and faults in
ucs2_strscpy(); with the offset landing on mapped memory instead,
the content of a page roughly 3 GiB past the response buffer ends
up in the caller's name buffer.

 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 0dda09ad156a..2c8f6dfc23b6 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -605,10 +605,12 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 	if (rsp_data->length > rsp_size)
 		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
+	if (rsp_data->name_offset > rsp_data->length ||
+	    rsp_data->name_size > rsp_data->length - rsp_data->name_offset)
 		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
+	if (rsp_data->guid_offset > rsp_data->length ||
+	    rsp_data->guid_size > rsp_data->length - rsp_data->guid_offset)
 		return EFI_DEVICE_ERROR;
 
 	if (rsp_data->name_size > *name_size) {
-- 
2.50.1

