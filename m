Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636093;
	b=pDwQqJFgi6Is2OEpHW226WrfRFsT7mXoSPXwtxxf819AHEgzJlITYLIUXqJq1d5Vld4R
	 OqnoL+xFQE8nTZL60iVugBnyHbh1ibFDdkAjYiF3QKodZDvrcjaEey7Lz3owxS2+bflqY
	 E+ex0HAVREGAkcp9IVUQByXz+8ghrqRcEuc8NMXGsTWy5oOMIBUm/Bk7BSPKdEA8gaOd2
	 Pt7KcqjE2VjErPX+w0bviivo8MVaZBmMBCFWRvBgj6lDFQuLLTYApx6mnegKExGZBd/Z8
	 zVgfr+chhG28jBnUSNeQCq9utDaJhCWD6Q4Upor7nsn4ah9KG7HJOEHPPCZVdf8bY5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:From:To:Subject:Date:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=xruEMXmxKsYyy3/7Uv5aUsYVZ6xRBTshqU8cnD7X6m8=;
	b=SUMRkhYGmtfgilPvO/9v6jOlICWtSWrkroMOcyjqC99qaKW8f/OgsvbyObtQ4iNKo78i
	 o3MzfGa9v8EMqBed693vOtJN9j7qMxsjECNc9jR5zBNKgBdVoMlpPysOIviPsvlVi0ybl
	 IPtfFouFCSMvLsKQbt8FTtMXkbF2SrlAPaim9M0eWbqh4FUJ92oNhEQ/RgtcRwZ3uIwik
	 HmU7uusCfGnuUIcyOSQuDxSr4FFa09GabM7j5Xp8rR3UNHcePq68LA5RQTMvH6iqF+yTT
	 e1wfJNjHYiuMATso/8NNQbAYMxJmjxxOlyOucpZUqcVPUyOutluECX0P6GDGaI0gHkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utexas.edu;
	spf=pass smtp.mailfrom=utexas.edu;
	dkim=pass header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=nXBXmYpB;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00560606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00560606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=nXBXmYpB
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6d290b10a35so607824eaf.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1792636091; x=1793240891; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:cc:date:subject:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xruEMXmxKsYyy3/7Uv5aUsYVZ6xRBTshqU8cnD7X6m8=;
        b=nXBXmYpBirikcttyx9/5JLJT4vDIsSgTxxKc2Q+QM0P/YSHZVvJlli/wRgaW6jlwIJ
         8gx+AYrpMZRCMw7qLUaMlg2yRrJo7k30lyCmwZzaeOHYU5b9NuXF1kSZmY7Un26bKGFn
         ppwkRPzNEWkIv23LWxaLgs/glqQYstb1P19e1btE4ajwkgKywl59wDcz5Jy5VQUsYEiQ
         B+KdRJE906oj/8ryBUMc2NdKfo4YMajjBqVxWoy89MxzxuTAl4Cd0y3yv1pI9JFjzNWe
         3jYE5hrslakvLkCPbW8dZr/kWE8tjNUsDoG9aeTtgHbSwFwmmZVIk8iQbP1Z01jdbQMZ
         ozow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636091; x=1793240891;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:cc:date:subject:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xruEMXmxKsYyy3/7Uv5aUsYVZ6xRBTshqU8cnD7X6m8=;
        b=VwnSMvI6SrMsvUvpZ2tbeHzSqbictxvGAkkGGZS5/kJQyN5EUibSqmrTDT7SNBJkd1
         YbxaQQpTuogFXhBhaLaX/8G8egw8a9Rd8S3OaYWsfCSBtI7F8dEbVi5VfS4sxCDnYF4f
         yTZiUJvXyRDomd9aPQUgdqtIeXxZ+TYYcb0A1K0tLG7STukIcTs8dpSJL86SqVYh583w
         QPsHIlvXRbAaCIR3JUy7Zhk/m5CN7xuM6+EbLxdJG2s/pkWet25n6BFwQV7cvNq2rfRt
         qArmrG3nzXCSVmBjEQF0RewLz0zxtga62L0nBs/XEneqZjbXG+na92Yy7y65Usl4Z5oI
         mR4w==
