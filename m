Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115410;
	b=XzrYbGvpkbUUDtAyG3EcZaCg7StylrvT/A33W39qvLCaXcbM3zCY6n19Y7UYs37/JbID
	 DzCxeux3OVnV93sVNZro/PO38QiPj1aDOx52fAB6Xidy4ziWWNKF7vNvVdDVYMyEtbrjc
	 lGou0Ofapv9RaDuKKxo4L1movBj03XHXrx3jvoKQNSK+lOwnjdnsTnRbjX4dTeDN1a0dv
	 XrzGcfqYq7cKGimQlUCVebLa4iVR8nfnRnMNTOB9IpKhyJXUSJUYtQXqbBdGAjnWR9nAg
	 K0gHPfWuCVvwPXO2C15s8d2WvFCryu9XkcFyr5ODtuTfNVtxnZTf5xbQPjRxsEFlWkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OWfWBSws9gh+iPoR7/7oxTfW1366liBJpIftUQNS3TI=;
	b=o5oUshSotd5CoOVTDjdsxszFPQ7V+kQSvJh4OsplbZvaEjKMIrA53Am4KMcTjQhqq+Rs
	 iJQjr9yLbPO472z2zQXNOY0uF25kGFOR70yakLDLZtXJTAgBJqWrWJWQVpmCNKcsjE+LH
	 APcGGfjpPQGmO7hVKYtY4QebSdU3PYZKwYdcYs+cfr2A78fvp2NNAk7634eNax2/WbpKQ
	 sWKNHChf7gdMIozrLeafHTMdXJ6lQkjVCFaGqGo5KGf2vrbCckFsaRK0EigZXgZbOa3O0
	 oZ7ElNvaiabeOLL4NLpk7VI10jQ11ZkM2SFrmJaZc1eZ3Zz8eS6VqQHzlBuSqwq/8jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/nsiqsd";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBB606A334
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 19:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBBB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/nsiqsd
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so144685a91.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115408; x=1795720208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWfWBSws9gh+iPoR7/7oxTfW1366liBJpIftUQNS3TI=;
        b=g/nsiqsdt4pH/tzBHE10yBClAItvjaLryQElgWH80JZmkqIvvDL1r10plqAcCXico5
         mOJMbZBqyrQIX5gIDYrNv3ltUPLHCFFKjjq0z7n07DkPSGNT8OSpbx8+8wPGW4mHgpkb
         MxZyFbSHhym0sV7UIudMlWJok1NPjVZIoiWwSNko3m2AMEM1Rufx2lsk/oT+AGXVpkfL
         gv1MZjw9rMmvJSKLSBe4JSYcx+OGP6hzJ20yKs1jfTaQu5LwHJNcluI/H1dTb7cNvsP6
         szl7egJk/kq7eofTpBMsq3hufiD2K1CtZcF+FhKJ/vjfxmADLHMVoF7RaMDFWPQvxtMj
         9bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115408; x=1795720208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWfWBSws9gh+iPoR7/7oxTfW1366liBJpIftUQNS3TI=;
        b=gPlvaF2JktamT8QIxkyWvBS1pZIT2zqrW1NIDUJZP7Y+OkC45QPfpKiyQTmI2HOb0d
         ecPLBsD138JoOiTz80gMYgu88hIGpHxA39I+lJ2Ya1LMOs1XTwJ/hh47js3IbmTLuOUF
         EofB4rlW4Ons8MU+Yu9NYiAahK3Mp95E3egiyXNy3kfcFYRSK2kztOVu3SVpK2bNYKiC
         h1bAcm85eS8qv/3+TG9f5FvE8bnMm49nCoh7GOjmbqObUoAGbF9XIw3EHWlIZmgwl7z7
         ikOmJnUH+QSDPrpShQEhiS6fISkMEIJj0MZVkOQMifsKw4cg5vJb4b+zHgt2Zn40LIW+
         2XXA==
X-Forwarded-Encrypted: i=1; AL+hErFeQBQheKF/VSmFJwYv2KBWspbGC5ysrl4q2ttZLjvS/jOxImW74LWo1dMELKKLRMtZY6DdOpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kyxSDWXHUiVm7iPvCyS3PKyqA0RdRSRUE5E/nzC4oRAGBPZaQ
	OihfCMdXOK/9CUwgzFPYmt6nNZP1EDLk4eGDHJl3dbERUXnjzuEjpyGURNvTBmLZCC29pg==
