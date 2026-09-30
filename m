Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400B515964
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787026; cv=pass; b=f6RXgc/shOfIBzEBFhrDhCwvgas5AkpsKYTxVKoMMwBGdFR3SoID1zqWkEnlvme8JzdS3/tWKSzT845CQE3a0G7icV4E+2H5vtRQI1vImyRcmk+QZ+h7rfEfQbjoirKEdMmmJvG9IBlyWG8cX1olEky5E4KsmvVObln5NYne08g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787026; c=relaxed/simple;
	bh=dMejdq+6xK9i302/pJWEwnrQc2gS9CMdhB1sZmgPEz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN8TbPQEhh4l2+itmEGYDffw4bh5QxvDodErfKuLWj/FcAqT0bayZS4lCQ045C5cPpvweglWb/weXt2nSo7WiM9gPTVSOQYsR5RARGhdOGk6zVbToq6/Ji7LEIvCT8FQQSbIqY6o0BFFv1wZkpcCOtNPz0s697tHwEsZsdCycp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeTagFjI; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeTagFjI"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a36887bso3067408b6e.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790787024; cv=none;
        d=google.com; s=arc-20260327;
        b=YBorui7I1Ry4D2tW0lmzwIJqSaU57S+7zKxw9s/WuCj3Qz3ogA6Uop63biolDroJaX
         XXEqALliQt4hxtK24454Kbgb9ITC+8SvOyD1BjgX2zO6MW137fMPsPv8DSPpmBe5JJfO
         UiG9bcVkpmFRCvMXDSA1KhqqtYmUksBe3XUT6QfCCQjH//GvpP53VZraKsiDHyQuLV6z
         QGCpH4qsmF0gps1hfi9s5fMd7zPOAJPVNEMhA6Pq6Je1IUN6AqYp9yofVcgrSOSxJwTH
         70xy6FWOECMEWRNh0EyvtjX5kmDY8tnazXpw0H8iFeFtxEpgFnaeyLpeCBRyAcSSIwvQ
         cn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dMejdq+6xK9i302/pJWEwnrQc2gS9CMdhB1sZmgPEz0=;
        fh=wqVm5E+aQ6YfBqUqeHqUCsDWVS7vSfpcoUr3VBsuPg0=;
        b=rJ7KQHUZQgAv0mz2oZc4XAm3tqUizVPVdQYCynooqDbz+qNu+RwxRKKxlblWuZFK3F
         3J80KxPw3rsI+sLtf0e5SKIghnxP99ZCUzXVWp6jfSw3gcPjY1/MX52Vu5H5vL8zH64W
         clsEupgnrxkcs0FDJ68rC6yX+bZlAHJYS5Ccqcsl7zMEkuhmCVrnu6tgR1tHhA5NDR0I
         ezpNjbSuInvgP9HXTyHuD45wchRrTDth2ypfzAm8UZozHB1QsC8WNe1bv54hp8QK2/2s
         hr9ssYebhFTc9rVe32UZ2Inw772D+GVAkK+Zmp2iRzycIefLAN2T03ZDrnSJCgvNQqXG
         SOIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790787024; x=1791391824; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMejdq+6xK9i302/pJWEwnrQc2gS9CMdhB1sZmgPEz0=;
        b=eeTagFjIJFzqQk3+seTMYlL7TPZ7zMXEPZbUczBT7D6Kcqw1cNKK6m3dVA+2YTS0Xy
         LG5K4PlwKTc3oIo1g2y6m28zS/i49EhQnSxLRnkdJX8bEf9yr2XM2hemOFTd8Tb7EqRc
         Zw+l2emHXbty+wktfzAlx8RxYDSuE8Sy5xgdvYB0NN1smAMOUd3iLn9PyolM8VVIzxc5
         4cY5TPxn4lzcJw2EAVupluNwmPq/Vo4ez8q3yKGGKXHJpbSwKL1d4NRoLV3tV9S3QxzE
         6TW3IOSNZS5xwRgCi4tL6NhS2TzZXHkjSaFLwfuwQML5LarpzW4RhoVpp8GJT6VleiVt
         pCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787024; x=1791391824;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dMejdq+6xK9i302/pJWEwnrQc2gS9CMdhB1sZmgPEz0=;
        b=IMVlcp+enP2uIxxfOVPO5ceXFPHcmHtKfxj6J488UxIlGwKEPNCNrlrk/Y44/2oYCi
         qVQ1vu5fc+xis2/h30D3u/dyXKkQ5yw01iFBzBZEzhJgrsbyE+b97WfRrRx1ojBV3yBV
         xCcFpH2zpl4tqxh7a+nOBVpQMZXeURefJmU2MiD8ysUvz9JByAaXoNT8F2NPbvO/EIkn
         /3/2/uFHJyMhFfSaA/AjiPh08IyYHEnFLCkePcBfX2S0YKCYYL56a1vMVrND+H1qBdB2
         8DAQJJ9m8HHKoMBquhy6CiNpvxvXcdUA+R8LWlQEmuXhrYzK4AqUyNRZG/H2bgs6ZWHW
         CFSQ==
