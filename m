Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E09399361
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461862; cv=pass; b=qzJsPKuh5m5qU12AYmABYsrdQBeVKcx2dOSpdL0lrrIukJwIP1jIUstoPPgtnLeWass4698sCxqoGSARpHmtfLU55LCzqDTrAmmZG1ar1rKyix2QDraTkucZzlnzXR6cA1F0lNk5G7SWwvF9sBfnkPYVfdEFzTM10PS22OR9oCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461862; c=relaxed/simple;
	bh=fRnswdqVgr+5zYrUkEi5bZmVtkwiBiu0PNZnsbCfZqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBqXWkh3PAzks7phTHavWGOKeZP9+z4FlK+G9a4EA4f9qoY7m7DkX6Mv68Pcqqqgs+g94Xg/HA8irDSyQNlcYZIso1e66iaz9G4Ikr8vFeuLzTaherEEPfjIKL0xPihspuERYmocWcsyYNCS4FBjUQas83i2D9OYHRzeI9CCAcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grxaU9bl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MK7T2J4q; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grxaU9bl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK7T2J4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786461858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
	b=grxaU9blR9wc6PbTjyoE6fhg30TjkeBhTvqnQ1kLeGV9vIok4ny734UGidSIF3iTb5EtgW
	EkU+LnzhT2B07ysjBWxtdmHfqmx4qWf0ojQJby/7KjPLbcaldpCKNqLN5+BfFCnoYKPcnk
	21fE56AJ9RuOO4y6d7izxIunbDy1cPo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-y5WI6KxgM5SgsQDxqU2kSw-1; Tue, 11 Aug 2026 11:24:17 -0400
X-MC-Unique: y5WI6KxgM5SgsQDxqU2kSw-1
X-Mimecast-MFC-AGG-ID: y5WI6KxgM5SgsQDxqU2kSw_1786461856
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-474170b59dfso2062266f8f.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786461856; cv=none;
        d=google.com; s=arc-20260327;
        b=h8JYFHUCsjReGB6tbjWJ+P8NPCcRxwadG4IvKhAdJ3PRlxtRNH+0mBQgJCIdbkFr7P
         LZW79LtDL5Xgmtr3kS84vl+0L5GaWzgVXgKrFx/jZKX3tw+cpvQ97DK3y6kwzshoXup6
         c/4c7LrkKFgyJqo1tS3hAjQLTugPDO9p67dT4bc2E4rhEZ9Nkmn3i0dxI6uxm71v+Z3M
         FsXu7u0l1MGRqWGXps7s2WUFQn2WpmxOF2wIoC6oa8s99N4cnQvyxH8assDAW6RvmipZ
         Rec77e98CCUgwRPBtVP/SSolS9uJVHKpKcO6wzhJl2b9SHYvrSy/zn9A9VhLRcAQxHHi
         fjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
        fh=xZ+rgjocJ3yCSih/aHBly7B0uC+x4lFS+4tpVjCmnUo=;
        b=kb/gQQz4fqATDHACDWFfhy63kfA1pe2WQHhNquK5qnkC2qbKVuQ/9CBer1l/h4jKzf
         SQAwP9LfmCanhUVRGRYe2sGE1qjallsu1SLf7Rj/YxScFRTbB+N9tK5MRE6mvccxq97n
         msgumy7osZWjXoYSR5sdvRh2Ga33ltStUEWQ/Qb1G86592M1uYxbZQqVodmRCV8sidGv
         Nw9czUcuamofuYnSsb6e14CllAbjmhg/6RWUwzviRA/sU+cHOojyma94MbvakGKV+iTl
         gwjcvEQlHD8gQoyTNVD9twTKo6MpJY0pV866DN1IjSFD9cwfB+9Vd7HAuoJGw/POjd9h
         1rBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786461856; x=1787066656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
        b=MK7T2J4q58w9m4SpktMogAMtYTwMp8H04mvhqjl2gUgyfFhON1LYW62yUurnHItbWK
         nUUHol8+aOn8Co+9olildBvxx5y1+sxnMDP1cNIs2CzXiDedoyCsmfAT1zU/lb56a8gB
         +USFlcE1iz7YCHvhytYaRli1+wo4xhmTF/2YLrFFhNA5/W/eqtRU8cyvziegyqaFhnUP
         uEw1Gu+s/EonTe7+j+l2EdUy1GJ/t7O5VbMEQnuA9UchUQV/eb7nUa27Lngfsriy3KD7
         q428mTORT8EOPIE9w7YPOu8vw53tHQAe7TlrU1XlPXIA3o/k6s2UtfNBSsJHb76Enlx7
         5u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461856; x=1787066656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
        b=F9RV7pMxGBrhFtCoNlghNGhAxtei3u6m+oK9i8HfT50nCzsTBOGkWlqtFyiSScyTqX
         VpaxUnpQNDjCql1alLnLdtWliRT2tN/khi5luoYC1NLqjIB2I6IgDn4ATLFryg1jFWly
         tGIyFxJhKqJLcjxJu36bffA3XD2zI7y6c3stB+XqjjONPuVwSJ50sg3OdeKCjItSzMxs
         BN9JAdNOVokf8Ki0IGr3+9viIPpTYCt6YuHW5qvr8M3Zh5sYd4da4jrwNbx5dGLaXs5H
         mk6Bqg7BbxavdlQMqYMNPQChROXKpuU021m7AatzGvUbW7RU21apHNnAUXzzU8v8Bvto
         TcZQ==
