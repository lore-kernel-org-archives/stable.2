Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246395;
	b=x1Q9doLyyxo99r7fB7M/6oMJ1PcwwW8S9NIBi4yEnZPgRMhCNq2QsxDGSwkoFNiWE2bZ
	 DIu5yd/zIBd7rJvIt+h9aabJDMwl+CwR/am3XlXETWwdCMsijnQP4y1IvSOjI4Fv6pYvF
	 Q8COU3akHaYiNcPjN4rjRGJP6qYRkC0v7qjM4qsHlIjE5qx0mwMT4JCPHSgAnNcdl4JfW
	 /JNFrEhcrz2y/l6TXWT9qQ86HEPms1x0xZoYD4gotKs6KAloo2fg08gxuucF9M6tNdKjR
	 I9LfThMhWWRQaTijfiD1o2gLcK7utOee93mKs0IulcU6AqcLubgKgXZpXOwtwvEutNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YBrHrJ+Fi6ULgqrmNdXQFkJ1MFe995vz1lrt+TAu8xU=;
	b=ob0TCielvp9ZEEIYVWvuHMNVW+4kXHC9vi5MY2bi3VKeKJAKsCXDZqj1x7DekjReZ12G
	 i1CAXKmOoss4ub4ICvpuZxkXCde/4QJSx6ETa/lB59IdeXt10OvX5HlDzXbpemvVx3eCi
	 KBU0y2+nZLPxChOtoWTWUpyNOIV80nssgJJEeLF8mgOy4x6SY2g/MBj9A2Nx0UQShTxRe
	 h5Vl2khN5LJmCeORyoNHjzTU+TSUNpAjZLK4ibRiZ7nWYtDsESdYACF7sSRV0UHFOrDnv
	 GKJT7OlQH1rZrCa9KWFsQbdjdmWaaLQufTlZkXT2RFNAPYhl29TT3nJ+ftsyJWFz06g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1KOuyd3;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0C606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D0C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1KOuyd3
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed0f842b02so1330905ad.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795246395; x=1795851195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBrHrJ+Fi6ULgqrmNdXQFkJ1MFe995vz1lrt+TAu8xU=;
        b=g1KOuyd39DbO1oJZCtZQXHAn3r83eoHFvdLOFAI6r1gcMgxhNE2+lmbsNryPqUR5AW
         Kel2datY0J7UYUxZY6D4S6tgYPu6kSzulVufKRKEzqy7Tk/GmdNfulm7DdpnRd4QXKaY
         2sSmceBXbDZfpb0UXzrHiIzTPW7AfIyBRpeFN0EBAfM1Ibu3dkiXiPZprw4HeTNOzZUl
         GgBBCQMlbL4QE75HrX4LOp5N+YSwOlQcHm1pVcyidVVbBb/E2QLFlr8m6asAVNnJ4rA+
         BmnzbmNp9JuNHsHAixgL5JBO/4HvBljTLUIOZDagJBcDJAz9UHhz75/L6ZBBVaXg546a
         x0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795246395; x=1795851195;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBrHrJ+Fi6ULgqrmNdXQFkJ1MFe995vz1lrt+TAu8xU=;
        b=ZayRWj3PQOsuQYx/8o8lW1ahxiHJzHylF2CyyCSJU3hIDgA429xb40v2SCVX71ON32
         OId2RK3SkZY8Z4Qud+TMPI0UxQIg6XgiBMu8Ls40qWRKmoy2xo/LHSGvBbV5A6oqd6Iv
         baXskmh/ibeX+utsuhrA5K8Kx4BPsP4qGJWma0PdmaX2Y9No1RUlP98ZLFX86OOIgEHy
         Cs+9Vgeo/2dYOxExTP6dv3ccBetB3aIKK08Rcs1biKBpO32fCC7EcZMXaAgyb1HhOS5e
         Qo1CkeaqyooOYHWbX3vyZ+gb2c8CuHtjIo80jhDBtOQzKVmsEtuWKjeFREPY9tib5cyb
         lLcA==
X-Forwarded-Encrypted: i=1; AL+hErEQVg9Da8AOmDfNU9lW8l5MXoZvKt5khBTZENMyLlN8grRp7+XMiUE+rP5c7XPwYII/6KIsLSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m099rzdPAxCUzC5NJYIt9DDEVifbs1lt/NrPvUkCQlSxdvneR
	OtgvtgN/HOnQlmxNQbxspUdY2S+gPMW77ggtF7FLsLlukuLO9y79Dd6J
