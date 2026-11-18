Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996961;
	b=oDykd3lfFn9vzQaa87TcbzDHEMjlWf7DUX+6SEUciu28xRtmCAzi3LT/4iw+A5khMBB7
	 1stHlddGYnGoyaIQzUGU2XKKWi4bd1J6sCSO1QjSDIoT6x2EfEUnEPlaVr6k02XzL4OIg
	 MQrbJVr7hi0JD1xW7hAGgHcDaRrmuv0v76JIFwrwoRnhsn4ePiXvoeY0+w/EOd8dWHAzJ
	 BTHh22TPweZuaLfz1TFa5UV9a+MCQ+le1wSL0ge+1NGQeeHTdOtpVUBndDI0liXoA7ZOH
	 nkCDwmGCgmTbltdbcukIqcYTzFC5HMG5mX110brG2PH9kBkU4rfcqvT4+TVYdOtxSGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fv3I+O9hDJ9zZ0P3XgSXSVC2IJuf4Bq4HQpsFJCZlL8=;
	b=zeLOa8Q9XjtJM/z2a7n+BtIAMvvXqv19/KGBhWhs3CE6GNmKXMo6IwrSvZ+g4QWFXrYP
	 KktmbKymle0tmOmwRTTRg4IsC9UYHVH+bEEASF0saqcbv9fnnxQAyn7oci0+kmChKMYk4
	 Ypzwe/E8lVOwl7ZkjrKYxoErRnnSUeC+8ff9YKb/PU5OngAZiaRh5Q7o8t6SI7s/AvPXC
	 872qxtLf4+JyovUGb31ifMdYENhJ2O1j/auGghEww1yY6KNU/cgahISG3QWhdd6GMifOs
	 eaV++UaOxuVsGi/G1U88/M2tdLWmUhU+O3QjAu4VZrW5l3RevVKYRingeLjuyXWDGTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wqGRCHK9;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C1606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wqGRCHK9
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed408b0d9dso3604065ad.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996960; x=1795601760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fv3I+O9hDJ9zZ0P3XgSXSVC2IJuf4Bq4HQpsFJCZlL8=;
        b=wqGRCHK9piPFaNciF9nHvzxzSkoIZ+XlCyaF5JkjzD2zwmNx3YrOXT/2p4AZFebyy8
         w+sDqVhPpkCxCClH7igBbWOOBEC4un2LVJUkTZkMbkoXsLF77xYCVMcOeY6LpwgqzjrH
         eJPqBxDJCNEau1rGTi7d11fuotL5vDzXqXCszdMJhchDjhIbDRBHYsNOy3uR4ShAmfV9
         GjMPhrATDXfSgbpW/ByRddGhcZGK1NT5Dtq/2LGpajmSkvIR4MIs9sJ9fMRiWaqwkigz
         vn+1ApZPhBY7VuW2aT9NnNjq97v/oOkrV4bp1UFxUjN9vrnYBfLaKFJd/GIyFRQZ6P3o
         FGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996960; x=1795601760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fv3I+O9hDJ9zZ0P3XgSXSVC2IJuf4Bq4HQpsFJCZlL8=;
        b=UtAhKr78wzp+M9f6EKMkHOZpH7WVBL67SVhNoZA6gMhFJ7rYddfUEkdcOiNngrSWIA
         OkR0hp8B7m9Rf0kMrRycTpojOg2zTxqqRqyPOG1kB4qWnCM4Cje/LU0IiQWDKFX/xTrU
         8il7RFBZxxKFoh4oyvD2JueTST3+zGU+vKKDjYkOUMRS8I/liT2Ppj6/W50ePTS6UOS2
         D51EUQGqTnwGu3jDyg2BbeQad71h5JuA8seKdBRcmUlywS7i3TWcT9r2IB+fSBnwmGGG
         Tb/q2fX9CHlrNsyzt9Ouqve13Y7lY9JcXDOueGhqeFRZ0d4HZXu9HJHPumqjS6BsINag
         xPeg==
