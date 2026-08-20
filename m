Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4547D95F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244148; cv=pass; b=Oco/KNIIBXBN+N25wHC/4LvP0RoSrcfvqUicQc0MzgsaWctJkwLwYvf7F24oP7Ar0DdxBf91Yp3I2Myasf/ALeuteRZOPrvpjux4Ck6C0VlfDjLHfgQYFM/dbmcOt+YUPHNazMmntIxMg6Z8QYnXdGb79eJKXX5OztWbKRYg8KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244148; c=relaxed/simple;
	bh=IDBX8VXLQ9hx2WC8woOhAZSlbEQbCQWrld8aiY2TGYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHP6SJEak32IQ/7TJzcLirx6OC7/kKRYBz4ClfWnYILWlGKE4Fz/ySqTB8+nwIL4ieVeIGL5MGB1QLQvH/mEQwHiAwEoXfxo0Kyc9ybg/MKCu5X7/TfIZfcsEu+vKoNLJnwVGkgYRJwEfpvEyn+1wJf0NEHEGPe0DV9om6mBPuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Z7vboocO; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Z7vboocO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84864086bfeso6577b3a.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244146; cv=none;
        d=google.com; s=arc-20260327;
        b=kEnRGjegCt0lXWaZ+v+BdhFVs7cC240OlnnjxU4ZjgrZmtYTNhDlqifd9oz+jVhjrD
         VbkuGtTQUrkTq/c3JXw7CXW71Vd4Kdn3T+BXO+V7Ni8aM3xotAN33xixqXjLFC6LeIwI
         siPNAwilql7lBzRdblZWmG5syooHSU2ecbRSh02E4ACeqZkHxd5abir46y3AWVo355jj
         HwumujRyNrBxDs6Y2iZ+2uPsHqg3uwN/ORmJVT1Wv0snMUo5Syc8wpq9RZCtOnNxcRpv
         tfa7jGoeXe1hXp9nNWwQ5VCcpZyB0vh+yqH1a3NZs7aLofzq+p9g8Oj5bwVSx/TheAlF
         LjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2yiP+LhZhC/qZnEWNXj41fXpS/L9buScLyFoFglz2o=;
        fh=oa9PKHMrnX72pT4cacHT0/PlTTwXyDDFBKyPFP76/7w=;
        b=Dkb1QxL5AK20ehsBWGkQBm+Gm51mMAiu8q/QOxjeUvUzVmkCQv8qSW7H3sURRvPSa6
         633OTpFj6LAbMgzdzlCFTTf5oLdz9xj6/QiFtb/nvQ+sePwMGSZEnPZU1IGyRkOv+MWh
         Zrc7t9f55sQAcZ3DD3JjY7f8E8L2gCUIm4rucZYZcie+UvWPPnDxyXAAcnaZwuqZRayq
         J8vv8Li5ttcWATax/T9J28pjkL+k8LRvwsK3rZUp56OtFRriMO/+ZTzuN3Np/D3Xcdur
         NluouYznN2gWiyIErW2FhMdca5CudYOSrzkvR94QVA/eKbF+ATMnRJmnLqYEYTXI9O/+
         EHDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787244146; x=1787848946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2yiP+LhZhC/qZnEWNXj41fXpS/L9buScLyFoFglz2o=;
        b=Z7vboocOBuJHP/N28j13IKnXK1QJUSsVZWZADKbDIhcl28w3ixc09A+iQmLB6y4RF0
         pIbUx1kUyN9umAoUWWXLsybYAM5+65N449BnACPx4gMAhSwySW7EGw6s3Mvubx+axIdY
         A7k0FsZgQgMh0JAofd80VyLEPlxi2l57N5doA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244146; x=1787848946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2yiP+LhZhC/qZnEWNXj41fXpS/L9buScLyFoFglz2o=;
        b=O+Ul4dElXSCu477ePPUK65K0zv6Mpu/dG8YKMNxyMmv8tz4ri/py5lCR65eRuv7Jcf
         r1++oZQGvGXRC5ybNsNaObkRmiQKFWhxGbYsBIE+jDDVOXK1uRHMR9t8x/J6b40bdojg
         sl0lG5oy7pqyYjHji521SNKSEil6EQdHCTBuWN1KWy+i2wKYhcXi6mbVysFWKEI+zu0i
         qAVAkG8z+U5G2Ae3eP2jTYI2Lhn8qlh4QwG9Rso3F82OslDFTbRhNxF84m0+OXYpMyMK
         T6epr9cv6KiczV54bYOoi0gsY65CH2+j7uKoBQsuVvLQq2QrVnfWw8kuEAKyZs+3fdLZ
         QAtA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3ZT2pZHfC96WmMuc/3G1Tdf68N8kb980jVNh6l3Hiso56tLhG5fHahNq0Ge7viwMpKijQ/oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMuXrqLrhmS15k242flHaKOHs/cphB+lNYowatOUb3UIdCa3K
	/ZpayF43Gen8FrxhR/+9XBoUPP5gVlVBu1nRmaDZ4/o9I0wsxMeLFV3zmLAct0cPxmgXTnXaWv9
	9EbEhlvjoE8X+Z7A7Cx8vacIl1s7LDG11wHg8xJSz
