Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795191331;
	b=nrwFEM/IekHvCQJsL4u5SuPA0LWHyKGamzTkx+oPuW8GFThuBLFmnKXJHFbDKPj2rtzA
	 gVYYsxWgzvJc3KaPWRILqfEC4N7RyEDRER95WVSB/cEMY1Zk4mMuLCN//QBIWpBkswlDn
	 4rcTSqn6arVXNi/wN6iLMcyQqXqt0xKH7yc/JCWoHZJeJD/raQDcgIiVjuNVrDGfs3m9v
	 Dq2uyRiFCh7sgnGNauEm7dsvIBmjA3czyd0desdbj2O9UM39uSichEUueFk1sFfRIMrDl
	 3Ehsrc3Y5v+2fuwooXNJCFIVpGdcQXaZvNr7kD8FE7RcJDke85nsbb832aBJYbOWrnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=loVt9V3ThFSHRp9ExXhi7XkwLMVgNnjHRJCnHqctjnA=;
	b=mM2rIKoEWIxcvdrmVK1epvQU/Z/cL5/prPaoH+MY1yD0t57utb/G2gjMHKgReoGJ6hEu
	 OxVbC2l15RKPlA9182PvWZY7Qn8b3p/qe2KXkqn3QUYu36deWgSz3Ra4mscsmBbjBKd1J
	 V0HIpub12U99bSB7Cuea3Jd2zVwx+8AAg36MvQHbAby5SLJ5NkhkM2dkUWzn0YgMhdpEs
	 5Fiwzx+YviCE5Ek3LmAn1Oad89BO5KEDG1MGbcD2Is7NRw82Nq8aLqpDJTK5arqH7veEe
	 TN3rbgRjibf+0iAvQa0E/cstF7okqoGNum6xrYaNVxPDzDr4pLBD+QNk6Ah824U07KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shUtPaBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9A606A333
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE9A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shUtPaBY
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ae3b5b1027so999271fa.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:15:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795191330; cv=none;
        d=google.com; s=arc-20260327;
        b=LjRVsuKeSqwOCi9o0fAGtpwBLgXTBJXKcrBjwCvvnKcaDaIyXNnGuFQiNTFEoO6mXB
         lHYmoLJ8ciEilMoMchQMASnnKyahwYDZh1Mwp3stzE5meNoakd4thvPBf4DXEf3MDjXE
         sgfcCl87Vlc1uiGjlYI4CjzYsZ8Uoyd2YNIwY7j6XjPqqHc9Mgm0QYH1NmbSxkyCWWRa
         /Z/XGi/A2qGhIP8pPKJ8VoRg+FmSWfJoxAJgLfk7vE80HzgJeh0p88HCZ1H4GctFwsFz
         TcDGbt87oy6o4f6t6QrtwjEHZL86IKvjyVVkixSEqL2vz8zFYgCNCYS3wJ8eXhuNXwn2
         gVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=loVt9V3ThFSHRp9ExXhi7XkwLMVgNnjHRJCnHqctjnA=;
        fh=FoJgquq89bv/2YGCQymTJqQ+VNeiMxIU6lFhtsZ7wm8=;
        b=mAbP0opHHkWsuvVLpofiKC29nrE0ND/AW5KLpYd0VuMctqQes0U7wwx57Mb+nvgnpa
         i+NAGJ/ax/Abv55/9hIiaw/rmItZ1o2IWBCVGQ2BgwmyTBP+sm2yUQlprrK91XIpgK6J
         KPZf5g47iQ5klfUjyv+bSCb8/rH3+tG3vaEHSAULsya2sM7tZHQqWqr29W5LYk81+mT6
         lh4vc8Sr+dc+pfKp6FHAxppZAjClJdnuEesQbQNkv/AqHTomhIcNCnrKsPEhQUAAaxUi
         aBMlnOzcYyaY7lzM7L9AN/a3r8Dncg56xCYoSgXYF2mFo2MV247bbk4ju1zKO1JOq68d
         UMTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191330; x=1795796130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loVt9V3ThFSHRp9ExXhi7XkwLMVgNnjHRJCnHqctjnA=;
        b=shUtPaBYoI7SsMO8gzvz7Ba6mbm82X7aCyC7rkBABKO/a8ni9olWuLKrqYQOx5IvgG
         wEkJwPygSHLtbyvm6wXtF2B/1DGP78HaaBicpQKrwsZFRdE9XtY5k3lgcIH1gw2vjnAR
         YTX3Lw42zCCUoWe3ZUkj1ijf2m8ffrcmDZaZF4zCEQiprqIVwL9mSaUEnXIK2pZma1h2
         9HONHlnwX5eCZpUfJ5MkX9by8XVPTQ6rSloyLUj6E4ixufEX2DhAqlhvOAn5t+Cy7cdn
         zvm5taG2USCSJMff40WWXbB6ORzqtxAUGXV3ZAezu6qE4WYtZmjm2/MEnV+L+WvMxQYw
         vXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191330; x=1795796130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loVt9V3ThFSHRp9ExXhi7XkwLMVgNnjHRJCnHqctjnA=;
        b=G0C7MjhTzZp3Da4lEzfNRiYiv0Hg5G2hKSp8GEk+Kx8ALzsJC68xNbgsCeWkzzrMIe
         y8Aj89B2XF5QbPtnP7Wjl5qfsNVKJH3yT4H0EETBdB/2g0BCAk+lo02t4+9FpPZv+L4R
         oGUeLgcoxziqshWC4UBbP4nUUiFFzL6OMDmStHZTn/MF+HIbfoxBtJThE0EGJmLOzg2o
         xGnNczYG4ubJmYdMdJC5Ai45esCHHt8yKtYdgSTNyOCre0xt9NydRF2oaaMf5Oz6TSh/
         wDUnSqrpddvwHSfLdSfiEuDKneIloIMKP7MARCY93Pl4QILBEgpBQjuSy3RjvSuCc0+S
         qLEw==
