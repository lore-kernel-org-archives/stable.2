Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9A4D179A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833379; cv=pass; b=DAIaddcSTdHkcXvKJ4Mn2t15UQOqKnADHJf2EnsAxgzb9BtuKgMtaGazvWZTVSxVDZKIRCKtTMwhP2oY2g2FX/xqWIAlY1/Oxky/gYP9ov1uava3PO4robvQHEySz332260BxrNyq0ViVUY3/xzFNW2RRaqVhFSCJW1ie+hGtt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833379; c=relaxed/simple;
	bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhVwqJRnPZoWR2CdTiQ90MePR+kzx0px5Yb3clFJIKmzfEh2+dbGlMGn3bKxj2JVW7QeBUj+NZAYh1OeztZeIC9oX3DJzfP4GAj6nat7RbsqZs4qn71+EO9AjwPoEgxzYwRLXF8ZgBcahTFJ0DP0UI9OmmlI3X49+MEwOEvg9Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Afe/3Zr4; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Afe/3Zr4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso15149a12.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833376; cv=none;
        d=google.com; s=arc-20260327;
        b=UO60L27ALwaER5IIpwNYshYE8WapUUgMBy9eCbr9YjpyOyxiHa9pVW4+d+Ej8lwpQb
         PTlmPXL2soRXKBPfU1hv5r2kL8fwSzADvYnFmEQAfx2KsOmA1cd4PDbZc8g5XgCv8/Vw
         kp3iwF7IRUoto+BSRcm2bIWG+4cUCVO2FxURBNfu5AMup6IN6/lYoXa1UmWyfDwokCAx
         oC7gx6Kcc8Fk4zgO8Wy1+1AUgqmNdRKKgC6uGrDI+T1ONHjALd5zrmagULMt8UQugOhO
         D1eF5K0g76UeiAU0AMlHpj2x/LLoQAsQmv1yRl8GC7ROwsIRvtxkZFugQuWqHkjvV0C7
         gKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        fh=epVwkAgic9vHhWMKKv7oNW/dOuCJlhzb5GM+5paQU2I=;
        b=V8QutJ0XKJEAyN/nPOZ68G0YbXMXUlRl28jna7aM2Wp+BaUYpm72n+V8Z6M8O24IJ6
         zLWkSkuxuKIrjXOZQkYrJFra8dipaYDInbeoy2ReKLI+BQofdQHg3jtvvE03RbM9gKiH
         RpQLnvFnGImI3d3uF3ZDr2O8P+bjZf6UQsM8QlhjQPIJ6UzA81+3kU1GfIvmT1OB4t+l
         DX4bTuKAv8jtiAadLX/ugJTkpvGt9JLWDc3+PRqWZLB8LIFrYB7U7ovz0a3KGNx11cTD
         kttNfUWhav1LeG9d9P8tXmULRyNLAgsK8vghv4c11slMQ1s7k19xBdOdi5vgKO7YuqOc
         4OIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791833376; x=1792438176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        b=Afe/3Zr4ZBhFeXjfVNJcs5SlL8kH9Hf4n+lQ9CVzyQqXgqdq27opBUFIMFZdn2VRCP
         k7yVRUfPkGSbUSMqtxqRmmH8/OXpVZ4uXfJZAbeDOYPxQcJOEYAbB73gJxCGFQc8HJcs
         FK3N9Kez/I5hywoERU+iTFa9YoLWPiLEKMdnQn5Jzx6f6sTgvP9YHszAr8PWKlbGftEl
         s6RHPCMOr+ekjfOVGp3kfBSvmttbwYdICha4KSmjOVKRI2h34OQUMguffv7ogVewEae2
         3YXkRZ13tctZ9CZ3Itwje+mrr3IUm8TnsJEmcTshBjWKi/P4GNtJ10EcSfCDQ/3JtCPy
         HRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833376; x=1792438176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        b=QUoKHniKmTpAL2BF5LLYHXPmJ3bUnxlpUXKOOWPjgIhkGCWAy07eXToS1J5wH9PZZt
         TrQbospOV1Al+3v48Q9RZPgYHiXWWOMh4AyZRC3GaVudS3Y7XMjPuDUGgAywzm621YFn
         ozqnbH8M619brORnjUYvCgm7/6kklo5FtDdVesn0i9HMzgiPEgHtkZT62XPqSFfYl0RU
         QKg5nES6uJ1P96r22/MU1L7bj50n5BpSIrKH07Y07VrinPlRzxkZjN00D7NlBBfsYBrG
         QlpF5BouQKN562WDHakFr8p3gJLjKL8pEqpp8IYybNhOEvi2/Er+ZBm4MT9bW0N2gP8A
         GWgg==
