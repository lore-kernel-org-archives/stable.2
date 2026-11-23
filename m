Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471295;
	b=n3EvwIGL+Ly+2AngcVs3Wdv0ZUhSXR+gh0ope07B1dWNybZa4KrFlHJUQqG9CAKIQ2g7
	 kG+HmHI9arX51/BnyPUSt0Y5YytxJOHl7y3ijYb2qdWN6KcKp/+ahcDSbHTO6Eu1OCt+2
	 nQMX4iON77aUbYYUdQDHOISLiYUmgSejqhqdDGLCtd+X0G3u7AS6V0prHkJLG8KiUmcFV
	 PJ+GbgpBlY6OqKHGJ3GGeWuepoXaA66PYVgNpvJPnpo288S5yzuxT3jgMZXB7zbkiBX/5
	 mbyT5oCyvcE0D7dPr+54jhBx2eVnUY0yUfhYh0PeVl71l7lRsMAA096ik3lT5F6MUJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=HXlZPN3cIE8dHERwMlz7eNxXWyTGYF+BUQZX4Ynl+DQ=;
	b=BplxNkudX+AbowjnOJjUow5NEqzaLUSYxikPwxuGIjKBa3E4qyUoQWDtPEM5ErirBqsi
	 lw3/Jl0CPQYyfKY/aqS7gtWucvl65c81auINmIXwHwPt7dxNE//xonjOcwnTBiR86NZdK
	 D3GT7jbwK+rjZdP+sT3XO1bqlH6KHiNuN4+flJRuYrfSzIH+s8BR7euRZki7SRA31Mh9V
	 6FANKYrsbwwz3nj43VCy8GyARgwceC/45Oa6RV4GtsW7rRtljC0JYSUu53ygE/ASENTmN
	 sRluK3crah8dxRgIoi2E2zKX0x6B5hqrAr8+X7dyhSPjwGud3Qx1SzynWkDnsi8BK8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MsrTYuOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A422606A336
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A422606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MsrTYuOJ
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJw1mC2657734
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:01:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=HXlZPN3cIE8
	dHERwMlz7eNxXWyTGYF+BUQZX4Ynl+DQ=; b=MsrTYuOJYQ2wytJCLzkEX65+iJt
	K6N23+oL6xEcDGJ6PnEdfU42/bHNwn1aZcR/d2lCBKBQ7Hjj5EWmqpCETDR9eQ1F
	hl3GntDVNxWEv7byptEAlCVTSzTGeKygL2vYEP366PP43s7n8Fa39izCDAto3Fdf
	iPIIXEISjxVunEbIg8Yn/yVRpvBRcQc+0u4ptdDH2EwkDaF/8mwK246FEvT6hxTu
	d7eYm0b6mO1LTl1Np0uBWTtI0HM68lYEvSlPCZsdeFOTuP8hsDqM+/qjp0qtqRo8
	DhjuNo74AJTvHSy2mYz/hx7xhE6DfnRTv2ksulgkxzIKCUsoYPC/EzZGhew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j3wx9hc6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:01:33 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a13ae043so4018296a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:01:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795471293; cv=none;
        d=google.com; s=arc-20260327;
        b=QTWt2T0siRx1KVK3LzWup7HETc/LU8wk245Kdw8gVDk/pKQ8jU5vrjOadunV5BDmB7
         FvjOs7tBZZF6uhN6lZebRznHF73OMpfqJjmqPwBJqU6ASwxRzIO162weSvHajrSqpNZh
         1wN+UY/xGui/vrhvtkNxiuGTW5Xf8yynQBoMgiZn7ILN16Oe8bydnQ+LX18C9utrdtRC
         c9Gb2It+2d0bsyDpt/uzgOUymAdca9jlq76QznKIURKCYnynzymvMewJBdzgTqieZPzS
         Ody/PxtQXa5KyUs9lKXAe1U/YcZ0AERax/o3JsPSxG45Fari5pXxdN/LnP/5eC56Z9Z1
         HdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=HXlZPN3cIE8dHERwMlz7eNxXWyTGYF+BUQZX4Ynl+DQ=;
        fh=PkHKi6ltniiUpf3saMUxZ7HT8Eu32Wwq2t7b8l5/auo=;
        b=aCIwNo7+M4nh8+XWsRelGw7d8i+Mla+5AdZOnaD+wmtr3HnS4SurfTpqeTeKhHSvvs
         XDkee7H6ezzRkrLn77wQJ30cfHbXmT4+vTjff4AMm+W4T///sQpaC8ExyWyHFTgOjd4f
         be+LntF1rAUIBB0HeHjLsQWtq4aKvQXEfbORc07a6Ox0UH4hCgTzStR/8b1DNLsBxHd6
         iuC2l9x9yK7YpZTJVenmrtjkWCyUeV8UHiO70kntIpeEBd8H3e0GYhC6Xem690qLGWmF
         E6i2XfHt7+mu+GWcfPLzG2492q3qeV2Vxq2Ep/oqondphcPjdMDl+6C85HZnJl7CXVjf
         cBZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471293; x=1796076093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HXlZPN3cIE8dHERwMlz7eNxXWyTGYF+BUQZX4Ynl+DQ=;
        b=g9hlMa75dZ/XqJQMQHOy2yRn/QIEzCa7BxASMyhVM+aL79goUwDhNrJahfm3jLAv7/
         qRvXPRywsMQW6e5tS0beOk3YPtb9aU++wBTgMJkPNwfWjR/WwVpDIzA8/8QD/h6se1vH
         nBit6gN3z5CdprapwnN4up0zebsRYopKDTvHmRNfOWeRbist73fbTYU4/mrU2p0qIE5h
         CmQWbC8VJVjo517wn0q7Cvevn7ext6pYqY6Fmohea+DsIPXGU+lgoMoX7VZtRV1GjTvu
         z22qY1VGx27CjC7Qpqttx0mEUKm2K4T/c9gzz80R9OCHLj8CTdtL3WqzBK3uCpkqpBzk
         tHUQ==
