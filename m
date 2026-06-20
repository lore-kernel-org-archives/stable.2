Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6331C5F13
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962582; cv=pass; b=GBOBQ0SuluFDzugUds8m2IwtHsrdr3Ur81qyDfyO+55sEWPoQpFN+ntZTBpcvi9aBi+ptCCvmB2h/4OzG3zD8+xpAJ1o60WYG73yAmMy/ZDaT0oqSj+v/8GKDAkWFJRPWfKkMw3DFHGFY5qJuz03gOcHiP/8UxPNX+Up6yqJOLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962582; c=relaxed/simple;
	bh=MN1s+Z+Xu5aFRgSauLt5FFTso1rCRaYXtl0n4UoTUOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+T/W+BUVSy8FAVUkeAEtt7EbOYkgwjlPXdUG0SnrjEBdL8JE4WTwaVQRfYbI9RXdma8DjEOyXvncIEF+ErUo/v4I3tj1phvC6jUBMT+A5Q/lnBf+khTbKXz+JKGZmZlqwljWeAxfSExW2TS89avNKATUcxiksARfZeC5VL/H+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fNPo1WnB; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fNPo1WnB"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e0b3db3499so25890107b3.0
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781962579; cv=none;
        d=google.com; s=arc-20240605;
        b=gyzYrxq5Z8K+f9nYRNW3AbCF7KN087RBi3QgBCeVcIvxF6zUMC1Y8b7Pzi7gHiYjsc
         GPrVScqyjOxqx4UT7vcw8Etx3blxqvO7ZhcnekqntdX/BdWWfG3fnsKSSvz81sCITEdS
         pqz60zt4HdoJR/epy2EZ2CuPSdoDZBrMi+CwD5SmGyiGqRXjad04e616uFxP/E0Pxx6y
         vSGrkS9KHbgEXP7kEjZxi5Rl2hs/gJqKF4d0sVbLulRJdNEvwF8ZH1EQstjYfiZ/MCHR
         0keVTAxtjEX7vQhuUjIl3MCr9nAlEBERBIpGYf7TXUxcBkMMSsZTrNeBO40AamGy0Yuh
         DvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HNXxrQW8BiAnWvUn2VdMTxhLOGhlRa3nkN0KOSpPFGU=;
        fh=uR07HqeHjAhViEKtav3BYJK18vgYDtGGnnPXojlxUc8=;
        b=aMXISEUGR7sBrgkf/35LN0p9x/Mp6CWvn7DAtDgRKrUiMZq+O5Uw89OVcDV8JCHBsB
         6h9hGjP2IGYKfjTJUtSAI72M7LiB1iFXRSVrepL72Ie9CP2WTD0z/67DuEV3gmOdGGKP
         hOFZ3GYT4OQZ2d8vg2Y6ItFpPK5eE/z34eRhuE5CpX8BjVN/1x/CIx+fXhc23kPkUm8v
         GuWYmav5cBOd+6ofOdPbpa0xL1KEVW1SuBL+sKucA/i2e9IrjlDtf4tuvi2fe+7Lgmu3
         FP7ovwTBQrc2K4mF9iFJQ5w3qW5B6YR+RkIgVqYmv2v9orr+3j8UEJt+iT8/rnMECw5n
         qx+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781962579; x=1782567379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNXxrQW8BiAnWvUn2VdMTxhLOGhlRa3nkN0KOSpPFGU=;
        b=fNPo1WnBCup5r6KOJh1GMtntwUFusp2h89q84fXZcTmlQJNT5sm6bul487KtvdUbTF
         lk32LPBT4IHzIcQr6SYPEm9s3Ajn71+ZaVj57xRjzizd1CC4F6s+WIdtBEhYrNAq/HF5
         N2zKSmTt4eVkP0rm9pk4/SLZuzuIrbAmA8SM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962579; x=1782567379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNXxrQW8BiAnWvUn2VdMTxhLOGhlRa3nkN0KOSpPFGU=;
        b=QXcSPxvZADl1ES7ftdRgi6bBMfNzw/siK0TYYIAwVgs1ULui4B5ajpneQSAHv7IP/1
         m2w0pKvzBpXIV0AizopyET+bDi/zIRH13IC31mLAOYi5+w/50ilU56kQEBaFhkMaqzxh
         YwAlWfJVmIZNcsG5DgrfntMBatVv+duycAtnUBe/LYQadEybJ5pMHo5hWsVAOU1u/4d3
         8hXcQG1F8orVO+TwoxWfmdDAY0hpTMks1QUviaBoLCylPAPgBGJHIIrKNtCfjtyLNAcU
         X+WmYWIaOfcz7YNdtFdDzn1r1w1oPS9/7UGsFqm27bqu4goyEuzCqZBMYT7sAUXAAU/t
         954Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqt01uE0PZhcqY1eu4sSN44jvwoxtnI2JLdTlH92/mdrUt0gr6teJ+Hc8ceUJbH4BdQqYspBwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbwd1yS3wk4+0Az7r3WzT2STuOaddI98dPHItFahkW9VdULf7X
	qO07dAmSiks9UZGw9D1sVJfvvHB4alDf845V1Kp6CmnQFA31OhTp1/tKrGg5BZ0qrfAc8sn/zlD
	E1sVL7kURfG8/AqGbusApB4SR5weRbTBz1r1r6lF1
