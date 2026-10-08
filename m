Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2C3368B0
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494389; cv=pass; b=ibS6xcYTk1FhUFEVEHWOqqePJnQjtnJyuuA91y9X1qBebAfJGmQ3PVDsUGE3UimK63KYGm2EwDpS9gvwgBCGnsOsj0JflDRUlM3V7laQ+WwlZ+v/h8Gx1af/PBvkMbeMRY3nQ3OS+VOGKv5w431Xpq84bU38P9ZZacrMRljt5k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494389; c=relaxed/simple;
	bh=RyQawn+OV1mo2o7XZ+wloEFr6zblvaiDgZw4ztEBr1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFizwhfdrzrVXVZZc5Wj/pU0JEjs7wbz6y8ai6ZML29t1dpfBilY3Clx40nOfVks4wrHA2p7hvg8TL+bUFw6s5rHiWGJBkzcVzvmq0K4/aIEmOqXklQWZmopJzIr1XG6AZw8Lg2n/Pky5sL/3eXJW5cRaogVDhipNOh2BDbMs/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja4WD4f8; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja4WD4f8"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a1eb6fa0f4so35367161fa.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494385; cv=none;
        d=google.com; s=arc-20260327;
        b=eUSi0IDmdz+IzQFTL8JibOeRK22tyVDIBVFkfnvGz06qP+N7fBSE56t/kg/kCVFAyo
         ix98zkTmt1WPwRjtzaU6jDjm8E2AxYIH4ktWksXxbUfxX+gcfrlEAPWgvZ5irsJPKIxc
         3AvhsGbdCtlTSzOKQkeGNDp2eBGBr++gzskgtNjngAxuHVZpd4CvBe0bmh2s96gCtGLN
         Zs55lfY4EQYG8xk9WQEHqQX0eXRzZW3N3SdGyYOYIggg/9MTrk8ObuHf5rOnGZojT5ri
         MGC0TJBA7is8+rHml44KGlGaI1wlCei7MuyEmPqGgK+9cRWTVOe0Uy1bXelOAvh6Va5p
         QmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RyQawn+OV1mo2o7XZ+wloEFr6zblvaiDgZw4ztEBr1g=;
        fh=uIkKW2oIwMxCofAgjdoDnqVnq20Fn47zpTPUQ6EF5tQ=;
        b=NemognoHlcziVUPEkEzb0uEHg9kyto/nFtJ2EjqcM1OarNNPDqSgJqpjDIQS7/y+lZ
         eHbDNHXyLKAibUOF5BQd/xsS57UXD840MC3qs++Qz3qhYo2cg5UI9zd1HufUcUcKF8d7
         5H9Mt5G0xElQx/mhKA3fP3xzr5LLs9114Z1vOiZtflEoL5jxN/0+4tJJmCSOcuKE2zo7
         Wlnpa02mveAN02ZsZEb/WG+9FvM74zLvN9HPTmLbyDQXzDxl23DAi7MOD+SBC/35MFXG
         lPpE4z/V8OAQVdzDMp8yl3QXLFFRtHcgYtM1hgl+8P7vxu2tmizV1CfpqTfMgj1EWz3e
         A4nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791494385; x=1792099185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RyQawn+OV1mo2o7XZ+wloEFr6zblvaiDgZw4ztEBr1g=;
        b=ja4WD4f8VJBVxV8fTXVRliqcL7E0Vq+0K/yxwnb/VrTN6MYQq41e28iWVPmRc96mYU
         mWp0nHDAMqXBicZPv6Um7S21c8aEXhmpGO4x7Yf2CYKt3+faXpHp6aA7k94gnFtZHq4m
         6YPnKROVnnqnbXaB3/VmOz+1YBXe7fNBjrwrbN7bn/Ux5wIme5P9+8yx7k5FmoxuLOQS
         6mtrt+hvyeGtmIbHHjhFSVNBYjqnzgOrQ+QUyacCOx46whmxdvV3UDNlQfe1mWH4Rm4T
         BnS8MUikQJVmM9wYZpzMPLeKDCvi0/Kpzvxe38dH57GiVyiRsBC1T4sXwgsFVfCvWKMq
         B2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494385; x=1792099185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyQawn+OV1mo2o7XZ+wloEFr6zblvaiDgZw4ztEBr1g=;
        b=BvfxN5CbfC2QfzNsfKmOA/jlDrX00ZAY2qoZgcxAsSho0C06lXwUR3Hoz8vVwfhHqh
         uub93GyucmrvYDIUerZjDE7eCCUoTCVoff9sqh1qWiNn4p7+aSdL92C+GIhNKElxHh18
         pprIcrH4+6UftCyhAE+DZuhRJQ73QJGVtSB18/hIP6HWhdKq1l9uC/Sev5ZBaMquif5Y
         B+Ou/8SK8BA7yg/+EvBrYAS4ML6+pj+8wD5d0Qx23dW2Re8OzGBWTtMhrmkriy/iEFyM
         mBhHZsmHahfZFNaAftGjqSENTmJO5vxGOt0ev91yaGLIjEjR1k4qaJ0XlyOk2klHKxc8
         cPXA==