X-Forwarded-Encrypted: i=1; AL+hErGBsBcgVwykvEtxuqcpLqAphhSVqwo9X918zF8g3c4XpGZdr/uHK7eMgI47Kd95mY7GuSH6MHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vMcj04TvpauIjqqYeb8LzQ6NRrC/9dtqU1DNphsTVwQT8LdEJ
	JfBapKQ8LPp9KJ9KJ4teGEA/SEUR/kLvWOLUY00J/Ei14n2cnKNURLkNKIc2EJLI1/ueqbnm5LW
	PBIxVeOKzTFwlFWj/848t0xs/XLpi/R6PybTKe7bZZaU/2SVDdrMYoYu1/QsbEmDTvbQYqc9r2f
	yNIgMIBOZBYQLIRx2rBsN++NTst190g4A=
X-Gm-Gg: AZFdTZeaQ3u04iFLE6ksuKu+NocJzXTDqZgForQSJGO7deUSr0eg/x3IL7AYf9Xc5+1
	iO6gMLR+Ic6mnBauyYpsvTdMGb4lGY7dOhUtC3EML0IE7GvphMvGRVSD7acV22QSXZtpkzXD3gl
	S4D5g/XklYtlXqdnN6khPEckAVlsUMlBVpRFbARRkcfW06WxDwQ3injPsm0YzevevtHMWRBr5nE
	5YjdqxsvhynNN+fekFMK7K6f6tD77ibtcUCMogAYhgl5yQ4rFc=
X-Received: by 2002:a17:90a:e705:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3b41c7e11bemr11000754a91.8.1795471292960;
        Mon, 23 Nov 2026 14:01:32 -0800 (PST)
X-Received: by 2002:a17:90a:e705:b0:3a5:147a:3b63 with SMTP id
 98e67ed59e1d1-3b41c7e11bemr11000723a91.8.1795471292482; Mon, 23 Nov 2026
 14:01:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117203137.804424-5-toddfreed@meta.com> <179529586053.3135.7106623626318776669@kernel.org>
