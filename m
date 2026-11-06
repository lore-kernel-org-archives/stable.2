Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793976023;
	b=hkkNaxx/OSc0RDG9LrQRMSk19L+B9MZuH6Qcr+VpX2ez66k+8yHWqaOV7CbxroFXeDVW
	 3NrrM1MzYsoCHB/JrmOdNvm5HZsGJxtd+icQge7jVvg6iJ/+biPBXzGewllW2juyzRQBj
	 rXVxu2Azjw7+ZoqDpM/M1hZZHclPASeSO2x9HeA6F461P65/FoPtoTz1nzo1b217/IMcv
	 qYoxuD2+DGq0vNqU+m0pcMHvrX6RbjxnIsOPJAb5a36kzQUN/YIqVh8jnAejtgUoMz0C5
	 UD4zTzmtuxNVWrBcPn8Ch2tsp0qP1t7S3xpIYbwOV5Sj7TfbhphpWmEYySGG1sJSrJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F7C3XvRPVwBnyBTPbAnWQGybPfJLAQ3PQIa1pes769s=;
	b=S10RzwrLqbqzdCernBERc6gV92pdd2A2Hf05kyHyUBeVxNDFrSxVsS7KEuG32ciXJ8z3
	 SLZhxIMn+Ux2wsDzuJ4bor3yqmusgPeNWNXDtS+4ApkBuB6PEy3v8VaJtDzjclK6oTTxh
	 hCV/CD7Yn4wxqSvSVLUbgVZLK16xK6msq8j6K8ePWANToDfMjyFVA6jhSI3Rd1fVSClPX
	 irce9YH38VbF643SN2WtZFYfPPxRKGNLqtt+W2KsH+jb1ErVuZa78QefyrU1RVfEf2RLu
	 RdZVDXt7aGEGO8pZlEH0DI0Jb/q4/dgvXb0SYftEcQYNkDV/G9TSgjyOQQwnujR2pYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUn65zTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BE606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5BE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUn65zTJ
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3646e6de3e8so57281eec.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793976022; cv=none;
        d=google.com; s=arc-20260327;
        b=eNiL9o87jIuUPlqne5kz+FBMOfXn59hsdTycdQnNZiLnVUZEwM2kcVQe9HuAeRWFML
         Kv1aQFi+RcRhUaCJHYMw5m82Y8X4ZPA5noe2hwcDM8nME2B4QxGNpGBgoMrGFv2RWaCy
         1p09oUhszpv1oDfo6l9crMm/GQkBRVXWOEW7TFKn7qpbzc7o+50R1dtrpIT6eOmHT2kX
         PspNgWKuxpaCKnuaB5taB+hqDgm7XQYGhJZ83EVBgafzIJ1/JrV4JOrH9NItq9vCqi53
         G34OqRNAv2pVgqYIMQIwVrb3jcjU3wC1KABi+rulp7XutdvRBpHTS5OXovtA8e6woYZQ
         NuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7C3XvRPVwBnyBTPbAnWQGybPfJLAQ3PQIa1pes769s=;
        fh=D9c20EoODtjoRsjbDSJZ7tuNTv8JXo8JkpjihbF8/Gw=;
        b=BmQNmjByw7k9SqGKlao/Q6PsHK7C+er/FFDu/lvcdaivJejjxpSSRZKwNhuqDkzGuO
         3odnyvqCPiU//YMCy1C6LdoHAIINtA0JvPOLFItRC3nedY2ByugxxGnEN6/iD/RL3qvD
         9RMF9ZW1o7hPPNaRo6AMBNazphT51ItOfwh6IIZIu+/WSATH1GQNlUt7KvqcQEJqBxG5
         zzaJPpx5czUbTIGDLoboGuSCXzhDLQOdlxswV8JdlCtUCKd4CXtZMQR4BpNJulS6skH3
         AO5Exm86Yeh90oWu27JgGpjiDgs1OAk+Dy5PxHzOZnrZP88aHo9pVAjK964fODsB8Syw
         pQ5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976022; x=1794580822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7C3XvRPVwBnyBTPbAnWQGybPfJLAQ3PQIa1pes769s=;
        b=GUn65zTJNDoKPl3vqHbGIg8CrkaoZJ5ZbKBXSUeL67ULltTdgPASpiOE8YvPaBD6gF
         /cmsscrZapHx/XCTz36wKvLtZdv8xwgHT7rNpn7DEXL5LUNOwn9yYuoDMEBisF/S0nG7
         0oDaxp7/dEvsJL1grsgcTjDFGYs6mBLE1FFaQ2rD10Su8TctKe3u2awY73AAxZY8UwcB
         4xgl3rGpKGpNoaSNahGdpk/5Cc53vxanDNtTzdLoB9qcxp5nzb7XksorFIpTdnwRwccx
         B260xn76eu6tQEgPIPohsl2PBlR7qq6k/AGaTlgN/Ek1peaysdDAoDokRpYDK+aP2PNN
         SNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976022; x=1794580822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7C3XvRPVwBnyBTPbAnWQGybPfJLAQ3PQIa1pes769s=;
        b=HhJxdXZC7IfMKnoN8HfO9qrUyPsRpHvdNw1RWmCaIek0fuabMOyyE/rx9EtWYqvaS2
         jsPMpxv2K9v/3PYzbGxj54+e03HOulhT8WmT6FVfDgOzTZImCJLzT8Hae6gGGBTM/JjU
         zqSulCtA6vxT9j1AghY6cUYrnfKOdNL9FK8KH5C1arYX1M6EhsEFOCgSgF8mWrFY6S6p
         jWiBTH9ZivwwUFD1ReEIjFNFxWIFZ9ibhtznBS9itpbc9Xsf9AODe7n3b4YdxVCWeDHc
         VyTLWTrys88ccoFEFjCsJVwwpseo1MDA92UksCVC+lu82IQImYLlMe0qR0MhZ6p7qsfu
         Oepg==
