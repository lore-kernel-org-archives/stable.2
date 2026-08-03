Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D742C51B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764773; cv=pass; b=RzpTUGpqpXtCYF/uJA6+/Qy+G80z0Dib8Zpag+HPPEI7jltQEvxW1LharD9TYY3voXN7NKNz8kEdu/5HTbEgTqk1bDntJU6fAkDU4L8+Qrn3bxGE4rrqN0Ycput22uZ42HqxnElqzOExI33Fx3KAKX0VrDGTDJQct+ai5Ud5gKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764773; c=relaxed/simple;
	bh=Ee4kLdXfVk2GCa9eJc5mwREr0xBuHFjtFrr8xmqcFZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxVhhg+iB5TLO2RBqHaMY397jAMbz7N9phXkDbngZ5meHXTCjswao0tJKGHZz3G0NhRhSkrxFT8XYvcPzF/MCQDEdR3hA54vaJtsiKBCGgQk6rU0MW17C55o2OGirBU/t1PTi9EnuysBeoNHsDzjsjneK6lmpQKaP9pk6OZ2Ay8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXbfito7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXbfito7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ee6b2da98so41362767b3.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764771; cv=none;
        d=google.com; s=arc-20260327;
        b=YX3VQJVtqEECvXe9WEgFusqjeY6ofY+lqBUd15YLAR54VLsHHQ+Kpf5IkXhjREzvIS
         +4IVc28E/g56eS/2spUIrMCFPHisisglLOjiU7S/qAwGtNaRCxsi1nz/kqnGCDp2UQY1
         GB5eR811VI45MawP5/q3wUQQbrf6Wm84K2As426qDPfZlujUIpa+2rz+Yo5qTrx0ydWK
         gEa8xCrRkrx4hHzbgeuTg3vFvm23NYPcuINDnVswux4CkI46q+1leaD6vBO8S535Acw2
         X6s9uaUR/Pc0ZfUABg2p2iWDrKzUiT7tt11U8ltb74eKuGGCTHaqopuJPWEEhmXb25sO
         jqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFLLowd+OV3t61SPjHw+s1uSeKRn83nLQOLuHiouvho=;
        fh=5VadLEulxAng2oHzDfedM75q5CuYz1LY3OV1l1PTTqc=;
        b=I3bEHcDIY/gILnyAGH1z5Wgbly2jovkwRY3eGivjoioHce2rufWNo4p39qQDdCNiBm
         zulQkBoUrt0Fz/QjKz1UFNuXvqZiOSvSBoO/b+spnQC77qf3YvvBkcucikwrwo9/+GAJ
         DpBqtd7Nx82P8Jetp9BNAqa27dxldKFm5y7Re2/fTXBcbKWiHLKlGh2v+uiu+2Z2Jx7k
         DdA7O6RKaXqsx6KzDNgKrkPx0Ngswi2tCGiB9e3xpn3fvMpjO9JILloP1LwrzbZbJXMY
         O1h5od50vqT8OyHRfqchO6lx5oFNJ39x1emhsiwMTBu9VQIMLpLJ3cwqy41x3kmxnmh6
         jWrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764771; x=1786369571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFLLowd+OV3t61SPjHw+s1uSeKRn83nLQOLuHiouvho=;
        b=nXbfito7PDF93pQpmw29hqbkWhUvQ73zky3hp6Bha5drCbQD2XsTDNwd2Z6nwkkyvt
         vIHAIELyySxnFuG1tpS2FJ4Vo6E4yc4PcA3b/GeOn9mDkObjc135jTL/n75KY4fsW5D8
         r5b/B7u1UikAZyq54DNI3ynFsG5LPulnqi9hzJVP++qNciT52FQPvYWwOCtnQFRsDISl
         RER6C/KlN5WYjpxkePB8PCQ3g2dvxwB2zF7EwMtfYwjWRXCwTqeIzZgrsCFzsZVe1Qch
         A19qkKZh5/v/P82qv4AwDId1VFaITh3/UmBJckfPfx/T2/vXestDLyg9fdcIjsshjqOF
         CdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764771; x=1786369571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFLLowd+OV3t61SPjHw+s1uSeKRn83nLQOLuHiouvho=;
        b=apddg38ORJ4mTaveNC23awaQNnl2mLGOKvM2CukquabQCv+YcSJJBELVkDgTbyhvgd
         UDlbEzMxzt23SoZj9ume3sUFmOeDEMx1zqrLM78EIaJs00+eHCony6CLrCVLmgktoSGm
         8Y+tL3/GPuNqq1k1Rf/rzGtK9PwqEm6+VJ8dF1csBOQN2ewdTlQq6nXDAPC3x+FKYXI5
         p095uJwrY8mhT6MGvdulRaLW4cUXImpFzJg8lXJXj6WUwRvhCnvmrrn8m2pL/AOVpHLD
         EV1Cxpx1BNQXHZ2b+Z183f8znIj0B6caZ62Qqc5UC5Cyd7LzbzOtbWxSURuq3+uvY1bz
         uXFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoN68UBQ593J/T0kqvJWl9R1cH8k6ZczqOyUTwBicJyNRHfMr1NOb8nx2fu7KgQAp7gx6TCWBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQak1J09df7BVN9wcTEenIxyAgFig4VIHkjXMcucRxGoHK+M2N
	KncAqQKSt93D4oYkgWC2tUbtFyKY7KGDsi0JdSkVICpEcQ8U7L8gg6CPHSdNmBOTQYwqIWG5U65
	0Y+X9eMmyy58zYk2CtMHZXggfu3i8fR0=