X-Forwarded-Encrypted: i=1; AKwUvByNsXRMQTrwy0LxeriXSNFRQjFI9o30f9I9a6cnQaDByFkrtjfZn76jtQB7qO4wVgxh653oac4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo/5aHRSnrGH1myliDhwS5XaLAr206WSdzFpyGsaTKH3/5x+zI
	G6J64BpvyC3ZzVXm0qy8OPjnrkwDnl8zumTOdPbRqs5DxTMhSvLu/gh2axMsCNQuLCo5K0mX3mR
	+ihstJ29rGe7RqtZ0Z8GQsMnO4pFEdw/xKYJXu1b+
X-Gm-Gg: AYBFou2xzlx7nKoJ0SlJbu5Evi1qz3Z25w599bm9SC1MeV74ah9aAhWMzZGZX/6GCIp
	KUojPpQzdpy8Rq/UpZi0DAXf9MSAqTcZm2P5huXGwJIVq9fIF0tX1pC9FQNK6cG25PjA3jF5NT0
	QaZqcAtIyOGOqa3pS/YxN3dd0UcrG2hJxC+hR/vtgFL4BOpeYVNFZ9Q1Ow4qduUoD9v9XNQDpou
	x8f++6MDabJDBQdyniW9zkmaEARzCxfqjwMWNWdKnVOElyFbzgwW7Ra7sHcwODgpy3Scmw4/w8f
	Gc/beMfim06cFlsb3YQDkmN64feeBSFHR3pl3kSxzDOaPncaTM4ZYww=
X-Received: by 2002:aa7:d58b:0:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b199a610c8mr109200a12.9.1791833375825; Mon, 12 Oct 2026
 12:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-2-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-2-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 12:29:24 -0700
X-Gm-Features: AclHuK_hh2UTJ_clCzObOqLEy25Uk0BI6IitQI982CcGkWt3YHwLApApzuL7Il4
Message-ID: <CALMp9eQB_FmUocuEf8hTYVVWoOTZCWzJ1LhHm__BaVoNX8wKMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	stable@vger.kernel.org, Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:25=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> free_nested() frees vmcs02 but leaves need_sync_vmcs02_to_vmcs12_rare
> set. The flag means that the rare guest fields of vmcs12 are valid
> only in vmcs02. After vmcs02 is freed the flag is wrong.
>
> L1 then executes VMXON and loads a vmcs12 with VMPTRLD. The flag is
> still set, so the first sync copies the rare fields from the new,
> never launched vmcs02 into vmcs12. This sets TR, LDTR, GDTR, IDTR,
> the segment registers and the FS/GS bases to zero in guest memory.
> set_current_vmptr() re-arms the other lazy flags at VMPTRLD. This
> flag has no such point, so VMXOFF is the place to clear it.
>
> A nested Hyper-V follows this sequence when it resumes from
> hibernation. It executes VMXOFF before hibernation. On resume, it
> reloads the VMCS images that winresume restored from the hiberfile.
> VM-entry fails with exit reason 0x80000021 (invalid guest state) and
> the guest hypervisor resets the machine. vmx_leave_nested() also goes
> through free_nested(), so KVM_SET_NESTED_STATE takes the same path.
>
> Clear the flag together with the other nested state.
>
> Fixes: 7952d769c29c ("KVM: nVMX: Sync rarely accessed guest fields only w=
hen needed")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