X-Forwarded-Encrypted: i=1; AL+hErGJ9gv5lE1fTe5LKUknlXYSNKAsDSJBhMSNmu8S1FMA2Y9VYw11rIqckO2YHqwdh0AKGUtKBxo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FWdMfZTpoGGtZJiLhkvpxVb56hRXe+saGH5MwmbfhNCGD4bww
	E7ZdlIxXymsHfvjrLDkQUCZiCpfrd8hMzNvos9YLPyFoUUZ30TPIZHk0tIPGGjhMTos9sitfwdW
	qwQI8kAQzrvXMPHAlLHCZXllocbT7tPQ=
X-Gm-Gg: AZFdTZfhgwtmfvtUpTgNmuf7RG6ymwr6kdoepTGC/Hie9PqSOORY3VscabnLl8NfNGu
	aue37BvyxMr2eI7RpaBJKDuXlOTmbh5VL6+8yEfy+oxGNFna6imGicX01OCnGYHrMAT2bQMqHgs
	DiVRiLpSHCMOzcVKfv2BXxiL8iTPC6OC6pMzLNACUJQFjzi1g4ZhD7uRY0jioP5T5RL8KTZPJbX
	MUuMZmtxYJiSerdDNleJf6W7ggGCzp86MRNYQdMtkn3R68KaGHiaSem3TjmVmKQ9ExLe6rjgeD/
	iRxCb0YEbFpeXiRce8115cqXG5cff16X1g5bJgYpaNehuXEaQpvphr+0bN0+/a8XwW9eLLfc6/j
	mL4y+w3eDhz7+nz9wv2601JOAHPO5b/r+y/UyHdbxCWD2YEmFJUvq73ty9dJSByUykEPLa11Wpi
	nPR20jMdNVhlFJLCCFBIi+aNwUL7M/+fhsr2AKen58+a3kzOyHK03OtjHMlawdnaI5/FKVjtPKd
	VIQrLhdUDY2B7hmIEvWEkwoN0OoPytKonW7fVVf8hqalTvoU3XIowns0dGlWkyCdABpwSPQsLI=
X-Received: by 2002:a05:6512:4481:b0:5c0:ca1:46d3 with SMTP id
 2adb3069b0e04-5c1bc7c5ee5mr1077254e87.5.1795191329406; Fri, 20 Nov 2026
 08:15:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026111823-prelaw-chapped-13ae@gregkh>
In-Reply-To: <2026111823-prelaw-chapped-13ae@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 17:15:17 +0100
X-Gm-Features: Aa3M54rEBtnT1IaA7BSlka4nR4SeVWNl4HJ8gmgSPJH5dgQCodvn-YTnJoZk-D0
Message-ID: <CANiq72=T71dZ4XWze+amCs=WNRnZL0GZ-jYXSzweLTOjKKkAmA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: bindings: derive Zeroable for
 bindgen's opaque array" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: sashal@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	nathan@kernel.org, ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 12:23=E2=80=AFPM <gregkh@linuxfoundation.org> wrote=
:
>
> The patch below does not apply to the 6.12-stable tree.

I think this can wait -- please see the rationale for 6.18.y:

  https://lore.kernel.org/stable/CANiq72mXHMJv8sbkJZSjsexQunEkz9=3DSDhXytXX=
ZZNcJXfJ2dg@mail.gmail.com/

...plus we don't even have the pin-init crate in 6.12.y.

Cheers,
Miguel
