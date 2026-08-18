Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639C48424C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080314; cv=none; b=EdXp/xcqg2s+I3lpeEZ4te00SXvd4Nxjq/zxrTyAHnux2jjMOu5JeAJsgLMF3Lq22N1CLByploIRnmSMV7/jGAHPiv52nQhxKiXBjIjI6JtlAp4juxOReMvpYrBjIqeq4NW3kP8qBBi/KaR/foSuvnzdQLJDv6WjNHAXHnEiT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080314; c=relaxed/simple;
	bh=9Q5eGR71QZ3FJ3qEs4Sx5aEi6jeXzBGzd9U+NtEODO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqwUAupNndIYKLdkTxgVwGMWLKGblS1urgQsYe0u6072dCRYWkEG/dENYExhWfr5KBbSmgkK0c84AEq0Kh8nnYqdr9upzeG4f++b3UcOoRKN91VtKBr+uglmIk7pVtn+D0e1IeqeWZDF5+kTa+7J98IUswQciDgHyKS4QEidcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kal4Nwrj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kal4Nwrj"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso333353a12.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080310; x=1787685110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73lLASQPtBYGFw7DMYZ0GmbUquwvaiOv1unAL4Q7bq8=;
        b=kal4NwrjvV58EH2gWR+tjOeU5UG5eOg4VwBd/JqPCE+wPsYjCujvFCLA/7uhnEvMjO
         JsrluKJ8wdCSO8TWpqqt1fkUCylZca2sAcGAkbgosioXd0T3Tf9aFKhujD1n69EUdgat
         RKLaa5hvaZHqWXC75bdg6igySZCcugKYyKjo7FdznxCG+HzIKIozFXGxuwKvBEauO0eQ
         wvGhQuCL+FnoWuVTOOXbxPgzd/I0hzWt3b1f3Ha9RTxMo5EJim9IxhUKu8cClG8k5IYT
         KFtjwvz6P3IRvb5/V/rbLd3dm9CSxK1ttHQUPSgjXRu/q04dmP5rjeDEYzekHCNSCaC9
         uRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080310; x=1787685110;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73lLASQPtBYGFw7DMYZ0GmbUquwvaiOv1unAL4Q7bq8=;
        b=OjKLqXhRcKDRPS/XMoZMn49ycfbtZ8waTW/ubDyx+Q9d4TJfe4I12JyMRXCLkJc6qi
         TA1dvTqcEpUug215/K/5ve7vXfib4zVGBeBISXTj+J52mpw3LZisxAyiDEhVnwEkwrHZ
         4QBbLleqZwgM9ZxiXLmP71mQyQqsCH26gedjWrxnbTT7UGhLD+wGOnAXcwyIcGgPrLsj
         bKA+1NpWfh6rFP5Cpd+HOjf22+1ylDr30YtHRZ4xcn0xVaJvoJN3/G9LRXsCdCHZRN4u
         efDYwIFPGN9HgFwdgRyKdG3/ARPS7jfPWEZTOD2DH8ajJYSZIiQM2DO/3sxfGfZuYgam
         cBpw==
X-Forwarded-Encrypted: i=1; AHgh+RpWs4Uut+HqxSr/IhcLh86F3jVhgeURADHKFjvOEgTgzvJQMnHuSKJAtB6JcURo2+nWGrAzxfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwilrzWbE8SSHifXoQnn+b9vGCYJwmSdpbEkjxXsXSZoaZyI6Gr
	sQ8FmCKDr8eUV1RAg45nH3VtuVf1FxKGfYHFuUcibz1DsJel0LG+cFfa
