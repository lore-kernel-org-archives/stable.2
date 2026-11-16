Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853749;
	b=YN7JQBdyZEj/rSqUg1htZxSiLOAiDfJ+fTcLfyKiKEB7wqxprSYKtwvvzPirMDpB4Iht
	 470Bbxin4CWgh2wgPrwoE7tZ41/+7FykLDQTNEnijE3NFQsVJwXx/VZUDUjSYmmZP/rrY
	 G3vYLPAIQX74xVklvMRr+12+8rzxCdtYKCc1IuWYImX0O6ZaXLTJsBWQ0o6KedsP4tsuI
	 j8sbW7PnuqcrRBI1t4uKUqEHmyqw2Wn/idTseL0X0rxuLPJkQgpXJL9XFzZRMtYhB36A0
	 Nj4stAVRnutVmiMZiCp1OUzaTI/l0LagE8nLFBWLE5R5N4PSMVtZsR25uoau19s14dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CMURHZUEjPGHjKxsa4r9UiTn+rQOp1qEEaG1lKbmkKI=;
	b=FeOUe/CY9ysAJPNqBZ3HV672gAHK/Y3GYLZGCEPGTHqDlvisg3CqsAJQETH02qlEfaCh
	 qWY17ddkZ/4V85wFTtwpwJAGCMfxy7NQ3wbK33TxmQXXgxKgCYstRfqD231FBS1CgI1uy
	 WgO6Z/YDo15t6Pm2FYX7cxmsTr5AYVrIpj8BvCccumPB7Nff5vtQyDLbHzLQh+gImxyAs
	 mI5xtb6fHlztBGAmDH876nS8ajXhlSAShKtBzkvBvLytlMb56l7itsPph2Vd1+Q7X5BoK
	 cRKXKIPCbwS0au6uwSVw01v9OgBT6FbwJMIa8u27S0W/FvcpxpC9ecb1q6Bo74KLz2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FHImyXqj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE1606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51FE1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FHImyXqj
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490f38e9688so114279f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794853747; cv=none;
        d=google.com; s=arc-20260327;
        b=XhVmHbZK2BDLKNKfoIT3mngIiZrcZKaMsqcd1sZDw9XINmmw5kgFCeZRYY69DOhtc4
         LMX4lDf2u0lgMbqilEI7JuyekF7p/JibtQOuuutKWVH0cnoyXuIzKYg/qQVtHubjINPo
         RvMFasYO0GmyMxvvidNozwNp9PQr02lTP6lWTL4sF2ENr7j8ebnPLQQ6f6lAAA8Dyn9t
         pLDiGHtavQKWQLaEVAk03bGI4PMebwssHkGTtXUjpwUlzQEc1PJY5MNuw1oHohAU9Wak
         VNJbuc6c8PBs18AQhO+L+Va8DPHWUsM+0PZaWEuRUtuneMd4ZFGS12mBWX/yBaZU8uWR
         ndow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMURHZUEjPGHjKxsa4r9UiTn+rQOp1qEEaG1lKbmkKI=;
        fh=3jnUqz4SVuHEIC/NgZSEWbOqj4Fn4b3Q9ct+2vhviWk=;
        b=bVUvDUVxIbzZsSprSv0RGbCE0lfpYLdzoPIxtwv+0+NORXD/QCXnwS5mtU7j3lbxry
         ilmuUhFyVuC/jjCl7f6y6rhl2a483yBPVeNQwTyLdLCjG+/ljjKoXE8hqdU57oYcmy8R
         4RXwDabizmxJ8urdYXomzY8avd+oGpOS7/ZfeDkGuTR7zLw9cio366wpdHEfqHkSPbN6
         LVSZx5s6obDQOwfvsnLu2T4POmj84FESZKTdwBEf/3iib0OnugKnpT8/FpymXp6ikb6N
         p+n0yrJxJL0LsCiWL9IZeX+pEjm015J7nOvfC40KG0FxlFEWtfEqeS09aJ6RI5c8dGen
         t0rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794853747; x=1795458547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMURHZUEjPGHjKxsa4r9UiTn+rQOp1qEEaG1lKbmkKI=;
        b=FHImyXqjKF54qvn1mc2RE3gV2hCnlWIaWAw6NqqnL8cS3+c3Jial2vTg35lmI2Pgi9
         4oaIRNBCSWFstH6oEijywsTaghGJAVPkfY/feKTFBfvLPDI8aJ0Ix1l6zNHzINX5IwsX
         o0ZIkSp4mGgAHFTlDVwvnE8VXvGTf2QAAXZJbDbENpQOzcTDb8IRY7TbckfhfPQ3uQmt
         vfD/7oZ7HfF2YHlDBzHKwm0p0Ok6Q3wVM8NYiFaoaOavsUJBsVL/+NQRVmj2RmVba6ma
         8YKlzRMmrswN6C3H4uVHIVK/zHPWZuhVAsQCbW/YnQ8N7wkiJ69ryIioYoFVX59Jktf6
         tRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853747; x=1795458547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMURHZUEjPGHjKxsa4r9UiTn+rQOp1qEEaG1lKbmkKI=;
        b=OySqIQe76DLEoeNfbn8by2Q3qichSVZEKitWNWiC8yEpE3YnJkK/CdJnJbQ9iW2eoD
         FCPCNlByx42UeFRQQ7CF5gQFd+BurEc5fBA8Lu/dQfDelZ6cp6110Uo1cC3uhOKrZm5W
         +5VMhVL0I04PGHISMrCzs3EsDcGEOpr2tt0y6EF8RtCsW7d2BSvKH1MKT6Idm6oAjJyb
         f3hI3PLsWlrBr7FNx/Ke9hdxdXVSqVPgWukmvb2D9SLg3AScgJPxJLTucYHmoCLa4UG6
         6S/S3k2rck5pteq+FXBgOLRg2MqJHEdNM7mFUeor8S/UHrzYTzz0/OKq/8XfpDCkJl0B
         0xiQ==