X-Gm-Gg: AZFdTZcgSqlb6azZAax7I42OeHeCtwqkrgL8VJ8I77NSrUB4mCFMkn03G/MxLTwFIMS
	7hO08oWPm3E4qb3QZEAJfnQpw4Sufe/78Z8sCj4nzVAeqqjv5lWCh65wjFvUZS3fs/HnsyfAxGW
	n4mSrnWGUBQr1W+nV8dsyAwyaQriDv0s2uBD+jBxsD6Km5bYPqYsoPrCXrLloPmpF+JZK0nBvv9
	T1Slvd0YGy1NaG5l771Fd0DPSPqibT4JBQv6/I5c05YogvotJ2K2Csf5EsdZi99djuDZvrZhf1f
	WNr9pzcTiyKRcyY562fP1kQeRlEDk6p/G8Adt0QGO+/XMruSU8TXJGFcyasZkhPB03waZGJMfMV
	JoMypy0v5wnXfzvnBQnunyN9rdIw+NPf78dWrDXgtIAFD+uJ+/B+eFXHEDO39dASq5O3oUs2Am0
	xb2oAa5JYa+Kor34UH+1Ne0EjjtRIKQLLIvQXUZzRiZqMHhhd95bnSuz/+oVs+VCfgRDIEC2WRg
	2NxJddvbyFPcroMIhTawOF7NU2BNXAWvPiuHNzZYUo20Llh2YjAOL4HzFCLono21QLst5KYCnVs
	gHpxlEcc4WQGVX1pYB+J1FnmcEy44w6zaChS3Tl9+bAy0k/SyXpTWA==
X-Received: by 2002:a17:90b:57c6:b0:3b4:e3e:642 with SMTP id 98e67ed59e1d1-3b41c579226mr8216561a91.0.1795246394913;
        Fri, 20 Nov 2026 23:33:14 -0800 (PST)
Received: from [10.232.20.87] ([101.90.31.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm10344021a91.16.2026.11.20.23.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:33:14 -0800 (PST)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bin Liu <b-liu@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: musb: fix double put of gadget device on setup failure
Date: Sat, 21 Nov 2026 15:33:10 +0800
Message-ID: <179524639094.16200.18023925953069130613@gmail.com>
In-Reply-To: <2026112011-dingy-onyx-4d4e@gregkh>
References: <179250629747.20696.17364135141613638741@gmail.com> <179419596286.2244.11782596409403661076@gmail.com> <2026112011-dingy-onyx-4d4e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

musb_gadget_setup() calls usb_add_gadget_udc() and, when that fails,
calls device_unregister(&musb->g.dev).  But usb_add_gadget_udc() already
releases the gadget on failure: usb_add_gadget_udc_release() calls
usb_put_gadget(), i.e. put_device(&gadget->dev), in its error path.

The device model documents the same rule in the kerneldoc of
device_register() (drivers/base/core.c):

    NOTE: _Never_ directly free @dev after calling this function, even
    if it returned an error! Always use put_device() to give up the
    reference initialized in this function instead.

The extra device_unregister() therefore runs device_del() on a device
that was never added (or was already deleted) and drops the reference a
second time, causing a refcount underflow.

Drop the redundant cleanup and just return the error; the UDC core has
already released the gadget.

This issue was found by manual code inspection.

Fixes: 3301c215a2bb ("USB: UDC: Expand device model API interface")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---

Resending in full because the original submission fell out of the queue
during the merge window.  No changes from v1; Sashiko reviewed it and
reported no issues.

Link: https://lore.kernel.org/linux-usb/179250629747.20696.17364135141613638741@gmail.com/

 drivers/usb/musb/musb_gadget.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 016d3f3fc1e0..4bc4270088bc 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1794,13 +1794,9 @@ int musb_gadget_setup(struct musb *musb)
 
 	status = usb_add_gadget_udc(musb->controller, &musb->g);
 	if (status)
-		goto err;
+		return status;
 
 	return 0;
-err:
-	musb->g.dev.parent = NULL;
-	device_unregister(&musb->g.dev);
-	return status;
 }
 
 void musb_gadget_cleanup(struct musb *musb)
-- 
2.54.0.windows.1