In-Reply-To: <179529586053.3135.7106623626318776669@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Mon, 23 Nov 2026 14:01:19 -0800
X-Gm-Features: Aa3M54qKoeHizOx32dSF-QEKNJXmc6qKuSfI7qtOC8d-AkJeAsj6kZH5_ClB_hE
Message-ID: <CADh2yMxeyoDYgcp6WpF6F4hcLGvt+DxKTWLQQi7HrUo8fit8vg@mail.gmail.com>
Subject: Re: [PATCH net v6 4/8] ipv4: icmp: don't quote decrypted payload in
 icmp errors
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
        bjorn@kernel.org, borisp@nvidia.com, cratiu@nvidia.com,
        daniel.zahka@gmail.com, dsahern@kernel.org, dtatulea@nvidia.com,
        edumazet@kernel.org, idosch@nvidia.com, kuba@kernel.org,
        john.fastabend@gmail.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, mbloch@nvidia.com, pabeni@redhat.com,
        raeds@nvidia.com, rrameshbabu@nvidia.com, sd@queasysnail.net,
        saeedm@nvidia.com, shuah@kernel.org, horms@kernel.org,
        tariqt@nvidia.com, weiwan@google.com, willemdebruijn.kernel@gmail.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=aY/0Dhot c=1 sm=1 tr=0 ts=6b04b7bd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=vS69VSOLqzyyCQB8HVkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 0D4wmJG9JceyMK6nyvXaMb7A9eFPBcwZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NyBTYWx0ZWRfX63SnEfwHCCCL
 wB0ZT4kBn54QRDI8VrHO5yM2wDUj/Z9tEJXWzt/WptAhfC9gYDKsgNhUOsJ0yyoCtPXGxMoZ+rD
 3k9690OA8PFDklwnJ4EGBhJMdkmocqs=
X-Proofpoint-GUID: 0D4wmJG9JceyMK6nyvXaMb7A9eFPBcwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NyBTYWx0ZWRfX1jdtO+c9DDdq
 +lBoylM+aiVGunw0bd9J190GY9VczyEzPJDYioSzWhEbxvu/4Zz8osVfr9b8zPfJw5HijxEGgAa
 cwOTj6Z3qh/Ug+CYcghmKmVyeGuoWIp6KvfdwM5nO8BJqaLgsSCdSofTfwX4TqetTlckGK9fm0I
 R5XJ2BJHFTlooPLfw/qglRVg4tZBwCOBFQnUUVLQ9FksR16ttplKoad3QJLOjaanHgA4MLlVp7H
 b0CFEPNFlyPnfddi8+K3og+WW8/NELwp3Eio8bXSXeSa0Si+4moD6q+LfeUWiEgURONO3nM7t9u
 aRlZdpo7EPB1rPz26UVd2oUvi9TuNvpue9PAoEb4a9cYQxdwLbLv3w4Iciit9LEFFvFdNVtgamf
 Ms1Uu4E3Ol5mv2WruvhV0/hjB67/GapUOnqsbeAYPkrfKMspnZkauTLkbwigMw8sNu1foTjn3oJ
 GcFuryLX8pSsjq4TIDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01

> [Severity: Medium]
> This check only covers ICMP errors sent through icmp_send(). Can a
> decrypted payload still be quoted in cleartext by the other IPv4
> unreachable builder?
>
> The commit message says:
>
>     nft reject in the netdev and bridge families builds its own
>     error (nf_reject_skb_v4_unreach()); a separate nf-next patch applies the
>     same rule there.
>
> This patch carries Fixes: 784abe24c903 and Cc: stable. A stable backport
> would then make an inet family reject of a decrypted packet send nothing.
> A netdev or bridge family reject of the same packet would still send
> plaintext.
>
> Should the netfilter builders be fixed in this same series, or through
> nf/net with the same Fixes: and Cc: stable tags, rather than nf-next?

The nf-next series in question,

https://lore.kernel.org/netfilter-devel/20261111003111.3826942-1-toddfreed@meta.com

 1/2 netfilter: bridge: don't refragment decrypted skbs" (dd5e0f8aebca)
 2/2 netfilter: reject: don't reply to decrypted skbs" (01538dbd6b9b)

patch 2/2 reproduces on net/main. I believe the precedent then would be
to send it to nf (not nf-next).

patch 1/2 does not reproduce on net/main. And it no longer reproduces with
the net-next series, "psp: introduce socket-less psp associations". I will drop
that one.

-Todd
