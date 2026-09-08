Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AA55C1DE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885480; cv=pass; b=SnbfEdyJi0wb11YGqOlyOrYuERPXKhNRxJSS79VASCPEuyE77XbfZtwVnW5oQtXdsHZA22Pg8BKX3oeic0BUrRyrKZqG0SePFchWdjUUGEh55TP3OXPy8lSr4bebG/ZSJx3OAPmGqsxOXjnRG38zdIQPeadnkoFi+hjUtmvLNpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885480; c=relaxed/simple;
	bh=tqk8614BLoIOeOT9CI/IALiduSN9nR6x4DKz4FZIZZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvD5swB7V89LH8/5fW/9/EZx5tiR3Axq0f9kvO22/3j1wQVqH6FUW5mcINGIu4BsS/fhq3g+GizsdG2g/702cKhviCGu2mvAGQVBJNfvnzhHAo1oewpw9vDwDETxj/cD6fomwF6K9IvhKeL05DXW221PBkEDe1KQPRtgvpD3Cwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJqUuuhS; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJqUuuhS"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-853c07a76adso4540377b3a.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 09:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788885478; cv=none;
        d=google.com; s=arc-20260327;
        b=gLbfEhsD0yLyFTnxFQv6LZR2OzHMqcUtWShfG4fFmVX3l/8v/BmCtjp/eek+wPaDBL
         B1jd57E4368A3fZ0el8nlAHVKJXsWF777GaPJWFpptDusdQLfFXLK2pQmnLqyD6JkWdS
         EetUTsterjr3n4fvTqvBynx3kQ0Rz1rKodrFvjrH4T5suVIbWsc/pKCLtWEqaeRwLwk2
         XoEhF85JVVV7vCA+qZwH22tuU6KCJ668MWWcik5jR0pcOI3NsMDn5RqHVB/eHkjkZRN2
         0949qSD7x0pUXfPxrHre+J9/a8gyPV4qcwMVGTcERIxhGCdJvrRJvAUjPdOJVFBn3qHM
         pulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tqk8614BLoIOeOT9CI/IALiduSN9nR6x4DKz4FZIZZk=;
        fh=3+pLVEAzCbY0CbLW5TE1Kv8SpawBK7lNsDtnmtRcZP4=;
        b=BaIKnkF5kZ4lpnHQX6qrYtjA8hOnXFsfeR9Tl7MCwo2+x+AEv/yCCsZLGp2E4m0i4L
         cssvp4PTWyL+exuVbFXJnOYlD3jEOaGY590k/CT2s3BewtyCbboiPpI04gJMz6PX1MBu
         dz8liyvTz+5jukio4qZhJccPvJtUoAH9TI4AvB3YbZwgY4WZt85FdP4nIS8WUCtw17d6
         36+NJKtNGvutei9KMBzeJzd5UZ+PnfASBU67hakB/As/rKk52eQhuSC1mM5A66p9JSpN
         kGVie1P6rDM8mvJCZ8/LrB0rArZhiQpss1L4W6/I4Uzu2wEWvHA+H9U6UrT3g49/80xm
         R2eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885478; x=1789490278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tqk8614BLoIOeOT9CI/IALiduSN9nR6x4DKz4FZIZZk=;
        b=CJqUuuhSe76t68OtOXGv5goTikIfTNl1Mw48Ka8y9ie9nJJ2EK45rLEFq5/X4MvcHY
         lKijqmDVUEFDyl6lsTkuXLlSQc/TZhsGN8i+kAwFcxHiFD1UD1ey95fqBzUsuPQjPqFO
         euG9egNueEo99u9219IQFZg0HsbuE41NxGDaPxt98ApSO/q1F2yIWTlmwmsTIl6Gudl4
         amoZAXeD8X2vBV3TM4QoIhHtUP8zQkqmDWsU5juy/xnNBOnMoRSEjDj5P8mcJR92PMN2
         tCJF6RU8ZUB34UBeQkmsPYNb0w1xue+W5jrtHy/9CNmziSN5T+TNdNMTaBBSMUOMaU9n
         fS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885478; x=1789490278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tqk8614BLoIOeOT9CI/IALiduSN9nR6x4DKz4FZIZZk=;
        b=C51bLbrMOsF4wVbClFrt7R/EtbJ6kHKsGav3WwN3JFTx7bpzH1cln3wuPPa1pqBGQe
         crpwiqV7greuD83O6wLu1bffjWJnJWG9p1DgAQrNUY6/1eybx8tnSkZTXZDySpT2RbEe
         3WSFRHGnthrtkMVIUfYGxXMnRqvt+Ny5gqryyHxZyaui4IDiGeVEPx415qqnoPawYm4q
         LkNvDw1ILLiQbOrAnGFv1kFYiXrqd9Nd7LXl+x7OgjdkblSGvfqATBYkWkERFjPNQHLR
         /NKEmFUTvfW4a2bytDxU+r+aXQ45B2E3hTd+DeoOqsVCOqg/QiqIe9iJZ9guuXGhZBTF
         ugpw==
