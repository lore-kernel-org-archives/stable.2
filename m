Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59442A82
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764674; cv=none; b=qwY+Q97HGdKAmH0Q/CRRCjBfUWhasbY8ma3+I8+Tz796TozEYlWkynNCrMgLcafMtUusX9YKqXZr9JhzBrZ2xsDmUJpVfhDNEBmaD76+KafEpcC3dHeVNiHXh1Q/qB4FqTsmM2FvDRI6qWzRJnyo/OXMSbeODe6GAngOW48LfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764674; c=relaxed/simple;
	bh=nmwRkBcJk1AWDx8hk3Zl9lyX0co2UPbT+mxFAqpceJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/U+UQztq3zXotRnnTwOwuwKO8Giy7izoGLCi4k8jZC0+2PhN46SnT5RkkucGjMi4hyYG2jeLxnKEzzUgKgYL5MiE8KbQl0MVrX42rjhKn4HPLe9Uqmsp5Cqtu0VXJyK+YPLpZm9zmoFywVFlc+JONUo+9tFhzmTDa5X08vIVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+JkPenw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+JkPenw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso4195445ad.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 23:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781764673; x=1782369473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mva/B6a1iolaNeqqoEQ3DAV0kliAQFp7oxE0v01gtHM=;
        b=h+JkPenwilfk+NA1hp3iXxXyRkvNzVKb2R3J7QazpCZovQ0mSTnTnacCgvsbfgv+OH
         eeF1pF+GyEDk48ElfsWpOH3KEgNRPhxUUDQA2a7LcEXAxwNnPAE6FUIKHZzs9rX87Coy
         x5c2vP2noR8YPxqgR0GH7HkyOTAVQ/FVLJqavjxlyz2MBHpeC5uP6fnOdkvab60cRVsy
         N3GCqoXhr4SHNltu8fhdgF5pW18fIP30UcFTFVYbKSydgV0hPcG2ZkluzhvRCT7syyAJ
         0AIF5lQOvZHdekNp/6cYh8Vf1hUxE5Fsgy3rRcZX+OWUXvjQFe8e3Iq+pYJ8bF2ombNT
         Ewww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781764673; x=1782369473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mva/B6a1iolaNeqqoEQ3DAV0kliAQFp7oxE0v01gtHM=;
        b=YVYbTU8XqFSdH8/NgkPnV54hQdN6WtegWFcy4mJPh1ErcTSFYUy/vZNPjTVhEwK9sE
         KIY55wqmn0j/M4IDVgDcIZwqdpAEcWkYX6UG0Z8UDfJPce71x1b/AUCbPVGW/KT0DWmk
         mMtl8VUVmmFEt2bVfNglvugF2MVc8Zwc+hj1YrzkaXMnoQ+pa4PNRepg88qVKKUHQMDf
         UskP3xyCe/CfhD/B6YjDHVL+hybboMJPhejJTe38g1dO2TyxeD1A6Xpn0RCP2m3bD3Tc
         vv5f7lZ5qSU/i5re6bnoAysJW7GIk638L5PiC42BgP0Wa3C81J3JVrifBheepTKyPQgp
         H1Ag==
X-Forwarded-Encrypted: i=1; AFNElJ+VLuT4H190TfLaU2F8RWJ68qEUVcPW//1MlPNDwuKD0fPXZu/Zx7XQf4arUvt8tqTkFHs8Kkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDmy0SbuSIxOP91XBqrj4oG823yf1409/spUWMRFgjY/i0pEh
	QTk4pEos4UMOsrhBIQYcFJoUrabmyfikTp7b+Gft0QfSHodyhUhD/7ED
X-Gm-Gg: AfdE7cnJzY0xMpPFcMqN6Wptd29Pr2HbGwrHL+hNTgclWh63WRdPeSOWMeTQaY7hqW/
	7uTjs4My+pRhMmwBgeilvJKKydKlApR3dIzcoGpfPnCZk7eweMv04f/hoO96cdDOXGVD/Qhre0v
	zHxBfZzeGAg4NLui6WHxRMb2DvjKcupx/wc7I0rU4FKuhYIAoHEC9d8EiUXn5RQ+kEL7zG3gbq4
	qOCJIpaOyYufvKTrrLY29Izout2mHMGSYTYH9hSgcBa38dl7Mm/42MhmpO+hgcR18TEhu8uKk86
	zZMqt/UgOGUZuctEHi1S1zdb82bxDNlqE2WuKTmBN0jAjTcUmXTqUatbvoHxrtq7NnsccK6lA3z
	Fg9ejCY2uP+6elYahrk3O28SjJPpGqow0sQhd1kXL3xGBgqPnWaDKxC/jSAhiC+TjSu+Bd5XdQF
	XrZZRHIW2HwO0st3jiOC+r4YRnNkZR5Bp3OXwaC7/fdkBvFktYZqddgOjFMcZN/Ur74+nV0ha+b
	yvz971gKtvCLUUJ
X-Received: by 2002:a17:903:41d1:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c6bc27e37amr70977595ad.35.1781764673015;
        Wed, 17 Jun 2026 23:37:53 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6e54e8257sm13505905ad.16.2026.06.17.23.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 23:37:52 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: logitech-dj: Fix maxfield check in DJ short report validation
Date: Thu, 18 Jun 2026 15:37:37 +0900
Message-ID: <20260618063737.211468-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT
related user initiated OOB write") added validation for the DJ short
output report, but the error path dereferences rep->field[0] even when
rep->maxfield is zero.

Commit 8b9a097eb2fc ("HID: logitech-dj: fix wrong detection of bad
DJ_SHORT output report") made the check conditional on rep being present,
but a crafted descriptor can still create report ID 0x20 with only padding
output items. hid-core registers the report, ignores the padding field,
and leaves rep->maxfield as zero.

In that case the validation enters the rep->maxfield < 1 branch and then
dereferences rep->field[0]->report_count while printing the error message,
causing a NULL pointer dereference during probe. This is reproducible with
uhid by emulating a Logitech receiver with a padding-only DJ short output
report:

  BUG: KASAN: null-ptr-deref in logi_dj_probe+0xb1/0x754 [hid_logitech_dj]
  Read of size 4 at addr 0000000000000028 by task kworker/4:1/129
  ...
  Call Trace:
   logi_dj_probe+0xb1/0x754 [hid_logitech_dj]
   hid_device_probe+0x329/0x3f0 [hid]
   really_probe+0x162/0x570
   __device_attach+0x137/0x2c0
   bus_probe_device+0x38/0xc0
   device_add+0xa56/0xce0
   hid_add_device+0x19c/0x280 [hid]
   uhid_device_add_worker+0x2c/0xb0 [uhid]

Reject the zero-field report before printing the field report_count.

Fixes: b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 381e4dc5aba7..9c574ab8b60b 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1907,8 +1907,13 @@ static int logi_dj_probe(struct hid_device *hdev,
 	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
 	rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
 
-	if (rep && (rep->maxfield < 1 ||
-		    rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1)) {
+	if (rep && rep->maxfield < 1) {
+		hid_err(hdev, "Expected size of DJ short report is %d, but got 0",
+			DJREPORT_SHORT_LENGTH - 1);
+		return -EINVAL;
+	}
+
+	if (rep && rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
 		hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
 			DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
 		return -EINVAL;
-- 
2.43.0

