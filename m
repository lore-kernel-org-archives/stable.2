Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F64582E2
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494737; cv=pass; b=liXsaNYlkqlotUOw7tJHeFUQDxKK2ww+eUOqMX3yBxG+0uToG28quFCU78k1dgAORBQtnMsD/8keSJBDNeg9kJQ2tovADfofLRk/qkp8mrvUD6Dmq9g43MTGOoTCzUAuspsBIHQut5VcVyWnKX3Qb8ezKuqRWOJJtSw1F0vFBJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494737; c=relaxed/simple;
	bh=S7g+s1Lijk2x3ZtW+DC8TZtx3LkiM/nDXQU5onS2N3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqTbYSkqbJd75iu2xzZMGS5Hn5Zaaj5+65PxmirdTNoVkEwpyIlXsNILgujZvJ5B2z8kUPC53hqY1JZitQPsy6lWpcaqqjAvMmRE6O4NMIiZBoZUPEp8cGMa8KaCAsLwAvfSSJjkYeaECOlYLnf/ZWOfdfM9dP6W02Wt2bSG5e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs9kGkUX; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs9kGkUX"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso2728409e87.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494733; cv=none;
        d=google.com; s=arc-20260327;
        b=k1FfdHFn1EuAA8apJcutu7EhbA3uoACIhfOh/FXVvgFYTE/SWWJWbnGNVOcoppOZM2
         9FrqUCQOo5ICzfk31LFMJ1oDfvblg2ICOeW2NhAh5NW2adS8uANRy4nlPFZqmjRny3A4
         9Yld4SSlIfeEgSoSkD+gl7CSMWtndPEP73UMKXj0xjrLk81d23RZZxRdCezkQRtN9h/w
         riGoUIbAazQd77LAobaF58coXrbsJvRdcwQBPcEj6BM6UT1r2tQdNBl+LL5W2/d6xlzu
         Gfqb1ii6906RH+rulRpepJ9Jw9bYgN7CpD3GzmONgevgRYLDkSg4Zhf0aKXVHpxqi52q
         fCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S7g+s1Lijk2x3ZtW+DC8TZtx3LkiM/nDXQU5onS2N3s=;
        fh=2v+OU7aPtSSMe1S6liQ0uXj8EpLM4sjdHw+aht1rW9g=;
        b=L0Mrhc2RDx+ILusJyyjsGiIK4kN7ZagjZlJxPz2izoVW785NuhRBfgrOJePUWGtILf
         r0nhcYakZUUksJXCafZeVQ1e2W+NcMAcNeL5hhnCNaOEwk9ufpCwryikVruy8Pt+Hgfi
         NYF8jip9EW8usxuy+Jh2yO+RmmVzDXu/ymWsU56AtT4feSdjqAlwekWIdoRPZZWjY1Cv
         J8dD6rJYDuZEBM+muS0X6uoSmgBbvzgAIXtOePtX/EoiEh8bXHB29PREXh9Wd/pRX97T
         3Zk90Yv8ZsY4xw3DfG5+DINewl1v6o2T0xV6KcGnLcoWTyqjm0VvpEjtnfZFeJOwZxyQ
         Xd1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791494733; x=1792099533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S7g+s1Lijk2x3ZtW+DC8TZtx3LkiM/nDXQU5onS2N3s=;
        b=Hs9kGkUXVDGQNgSZg7i6qceK2VM4b3QhfkJ9Yn6EqZbxFRE99MYpBCX2GA5l8Lxar8
         PdvGoA1x7DRePTWyF+i5E4xv+2AaPo7WygKG7xjN59vFTcWJxNZ5eUEaJ+3WUoBzM0ae
         cVoHCr2FvwdYydBX9nl99UX1SyYxWQtLHqFYlZJmLH2sNQaY8jsrUA60ZjOTlQsLsmdJ
         spkO6Ke0PZeKs7wRH3/bXuRsNwOd4aa4b8rhRqDwLISs/y78b9usAn/b1Ty4KxwqGCv7
         IzUurzv1kRdiEa7TdWev3fxl5xjpk36T+3DaKzQ+DFTbcL28OVccwiSusdFJrJiIoosN
         63XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494733; x=1792099533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7g+s1Lijk2x3ZtW+DC8TZtx3LkiM/nDXQU5onS2N3s=;
        b=x33k4AXgKLPL3NeSyqKbVRTPihFcKcQ+Bzk2it+EeL7gkWXCCBsjQg1cPOESs7D8oW
         x+0yaAgC1hhkmJF8Eipp9u2aGf6zNIfsRVoP9ria6e6pTLw9VUUpv+WhwqGMGNoYdaoy
         G3nREFIByo0+7Wb2+pymD6L5cRkZ5YKH39o/WX/qWY7baUHlrPt2kGnPDzLILlVGej5V
         nrI2iPggYjevH27ywJ906aQD6HRcw8TkDn5sCDe1EFFDgJgXtdtlALq+agZ5pcZ8MGOu
         sfA1AmwPIsQt6xUzCufQgzhxpoFiyTEnNpzJkfMte8l2kuacT4XVXGnOwB+Nhq2d2f+T
         WQpA==
