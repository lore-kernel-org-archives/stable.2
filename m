Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E844CA795
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448516; cv=pass; b=Gri0gR6lHp6gPLCRidv1gVOYdSmXJWjYNthE9SmJBibb7vccrBXWyFNOPVSSamuHWcuXkw7m7u5BGI6CE1oaIf5CEfxeyDHcGPdT6LLrQLixjmSPS/7LwnBW9AbMZoJZRqX6d7179O7uNU8onZAUfVZ/a16IGenXporKvpHXnNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448516; c=relaxed/simple;
	bh=h5neUTOrP1x8BRLR5mddyIOxfogfU/RQTAICejXgRso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqv0MzaucEbrPb5WxdbchlQSokUsvZp1GSTPlAAGiOoJmSOnT8jIj8hEN4e2vRbgwI+oChU/Wf/nHLb2BRD7di1xZlWu/Q51mhOZKa8MwBFpFW34bnpn2vwlxwwxLEVV9OIdPPmXK3lHiwTJMwT6wR0EWW6FdzV0v+YW7bfetfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iozxyPGZ; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iozxyPGZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso448434a91.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448515; cv=none;
        d=google.com; s=arc-20260327;
        b=nUSUv/J2KkTv4wzJNre28efrLsBYk1f3r+hIN22mwvxk9GQFlPepdDe7cczPCwSryd
         3Nbm4kVPJ4WkpfPbABhFyOT1/N1qHUaErCNHmxTST9Pp83oSVIkTcKFWTa+UJL2/k3BV
         zRlZTqzEyn30jMiTnLhOJ88k+E/S99Wb4iLLZ/NjGiNj/p49VddDRJ7Lz2X/M2UYLjpg
         v0gFkM8CKROTADicCq/vmS0ASDL9sQ1fS9AKbjB8+K+lX1s2Wg4qzT6o24GOBu1tHD8m
         v11tMTt14+meRlR9sxaGmvPQ8abdvFTOIOKz4QtR52bHE3c2LWiFDGWHYLxmN7yXBSvV
         +1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5neUTOrP1x8BRLR5mddyIOxfogfU/RQTAICejXgRso=;
        fh=ZXH18aCZj7OO1l//4N7B6hPTg2oFZvRPQM/FrAh8Iac=;
        b=ofTwaz//aP8d7DOs6OG5QG1yp/AFdqyhhdSqST80Uze1JRPVUIttoJ11slcJ86+pUs
         cqPJEGr1WwcOA+EQzwk/2QBdjw9ISofpTSa+qvCsCYfmDMqhMVkXQ/kMIqafrjgjXVS8
         RE6xY4q4Awiqc708Wn2EHWpogxTwE+ya0wbB8Tl6VxPvH4UHCY9LSfccUKaDh9cyD1X0
         wx0azBQnlrVm7iHecKL0RNXKOkABkuZGq2TckflTGKSJWMpuKi6whCJrQ2FnuVHPXpdu
         Uzs1QOZr7nPWh/4e4SunqbIiyQS5QeFZnOQOrjDnzFxvCrj+TlWoJ7yjI/KfcWUhuerv
         0M2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448515; x=1789053315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5neUTOrP1x8BRLR5mddyIOxfogfU/RQTAICejXgRso=;
        b=iozxyPGZGp8YMPN9lkmArDycb4ZNQvlfxUKTaFCSX3HpomW62BHHlSadP2NAnbK3sV
         DdG/RojlbGmcEWbG11zOxN5JM2AaXG0sAh11A8ZQ02EFy5mI6EwA7vMumge2Q2HXzsm5
         vJ0WIHCX2QUg0AKB6Z39TksZK0HOl8c1Q0vpPnWzS2WDXLeIE5uN4UkrGDVswFSJjLpd
         cGRLwJhRtFnj4/8EN+LTC6UClrlL2ZvLx/6rIvF4oSfK49+/FOn2hsQPgv4/wxj3wX2t
         2AA7MZZvGwH9ZsstWSOMSdPSY/C3kTuFEYvEtKHEbKuZFx6xe98K1u/07hPO+JPW2IOA
         URNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448515; x=1789053315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5neUTOrP1x8BRLR5mddyIOxfogfU/RQTAICejXgRso=;
        b=q0ERCw9CNBVitm2+8ccJwcnLtdcYWQFYykL2C3UCz7YhRsohMZr2JbFPySGkE0/ULs
         Ro2tEnGwLti4CdU8KXrGRd8jDzZVzc+doM8DdRc0celHgD551SdAY6GGZG+7zSlFTLE4
         YAkZ9RRxzwsvTxH4H46zIIj8qxUhoC/9/OhcXBCutXBwdKN4Aqt9gcBPJYBotICRub41
         m+it4SPDHe7xTVFqEZxDM805vHdrtzsvgfz7IDbqtxg9GYfBk8sMqqm+EuckB2uRbYbL
         UZHhe8Acq275cshjj/YDBIaesooTBg+IasT8RCwlQPcYtX9OsCgLxur+Oz2gFnbdFGpA
         KbPA==