X-Gm-Gg: AR+sD131QOFJ0ZkqTv5kaIurlofyKyTczZObZ02rCIlfTHBQB69yy0vFdnZqeMFonh0
	k8bu1fNrCuif4z3gEnoc7mS4XokNVZNWLWdPBDClHfdU3qPOFfoO/xITrNeO1e1pfIY0YHTvIMg
	YDgozXwidV9zd76noqEy3zlTQ9Aj4oih7sfboJ+2njQmxAJFnHyJBzjGb14pMqqveK46IEqm2jS
	63sB4ZF0m1TzrfSsiSklPFqMdOKTLIXpCQxUVSNfvnPb2lvkIB2iTpN6tiz+WKcKMvdOIan66n4
	o3IUe9F7kZhQevRpLZfQNibE/VmU1Aii9TdkbhQvFDXysKcZ7kHwdYt4VBfNHnQR++Cdmo5HhKY
	u4QbVr2/2bzNCiBv3DXuhqNArDt5EudouUOIkMzI0EU2Xfea77eiKVy8gQm6w/lfAsr4JFRe1JW
	UfNmP2TGQns8NV8JsL0Q72Fv27eqxl413kdD4kn3EPpJh44mCdU2X+rvZ67HTPpSf47A5YTX5TS
	osRMN6gg/AQjMATsFFtqw==
X-Received: by 2002:a17:907:94c7:b0:c21:f41:e192 with SMTP id a640c23a62f3a-c222a0ee20bmr31270166b.26.1787080310180;
        Tue, 18 Aug 2026 12:11:50 -0700 (PDT)
Received: from fedora ([2a00:7c80:0:3b5::11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8531694sm2291552a12.11.2026.08.18.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:11:49 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	Josh Snyder <josh@code406.com>
Subject: [PATCH v3 1/2] platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
Date: Wed, 19 Aug 2026 00:11:07 +0500
Message-ID: <20260818191120.38556-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818191120.38556-1-meatuni001@gmail.com>
References: <20260818191120.38556-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hp_calculate_security_buffer() special-cases an empty authentication
string and returns a fixed 4 bytes (sizeof(u16) * 2). But
hp_populate_security_buffer() does not special-case that same input:
for any authentication string that does not start with BEAM_PREFIX,
including the empty string, it always builds "UTF_PREFIX +
authentication" and converts the result to UTF-16, writing a 2-byte
length header plus 2 bytes per character of "<utf-16/>" (9 characters),
20 bytes total, regardless of how long "authentication" itself is.

The caller, hp_set_attribute(), sizes its kmalloc() buffer using
hp_calculate_security_buffer()'s return value, so for an empty
authentication token it allocates 4 bytes for the security area but
hp_populate_security_buffer() then writes 20 bytes into it, causing a
16-byte heap buffer overflow.

The authentication token used here is the current admin/setup
password, which is an empty string by default until one is
configured. Any write to a writable BIOS attribute while no admin
password has been set reaches this path.

Fix by removing the special-case early return for an empty string in
hp_calculate_security_buffer(). The generic calculation that follows
already accounts for the UTF_PREFIX correctly, which naturally yields
the same 20 bytes that hp_populate_security_buffer() writes for an empty
string, avoiding duplicate logic for special cases.

Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
Reported-by: Josh Snyder <josh@code406.com>
Closes: https://lore.kernel.org/platform-driver-x86/20260402-hp-bioscfg-overflow-v1-1-6985f8c9e67c@code406.com/
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v3:
  - Remove the special-case return entirely instead of adjusting its
    formula, avoiding code duplication as suggested by Ilpo Järvinen.
  - Credit Josh Snyder who previously noted this approach.

Changes in v2:
  - None for this patch; resubmitted as part of the v2 series.

Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.com [v1]
Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.com [v2]
---
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 4d94e48c1a4c..136585141e6e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -47,10 +47,6 @@ size_t hp_calculate_security_buffer(const char *authentication)
 	if (!authentication)
 		return sizeof(u16) * 2;
 
-	authlen = strlen(authentication);
-	if (!authlen)
-		return sizeof(u16) * 2;
-
 	authlen = strlen(authentication);
 	size = sizeof(u16) + authlen * sizeof(u16);
 	if (!strstarts(authentication, BEAM_PREFIX))
-- 
2.43.0