X-Gm-Gg: AR+sD10G0V0N/erpPC5/lrRUqqH5cieDIv3llqu4VDxL5YD5ansCJE9+bTshxljE2s3
	5Y/VaQbxy65W6OVOa+HfoZjddIVHRuz+lNkt5pTQommi0Sg7h6+OEuK4H+F8zA9EC04bccNC1xn
	9TsKG6a9u8K9Gu+9Ccur/+0Wg7jPaD0dqgf/29PI6oFvz0aGrLmqN8ITL69QyeeXJ15Gy3EjmO2
	xu5q5bvv6jsN23X0L/MyH7A9RLpDsw8zrA9Ku8xmeLs3mb5HjVlQssisy0spAUQkLkKf5nKiYvX
	L4CAGhIJLiQq4rPfR7vWf/cYPQVcAr55HHo07cRGV6Y+frXQXLd1NIIr
X-Received: by 2002:a05:690c:6e0e:b0:81d:489e:8847 with SMTP id
 00721157ae682-81fd49c716cmr144522987b3.2.1785764770880; Mon, 03 Aug 2026
 06:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803112218.3361213-2-dingning04@gmail.com> <a66afeeafca30042408238757e166de2d5ed5bc93a4098e0d57627c63ed7efb2@mail.kernel.org>
In-Reply-To: <a66afeeafca30042408238757e166de2d5ed5bc93a4098e0d57627c63ed7efb2@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 3 Aug 2026 06:45:59 -0700
X-Gm-Features: AUfX_mygFOBvWcZJpU-pd4J_Eq18s-OyZUvHm9LKyyCuB02wT2BpWLcTbEZuahI
Message-ID: <CAMB2axObnCmR91CTZjf8egdskM-DGVqaArK5n+YYmACUfSOOAA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/4] bpf: Keep refcount_acquire nullable for
 borrowed RCU kptrs
To: bot+bpf-ci@kernel.org
Cc: dingning04@gmail.com, bpf@vger.kernel.org, memxor@gmail.com, 
	greg@kroah.com, stable@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, davemarchevsky@fb.com, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:14=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
> >
> > The verifier can mistake an RCU-loaded map kptr for an owned reference =
and
> > assume bpf_refcount_acquire() cannot return NULL. The kfunc uses
> > refcount_inc_not_zero(), so it can return NULL after the last reference=
 is
> > dropped. Passing that unchecked result to bpf_obj_drop() can crash the
> > kernel.
> >
> > Only treat the argument as owned when the verifier tracks an acquired
> > reference for it. Borrowed pointers remain nullable, while owned pointe=
rs
> > keep the existing behavior.
> >
> > Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node=
 as non-owning ref")

^^^ The fix tag is correct.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> Does this Fixes tag point to the right commit?
>
> Looking at the code change, the fix adds && reg_is_referenced(env, reg)
> to an existing condition that checks !type_is_non_owning_ref(reg->type).
> The problem being fixed is that the verifier incorrectly assumes pointers
> that are not non-owning refs must be owning refs, which fails to account
> for borrowed RCU pointers.
>
> The commit 1b12171533a9 added logic to mark certain pointers as
> non-owning refs, but the bug appears to originate from commit
> 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-owning
> refs"), which introduced the logic:
>
>   if (!type_is_non_owning_ref(reg->type))
>       meta->arg_owning_ref =3D true;
>
> That commit incorrectly assumed pointers that are not non-owning refs
> must be owning refs, missing the case of borrowed RCU pointers which are
> neither. The current fix addresses this by verifying the verifier tracks
> an acquired reference before treating the pointer as owned.
>
> Should the Fixes tag be:
>
>   Fixes: 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-o=
wning refs")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/308109=
49269
