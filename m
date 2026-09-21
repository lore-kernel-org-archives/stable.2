Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC5451990
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984012; cv=pass; b=bpMG6i5cy23olmtgBJdiIs9m32/DK/Q9WaxwWwweFGKTGXrWMQAiIRLBxkWyARExN2OYWJGK+kUlJUZkLSXzb93a8oRO2tXT9bIQjYEXfH7R7OAVKdKgYk8vCIqraFJV6UVNVKP6NjUjBlqsX3XhYl0XxUxWhMA/pYD335z2Z84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984012; c=relaxed/simple;
	bh=f+/Cm9YPfNPvvyTL/kLTG5mweG3JOW7IGzYX0bdp7V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajmHUf5tcqC7hX83YwwpiyR5ajylvH325ODdeaLHoFxEJUmwAtJQeCpWxUvbcjGp+SlRkSMqG6yow5a1aKt6zqwV+N3XdLpJK2yAGvOWD+5uJBVzFEf/QuXHqNfsQs1URkYFd8B4PkYCSEtAX2+UUp+Dkto6sy02VBTfJwi2CkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha3tZRKo; arc=pass smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha3tZRKo"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-85868e38a49so5438767b3.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789984010; cv=none;
        d=google.com; s=arc-20260327;
        b=HR5Vv7JI9qrS5m0CqezLMbx5fx6oqHUl5RZAPTleiCXOpdN7nIm/E+3zvgQxcSNfpS
         sDdGmQaqrMOhzwLdK8IFbEtnau9XouIb+luGqQ0gHSHC4plxY2nl+0QbyMicuxMj8dYN
         /UMjnLCftpf6K5XHVcWO7VauIPaiMcExHvZdsDx6LwhW/gjHDj1OpKdECAPiE8tGsfP8
         yolgZUAtsomkU0UBCreQbXG9Y9Romq5J7ZKC0JMNHPw5tfPmsi47EY4fvUFxAZjnpvqS
         e+RTO5/NRdls7KhDXgHA0gNhypoYcqXyrlSRx2AvkTVdzfL3u/tRQc/cVxSgBXbTcqWX
         mW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f+/Cm9YPfNPvvyTL/kLTG5mweG3JOW7IGzYX0bdp7V8=;
        fh=WBuEKF093x5WsrmoNdkRYLEB/kgkR2y3etQbZaiwDQc=;
        b=FvKx8jMS/rrsZXq/Qr1YVZbf+lWwAIPlvazRf+ZNbOEb2Ajgl7To5DDt2O4URevEmt
         AeauJQUCPv4ECLiH6K/Rxik5NjsFcLCP+jLzIcpQIJnuXSLPxOwI8na/VleZJ1Kmw+Gu
         bGsJ4MVnuRFMltSZKfwaQZj8y5Ufk2jHzC3bSGj0ZRZU3WrcOb9OtSqexEYBOHKLT8Zr
         t9OfFOR6X2Cd/rgS2Q37d3W6/Cl+Nm1MiN8XEk0/SdIjn22rwsVqcOjjCAxkx+87LmlR
         g+lj9q7IWiWbIWdZsL0VLUqPAaZv8YsYmDrxb2by1QTDq3AHdu4MmEWm22oJLY2tldk5
         wrJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789984010; x=1790588810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+/Cm9YPfNPvvyTL/kLTG5mweG3JOW7IGzYX0bdp7V8=;
        b=ha3tZRKoxsQuUPyIefLtSnxddM8Vn7ccv48KC3UVcVaUXtRBxa+mGXgiCTQipp8nEi
         Bki0CdZr0O+ygsgPk9H64zjptvGPNo8CZhXOVqKCkt7eujN9lvzE9Imr6jkNJCbikvU7
         450UTJYFFbHrt0T+VluNzKdbu0JU4YRpvuOUHseK3zPqSROvZ/Hqhpk5BwnIVwWFaCE3
         UnGuPZNHAzQjmosepqeRvHkPnOHmGerAZmtcqK8I8aN4DGwsPuLHhdnpHmLx74YA4UAp
         MAlY+uesT6AveQMyebdVpWgDpnPOzVmgI3d8tXXTdzKo3CTHDqw6UlfdigrlC01AEpqL
         QN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984010; x=1790588810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+/Cm9YPfNPvvyTL/kLTG5mweG3JOW7IGzYX0bdp7V8=;
        b=lpaXdJFwtecAfBfzqmMmc54lUC0mnJ7t5Cev+OY6da2++LLn1p1kBxYknTakzWdDkP
         M7Trb+UqRjhBEaIlLSwRS0rhNqDsh4UI+3n+EpGljetwjvQrlm1uydFmytvttmMKJHKq
         jcF2XbnmXk7czPcGgTnyWkHlwQwdKBl+f0VXMd7416tqIWa7FHGec53Jdl4Uz0XDCDlW
         mxX7z4QCGiTMe8bWRWbmVizXtD5JCURJgyEFwAF8ROudO5zPeKfiOa5vUgtuRPmu4mWE
         tpSlNRz5j4K/nVRkAS+v0EJ0VPl/pJUVH3Auorrtb0NKMGHSDBPxO8M0jKGhzF9JdbGq
         WdCw==
