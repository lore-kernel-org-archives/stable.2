Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492015;
	b=YvhbNqUT7Mh3ky0D/sLK4ZoDQ0vAptOZKe3uO2pa3Yiuah6K4vsiaMxKNlY0WOVpGNLs
	 njwz9X+uuwzas/pvmRWL5FL/mCM+25laOF+bdWUhqGjclgZV7QgfMYcotnq3hD4x7128d
	 8/7ykK+MiLyThOZjde/kxca0eosO1GVDvDZ+ONTtEXH5xjurFn0gCQ6jhYLU5FJHlWOQH
	 U0TIO3Te7f7jJmUg/ONNsjBOQhxtGrIbT3n4Zd/GQieMrt7mZe3ZY99iQ2qmgRWUP0pEW
	 nfR12IXqnj7+bOELz4CYZBKdLmSnSlyCHFZKiF9SpMNm8tAen7W4qxbYGvlEnUvf+yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
	b=UMWwuh11TDa0uCXYfLMFoTcl4A8Y9fhx7FCGtg1Oa6nDNYmg3iB05EMZsnA6jrHgh5Bq
	 KEmg4t81bSMsCvYxWwsckHQRh0WQGB/fAhk+95GmKmee857nJsoIwY63y1bz6dmVdE2j3
	 L4wcwHvbFzjL/msZVEmmyEu0XNnFpfI6aN+bvQ/muxg7fwcakjG2j2yfSoDc8O3AjbGYu
	 IKju5mfrKbz3ZBMwKxSnphoojBahDintAGhbFqrQ8KrRefqsM17MMWYvcrG+nZ08pLn1S
	 MVN30fqkV+q0NQFDpZkIbV07VZMJ3S33qAHiZ4pZbJRrneUg+kXxy9gREuxnh3r0X+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=o9AFjjEr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F77606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=o9AFjjEr
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1654016a12.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792492015; cv=none;
        d=google.com; s=arc-20260327;
        b=pc58Zq1S37wXeLgpyxpGcWyk9e4Ou8LWLmT27h95H75objZILza4AzCrXXvRqg/Bx/
         F1LbW5zx3uOsVF+yWPk3RLpLdqzClbPs2GRnZNQ/OUz35fec0ZFpr3pzXPnjWqYDvOa3
         DzAaBOFBjrvW+UzE7ohF4AdemEounbr14uiqmqOYx6L4+K8FJRMgg9vV5htC3zIb2IOK
         cd8dB6AE+R085nDBk/TNZ+wLGQ68j838gWZgTxZkJM36Dnek5ZSYTOeidgsiHPgWb4GG
         /dbo1Qdd+a7UdnMSAzZcGQCMBmKO5kqHm/zIT2H3cA8k2xyppVIVMYjr8AXKv85rqAht
         hu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
        fh=EHyUxejMtjMEBOeViJdUM08YGYm0m5Sdgv/8Bjsk0AY=;
        b=YoMZgRwX9MO95De9IMy24bxO9EXBNWkF1NO0ajT9GIqHb/L1oK7tSzAgEnpByRbwgE
         vlfF4/j8Jd3a2a7lR6LcCBGDCbyMArFG8Fl2mBAGw+sqd14qGD5nqRJUReHc5aXut4wF
         WDLyHsEmK8N/mbpa5PyVC0IG5xuZgrwN/IP/J2vTY48jdH5OK60bmtR67sgdyYZFF10R
         y5pQq6vHUz8OLhP2hDvrXfdqFaFazWVqtDfJr2izKm4Bnh87mVmOqDn04FjMEjMdb8DX
         2cOg7m+iYYS30H7USAzBDPJLDmlO9xJizDWXYzqxd1wSBZyz4otRX7adxprcrdHQ7fAT
         cOrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492015; x=1793096815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
        b=o9AFjjErLSgOk8N/zevDeBsLl78ZdWDy3lyuN91Tkeqj3Bm7pigFcLtxOJLb2OPptZ
         xtSi2czVZSmowJ4TIlFZmx3ywvC16rKGTukmHKa1WfynCSPL7l2kCG9q1QA6NO9kCOIj
         3PelFBmhd+9mjRVVjAdX88vXdGOCZTEDXmm38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492015; x=1793096815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
        b=mfTMc7mJXNrfdDSBGhnanU0Re6opjZ8g+h4aluB7ogWZCvIzKNbaEivvGL6W3jvvhC
         e2De/OouVWrE/6MkUvJLtzSJGFRHY1m1iWh/egKsqUsO2Iy8RW36RiU39xioINYmtWmJ
         ko/q+jXYa8KoF3x/Iolt2okOcM+tDqbCkbrg7CFzOmqZBzEvyBf+5gpjlsrpCiBKyGpY
         y7GnV2P8Xvh56MBBGIWgDa4vrCPvbZjf8MtNUfGp9oAV1ErKfaHpXWHh5zDQebO04yIh
         x+85M+0Fdg9rM5SqY6CiOMhwC2XcGGeAAIoW9Wv6JdBLdosrAl2WZgRy97iB0Vxzg6am
         LxUg==
