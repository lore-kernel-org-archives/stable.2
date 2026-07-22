Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB74374190
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732484; cv=pass; b=b55pps7sFY8Irhgr2YREw401lgyrlmryWs7ELLxYu8Lon8jmkN4lTO9/rAdIrHtUfl+aE1GFN1omeYf68mPFQdzH2bHgVSsT5QBKftP0terN5prSd2C1E3Qd+p95VlINl0rY2ywpuH0WEQ5Ik+VDC5q7W2DSuqh4rpk6vok18+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732484; c=relaxed/simple;
	bh=VI4OwuFEOitISKsCf5TtIc8+gelg15Dp+6Rf9Tq1qX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqpNu+cFjmpK3uZ/LZAVhwOkbsecmPNH4uzo6bP46Wb5na/youxEooXe77sonvyWuAF9WTBMnxQ78nhqQm9Af/tybklbCSA4Ai7TOMid5NeMBmuJgFH4Ss2OcCPMM2lwdr0uqtQPBRrc6UEDpa6iPnnZofS4poMBxMLvkHgsvSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSPpg0f7; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSPpg0f7"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c01c79467so1415841cf.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784732482; cv=none;
        d=google.com; s=arc-20260327;
        b=RwzOZoMgtNYYzL/cgbc+xBVzcQZqWqeUf8kjgbTMYiTHheMeJWo0T28U84eVm6bwnc
         QS9MRdmcWWf+77AZb4Dl4XsKh3OpzGqNnA0Lv1f/abMEjgVQPcKBh1jWEtEGb1Ybt2bA
         VMe8K6+EMFZgT+IlwnUZLhtYeASkSP4SYyiWurLP58TTCQjRXFjIpL2GVlUWD0om0Sp2
         LLONX3I6VLbUjxuAe5/M0whpGyCxqA9NkxVmh8L101omMzL1JyclAIFCwCdQt07c0TKQ
         ggNSCeURqlag3rTWxTSqlicf+wFtDoyWsgIPDe/fJ5w8NmP/nJ1d7YwxscAsLbkDjoN/
         KAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IUDdFmL3+NA+J1/tlIoHIkJZpryeycSZRENBb+lv4ow=;
        fh=b9EcZOEYw7LjEYP9k1or0xSM2l61F1Wm0P2TAKKRdLQ=;
        b=O0Sg/qslgHYh5qYWqcw1pRFbTNNrDYyOlZGg6WWsq1IbC6fT+Z049DbESo1LEhvY2J
         Hc+zdmI0Yw1DWAMLDovoHcJ9+xk2/89odO6+6ZGQKfswT29yfAIz/gziXyc5ALSd6URk
         wCdd7ZuttgGwSPIpgTEU3OET10aL2FK+vPx5O9ypLvEgfENmCU+tO/hUoeoFYWaY4Umh
         +yc8Tldwpv+s9suktkYXQZm8utcpk4aD0ZGKPHgvMH8h2SYlPoVbIDGjiW1NPgn5Gi1W
         qmYOuKtiEhOWzmJso8jSjm+AJzlGr3IvXtdoKcNMsTsn5bv/MLLBwhmWDeLvkll+e9Bo
         yyow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784732482; x=1785337282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUDdFmL3+NA+J1/tlIoHIkJZpryeycSZRENBb+lv4ow=;
        b=ZSPpg0f7r/YhvjRoLyIAlFN+4MjqH0BCbbfgUvA0rPW7GS1jxAj6AaTZzCUl/KkV6i
         VFmERVx56aqvhmxCZOMlNPUOMFLwAr5uVtwunHD/bLu68FxKLf4lcU4y6cyFVArtRGzw
         19nnHAERW1Cod9XXGbF/6Bf7GcyqfYdC6tuJRB7mvRKrtmQvUI3kHSCxTID8O/jrO7dh
         4pG1dDCMtESX8N2/heY1Us/Vc6btQQFruIE5ogkTfE4rvEQRVadeoJpYgY3aufBAEnlG
         B7fywLc+rV3uJKK52OY5d5B2gLkbDTQoZgmOP9m0Q1KK9ZS2VZJhRmytpKdXws8XCZvN
         t7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784732482; x=1785337282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUDdFmL3+NA+J1/tlIoHIkJZpryeycSZRENBb+lv4ow=;
        b=WlcdSN6olbEpMlToykqrdBqmDpJRA1mI2lsZw8sRPpySmmCOdy8Iu2Tv5kAZjhhlm3
         u5AM78DdbEOZTJU/nxFnc6P0Qybayy9iOEN0AWt6KUPCARrDoZkyEUt4iHmDcXGMfBL4
         eTJUcb5pkHiXMqVhqvlBlylO7oHF0kLlYV1VhzP9UXruFCkG56IyJr1fwrTtZgxw6Njt
         ULBl2aBkEWZyGA8FDXmT45jsWim+/Q0qzP6QP3G0FlnA6BUmBPFnT8HFNcLbxftqz0Ze
         6yq4L29yDsVyFy5wwRjcYxEUfmwyZouaxLfsyH7h7b+2A0Zl/pWsCD5j+9LojDQ7HRbY
         07UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rps4An+a4rehi8yq4sYuuL3TneMMcIUwzhrlaTgd9L5b0I3ZvWwrvc8vIXku6DpYhuTmXVAQUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzey0IT/peqHHqo88opQiwMyw1ECdP4M0LzcWM0stmZPXgvasqK
	+tRFXieO2m1CfymqhgB1VUfXmfwoqH6rrRVTo4gxaUPcn10RRa+4NQWSuSDu2sm7c483LY1mYJ+
	7J88HDcBTAMnVDpKiDzGS8Bxn+W6yunqSM8EjnNio
