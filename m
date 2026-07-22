Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45855372EF0
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704788; cv=pass; b=Eu7ntG5J6sXdDsm2JNtOiGuF8mG9eTflTDnJcwPNpLay1PX/+Lp+HUMUZfklwKVkvfRj3McypAOhW0p6/f7f+COMGoo5osH7/88vlkrP2Mr3+VxlTYGohXSJc5eBCcEoXfTKoWQnwAddvsp2vwXs+ByMuC0O4NPsr09w9h/D72s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704788; c=relaxed/simple;
	bh=4zThSNHzxYD+okwWzZg9aALuGq5zqrVRtzbLGFKtg2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5BeKMT4jyIuvpHdaXoOqET2nsmHk20VJbehNz6bJpPbYfWvZ1+9TpXphXf/NwTWoOmEMJZaFE/x2zXFnQWjenD9LSKEzUxQuPX1ZohI7Mp0EvDJtDj/G/EOw0FAR25asCbnC2E/SjaQg3GX/mg9enUjwZ7cQ5Xr1COWQoM7It8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaU0a7KC; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaU0a7KC"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so1777421a91.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784704787; cv=none;
        d=google.com; s=arc-20260327;
        b=Vsi0pESdsUplMaHWTQLVYicH8oX9QJHc00y+d4OnLN8XlBFVyv6txqUnBI6Pr2eZZj
         6DSs5mk5mm3288336wjd+GljGeaS/z3VpVHlGynhAnMfaYO4D6rN76sq4gIIfaBgt1yq
         oNxl30NOp/NipcNOkbIQ08feXyC/l6U07KmdOjbCk10x9DI6RIQvRLZgYPev5Lw6qvzG
         1RwrGwsPDxT1JowJiOdq45G0PnWF9UZVJHF/ym8InW4J/QweChGEJ618a0zWdg7DYaKE
         2cP64wCyFQ1WmrFBqunSxQ+RilZdwGyDTcWlGOmpv51GHA2xcVHD21cE2jmlImsehBon
         6SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3kLMI1ggHSuNQyv11Yct6G+erBFb60cEs2tdiP33S8=;
        fh=RLPLuXXQmaWKpCclX9dTzJtY5lJARDa8YNciMhK7aTY=;
        b=CCs1fqFmEvPmo2QdIp1NdQzh2zOxxkA+lrLYayshkJsUEntmlhNZ93hcgw4kZhOot8
         xfD05OIFMZD/vSxYQXMY3didEzdA7soaU+pzrg8ak16DMwE7UOSObPCvwi2tzewIlr6e
         gtj6xC3yNnugaI3yPSHRVF9ReZyl7eypaU0rru/Oys2NGd+gqZLGM2OnfP8HYUc4VWVw
         PNMwIPIFq8Hk9i4WHTASby1XgXiwEzYpZUD660Txe0U4KEwZWGJ8eG9USne4HD3vVFrC
         s8bTuhoOe5gUQTt1yEZnEnrvv4IsYZar0x+umfBwYAgkUdhBKGD/wl05vwclmlUl2XEv
         xjLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704787; x=1785309587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o3kLMI1ggHSuNQyv11Yct6G+erBFb60cEs2tdiP33S8=;
        b=AaU0a7KCT/PC3/Uujs3tDfF7GjT0zwhu6hT8511GWowQ25LkpdqBKS6HdJQx6J46Az
         CMUv4qeM159xR52SMYPkEmMGrNssFWVjs49+8Tja78KhD55r91FdilO4GMD8HdYWcRNo
         JyLYWbqnn92/4w9NoenFbCGbHyR9bux7Xifc8IEsvF0sE9bmbWAFpJ2CcJ5l5B2QtdWa
         3KVn6ogY9KfwKBymeYDrqfJZjOK3ZQJ26O5bKQzWWZViBrdsCHhSQhG2oq9M3N7H1mEn
         4Ai7MAf4Oqy6QnGopQJ3WzXQkGHXyzcSFWVsbss2xJfyTACXnnh9gnNZ2APboDlhJ2t1
         TxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704787; x=1785309587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3kLMI1ggHSuNQyv11Yct6G+erBFb60cEs2tdiP33S8=;
        b=pMo7geCB7YFEl8eu7j/xwipKY75h0f0OhLAWpBAwDWzt09FxDN2t8b8zivUHaXOCBc
         PIMb9oFdSlhlAaj/DXZdcGxCRGndoekga+E52LGcXRRXPkoNzNWRN0qzNQ0ncMSNunFb
         BStYcoQQ5vHic8W4DQGMUWqvRj2dNqSl+LL+AujyYZbdkl+6KJM4v0qv9XqOQHkqQ4tH
         yS1La3+Z333cdwUkK8NvCiYh6vJKm6i1bKC7U5Op4TMWYS2y+BdARi5Hwafh95/5NGC2
         ZZq/E5SvXNceapfZIG+vCeOSlWsnb4dFZaFprJVggBMjIKdnwZZ8bTEa4YrdMj1bvX4j
         y6yg==