X-Forwarded-Encrypted: i=1; AKwUvBzQY9SRpRROrdS0/QAG/ny7ZrO4moUuttnmBWjpobOHwrc5yLIXp47HDPwqsP6qUVtlKEcVGVY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJmh/b+iGVzoEJbHT+08/6hgOCKeqYbfBn8YZ+T/YAsG5uZATH
	AYXbTL0hOzpCDbJt+4TUDq4Qp/CepMxy5PrEq6nXgSYykKBklsiN5zZf53c/JQbYRn/+tqa+7cv
	wrda/mIFcjBoGKTZ4R/DXZaw9nY1woERuaAGryZkG
X-Gm-Gg: AYBFou2ywTKgd1ywYLxtVBWgPDZmCOvtz97klTuRnxGjfRj7zO1QXAvBt/kv1id/1vc
	YXu2DYNzr7DtmRdMkGzAp15Z/v13kuEojnPbPaDUNvgYDYbLumSQnoOrWSseksgID1WudqBKQnl
	5fJYYLNxa9aYot8Vq4S2F3m39UGIRJx2+rSI5CrzO/+TUVFEhl9C6hd/We6YV9u3MEHjfcXqwmw
	3cIYatgab40XsPE9wE4kzlc9397bfXBXN7Ig/53wuWbvdzgj3EGjaWzXt932AUDLuvEwjKXupmd
	OF3Qk9ZX+2iIxzMmBdkn1liojeE7TWcmm2dep7Q8sSLCr4xibk0Wmwa0TC8LUZ6EcYZsl7yKsrm
	2JLjfl+AzL84AxA5ur7UmgjTcDr8CkiEPKEGpKv5b8vcOAgy0Nc6c+9TM4RMuMjaOrApOy1tqOk
	r0j2RS3duf7Rjw4b0=
X-Received: by 2002:a05:6a21:b89:b0:3e2:1a3e:395c with SMTP id
 adf61e73a8af0-3e2260fab05mr8114467637.59.1792492014703; Tue, 20 Oct 2026
 03:26:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r1.20261012134711-1@mojatatu.com> <20261019194019.4b778671@kernel.org>
In-Reply-To: <20261019194019.4b778671@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Oct 2026 06:26:41 -0400
X-Gm-Features: AclHuK9w4N--2-RJIEl8VBx-0rkjIVFOVYul8Lm3ZHkR3c1K0BlS8cEin8kt8kM
Message-ID: <CAM0EoM=iL9kpU6Ju_9=9Frg4sSbD0OMtbQxwYva607259WBXhQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared headroom
 and header strip on slave retry
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 12 Oct 2026 14:16:27 -0400 Jamal Hadi Salim wrote:
> > Subject: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared headro=
om and header strip on slave retry
>
> not correctly threaded, again..
> patch 2 should be in reply to patch 1

Thanks for catching it - will resend. I fixed the scripts so this
doesnt happen again, but looks like this one went out before i did
that.

cheers,
jamal
