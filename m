Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D83115A5;
	Tue,  9 Jun 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968646; cv=none; b=eJS/+BA4qh2yr8K2nnw8gLAAJIB+b9qmAUmWhTHCoKIMu0/xftDeaS0BcLNbAxE05irSPpLKwT8sc/PKCLh7AiKX7lJtBQmscATLtQGDXVa30MNbRZMfDsbwu9IC7/xkWRcax/6jRIQXf9pViIajeWIU+gCJKlUSCMqUZxUT/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968646; c=relaxed/simple;
	bh=wbBkMfNzgrpdw/AQgcjPP5Qj1kkdSNWHGzysULcHpco=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gu0wcr+SHwSXpH9o9WJe5R+qwfqUOVi5xeJ2EFg99bayP1Db6qqhDYSFaVF6SWkGJVyXOVLoQF6YI29Yqa9LioQX4YUlbLZc7tqqFED273UHvW9AMn5MlaJKACZImS5txCeu/qEWpPa1gB7IOjy9Uq+U1uxryz38ThjzQruoW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GXHK18xP; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GXHK18xP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PE7SL/rp0gOOvRnYwk24N7Jwk/rjpDxGlneTY/S2ePs=;
	b=GXHK18xPIo6UAyvaNbYue7chNh+G1m83OPO29zHBSk24lYO/83w3wP9wpyOVwyx8Q5YzjHNUR
	5eYTruuQOt8dZP8Ls3oh1Z2eHBi1qaLwiPSoRQEGAq8iJKmIETZZEHdV+AZTQfUAReDL8Gi6mK1
	hINfKXA0QtOWZBwdkDjAWdo=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gZB3q23nrzLlW4;
	Tue,  9 Jun 2026 09:22:47 +0800 (CST)
Received: from dggpemf100012.china.huawei.com (unknown [7.185.36.196])
	by mail.maildlp.com (Postfix) with ESMTPS id 5215B40562;
	Tue,  9 Jun 2026 09:30:40 +0800 (CST)
Received: from [10.174.176.103] (10.174.176.103) by
 dggpemf100012.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 09:30:39 +0800
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
To: Eduard Zingerman <eddyz87@gmail.com>, Paul Moses <p@1g4.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
CC: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <bpf@vger.kernel.org>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260605234301.1109063-1-p@1g4.org>
 <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
 <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>
 <DJ2RQ5NHDCZT.2R218ZSS80NQ4@gmail.com>
 <0_PQcsqBnb7dqgu9UPK6jIQvePSosttml5p2ZDoXAzy2AseVjvBu3ihswwZPWr5bZkOUCdH6HUvw3MRKJEwVYJAkT3j5gdNBHZp8l7_cP6Y=@1g4.org>
 <d7ccd692ea8c6009785ad141e6ae4bbc68347517.camel@gmail.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <83321d7b-516c-f4a0-65ea-6fd224ba3110@huawei.com>
Date: Tue, 9 Jun 2026 09:30:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d7ccd692ea8c6009785ad141e6ae4bbc68347517.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100012.china.huawei.com (7.185.36.196)

Hi,

On 6/9/2026 3:59 AM, Eduard Zingerman wrote:
> On Sun, 2026-06-07 at 17:53 +0000, Paul Moses wrote:
>
> [...]
>
> The repro is legit.
> Here is a somewhat minimized version as a selftest:
>
>     diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
>     index a9de328a8697..212ca4472a89 100644
>     --- a/tools/testing/selftests/bpf/prog_tests/btf.c
>     +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
>     @@ -4258,6 +4258,44 @@ static struct btf_raw_test raw_tests[] = {
>             .max_entries = 1,
>      },
>     
>     +{
>     +#define N 0x1999999aU
>     +       .descr = "repeat fields overflow",
>     +       .raw_types = {
>     +               /* int */                                               /* [1] */
>     +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
>     +               /* struct target {} */                                  /* [2] */
>     +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0), 1),
>     +               /* type_tag "kptr_untrusted" -> target */               /* [3] */
>     +               BTF_TYPE_TAG_ENC(NAME_TBD, 2),
>     +               /* target * (kptr) */                                   /* [4] */
>     +               BTF_PTR_ENC(3),
>     +               /* struct outer { target *kp; elem items[N]; } */       /* [5] */
>     +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), (N * 8u + 8u)),
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* kp           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 6, 64),        /* items        */
>     +               /* elem[N] */                                   /* [6] */
>     +               BTF_TYPE_ARRAY_ENC(7, 1, N),
>     +               /* struct elem { target *f0..f9; } */                   /* [7] */
>     +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 10), 8),
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f0           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f1           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f2           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f3           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f4           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f5           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f6           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f7           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f8           */
>     +               BTF_MEMBER_ENC(NAME_TBD, 4, 0),         /* f9           */
>     +               BTF_END_RAW,
>     +       },
>     +       BTF_STR_SEC("\0target\0kptr_untrusted\0outer\0kp\0items\0elem"
>     +                   "\0f0\0f1\0f2\0f3\0f4\0f5\0f6\0f7\0f8\0f9"),
>     +       .btf_load_err = true,
>     +#undef N
>     +},
>     +
>      }; /* struct btf_raw_test raw_tests[] */
>     
>      static const char *get_next_str(const char *start, const char *end)
>
> However, as far as I understand the repro hits an overflow only
> because `BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 10), 8)`
> lies about `struct elem` size. It is specified as 8, while in reality it is 80.

No exactly. Every field in the struct elem has the same offset (0), so
the size of struct elem is correct, but the field definition of struct
elem is incorrect.
> The size of 80 would make `struct outer` unrepresentable in BTF,
> because (N * 80 + 8) exceeds u32 range, and that's what btf_type->size uses.
> Given that btf_repeat_fields() only traverses structs/arrays but not unions,
> I suspect that overflow won't happen in `field_cnt * (repeat_cnt + 1)`
> if proper size checks were implemented in btf_struct_check_meta() / btf_struct_resolve().
> Even more, If I change "kptr_untrusted" to "kptr_untrusted11" to avoid fields parsing,
> the kernel accepts the bogus BTF.

btf_struct_check_meta has checked the validity of field offset. However
it seems the checking is loose:

                /*
                 * ">" instead of ">=" because the last member could be
                 * "char a[0];"
                 */
                if (last_offset > offset) {
                        btf_verifier_log_member(env, t, member,
                                                "Invalid member
bits_offset");
                        return -EINVAL;
                }

For struct elem, all fields have the offset 0, so the offset checking is
passed. From the code snippet above, it seems BTF tries to support the
following struct definition below, is it OK to only support the last
zero-sized field in struct definition ?

struct elem {
    int a;
    char b[0];
    int c;
    char d[0];
}


>
> Paul, could you please investigate why is this happening?
> .

