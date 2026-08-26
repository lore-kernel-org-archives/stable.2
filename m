Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0A41B8EB
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749911; cv=none; b=r6Gz3Yz38mpvJkKHu8VruGnSaQD3sCIkHgl9jGX7c2EebCUt5LRLj/Dy7btlR4NRF1ju+NkPt7F1Feo9rxFU1YuDmm1OCmmufC+YlB+KvC8YyceUB1yiaDJJUDSniQwu9QCZoz9GU23TYHIaqwdU8Xs2cXYHrDga+UWmdvi92FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749911; c=relaxed/simple;
	bh=iYXUe0s8goeacHQlmKJ3f9w79aXm+BLB+1SI5FmNLhs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJzQIg0osSNME0ifXUS7VpA/2kHjCLIK4Or/j/OyO9/BHu62ak86iPHDy8ZXLkKTY7PnzvzXfmQjrf9FqHmP2iFOUHxE5QWqt2qKOUNALnXy6FIgdA5nPJtGv0qdt6dXVsG118bDWC/sLinYop1S4APn/I1pS0a37Chqcqo0/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHcOEytK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHcOEytK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c207cb16cf5so136028166b.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787749908; x=1788354708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7M5t9v5XwKSZ3VZcQrdmnixl9ZSmqbJvPFx6wEt+sCo=;
        b=UHcOEytKwqTrP3/bYCFJYliOVV16KXbK4jB07J+DBzs1nHlo/HpmkzDDeYAWMPpmDk
         F4mk8jncnnay3idLSKlr54JYrRHfs9sci+n72qoQhNbsYJ4fU6APFW1sDTij+nVKdvBK
         963ARIFZdSp1SY1WwIsY44rQ9zBowd2MRtl/p8rAaJUQpoW/HF5FYGqf8n7Fca/VcaR/
         EPyrZkiBF7VyfGY3NJPBo5ntwgp3tuWWXUs61iaMP/V9m14ZPGGT7cmTivHX3D168z8J
         clemAPbXxJ/lOTevAT01WcXMN947RngN7wdj5AiAus0fGQ9GP25pu7dCix8TM9Y+FVzm
         h/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749908; x=1788354708;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7M5t9v5XwKSZ3VZcQrdmnixl9ZSmqbJvPFx6wEt+sCo=;
        b=mvW6BcZbqSroMHUdQ01vsv2NYHAxgQGZtAG1evc/ATVxX6oZCnGWEaPgp+dCzMy8KS
         ELMchIk5dcue9Rgggij214WaOejFtwVcJYEEGGJj3HAnriN3zTMyFF9fHjz5OCeNg30/
         vOWeG9QHcW64V6AexmW1/jK/vmaNSgiez1kY9XqQgrZnwXRhsNrnXJBC68jhAxdySgRZ
         1Jsb0knXd7jEOcVqOwOOl4jTgKA0JbMPqxVIzVWehBaWnZgJB+FSFJMIcFw8/6bvI67E
         BcMxYdnNrrfKrX9u4nD5L04aXbVjZccu/IixjFt9QdUXYa37lkrNU+5ieCBwwB3WGunx
         yGpw==
X-Forwarded-Encrypted: i=1; AHgh+RrV1ByiFsoSV56dSuWZDkO1CWBrogmAYIJHH8bQLOKiHcwDlU2yqZBHYxqPzhOgi09KUFTWB4c=@vger.kernel.org
X-Gm-Message-State: AFuF++ncJz38rwAe5faefYUgCA7qbwv+N2s2KDkASkRj6I50K5xSh4OB
	v2r04w8rPzTYGWF9BNNn8giXk/uXKtYEXeG7BIibNiwmPIMRySsEbsFs
