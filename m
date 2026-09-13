Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5602874E1
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789312214; cv=pass; b=K77nmq5lyAv2zftxiV9ScwMJKqlOiW617ctHhvQu0+M5aeLdd+DtCZ63dX6arx3HbL4jChspMNLH4Sst60+lzpL9z9rPkHiWWEI69mxdZ+laXRFkelt2Uuea29NDev4DlNxTEmBaYGk8EpZq6r/7pQzzXd0XCMBc0Jfj3xGHtz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789312214; c=relaxed/simple;
	bh=Kbb/7E30ax39ZQEaiWexhkP/BDx0t8X14fDULjB1uBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzMfDBKVmYCs90n65SPFbvUmA7amahSdoaYbfRiq0dyP9Uw7mL9kPkeqGCKpTvlQNVTiRz4Ppde4tM65OpsE5yXl4za+xNqhwUwXd+1zXZzqf47T3ZNm9QCA9sSyy+STGbITMY35lRakpQT9ufi6PeWCcSAp4q4mAzmkIT8L8pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPi6YYGF; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPi6YYGF"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39931869b4aso213651a91.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 08:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789312211; cv=none;
        d=google.com; s=arc-20260327;
        b=Zk2XFFd/8ALqZo3p0gt0nGZ7JishRmSSOLUdC6xR2W6JQ+MNKgKshqnYRKrB/y7nyc
         aeESdulhUTrr+6psjPJOBR0bPW4qxP4Z4yd5GkVeYjpqWGhXlRZKb3IoLWc1mf6hSOpn
         oqROHWDCwf4F9hlAufOGw6YHkNyvS0t2TRvCy+A9m9SfU7CGW/qg8WpLbsjNkINuGrg7
         IqU/Pc/OnXssXwxDNSPEaYsTx6sbAwvK66LeM3Jrvslcam6H3dXgdq3n5vJxOAomuAvB
         3QmchqciG+g80I/IopJAB1sze5MjZiQzXQ25Ddb5EFUPFgAJz1m9mzuQfUuaDM9g8D3Q
         +qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CgHJ2BPkLttawZZGtVilE3FDoUcF7iE9BEhPTntfQc=;
        fh=oMxQE66TlEzFyd7h93eBKspaWp1ZOY4ZDz3xE0giAvw=;
        b=h5UHrt6xLo5Aa763wbRQ32YY8GLLNUvJv2PEKrp9cQ9ztk46ndODbxBzBapvhqCi1W
         cGvN0efisDKKgkM5MdQ3kNlS0zyl+D/YU2GDZ5eT4Y9BJNwQczKg/5sa3xVaftvuFiKI
         He/jF2Jyf8e63fldRKW0hfOpZnCMsSQaIyApur9MDJfWpCSTnr/vPkdbYfPVc5WFUmco
         /NxygFEKRWbwLMKIZCAFpsYng0Jqo8WJ23rsTCVfbLdxclED9YIDHaL+JDRFD+IcZ15w
         3B17b3kUYEqeJS8qj1kVwF7l37KjuwrQITRUhfm1eZ9LHsOWpomjLEHLdjEJff7Gc26Z
         VNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789312211; x=1789917011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CgHJ2BPkLttawZZGtVilE3FDoUcF7iE9BEhPTntfQc=;
        b=MPi6YYGF8vs52I4pve7VO3vvBUXGhrJ2U9H63+gwxW6C3X8Hsd2hBHP+Xt/Cm4OBwv
         lNzsvwfFN6eK7P6U95PIlGA0jOgVE3bze3omIwqoeu8LFLpH2xYQCnA+TMROHb6+GIn+
         WBaTrZ/gKObPBBT4XAIlOnuh4pHE1TA4vkFvLqXpBtqvyJSNnF/P3vazH1+7INOo+i1O
         EI/RqiSZC1Y7GZ7WGF04TkCpF12JjBMw75BVh6B27TX53j1qKBvi8RDx0ucLltNYJDEo
         LMsB+sHGlgyaEsNLoN6GfUp+LjZlfPmfs3qHOppLd1ix4JxX0yeMYJZPcTcXxFQ6QBkh
         AyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789312211; x=1789917011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CgHJ2BPkLttawZZGtVilE3FDoUcF7iE9BEhPTntfQc=;
        b=LAqJdqng1QSeDlLLUEr5VF/wcZW+Rl5p2X4lLTmaGBr5WVFt4gIN+rE6TtpuxQhI5d
         WT5IsXhsnDRFoDvkYSjebIxJond0/CCmTv5Zn/EUf8WxT4tMlseHg42rk28F4+GpU0Iz
         i0j116WWExkjX/PnqeKjiVMR3upcmWRsEDaKmBdUkqf3M3ZvQw1hNme+KAHVzF+H3koe
         LP/nxcdGzTCnN4F/vz+h3u9FPLghJ9k1AxBQ8kaE7UG51SCKvUOLSShw4LfX1jkhAI/W
         /R+O/gFSFWNj13H/9BE2hKW5IO3OYSKxp96iiMxFBURXu9sTyqfC19hHwX9ugPBWA5RU
         xVnw==
