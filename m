Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846368;
	b=n55VPCVwo26nPMLN+OcjkzC1dmr84yiSCOlX6NGf9arbAvB7RcNGL/Hs8wJTLZmkg6IK
	 Yo0b7BpxDRakzizI5mPEy7O/WVbjrCIFY4ZbUD5tEOvHku0RUocFx4KU0pcgGrhLOAfAR
	 0E28cUJCbTSxWG78jG0X8Bwy6Oe5uJSjtfoxBpF0Au93S93tffWnMHqcwzdK55aUw8u2+
	 BpLDegkdujBAgIqCge/ZXBvUPEBmLoYI0qLQHqB+HBE5AvvuNQ9ehV2faGCwD9bY6Gpze
	 6MDGat/hFkTjmSfNTwc+DqpoMjcS7p14LbHKp5wzpgP70YWKZKwg8IjtKi4Tw5n+e0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846368;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=gZ/tQMr/BmLtx3XHYu53KzFgLd08BrXgpez4MmpYMtEpSlYEsDdBZS+CwscULzSF04Je
	 brL70Wfe3mUU2FTBUOBpHhxsq8VDF7jfnbfO2jLXrsB9oe48cg+9akXCihRiZ3h8EJjXT
	 v8dqWd9WJtBMLKqJ4zfH7Aa/iHgKdAqahs3pqDTooaRQctSqSm2Z5ehRJ5Fwi3V7fzlTB
	 u4fZs3v+bAsgxA/1bv5N51JlbuOBkIZ6BzLxl+zOOrJhQLI60ey9bFEgQqNihWBN3IFDP
	 FEYsWh0z5yzD7uhwTyIotXrBBGBcptJsxYdE5rzYmX/8HrfeYvHujAyjxviqLnIwAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=X5zCXTkx;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B8606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=X5zCXTkx
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so626561a12.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846367; x=1794451167;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=fOygrupJyZ5gEM3vXJpFX/4hTRraDeVJxgW/ZGeBOAgC2gB1atu72ineMgGvKs46FJ
         h9R9AFKe8JWWrbHMR42eojrS1u9OEI5KzZ4G8INfxXRINMC8ztbs2ufbrRXZesDclxHh
         HR0UFeifTXYRNe2OVDrYKrf4bg0iUreiDsht7q1xG8GhjzvNGCAMx3M7tTiXF1oBZrc4
         DZ0g/FoXB9WM6y0pB8woMqpxJTeRgUFAalFavOT1hY9/5ghubEVyYPoM6C7ppocULFIz
         EehR2hAJ6Iy1rOIHaUKMFVWYRQQy9gLzs4+QpLKCXPDG3ed3izt6WuMIcPUAAs6I0e3x
         64CA==
X-Forwarded-Encrypted: i=1; AKwUvBw/TLH2p+dfNA7QSmc6pGzRyTTlZPCixBrGBMrX5UuZW3BFw3BEf40OPPRWvZq9eitPDlC7GnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SVrvM45ipeY2qfyA+cBdsnomQKQrfjNirS6aVNp4YIHH5JOIn
	Ky4QDIwsEdQzU3zJdwzDIYJYJsCl3wzuH9q3j5zWaCFAdSEqx+NGGv7sNdJeA1cP30YAHkxJtAa
	EgMBXnSGSVWoSWkyuBtY5Gxha31iROZozLGOWYp11RDncJY702T2LvA3naEdIIBGHHEi6JbTG7V
	QGt4CzvI2NbPlBIyWTYnPnPTeQ9JIB/wrrB0+ZiKN02apulw8Iduq+a+jR0YQYoWh+pOYNy8SiX
	XBiTSC+OvbGsAuV
X-Gm-Gg: AYBFou1dril5x0Swd/gGB6fbGLGlAk3nST0Ful4Wz2zN9zqihGXnBoEWiGajR99KVTj
	YkEfAafIRElQZMx6CSVXJeiY8sJSOQruWK4YX4N1EUll/hgOp2bDGe/i8FwfFDkDcKvaH1p5Hpg
	rq7mGOSyRWCZAV5iOhxZa9ZWCASEgKk4VP5igg9ZMUMLh+3nJlXSF/xCyQIGue7HsVDDDVc74Wq
	U4q3FAJRu0bsUgEN9PgeBIAdzTFACwEqRStyfWNLqueLiiImUNQ7Avm5lJ5JV0YpS0vzgiQHcA4
	SWHQ2soxHdf5jzVB20tlWTqXBy0/s9Y3//LHisiVG3AFgs7T+jSEwKqZUchKLRzhmSQK8SH79uU
	phA6ZXlJV3ttRzi976vN0kZYyMnHZDJxOMrBhb1jqZRfbW8GLNWdZL9uoT9p7Mzn60CXoCryHDH
	AKBJdedxSU1ZkJpkVjjhMSawWp8RBXdBkiSa120DCM
X-Received: by 2002:a17:90b:518b:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3ae897b6653mr14051626a91.24.1793846366567;
        Wed, 04 Nov 2026 18:39:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b93e8cf1sm432630a91.8.2026.11.04.18.39.26
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:39:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so2854931eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793846365; x=1794451165; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=X5zCXTkxkyi/AFtLzEnjc6bv1mVIUm1+KofxAzUZ+IvGzhTYOlILhtwhKQTGQUibzH
         91IVJuSgYVjxu2N7j6NgHkp2T+Mo1VDVR5W3MgldJnZTdGxuUCJXIOSMh/UTzI/viEa9
         WCjAJrQVekaMKCqdQ6rVr1HDNkAQbTP1V8zJI=
X-Forwarded-Encrypted: i=1; AKwUvBwQKnSO0D5kNKhSjQ5jTrgAibNkiRFYv/mSrJBK99XXLFuT17C5EVuP88UIfNIi1skFzyxoaWQ=@vger.kernel.org
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id 5a478bee46e88-36a6106506dmr20646927eec.16.1793846364837;
        Wed, 04 Nov 2026 18:39:24 -0800 (PST)
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id 5a478bee46e88-36a6106506dmr20646877eec.16.1793846363921;
        Wed, 04 Nov 2026 18:39:23 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dad72dc52sm4329396eec.0.2026.11.04.18.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:39:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:44 -0800
Message-Id: <DMMXHRWQ5FYQ.A0UTZPNLJ1MN@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/6] drm/vmwgfx: include legacy hotspots in GB-only
 cursor images
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-4-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-4-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

