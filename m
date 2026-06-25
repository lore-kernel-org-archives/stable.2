Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3342FFDCC;
	Thu, 25 Jun 2026 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394169; cv=none; b=WWkh7yzk4JC3ozhIVibYcVtODhHf17ODHobOubiVErEXcXiOkW32qZ7BL1UvCuxnx+ujXqKjAm97yMYMj1e0TJn1qw4iDBzvPxDdhDuIfow2Qj0dU0nI4SuQ0zMALrfvDWqzYTj1wDJV1uxFLY5zlbI2SH79q0i68p43/1S2orM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394169; c=relaxed/simple;
	bh=lR8ReByppS9j0Zz4J5mwLiH/Kk6k6t8oiAGWQgVuRII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRbeEl9O21k/3I4sqnTGI8YYpQhTZk2S9FlQ/oix9WSXB/1DWxX1TEWij2g+WZ75hwCYAOCDkuoWFx558BpXxeBrOjWOOb371nJZa6YYY4KZNqnc4Nfa1zDaojCf1BB7alBexRgRJOfVjYJRcqtKaVaXreY6TpHtXkPWKxLeMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oLokY56C; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oLokY56C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782394152;
	bh=F/c9kHQD6QLg3SohqohRdqazcvSfghTJd0SGSsKc4/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oLokY56CGY4x8zO+t5Dh+WxZpFwJ2EuxVC5b8Jj8//juyWP87u2d0Ya4oRduZQs/d
	 ++kVKZLn6jeviIPBRN80ZcxIrr2HXTUgqI8Qz9Ma8ZeA8fAaNCY9UV/d/ayh5Kpvge
	 RPwfnaiDGuxh6iFK/yIWtt6zH89A4ef/SdJfj8xA=
X-QQ-mid: zesmtpgz1t1782394147tb3c9e761
X-QQ-Originating-IP: PZeMdAOHBtXkAHxpAsB6podZ48I51po+U9kHMja91gU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jun 2026 21:29:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3255596446001045278
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: TAD: Check AC wake capability before enabling wakeup
Date: Thu, 25 Jun 2026 21:29:03 +0800
Message-ID: <961A84FF37B50665+20260625132903.2840457-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MAL61fhe2h5SZjwhnlJBOSASzuE5jENPOQOlGmIjjPJ4QPurwrtFvTBY
	bUkJwkZyv8Lc8p0nE7G1Fvji7xZyef7exb78G4ZWrJd2gANBioGoUc5uyjebVcJb0zBNZJA
	/PmVGFgbCX2eHjqm7pXmYDqYnwC+CbCZCY83/62UFVfRVA61b322g5/ysL54cmH8tyUNtO6
	9eZ9hF40lPRg2wzSvEv7AQ0YJ5kqS3FH3BmlpRYB6jMsqqidIcL5dww8WzWYUkerEgStfTi
	cVfeGUYXQyzCHhXdBiRpgkw23VrbNiAqKG2R//v7Q41var812gaOuZhG8bGRaGuwcO9E0nB
	eG5lsXWYI153jsSV4tKB7fVRU88NxGkSIsA/Zwe4m5MG/ge5vayTrgPSD3dU9Aub6zM+6w0
	C248oDB5sSvc4owXqNWvF/+qCvc01zgBeR03zudtTxEhC0ksom2O1BxJd9YITxTo2W8ic0C
	hLbZ81XFSfe6x747hp1HhQfV6eWgI0yvTeRAjWHNwo5gBIgsSFytYTN2/kRto9JBBt/QRRe
	aEOqwjHqLPxo9vI8wbMvspL1hEkxaaBulMpNMxRwy/akXDyQ/+PgFhN9ME9n2YL3RcbTIFL
	quToswRU4hI2i3VxrHo6YeiBdWPwuxrQuED0x7eGOjlQBLADxxuLTsiZXobNk17v2R8to4d
	qEUtYqSqqheeMKQPwaLL11CJHKmrXd/07W9IJZYqR3UBHuaeKboJygxvxcoM8yeY/UU1TBM
	RaqB/h+av9nhrIuIQCMGdo7clJs6jhAio1w0ab5a5DKxIBAfl8zsZmQiGIojDTq4Z1wXdru
	Gyb9iEKmgFtbz0UE8FXkEgujmP0nG0EZ/knkSTlj1sBPNERztMVw+53gNPjyeDQJ5Zs7Xi5
	sMTcRIb/8s9r7x3oDnhAZzHiCYOhIrkMij8abIZELpQ+AEljiuFd4W0fQCwx0ZKx5heI5yf
	n0SFTyFZeKO8dRoVldHqMvw62ahVg88gQhU/soYE3Zt4yUC7Af/PI8kGODFx40ABsIy7wPM
	5KE8oj1sVR4XN5HLhPk984rUW9iVW4L321zwHRHG9sHsNa3MLO
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

ACPI_TAD_AC_WAKE is a non-zero bit definition, so testing the macro
itself is always true. As a result, every TAD device is initialized as
a system wakeup device, including RTC-only devices and devices whose
wake capability bits were cleared because _PRW is absent.

Test the capability value returned by _GCP instead. This keeps
RTC-only TAD devices usable without advertising a wakeup capability
that the firmware does not provide.

Fixes: 6c711fde3a1c ("ACPI: TAD: Support RTC without wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/acpi/acpi_tad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 386fc1abcbdc..fc43df083738 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -856,7 +856,7 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	 * runtime suspend.  Everything else should be taken care of by the ACPI
 	 * PM domain callbacks.
 	 */
-	if (ACPI_TAD_AC_WAKE) {
+	if (caps & ACPI_TAD_AC_WAKE) {
 		device_init_wakeup(dev, true);
 		dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
 					     DPM_FLAG_MAY_SKIP_RESUME);
--
2.50.1