X-Forwarded-Encrypted: i=1; AKwUvBw8PMVPu5wqojkLXalXXkWoNhLih4Z8lPExo9GLT9el5Q4OpQ43GvCwgqzLCnOkcELu3CR6/1c=@vger.kernel.org
X-Gm-Message-State: AFuF++lLpOYhqRKkWoihMKndMjZtTKMOVjXofx4PniWeP+l+C1LN4t8f
	ALp/DjoRJwACriPbgC0ChO/uhMu5Mki+a3FUg+JiSsoU7r2I95jeMs+1ehyFn1GszNyvDYRary9
	WKo/KMPlMm/aKNNwinJxy/BqfDVt8a8w=
X-Gm-Gg: AYBFou2rk8ZvqoKr5oMasLjrVVqnhYfJlgvu33DgPA8E1Su224E3nOsvzq6KOkBavGn
	JdgUhlVZORytET9a3Oi06mMslqjvNTibb7v8DAFpgtphP7SdYmAQB/TniGT2EdCrShf1ulEZ/n0
	fhUkJF8cnCb6bGQseKX3JEp8CVCHVUhd9BZa4N1bwO1Yld9L5SKUF3dGT8DYabMpx/47bslWJVE
	VbQK2lLZfyBPIj2s92oCU1H26Whc1BCLoB54kL7eU0ddGVXUgFVmpTQZVhULYV9c33FJQVb2QLF
	Ie9GZx8G86Ioky1w1xWCouFmsmP3OKpt0TspcvPD8nQNthkYwq5ufSPfrT73sHu5SZPWOP/e3eb
	jxsIdkNVyjBecZ3swJePqFV/H0Yt9
X-Received: by 2002:a05:6a00:3007:b0:846:4d4c:23f8 with SMTP id
 d2e1a72fcca58-861662d4c34mr43970654b3a.1.1788885477863; Tue, 08 Sep 2026
 09:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
 <CADAM+B2jgDiyShSSXYoUG36C7yVpjx2NrhP6tOHeDjB0h+GvTA@mail.gmail.com>
In-Reply-To: <CADAM+B2jgDiyShSSXYoUG36C7yVpjx2NrhP6tOHeDjB0h+GvTA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Sep 2026 09:37:46 -0700
X-Gm-Features: AcwNN1U713emDEBEY77DqpIK_oX7R7ikV6MmHQT0CKKTJmS_FXiyFemFfwHRuRQ
Message-ID: <CAADnVQLu-XiLxz_k02YK9xCgM8guoszby3O_m00_vdq5X8-w5A@mail.gmail.com>
Subject: Re: [PATCH] x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()
To: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:22=E2=80=AFAM Soheil Hassas Yeganeh
<soheil.kdev@gmail.com> wrote:
>
> On Mon, Aug 31, 2026 at 10:49=E2=80=AFAM Soheil Hassas Yeganeh
> <soheil.kdev@gmail.com> wrote:
> >
> > The switch of the FineIBT preamble from "subl $hash, %r10d" to the
> > shorter "subl $hash, %eax" moved the hash immediate from offset 7 to
> > offset 5 of the preamble. fineibt_preamble_hash was updated to match,
> > but the open-coded offset in cfi_get_func_hash() was missed and it
> > still reads the hash at offset 7.
> >
> > cfi_get_func_hash() is used by the BPF JIT to give a struct_ops
> > trampoline the CFI hash of the stub function it stands in for. With
> > FineIBT the trampoline now gets the upper half of the real hash
> > followed by the first two bytes of the next instruction, so the first
> > indirect call from the kernel into a struct_ops program,
> > tcp_init_congestion_control() calling ->init() of a BPF congestion
> > control for example, fails the FineIBT check and the kernel dies with
> > a CFI failure.
> >
> > Move the FineIBT preamble template and its offset defines above
> > cfi_get_func_hash() and use fineibt_preamble_hash there, so every
> > reader of the preamble shares one definition of its layout. The
> > CFI_FINEIBT arm is only built with CONFIG_FINEIBT, the only
> > configuration in which cfi_mode can take that value.
> > cfi_get_func_arity() does not need the same treatment: the __bhi_args
> > call whose displacement it reads still ends at the function address.
> >
> > Fixes: 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA")
>
> Gentle ping on this one. To recap: since 85a2d4a890dc the FineIBT preambl=
e
> stores the hash at +5, but cfi_get_func_hash() still reads it at +7, so B=
PF
> struct_ops trampolines are emitted with a wrong hash and the first indire=
ct call
> through them (e.g. a bpf tcp_congestion_ops .cong_control) hits a FineIBT=
 #CP.
>
> We have large scale panics when we use BPF congestion control.
> Happy to respin if a different shape is preferred (e.g. moving the
> offset next to
> the preamble definition), but this seemed like the best way to fix the is=
sue.

Looks fine to me. I guess it will go via tip tree?