X-Gm-Gg: AR+sD11Ky39xat5d4tKXp/I0qyMqRsT77gI/97r4sKGuEdShX1SvMBK7HKMfhp1mgws
	+se+vc/3TSlIaaY7GEGh1ae+d70OuU42Ly83mc8mUuxOVT5tT8oSC0kQOj1SnlN5mG17Bg6J497
	gvJ+cTOx3whRAWHmxgJUC5rlv1E6csdjMDQS6owOALXdymYpqQNREFDdRUKusaNgoP8JxqJXXQL
	9XsOiLrRIiQ6V1LJcnvP6YnRcLa6/OVo3mW16+jiV9AmECLONeYmRgDDXxc1V9rvGqm+XxafiIC
	teSmXdJQnxq9i768zy7w+J+sM6Nl17PMW35u55AF/SYcAymhY3heLdSs3vogwmodZjZ7BWFr+1C
	5RcjPWAdjCt0QDA5DsmTBWnQfjcOD1hV0O+PJq+hdf0LfZJ/umPQsoqa2Qyu7KsjIqeSf6FnNdD
	OWpjoTKrZHTKw8k82cEp1yJfJt18BljSDfUKGaIuMDjCwRrQmV
X-Received: by 2002:a17:907:3d44:b0:c25:5a7:87f with SMTP id a640c23a62f3a-c250ba06e3cmr876138966b.0.1787749908066;
        Wed, 26 Aug 2026 06:11:48 -0700 (PDT)
Received: from krava ([173.38.220.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2523ea83a1sm299172666b.60.2026.08.26.06.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:11:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Aug 2026 15:11:46 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	tj@kernel.org, yonghong.song@linux.dev, stable@vger.kernel.org,
	andrii.nakryiko@gmail.com, olsajiri@gmail.com
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
Message-ID: <ao7mEnrgVNj7prrI@krava>
References: <20260822225444.2774461-1-simon@swine.de>
 <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>

On Tue, Aug 25, 2026 at 06:20:16PM -0700, Alexei Starovoitov wrote:
> On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > A JITed BPF program can use one private stack per program and CPU.
> > Sleepable programs can be preempted, allowing another task to run the
> > same program on the same CPU. The second invocation then reuses and can
> > overwrite the first invocation's private stack.
> 
> I'm confused by this. sleepable progs go through __bpf_prog_enter_sleepable_recur()
> which has per-prog recurison counter. So preemption of the prog
> doesn't break private stack.
> If the same prog attemps to execute on the same cpu it will be skipped.
> 
> syscall prog types go via bpf_prog_run_array_sleepable()
> that have per prog recursions counter.
> 
> Looks like we're not doing it for bpf_prog_run_array_uprobe().
> I'm not sure what the right trade off here.
> I feel universally checking for recursion is better
> then selectively disabling private stack for uprobe.

also during the load we can't tell if kprobe program will be attached
as kprobe or uprobe [1] so having a way to disable private stack for
a program would solve this as well

jirka


[1] https://lore.kernel.org/bpf/ao2f-rBgT0SqX6Pw@krava/

> 
> > Disable private stack for sleepable programs so they use the regular kernel
> > stack, which handles preemption correctly. This change is intentionally
> > limited to programs marked sleepable; preemptible non-sleepable dispatch
> > paths require separate protection.
> >
> > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Simon <simon@swine.de>
> > ---
> >  kernel/bpf/verifier.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5e37ca75e5c4..038753ef07a9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
> >  	if (!bpf_jit_supports_private_stack())
> >  		return NO_PRIV_STACK;
> >  
> > +	/*
> > +	 * Sleepable programs can be preempted, allowing another task to run
> > +	 * the same program on the same CPU. Since private stack is per-CPU
> > +	 * and per-program, the second invocation would corrupt the first's
> > +	 * stack. Disable private stack for sleepable programs.
> > +	 */
> > +	if (prog->sleepable)
> > +		return NO_PRIV_STACK;
> 
> This is not true in genreal. sleepable progs can use priv stack.
> 
> pw-bot: cr
