Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793963064;
	b=igIEwqunuEkxpSGWcGGam6TWbQtsa3pOTNH+OqB8LycQpXrsbhSm6GiiGFwWIuiPWubp
	 5buaRXd7xE5KXPfgvt5tlJO3VfFA+CgqVoPtcRVoiVRniQb9V2+ZTyFTW7ABuaqXM9yD7
	 kXrUrQG5eCFvZTD4e/m2fELSnX+8fq7oq7ZPwJeLDLPcbI2M5bi30ju5PiHT+2NmuX4X4
	 4cwDE8puS5PsxNNPfd8ECRWz/JCq+gryRKO63nj3N9Pz87zhqW33TLgpm3WrP6etyJqUe
	 gVqVsjjGcEpBTkRgzFJgn+WNQFw+gju1qv8OXT6wmBe2SO0QLl36uHr0d+WzvEHlhiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xX6kbsH2ACpFzEA8FaBzvuQCY5451nglFyNk9c6crjY=;
	b=Ckmr+izg3ZVOduWUxitVBJFmihEm72aVuOKnPHJuQpv4gprpsTbiHAT5VUAp2mPNffkl
	 Ixh+GCVLLAUB+eWlwcWaKugaF3lPkl+iJAbvkxM0KtB1l7ef2iUxVLctCPFUuhyJvWsJK
	 NjFgdxzZXAocLA72NTne5hvcHKh01nPOMYZiQQw07bX9zmA1dN3Pw5h8zkKYTh/sCb5pH
	 x6y+kNEGpwEvGqoRcBTOc1LjG3lg1AmxtSU2Z8PDVhMF0BvXUSxyErCNwk+2JC5I5GQqJ
	 drvNczV8PmzbRRklJ1QokwhY73osvqc+c9F2Ou6JtRGCSHSl7ghVv+ThnAGK0S5nDaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXX978+8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3C606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED3C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXX978+8
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36d499f6ab6so54747eec.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:04:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793963063; cv=none;
        d=google.com; s=arc-20260327;
        b=RqzxvL7pb/PcMkMYEidIUEGbzUHxx0NRA43xCIkagbdA6savY84bEPui9Gc5TV6rYA
         0wi8eP71Es1pURUVO6lfMbs6hxvJZkR8TFuBkhMeuOMuT+Cjzl5Q9q1PpUXdmOPpbYbb
         eqttQ8r3LfWPaT39TE+Z58yps2s/sRK3veTDVaFLdH0QlZ1Rhhv3OqjYdjpyGaAB3KEr
         JMc5+7L/PoEf/5yqSSvJIqZ0GHRfjrYcZc3KY0xfyMkBiO3up1UzZrNpbd6tSRicXCMC
         PIXf8lFUOCvFCGF5gMQnyc6ZAJGQ97uWH8hNXH3IqVdNWEhD/oeFoNp1o9pMBUb2jeEz
         Fa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xX6kbsH2ACpFzEA8FaBzvuQCY5451nglFyNk9c6crjY=;
        fh=48p0rhjJSKHv1UlYGOsOv/qoL1/wlm8xZ4G4KsWHcZw=;
        b=sbnHQ72BgnpF+cvIZA/f40Mppy8thmJwbzq0Do9IlwnRRftaKreXSwUfZ5mQVt1Cdl
         OmSnHVAAjgixJx0Slc8QcGkGm3YPzwMuvW3nqIdz/AgP8XAxvYDNBXJUhdOY2ufn/8V4
         4lpHmvrTmX2eNvRnC7wm0wdNzqVZqfaUjQ8dFT3/8H0J59JMrlO6tlM+JJxvfUQh7bf+
         aRW3TPSv0uGKdwvB9cq0v0Y6owcSx7eD7e9PoZ6PC9esISyN7NZXlHMa4YUj6t5s718U
         76K/UWZoGocUx1xCy2CspN5Hbfk5zM1QQzJe1Jbsdd171nDBMDsWktZRcxdI8HjGu82p
         xsRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793963063; x=1794567863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xX6kbsH2ACpFzEA8FaBzvuQCY5451nglFyNk9c6crjY=;
        b=jXX978+8EoBAMGAwT1dGsoJc/TpeWkrvRfDiemGcXY438LSbQ1w0STurN0gDfgi1Wa
         kPEfJg5bDfLiCK8aGgbQsZIDMIwuqsy+H9zxgLT5Do4RAG9ZUMYhfDbTBlzd7AOnAWjf
         3SIMNBpbDRb6RFIcwXGtzDpXcsZLr+L0xJ2HbkEk6JF1qjsCCsMHodj9nHPes49sigtG
         D19BJAZi2WvcPAtgm978S60X1qFtpM6vBd58r/t0jCcTt+aEPQZf6O5OpGvwWv4I1eyD
         mRdYCsSnbe0MCXdC4xPYNOwo62sG/DUO7FJo4ar3lwlZeLI6gPN0w03IA9XLfxGG2eYZ
         ppzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793963063; x=1794567863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xX6kbsH2ACpFzEA8FaBzvuQCY5451nglFyNk9c6crjY=;
        b=1CbgLduwq7WVOpT51jM1TNPLfkKSzgZKi6HXi6PhM5COTrlZJPQux4LbibmfjA6olT
         mayh7pVA3wGxKeA/BGqut/7ZONyrwvJd7wrddTL313bOOWS8EZlvl1bQQKimhKzh7ns9
         mHfn4RJJNWEoyaN6sD5UTWQCTgVKtC7KdDsZC84RZ4smqGhaeAmsB4UNznBVzbMABKWW
         b/E2R0dTFXclxvzYUPL0p5ScfsXf1uZOO4g5oiEDOI2XyVEe0yscwKOCjMmGiy+q75Tx
         IznpYAWp29oDpnqk742ZfO+A375H6tMTYfLorD+eMXNJoh6yyYLYWTMRcBtgUL7iMNHv
         YxsA==