X-Gm-Gg: AZFdTZfODQwUVu5ID1nl1Bio2r/hCoyZ05OTTrcBwcWJdldXQbc8mFQNBsdx8/r9tsN
	IbowTTEFTrfklAaJExqlhjrlGwAZuay0wozYow73iev6/7rghMu5+D0rkdCTv02VUIKlvUgNtdf
	Ko5RQgph5+G+wAQQzLoUkSVleDMl1LoynFJmSRhxRxH02FuR3guHwsn6NT3pe8VVJWvNMkBQNT0
	tXqVZEqGONQLwgOZ7Yo8s4g8rKEqRMgleFWux6gqmlmTtWkYrtbDGN8QpjhxMntpW1LLnOpm+ff
	ZAzOliBRQqkM1z98w2L0IvFZ7/K6K1Hi5r34ThsM1bbps89mUF3Tl3OzK8oEbFX79faBHiwUywL
	Z/B9Mw4/MlGEnEh/Ba5//GEnKHCdmfhcSS2Gf7Blxw0KCbKQj9qVRwzRpc0KT1084CNiBZQDPO1
	zOx42KOBvT7yFm3cQKN/g1aANhN8QkWk3dxbxDxVV59Iz6IxUUhNOQX35/tVRR5uj84ylBinhNv
	biLHVfMKxGD/P8+cnGN7is5UVxHQc4xopdG7mITgtVqQ+Zsx6fAEXyQWnJwAJsAzM+DGhCp+V9H
	igsrFXpMqwPpWqTHy01T9pgqSbqTz+6bqLHb22PWeVjQXjsJv63p/GVqZCAHj6gd+5GzABtmmN3
	z0C2BrMdcXlOh4V41w2KqaDdram/3fTEe6QQuT3H5sInFUZ37x9Ong/fXG3wmRNSH109p3L5Iv7
	gGvEXynSkVSmTo6/ssbtYaeuL4z90o8mB7MfapIKsyml3aE35JfRjOeG86Ir2fgr1wH5k3R2NtT
	uoK9HitwNlkY5U=
X-Received: by 2002:a17:90b:2f8f:b0:3b3:bd07:665b with SMTP id 98e67ed59e1d1-3b41c9325b1mr290487a91.40.1795115408162;
        Thu, 19 Nov 2026 11:10:08 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm3678174a91.6.2026.11.19.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:10:07 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] spi: spi-ti-qspi: finalize message on transfer error
Date: Thu, 19 Nov 2026 19:10:00 +0000
Message-ID: <20261119191001.878454-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119191001.878454-1-jctchan@gmail.com>
References: <20261119191001.878454-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

When ti_qspi_start_transfer_one() hits an error in qspi_transfer_msg(),
such as a transfer timeout (-ETIMEDOUT), it unlocks qspi->list_lock and
returns -EINVAL directly without writing QSPI_INVAL to QSPI_SPI_CMD_REG,
setting m->status, or calling spi_finalize_current_message(host).
Because the message is never finalized, spi_sync() or the spi_async()
callback waits forever on queued transfers. If spi_sync() took the
no-queue path, it returns -EINPROGRESS instead of the error, and the
message's optimize state is never released. The frame is also left
open, because the QSPI_INVAL write that ends it is skipped.

Set status to the transfer error and leave the transfer loop, so the
error goes through the existing tail: unlock list_lock, write
QSPI_INVAL, set m->status, and finalize the message. This fixes both
paths, and the caller now gets the error from qspi_transfer_msg()
instead of -EINVAL or -EINPROGRESS.

Tested at runtime with KUnit (spi_ti_qspi, ti_qspi_test, added later in
this series) by injecting a QSPI_SPI_STATUS_REG WC poll timeout
(-ETIMEDOUT) via logic_iomem emulated MMIO on ARCH=um.

Developed with help from the Claude and Gemini AI assistants.

Fixes: 505a14954e2d ("spi/qspi: Add qspi flash controller")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v3: Rebased on spi/for-7.5. Fixed the commit message: the old code returns -EINVAL, not ret.

 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 7e796aafd2bb..9e270c30d0d2 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -718,8 +718,8 @@ static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
-			mutex_unlock(&qspi->list_lock);
-			return -EINVAL;
+			status = ret;
+			break;
 		}
 
 		m->actual_length += transfer_len_words * wlen;
-- 
2.56.0.679.gc527c65306-goog

