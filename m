Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F03F823D
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948787; cv=none; b=n8GpA29FNXjwFexc2eyQ5tOy+tgs6vp0q5mhwbZbtzCRb70P2oWHoVn8Zf/1gxZm+os8jboZ6s3ar6sX2PVILJ/V8t0wTenb6WY7EolKnnqm1dPQP0i/fg124VkXnOf+/RUG/kzKIomTXHO2weqELyxvU04NIi7WITnmLS1Igls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948787; c=relaxed/simple;
	bh=pP5wAIxFb4TuDtHklK7t2r96/cLDYX9cu/5cAeBOiYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPyJ1kXK26OHMOF572aSRigGSdIs+2CfeKRjiAhFnFtRWZsNgrVN89xjzDQqXCldC26kpYXhj+UUingSEGB4KZTpgr+LxFZtkGHTmrIL8NtTzcIrM/QOqjCYdwu+m2VPq3ha9UMHSHF0+S2xiqv8vjw42p3zerqT0rJ+tZuNnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC+LaQmu; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC+LaQmu"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3042a388168so2544441eec.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948785; x=1781553585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lynx5jaczBFbCjQaOB4+zPyp2PFUK+IBKvmn6JxbYEw=;
        b=CC+LaQmu3MW5Wn7djRCmADI53v84eWcHbQjPX2mKASABuw1MqwaP6SGKzQdJAMTW7Q
         Qa6+7WyiB3aiEOXpS2pbNwREEQCrvsQqVD0EekfqXk16p9mh7KyCy3JaK/qA/Rmw+5GX
         k6kk2t4TKWeX2DuaPtX662SgXeSqfVanO1ZriQhkwxz5FkI/jtaQXA/vu+5TuKMpRhC2
         8V3DdUPl8Wxl4xz/tduqu+oxL3vG1KVqjwVzZC4NUBWzYrblQLkPrLkQSMJcwHmqYr07
         w6ns+wOe/MmCeC4J+TD+nBYa7UNdUmIzQLDC0ibkeXHrfb6UyIkQ8slW4m/guDw0cn9+
         re7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948785; x=1781553585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lynx5jaczBFbCjQaOB4+zPyp2PFUK+IBKvmn6JxbYEw=;
        b=IVAppTtwfawm2qNvnvagzImNYQmZY22HV1y4Gofdsf2ByQZAW8CpmURwWLxsI55wwo
         kZw/WpfHObSBtdv0RmWIF0XFa3Ql/Xf0wCDSf2pzARF4ieQocSy5qDWkdKTh7Gbfbu0M
         PqqCrhCWaVjEoyt0my80BgaOxMxMdNhrQWTKwS6BMaiuPzjhRqQOeTICm1koabilIdY9
         qHyrFAGD0p4zont7/i+iuzFYSk1ivvf5vsHp1YXiQDwQ5cRIiD96LohxnmuNSAD8n1Me
         KpJ6lkQG35514b4ZVV6adrI7TC6HrrJONtk2/nsBzC6+mSs6+eb9N+cNg088/nJ7tXFM
         U8KA==
X-Forwarded-Encrypted: i=1; AFNElJ/WyXmo4jsKl9hCfwvlOidbsvijNQnFcuYlD7NLwv38E74gvsve5oAKlZpOiQ2mlQZpXkhAQsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VuKKXAA+B5vwW5jelDj0UTV5749IwvCGpv9T08p8Lw5jNWu2
	nREJ6ZyU3kLgMoPZu2D6ntGvBcOPQwjyCwF8F2fyp1eeyI/FO3HyYrDZ
X-Gm-Gg: Acq92OH/N3bzGAsHxIkXOEGmy15bFAYJ5uA/D4si2yB4Yj9/04M2flE1GjRRIaoq6jo
	SspHLnMQFJdE2J8YJMAiBIk8GgSghA5ex3BSCNiyPxqHDuTgRU7E2vzPJmADVGhbcRg56sRCCtr
	qhlZ3qPq3UGPfnTQhQkvNUZHY7qgEhnihId4Vrk3NFuavw9qaT/jRUOMgnrNOcHJjic7UFATNwq
	0G67hvzCodQluWyTfJ1FqMEkoRq6MkaaMhGSgcgDVfvBPXxM5NMOWe9gOyKkhmz4gB/Pz2WJTID
	O5SK7HjAR3H7PE68WVwY0+dppym1ajjyHtHuND0vNtD4ptJykxECf6acaK0GAQ4l6B0r5lICnwZ
	icTWT6jGgFHZOsXMvZ2Brg/a2caP+sCXCHPvGRCudkK1D0IqpGcfs3g+1dNhCstoBU36DKaqUet
	cuM1ZcYh9OPYzB5SKW/1yjIUKLl6qglopqQ93nWikOb4rDRwEeUQc2smCkQV41s1StuxuqX0lzV
	4boZ6AiWlcfOEMj