X-Forwarded-Encrypted: i=1; AKwUvBw4uDcN+PeU6PfkCSdi00X/LWIvXXe4wZQjXovQbs1vqHbKlyB8Zn62966EmlCaSlqu1dVqF+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvjVAwnUO9q6VYhL5+X11Yzz1AOutTdBIza/vq4gCWoLT8bgXs
	ZnWwjeuN+IcafHmfDqUNzYaiwPZpcIr5NXr6RwYm5TVUfQQMotTgr0MGx7Z95XGCFIzT39p/CQX
	ecFo1vPuppVaUoAYFVGnfCGpa+aNYfBg=
X-Gm-Gg: AYBFou0k5p9sOtuxNUP3gmOmdc/GLRpjR4lQpmfBtGy5iCAggtvOaStWhD14yxUIzTs
	sP2pSJ/kyHxWmvDnX8s64b4GucSImLQzi21cqzf/zmpfmECX2yE6t+ydt03ohDAQ9rVwcleIoJS
	dA2yJ3KNm4dJyicefhYWNBBcy6OvZTNHVoF3JozAES/1t34oakBwSjRaGrjsC4FekRNBwy7aNiH
	/3nnrnyYywIgPjybYMQFFCgWKpqc5KwoVxRC4ioh9pxqp7k54zHk3FQiFjCvxzOfWkj6nwN6mgf
	d3Orip/eZic5oD9P+2wukMgOhBD57k/iqZ//GptxLoBUtw05fM6PsWtD3KOh5ttyHDiZOlHTciC
	lW69T1InWrdM97Q==
X-Received: by 2002:a05:6512:a81:b0:5ba:35ee:bd96 with SMTP id
 2adb3069b0e04-5bcdd54b8cbmr66712e87.41.1791494732764; Thu, 08 Oct 2026
 14:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008195608.965266-1-linmag7@gmail.com> <20261008195608.965266-2-linmag7@gmail.com>
In-Reply-To: <20261008195608.965266-2-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 17:25:19 -0400
X-Gm-Features: AclHuK9sf7yMp3FZjXD6vDdr8J77IFSBgkUkzbBb66SHYetuHtwbzGP3_Y_Xu7A
Message-ID: <CAEdQ38GCisZE83bOp13soyDjSrvprWd+avmxNONb3nee4oOUBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] alpha: load the MMU context when switch_mm()
 switches the current task
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:56=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> ev5_switch_mm() only prepares the incoming PCB. The context is installed
> by PAL_swpctx, which alpha_switch_to() issues against that PCB on the way
> out of the scheduler.
>
> Two callers reach switch_mm_irqs_off() without going through
> alpha_switch_to(): kthread_use_mm(), which borrows an mm for the current
> kernel thread, and sched_force_init_mm() on the CPU-hotplug teardown path=
.
> Neither explicitly loads the context, so the task can carry on running
> under whatever was loaded before while current->mm says otherwise.
>
> The stale page-table root need not be swapper_pg_dir; it may belong to a
> user process that ran on the CPU earlier, and the kthread's user accesses
> can then read and write that process's memory wherever the stale mappings
> allow. Translations taken that way can also end up tagged with the
> borrowed mm's ASN: ev5_switch_mm() writes that ASN into the PCB, which th=
e
> next PAL_swpctx installs against the stale ptbr. An address the stale
> tables do not map faults instead, and since do_page_fault() resolves
> faults against current->mm without reloading the context, the same access
> can fault again on return.
>
> sched_force_init_mm() needs CONFIG_HOTPLUG_CPU, which alpha does not
> support, so kthread_use_mm() is the only one of the two reachable in
> practice; the fix below tests the caller's identity rather than
> special-casing either one.
>
> The scheduler passes the incoming task, which is not current until
> alpha_switch_to() runs; both direct callers pass current. Test for that
> and load the context the way activate_mm() does. Both hold interrupts
> disabled across switch_mm_irqs_off(), so this completes before any
> shootdown can be taken and needs no asn_lock handshake.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Matt Turner <mattst88@gmail.com>


Reviewed-by: Matt Turner <mattst88@gmail.com>
