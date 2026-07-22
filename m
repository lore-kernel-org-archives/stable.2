Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562240F726
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718444; cv=none; b=OLFXFqod9NTs0hlONzAiHkJXaLrRHHFIp7N6Zc3lcxs89AE8SNYYfxJYktv9SWoAi5Ha4eT654TY3ArZmBDvXb65Y2x0ZqthGQ3kPxaRh3nUSocajwGi0RBvFqpHZIUFOWvm3G5mKVi+Vw8l29t5TNh80g3YhgTHnMXaxKqcJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718444; c=relaxed/simple;
	bh=Gvq8bn9U5dieapHENn6/tVPX84MtSWPT3qgQXTSmcc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHc0rBKcNu3hwEE2azVi/obzIuAUxbJHFPVrLhaLlQuZpAqJqheSJkxca4mWNxSj8k35dx+HMHQhn3AXu5pIf0oGMRMQc1UIt3gz4Pe67IoR5VfQ8GbPgmVDVUFitPmTi3dpPGJ6sxxz/OXZvWV8Y7mlQQ5zYTmfhlH6GxtIdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=nhul7KZ5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="nhul7KZ5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceb096e675so127238435ad.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784718441; x=1785323241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pn78C/RraBqASlFsZzfGipH4Pd/7ButyH44MMOGEmn8=;
        b=nhul7KZ5qD0HjlCk6J4jD9jUHvB5LRm5qIKfGa2iyt3dnJS4hHWlwHcQyqMc0o4Ds+
         hxr2Nyg8o6004vR3tGdZFJEOuq2A9HE9NdzkWg2KD4i8kjndLQ/vqqkD/oDLFT25gqfE
         vfQg4asLj3/S463ZVccc+dRF9/EXrKEwwhyQIlr5ZwRLtS8er5Ps3MEQZuVXiMCLChmF
         Lp4Z0SwpTNZUT9JD5LZL5khVzTQbEoJVHe8R6DtlQ/RCaS3/YtG3O1yOI+zyrbpKsLWZ
         3QZVQW2GP/z2BGxOAzXUcg39RCtlRPeGhP2A8RnSVzohQ0UcGTKlD7XKZPCO0GMF8YUX
         vEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718441; x=1785323241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pn78C/RraBqASlFsZzfGipH4Pd/7ButyH44MMOGEmn8=;
        b=mZx7AhKZH18399eZqrA95cNyO+2smCfBHhQuI9m4Nm8E59EhxmQPE2bAJoHbbDMSxp
         93an14BxCtjyDjPEzgeUjQHyiXmX1hn3MQaNiX9/KKUj9sOnNlkNzdJgfCMwH4JRmWI0
         N4TN215KQodNaQxMWzoeAbFYUIihavpShexlxXY0k2KmJ1HSCIXsMYjBFnKxhTGVfHBb
         6MKuYqLE+IIcDaOG1M267VTnp9aWrThfB52ala7vDme/8vq2n6SVMbvTCqIneu+ttUsJ
         Yeqr66LBo+TvkYTFoGX5EL9yZ2UlKesF/kH6BqM8MhZKm5RfR66XxYwkp3yq9qb3G7s3
         GzLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr6/lCmDJiUbnycJcjdonGGgqcLEiVQWHeNCiPqeCdwqOJKEsaXDPWREgmbqVTk80fgNvgaTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50CTn/bnNG1M+3zaQddCDaUfnLhAdQqLL+rZczEY5310VfHik
	OdcZPjGw8ncQFmegpNd/GxRVo4WCxKag2oOseIqble+On7+qrCvtuLVmKyhJwAJD5CM=
X-Gm-Gg: AR+sD13qyRIf7gD1P8qSIdwFJ8t9z0FhX9psB75V9pyZOZUS/i7/KsX4tjhZdjjwu5Y
	cGmBHOrDecqdWHpsSjFSym+Fk1L3wP5q80KALMm3qmecsPU4U6qf9hwIi85TFpqDc2GFeFu+C0x
	0e26sz7j7mvursafpqR4vOYPjmoO+kfsjOjAIIwSv/6nqFY3SMidY/eagieJFzYjNjrZOYh1p+x
	5CDnC0Wx1iJT2QcZCYFrnYAwcOfnnV3u+4a1ph4KKk912C09gNwt2y0bvbOQyDoPr/CKMDG5+MX
	HLouAZfx+iJMHevHCY597zB5HoKoI7QDwurarNS0vyXCoOGV2lQCRNwsA0VjqqqAYZcM2kL9sNt
	xiigQcMzX9FY0mQ2/mXUAEHccL0I9u3oKpoLxS5i1Kb0830MyEmQ1Ly/un7TRnAbHLg93FxJlGC
	t6cioIpCv5lo0l3jtaCWcWckQw7IFlRTHdeRkDwwucJeSj0WTuM/k3grbDw228D0M/Yutorj/yo
	lUv58JIhth7cvSOE9rtMgE1dbPB2Bbo
X-Received: by 2002:a05:6a21:b94:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3c3ad7d7fc8mr25322681637.21.1784718441385;
        Wed, 22 Jul 2026 04:07:21 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3147e07000fsm15952879eec.21.2026.07.22.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:07:20 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: arend.vanspriel@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
Date: Wed, 22 Jul 2026 16:37:12 +0530
Message-ID: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for buf is not freed in some of the error paths in
brcmf_sdio_read_control(). Fix that by adding vfree() calls.

Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control frame buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index b725c64e5b5c..0900211ba2fe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1792,6 +1792,7 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus, u8 *hdr, uint len, uint doff)
 		brcmf_err("%d-byte control read exceeds %d-byte buffer\n",
 			  rdlen, bus->sdiodev->bus_if->maxctl);
 		brcmf_sdio_rxfail(bus, false, false);
+		vfree(buf);
 		goto done;
 	}
 
@@ -1800,6 +1801,7 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus, u8 *hdr, uint len, uint doff)
 			  len, len - doff, bus->sdiodev->bus_if->maxctl);
 		bus->sdcnt.rx_toolong++;
 		brcmf_sdio_rxfail(bus, false, false);
+		vfree(buf);
 		goto done;
 	}
 
@@ -1813,6 +1815,7 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus, u8 *hdr, uint len, uint doff)
 			  rdlen, sdret);
 		bus->sdcnt.rxc_errors++;
 		brcmf_sdio_rxfail(bus, true, true);
+		vfree(buf);
 		goto done;
 	} else
 		memcpy(buf + BRCMF_FIRSTREAD, rbuf, rdlen);
-- 
2.43.0