X-Forwarded-Encrypted: i=1; AKwUvBz5OxOFADq9mx9fQLZfzNeXy0olOW/TC/cjcuTb19I7C9Nuju18GuYfPYsDwgbjefufposI8Hw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgNy+6IMwlGd1rUKmFW9O01I+CjAKmFM/LVRqwQrtIP/fo/FA7
	PTbeB3ntLqY1IrCQHShl/mEaFT/1aExC0LIJ6LmF+U7a9pse+AUui8vRZc4WGyP/vTZfw59+Dd1
	rpFNLaJjsxg==
X-Gm-Gg: AYBFou0a7RcwepeCUfgHQ6ecMD89OR3ofNZm5253cNOuVfWcLIDFrRfP4m2oBVL+xPD
	IGhDn9CHFfng6FH53WSREnAt+bDcM1EOb7B+9KPcY4pvZhsDJ3v8DIpu2tCtobnHHIw9WGy/Ht9
	CnIAlHvHTtEakuQix03fPtGdoa2C8Sc39ERHGmz745A6Wgam6PO/iUMR8h0nG24goBglkraEYPa
	j/MGBofL1TpXYBMssvI2Bchimq0J5zvNr3ftKo2dIrsqx9hmVbW1QKlA33IOd5CeMdeG2nbGIUe
	1+dpBkofVXqIiikAbB7/WT0njlEIpEMOKxxSzOQ5pIqwBW85fvQ8STZX7A7/HFJv3VzpS15pry3
	3tDGjVOfxSiiPBtIObOxEKeIgrwENUs/TgZ00/f5OI+e4/DSEZtZFmjuqPAL/KORCR3YxOwCQSc
	iq4Yvk460QwZlXKZgJ8bWLozQ6r/BgZ+UzkKqFnfqYwddQeds2Ok6fqQDJ5NQJ/6H+KND5KzRHZ
	Q1uAOEQVBJUq/ldPI5lqE8gWkqCx9tEDgFVq5ddhwcKt/NVBpJ+dbE4coqWLBC92WTZUn9AtTV+
	kJwNpIv6sA4NIUqNSKMQJHvn32//z9XS45DZnqZ7201vJnC1PLNYiTZEt4J22w3W3PT6Wbq+n2r
	ZdUj4ClWXEdgx79GZrDXuQRNrPPxST/h+xKsID2umxwNLsjUL2fwPtpmXXPN8MGkaz7MzDb/0W0
	owaiqpUD3YUYGtGVtKwOM=
X-Received: by 2002:a05:6820:813:b0:6b7:8396:f3d6 with SMTP id 006d021491bc7-70941fbb729mr2897081eaf.56.1792636090730;
        Wed, 21 Oct 2026 19:28:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([173.174.112.101])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm3431624fac.1.2026.10.21.19.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:28:10 -0700 (PDT)
Message-ID: <6ad974ba.a8122b97.39a7e6.f867@mx.google.com>
From: karim.sabar@utexas.edu
To: matthew.brost@intel.com
Subject:
 Re: [PATCH] drm/xe: Use kvmalloc for the VMA ops page-table update array
Date: Wed, 21 Oct 2026 21:28:08 -0500
Cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <atkLLH47Zd6vMX3B@gsse-cloud1.jf.intel.com>
References: <atkLLH47Zd6vMX3B@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hey Matthew!

Sounds good to me, the fallback of trying to bind the vma one at a time sound=
s good to me. And it is actually a bit broader than my patch since it covers =
the -ENOBUFS case as well. It should also be easy to get through drm-xe-fixes=
 and then backported the normal way.

I can write it as a v2 & test it on my Panther Lake device, I have a small re=
pro that does about 20,000 mappings and fails after suspend (every time witho=
ut the fix). If you'd prefer to write it, I can test your patch as well.

Thanks,
Karim