X-Gm-Gg: AfdE7cnX9/uuHq8sPM7Oe1OStVySeUtuquN8ABggH7cCdGlOwCpyudel27YgoZq01R0
	kr0+IP7qKcBtlfj6QFPGZBfK//EA4x8v2+AyrYPHHmAmuiO8i9d/+2UahR49UrcxU1fr5wGQgjC
	aZPJevcHIaz4nyulxsB9U8MqWpnU36GCI4zOYVFn7pIbjvoTPzoGmCyBvGVosmR8qoK5aoHqTU1
	Lu00wOSX+3DhbRSZYYgNOIUTtlPl0PhR+BiPOscB418LpOGHNOFHMCSaFkxS6ItaRYKRQ==
X-Received: by 2002:a05:690c:6609:b0:7fd:a4e0:7919 with SMTP id
 00721157ae682-8013227679dmr87522757b3.0.1781962579315; Sat, 20 Jun 2026
 06:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io> <20260619151447.223640-2-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-2-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 20 Jun 2026 09:36:07 -0400
X-Gm-Features: AVVi8CfQUoncW7_tfjZxRR2A5b-4Jex5w5efpfja42_2Wo1uObhYdqQh167V2E4
Message-ID: <CAM0EoMnfAuWc2VAHB9g6druz8hkutX7Wk9eq3hUWe+HdRNF_tA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/tc-testing: Add DualPI2 GSO backlog
 accounting test
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 11:16=E2=80=AFAM Xingquan Liu <b1n@b1n.io> wrote:
>
> Add a regression test for DualPI2 GSO backlog accounting when it is
> used as a child qdisc of QFQ.
>
> The test sends one UDP GSO datagram through a QFQ class with DualPI2 as
> the leaf qdisc. DualPI2 splits the skb into two segments. After the
> traffic drains, both QFQ and DualPI2 must report zero backlog and zero
> qlen.
>
> On kernels with the broken accounting, QFQ can keep a stale non-zero
> qlen after all real packets have been dequeued.
>
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 44 +++++++++++++++++++
>  tools/testing/selftests/tc-testing/tdc_gso.py | 43 ++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100755 tools/testing/selftests/tc-testing/tdc_gso.py
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.j=
son b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> index cd1f2ee8f354..ed6a900bb568 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> @@ -250,5 +250,49 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY handle 1: root"
>          ]
> +    },
> +    {
> +        "id": "891f",
> +        "name": "Verify DualPI2 GSO backlog accounting with QFQ parent",
> +        "category": [
> +            "qdisc",
> +            "dualpi2",
> +            "qfq",
> +            "gso"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link set dev $DUMMY up || true",
> +            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
> +            "$TC qdisc add dev $DUMMY root handle 1: qfq",
> +            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1=
 maxpkt 4096",
> +            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: dualpi2",
> +            "$TC filter add dev $DUMMY parent 1: matchall classid 1:1"
> +        ],
> +        "cmdUnderTest": "./tdc_gso.py 10.10.10.10 10.10.10.1 9000 1200 2=
400",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY",
> +        "matchJSON": [
> +            {
> +                "kind": "qfq",
> +                "handle": "1:",
> +                "packets": 2,
> +                "backlog": 0,
> +                "qlen": 0
> +            },
> +            {
> +                "kind": "dualpi2",
> +                "handle": "2:",
> +                "packets": 2,
> +                "backlog": 0,
> +                "qlen": 0
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY root",
> +            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
> +        ]
>      }
>  ]
> diff --git a/tools/testing/selftests/tc-testing/tdc_gso.py b/tools/testin=
g/selftests/tc-testing/tdc_gso.py
> new file mode 100755
> index 000000000000..b66528ea4b68
> --- /dev/null
> +++ b/tools/testing/selftests/tc-testing/tdc_gso.py
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +tdc_gso.py - send a UDP GSO datagram
> +
> +Copyright (C) 2026 Xingquan Liu <b1n@b1n.io>
> +"""
> +
> +import argparse
> +import socket
> +import struct
> +import sys
> +
> +UDP_MAX_SEGMENTS =3D 1 << 7
> +
> +
> +parser =3D argparse.ArgumentParser(description=3D"UDP GSO datagram sende=
r")
> +parser.add_argument("src", help=3D"source IPv4 address")
> +parser.add_argument("dst", help=3D"destination IPv4 address")
> +parser.add_argument("port", type=3Dint, help=3D"destination UDP port")
> +parser.add_argument("gso_size", type=3Dint, help=3D"UDP GSO segment payl=
oad size")
> +parser.add_argument("payload_len", type=3Dint, help=3D"total UDP payload=
 length")
> +args =3D parser.parse_args()
> +
> +if args.gso_size <=3D 0 or args.gso_size > 0xFFFF:
> +    parser.error("gso_size must fit in an unsigned 16-bit integer")
> +if args.payload_len <=3D args.gso_size:
> +    parser.error("payload_len must be larger than gso_size")
> +if args.payload_len > args.gso_size * UDP_MAX_SEGMENTS:
> +    parser.error("payload_len exceeds UDP_MAX_SEGMENTS")
> +
> +SOL_UDP =3D getattr(socket, "SOL_UDP", socket.IPPROTO_UDP)
> +UDP_SEGMENT =3D getattr(socket, "UDP_SEGMENT", 103)
> +
> +sock =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
> +sock.bind((args.src, 0))
> +
> +payload =3D b"b" * args.payload_len
> +cmsg =3D [(SOL_UDP, UDP_SEGMENT, struct.pack("=3DH", args.gso_size))]
> +
> +sent =3D sock.sendmsg([payload], cmsg, 0, (args.dst, args.port))
> +sys.exit(sent !=3D len(payload))
> --
> Xingquan Liu
>
