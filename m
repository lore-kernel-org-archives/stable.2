Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222571;
	b=21zwbixO2V4/Y5u45SKoevTUsbudNmq3ELAmAJWm1E70xaokopdFDEe6uvcMl+igWLNA
	 atKP4Dpj1VtpAtsMXFZRzXAantyG1oNuq+qL9+LvUddWSG4S3+gwXKdC2dRZBuPX0MY6E
	 5fW8g/wv7Z3bNhTAquHVvFa9LxuXlW699JtYc1n4AWQhobRUSNMqLX9ZtPA4gpGzlVdmP
	 iaqE482vVe30R3KZjiqfZWF1E/cdCk7x6L0oe8OCF3O5Qocbdhkcw+qDFQCi7RywApXsb
	 6n+8bOMghXLBQOCH6yLEXQslAbKII+I2g187/pPdlWMY0GhtSYHmiwjPo5rnqC3S09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=i3GTOPnQyWclBIu+6MA2Oe59A19a3zhTv3uiRFaf8C0=;
	b=ViPvkxZFw7Wxjay4IgqQ70JaPzgtBiDiXGGaHUAAS46fmEqe986JQAj8XCqB7xseKS9C
	 lAFLkneggMWKPVMaaAwourOR5LQ+GR6OPvIoQWFeUBxCTOKPYY2bje9sVuSsHTxID6iCq
	 fl2OpKo0fA9JiD5nR+j6ojyCGxwSuSPgFAMLcBpDFIBpdhCIl7qeoheEUKIpaQgiWpoc0
	 7YpBFUpFe5deyo2KNUdwkWof7NfrSPI9OcfN5GTTur3vULZEihR0W2jRc4cGIfFRObl/A
	 WTfhx+F3M5YJK3iRWeVhQ08ACW+SrDzfxGBL8RNf3jnQ2BdKXgpS6HPlb8WzusU9B8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofGMIfmj;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F2606A6AD
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397F2606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofGMIfmj
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso15419395e9.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795222567; x=1795827367; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i3GTOPnQyWclBIu+6MA2Oe59A19a3zhTv3uiRFaf8C0=;
        b=ofGMIfmjUmPZDpbiK6zzZMK5vFaD59tJ4YjxAYXxfl+KJD+gDOdi0nIWE0DDLYzNPV
         NSpufJVrv1sdgw/vRTDF8nkZ5Qg42Lfw0TxabFiDMmhTaD3/tFkPGKnDindJHhv6+thi
         Rt+50uQUnNYolC3Rpj/0VvgeXe3p0nK6MmOYK3bHcGVoTDFC5v2BGfKFabtqnuRaFNog
         7nkJhKDchbITOleWddiXZWAC7aRJC/qc8DqfjmCH99H+TSiinqLsDKCvoaDPLUqykw0B
         KCwlK4+nBTVzCxX3d9uS+xWfQyAY+uhuLZ2RLiXwKH608nOKEmEq7m2f3xZJqgMELpbb
         UVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795222567; x=1795827367;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i3GTOPnQyWclBIu+6MA2Oe59A19a3zhTv3uiRFaf8C0=;
        b=Z+pvwul66pKK0LQLFJHpKBfRHTkfjMaLB9tKJtVm7MvwXLRLmesPwCPO7K13LUc+bz
         E31IEPzCnZipCfgIzfqTYdUIAby0hOv5mVDs2BpJ7/y2G1/VheJL9poe7/d/6E4UJVNz
         qoW/c8EPZ61Xy/JYLJ6XpqwEGtFP7tb2D6Iw/iZ7ovBtFG51MWQ9XK8upD1W6jcax7DZ
         Qw5rEHmN85KNHJVCv3okVEVP/7hs3ZYyAy1OOpo66TwysKD/OhjeDsVdtQZLV98G6L8s
         Y0Dwgfs+lM2GdjUyIG3qOLaoIqie9TtT49Vn3gFHQ6iJAsfcIK0WNycuVkjW1+ozfj9S
         sQ6A==
X-Forwarded-Encrypted: i=1; AL+hErHlyePpEeu0C8wMQRF/wDRgPjpQMyXgMlbFV+3zaUNGVqFRATgRwI1RY9C1FgDsqHta9SUZlKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bbxZJSZKOsUXOI9trbPcxN11+/ETck1PrPhJx+lC9Gxry5ydO
	kgNQYwtLd8cKGRTm1rpX6mOOVlYExuSuv0/ygBBOwLl+gFYeBVdmSsHZ