X-Gm-Message-State: AFuF++kWkrtgQBDy9b4xaSG5fBAvZCJpNI7F/5quvlgZk/O7Kh4lyPJ+
	oCE98gJ3bpySC+qMbWbNSU0OGJ59bDdNywaA8prO6lhaKh5/HBZKrScwNap7BwsEknjjFro9ARJ
	xT+4dgbW8T0QLV34cf3x+cyd9mhRJSl8=
X-Gm-Gg: AYBFou1OEsWQJ8OydYR9ra3i23Z2Lcm2/NsqNXjA7Nv2Ya4c61uD5YPZPw+Q4zKOtWd
	sa29PhgA2edqr3FblR/tcdFp7cbQMM4TkG+TbNC0XCw2oEqKei6MKeQBuiLPRm0gvfoDRqZ6zoL
	RjbtZRdsDI6W9Fzo7kL0I4gGAjV7cNjPpBYI/TOJrkONfSXh4UQyJs/bkpzHHx4qcDSTD/udrmM
	bPybStnqn7c8RLk0mGCodPDKqLVpKw8dCvRy5AS1TMuyeKnwwr/oU54WZHDv+mnf95wBt6LJOyK
	1LlXVwfR495VbCtRVuG0opfbQ8ElZon/w+erodbb+mEIiKFvPF57nl7jttltVzj4KXnzGS6bmkA
	HplTx7Bw4+aToTI0iS6CFw3u+rbHC7AtOL/dFXjVqH3gvp75lp2jQogH7h+hhk5+LNzX+v1RhKn
	oORjF7hdcpaoovwXK2NRiJ9NCqcqokPKpnvk5mhtwESWIaNBLtN9Q=
X-Received: by 2002:a17:90b:3d92:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39d9c3bc1demr16298781a91.6.1789312211153; Sun, 13 Sep 2026
 08:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912065526.833703348@linuxfoundation.org> <20260912065542.937384676@linuxfoundation.org>
In-Reply-To: <20260912065542.937384676@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Sep 2026 17:09:58 +0200
X-Gm-Features: AcwNN1VstPN0DZ_vucv4j1EBW6eU3LbZ-rliJHRbeKxVGTZhoyRntdTd7caee2k
Message-ID: <CANiq72mEfbYd=Xz+f2MXku3RHt_oH7KJBi0iSHCOD47oPDo9=w@mail.gmail.com>
Subject: Re: [PATCH 5.15 702/935] scripts/tags.sh: Prevent binary files
 appearing in cscope.files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Sergei Litvin <litvindev@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nicolas Schier <n.schier@fritz.com>, Nicolas Schier <nsc@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 9:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.15-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Sergei Litvin <litvindev@gmail.com>
>
> [ Upstream commit a9b93c34625a27bed5dc0f80ee2a359ceb955172 ]
>
> When executing the command `make COMPILED_SOURCE=3D1 cscope`, the resulti=
ng
> `cscope.files` file contains filenames with the extensions *.rlib, *.rmet=
a,
> and *.so.
>
> To fix this, modify the regular expression in the `all_compiled_sources()=
`
> function so that only files with the extensions *.h, *.c, *.S, and *.rs a=
re
> accepted.
>
> The issue has been introduced by commit 4f491bb6ea2a ("scripts/tags.sh:
> collect compiled source precisely") which implemented the parsing of
> compiled sources from *.cmd files instead of using the "find" command.
>
> Fixes: 4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely"=
)
> Signed-off-by: Sergei Litvin <litvindev@gmail.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Nicolas Schier <n.schier@fritz.com>
> Reviewed-by: Nicolas Schier <n.schier@fritz.com>
> Link: https://patch.msgid.link/20260714083331.69482-1-litvindev@gmail.com
> [nsc: cleaned-up commit message line breaks and removed cc trailers]
> Signed-off-by: Nicolas Schier <nsc@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

(Same comment as for 5.10.y) Before 6.1 there was no Rust, so in
principle this may not be needed (at least for the `*.rlib`, `*.rmeta`
and the Rust `*.so`s from proc macros), but it shouldn't hurt.

Cheers,
Miguel