X-Gm-Gg: AR+sD12cn5vX3sEeiOlr7wyGoVIbD3mSF7PT+jZ57wDnIuHZIerLD56SzfgnxBATbOr
	gmfB/ZsRhnKwfI4je9FiIleobCnSIUyg1t+kXkuB2gQWMJ81b0RBxn8O6A95Zx2ULz5LYUsstzD
	rgt6F4v9TeSrQLE0CZzVuS581czwhXYk8ZJa53ZT5f/pKYOZWXtl+0whjhhzhuu/1geEPUiXf6o
	b9UZi3T4gyCAIukjhH+udXiSJdAs++75IKLSR6R3fZLbtWIyyzx35D1fGGj9j0kts7j2/IMcLqw
	NOEHnNh1So4htR+alL0N5vzPTS1u3v1UQmhguS0ZzA==
X-Received: by 2002:a05:6a00:848:b0:84a:2c46:3fdb with SMTP id
 d2e1a72fcca58-851d3862b92mr23921664b3a.5.1787244146053; Thu, 20 Aug 2026
 09:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095236.68390-1-jhs@mojatatu.com> <20260820095236.68390-2-jhs@mojatatu.com>
In-Reply-To: <20260820095236.68390-2-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 12:42:14 -0400
X-Gm-Features: AcwNN1U6Kw-V4I0kWZuvf6ET2mei_Yx6Hn09_R_W7mFlT7Gfj3HR77holbziYwY
Message-ID: <CAM0EoMkRjG0-ssck6b39JA_439U3N=s3nEt3Av1PVZzvcA_E1w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: tc-testing: add u32 node ID pool
 exhaustion test
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:52=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Add a tdc test case (7ec8) that fills the u32 node ID space with 4095
> auto-generated handles, then attempts to add a 4096th. On the fixed
> kernel the 4096th filter is rejected with ENOSPC (exit 2). On the
> unfixed kernel it silently succeeds with a duplicate handle.
>
> Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles"=
)
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  .../tc-testing/tc-tests/filters/u32.json      | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json=
 b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index b2ca9d4e991b..b9019b14d05c 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -353,5 +353,28 @@
>          "teardown": [
>              "$TC qdisc del dev $DEV1 parent root drr"
>          ]
> +    },
> +    {
> +        "id": "7ec8",
> +        "name": "Add u32 filter when node ID pool is exhausted (4096th f=
ilter rejected)",
> +        "category": [
> +            "filter",
> +            "u32"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc add dev $DUMMY clsact",
> +            "yes 'filter add dev $DUMMY ingress prio 1 protocol ip u32 m=
atch u8 0 0 at 0' | head -n 4095 | $TC -b -"
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DUMMY ingress prio 1 protoc=
ol ip u32 match u8 0 0 at 0",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC filter show dev $DUMMY ingress",
> +        "matchPattern": "pref 1 u32",
> +        "matchCount": "4095",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY clsact"
> +        ]
>      }
>  ]
> --
> 2.43.0

Some of our long running tests have failed because primarily of the
tdc test in this set. Will resend with a renewed tdc test. Hopefully
my attempt at this pw-bot thing works.

--
pw-bot: cr