X-Gm-Gg: AYBFou1ZlxytFHltoz4cVBqbT1x/oonKqiAnWV+mW1cr0C0nTno1dvnmJKbF7tqi2pO
	wDmjADWQEizUwPgtoTFfaSc6SreHRhzX7uLM8ykFUdV6r0s/qNPuU5kynOK9KpPU8Idu1+LZ+BF
	A5IMXqqk5JuDqpCEWrxABvxev1NCziqT4IxhgzP7gZvPsMPTUEHgjXqtg1OP7F7onSPnfm4BoZx
	eUF9mcf147JhgktqP89v2iBnKd/Y3QQqGfueWQeAre7CQSktzOBhkzCTmcZ/yCskTRaO5S9bxUm
	2XuTuNhpY6S7iYHbWxmyAt9LoRdY0LH7F/JPWBx1sLzv3qSSB7dprVFkW0fydN8VzzWMB/zI/Lo
	P87vx0X3oI6GmsLJHWArW4HUJ1O1Q/cO+l6sPeZ7p54xqoqhxLDjwwlDJCqU6ri3TREclQAWyca
	jMq49iOdIPPgbBA/xUfyiMKUDuTsjiX4rqEe6exKwvj2e4CW362b9KLX5IjedZ9uHyTQOP8Ru0t
	o9J5Pz2dcWPUxVqoqtLUnEaeM3xr3MEpp3FfbpsHUxpYSN5uXBdriFFoW6/LwIRYtH2onC1MO9V
	hsFKtUaOQM1dywX8l8t6zBPnrb5I1nDYVPcSqJSbINSCeMAKPxBrC+/ndjsQ3Lg9Sfwv+qbieV2
	5g9C0
X-Received: by 2002:a05:600c:8184:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb8881e969mr101042085e9.28.1795222567564;
        Fri, 20 Nov 2026 16:56:07 -0800 (PST)
Received: from [192.168.1.15] ([185.69.144.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm152290885e9.5.2026.11.20.16.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:56:07 -0800 (PST)
From: Dale Whinham <daleyo@gmail.com>
Date: Sat, 21 Nov 2026 00:56:02 +0000
Subject: [PATCH] firmware: arm_scmi: Don't mark OPPs as turbo without a
 sustained frequency
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-sp11-noturbo-v1-1-37e1083cec5b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxG4asgz0SqDerQqyAGEn5ad0hQDAgJc
 XdSOn7DewcZssLoVR2UsalpigVcVxQ+Q3zD6VhM8pAns7CzmdnFtKzZJ+cRRogENNxSSeaMSfd
 71/V/2+q/CMvvQed5Abh+Od5wAAAA
X-Change-ID: 20261121-sp11-noturbo-becde22ce314
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Dhruva Gole <d-gole@ti.com>
Cc: Haipeng Lin <jimmie.lin@gmail.com>, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dale Whinham <daleyo@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795222566; l=2027;
 i=daleyo@gmail.com; s=20251214; h=from:subject:message-id;
 bh=zMtLMtQ+dyPR6vWexg5Efr75uQzulLUBjfV4ysHWXLI=;
 b=/0FvWqPNrFnVvgEwryZLXaamwpG38yrLu4Qie4Ux5eNj5z8zCxsJo8BFsvWf6INyW31eItzll
 jyRFhEZ4DfrCE7Lnvk3W36ChLSg6Ia9sphAiI9nIjeD6SMTLbxVZlRk
X-Developer-Key: i=daleyo@gmail.com; a=ed25519;
 pk=M4mvgx1TB2TniKaedTDsO3PbLKgFosJuegXRXPbn2Ds=

If the firmware reports a sustained frequency of 0, every OPP is marked
as turbo. With boost disabled, cpufreq then has no usable frequencies and
fails to create a policy for the domain.

The Surface Pro 11 (X1P64100) CPUCP firmware does this for the two
clusters that have a core fused off.

Treat 0 as "not provided" and don't mark any OPPs as turbo.

Fixes: a897575e79d7 ("firmware: arm_scmi: Add support for marking certain frequencies as turbo")
Cc: stable@vger.kernel.org
Tested-by: Haipeng Lin <jimmie.lin@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
From decompiling the CPUCP firmware: it reports as sustained the first
LUT entry rated for exactly the cluster's fused core count, or 0 if
there is none. On X1P64100, clusters 1 and 2 have 3 cores but only
4-core LUT entries, so they get 0. X1E80100 reports non-zero values and
is unaffected.
---
 drivers/firmware/arm_scmi/perf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 0116ffb2b279..d4394984a0f5 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -879,8 +879,13 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 		else
 			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
 
-		/* All OPPs above the sustained frequency are treated as turbo */
-		data.turbo = freq > dom->sustained_freq_khz * 1000UL;
+		/*
+		 * All OPPs above the sustained frequency are treated as turbo.
+		 * A sustained frequency of 0 means the firmware didn't provide
+		 * one, so don't mark anything as turbo in that case.
+		 */
+		data.turbo = dom->sustained_freq_khz &&
+			     freq > dom->sustained_freq_khz * 1000UL;
 
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261121-sp11-noturbo-becde22ce314

Best regards,
--  
Dale Whinham <daleyo@gmail.com>

