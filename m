Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793734842;
	b=jY0PV3OeP/sdwPLy4iAbXK/tecuMDQ7CMyeQ/8Eb30Q+mbmBN/6S51mqanfv/AjF+UJE
	 6j8XU8zHTFovVv3c/DhBkCMnP29fJc7vL63Lcy0DcrbhFpSZYebkh0i/GtukSR9Yqv3m6
	 kEMjBoUqkBVf4zuSm/GmU2iMX/iwWt3KgrEGNM9vMwKmqxxVwb82sAv4dkl2zLhBRZpT4
	 rraCW9QbbaSaRk+sCNxoVTvlp18UoKNqdWejXT48F/Cjuk40KpBOR9nlaEzFrqqgqZ99m
	 L+41X66NJz2wPuYzc2Aue9WExzkzUIJkhmY1QPQTpsfKxpHUSeYO08nZ8L8syP50bvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
	b=B4YrDUYM0QI7Vr+ILUSYx600Y5uJlDcJqZtyIdVZBnjlwQho36LfHdarYqNJiIf7Il+R
	 4aYJHUl8zNTCBx4G/mdvxYvD53+f/Q++DwIx5ZY0AQ0VEt855vd4CsjcUa5sgdSD2GKjo
	 OG7HXnvgW+tmnSDIB6K3wwlwEbV4dakVf5BtXLw/FPD4/SNc7DzOvZvoe2LJVF/sNxlfX
	 0viCaWDTxQwVtJYoKD7RbJwYhurnojDadIMqpvKxjSd0mxIpnPoyxmRDzfdqoba+pE+MJ
	 X89PWttC1XlA/d9/R3aZWQNf+Ang6RrqfkOFNK+E/BGBoS21WtjP3fAXZxg7gonKwZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pT8oYGJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF81606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF81606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pT8oYGJF
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so2067a12.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:40:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793734841; cv=none;
        d=google.com; s=arc-20260327;
        b=SWbNuhvBzHQvZemkKO5U/BmNfiDOHCQB8OOyMgsDsRAmAmcwxegU/rE1/5yaDKwAE7
         4cRi+g9TdqOvvkTFe87MbZoIk692rhanVpNjp5gx5kPbzmFRX3w0PUnLAjPPQoAZ4HtR
         vbQFtPa7GOpQNRhvWjsgQKiJhcmqKJFu1TJumZ3yIqNku5wFXUQdKUd0QKR3W1zmuC99
         pDJCbSvpPOEWjjzwsR3dHzMs29OrhE5W0skgd7GHoYgnKygryNWHjyqYBwY+oeAiAgVd
         n6i7MEPIiDAyMj8d6iERGEUxI/DF35A9G7L6HQxstqopjv5PoV2tDZHX5ENoUcp/E43q
         jJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
        fh=+2ChdOuHiAWZOWAf+yB5uc9sUkPLDxI+q16AtI/V99g=;
        b=fM4rrRUY1/Wzgu6MyCL3Tnzvd7/iWHly7af0/+gMLKnihekfBjRKXYaHBCR6AlqfJO
         vW7fcvkhwsUbvWOrrdBviCRewN/VoT8YKSXLxuCeCPD3Q73+5D0nvfucik8eQQIrDf2k
         vZOxXzngyUHrOepyFpd5CAzuj/gXaNnmUy0aM1tFrfjWQ6qoAhxAO8zYto2WvsZtaZ7Z
         7O5Mjt6jkGzWlge7fq9UsNwO/N4bUnMSn2ZUG/iwT0rSLa65A9wT3GZpzHwVn+BqbBXE
         w4+H2tY17b/6TQ0/OZoO0aGAG+tx/I4XQGMoim2T1wURqIE2/Awm2l4QKtn46NeQb4nQ
         eqMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793734841; x=1794339641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
        b=pT8oYGJFh4OylXN6LyeQXGxqmvowxZqdmP7Y3GI/F86yIdKK61uaZXbx/qqo4fe3LE
         K+10ICcH6HQsz0hOTk4irDRXR09D76sjU72Eo7frk2aJyBkj2dTV3oxzS65+g7fbWTC8
         wqA+FfIIFa350fcZQMunKgAVUt3C05tdFY7Jdp4RiUaQlqlzlIm8cY1WHZBTeMsmEZqE
         S2+gCEq5vSCj9X0osfjThi+pXaT1qJgU+NoTEx3rcxFkyG/2JGCTjrDSb8aM8e2Lh3Ah
         nu1LXgiXKkBl9s62wwdN3yiPrVRzPQZj9DxfH1T+f6cxa236+QxvMVFbUha7FIycQPcC
         tgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734841; x=1794339641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
        b=k9HRpn1o+0TOLquKR5EJOnVgsnnFfgtOSgsYrEQQ3Ts7GChp6+/+MKXvOuVtBZDWLg
         E4QoIDrjbqUEmvE5OvyKnEKOgdHXM9J5aSDyrg8K2XhsL01Zz6Wgh7vct9zM+iz7BUaX
         3PWAFbyCiwWtku3cyA1erNlEjjNBEoM+vIz6JVH0YokgxRdwQ1ZfFJqNoFOu9rQNGZaC
         YV4MM/mTDiwiY3u9rT/Wv8iMr/jsbQgmxSJc0JZmV1lJ8GoeP1LyKk6vW5AkpkkFudZe
         haeGNz22G9iuPtXUyTNwBndjMAIqjIwWald6OjFyC+nhXuF5cz9BootyD2j1ALO87CYr
         Em+w==
