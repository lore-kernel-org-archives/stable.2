Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792544279;
	b=tpKZPfzioyzYwIhTuhqPv1Uq7dazdmc31LjXERAwP+QVnVjwpctdLEX5ryE9S2maTOD1
	 EDJi1SEHJ/Eh8u1JZDduXmCcBZv6XJ9o42Gpq99DAzYMlMIHe+m4t8JNUMAAIwiggwwwH
	 1PIYeo+JmH0pHuAmpveRJT6wZHUwXtsOockPJA9AR39tqgl9b2IYQtpGP6H89FkBnfNgM
	 ka5ZN7wg+Q8Gz/Fn5+3LRR4Vd9QjfH8Uy0KRQaA0LUOm1K4sNlcn12coYYLY88hybV8sO
	 lJLhzFDhVHnKdnlWPnetBxM82oK8j04dhPyNm/NavnvIJwIUIr2u9sAadCfCk2o2gxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
	b=2JXajgVxstIJOGenA/mVJJYliqr6G7wgAUDjFsR4wD3EdKQ8RumF9qe1rnGcUm7Z30Fu
	 pj7IVl6XLKFJm3fBaxk3Bme8FU79I8W3Ay4ZSRPq7xE++ep12XnLdPvmmTWQMiBRuP0wy
	 C89MI/SkLS3nri63r4ndKF/MbPD13Qw8/lBV53J6Rl2goS4iD/ydERmCBeRRzX57MtaZ6
	 /ppYjENbtvF3YEUGT5oD5qHg0mKw0jXam+cjcZP8X2K+YSQOn1l/AR5iy7TPIrHdw2uOZ
	 g5Id8ULlawJYSmt8Hyhq94fH8CYwhHHrYaRo58Gf9IFX3aRr1IWJ0k11YygVuPn8huA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ruMg7oBd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A2C606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ruMg7oBd
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48db76d98a1so82308f8f.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792544276; cv=none;
        d=google.com; s=arc-20260327;
        b=k4KrjR7il8UeREw8P+w8U7/cDy3KLCD2ykXrW/u4Ie1X7WOSzFiP/fEYmiLOY+wNsQ
         ZvAg2iWxVpNPa8Tz4rpLOdmoZnoQDVRu2EI3sEfHeRSA1x2xFo2jDzcCJxFG7eh1gSFH
         wbHY7uj0T8Xr6cs2Cr8Is7xDjAGM/ltmOZMWdlp+bgN9Y3uoo0yM897E6hKwS78ByMdX
         LlWa/FMVVnTxCHaW+q2IyU82zUdOWYNCQja7XHqPJ1ZyTE1Vd2p4fGs5kRlEFRPJTJ3W
         plBYASsdocVzT1oVGSZuVCmmr6/WGBso9pBp+h1EtNvbkPQlbYv+u1itk1euF0iqdCKY
         hM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
        fh=PfOSUI07e8iw74RSMCoEio25+rcvpkUFIe5Zn33G2jk=;
        b=TOSSknTNomYOPfD7Ospf4jgZmdcMJYnqlXFGEQHD72g1nYRSAyryPAbuorO3tCxlAj
         bAEGWC2hvZ6KZgx1wQa2h+sjkbgTzXeGE98PN+oMlLK2LJ+nJmJpvDGkkRf6QDQVj9bB
         4TPUfO4YHz+TchPeg965nWeiEOMEQDLb6fujMfDttqln35foO2OUJcstCHwbaY6d8h+x
         /ZIID28GeFqlqF5M8E5rYx/vK5WcC6576udYnvStOko3/z+86uBYIUhKcynt1wgqoiGy
         SF9y5tSsb1fHce6VPqwaS120Xfs9XP0d/8rmBehoiPVaT5KoqiP19Nk7sQaCgaBQ/3Jr
         LQmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544276; x=1793149076; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
        b=ruMg7oBd+QKJNGrS4eRdzeKTniD9dJVtBuaItZbF4rUuFEoXrxGAjtnHWFCXLsjoju
         OT2skSftBX37yM9TdWsJw9WGoa65S0wVXYSSuYdh4+dTT1dL371QxzxmlXEzMjEDOPk2
         bUtKsui6j1UiOk7pfbCNC87LL3P5rv0H6R5aGLFn29/DlKaTcgUTIC5FbwBwWNjjPk/Y
         VSLwaxHPTfQ1HI/uJHVSSFUETRCwRb5DK+A1ipKrxoHjIpTtGgrUKy4b3+JMUou2oxmJ
         CpXUtlOf5ohsuRqUHfnu0LorA4+pKYTVI1Q8qpLwG8szRs9E+q2P9d6YGURiJCbRvCFd
         BYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544276; x=1793149076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
        b=K2+OJJGJ+gXhMlgIwExRyS4uihlVcXytZoo8U4mxqyXKn67/1GW3mJ4ADY+rRYKqUe
         v5g1Gy9ZuvEu5g7SrPa8UFRNscKqdMMEsYat9vCASzZYmP+QStL52o2xtSjkCJB0QUzt
         pDo5u1he34Pb8Nr55le8VANvzk3jskzeh+WJMSy7lQP9yLnONLUf0IeNnWxBW1WTtgTE
         KE3O7Brn8u+3oMsx+Wgg1/KX+/FyJyo6Zy0L3C//96oNEbwGKkV5TAsDxY0jt3/r3UQL
         5etfiecI98x9TKI3BVyCEGE78ghNUJwvtAxfK156Dnb46R3w+ZHFY2+dZYtEjNY5NvUl
         omfQ==
