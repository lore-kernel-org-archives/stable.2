Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445314;
	b=zKv9gY6FxcpNjqIB6qYJplaLcxC2Qp2XV9gBacskoZJzeO809dnRbsuBTcIfiGlXUiGa
	 gNE0GajoIvuJ8lcarm6HuvW5zW0cf8PmHX+CiaDOfDdWqHCgU2zXEM2URKiP0vMK0SsrJ
	 hhTewUF6R/YV1P3yBtAZIZJ/YCufL3Sb1z5BPnqHrhw6cU1LOVi8FS2H7z5BO+L6eVdnS
	 Dj1Kt0bwCXZyTb5JMACC+JWulfc0yhMes13+2jAkL4e8gF+k9YsyUPwosyoVOwBfOYmva
	 tN8Kw6zYM7gEEyVXjRQEOXn5ivb9aBgWHuu0t84xLSVUcczABRpwHoni9AMsHpPJoCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xZF0Y2fdOckMYZ5OQvo53Uy9aotpRIWurFGH1UvKcdA=;
	b=lTXmaEel6AYShlYy+c8r8vRGI2uEmRJnPws1NnxyoYY9uFJU3fj+5lnTk0nmZmSt/jQP
	 HIAg37zPrYqUyO2jVZh7t/ESFUZV/6c5PkMHDUUS4Lxbrpn8u5xNfATrQQECjWomtix3Z
	 GhNTOxgt8slWdKaEtpwX/ry2eRkAxTukmt/5JZ16ZX/+MESvR9jthbFYf8w5RSR2lvBeD
	 f66vBJu6xQIxidrn7ONOCXp2sdDJZKIbduNP1GGnUo8kPjML8n7OcyEeMTJHQaS3Rx1cL
	 MWEJjKe4Ro7lJykLFgenLgqUlqwv8Fqz8cGH8oCFl5m/EFWfLW0fT7FswAFDTAQ0uEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cUfdMJJY;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F59606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F59606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cUfdMJJY
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so28387515e9.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795445312; x=1796050112; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZF0Y2fdOckMYZ5OQvo53Uy9aotpRIWurFGH1UvKcdA=;
        b=cUfdMJJY3f/reliHpqxivdPBRUxH7MRW6dVHwyAPTsQMdqU+KijZ7gi6y7j9Z0QY5B
         HXhu8F1ZgdCCe5jq4rt24Vt7ZeafgB4hhzhK1PN/wYw4R1j9YK8ZpYBtZ4NeTy5RpblW
         KaI3DyruCrqOUSzmOtJQJTLXeoipzGvuZSUeiE2VRKlZdb11jgQyJF4nsv5gUDhDc5gu
         r/SVIsRuuyFDzGMVJeaIlZATYxJ+0wH9VMOBWWnvt4FVJaS+ZHk6n3CTnc5R5Yh/qEha
         EDeG9XS8yG8TnQSocyLmA9mswbyGtmlHpnBCDD0LvfZ9LuVGn09EoDawyCAaAODsrr9p
         /r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445312; x=1796050112;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZF0Y2fdOckMYZ5OQvo53Uy9aotpRIWurFGH1UvKcdA=;
        b=fQHmLRkjH3iQVLRmIZQVEFltPF2NMahrY82zP7U7pHCm9bV1mvJ1VSZZ9+wpK3FqTf
         D8gjmc2YkStMB/eHlGpgfxzEXF1V96qllTkVUKIol8iCVKquC7F8hdW9sQk4ezn1XDaj
         HQPTi6WBGP+sZ+cMZoNuXzq6Z+wjfSKMglRfpkYjaX5jiaDq7guIjlMr/5P03PHd+Y2M
         RBwKDLdB7bNtSDTzmkc6J68Zt9JzeS3fxpWA8ufgeBKRLjCCqX6nsltu/rTmOm3y7uWf
         vTNeNN4Byl53b025MmShRZpCzWy8OBPfAVrA6pvg3CxVnVYzoly3iPfaHEaN8hqfztCh
         KNsA==