X-Gm-Gg: AR+sD10mNYgi0D8KF6CxawG45aEjK9JOHiMvuT7r5OTxVS4j9fd2UApjD0AzfZLWyZd
	6FGgpDqqHlryVunjqwm5IhuLmi2FQztF5LsoRHMA8udEfYsRqBl/xQ0UWgBsky24jjFFNCnnxj1
	mJo5BcflvOprFYLrHreWzLJtf8qZz2jCj335kT7xs51MsZ5lg+WM712ZSqgF5O4Pka14WfSmk/1
	soSLj+DXoGT5qgRRUx3Fj9WwLZy0jFid22UTvdfnQk+HRTkPXk/VmAoshjMNKQSs+zOnA==
X-Received: by 2002:ac8:5fcc:0:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-527ef057dc5mr8866391cf.7.1784732480733; Wed, 22 Jul 2026
 08:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com>
In-Reply-To: <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 22 Jul 2026 08:00:44 -0700
X-Gm-Features: AUfX_myRDvh7sB8bTl-K_5M53o7Jc2MxCOtToMgfXS4NBIZfb2fG6H4OMTOIhfE
Message-ID: <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:54=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> On 2026-07-21 8:09 PM, Nathan Chancellor wrote:
> > Does using SYM_TYPED_FUNC_START for imx6_suspend() make that work?
> > Something like this builds fine for me and I see
> > __kcfi_typeid_imx6_suspend generated by Clang.
> Hi Nathan,
>
> Thanks for the suggestion!
>
> Unfortunately my physical board died, so I couldn't test this on hardware=
.
> However, I gave your patch a try under QEMU emulation (with CONFIG_CFI=3D=
y
> and copying the 4-byte hash into OCRAM before fncpy), and it still
> triggered a CFI panic when suspending:
>
>     __und_svc_finish from imx6q_suspend_finish+0x78/0xd0
>
> It seems like the hash generated for assembly doesn't match what the C co=
de
> expects at the call site.

Are relocations applied to this code before the function is copied?
Because SYM_TYPED_FUNC_START doesn't embed the actual CFI hash in the
binary, just a reference to a symbol that contains the hash, and it
relies on the kernel to apply relocations before indirect calls are
made to the function.

Sami