X-Forwarded-Encrypted: i=1; AL+hErEuuJxsHEtZKyJkiJbuRKqyIdSDs27HmNMnXVSdM7eIbC/fqLlJRAbMcWuhWXwBqrStG930b7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OIit/nrN3F4pPg67YvfHKF9zmxUF8j8CLm/9Bxk4TjkXDQPOY
	JtnVYYqtrnNxN+NF8F+GTsuGDCfb2rwkzGdWHPq9gQ929dnIQUOZDbOeozRYZTFMAU6fzLb2dvb
	K8SEG5l6SMRsDuF/jfSMybVTV+pi6pbF59w8NMyc=
X-Gm-Gg: AYBFou1UXI+0Nmz/yuafG2CCbhQUXthZdfzntGRc/bYvyL67uefYMww5cR7tdJMcnG5
	GMC2Foyg6enSyTddHB/Q1HnO6ewgI7poWC2MthASXDftjM+lcYhGAuoO+2DAhjBoJQIVR5WqVrd
	uhN/KgRLZk7h3MK9o4RB2L3Oq/2W+J4KZov7iF5kSPqkh1bU+K4o1H8moCrKA8c7aExI9kH9jD6
	xHIpip2NPGPrYQqFmQwgXp8MZpmXXDKLBbpKQ92wX/3XBiQdJr1hoCqVAc6hfni+De6hD8PHEsQ
	lsqbLKeSrRx7pi/JHBRo87d4ckULznnK5F5LZSACpVzVTmKJmmJLRfJQltPxW9Jb2me+cynKTxW
	laRvDjyZHcVBlQkvH1+hP1lM9hPn4N0YM5+TkoLgjQOCK6PA3nX/5K2vwmez46qz4qvSqp/GkQW
	iALTi5zpcbt/Zj2DfoApvhiRo0zz/I9SOX0gg/1jG3QbSCUtl0ygmMEk8iIZmC6TrLobyotgCr9
	lPgYOJ3UjPC7dbH7dzsu+MgtagUZga/xriG
X-Received: by 2002:a05:7301:5156:b0:35e:d21c:f33e with SMTP id
 5a478bee46e88-36f7474bfcdmr5902404eec.1.1793976022514; Fri, 06 Nov 2026
 06:40:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110415-camping-contently-b1f9@gregkh>
In-Reply-To: <2026110415-camping-contently-b1f9@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 15:40:08 +0100
X-Gm-Features: AclHuK_Upv49bER6V84XXMfrSQQRM_BUIeLMni5czHEmceeRDEa86FWt42N3Kek
Message-ID: <CANiq72=+xor_iCwZtyLkg8VpSUT1XtHeKfT=i472YZLRadTYxQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: hrtimer: declare cfi_encoding for
 hrtimer_restart" failed to apply to 7.3-stable tree
To: gregkh@linuxfoundation.org
Cc: samitolvanen@google.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	dakr@kernel.org, fujita.tomonori@gmail.com, gary@garyguo.net, 
	ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:14=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 7.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This is at (as a series):

  https://lore.kernel.org/stable/20261106143802.27907-1-ojeda@kernel.org/

Cheers,
Miguel