X-Forwarded-Encrypted: i=1; AL+hErGWGNYd9WrprHzbAgF+0WXW2277VT9PVSTmg4tB5eJLSCVPIte4EKTCLYtuqsyYdvasRLqsJ7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8seauku/3foehUQVO2KsUmoIiXcN/TrIW2MRf2eJFBpctkVYJ5
	LoTN34TpLTbH7CxZdVSEUWHv3ra+f1uzQq9BNaVr8p2qCS+XSBSeQ7e1EdWLJJJTEM/c6ca7Gyl
	hYzjmK5urAClwrq/oK+4xlIHS2ogP9ApyNq5XSGXA
X-Gm-Gg: AZFdTZeN1RWes6EA4UgV0Xudx2/qp47BT/zBHp+6mz0BrCqFIwXl7iOMV/VMYP8acKB
	LcvwbunBkX+5jbWwcXw2LvPSJGVdBi7vgYY1br+gzqE8WpysXoxP6ki2BdJNgiwWeJUz/je47Kh
	OkkhOkfXxNlrnjG3cmjN2lTykTZR/30X3DbYg2rOFmP4R3qLs+PSIWmL/CdcMMtmjw3GuPgH4la
	PVviwJO0kiaf29tn7Hfy7KW71v/EFUyJdyZNYE0muowxB9NHk5nOCTUW5KeRPejvsECPN76nAZ/
	1BCIeaiPGJiegLIeIBMkZkefPBFLa0rE7TcH8bDMa/NvjCxkFJv8tZZcQiI41FYpCq6XvkyuBEA
	mwv4HOwoiGlPDiSjrrShaDP2HXHiQOHXUf9HSGylW3Fzl1EmUbjtFaUJ/QCwow79fH3f2njgV+S
	gdtkRvdXqF4Kjo5dgldt0maIp1+nK68xzIfVMmFOckiMM2kbD9n3rcDp8a6PyR3RKNsW4zoV1Tz
	+hhziGtOgB+aO98LKmrpK/iD8kRsYX3a1Thl24=
X-Received: by 2002:a5d:456d:0:b0:498:be72:6364 with SMTP id
 ffacd0b85a97d-4a376860342mr482276f8f.19.1794853746846; Mon, 16 Nov 2026
 10:29:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
 <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local> <20261114204605.GA173332@ax162>
 <20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>
In-Reply-To: <20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 16 Nov 2026 10:28:54 -0800
X-Gm-Features: Aa3M54qN3_OoGAqkQOkSbWOChdqyPPowLr2H70kPaYwIzW6n-JgVCrQ_Fg1xSn8
Message-ID: <CAKwvOd=f+ib1XVvFfiW2mF8NoWo1jr55fJo=QOuZCJmzQCVmtg@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
To: Borislav Petkov <bp@alien8.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 12:58=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> (If it were me, I'd simply whack that native thing. It is such a waste of
> energy).

There's always KCFLAGS.  i.e. we _could_ remove it from the x86 build,
and <whoever cares> could still do

$ make KCFLAGS=3D"-march=3Dnative" ...

(I'm agreeing with Boris here)

Nathan,
Was there a bug on file against clang for this?  I can picture a fix
in my head for this...
--=20
Thanks,
~Nick Desaulniers