X-Forwarded-Encrypted: i=1; AL+hErHmrEgobf13uY76pI7zXcYXxrYbK+Q5Mloqqre+9EFm9FdJpTEyhku3p4yXBuV9iWKbNRKCQXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9JMZ7cb8sGFSECCbKnFmfhS/Kp+xogmBlCH/Vf5qn2n4+jsrD
	KeH0Pg7deNljCQmOCwxpK9AxEoehR6QjW9MwjjUEgje08Ok0Y0toSHTp
X-Gm-Gg: AZFdTZfIiOcM8ghV7slw5VVV+hbFQHNTceML7kc5AXM0G96hOf+lWEG66StltlIB6WG
	fIjgChfUCJe7zdV1EQfEHMWlXFYxfMQN66yghBVMOZ1Jf/xtqLnyC3VqgIwmNHBW1gv5Atv8JOx
	u5T8Q4Wf7ywZ+A/NrjU/WWfZEAr2ogbcQ3qY3o+H9c3CskidBBOlz4CIsc/Z8C3EUWHCN1F6zo5
	iA8lZOzE+be5PWKQ5E8DC7fPPT1gLCuqmUR7tRG3D6iBqOz12UXL4iWy5XUBy8cCropauPUcpNy
	corGu2slCRgUNrGANDqsubzRkWeGCPtSHZD9V2b6ef8FFf1mGQ3FkUyZj6v/PMFY7sc+aDHCnjx
	176XMeVbkehw+izuvz6dxaWACBN82cLttST3DhA92/m0gZFXj+vFcaAkgJ3E+I9ZftF4WgumJPC
	xzEd1o38n96FTih91oriCL7blvq9Uq/Z49os2F119fsCIecQBGkSMc3iF1Envnr/+vE6jBMUkUB
	QJM96GClbazG08KUJCIiqG8tleiZXNEShG837FImw4l5gb5G3CAN599TXipfaGQtMYBc7yceXEd
	Ej9Ee8PQfG38avny+1P/m5mEbbCQXKwBHG1TLKztPkC7hrpnhXw/Kw==
X-Received: by 2002:a17:903:234c:b0:2ef:e28e:8f17 with SMTP id d9443c01a7336-2eff754459dmr21917045ad.49.1794996959717;
        Wed, 18 Nov 2026 02:15:59 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff623c968sm10954285ad.55.2026.11.18.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:15:59 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: wilco_ec: Reject out-of-bounds property length
Date: Wed, 18 Nov 2026 18:15:55 +0800
Message-Id: <20261118101555.3467162-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

wilco_ec_get_property() copies rs.length bytes from rs.data into
prop_msg->data without checking rs.length, which comes from the EC.
Both buffers hold WILCO_EC_PROPERTY_MAX_SIZE (4) bytes, so a larger
length reads past rs on the stack and writes past the caller's message.

Return -EBADMSG for such a length, as the file does for other bad
responses.

Found with a CodeQL-based static analysis tool that we are developing.
I used an LLM to help write this patch and a userspace harness. The
harness runs the unmodified properties.c against a model of the EC
under AddressSanitizer. It reports the copy for lengths 5 to 255, and
nothing with this patch. Not tested on hardware, only compile-tested
with W=1.

Fixes: 0c0b7ea23aed ("platform/chrome: wilco_ec: Add property helper library")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/platform/chrome/wilco_ec/properties.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
index 9951c8db04da065..4ca7e874804c28e 100644
--- a/drivers/platform/chrome/wilco_ec/properties.c
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -70,6 +70,8 @@ int wilco_ec_get_property(struct wilco_ec_device *ec,
 	ret = send_property_msg(ec, &rq, &rs);
 	if (ret < 0)
 		return ret;
+	if (rs.length > WILCO_EC_PROPERTY_MAX_SIZE)
+		return -EBADMSG;
 
 	prop_msg->length = rs.length;
 	memcpy(prop_msg->data, rs.data, rs.length);

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

