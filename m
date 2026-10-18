Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835749AA4B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359511; cv=none; b=Qk37Rz9PWDG+6kHlgEA2BMEubuB2fWyKuQ1L/o3SjszBez3+DsC2iGgfPiyOhUplWJNAycRb5frOmJwsLF7FgusqPmmThdjuKenNbHUw2+WQtRFWGJF8T6okyJIDn1CSRNwOxISFCQfsiBS72DV96el2DHXTSZdiFicOlp76lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359511; c=relaxed/simple;
	bh=5wsrlnsyVUyKvnXf+lRWfv6B2944VYbzkpRhaaCTiDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CksjJVUXDQs3UcwAo5QYekliQz1jlv67hrlnYXBi/WoL5xQpoHeaPxNH3kCdZO64MqrhmkwiQ1skMbEiGvY3Ek0MfA8NNOe4TiNHRfe7njnggAHDkufrUtvcgX8kbg7OTZrZcWC2mBBfpSptJF+ovFbYJ+0h0nshV7qDBByzu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/V23NVw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/V23NVw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4d870d54so845965f8f.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359508; x=1792964308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yTHsJf/ydt+NtEYqMFxolxbcYpfS72oO0ir1gLhxLlA=;
        b=o/V23NVwzo/RnVs4/NT9HEfDPfxE0eMP8eGoolWa7JWlzfjj0LFI386D/gSP1bExTs
         9BL4R+udM9if9eaEyJRFCmu3TObu5xeFm1RuMtL4bfHNUo25fakyMjj8COlNpnWTFjQU
         gwdTzHCZa2b/QRbnM8fZEEJqMIxIjEkn/5QtlJE2iGAjYGAC9u6SPikBc41f6sNQrxr+
         XfWJ1RHFalJRHVQT+/0nRO2oongGNzgwnqg5GoPcs9ys729XqGSzrUgZmwqNE/EOZ+lM
         nrUexKWz46uWu5/6q4Vln2A9cscFhlQieRKV5UbmxkRaJoOI+nPjWSp2daD0LRi3cfoP
         jUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359508; x=1792964308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yTHsJf/ydt+NtEYqMFxolxbcYpfS72oO0ir1gLhxLlA=;
        b=ZhH0tb7o2uf79d6ddJEWwYbTL4dK+xMVTO63izHWNGotl5Y0pT/M3q0QoqqUR1vBU8
         QEJKwdnzdm6mvnv11/YXMG/prLO9KJ/revAB/mDvIci11T4nIZLBblDUiC6mhmasGclE
         T8ShFr40Z88Im5MkaB+CcM4SAIkaSZ0ztXBp8MxH93YPezJUbZJ5xAMabEzxoHxIuJJW
         hqqAv1UxzShqrUX7Deu8S6xjhP5t1NRqosAvqkpr3anlySI+NilDuBw/pZT6m5E2BocK
         zFWG2I1s36EAYV6X1eUzx9ACi75NarFNPhvWiZb7U2fMz4vc7dlBiPbuIrqMqygV8mzI
         7dkw==
X-Forwarded-Encrypted: i=1; AKwUvBzDFiuKiT5sGSQTwMWn6+QddMgpz8aebF9VwFNjJ87mGpXKNsHwulvlLE6Zt1Dh2odMf6qXUzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuXwaDHGM7xp0W9uTPkgotDLRvpx7H6nrSONHS3fRDrz8zR9vd
	Nc8C2PnnGZxftzGrCceowwHaeJRKWR6Thjh5+GIPvn8OB32xKIxhL2A=
X-Gm-Gg: AYBFou0m2VOscfD2gYIqKZyvGVOSP2bdo5410JNTCETx1xjcjem/YPcDURfLkJalQLa
	VRw9b2k47DSKWKPAk/eBNA55VGlIhIs3d5MHfFK570NTc6JJwsPsCLt7zkQpLwn5bys0VdljbIj
	0GcywY0HQRR/4C1uESw3zMqhN75WUal4bhz1ar037bFZRwHBtP3rNvtdC4VR735cQSz+yzYwgPN
	21zNEw6u+zic+riMyd6KZy+ZlCBtzuI25QAZVrg/sbBXTYpT52VevaKGowQAKoc6BbVSNxpUct1
	Bp8cQGSKfxm5WuONw2U7/zhlmnVuZaJW5xByF9SsrYsZbsEu8SNjliPkHutvlGFZyBjiedRi+Ef
	F8gbSdb2b7pELIvV6fae0xneXpPu69Ytg2ZFfHyD0WugaDWnNIpDwFVxQG+PMdYLpX7RhFekWTi
	Pwi20MKTb3HZKSeoNr/R1qbv7PJJLLwOeSaIQIFmg=
X-Received: by 2002:a05:6000:605:b0:48e:10a7:438 with SMTP id ffacd0b85a97d-48e10a705abmr5408157f8f.36.1792359508375;
        Sun, 18 Oct 2026 14:38:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:26 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/8] HID: prodikeys: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:53 +0000
Message-ID: <20261018213754.1951187-9-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018213754.1951187-1-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

pk_raw_event() accesses data[0] through data[3] without verifying
the report buffer is large enough. Since hid-core invokes raw_event
before validating the report length in hid_report_raw_event(), the
driver must check the buffer size itself.

Add a minimum size check at the start of pk_raw_event() so that
short reports are dropped before any field is accessed.

Fixes: 3a370ca1dcf8c ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-prodikeys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index fba01e4fcab1c..c1419e6703777 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -768,6 +768,9 @@ static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 	int ret = 0;
 
+	if (size < 4)
+		return 0;
+
 	if (1 == pm->ifnum) {
 		if (report->id == data[0])
 			switch (report->id) {
-- 
2.47.3