X-Gm-Message-State: AOJu0Yyx+7vJjDAb8eGUAhCmOoM/QgVGdHkMtcw8SYMdvMODegxxE76D
	NkczyIusw6nqjaN7MGavy1C1mIs02UOpOARS3Hjs/+0ReZGZPAl0o+DtCkEnh2UWgQZdGQJ2L83
	iAozFZoJMZW7uS/Qq/CNPDWpNZ544You4d2QSCmgUL4mmcvqk0n8xq3enU9KHMAwuv3oyI5rBEW
	+A+1zczWvagZU992egwS/3z3GbEte+jyM8vozKbIj2
X-Gm-Gg: AR+sD138H+APCwJ7neQHDC4O4KRoEtboKxgckFgfNS7GBJI9YHxQlxDWcn4T8rYgKUg
	jXhfDSTWqsgLhq2H9KJcld9IEXq9hkWZVnTbRv3zJaeVzHHAjPgXK8N1uZ4oqAnpfzSM7SGnIxq
	BUxS9BPGj5mWlLn/OMZwtjLaZtAde1mkKWphDE5/q4oraYm/HDXijImTJjv3yixWRs1pJakcyg2
	C9CZVtuplLN42GTbSC0w7B65p/zWZq0lDoWpb4HsetwEhP0i0MOFVtASwI=
X-Received: by 2002:a05:6000:98f:b0:47f:89cd:b48 with SMTP id ffacd0b85a97d-4814ad7558fmr7911722f8f.5.1786461855867;
        Tue, 11 Aug 2026 08:24:15 -0700 (PDT)
X-Received: by 2002:a05:6000:98f:b0:47f:89cd:b48 with SMTP id
 ffacd0b85a97d-4814ad7558fmr7911651f8f.5.1786461855460; Tue, 11 Aug 2026
 08:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
In-Reply-To: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Aug 2026 17:24:02 +0200
X-Gm-Features: AUfX_mxTbpWSPldn7ZElWni078GpwaSEzhZQ_JN6inKC8rBkL401LkB0N5cy4UE
Message-ID: <CABgObfbRQt1H5nEDzL5zCLPKdWDGX348+RcrZpmLSd9QqSJTbA@mail.gmail.com>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete
 root *after* making MMU pages available") / CVE-2026-64561
To: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 3:43=E2=80=AFPM IP over Parrots (with QoS)
<opensource@rfc2549.ca> wrote:
>
> Hi,
>
> Commit 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root
> *after* making MMU pages available"), which landed in 7.2-rc5 and is
> tracked as CVE-2026-64561, does not appear to be present in
> linux-6.1.y as of 6.1.182.
>
> I checked with:
>
>   git log --oneline origin/linux-6.1.y --grep=3D'invalid/obsolete root'
>   git log --oneline origin/linux-6.1.y --grep=3D'2abd5287f083'
>
> Neither returns a match and it doesn't seem to be in the queue.
> The commit message notes the invariant being violated was
> introduced in 5.9 by f95eec9bed76, so 6.1 looks in scope,
> and both hunks sit in direct_page_fault() and FNAME(page_fault)(),
> which appear structurally unchanged on that branch.

Sean already answered about the backport; I will add that upstream
maintainers, as a general rule, do not have the bandwidth to check
which commits are needed in older backports. The older the kernel, the
more we need the help from the community. Especially with the
increased amount of reports we've gotten over the last few months,
*there's no guarantee that LTS kernels get fixes for all
vulnerabilities*. If your distro or fridge is running an old kernel
and is left vulnerable, complain with them.

Paolo

> However the announcement[0] only mentions the fix landing in:
> - 6.6.148
> - 6.12.101
> - 6.18.42
> - 7.1.6
> - 7.2-rc2
>
> Is a 6.1.y backport planned, or was it skipped deliberately?
> The security tracker [1] for the Debian 12 stable kernel (6.1.y)
> shows a vulnerable status.
>
> I do not have a backport to offer, so this is just an inquiry.
> I am happy to build and test a candidate on 6.1 if that would
> be useful.
>
> Thanks,
>
> David Moreau-Simard
>
> [0]: https://lore.kernel.org/linux-cve-announce/2026080401-CVE-2026-64561=
-d0d4@gregkh/T
> [1]: https://security-tracker.debian.org/tracker/CVE-2026-64561
>