X-Gm-Message-State: AFuF++mHOOTKULIpN6nB/eQZjnBdzJmfvbwgfDJMi7G2Y3ChKSCmy4mb
	8H3CTQsjTMjWctEIGCqkL85Cl3ADXRMC5GeuLccZZN0mescXWI2lotLbJVcOlJF9YxpsKpZF1C0
	sDY54kvm0caeR56u1d9oLoGEZgWSEJIo=
X-Gm-Gg: AYBFou2/59MaaB+U/pRAK8Z0zr9SKZFkcLPlu6dvJKVlI4CFPq0RuIOtsmIbudLFmEl
	OByNSdaaMQgbyvuBkZ2LfvaFCCaWEAj2UmngKAYwAuMEUu+H14Qs46oXJ4cQXUPLrEp0qHZkl3c
	rMEBFRCZYyMldaDwvehi2eCQgU5VBH320NzXT/gkeIpTmT9E2w6k2S+XcNzSSWoO1c8jocruUcH
	Ris9NkiWF9M9eVZFwVPZydg5LhGvWQlojCxVhL8bYTXcqmigc7vRzL9Sfv20+P2zNqQnK2DcXrV
	EVxlAZHiuCsJguJyGfywzKrer+Mb5ZUFx9VFvswV/re6P6vp2pvnTu033+HyOYjCm7gr0/7k5ri
	HqWOZoFbVXvu4Dg+J96Sm3HkP8dMsZF8ZrSQQ850X02gCMoY47qWM66us8SMd
X-Received: by 2002:a17:90b:2644:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-39aee152be5mr13407361a91.4.1788448514629; Thu, 03 Sep 2026
 08:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090303-moonshine-study-20ce@gregkh> <20260903133902.763984-1-sashal@kernel.org>
 <20260903133902.763984-2-sashal@kernel.org>
In-Reply-To: <20260903133902.763984-2-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 17:15:02 +0200
X-Gm-Features: AcwNN1WH04PlCkUoCzt1CwCFVWiI9_R_qFdjDXNhDSS_2HoV4pOHAg_1q46AzCo
Message-ID: <CANiq72mXSQW-haA7tm-5152_WshqeF2qPGngii361zTNGSsrgw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 2/3] rust: rust_is_available: remove warning for
 `bindgen` < 0.69.5 && libclang >= 19.1
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Tamir Duberstein <tamird@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:39=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit ae64324ad5c1fdefe479d77ecee975bc6b37467b ]
>
> It is not possible anymore to fall into the issue that this warning was
> alerting about given the `bindgen` version bump.
>
> Thus simplify by removing the machinery behind it, including tests.
>
> Reviewed-by: Tamir Duberstein <tamird@kernel.org>
> Link: https://patch.msgid.link/20260405235309.418950-20-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Stable-dep-of: dc01dfb37b34 ("rust: rust_is_available: warn for `bindgen`=
 < 0.72.1 && libclang >=3D 22")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

No, this should not be backported -- `bindgen` 0.69 is supported in 6.12.y.

Cheers,
Miguel