X-Forwarded-Encrypted: i=1; AKwUvBwFbsg9tQWJp935jzWQY06TM5JGi2t/4g8w02lTDbJpcu3aASVThgeVRr8/h3sq3bgMX/Hre7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kWbxI8eKWMzZWvM1Uwg2+ojnudTvULT9VV0S8a3/zoozLR/YV
	Baj+8zRPthmuMRKSYa+RS2LKhKK2DMYxOD6GxzGZK/ZXNMK2JqXp4ae18uvfCo4nJGy9y8H+m08
	SXywHL/G26xfvBbmMTuLlbhe+DZ5wJvTRsk8JegtX
X-Gm-Gg: AYBFou1NdlV/SuDo6S5JQiGrwnGqfSSikXmr7qLor3vbJCZAHHI5JmeaIpdcGi2dlIO
	t2TL36JCENxaYF1eRZSkaZmW19xv6i0lv5DZRMssRjEMwSArMV0tbMcMtclZmyNfW7v1mcO8uyh
	QATe6vBOgQpl6BLXnsclC7bmwoTZZLX+WSLxM47g971GSWq1sVcumu61ILp4bFl3lJpkCZJ7HVu
	WNp0gsD9BueAlEpqxCkj2zzAch1DA2Zv/EJQ4N6LgmehJ3iSQg/OG3qMxFJBdapBQMj+vKjcUZV
	i0KTV8lzwb4Z1TGFtpmZlrrRqmq7z4CGTb53pq8+2V22YKzj2BORQfH/8888L2hLSbnJmGxzvh7
	Bh0twUXMspVD7zLuHmpcqYzpAi7klumCorYLPxJ96MwNPJTnTRDUK3C66nQ==
X-Received: by 2002:a05:6402:b15:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b5560924abmr11211a12.7.1793734840182; Tue, 03 Nov 2026
 11:40:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com> <aukmeb9mV8b504T6@google.com>
In-Reply-To: <aukmeb9mV8b504T6@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 3 Nov 2026 11:40:28 -0800
X-Gm-Features: AclHuK-z2TRsVV5-P73NQ-eqccqZjCkcB6JcQTKj-t6dr0cpB0gWLBc8vRzU84k
Message-ID: <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Nov 02, 2026, Jim Mattson wrote:
> > KVM needs to do better.
>
> Meh, KVM is doing pretty darn good, all things considered.  Yeah, this co=
de sucks.
> But I'm not convinced the alternatives suck less.  We've gotten the set o=
f missed
> consistency checks down to effectively zero, module the TPR mess that I d=
o test
> by running warn_on_missed_cc=3Dtrue.

I don't understand the TPR mess. The SDM says, "With the exception of
fields corresponding to virtualized APIC registers (defined in Section
32.1.1), software may modify the virtual-APIC page referenced by the
current VMCS of a logical processor in VMX non-root operation. (This
is an exception to the general requirement given in Section 27.11.4.)"
I would argue that this prohibits changes to VTPR between KVM's
software VM-entry checks and hardware VM-entry to VMCS02. If the
hardware VM-entry fails because VTPR has changed, section 27.11.4
gives KVM the freedom to implement whatever "unpredictable behavior"
we like. Yes, that probably does include loading MSR values from the
VM-exit MSR-load list, but why complicate things?

Something like returning to userspace with
KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an active
VTPR seems far easier--and cleaner. What am I missing?
