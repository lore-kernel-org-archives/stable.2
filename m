Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812650;
	b=OBnlwNoytdjglABXIEsSgKuEttrGsWJitLBVRIlpJTun7siHEKQm5Wj9ZUb00fhySa+7
	 gs1W9ZGMIyHdMJIc7weIKBIWN6hisA79zYgjVlDP5A0vX1qdUbF8kCgnhonfdnnIv+UoU
	 9xPVdNPUzQ2EYCcrri4Np9Ok+0fkT+4C8B7Q2k89bJu7RYuss507jw5Ll1jYnvDBD7GiA
	 ewSwDrUvq9bbmpHHBlkEM3VX+zalYgs53YmZk1w/TkyDfsGEumsM7IZ5qZ+CFLxWxK7TB
	 DCyjq58TVmfmt9yFogtG6fZU+5izos1tTAsfgs3haNVMZLQgzCDTiljLNGNwGjEZuew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
	b=0uis5TBGJkAVoemKzaY0tgdT36nm4nwQd47ILyA2EBhshrO1cHXvEsDujDe1+zIM9pv5
	 FD4izmGHhxEjUu7IH6Lx1ZaFjg0lW30EusM+aw03KvxWlOkkXoseIwRT8vBXObnd5KKtn
	 EpgjqeokjKsN36bL+KNv9vwKppz8zFoAt8Iu1lsExAjFEdyi1AM+/gqzWdLlEEtHgFfXs
	 NYpbnsxj7PUq4RPIoXgD1dS3Kn5HMZa50bFfVRokRtSszZQl/XJOKLEQ9xCfLmiwIE3Kr
	 bqVI9s7ihsA3I114QyNKNtOkh1P5UHmFGsh4U8eAUgy/ZKcuroOB9E61T7AEA5T0pNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="AV5Y/H6z";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB81606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AV5Y/H6z
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2772693eec.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812649; x=1793417449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
        b=AV5Y/H6zdr41aHo0YPq4T9T5ypgyuVSX6pp4Yu09Y2B5L51c9JJm7hVn8k99X1SrW5
         udT2Ba2CwHecNCErVzXowi8FD1zKk6aHr87v1TPfalaiWtvB4zIJS0wQAvBYgzguerTJ
         BMQTDXEpCd/NrHxhRsLkGHP7N95aZ9nsYVPUSR+SSWWiwTmF53MifHCUPfk58+UXEsWD
         62TzwGi1VH02xbL6Wiv0ulI6YaErYKbSXdF935NFb89QcWFI/e6WxI/Ecl+FuZukg7FH
         daY96fB07xpdAb3mwdLOiZzzGXQlPwIOHiHdYZIYSF3JU0vPEYmn245yS3UeqoUsYHVu
         xCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812649; x=1793417449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
        b=qJiwIjjwEbBKGmoq69gFSdd1ji19s3GromSG9gucq9pV5qxE6dxxD73G1qZdzAFZ1X
         eBEpSabSsAMbxNol4twzbMpjddrUe87T9Qsr8ONR74gtDgFNQ8K+x4nyUqLf+dtXqtE6
         N61lQooCLdsLChwxUBSiaLAGWEGfElysViVGcn1M6jWC5ALVXYIC09Q787Am9H0XhBiZ
         +2NXr+J2lRm20Zean0x+ldB9hAXjnWSAyGsu3EhaPwRiBKVl4Fl/MIyUTBCmgVJs/HY/
         iDHaj0oqa7DFgB1tnDBM0cbsZDWOMFRoMakcXZoKXToKCMyDhMusu1Yp7VJNkSho0Bul
         I7Yw==
X-Forwarded-Encrypted: i=1; AKwUvBw/reLRdtXRi3bERd1laTMMHSutSKdEh5zDY55QSIdD/ZmNI+CJ7jYxjI5IMPW6oLd9dmZ7SGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoxZp3iIf9iufPh9bYmBaffpAOOraOrexB8BtDKavYYPQRM9CL
	1tie/xLzi7SAPtZyEW5pAnu2Q1Rvh1Jw0xAkUz8xeHik4VCyE6en+/uD
X-Gm-Gg: AYBFou0TMDdWaritavjI6tWttsGX357YhBueo3JULLOMGhdnWyP6ZQsCGlPQ0jxB0Le
	QOqDDqrzUM9vn25StM6QM74dz66kMR39+CuufL8EVjc8NFToXIsyamH2me09q3HbB6FHs6+dVAD
	LBK0knP3tRqN+G1vWafIOauwQ4dFWPcdf/RVBqy87H2jtI3UNaFHZEzmu6ucSCBoDoxx4GdkYVF
	31zntmUnpn6QLS+1b+XxgcRcrGouaCWkAgSBtFbApTe3HUDDnUJBzgEGb3jPTGJvxnEh1uun/r2
	BFJV9WCbT2pfLzd9UBvzbqxWYwi4gIQ0pk0Q5BquN8F8gI+nRjBsAcBnt4Qe17a2fzh4oIKdaDj
	4EHspPgiAnE1KxjkYrQTfWXAOgBZI/MjY8ED8TeAYj1kcrlyJ9HovgwDKlKa9T0cqTPTGeYdT6e
	FW1Wd3kflT0f06Rb73EW/CWOicuqpPsx32T8TTyIwLO17MwNAvwVqefvGWcR8gZs7XfsxRDdbkn
	SK8zeXWAT1gJm5GsjNxheQLDl2pRSOMS3y8sTJFYU3p0Gc9t6Xi/rmPnsYbSncNoYuGhVR0npJh
	OCP7bngCXlBB8fgcnBh1LG57ffbHKGPu0l1Xlgz/L7ZF/5RBQA==
X-Received: by 2002:a05:7300:ce87:b0:35d:ddf2:e986 with SMTP id 5a478bee46e88-369e84dc40fmr1604956eec.11.1792812648537;
        Fri, 23 Oct 2026 20:30:48 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:48 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 1/6] HID: wacom: check the input device in the shared report helpers
Date: Sat, 24 Oct 2026 12:30:35 +0900
Message-ID: <20261024033040.316652-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
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

wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
reached from several report handlers and use the input device they are
given without checking it.

Both can see a NULL input device on a fully successful probe. The report
handler is selected by features.type from the id table, while the three
input devices are allocated from what the report descriptor declares.
When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input device, sets the pointer to NULL
and still returns 0 - the "no pen in use on this interface" case.
wacom_wac_irq() then still routes reports to a handler that passes the
NULL pointer down.

Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  BUG: KASAN: null-ptr-deref in range [0x290-0x297]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
   wacom_intuos_irq+0x29e/0x3300
   wacom_wac_irq+0x1b59/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check the pointer in both helpers, following the convention the driver
already uses in wacom_tpc_irq() and wacom_wac_pad_event(). Log a
warning on the first occurrence so the condition is not silently
swallowed.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..567b01882eb1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,12 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (!touch_max)
 		return 0;
 
@@ -4226,9 +4232,16 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev) {
+		pr_warn_once("%s: input_dev is NULL\n", __func__);
+		return;
+	}
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.53.0

