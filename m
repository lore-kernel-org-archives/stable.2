Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600718;
	b=ZlpfwDLjD7Pik9+2LWQ6BL3X8rCpMBhVQg15qNIz1LJcNk5khhq0UfjghVsMrGXNThT+
	 FKn1xyj1H9nIvwBesz0n24YpYLjeRDwq9LL0MFIG0qWfPHcatP9CLUa3L5WTMgKlIzIUY
	 W+4gp8aAaLSbVUGl9NDPIc/gOphpvVUd8S573d7yjZ66k/38QbJxDqmhlo3isLOk/ckey
	 eGQjAiVALxliOqbXmuEMbyGXX9vXEu0/+Y9PRzx9zvwX+FBBBSGKay77xf8IEWRPe6MXM
	 KidJ++CDBFrOv+QqRXZXqXk21WLH5cUdZGwpbibOKFje+pGqL6VHAKZpiyu/cuW4amA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=1UD/fxzUT0tjfssdFOdd5M1pCrEUV3tIjK+qrLIpIpw=;
	b=QTaIdyrkaT/ro7lGUle7mfm3v07JlxeKqjRbqHQ1nj70pntP6GZXIZlF4Bw/RBwa7UEw
	 hH9alZdgOJdpcJyRmpV1pIkn1h5PtZM4br9g5cqe3d2y+2A5zZ+iGaX6rJ9caibadPiVR
	 Uzkmz8sZ5yB/KDz3ZXlxKmhf2hMHy15U7MFzkrEXn3sbsRzIDJkMJcThd4ipqop6k42Fb
	 CFZdiHbuzdAUHPXoGPDD4aAeZbB/WW8XgxwQ1ejB9DOjVj/EauNqU05zmUgN8H8qLWtMu
	 oUpdQC5rfEdhdbIQsv4YhmoeKVZ/VSlKiSfR07/YfhYCzaqvgCAGjWobYcGwme8D5EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fys/RInJ";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B5606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8B5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fys/RInJ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38431138772so7172732eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600717; x=1796205517; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1UD/fxzUT0tjfssdFOdd5M1pCrEUV3tIjK+qrLIpIpw=;
        b=fys/RInJOM+KHowyp/0+bp6mIOdw17l/KGAP5Hu8FUU9jepLarKea785/2Unj5x2zX
         PKfyXjkBIquOhWWotnJNPdSocuX5G+ajBq27L0xeZvW1xoZwiCDunhgwui+vT3Ko+xdf
         2RChKewf23S27TRhHB86w9pUuXg0RVmEUOpFVHY1WPqwxKva8qIc/EwuDOH0PzPjavoz
         pLzkl44Gr8M58NQ6EVZ9BK19KXOARF36lK8q7Xu126oWzJVMP9hfLMNmhM02W7Et+Ym1
         /CK+3hx0rW+i2D+/rfPpARvlQI9b2hxoBGYUFhARasRTp5BJNKv/xuG/kbvsuo2upaw/
         bVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600717; x=1796205517;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UD/fxzUT0tjfssdFOdd5M1pCrEUV3tIjK+qrLIpIpw=;
        b=uvnpOk5/dsutHIUbbCthlZaRozq9DHAEm6NrXJd6r7RL8NMubuJ50MSukOyyy741d9
         1cyRHKWwND+vXQvYdqDnecXfY380rz3eno5k346i+w/4rTKuGLkGH14XOFV7/6CtAWEi
         uxhFdADCezIhD/ZfXtZMq4MHKS+hVdkRE+3mZ2eUe1kB2wR8GRyEGH7yL++z89kDmOI5
         vkpGij3VuJFB3q81mwd2yUR+u9w+r5Tq7Kwf/CyXLPxRUWIXfr1nXR1+CtOOMC2n6IDN
         GcjQMLd/HOOLfl0HYMVMhVl9xPLji27j2wPeXE0xTOa52+QbY9xv1oAGr2K5h/uOSfl+
         JDhg==