X-Forwarded-Encrypted: i=1; AKwUvByaw0zfl6SNSpD1OujVQAuvHFc1dNnnog5PMVHPVZL3WThJwAhmfTPKzFa2On62cicN3Op+oyg=@vger.kernel.org
X-Gm-Message-State: AFuF++k/3//HyWCwnHfUngpBPEg2obdykS9zLekSCeTKzGDms4fh8NWp
	lj5tvf6P3jaNMXH6xSCx5rATxZyv+ZN5TYAuPlLdY5a06F+4CGvy38ZC+V03gfcSIdA7Ktge5A/
	hTkzYVYYrudagdqmUT8mGIAHg439oJus=
X-Gm-Gg: AYBFou3PDOnQJlTqQguXmhfwfuv9cTtXxmJTxjzaMUEeFg4xNrELNJN6ofFgBOa2o+L
	hDP0jyV5NBQlLGOCKDKti3p23RYlX3fGK7cjQGXdAOKpvETNYduSn0AqLvaj1oJh6HEjzLsJtBs
	OJSIRAOKk4+WJCceanlkh2AyGkCLRWr7GURJK3o2QMF3OFShXY+STcRCDTVQHWHY0zKIuC19v/x
	NV71LY5DdsSA1OmwWcq+srQmRr+KchUmjSHCMX9jgTFaPLRJuR+8K5zwx4xzPOsNBawaKtwl/UA
	ZtBlDZLqcPyuLeEJZhbkqk7bNCUHLKBx92Ss0BfD00whyZz1+CV2yT69
X-Received: by 2002:a05:690c:e649:10b0:89a:63da:fab4 with SMTP id
 00721157ae682-89a63db0408mr12439377b3.111.1789984010444; Mon, 21 Sep 2026
 02:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920145848.44521-1-me@lizi.moe> <20260920193830.53706-1-me@lizi.moe>
 <arDqcJ5AbDjGHd-b@sirena.co.uk>
In-Reply-To: <arDqcJ5AbDjGHd-b@sirena.co.uk>
From: Li Tadokoro <kokonata233@gmail.com>
Date: Mon, 21 Sep 2026 17:46:39 +0800
X-Gm-Features: AcwNN1Ud_FIYDoPOA9vd1A9iNgMPZfhlScfzx8a-KRd0K4u1ZBcEhynMGifCZ8w
Message-ID: <CAGFxjK+1YVvFiZS7Geaxe=TMO_bvuYsYtsOjgpQ2MV876KNvwQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-cpu: use DAI table index for
 playback constraints
To: Mark Brown <broonie@kernel.org>
Cc: srini@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry about that. I'll send future revisions as new threads.

Li

Mark Brown <broonie@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=B8=80 16:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 21, 2026 at 03:38:30AM +0800, Zimeng Li wrote:
> > The DAI ID is a hardware port ID and is not necessarily the index of
> > the corresponding entry in variant->dai_driver.
>
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.