On Wed, 21 Oct 2026 11:57:48 -0700, Matthew Brost wrote:
> On Tue, Oct 20, 2026 at 07:08:27PM -0500, karim.sabar@utexas.edu wrote:
>> From: Karim Sabar <karim.sabar@utexas.edu>
>>=20
>
> Thanks for the patch. I do see the problem in the old code.
> Unfortunately, we will not be able to pull this into drm-xe-next or
> drm-xe-fixes, as 7.3 is already out and 0e33330f1238 is included in our
> 7.4 PR. As a result, this would need to go directly to stable.
>
> There is also a risk that predates the series containing 0e33330f1238.
> If the bind has to run on the GPU, you can still get -ENOBUFS later in
> the bind pipeline if the bind is too large to fit into the
> migration-layer BB. If that occurs, the proper fix may actually be in
> xe_vm_validate_rebind(). If xe_vm_rebind() fails with -ENOBUFS or
> -ENOMEM, we could call a new function, such as xe_vm_rebind_iterative(),
> which would run each VMA requiring a rebind in its own job. This is
> effectively what Mesa does in userspace when a bind operation returns
> -ENOBUFS.
>
> We could probably still pull that approach into drm-xe-fixes + have
> naturally backport to stable, and it may ultimately be the better
> solution.
>
> Let me know what you think. I can give this an RB, but I'd like to hold
> off until we've settled on the solution we want to pursue here.
>
> Matt
>
>> Big games die after every s2idle resume on flat-CCS iGPUs. The exec
>> ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.
>>=20
>> On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
>> these parts. On resume the first exec rebinds every VMA in one go and
>> xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
>> Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
>> array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed.
>> __GFP_NOWARN keeps it out of dmesg.
>>=20
>> Data from a Panther Lake handheld (SteamOS kernel 7.2.7), kretprobes
>> after resume:
>>   xe_vma_ops_alloc  -ENOMEM on 63 of 63 attempts
>>   xe_vm_rebind      -ENOMEM on 63 of 63 attempts
>>   BO validate, TTM populate, PT prepare  never failed
>>=20
>> The array is only used by the CPU and doesn't need to be contiguous.
>> This switches it to kvmalloc and kvfree.
>>=20
>> With the same change applied as a module on that kernel, the game
>> survives every sleep I tried with zero ENOMEM. The biggest array was
>> 30,753 ops (11.8 MB).
>>=20
>> drm-xe-next already does this through commit 0e33330f1238 ("drm/xe: Add
>> struct xe_pt_job_ops"), but that's part of a big series that won't go
>> to stable.
>>=20
>> I tracked this down and tested it on my own device. I used an AI
>> assistant to help with the debugging, i.e the kprobe tracing and
>> reading through the xe code. I ran every test, picked the fix and
>> reviewed the change myself.
>>=20
>> What I couldn't do: this is build-tested on drm-xe-fixes but only
>> run-tested on the SteamOS 7.2.7 kernel through an equivalent module,
>> not on a mainline kernel.
>>=20
>> Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
>> Cc: stable@vger.kernel.org # v6.11+
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
>> ---
>> Downstream SteamOS report with the same data: https://github.com/ValveSoft=
ware/SteamOS/issues/2962
>> ---
>>  drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 99e42bd29..5caef443b 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -703,9 +703,9 @@ static int xe_vma_ops_alloc(struct xe_vma_ops *vops, b=
ool array_of_binds)
>>  			continue;
>> =20
>>  		vops->pt_update_ops[i].ops =3D
>> -			kmalloc_objs(*vops->pt_update_ops[i].ops,
>> -				     vops->pt_update_ops[i].num_ops,
>> -				     GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>> +			kvmalloc_objs(*vops->pt_update_ops[i].ops,
>> +				      vops->pt_update_ops[i].num_ops,
>> +				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>>  		if (!vops->pt_update_ops[i].ops)
>>  			return array_of_binds ? -ENOBUFS : -ENOMEM;
>>  	}
>> @@ -742,7 +742,7 @@ static void xe_vma_ops_fini(struct xe_vma_ops *vops)
>>  	xe_vma_svm_prefetch_ops_fini(vops);
>> =20
>>  	for (i =3D 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
>> -		kfree(vops->pt_update_ops[i].ops);
>> +		kvfree(vops->pt_update_ops[i].ops);
>>  }
>> =20
>>  static void xe_vma_ops_incr_pt_update_ops(struct xe_vma_ops *vops, u8 til=
e_mask, int inc_val)
>>=20
>> ---
>> base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
>> change-id: 20261020-xe-kvmalloc-vma-ops-2637ebf81cfd
>>=20
>> Best regards,
>> -- =20
>> Karim Sabar <karim.sabar@utexas.edu>
>>