X-Forwarded-Encrypted: i=1; AL+hErGit4gw20tjOS8iKAfm6+Var2TcRURTXZwD2A2M6FNj/Gd6otu0O6k/F8Q/r/sU/gTxsF8wN7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BI5TqLCgTLI7uwsPxcc72tNrrbS3cOHPUhZBgDQb9rySwG2h7
	e6CQ1LJk3wwVs03jpgrdKIYSye50hdcF2Q3weLRU6WUWrAE7ZCL5BZqMK6rdlg==
X-Gm-Gg: AZFdTZfmsJPvjWWBnWzg8MtdvRosE9OOzoNnrGkcdYwlm54JDOUEw9/3abE3hldgRax
	uhOWhbsjoMHzfikXPF8rljgtiyiw+PqAdE+UmPG+8cUK6E4Gyn+x7ubriLxgIvYJInX0ix0pRI2
	p2FGYqrZ3dd9cDDrqWVb4sXHpW5OohyISIKVkwQHUhk7Whwtp5jPn0bTVGTVl6ULh6wHim8X7F4
	xK4RKhzTTHh1m5VhDbDjThspL3oXoQiAXBC3aaNeOj3dSAIahnAY4fAIn9rnU9VUWyoSesULqNM
	tfIWXaNxlCWTJbHUShc0WiQHTVj/1aBLulWxUlVkc0fZO9FDMNU9rIIu28KnSePCHI0b44awpKE
	RcqxcdeEVpeTujoAqYtcG6wAHeGtzVhxO9cRqbPTQpkFPZBrRqywmkeDVtQydKZq4KJQ75ju1bI
	gHsnGCLn2FOS+qjIr3/6Us+RQ9ilf6Y0DqNYu4bBcMa/r1DZl29FU0V5dSpGv0Y12NdI+42iN8f
	WZvLgN+EkfKsEp93P2RUFXbE9rQtDTzqsNsPRB1MViUpVXVlBO4hUZ3pnbf/Cg+rFpQL5wzusDm
	nvGC0Kfsm70gc24XvA30NwI2p+/M
X-Received: by 2002:a05:7301:e103:b0:385:496e:80ac with SMTP id 5a478bee46e88-3856fe59334mr19973566eec.8.1795600716629;
        Wed, 25 Nov 2026 01:58:36 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm26470301eec.18.2026.11.25.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:58:35 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
In-Reply-To: <awZ4ZhK1GFHKi9Tr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Date: Wed, 25 Nov 2026 15:18:30 +0530
Message-ID: <pkvtjl75.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com> <awZ4ZhK1GFHKi9Tr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:

> On Mon, Nov 23, 2026 at 07:21:53PM +0530, Ritesh Harjani (IBM) wrote:
>> kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
>> gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
>> perf_pmu_register() fails we return without freeing them.
>> 
>> Call kvmppc_cleanup_hostwide() on that error path.
>> 
>> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
>> index a58634f656e9..ec05b4855736 100644
>> --- a/arch/powerpc/perf/kvm-hv-pmu.c
>> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
>> @@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)
>> 
>>  		/* Register the pmu */
>>  		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
>> -		if (rc)
>> +		if (rc) {
>> +			kvmppc_cleanup_hostwide();
> Just a question.
> Inside this function, should we also take lock just to set the pointers
> NULL rather than putting the whole logic(free also) inside the lock like
> we did in previous patch?
>

In the previous patch, we brought GFP_KERNEL (sleepable) allocation
outside of atomic context. However, in here, there is no harm in keeping
the lock to assign the null values to pointers. But I guess what you are
suggesting is - Do we need to keep the lock around in the cleanup? Looks
like no, we don't, since if the perf pmu register failed then we won't
get a perf pmu update event for this - which is the only other user of
this lock which can race.

However, this patch is mostly an error handling fix (reported as a bug
by Sashiko). One can pickup the cleanup of that path as a separate
patch.  There is also a powerpc wide clang's context analysis work that
is going on, so as part of that - we could maybe optimize away taking of
the lock in kvmppc_cleanup_hostwide() as well. As for this patch series,
I think let's go with this, as most of the patches in the series are
with Fixes tag to be backported.


> Apart from this, all looks good.
>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Thanks for the review!

