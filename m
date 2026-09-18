Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E221A3AB0;
	Fri, 18 Sep 2026 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690060; cv=none; b=nXUWokoHKiDUHLcGKwWfgL7Z8CHMNXumbx9q0yEVtv1QoIass7z5siVX08/NgVniKCtLl0ta2TPLz2PpKXZmcXSOIOxKPRvkU5Y0D1PcFIH+fbvo8LmM4/QtBhVwmpZ6JFA+5aevOZBXnFOGFDwnjTtobvG7DjKOoUMDCRVU72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690060; c=relaxed/simple;
	bh=Y9bpKvVBXYWIaakR8aShecfuwmrw2o9u8ku+AHFVZpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBgznkppBQix+vBQIm57xZEtSbgvPHttboY8qBtF2rrqjDfd5I/VKMYXmurjyvgsVw4Eu+ON7xqivbEEl0fMSL/NF9ipLohkMVSZTWWaIOdLXEszei1TuXhYD4eXBKbzT9sG2FarOAVwhTnj0lz30zADiuQJU2Z/uq0c4nRkI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=J2mhtlci; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="J2mhtlci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789690058; x=1821226058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hcr0t73GjYbm1RcbpbTwDtkVhE7rUGbFIgLau1aa8lU=;
  b=J2mhtlcibt4q1TV6kE01sFTmGR7+Ju5UWaWGn5jNedB9Ox5ml+WpDgfq
   Hpvd7l9SLGvvu/ECCqO7GhoJMgCMVtrO2OWn5QYlcPTOZer7RIbrpP4hX
   C+ka292ZCKB4ufEXUIMowTrZiaF5qtEy/5oWi0069iHBtE9Xt3pRniEsB
   A5uFfwebRqYah6MsTD1F9J/JTrspLLE1bSqVv21LIv2va5UpQs9DvWmK5
   rb3UDCXk/cYIs3Hgg+1jglcL1ubect5pSity/0NCgzEK6xHWKJcgJVh5I
   oGKeFl591A6LSigHSmZbTHh22Vd6HsqOob0AAqdLWoy/nmiqJAC63jsaD
   w==;
X-CSE-ConnectionGUID: H2590wdlTS+x2z5PaGJSPg==
X-CSE-MsgGUID: OXytW5IaR7SXs/ozLEGu+w==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28977043"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:07:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:2721]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.195:2525] with esmtp (Farcaster)
 id 46005627-63ec-4280-95cc-7dcd1c04f594; Fri, 18 Sep 2026 00:07:35 +0000 (UTC)
X-Farcaster-Flow-ID: 46005627-63ec-4280-95cc-7dcd1c04f594
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Fri, 18 Sep 2026 00:07:35 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Fri, 18 Sep 2026 00:07:34 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	<linux-integrity@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Stefan Berger <stefanb@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<nh-open-source@amazon.com>, <graf@amazon.de>, <gunnarku@amazon.com>
Subject: [PATCH] tpm: Disable TPM on null key name mismatch
Date: Fri, 18 Sep 2026 00:07:31 +0000
Message-ID: <20260918000731.48657-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The null key name check exists to protect against TPM reset attacks, so
a mismatch should stop the device from serving further requests.
Currently it does not disable the chip when it finds a mismatch.

The mismatch is logged:

    tpm tpm0: null key integrity check failed

but the chip keeps serving commands:

    / # tpm2_getcap -c properties-fixed
    TPM_PT_FAMILY_INDICATOR:
      as UINT32:                0x08322e3000
      as string:                "2.0"
    ...

tpm2_load_null() where the null key name check is run sets the chip as
disabled only if the rc is non zero. When the mismatch is seen, rc is
zero at that point and it returns success. The other issue is that the
caller expects the null key handle to be populated when the function
returns 0 which it does here without writing the handle and proceeds
assuming the null key handle is valid.

During the test, I noticed that tpm2_start_auth_session() uses the
uninitialized stack value as the key handle since tpm2_load_null()
returns 0 despite the integrity failure and proceeds with
TPM2_CC_START_AUTH_SESS with this value as salt key handle.

Set rc to -ENODEV on the mismatch. The error path then disables the chip
and returns the correct code to the caller.

Tested in QEMU with swtpm and CONFIG_TCG_TPM2_HMAC=y by making
TPM2_CC_CONTEXT_LOAD fail with TPM2_RC_INTEGRITY and changing the name
of the re-created null key. The chip is now disabled on the mismatch.

Fixes: cc7d8594342a ("tpm: Rollback tpm2_load_null()")
Fixes: 423893fcbe7e ("tpm: Disable TPM on tpm2_create_primary() failure")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm2-sessions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index cf8f1fd6790b..ca1e2bf424e1 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -975,6 +975,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 	/* Deduce from the name change TPM interference: */
 	dev_err(&chip->dev, "null key integrity check failed\n");
 	tpm2_flush_context(chip, tmp_null_key);
+	rc = -ENODEV;
 
 err:
 	if (rc) {

base-commit: b5f1b25b21f56c9fff87ad0235791883d1bf01a9
-- 
2.47.3

