Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069E3515D1
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907493; cv=pass; b=SYBd7Ju99zKKrIirKYph+EmQYQr/J8qUY8I2Pd6koevYyvxx6tPnHsJWSecmcawfnEN2iYCfz2vPeh84PPX2C62eLA1AenB+0qGxW4ZK3B2TB3eDnJhMRnb1M/Czdqjj1aabD8h1VYMJaQuiz/h54ANSTyO4U1jAcdxWW9D3M78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907493; c=relaxed/simple;
	bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uSAzKtz32ZauaYxEKGqDoqQXysqpnc6cKT+yOk8uk5LPq0CIQqn8X3QG4i82/Lh3KPIPQPEnzBtvq8BdpkMW5ta6UZ+2AuJDi3y62xv0IV5AXyKZHI6cpAEgyvWvQZacVMAg33mJZHrfLRaKtoD1DKLk7mkiTwj4HtZJBXqVJ74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ven2Bbg0; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ven2Bbg0"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69e08ad526cso628297a12.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907490; cv=none;
        d=google.com; s=arc-20260327;
        b=b30z9HnS7qGotk+TU2JO1i4d7jTUqIGnyGQ4Jf89yODz0F6U3IwvJ9TeYy68X4IZmi
         5zqJdC6IUzROKgAsVttD+2tUFy8TkZbfkDU5tZGRZq0dlxCOx9o1F9Snd0K3h/TTGzB9
         hiuKTi/h5TKkmiUUrHAqFYrIRDBNSNMDLZ300LSmbyoVijz+DR0k8/hnHU+pBh1o6/QE
         pv0RLJfGiuP9egTiy2CzKSKcjdIxGQELTOK2AUsBydgrPbmDQGWLZLWmBCRQd3QStkUo
         XrseHr2tGbShkBmLRvGijurwdFMsz63hqpevx4AmFC3HmPsNfbwKHdpC1OpUZW79Akk3
         vUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
        fh=Yd7QxrYjoTu4beKhyz07OxYZeZ/K4sZSSM4vHme6x+k=;
        b=HqaZL3X0tux8ljEMjE/PyCr2SeklK4TfRTe8CekHpuWNSHu1ZjkCKt2mExn8OqPwsB
         9m2t0Bi2b/lzNmE6S7ksjrfZI9c0nUHKk9dpAkIoirPEvCpJiWuPrdIZtQJH9in6ZMsN
         EeXZ9yp/pIBPF+xTjrGfxKanVIwDsDTo5Zp6QrahmL4OwwmMsdv4nMmmL86Sr6QUmgK3
         OyPuF0hjLOnz5n0Z0Gy+7v8zv0ZVxEGB1hB+8F7m+jtcDEzuZdEQWPbR4gE3W7GdQ5hH
         y1bifZ4voASVDi4ZLB1E/QvRqeSCb9gYwdOXyPISkN2DS4jKWRbYVq7M1lLy6jjWDVfp
         rkag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784907490; x=1785512290; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
        b=Ven2Bbg0WIHLL/mhuqbj2hWmLIoyL6ZpmjrDCc0DkMO7uCkfQlvtQmAO8O/PUc4T0F
         Y+7ILgFjHvLbm74JYM5Hvgp8X8ULJ7iUH/VsU9lK6UnzPTWtD7xoIX0ukDC4Ykv/JL1o
         eqTDbGl22tfgv1f8BIfVFsOSH6u8n0l1hapXQtP9rQ60We0u5KpmJ+NCoywObcYmffnU
         pMCjmgcE+hBByOuM9C1nozbTnuXqcSnPM7ErLsRHzx9p9qcgjpAoPNQmNt2JvKqkgT7r
         WHIl47EyRK5WbvilW97rjjzGHYkccLKRXoJzZ1lztozTvR+dG80uXeDo6Y+V62fmc+jJ
         ztcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907490; x=1785512290;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
        b=e+JL/Ka0KEOChxWKC5oncDgEwz0qackYOm+k3I1s1JZ94Q4s57Dm8zrXC+kj0k+TKi
         EuuYjhRckg4jgHfJvXmzl+PxZHKaeaLbvM6DqPF+N1NspDqvadUbWuKLHT3+rsmVYm0V
         fsOR+u71nGd2EdbLQpBaCe8nENZSJJwLkULh8/nlw+rJo65JqQgELU0scBoG5Dusfpzt
         z+EPlHa3J7qHsKq++aQCDQF3fYPv9bO9/XkprjutG3D3YzpPrAr+nIKRAT/XySkYeTcx
         trFBuUhTUUYaVk+D76aO4YmdUTZC+hGYI7i7X419kXaqzG4CSe92+7wUhOyW0g1ELL/a
         PsMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzH2es3eDAjdZelhvRXLYQHBhVUYbtnPazo5U2dr7QqJHoMoZagd3UnR2903HsZiFuvvn9sEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pOpqdHfl8SwctBbL+A2oZ39TMb9GsMwhWgT08XrsmwdHMY/H
	dCPHR5QVTjWa2Dj8bwTGq970tqft+N4Gn8Cb4QStf+ALVD9KTjESXTCChd9NGS4UHoGQ6eGXw3k
	5JIWA/DfN93rLyqvuRMWL0yD5ovyhXi4=
X-Gm-Gg: AR+sD10Kq84SUMryVcEK1w93WZqRdBemuud3KPVmfHRD3NNrfVplreF+a82JNC9o7Q9
	E8ePD8UEOKZOUdfwaGvXgTr95LuvQAacqVlO1xhaby+3nuSNQTmt4qh0z4ChICqnxfMkBLCwso2
	KGa5AMnDcsFJEhdXWDJhf/l3TU/53Cet8Gekx9Az+s54wgmzyD4UJpfFe9sxEFkhTJh8Wh3/zOK
	/yM3pJnJPAqfIrKYUbXdgHrw2n6jwa4DESaLv1zm2IG3O/NiEdIPsqb9FLDXx6kZpmWjpLnqUPr
	yh/2I++HUbH1u+GYPLc=
X-Received: by 2002:a05:6402:847:b0:698:ac05:5b2f with SMTP id
 4fb4d7f45d1cf-69f6b143145mr3254860a12.4.1784907489864; Fri, 24 Jul 2026
 08:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 24 Jul 2026 08:37:58 -0700
X-Gm-Features: AUfX_mzU7u5uNdXumU_vcZlVt2HDSLvNSuujJoCvOQwTQn5iM4qD_F0D9lRlIvU
Message-ID: <CAKSQd8V=wfVrUxeU+fDRgKJBLdiyCkkY2SRY+OoRBNE68LFnCg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	pbonzini@redhat.com, stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

> My understanding is that the revert was considered because TF32 never
> reached any implementation. If that's incorrect, I'd certainly welcome a
> correction.

Both TF32 and TRANSPOSE made it into a product that shipped.

Not from Intel... but.

So their CPUID feature flags and their opcodes aren't reclaimable
and efforts to rip out their software support are counterproductive.

That is all I can say.

--
C.