X-Forwarded-Encrypted: i=1; AL+hErGaH2cRcSA0fiwDTayNeDP5v/Otet6d7etvz9oBN12ulyUW5ufNCWs2Pnuky5kU47E8+wlETfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+NJ//GZ3kXwbd6P59O2egOz1CyBpmT7LVTJNR7OHVfGWp2mrl
	skBe71ION6eGn6ToKh+n16hkDmlFgac7RnxKBy/RdwmHMJEOpH/oI8pcLFPkc90wM7pIQ8CJ0Kd
	rX8mVmh34Oc16kA8YcfXG7xCucolciUU=
X-Gm-Gg: AYBFou0z5fkEyicVbEw+7KZE5K6KMXzaNU8cuBYCmodIE51tfyXdF4xfOcMlZb90H1P
	e+PWkp/rilpKbvR1juTtSyfOcZ+erESVs0frnae5fJYeaXgDqMKS/27d13OoThxMVkNELcNlWOg
	cZJjorAkoVZ/Pwgl7n2uqcOUEpCYfd8sDYsr/g05o8pOmHFwWX8sxErwC9KDIXW0FxmWx5LjCRs
	7f8+FIMzuKNygWjRZX/6JNctrPuxQS+aPuFl1JLfzpOWI5R1wYfOdgtUdI7v1nQKw85EXuiXESJ
	y5xnQkA2PK8JyhDlVVhyVVxDnk1LO9SUZTtUvtWURvygJ0qlDF4eBCPeO34lp6xzuzJ9u8BPTf3
	+755wsD0f/yybMYQFYuVjs+WZ2pz5DOt0XGofcabewBZnpbjurTqJJiN122n+Mi+2k1I9I7nGla
	Hns2VEu2ezM7bzO80+UWMd+tiC2uzObLfK1LxEOwIRwWrKazZFxBpovplGE11tEaJ7dS9XKSYqJ
	Ne+vjOC/jtypbvYl5HPSIywqC4k8WCUYfjXAg==
X-Received: by 2002:a05:7301:da07:b0:36d:cd5d:d809 with SMTP id
 5a478bee46e88-36f75831c52mr3957219eec.1.1793963062999; Fri, 06 Nov 2026
 03:04:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106073528.93371-1-ojeda@kernel.org> <20261106104546.2297584-1-aliceryhl@google.com>
In-Reply-To: <20261106104546.2297584-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 12:04:08 +0100
X-Gm-Features: AclHuK8jyqAZ1F8XeuMU6UiUwoMLOdeHY_OERfr8_KSaOVX2nI10vYWcW6OLODI
Message-ID: <CANiq72kSG61mTC3_0pPokoLbbE87oFrKHcNUZhxhbxpg24USYw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: support stabilized flag `-Cprofile-sample-use`
 for Rust >= 1.100
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Could we check for `-Cprofile-sample-use` directly using `rustc-option`
> instead of checking the rustc version (e.g. testing
> `-Cprofile-sample-use=3D/dev/null` or using `$(call rustc-option,...)`)?
> That way toolchains that cherry-pick the stabilization (or older 1.100
> nightlies from before the flag was stabilized) are also handled
> properly.

It is definitely an option, as usual, but this file uses the version
elsewhere, and we have preferred so far the version one where
possible, because it is way simpler and spawns fewer processes
(especially so in newer Make), which Kbuild has usually appreciated.

Regarding old nightlies, those are not supported by upstream nor by
us, and we intentionally never attempted to make flags work for
particular binaries out there. I think the fact that we support even
nightlies from Rust is already quite a success :)

Same for custom `rustc` forks, if you mean "cherry-picking the
stabilization". We can't really test those, and if someone really
needs that properly working and can make a case, then we would need to
take a look at all the version tests we do (and not just for Rust).
Perhaps some folks only customize 1 or 2 flags and thus only care
about those working, but we wouldn't know which ones.

Thanks for the review!

Cheers,
Miguel
