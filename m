Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991B3EAC76
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517112; cv=pass; b=qDH/WCEA5kOc/l4Vqs/RbXu4Mc3orR3mcAosK5NqCaVULsVw/721s4W7bqTi89qFsIn+6+XUbXaCNbJpXbJSHnMV4fJCl8EJuNIC4enNiHyxrVF4UNly8h63LH60Y5nmZ2VZ6ViqMkfb57wSQEKVfCTK5P0CVs7KfuUWNX9J3xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517112; c=relaxed/simple;
	bh=BYsjsQCtzJ8dmZ7akV4JRU3PFof2LYYlizydUHpxZX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtLUty3EExArc3Cqvbd/TAwmAWlnnSvAS1efn53tfSF1nODeaacVwUIH5XOxFmoWy+UcQMmjHOajUEGDoDLaBev8dM/1KxSqQg2B964CiWYHdmaI+qOECSrOgVIVgUq1ZdRkZRCz4GG70TeFujmk8ec+VcGz6AiWl/IkaJgt598=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQcmkyEX; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQcmkyEX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so143a12.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785517109; cv=none;
        d=google.com; s=arc-20260327;
        b=qQ1/8NypkPqnTe/0SC4tYuUfGUY4elB//IiWsEICqDsLjqztVKV/ve01A1D/9KGfMp
         h46LZBJ6XiLt4VZqURIxsm1pjgVdMqu4ewj1zK+KXFHqc9wMW9JrpZC7q2ZxU+4YHe4s
         Dh7HsFUSiY5ctTRclUfUCyoGZMbWx7rgmflW+ZqeC6CI1rmaYCd1vScZMp03KcqOXlBZ
         RsWjzb8Ss09fhaNq8gAoscspfi/Kc7kgdyyt3+pNLEwsuQfGFcntdP+RvM6V6cISB3ei
         3hdDDMyGfuBbmzZtz7wEXiAwNe76VTU4qaFhi1MQNOpx2sG0Q/LqhOim1hsAAWxLzXFF
         G7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BYsjsQCtzJ8dmZ7akV4JRU3PFof2LYYlizydUHpxZX8=;
        fh=BKlZQlE42MMglPbRm+nUlH1ISEniZNuEPmCboy+fC0I=;
        b=kPn6x/8HnQ9U8BYFrcBIZFT+w1ov65wcV96iBzrOu1bi2m9RY0npY2tvXfwbG2Mb6q
         2T3lLKPkVg/6IWeMDgPpBbupr4WcC1ZZo8PzpStB0QZLYvw3cS3tVeAEhLFmn1EfKGQH
         BB2GJMR7UDDftE12zZpWnb09Xgn0GSK3pF3+r+PBsiIFSBBFzb2V0562siAW6aXwUiAV
         jgqntdlEEa1873jmj7o8p09B2aL7do+jSw3aHprf+4+Ew6eHCF9wRfcmOaqftHPtAVOo
         Tgt9o1ifRymeg4zoKPv6W3C971u1GbjdElHSk4ZiB4jz5SzRJqcjabQOpQjn3wmlo3Tz
         V7LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517109; x=1786121909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BYsjsQCtzJ8dmZ7akV4JRU3PFof2LYYlizydUHpxZX8=;
        b=FQcmkyEX/m+L2SrVk0tQCNZdQjIXeeI44CbZ04iRw6d9u29DEbQROAa+p6Nuys3G6a
         JPh5PQxQAvWyqmJzzZG9mWujkjYeY48Givjp8rHU0TwcxAqT7g/Ykm5he0Vcucry/90E
         PGRJjp22ehEjqJFNTxCrpeHHhFV+fECJTL/j742qCGarvS2LcsTXRkc29nk4DOIIRSOS
         tPPrZR7xLfA3IRGPBtQEkNRBEC/YuWG5IFOdUgDy0cvwSMA90Ds23NW056liWPGA0VjL
         TqXOptFWVyJmNcDHFTYwOELP5MTYAU+Mfp1gGb0iyIE6r6ci7Jzp81CHozEaY6puSGop
         zzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517109; x=1786121909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYsjsQCtzJ8dmZ7akV4JRU3PFof2LYYlizydUHpxZX8=;
        b=BeWEAFUKkG/+1ySy1FT60hPgmSqrpGYeVhtpmCOgXXagIJs/WooyZ/UF7mbS4LXfG9
         yffUaFkpa6rPouTfDmeTdOxEonlnj/791VcKYmi7ki3THmUUnZT/DlAL2yQGb7MA2iiS
         v1HoqmeTPNMfGR0qmjLNbKk4ONKWeLRRQhBRC/Y4krBRjSLnFzW3WT57Sjo13nGNm7bz
         04L5M41smQMdSMovZB64J5lZ2wb88ZFP8Umq2jeYP5QNxfQQ5b3+MvNgEJIkfkhNiVjP
         WhFUHkUk5KyMbGwiA4DuUmSnIMIE5hvwFHwBBhFsID4MqITz5DY7UgOnaqA3UnRGZjq4
         agbw==
X-Gm-Message-State: AOJu0YwKLK8V0yTfz2hpn60rpsBQCdfnOZHzGP74c9J9Lav3N0pthlDa
	FYE+Yl2+GqorRKqU/vNgVwV9uvHO87jjKRVcbG6TPAnt8moWL3O8W/rWDpEBVptR45ZUjhSoZtF
	M2nJmh0mj0YFMxI16OfReqoJuWhAAWoSNXouXF/APC8xofQRAiAQ2SjYsFbhUMA==
X-Gm-Gg: AR+sD11YJfJB57VOfQQ6NY4+kRKIID4TI8clyg1S0LHwM8eradYDlq82t15IgrwDDPK
	ShR21XS5LQLC2S3Itle9UB/bhPni0GdRriEI13xQM0SmKme7JMi0Mgaf5wGdeCHF41YAySqWhxn
	CLCIKMS+BhglVdO4U/3w6sgIulQdPjLgMxMhg3rBocoGva4RiJRLCcU8g+rh806YBJgE5M3CB5i
	U7Guw908II6nmyHnWHBZtaXMdwZOCR1NNMbkq+AGo64chbjQiih84ww7S77Pha3ihaPIleZpYIq
	plOhZy4cYVHagT9IDBK99r/e5VEixkvZfc8wZAh4Acmm+/OVmwAtyFa7On4biULzBU9Ci3+jWCk
	8fPtDy34ZTFG50HZnFAyApu7kSo60F1Y=
X-Received: by 2002:a05:6402:499:b0:697:df76:63f8 with SMTP id
 4fb4d7f45d1cf-6a09819c2b4mr68740a12.3.1785517107684; Fri, 31 Jul 2026
 09:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026072934-rule-library-9954@gregkh> <20260731154449.2755799-1-eddiephillips@google.com>
In-Reply-To: <20260731154449.2755799-1-eddiephillips@google.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 31 Jul 2026 09:58:16 -0700
X-Gm-Features: AUfX_mxGOPQ4tgemlfUkw9-BOMIH4U0DgEdyxzNaFCQyzRd38dGdGlWizd3_K54
Message-ID: <CAPBb8H=071arZPF2MCdQp-LJuk4v+cPOY39yd0tE=cYC2Axx=A@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] gve: fix Rx queue stall on alloc failure
To: stable@vger.kernel.org
Cc: Jordan Rhee <jordanrhee@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 8:45=E2=80=AFAM Eddie Phillips <eddiephillips@googl=
e.com> wrote:


I have made an error here and failed to include changes in
gve_rx_dqo.c and gve_main.c.
A v2 will be sent, sorry for the noise.
