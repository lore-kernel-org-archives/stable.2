Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627504;
	b=d8OlZmRybCEYlz58ZsAoAEkHqNDr1sxtkY5OOJKAPOv3own/qDhQht/usEu9dTg9XD9g
	 DAUS8GwINNMn0Tbeo/YQynukryI2Xyj8HsP53GWUnCFvBJINrjbLMhhizS+rO2+Z7rJNv
	 ZrdXWxFE6NPQbkAzP7EzIB7ZHN3P6Rri9U2lvC4buSBMgxzRP+TSyBPhdmNWrmiegZwHs
	 UL6uhKntegWSS5SXd2m78MvLPXmaDXJfBftwYBOutY7rKyQx2puf/3caafLY4D6CKIimf
	 az1MLoosBwxszdcMmJRUd9x0lhppZ+H0wT2LUdn0bMQVngKZdOyV/BnWZpkx5YyewKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XApMTeRiMcqMGBClJsYA/h0r8RwI8hz2qrd5pPnw+Tw=;
	b=GTWdy4qd2gb9oHVqNDUvMHvgcozAPc4sgCL5ejqQnuoiP3lMfxg4V5YuW5DFkswVpU0w
	 pQihOaXCynfczeIBI76SZzwxfSM1zjcXnuez2GV0uKoSQDsqjl31HU2Fux5n1kpa9BHxo
	 gKQVdaOx8THFul55te6PtQoFeSrJk+gaPWeKiFvKbVquiuQZK22k5oaqSWzpuPI/GD5mR
	 kCn0gwTOrvvoY2N7v9TrdlH4P7YkfB4bRp8EJsDtoej7cOVtfLyaEUE3rsVgM4JUujASx
	 cnBfoQSSRnvMszPwEmHSOft7oR611q2zLDaH1SMKxukH4DROdDLr89Nn1OycxpNrBkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t1LXlA0n;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB4606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDB4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t1LXlA0n
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so1361159a91.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794627503; x=1795232303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XApMTeRiMcqMGBClJsYA/h0r8RwI8hz2qrd5pPnw+Tw=;
        b=t1LXlA0nPq5/PxDT+AAAb00hC5E8MFOJkTAG9lQtRUPtk9xI84h96Zhn5f/+xcMAVH
         yiQONaeSY4785hcIXl+AGRH7VfZ9G8RxyBbpyOvOKqcWasi0XXDOFGaWfqCR0qWoNT0J
         clZ9qa2mC0Sl8gfBmJwn92zskVSycSXiY0FaMwMwZJZPwM2hZAFeF/KndItNg8gW0GGe
         j/cp2M+ckZ29KhTdQlU5C5k02XXlVyEHGB554WXYnP5Oh345WkV1ib86eNp7GVjwJhQo
         4RihW2Wk6S4IgO1am1+nxVcD9B/XPX6z6I3bikk6GxU+PfKS5nqavRDUVXlOEaTCghD6
         u/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627503; x=1795232303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XApMTeRiMcqMGBClJsYA/h0r8RwI8hz2qrd5pPnw+Tw=;
        b=rGL2qdo0FMeP12KVO+8g7ughE4TQlb6p0TSLvumQSnBxffb0ItHZUGFXEJtiXHNwCN
         WzBjbtSswnmG1VnPkausK8Ukfhye3xRTm4fRNziAgUyexjeiywROfjHpztnb8R0m4+G2
         bK7UT9CWJ8QXdbmopITY7iwmOyzkkbL9TldoHbJGPri4L3oXkQEPyLgT/hN32a5ePalT
         95Mn1GHTMp+6kMgKPOt38fPBfM8hIEkVyH3fnqCf5BiklA9t858Q6nw9FRktXzSAp1he
         za/ilYOL+TY2oURLpNW9pXZxYjPSy0Mx4XTSKMra9ew3yNEoOutC+w6PiorNL/Eo119E
         0JWg==
X-Forwarded-Encrypted: i=1; AL+hErFwKnMfCvh7uWFMFRl522mUcwgjXq0brikgckIpmWxwY2DigveE7Q7w+lS743z7Js5KxZUpfh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/elUewffo/Uf+zns+IXbPy1Hiv5k2sgXLepYCffyWsrhRV2SIo
	OWLKcBLijDYNLeqj3k5ZhzMUtWHxOftnjgM0qPhutEac0D6UviPbF6ItYVydo7TfuH0=