X-Forwarded-Encrypted: i=1; AHgh+Rpe4K39QN3cwO+xsd1T9oPGbQmHPLZudmz8bIQuUvv42KOoVdbUOpAuIBdd51q7U4/4jGl0tFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd/Xbpr4GBXndDSVU0NKkgTNA6lK/qNdr94wYjnxzOZlktE53
	tllmji3v3S3rtXKmREDbrNmv4dJM0IgzY5aIdqqsclVO2WZMA1fi4o1GmRoGVrBOd27FAcn9/tt
	J5BQS2IiwjAdJrdfFBlNq7RnPFVNPXWM=
X-Gm-Gg: AR+sD13wD0MSQVin8hX7D79saX9G1vnTszmZsuvDUL/oafMyA0n64+58S1OxeekTEON
	9L6dlvLTmZPqmYmks6ByjllHFKyg+GcUwG9Sz5WCuCZe1Hgjs3HAtRZpvp/an3BHEprvz/zc8Ro
	qikwjD2Sb2ZLBb0ZxvJLhZb6NrMiFf/pa6MGa+2pKzGAUSO/i3ZYGw6+dg7dJJlzDtfwpn/AXUH
	pOEH8P6NZyGaGZpqNIC9kbU/7WBf9K5hoYOzgeSfkqagqlXqPcsu5dcqu0GCMQ3/1c+DnpOk+io
	P1xpJtvIOxVPtn7RR2zRq/j6t73nHvQ8sW5eEuZeCfnJ3SXgj7H1b7kIj3C50cAlIjwshQLBnjC
	F1Z6oD2Zwm6HF
X-Received: by 2002:a17:90a:e7c1:b0:37f:e7e7:ad1 with SMTP id
 98e67ed59e1d1-38e92a46742mr4531515a91.5.1784704786586; Wed, 22 Jul 2026
 00:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721152441.786066624@linuxfoundation.org> <20260721152443.212105076@linuxfoundation.org>
 <CAH5fLgh=6eOcsUpBODZmyhQnZ0eqDfY12MkmA20w2JmgxJ3wiQ@mail.gmail.com>
In-Reply-To: <CAH5fLgh=6eOcsUpBODZmyhQnZ0eqDfY12MkmA20w2JmgxJ3wiQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Jul 2026 09:19:33 +0200
X-Gm-Features: AUfX_mzu6_9BMnuLdA9zaU6lvCr1vaDjIaZa_hixp4hYnmzw8j4YHJhB5m5ABiI
Message-ID: <CANiq72=G_TpX6Qjeo9ZAkQX7oVjtMSkw5arjepFOW3_7GSv+5g@mail.gmail.com>
Subject: Re: [PATCH 6.6 0063/1266] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 8:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> We shouldn't backport this to 6.6 because -Zllvm_module_flag does not
> exist on the rustc version used by the 6.6. kernel.

Yeah -- please see the instruction above:

  # 6.12.y and later (flag not available in pinned Rust in older LTSs).

More details I wrote back then at:

  https://lore.kernel.org/all/CANiq72kek9NoFe2PCFnND1p6BRbuzgv6kT2o5jw09sWg=
+wau_Q@mail.gmail.com/

Cheers,
Miguel