X-Forwarded-Encrypted: i=1; AKwUvBz5VyP0uZ4x1bTctLlEg0EwHFE7/5CCHZkGsfp3zGchKkq90+6ROMkVAruHehgPyvvCcYwNQd4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfVgwXrPt6U1avIHy+kb8yI9mL23zH9JKpdajxNkYneC42H3Ne
	52QzjPZehrMbHnSSd9OVrEalVL5k6XAZmTUKbTC4l/H7ukcp5lBqpBjKJj9PxXqZFCFKYMNj0ci
	Zfc1NySl3wGOXUzNptS/vSoUHrA6Khlo=
X-Gm-Gg: AYBFou0nmcU3jn8pF/CqUCY1B0tpOb1tPeEf0b0opH1PKLoMBizVRzv4YoH+9JMX5sI
	l4coNJ87loscyGm1ZDxMxdKwiovtPFiLEh3ti3tNryF0gojLuNhaw0JMVUzT5opYUUoxFWgxDKA
	ZJZEDLahC0QFwMUkJ40BN0ekZIn/jFuhbc4ZYcoqXLt0eangKFpDRboZV9TS4a1WycDwTMHbVsg
	czesQFPbWjZYiLBpJmSCcHRbmGb7POde+nDMK8vFeitR3wQbtiTpUbVNrVl7TvUSwQR6Y0re1fY
	jQguZhT9Em39asmvNTw27MqMe2WMAdjHd+/ONz8QAGUB3Lpk3d8cY8Xiq+tbyTY50uuEy2eBymu
	zRnF//xOz+/GSww==
X-Received: by 2002:a05:651c:a38c:20b0:3a7:e737:c401 with SMTP id
 38308e7fff4ca-3a9c2a6d715mr736611fa.17.1791494384639; Thu, 08 Oct 2026
 14:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008195608.965266-1-linmag7@gmail.com> <20261008195608.965266-3-linmag7@gmail.com>
In-Reply-To: <20261008195608.965266-3-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 17:19:31 -0400
X-Gm-Features: AclHuK-dPUM5_kwRdWjxFHFwkBxSpn8txFraCtvQgNDCuna8iJ8OD-319zdUQiY
Message-ID: <CAEdQ38FXFC43UHjh5W_Z4H5BtVxbM8RQS2t9a7jUjzfu93jpRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:56=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> After the on_each_cpu() rendezvous, migrate_flush_tlb_page() walks the
> other CPUs and zeroes their mm->context[cpu] when mm_users is at most one=
,
> described as mimicking flush_tlb_mm()'s mm_users<=3D1 optimization.
>
> It is not one. flush_tlb_mm() tests mm_users before deciding whether to
> send the IPIs; here every CPU has already been visited and waited for, so
> nothing is saved. The callback has also just set each CPU's own slot
> correctly, so the loop only overwrites it, and does so while that CPU may
> still be running in the address space.
>
> Remove it. The shootdown shortcuts in flush_tlb_mm(), flush_tlb_page()
> and flush_icache_user_page() clear remote slots too; once the next patch
> removes those as well, every runtime update of mm->context[cpu] is made b=
y
> CPU cpu itself. That patch relies on the invariant when it reads those
> slots to decide whether a shootdown can be skipped, so this one is tagged
> for stable as its prerequisite.
>
> Fixes: dd5712f3379c ("alpha: fix user-space corruption during memory comp=
action")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>


Reviewed-by: Matt Turner <mattst88@gmail.com>
