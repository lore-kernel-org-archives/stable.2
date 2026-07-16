Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4938E8C1
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217539; cv=pass; b=A6RRdi3EPkIHgm0Yl/i1C39JE/iYdZpCODMDLFVi0tgazwR43zCG5PGzMvfX+F8+dWep5SAjPJEi57GHvMW6TsZFxiJ08ANwBc0a9RpDIkzgJLMVlBVeGSOQZEAcYHNMflw94HFo5wQd+fVzUdIn/VMBpNa6j6sPDf5tuYE2VR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217539; c=relaxed/simple;
	bh=gXGE2JTN3iONMX/sxgFMRargYjXfoFWeNgc/EmcHwhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ+kMbm8Fmm+61+d+DKzDdZLDSdkWe3Giq28EHPopdUGrJHfo3rvfgg01t3ep2QnElhR3HRGaMq7LLvC03xE+tRPgyYFU1EG//uM6bzBD1DP9vndveuSJTHLBtpvCL0zcBifRPVtFX+yuaZ7OSse/rz6q/ID2D7D7XeQ3BytHtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlJUtXfQ; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlJUtXfQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38115bbb83dso544504a91.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 08:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784217537; cv=none;
        d=google.com; s=arc-20260327;
        b=HC9jmk4nvwPCObV/daHxE0YDpRKH5wVnq1OU9RlNZg+X0SVjGaVWSVgLYElXYUqcss
         XwFTvNG43AJnNYCk8yJ4TXLmJT/rZjABkfMC46AUd8mZ2t/0hHTlbdf02/fO1okqA9mL
         ZbVYpwfWaNkBIVZZJGyNflFjzexocdwvK2ziPVmEfgIeP5n7R6BCpf/mgDsXPnasDIdd
         0CwzR6jxYjm9/BzPJT6THxbxkjwq/y5HAV6fHmtmDVi013VMWyC8oFGfYHhvDoeR5CRB
         0Jf8MdGWVO+RUQ1wMaa6dCSXs9Rov04QY1QZMmv8uK2uthAAJR6L5d34NU1SJuEueKNr
         4/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLLvZR8s+bvbiEudcUvS92j1tIu/zyxnG1t5VD57tWk=;
        fh=MMeMReNoLytCn+VqdW2LNqgjWNr+nrBhxOYfbZz2qDg=;
        b=qeyE38nJa/bUnOMqWxVoy59a3M0mRTezkjA7GSkvcstp1ledeHre4rUiheIYYVkCyI
         F3j5v5UxOS43v8Ixbzzl5+Mou73+dBQTsXFYdvSe2Sjw9PDnmKC729oWMZj43p7NuEe0
         CJtMqlb9wX4n5uxjQFF5lxB+Zxr3TV8MefX3Jr6XnrBVaRmGkxwkMLzMtX78gptr6AC+
         L6iIUeruEmTwsvJ3vkVjYTJ/pIcX55w3G6kXy5oYXYr6k12VXrg/T0RPawJm3Ovjn5C/
         k6l188YMbPpg42rsZS/ENnYCbRrGEsuL7nPQ1Hdx2LtuW8Aj9njvIbHWmqtemUSTAk8G
         a61Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784217537; x=1784822337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLLvZR8s+bvbiEudcUvS92j1tIu/zyxnG1t5VD57tWk=;
        b=AlJUtXfQmI3wTvJfqZO+Iyka7Upt+Owd3krGKn+EKUhopSqu1UcT9jfaEb5/1hIjqv
         kQ6Ma9Q/pZet2R6JRDIHLSboe4zW0qkLwv1qHng0+K8AD69uQmf727Cths9r9PNyv6Rx
         b8Fi6hpl53EDOQ8k68n8n3TI3rq3J1SQA96hAzkIDUV8oBdAUNoRwAAMSiecV7jKkHn/
         DhbQzZJU4KzrsWiK5Z4+yKtAGLoS3SoatvpC9GDSogn1Yv7rsJr0f/1gvinHHqyFt5PY
         Uzq4YSP61V2RIu6tcpAvahmD/bE0auEE76nYGv2G/Yz9HoctcVOUteRKwC+SCqRHjVeS
         ge8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784217537; x=1784822337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLLvZR8s+bvbiEudcUvS92j1tIu/zyxnG1t5VD57tWk=;
        b=m7GxEIffJbCj+aK5f4zL6JeBGn+BeKUWHFMJDp5SJlK2+nvjTmI/8qGEw5/CNBdjUu
         O/Lqr23ABIPQyw9h394NoOqIFH1R1FsWSXF4PMJ3FvakWmKusLIOuAa7ObZRu2t42KrO
         HQXkGEjUA39VjX4wZPryw3zDmENCMPgyRAHsno3YdrGdA7nWfaqOUOHXkjxUGkd1ulYb
         xadJ0IUKIBQU3WVt2+Ljn5LAdNOmZH4E7vIX9EM1cB94t9B0OpR33LaWjwM/rne4enUq
         3Pr3Q97mR9zJr/DZO1DzEnfkvY2TCK1xH58c1vZRb1o6CRgrB0LsY8J34X/MIDzf42+6
         1NdQ==
X-Gm-Message-State: AOJu0YxaDEey0BTJx2oOBqa9OTsIs4M8zbG/DG6uhLQY+PTh+Eu5NCej
	wFgxY7/uJ6FW6OorPfomgeNIqCKmHzEoIsFuMWP5aXUyShnbcVpmcvsUFnxpV9pddUqbobFq0TD
	5cizT65PLFRjJimglc87kzcVIb8bVf9w=
X-Gm-Gg: AfdE7cl8LcEDE11rItgvsaDUV6d5ZEGp9Cp435I+668t/dCa0ddrIKIMGczzspDdwcG
	4UmzRkmyCHgcwyFWjVj8qjV7n5EkPw7utd3YPzYHlXBA84tEaR+iUfGMpWtP2D2UJ3v3lwsOWjg
	yrUe7HUraTwiwWVI9F8AWfliJepBD9ouvuFAjj1U1PDD7hTRR+fJkRwL7NWSuUn98OcAqGbsRbX
	IxSQNZr/Ivkt26wkrRNOltk3YcsKL+87t/+Xl4GKUw8yR4aoPChff5P0jorU0CV6XywKlIHjlmX
	Bp5nl5wCgCyYTnFqw0L258I5C1Lj1/MH5eLsH5VkuhRim8h9GnF7JVABC2QAU8kg4rf0sSGfZEZ
	4Dg==
X-Received: by 2002:a17:90a:7344:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-38e05499eeamr7440803a91.1.1784217536632; Thu, 16 Jul 2026
 08:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716133047.772246337@linuxfoundation.org> <20260716133048.240591252@linuxfoundation.org>
In-Reply-To: <20260716133048.240591252@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 17:58:42 +0200
X-Gm-Features: AUfX_mylqLCMHtYaCdsdSeRtFykT7QKzo4AElgdPbIx5g0i3WLsKPDPqmzR86l4
Message-ID: <CANiq72nR1X9Mb614koFqALMJLf39K6wXsUcF1WegM26UNg99Aw@mail.gmail.com>
Subject: Re: [PATCH 7.1 021/518] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ - Adjusted Cc: stable@ as discussed.
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>   - Added comment with link to the PR, similar to what we did in commit
>     ac35b5580ace ("rust: arm64: set uwtable llvm module flag for
>     CONFIG_UNWIND_TABLES").
>
>     - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Something strange happened here... :)

It seems your SoB got interleaved with my [ ] comment.

Cheers,
Miguel