X-Forwarded-Encrypted: i=1; AL+hErGTUe99GxYEbVI2ikO3iHoe8V+t3jhejaq8z1a+JbtzRbAf/yDic/NiOkR05Tmz7Lnoaj/lJcQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NKWnjHylECJ0T1vtfd7MzYBpvWgjxNDhIqU21GhYZs4HRNV/t
	tyLXqp2gXK0x1Yt3h4wF8XHK2kgZFbmzcTvpFnUPEwSnsqaVs5vkCdu6jXZAEBMMTRQ=
X-Gm-Gg: AZFdTZewHVwufr33D0ba5Aeh+6z6jy3ra8Ic+jiCuaUEuW1Unny8AXayC5fe1gpABE5
	bwL7SAPUCmYuQkVSDgQpk3mNUiV9z5vYALqyENe8ojXhL74NyTNWravQRnU44ERdcEH1GDJSIFW
	ZYESKxOoIrEIRF15+y05HjzPQmceB2f6NN/X1buNkOx1PlfM9fdOySJxL9kyklVm/If2gbEZAOr
	PfQb4TlH5+nz/Oh4qACUUvlbMpzLUPUycFMYzqxHaA36QcsJLpJfXZ3j0R/0YvhFlhLBRQge73D
	25ZfTFtaOVJNJN41auXB59+4Uy/iOdkFj9fZOGslvTo7IqWBu5IyXSWz3cxHGZWZQNBc7gBDdmh
	pQ8FpbMx3sg14ayK7S+wd5jryLcIN6IqqUvTcB7yYBJTvdBztyIxYEwRzIDMBH7VlttvR/wSrUK
	WIcwAEdtZdeeQPFNKvxArkH8neASuBqD0xwrQQplRk9TJlh3IQtjFbuQWW22HGEs+ABTdHofELi
	kx/KpwJ7BfiW/02ZFdtsBO5joGiSz/Cn+7w0EeiG2nPjosKnuBQGO62zXs76di5VE2hNh96kwT2
	NnFpsiHE3ueqcLfL8BVmUCxZdFfmICEcMhpr289BWdPlz+39XGU=
X-Received: by 2002:a05:600c:1c11:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4bb8881c357mr274976895e9.26.1795445311988;
        Mon, 23 Nov 2026 06:48:31 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm22471477f8f.42.2026.11.23.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:48:31 -0800 (PST)
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
Subject: Re: [PATCH v2] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
From: Guillaume La Roque <glaroque@baylibre.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Brajesh Gupta <brajesh.gupta@imgtec.com>
In-Reply-To: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
References: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
Date: Mon, 23 Nov 2026 15:48:27 +0100
Message-Id: <179544530793.3861580.6891548435680251826.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795445311; l=806;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=00LSWVmN0FB1IQwX/OYvVQBvFJYhXx7VT3sxIQ7c0wc=;
 b=MxhtnwKz3q5p0JRhWOpgCiX3vyfV7rQQ51LTmpRjQM20hO7cKOSFMmrLXqJpDYOF7v7p+++iW
 v5Quzv11UhXD5dm2KIb64yezSzKCo6+m+F7XOlWpmN1sM7cpfqQ28Q6
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=

On Fri, 20 Nov 2026 12:10:21 -0600, Ryan Brue <ryanbrue.dev@gmail.com> wrote:
> The firmware takes "prevent all overlap" from bit 1 of a compute
> command's flags; bit 2 is FORCE_TPU_CLK. The kernel has used bit 2 since
> the FWIF headers were added, so the firmware has never seen
> DRM_PVR_SUBMIT_JOB_COMPUTE_CMD_PREVENT_ALL_OVERLAP.

Hi,

Tested on a TI AM67A (BXS-4-64) and a SpacemiT K3 (BXM-4-64) with Mesa
main. While a fragment load runs, a compute job using a workgroup
barrier goes from 19.1 to 8.8 ms per submit on the AM67A and from 47.6
to 20.7 ms on the K3, and is unchanged when run alone.


Regards
Guillaume

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