X-Forwarded-Encrypted: i=1; AKwUvBydvC+3hpkLHR9DqFyOxY5fUNy3lXizzSsVJ084k592CQu8NKeMChoNp5eSMxSdGaWEx+FWNqs=@vger.kernel.org
X-Gm-Message-State: AFuF++lUxwHPf0Q3O8P5YkCAQ6QdlEA5037o4CNY6vpDkyGqWO1MFvwl
	lnUipmiFcHcl+hlVv/hHCKPvfLSnxE+FADq50j++Jpi9HAL1kc0aHwuSCCdsVE7z2UaBE82rSOZ
	tCSKonbLX3MmUcjsJ8lpNg5cgzpxYB68=
X-Gm-Gg: AYBFou19Ws6hapidltJdHxWT3c1mCmvPWgqb45TrP8DC2X7x3scnzGOI7N8/ndoaW4A
	sP23K8aFmz0rhq8VnEi3TyHyP7JXk3BnLnkoMkiTbcYNLQo1CRv3h6firIRvCbvmOytLB5nBgni
	g7/XEqpgiS8+x7ZlCWlLnVX05u9T8zLaW5KUBhgdXH044mk2BWG0O3hm2QwfCztFX92EydbqnHD
	H9OosVsFXKOgX2b0s8W9GaA1iL2pzhXYdoIHZgDYowEsiPoi/21OTJurAkRizApJ31X1JzWUIMH
	vTFsRPmo7blnOWyuQPPgN1J7SY3ysTmur1G3IOya/WTZ5uOAO5iDEIQ3Mkel33i4FUVIk4de28S
	3zCkPmq+Oy0ps71tgJK3MfQ==
X-Received: by 2002:a05:6808:5089:b0:4ec:19e3:4072 with SMTP id
 5614622812f47-4f1b688c0afmr2518939b6e.18.1790787023868; Wed, 30 Sep 2026
 09:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801205311.386692-1-devnexen@gmail.com> <ar0r6Ej8JgH5Sj3c@zed>
In-Reply-To: <ar0r6Ej8JgH5Sj3c@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 30 Sep 2026 17:50:12 +0100
X-Gm-Features: AclHuK_54_qV2YHpovcqDJGpG6ks5k27JUE1UKomn9QRor3VmwsO1wi08DR76hQ
Message-ID: <CA+XhMqw3kwpuv=D3Wvco6kGq2crbKyK1ewgcZePhHUMPenuXmw@mail.gmail.com>
Subject: Re: [PATCH] media: mali-c55: Fix frame sequence numbers on dual-pipe hardware
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: dan.scally@ideasonboard.com, mchehab@kernel.org, nayden.kanchev@arm.com, 
	hverkuil+cisco@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo

On ..., Jacopo Mondi wrote:
> I would rather handle this with per-ouput queue counters ?

Right, START(n+1) is processed before the DONE(n) bits when both are
pending.

A per-queue counter would not advance on underflow though, hiding the
dropped frame. Would latching the sequence in
mali_c55_set_next_buffer() work for you instead?

Cheers.
