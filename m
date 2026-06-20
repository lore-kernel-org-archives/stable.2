Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406F397692
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970817; cv=pass; b=Y52Jc0D6g++JDrpNnnWbnqfz35hpHBWaHQ4vK3yVSSVOX7wGvWoQiM09Yt755Ql26jZH2TFfiElaQg7o470cVjVt3xN2JgJeF2TQTLVuxHMV5wvWAsjVHGSz2thH1mrrsxTfbHjHGN2V54ztT+DacBQaWBcuhz5juxdMSapjO+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970817; c=relaxed/simple;
	bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtLkwAEtmulOo50A8BGAKS8O3xjZWPRim4SRbAX8evr+gfzm/vITeTNWjnGrADuVhMv5j6VnSreDGoLydiNmLJYCnnT+WkGxY85d8HkNkinC/0D/QuzUXnJz7r1hWmizwDsD7IrG2UKJ9aqFmn617DVjKo/utdKyH4F6hnp4pdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=U9Z2ZPT8; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="U9Z2ZPT8"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-662ccb916c5so3180550d50.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 08:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781970815; cv=none;
        d=google.com; s=arc-20240605;
        b=HRoMsM8dAn6+E+x3SSCfg0/ldfQdOyjr8r4yCw5mQxQpefuUgoQQodB2F1h5/V7FXD
         ePpbWRtyCHvA7rkUy4bZ53hpJlj49b8TuBlHVubvNs+Az87xQxWPm0ghSLHNQnLGAfoe
         5qhbSa1qpBSsvw1lY8kj8coicR9dtoexlzl69G3a3i6+FGauBy5fV0QUA9xFLSEe8KXf
         hXNaqmHV6B0ln72celmrvvrJA4zF+4bA6hgzn2fBPPjvchybf2efKlLNQ3IvIsqBcTgS
         7uUSsINIUEDPmXrvlmlFcFmGtQRKxLeWwPXfxenYzDvFbv5I+Zgl+J01UDLb51bPyVao
         mUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
        fh=Uc3IDn8dA8I/jssnWEV+JkuLL8pDxbnSWAx+DycVibA=;
        b=TxIcMzOiAqMNxpcCG4s8GFzmPiL9j4KGkoB2VVw+aLNo83RmTVcPuEuUrQ8dEbyAoE
         IN6GJrG5R6BWa5uF7RrGK7AFo+G2UWGccsCA0fvhSTT4FXZL+fyvTyWDtKDqlFax56nK
         DsWTEc+iwPSdAnT1TKuwF6qb7mUxbJbGs6rCXhZzMJF3kuoRDCr4d+eLAM7e/WIKojMP
         6QKCwgYlzrNi8AxKe79DkkG/BSHjVW7a1jqoNixTukP6w8ea6ud05pniG5405wqo60u7
         CPF3TyB/FbBruvA+Y4/mUUOZ4zZ4XnfyedmClZyi+utGw/qUYbMHaour39UleOT/5JdS
         svWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781970815; x=1782575615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
        b=U9Z2ZPT8o6rPpXDNvC0733ikSVYIdCPba9OWRwGiD5c9kcDmM9jPR73EK6j9u+1kHr
         2sVGAfRgXhtjGn4Q/c/jXeHCFJrnBouoXScb92l110QKe3hC1ZsBqxQkfOm3o5V4fvJd
         8Q3ZoFJJGWnNO2E/oAh7Oe/oqV2Yk4oK2HCUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970815; x=1782575615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PprN2t9rjdBiH7hNZ9B0fAoZIV5oRd1FHv4010wsUIo=;
        b=TCmvCmiKRMijICAGZLPxsJpb5iF12T1ZUXUKqygmZYw/i2zQDE0aXzbh8ENt9dXqG9
         aAyOqOFuKnV+UAOUq15Z0GeMsUwu+R5nJkESXkBByNhVeSpY0hoQG9idFwvUn9ipKlEM
         rjFbWSknKuxucIQgpdv+JY4qY2rwxECkVPt4+Q18QN81CaSgTH+M0hALihIqyla5KgQ6
         TZIV4g6vWLNL9334ingzPorYjTg20VlDSXnHIH0tYESHtfa96fdlgYACLOJRD+m5J/5s
         5o6PwbOaYhst53qdT4m4aLVJ/zLQrApCfHu0Im6tAV9CyqOZiQPJf1DBb1aZDFtjmN8q
         B2bg==
X-Forwarded-Encrypted: i=1; AHgh+Rr76HDMTxc5T/JzB6SmjPtBgLLC0Putp+FV8lyqOEX7B+PAP5UmZAVTsLRq6H/Iqck3WgLKsbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FTR9YRX3CkNPsp6C7rIncbY2YFw+r7s+CeNKobhb5yXiMjYH
	EdnGluC1RChdY08MjwVaLGHmAvw9+x7/TIXuv6LJmxDNBucgTcNw0vzyf4ANJQRCXgi8LKX9YV+
	49kTvIYa44UKYIAXdRkbgIzC1noJkzjFGjTnMg7AX
X-Gm-Gg: AfdE7cmXm9za37Hhc6UYsqz6jK2a0UZ0+AsecQoOIU09ARVnm5Xsv94zuIMV5jQkzj1
	ZaPs2zvh3HW/cshsVLfUJQHOJUx+OZJXNf3TktpaS6nJmFDygWBi7a+/Y1QSRGJXYYbHUWvnfrE
	PSKUal5IdEB35x+pAx4nHu3f5+azd2ta+p7VfhH1L1NMLk4JtJxQlo6zfqGTGUSOHvMUXF41IT9
	DbWpikSa2sXZ0AyXqdOrfGi74irtH7ho+DxZxZfaoLq8gijqoOxlkCuRIrw+U9dGUG3u/fBIyy7
	iXwYxYmSUz9iNpvLj9N6RKFpAIA=
X-Received: by 2002:a53:d601:0:b0:660:e9fe:18e6 with SMTP id
 956f58d0204a3-662fc5eb415mr6811831d50.8.1781970814676; Sat, 20 Jun 2026
 08:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io> <20260619151447.223640-2-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-2-b1n@b1n.io>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 20 Jun 2026 12:53:23 -0300
X-Gm-Features: AVVi8CffwPZzdgTHf5I-e4yibNUpPw9ZYTSlgla42xdPOTrEgy9qgzAZqsIDlDA
Message-ID: <CA+NMeC_jyE33TtATHTNMPBmp1nqjqnGwAPrqKVBECTzR9huwNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/tc-testing: Add DualPI2 GSO backlog
 accounting test
To: Xingquan Liu <b1n@b1n.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:16=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
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

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
