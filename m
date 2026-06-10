Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47F3EEAE5
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096945; cv=pass; b=n7G0oTgJjdF/C7UNVCs1P6PFkPT8MVstehWiAPg43XoQy2COGMsTjzXhdAwBuz87ko5C1BUwNEBz9jQBlgeIcGwAj3N6nrxctkOoOWa2WeojP5nM9P1RdnFVHXzWWGxIcEikUuX2AinCCZ8smpPyH6D+gOCA6h8SunRtkmth4f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096945; c=relaxed/simple;
	bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZlnixBm2/8h81zdukvrk2agG+7QPJpzWGNKpda41RrCHD/CyTTfvvK40S0pcY1pcUJmAhk0lNjBKml8XIs7SmxoAohjV5AadOydx93N9y70MxM4saSNB1xpp8CAblh9rg/igJnkDiwMQYsTvP51Xejp58F/bKsefIStm3Q3NqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiirN0jc; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiirN0jc"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d2c56402so336482eec.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096944; cv=none;
        d=google.com; s=arc-20240605;
        b=aASF8bQZdP9s8BbTG2bOdUIPTjrCaGhVDaxBj4yYx0arQbtK1YuAeUgpUR5MRLAp1Q
         RFClq/8r3otYrDecvRdW73rmgqx7zml8bpuFWVPs/FQMhITFH88n0MRDignKRZXHLuZC
         /XAlRdVXtZW14KMPrjhztXVe4RJ0/cI/C9TPC9DdhOvk/vRMkJMJ6x8Wp16liRAI6Dna
         qLhx+7socFvnNsgYaSq3hpvy4BTgo0bIUt4Ubqej4MMLQtv9YcauamcAEqdOemZ8A4eJ
         xUmrk563cMmUk3CpUb7PPq+oKq9I9cMsgYAznO7DAZ1j3ed/O8FvYcgc5I0zoZ50tkTF
         L4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
        fh=7529rl+nU+yBsAeDF3evZxxTJBo3LC2O+CTMzyE1r4Y=;
        b=jNX83a2AsE+YueVpbEEowZvCwaXX886bNxnYgoJlFQNwN9utXLpeGgK8zasBDaXBCk
         mmawvIWbXwZxyRuKhum6TPgbw7ibuEZu852vlE8XmfV94tXhsaK/3lvIt/BDfuUktZhZ
         xGdAoJDmTrf/Crw0jW+e+DGunmZX0xR1SVDNal6eYVX1o7yg7Uz6ILxZnD9u5L+tTqo2
         TWaeqptvVsIeGL9+6tJCf4zROo+AUhBMfU8F31fNQpwQJeDkD3YxBz83J6AnNIOt0QMC
         FTJPJ46fjKrE3mzctI0RyleQ0YW3T1b+KL4EsUI8ztqSAKyFB4gHHENjRC3X8Ce5orG8
         gJLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096944; x=1781701744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
        b=NiirN0jctNGp0Xrul/PNU/K1v50I4gqMb1n5zsGuOSqZ9g/CVyFXVr8ghr+rfk1CsI
         UKE3zToOcUOOXUjhn/hg+PCw6NC2vLMwJUBE2fXuGjm7Ua2ABhupZFBNIxxLsleDl1Mg
         Pd/zOK50sgJDgZ72jd9xv9PzllIHHABaqVTQ4x45JOfzn+ujt87qqNKoiQPicapBBtpT
         C5pTxgw3NgDCWafzAzr8iADMKy36+2bLdv7GEG6nhGFkik10OPQToFstgpc0OTHwKyHD
         5sh0IfRAbxmng3n2aaTPytTttR6TMHyz8Z5OmstlLced1rct+3t4XgBZO3uhra1yE+ao
         nP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096944; x=1781701744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
        b=Br/kbQvxDNAJ1m9ORYFOvaKd4X+LRGDMsP/UU2PzzjWERO37L3POhA4RMbOtzIi67v
         IhBFSI/U/9rUesm1NlRcwQZtLsJlNV0NfDgCGCE2tBBfJt0IohRk00VZpreMA0A7mupT
         ZRB/9V8cy+zOyWSjpaIk9XMk8U8vv31KyYUMbbgBcw9PorwqRS63/xaJWVQNVrdEzf3A
         agGIhtvpJRNhuDvIkFrzKUvk8hdZ5FGLgbvsT4lkxgt58BVrjfvrLEuIXJarR8gotJvt
         DVUqLCQi1w6fzWVd8lnjMWJcxNmJOIJv/6qba/CHDiL8fdsODeAXOZvShW3vnRjQBxnE
         cjKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bNsMnovx4wN1aBiOUeyQSlW7aUVDYhLySBOtAb5yw/t8CWCNUqfQYdlc2cbgORQdwQDeeW1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkB7ym4Sk1jIAc67GdK4JHP8WNnbAtGMY6oZ/Ca4rFTv7tGLc2
	iv9sbGD6YJa0Pa06o19tsBO4DrQEYrniBhIvP2NyDgg88mLh19gXzcSY527qZNXAlhBzOEOKCl+
	wcdO5xAE7Y3j9F0m5YPofKu33iPtVLGo=
X-Gm-Gg: Acq92OHJtG2Uww7kIljuKiaGIMoJUeuisZ2y84SUk/fYBVxLrW7EsQ8Kxag2qTdv9oh
	wukCKkwTNnsV0XZbVNGNQhQYDNhYloVUxvoxASCpNnDWZMSOEca7B4eBqyTyRJwcTyVhbtewm7w
	Jvn3WM2ZRNDjLOSlS8P2RPbESTpC/WrtQmjVtGkChRsWdEZW/Yc9AB4EMiu/qxo+cVbKmFPEU6V
	jvfXO54/+uG5fnQN+Q0lMrsgLjulpPdVpmgyOoawMT9jNF3DZpj6hsKODswcFDhAwUbK468/gTK
	UZUOBEWrvjmGLZYMquWvYwIV06xuS1assJWh0dKX4Yx+Tpd+KZNunhWUY0PaaNcdIcCLNEojuGm
	fNSjlPErKpn+u1VyWothJU/EocQ/5HRJ2JQ==
X-Received: by 2002:a05:7300:1352:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-3077b576885mr6517116eec.3.1781096943682; Wed, 10 Jun 2026
 06:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
 <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
 <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com>
 <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com> <CAM0EoMn9EA_TS80QzXsTscBpCgfJHssq0GHtiNbrMU3FAiP2mw@mail.gmail.com>
In-Reply-To: <CAM0EoMn9EA_TS80QzXsTscBpCgfJHssq0GHtiNbrMU3FAiP2mw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jun 2026 15:08:50 +0200
X-Gm-Features: AVVi8CfHlwkVTHo8xz3kijx6SbCXBkd0w80sby_--JSQFG4p4xR4OJZ4-aRIac8
Message-ID: <CANiq72ki_YW=0UbadZ8pp0Np3Je3W6gLvAw3GJgRmzjXZ5RBVA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 10:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> I think it was too early AM here when i was looking at this.
> The answer was right there all along in what you said: The missing
> piece is commit a005fa5d7502

No worries, it happens :)

I see a005fa5d7502 is now in the release.

Cheers,
Miguel