X-Received: by 2002:a05:693c:3618:b0:2da:13c6:f27b with SMTP id 5a478bee46e88-3077fde276dmr6656296eec.5.1780948784960;
        Mon, 08 Jun 2026 12:59:44 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1875:35fb:3a7:e87f? ([2620:10d:c090:500::3:d25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm25741417eec.11.2026.06.08.12.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:59:44 -0700 (PDT)
Message-ID: <d7ccd692ea8c6009785ad141e6ae4bbc68347517.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Moses <p@1g4.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	bpf@vger.kernel.org, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, 	houtao1@huawei.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 08 Jun 2026 12:59:41 -0700
In-Reply-To: <0_PQcsqBnb7dqgu9UPK6jIQvePSosttml5p2ZDoXAzy2AseVjvBu3ihswwZPWr5bZkOUCdH6HUvw3MRKJEwVYJAkT3j5gdNBHZp8l7_cP6Y=@1g4.org>
References: <20260605234301.1109063-1-p@1g4.org>
	 <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
	 <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>
	 <DJ2RQ5NHDCZT.2R218ZSS80NQ4@gmail.com>
	 <0_PQcsqBnb7dqgu9UPK6jIQvePSosttml5p2ZDoXAzy2AseVjvBu3ihswwZPWr5bZkOUCdH6HUvw3MRKJEwVYJAkT3j5gdNBHZp8l7_cP6Y=@1g4.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-06-07 at 17:53 +0000, Paul Moses wrote:

[...]

The repro is legit.
Here is a somewhat minimized version as a selftest:

    diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testi=
ng/selftests/bpf/prog_tests/btf.c
    index a9de328a8697..212ca4472a89 100644
    --- a/tools/testing/selftests/bpf/prog_tests/btf.c
    +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
    @@ -4258,6 +4258,44 @@ static struct btf_raw_test raw_tests[] =3D {
            .max_entries =3D 1,
     },
   =20
    +{
    +#define N 0x1999999aU
    +       .descr =3D "repeat fields overflow",
    +       .raw_types =3D {
    +               /* int */                                              =
 /* [1] */
    +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
    +               /* struct target {} */                                 =
 /* [2] */
    +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0,=
 0), 1),
    +               /* type_tag "kptr_untrusted" -> target */              =
 /* [3] */
    +               BTF_TYPE_TAG_ENC(NAME_TBD, 2),
    +               /* target * (kptr) */                                  =
 /* [4] */
    +               BTF_PTR_ENC(3),
    +               /* struct outer { target *kp; elem items[N]; } */      =
 /* [5] */
    +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0,=
 2), (N * 8u + 8u)),
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* kp          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 6, 64),        /* items       =
 */
    +               /* elem[N] */                                   /* [6] =
*/
    +               BTF_TYPE_ARRAY_ENC(7, 1, N),
    +               /* struct elem { target *f0..f9; } */                  =
 /* [7] */
    +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0,=
 10), 8),
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f0          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f1          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f2          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f3          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f4          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f5          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f6          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f7          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f8          =
 */
    +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f9          =
 */
    +               BTF_END_RAW,
    +       },
    +       BTF_STR_SEC("\0target\0kptr_untrusted\0outer\0kp\0items\0elem"
    +                   "\0f0\0f1\0f2\0f3\0f4\0f5\0f6\0f7\0f8\0f9"),
    +       .btf_load_err =3D true,
    +#undef N
    +},
    +
     }; /* struct btf_raw_test raw_tests[] */
   =20
     static const char *get_next_str(const char *start, const char *end)

However, as far as I understand the repro hits an overflow only
because `BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 10), 8)`
lies about `struct elem` size. It is specified as 8, while in reality it is=
 80.
The size of 80 would make `struct outer` unrepresentable in BTF,
because (N * 80 + 8) exceeds u32 range, and that's what btf_type->size uses=
.
Given that btf_repeat_fields() only traverses structs/arrays but not unions=
,
I suspect that overflow won't happen in `field_cnt * (repeat_cnt + 1)`
if proper size checks were implemented in btf_struct_check_meta() / btf_str=
uct_resolve().
Even more, If I change "kptr_untrusted" to "kptr_untrusted11" to avoid fiel=
ds parsing,
the kernel accepts the bogus BTF.

Paul, could you please investigate why is this happening?