X-Gm-Gg: AYBFou29R7rtOWXhhXk+dcSwVfNX/fI/KSSX998cDnT3GD+21DyCQD++fP9dSK7Ed/5
	Y30w0UAoC9EeUtsrCA6E4WUwbDQYwHLtPKfAS223M7pywiLdaxIAEJotSe7lofQ7lNYrqXgAHbB
	RoZ/j/ci3U/fc3yzgagbiIFGUsurFvdfJPDvgVw6Pv3ZeKoos6e9Noyns4GNuRXcX48pSAoByKy
	zWz85b9v9mKkJXlS7WXjrn+l+C60inyUaAVnoIkxmJJOckNyIF8bFYGpHEtKqD02nwpsNl1/1Yp
	eTTct8mF5tiJ8nvbxvmtRE0X3zuEDGe8CHZbe0MrZxb4WNWX7TnrQA7hjJDCotED0aKjc5F0f/s
	z918B1V751VmiM0zF5clX4jl413RNsp2YzMVXghHQj2ar8cvjdtKUQacK0szd06amCEfUmBLDt6
	I6EsElC+3JaZSnMVefxjqPvRABXS5f8EpHqDT+zGS5iQJNmQPCxAypCu/AtDiNHmmnCyTFuFLaj
	1SRmiGs4FfKE39Xb6vZ9KEtbb1FwU8gx1W/awzsD1urBbeiqctUkjHgpJSULcnxcp9crA5qBbQ1
	JPSHYC8o8UxfVRp4U6Tpy3c4/mLMxKyeMsT++s/um80VAP8l3ow3HMnfmxAyS7Dv8v+BJSFFvms
	XZWTa8ui6ZK05w8Nj/2O1+qrHZbg9sNPH+b7obA==
X-Received: by 2002:a17:90b:28c7:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3b1b0b63d26mr3878240a91.46.1794627502924;
        Fri, 13 Nov 2026 19:38:22 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:f861:b117:6318:c068])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3a21769sm3412380a91.4.2026.11.13.19.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:38:22 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	erich@areca.com.tw,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v4 0/4] scsi: arcmsr: bound adapter-supplied completion indices and message lengths
Date: Sat, 14 Nov 2026 12:38:06 +0900
Message-ID: <20261114033810.549787-1-yhlee@isslab.korea.ac.kr>
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

arcmsr uses three values from the DMA area the adapter writes - a
completion slot number, a type B ring index and a message length - as
subscripts or copy lengths unchecked.  Patches 1-3 clamp the length,
reject an unissued slot and wrap the index, each reproduced on KASAN.

Patch 4 is not about an adapter-supplied value.  Type B is the only type
whose completion ring is consumed with no lock: D, E and F take
acb->doneq_lock on the interrupt and the polling side, and patch 4 makes
B match them.  arcmsr_abort() masks the outbound interrupts but never
waits for a running handler, so a working adapter is enough.

Not addressed.  flag_ccb is unchecked but is the CDB address the driver
posted echoed back, so only a fabricating adapter leaves the pool.  The
data_len double fetch needs the firmware to change the field between the
two reads, which patch 1 bounds anyway.  Type F polling not restoring
cmdSMID is also handled by the dedicated polling function in
https://lore.kernel.org/all/91fa9048-ae23-4813-a8fe-bd64d5b374d5@areca.com.tw/
so I am not sending it; I will rebase whichever lands second.

v4:
- Add patch 4, serialising the type B completion ring with doneq_lock,
  as raised in review of v2 3/3:
  https://lore.kernel.org/all/sashiko-outbox-167892@kernel.org/
- Patches 1-3 unchanged.

Best regards,
Yehyeong Lee

Yehyeong Lee (4):
  scsi: arcmsr: bound the firmware-supplied message length
  scsi: arcmsr: check the completion index the adapter reports
  scsi: arcmsr: wrap the type B completion index before using it
  scsi: arcmsr: serialise the type B completion ring

 drivers/scsi/arcmsr/arcmsr_hba.c | 45 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)


base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

