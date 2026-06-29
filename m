Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC234A3BF
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754284; cv=pass; b=dbmyyHQ7RDiPb2Tq2u67S+BjDe5doMW4g3Elg5ryWoFdAWrY9hEV7amcowPGtAmqarqxPIxyhm7S0cPIFWyR//SiQPlaBMMdP6gOWWuLYfNDWyUZT13Wv+eRxXT+Tl1sWwdYumnF5mdpbeoZrflrsj1jANzNplkThrMVs6Lp+TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754284; c=relaxed/simple;
	bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrrTr98Yvajdh5d9QmomnehH111SRbBUpGTZ2+Adad2vGnQblg16AlYr50K5knV/P4ZwGVHwAXThqIaxg2O0tAOKK/GqjMRKjeBsYjA3pH3g2Lnc6uwwXxxJoZp8G2Yd9MWOkTE8i49uoc7Yb0jirf6KkQVdzQ249oVCuuuF6UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOB0tbQz; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOB0tbQz"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69857dc1d5eso2962011a12.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782754281; cv=none;
        d=google.com; s=arc-20260327;
        b=pHz6CuwJJt7cZi6w3iwUuSeQAup/sgjPj776hm6xFgfKM3AQ2cqMcYY7eK/WuJ1A6x
         g7ptKneyttGA69+SV8HMU4Tl5WK59escqjWL7hXg2yKXxrPGrU4X9z28tLK6vYK8rs87
         VSiOQcWvBe59/bxbskvTiwfqzgqyGHJmaMq1p4DssyLEbTqh94WY4luE+PVTjBaFiEdN
         w/f8lcVwrrQBOQCJFXnWuOr6RTxWvwxZy55S+Pn2yqlIVoUrhm9n4LUmJhf8F9TS07xN
         P04KL+FB9zKCbTGHDxDoKY3q6kRAVLZYZx2ta1Xa6I/DCHcR5E3VAj+8C+gkSPu1ZYD8
         E4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        fh=BrFeWbUGWeAj201CeSZQHJ73r78FnNC6wvlEBlXQoDM=;
        b=QOWJy0jCEJwXXcm6MGI2hUFf/YNFqZtnY3HUX7jfv8O5r0zVY2QjSvJpaaQuarSLUa
         q+k6DnrWCgAbbbJKJILOIK3orEDFpM50SkptM61FGykh874A57pnYlggTN7MPbMkGDre
         W30QN3IkBW/lhSdKOQb/U32apgqD5N8Jc5Ev6oW4UFPA0GXJxqxaDRZJmoJ1opqZT00I
         GmT479cSkitD/rlYNNvgKhsYiAdyqJYjkkakvtrmGT4Zm6dvvnRfd6cyMJMpjJ6+DFEE
         LqB8zoYcKnbdfWsXXpSozS6RheqYveDFRX+t9B8k3ZNR1zuqJ4ji0S+8SkCJNEG9S04g
         5H5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754281; x=1783359081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=VOB0tbQzXHx225/eBRLGEzWz6vX02N24U92aDSCNpfdq7DZv9iI6NGkOHF5VJSXBf0
         iZEHeZ0V5mC0F3hIMX5sla7sCwE6QUNe99CfMZz+3kF02NmreX29GtPeIhhn9/tvERdq
         6rIHJEfwGNs7g3Qtc2MU325nY7nvEWm2h/9qTqpSpa6S67zweReqCilX7ZHuwu06Afw2
         Tp0haJ2b/3LKr4BGQqiyRCz5NDX62Jd6SCIPaTHgyHwtVcs9J/8SW3WLPHp/mOLeDDnB
         HbauBnc7gNry89jY+RZ4nsQ9ECd+RxPZvUBef39i/RgCTiFo8PTy4LyUjrjbVd51dDKN
         dcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754281; x=1783359081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=YZTCPNGsL8xZphi3ms9rjoz/r4tRN/goG7G9PVz8DQ6Zx+X2RAksM+LHREEcPffo65
         aIQ6ZTNgD9PG1Pw55hwLegYX/GNQPnxMu4YpVJz/r4uZcpmYA9fh5Pt5k9LMw9Ygvlg5
         CpVrEsIUyldkswftCE5Mm5Mc5ZuyrV+NMRMP8wFwOfPF0HPrO0TD6cxC8dDUXNb9a/Bs
         znRtd7ufulO5OI3ZXXRslC7Z2aoe6dZIL7fBWkDAh8vKeGHI5DpNJwION43kI7bkx5az
         QWIbw/pPS3qN/g4OqsIytKXok0qHarm8LiUMz8Et+sEFccC8TuV1YU70A7yttgZ4eeMw
         IZSw==
X-Forwarded-Encrypted: i=1; AHgh+RrqVwY+LpFsFFdt40wIpaLnE89jSnVFvkUeTJ0v++W1ycxJzOWo60BpWTLlgReqaU6z+GrrO+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YyRSIcPF8+ZAeJKJ0J3mdqjE3hsD9VuYIJoqLvaX2+aUJs+b
	zVlEXhJ0HXUHqxbYBgx9Te/52Mbkz+Oji+QTrvClL/APHoCRuTwNzRCcxv1ZuJ4ADFBAq8RJsdp
	oszRq7o7xb37WA7EyITK/2yvuO65KfiI=
X-Gm-Gg: AfdE7cltjR8zafCRY65L8gs1Jialujvn+UFyTHgmecXIVFBNgfk+LS4jClYdYFbu4EK
	rEbp/tQpQErlY1kbXSvtTxGQSJLn/hRnIqT3Arn60dyeFqYrpfQfzeQ3TV9ziElPIegBlTZCbrG
	nCm4n844kfyFU6uvI1QHp1r3V2Wl3pYVnogOWO3Z5yMZqozEePfKEFaRsUiFUSMFftNzvKUazBq
	TNKfhn0R7jK3y1l1QGUKU2t4kfcX6GcHEUK9TZKiZ342QzGjxmPGN8JfvyYESNXHY1cam+O/OhY
	MYii9sNLkDFL9dLZwE25psgRfeun/6k=
X-Received: by 2002:a05:6402:390a:b0:68f:cc95:8c10 with SMTP id
 4fb4d7f45d1cf-69879e4b974mr46982a12.27.1782754280332; Mon, 29 Jun 2026
 10:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jun 2026 19:31:09 +0200
X-Gm-Features: AVVi8CfvDZzdzYVHdraWAewZEFEyCZ6yZ4zu-tcKsdp7diMSLlszm49WqjY_Vvs
Message-ID: <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:38=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> ackport the patch series
> "Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
> to 5.10 lts

Chai,

First of all, I don't think that stable maintainers are picking backports
to 5.10 that were not backported to 6.1 and 5.15.

Second, backporting backing_file as a dependency to LTS kernels is a pretty
intrusive change, so your description above is very much lacking.

Please do not backport backing_file to any of the LTS kernels without provi=
ding
detailed explanation to try and convince the vfs maintainers that you
verified this
bacport is safe for the LTS kernel, because honestly, this looks a bit
risky for me.

Thanks,
Amir.
