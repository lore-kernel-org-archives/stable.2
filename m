Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705E3D45FE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693237; cv=none; b=jD+p0tZnfl+SnXz/GIQuI0FgHlFcb5EtBF9lC2UcK97YOqedhrMguGeIcZSUeGM9XjcRoTZla+g3Fl6uuvoWrH/sjmCmCP9pLW3+8bwvx9rjs1++D6YOfBuQlB2WuZQ3aeLj4hp+mkBtCUy01dCTo16cxBlpQpbFa5li/Qa5khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693237; c=relaxed/simple;
	bh=PaHoAXPcrpcqQeGw4Tb6R83pqd8LYLw0tH22EeiqQ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3F0/0GxEKyJ+qTPwClgXeghCLtw05oikwkGVZ5hE0VueafF93aggaEZJ0Wcz+fj8vAdZVjLhgsQHMDjyGojBZ4P8eG49q3xx8z6AkuHdRrpse2UruUcit11qf/L73jxv+7FsavcPlN4TvndJv486QvA13E+oQuAxbo/G5YDPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KyHbqqjP; arc=none smtp.client-ip=91.218.175.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KyHbqqjP"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PaHoAXPcrpcqQeGw4Tb6R83pqd8LYLw0tH22EeiqQ8E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790693231; v=1; x=1791298031;
 b=KyHbqqjPWvtl0nfZ854sy61IxM7VlJfp9BMUTCk7kyqXIcQWgdlKjYmm956T99rVu0xxGGkI
 NGhEjw9GDYwycFBr7wyzBMkxnL2miywpQJFKgTHbxBkCoMO7+3FWqDscqTjh402IY/bn+439spB
 jz4+Lh5pZ6Ca6RWXl56DY9Pg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3e25ca576f8389c8;
	Tue, 29 Sep 2026 14:47:11 +0000
X-Mizu-Trace-ID: 3e25ca576f8389c8
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b8ea0ca5baso8722e87.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxO1Mk03NzOxjmpq+SBKzAjzOouYJOmZQJB21XAaNZzruk1VgJNSxb9PARlXBx2/QbivD6h4ao=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCrtDxmS9cZDAuO+S705naC9Ka1Q3+qyvv/GHq5iV6ph+klpzG
	F0ELy31PuFWaxYjPxV/iOP6lS0rxuYPTB0S4QepMP88C9h58NNsQXV5qG32Z/CzNjNdbx6nXQjO
	Aa4BDczrr5N7anchdLyPttGrgTYDtKInTZNGLQA1l
X-Received: by 2002:a05:6512:4015:b0:5ba:3797:2359 with SMTP id
 2adb3069b0e04-5ba37972460mr33642e87.2.1790693229297; Tue, 29 Sep 2026
 07:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929093548.3598547-1-maz@kernel.org> <20260929093548.3598547-2-maz@kernel.org>
 <CA+EHjTwZSFUZmavbB4tE-eFxHg9WF80CA230EwvynuNcZQ0prg@mail.gmail.com> <86a4p0403b.wl-maz@kernel.org>
In-Reply-To: <86a4p0403b.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 29 Sep 2026 15:46:33 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyuXSLw8kfRu4QB5+UdrTzc=LVQdWs+SHPvGA1NS-wySQ@mail.gmail.com>
X-Gm-Features: AclHuK-PJma5Gz1v-jtnuLZMTzpONJmBik9WyxHWow9PmByLldd07rhmiNwGARY
Message-ID: <CA+EHjTyuXSLw8kfRu4QB5+UdrTzc=LVQdWs+SHPvGA1NS-wySQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication
 past context being saved
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Yuchao Zhang <ndaugoing@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Tue, 29 Sep 2026 15:13:28 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> However, there is a problem if cmpxchg() fails, as there is no
> ordering in that case, and I'm not sure the smp_mb__before_atomic()
> saves the bacon in that case. It feels we'd need an acquire
> somewhere, a bit like this:

It doesn't save the bacon. I ran it through herd7 with the LKMM, the
fold walk in vgic_v3_fold_lr_state() against the list_del() in
vgic_flush_pending_lpis(): with smp_mb__before_atomic() and a failing
cmpxchg(), the walk can see the list_del(). With your
smp_load_acquire() it can't.

[...]
> We need a release so that we know for sure that any state stored
> before is visible by the time we can observe OUTSIDE_GUEST_MODE, and
> WRITE_ONCE() doesn't provide that (it can be reordered).
>
> I don't see what taking a lock changes to the ordering requirement.

The fold walk takes no lock, so the locks on the halt side don't order
it against the list_del(). herd7 agrees: WRITE_ONCE() with your
acquire can see the list_del() again.

[...]
> I don't understand what sashiko is trying to say, but this is clearly
> missing from the patch, see below. Not sure how I missed that one.

I don't understand Sashiko half of the time either :) That said, the
diff looks right to me.

Cheers,
/fuad
