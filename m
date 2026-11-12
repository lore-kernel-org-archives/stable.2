Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508664;
	b=fDLtE2D1gpCHaUvu++ZbC7NNe/Wks++RJIPY3avAtO+HpZdn6ho8MO6OmrFkoVALc6Mc
	 lnVKxID01QLrvIWGULB0mrAm/ZlKDqyfjiJXlA7YXTEnAAqk9tdBd/3gWkOlXnCIQJGO5
	 spea/yk40GARNXkrUVmgsdyGMw4ToqIzYJWvguL3kG8giOP+ozqRyFAxrExsitOZbm7m7
	 CozS70TJN6yf+VP1mvEuiD9/pHpnVsw7CvAwGyGhT2PqST8Uief1kJitL0MciBVfN+Te4
	 OQR0uW8Cs3z2hlB7Qx3cl/sWXDEVJKZDh72CwMVOuexYEQRac8xNXIoFeok7E2mP/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508664;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=A//gDP+d92/7X8XcaMWS2T2zTqHY08pMmAFu8Sj/ITHLwNO3Tu+LLDKzX/g3jL8qpnnx
	 +7/eIqFIndX50kEzUmM2fEnuMRuRPi51KLMyrDEW+nht4HDLlfRwx7uLwCPG091vBVofu
	 C7eAppuUub5xH6G4ge/sZPHwQTN3y1aC+n4LZIRjc97nz21Ihs8LVvoBS/oQg6GqnNoiC
	 8JP96+UeB09LIOC1L2shtAPE+a3dNhPdiQsqYf+SpwYa6mEgMo2NiepNg6VmJasr8K/sy
	 qHgvYQqUjpF8IcS5YKH2n9RQ0SmtO6H5ks3UDb2miorPyHg6S5jieCIkYMv/gPQ3bOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EExWWLEt;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851A606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1851A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EExWWLEt
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ed0890476fso1092385ad.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508663; x=1795113463;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=e82xTzA2wrNnBXqR2O+19mOR13v5zLNUugu7srzv4/YzQl2FfHnVwA1kyFq/EPx08H
         ph2NDI/klP3gJOSLGEteogb5YyFgYm3WpxoE4EgbtT2NUz8Yfpu3OWlLSF6m02X3FgEw
         psUi4+wS7i6dmSV1AAY0kmmekcoCGjdr383HuTPTozFrPbU1KTPTw6zzbu2s6PU0cYqJ
         C9L2oS3L+OHqaqUq+YVsfIkCwanMCd8IT75uXUE7AYMUSKirgtRqt6vkMMciLHmuPl35
         i5Ev+3WL9a14gvqvCVRDS8wBKqhfzMNLPWvncZTPtQpITrXyver9LdR3InnoBcMaxPox
         MDyQ==
X-Forwarded-Encrypted: i=1; AL+hErGXqQAL74Ara0LgtQ2bNL9BQyxWB1zeE1IfJ0WWPRTYJO7EcWWMel9HpY6fcBZhxxawIp5fnm8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LZ+8apGKZBW2qjXR2JjPnHs2PWdxbxLyn5m/yOSfJC4iySTzf
	6uah9MpbWtPFruofg77hyF/RBI1J04ArDdSkyNFYEo3BEdf1m77nSTBS2zxa3XgQrYSKgr6+vfc
	Y8li+Tw8jcvQD1m3o6uvKwPdLweL6dBsinO1jZIOKsXB6xWSAUYvURxVtyjJ4vgoi+gucLCnARg
	xSXkXkbx5R6RJ6pj/W3oaCcurZ8OKUImoiJKCcQSjpKXWObQHn+HCnG4f5oo3klS5ImElT+XR3y
	jOc4ACYkK0FptXU
X-Gm-Gg: AYBFou2S7XrxBqP2bsBruZC1ylKg/UWB4hWTLuTQiMyzlc8nmv8b9W0Wb6nMxexLDqL
	ncWN7JZWn7Ntxn5qS9mH6EcYRaQRJOBMqe3/KPXcbF7iT1dPjfMgWItGCYuF9t98uKC6DW1DD2T
	b6j8Ww9ZZNlGbyFYmg6uoaRb4NAXYzsfEwA/vN8GCnDE8VbYKYhznzFBxAGk2yJaj7/vJS38Zo7
	+u2hoTcMZBojCzpVZrj58XSWfHLjXwo23/276cJnCMny12XkxIjpAJBh6zbGRDRJV5io/3RWk8S
	JCeksQd2WvNNC4b82VjJcP4ngUsi35+Usep2RbOh9pVHySieIgyVbzD+ogIMfQcakdx7IkF2yMP
	XtXDQzHVesrkr6vT0RE7xh8rbcVNcVzMmbhQ3gVxCivfSnqqaT795sFTZ/pbWGMAivLKy4AL6Ie
	/737vrwM+Ds6qG6ubW/k7bMLKdpJLLP0uWroh12p2L
X-Received: by 2002:a17:90b:268f:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b182e940edmr6235217a91.20.1794508663228;
        Thu, 12 Nov 2026 10:37:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181ffc52csm2348548a91.1.2026.11.12.10.37.42
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:37:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso573891eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794508661; x=1795113461; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=EExWWLEt4QNSfYH4AkOHDY15kb2ek8S9xNKO0M6SYMx38dAHjfmYvRaa8IBk2AyQlj
         co3HfhljPnrHtSxkV3SNjSCqCiSAhmop/2zvqHt81bWeW53Qutwz4fvR+sXknyPva+wl
         ophxX0/n/gIWJSXsCFleKHa6a2GTIhbKuZ7iA=
X-Forwarded-Encrypted: i=1; AL+hErHtpnrUUn4mC/uB0zgiWCsnMzqN5ZCZ5f1mwym/pKaubxnKwtjD9gHbc1oqSO+mrmHWYVuPvNI=@vger.kernel.org
X-Received: by 2002:a05:7301:52c5:b0:36c:a281:1bc with SMTP id 5a478bee46e88-37966a5ba74mr13300eec.16.1794508660971;
        Thu, 12 Nov 2026 10:37:40 -0800 (PST)
X-Received: by 2002:a05:7301:52c5:b0:36c:a281:1bc with SMTP id 5a478bee46e88-37966a5ba74mr13272eec.16.1794508660356;
        Thu, 12 Nov 2026 10:37:40 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm353962eec.12.2026.11.12.10.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:37:39 -0800 (PST)
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
Date: Thu, 12 Nov 2026 10:38:59 -0800
Message-Id: <DMTG9A5MNXGM.3V2N3BM23YGMF@broadcom.com>
Cc: <ian.forbes@broadcom.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: validate command body sizes before parsing
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261111193836.3161904-1-zack.rusin@broadcom.com>
In-Reply-To: <20261111193836.3161904-1-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