X-Forwarded-Encrypted: i=1; AKwUvByBh7vxt6NO8Aq0nA0pysT7c5oY4X+2FHcUrfk7TjoTyEwEGmNSmwVdu2EKsWS8t040pwSIEpc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEkL3C96Xdmbv5UP8a5ov+xdM/c5sW8fXf17r6yJpyoqmAERPR
	hbETcwS3cAVLUBHJR56kLyRGvQ3eAaFAD9Xr7oatVDRj+9uOlQrIk5T4oJtjwDxJt2CdaqGKWi7
	tRZ6AI8Fl1LGzsdBDWbrZDFsZHa+PNro=
X-Gm-Gg: AYBFou1ZBzpGrJg6wXCWv11VU/VH9kRMEAjVgIF6o5UELEBxOFPLN/RfCjXsrirMf7S
	3YDUuxJi5yQu7f8knTz1HR1x50i3xwkWRuUtx94h+auXrL7s+BT0rof04LcpBEKjQiQuShDl7+X
	M2RP+tCqfnuGlX9kvWuBNLGRqkzkL9n5aVmlsGqprMG1szBIfNKrHP6DN9PzEbs8qD2f3UWjvu6
	sg3StKwox8T8AXAoL9Nua5FKRf5+iIy41uXYdq/NQ3YS8/KLHH7AefveodQN6WwEjk2/q8XtFu7
	Bjj89vyvUzfwW0/R7DUe7Mfi5WYZgKmCjKENmO0GWgvoIPURL2Jf6H3iL7WxISiKI6aPLo6ABBo
	uzq4nynSoLJwIUknNTDuIyKVTGoLtOYYo5g/3uXnFwAFizSYZ4WqIftdQNpVJppjYFJaonsqRRh
	FKPqOCVOw1EV7yowupQTIOaWeDDEIGsQNhDOfXUIDys6aDG/gOZtNUigCnhwbKfXHxtVtcyAUyn
	pA/ghM7TH/Y5ek=
X-Received: by 2002:a05:600c:5252:b0:4a1:9661:14b7 with SMTP id
 5b1f17b1804b1-4a1fdd641ccmr6945075e9.32.1792544276298; Tue, 20 Oct 2026
 17:57:56 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020145059.2146170-1-utilityemal77@gmail.com> <20261020145059.2146170-6-utilityemal77@gmail.com>
In-Reply-To: <20261020145059.2146170-6-utilityemal77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 21 Oct 2026 02:57:18 +0200
X-Gm-Features: AclHuK8Qw2bebhlFOxjthcAlLXFgpCgvnWRDwHYFLx-O3tPMva1ZTXx8_Gt9sHo
Message-ID: <CAP01T75VJXS6EnYbMguicH9vDbeYxzkAJMEYiBYZ5Cv8mkDJ=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: Bind iterator elements to their iterator
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 16:56, Justin Suess <utilityemal77@gmail.com> wrote:
>
> An element returned by an iterator's next() kfunc is kept alive by the
> iterator alone. bpf_iter_task_vma_next() returns a snapshot that lives
> in the iterator's own allocation and holds the vma's vm_file reference
> only until the next step or destroy; bpf_iter_kmem_cache_next() and
> bpf_iter_dmabuf_next() hand out objects whose reference the iterator
> drops the same way. The verifier marks every such element PTR_TRUSTED
> with nothing tying it to the iterator, so a pointer saved across
> bpf_iter_<type>_destroy() stays fully trusted after the memory or the
> reference behind it is gone:
>
>         bpf_iter_task_vma_new(&it, task, 0);
>         vma = bpf_iter_task_vma_next(&it);
>         file = vma->vm_file;                    /* __safe_trusted_or_null */
>         bpf_iter_task_vma_destroy(&it);         /* frees snapshot, fput() */
>         start = vma->vm_start;                  /* vma, file still trusted */
>
> Set the element's parent_id to the iterator's reference id, as is
> already done for the PTR_TO_MEM elements of bpf_iter_num_next(), so
> that destroying the iterator invalidates the element together with
> every trusted field acquired from it. Elements of an RCU-protected
> iterator keep MEM_RCU and stay bounded by the critical section instead:
> they point at RCU-managed objects rather than iterator state.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---

I would drop this one. Xu is trying to fix it here, which is probably
the more proper fix:
https://lore.kernel.org/bpf/20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn
