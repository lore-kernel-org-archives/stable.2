Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8D59575B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888939; cv=pass; b=FVu2FLyK0D9yV9mvu7m3fK/PHQy9wwPWuSzcKObHKKcxn2H1zFQ+HS06M4fSJSZ3hgiomjYj3y0sPuD2Dme254NGLFWrfk1PjkTmMOU+JPLdleqhINEB8y3xiRsLhPrDVrHLog/4uiPoHHNjo7wOQJRVP/5KeihqKfz0V7SD56Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888939; c=relaxed/simple;
	bh=24Lw3GJPsJbT9oeWCVSvPsBKcq5jkT3c/KWBCCdcUwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXM7XZSuABjt/8t7JcAe+zGDioZk2azJEDhbJne9TxE9zMpVA+AT+JgGYToS05SEWrF/yBid1BknC0Wh9KFNmJ0ZXGG59FwY/roDGXz8htjYVsnixr0MIHA8QGavY7wLhmQwwME8kywW2V2lJ9woKuiY2Kuqql//UjBI291gXfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNk247IM; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNk247IM"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c255c58156bso988446866b.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 10:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788888934; cv=none;
        d=google.com; s=arc-20260327;
        b=gdLxPx74KbzAtvV3HDlwQCsQwVYiFoS5/fg+1eEosbq2HiCNqrP2YlIVL/7KFBEJAm
         GTIsWzZ+oqSTRH0TEKFiebCmlnuLnzr/jmROqlxeSIzEE6QLSRL1bKFx7RdmCozNsxCS
         U4Mli8Ap5lKCWYxWWJtgp/J+qnxUTfIk64EEaDpijxcb/zG+q47Qxl8TGg4ShjXOMkOe
         8q335p6S61N29IlWA8NX7MVvbrfccSEEv52JRACafjPGcwCoJtQoAaNp3lV0ODoyZHyL
         JC52cz3LAaCld9x+1Wlc0f758/LMA3m9ea0/GfWDkhTke/8/8XQFdJuvooJDHh2aLrsD
         mZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qv8kpOJ+gruMgjflclenRxoAx/cflMIqU2HH0kj8vVE=;
        fh=UoytCFlqe/BokKUvRYwD5BMbj5r269QtxH+hmOC5W1o=;
        b=fNI4uByY/zoXi4kgKvWcFC7DWipPWlyBGYhzeNshd+sMjitZdodnvGCxjQ814w+mZq
         l/LgeAyP/eusNq+PxbmifVvK5qIG+g5lhCOnatzHqh1d+7342j1BOMx+8OkdnrmWJP8d
         cL4UhuLKxBHiBkDr9fhNMNeqjkcH+KcqiQq/F+qQWiacpXHhhNJzGj4BF+21Q444sAey
         rmhb87/zmOnSYwku75qDxSeccqSREpXwlzRRxhMyAwWTRRcQqCIwEFq6xnhDgLya1zoe
         vPLTzkXt8C0LGioZKjyZ92lZkik8vPUdk4IfCMlRHc1hPlCp0g99ym1QXpJS3STLYG5g
         SlCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788888934; x=1789493734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qv8kpOJ+gruMgjflclenRxoAx/cflMIqU2HH0kj8vVE=;
        b=fNk247IMBveoGpGa9KXNQwbiENytvrXHqT/1Y9qzF1v/xMVTuxFGzOppZZmfwXY3CY
         tLLnUya+rzqOPICTByepSB/gGWGOpm8VUn8RSZ/JzdwBJ5s5vwgeHoO7GNhkd0mpQGhS
         MK27M8rr6xTeonR1ZInAnFZJFWmkCt+hexeEuS1U5n0PXiuO0r+Z6nwF6bWbBMrn26YW
         0rCgQ1WtvEq/fuwIRgpwvV1AqdOFHeldhJIGaa5yj9NK3+q/9KijPYKHmaHAoHy7cYAS
         82olgWyiH8T/RWyDxuIHJIOTQ3XWEG4StNBNmVRKYF4JjQWpn1BxZhGSZb+Uq0mLVotd
         y7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888934; x=1789493734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qv8kpOJ+gruMgjflclenRxoAx/cflMIqU2HH0kj8vVE=;
        b=WLI7n3anAO2Avq6GFHbp86Xif3uhgysRL/JEEFw/mFoFR7ufW9qiJ1SJKnHSWCw/KJ
         xIjagZclVP9Lyjv1+yMEjjlIq4JW1jwFT8DHlrOQl3C4CwUjfhW1V5fzYSGx61i5C48i
         kmIA/+dtX0kaCQ6G/Mhq2bhal7UF81EOXBxeIzZ44KYYggagB2OsvARFU1gLaVdekhST
         zcC4ilz5GcgdpgdC7dXf5NajCHMmQ0KB5/R+NpFNSp1nIcmI2VNGmUa846iC8sEkrcek
         zW+9zo2oNowju+6Go0+euTCWANaENBLbZj9+bBRvcOtkyOCHBBeELhXS0NVc7a4+k9qJ
         oPhA==
X-Forwarded-Encrypted: i=1; AKwUvBzawBOqbQuvb4e4xC+ax4j3OuwkwPY4235hJ2LHdLXsJr2NyRf8iZ3U+I3GoLP0pBTJNwwB+/w=@vger.kernel.org
X-Gm-Message-State: AFuF++mkI2PIvu8kSPZEIOnE6Gwvb24Mv8/fP0GPzz9jwCNvcGcn3OPD
	7iOfNmy+BQlA6D1zAfr1x1PKSBOhYtWB577TjBbdXnoASvfzc0TPdDLt84qQO+hl+HS30fCjswN
	0xPtdj1p8jycPdneH9Hfv7UJVVSy1rQb2igU7tFqQ
X-Gm-Gg: AYBFou2Nhs+ogIgZ7x0XGBMEfg5tXh8KBQ3Dvvsd0yU0IGd6uhQXh2268QaFeXcvF6o
	yPdQz/uSDRTDIMQM8ThYGbPISVUZoJ+QkY2SUTNUO8z4J5UnKaMF8k5KDBnEZmEDUx6Y+PzkWo3
	fdRUxiOpRhubthbvY/4Y4TJIMSKvXBZsj30H1WAByUs8jGEK7Vy2fy39ig8lOUJf9oVzZRCcpHN
	+UF57tF8seSKacIhQmrHDf19EvUfEnO0aUtazMP35npy0BhznOopzud0sc+vsy/w8KtXiHYMQyg
	JnL1RbbYW2A2uMEOrBi908enr8ZUrqI9y82RVoPSDIFzrUL+E276czz6bFd9KNWz5ghMEHGzOnX
	DTBJPj1pTQABczCezvBmeeSRYzVoZO0FNkKVu5oHEEXp6YOrlOWrwePVLNvfux/tDV0kIBEFnie
	q4pxqBPcd8Uwdw6fZCHWzKzc8=
X-Received: by 2002:a17:907:6ea7:b0:c25:ee92:2d0d with SMTP id
 a640c23a62f3a-c260c7aaa74mr1073835866b.9.1788888933689; Tue, 08 Sep 2026
 10:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com>
In-Reply-To: <20260908132838.2116068-1-jmattson@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 8 Sep 2026 10:34:56 -0700
X-Gm-Features: AcwNN1Ve1KZrSiuBb6ANCAR-3Emy-6ijikQlC1aPkqvjf2tI8agssARUGoJDI7A
Message-ID: <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:54=E2=80=AFAM Jim Mattson <jmattson@google.com> wr=
ote:
>
> When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
>
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
>
> During process exit, do_exit() calls exit_mm() before closing file
> descriptors, so vCPU destruction runs with current->mm =3D=3D NULL on a
> borrowed lazy TLB active_mm. If the borrowed address space has a writable
> mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's memory=
.
>
> Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason =3D=3D =
-1
> (e.g. during vCPU teardown or SMM entry). In these paths, KVM forces the
> vCPU out of guest mode internally--no architectural VM-exit is delivered
> to L1.
>
> Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush=
 to memory on VMExit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jim Mattson <jmattson@google.com>

Hi Jim,

This patch looks good for a stable backport, but I feel this kind of
bug could easily happen again with the current API.

One simple thing that would have prevented this would be to:
1. Change kvm_write_guest_cached() (and related) to take the vcpu
instead of the kvm, and
2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.

This wouldn't be as suitable for a backport, but I think it's better
for preventing similar classes of bugs. I'm sure you (and
Paolo/Sean/others) will have better ideas. What do you think?

Thank you very much for debugging this. :)
