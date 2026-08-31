Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F945387585
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207330; cv=pass; b=TD5vf+mFuF1tBz/kD7UexXc80yUpZ5M4HepouZGhRDd7z0Y4wPAA7rnyOIm1fcKBFpSiwbXbmojDMPqngz8VjQA6UMX3cToSLY5JfTYNw/ZiK84T2kvpOhJP5bTZmvQncQ6lBXreOap2b94kstdwl7V1N8ZmvxY7bTvVRDfF7Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207330; c=relaxed/simple;
	bh=ufZLh+kfW1UEdEikHsgtDF5Qa2HBFc1dj6ImUClbn4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drURgtiCmuGaYw5FXnrBDIq/6dAPO0NfZanDe0Ov/VwsWeAnZU6FAspsTep8ytZOCxWUJI9aX/XKaGdVvjia1IMmRf51vvzenxs6BDlJoRmHIqCK3Mc0q+42+1aTPWMlMvuW80iFDJ5+d3no2WNCKgzNKhEfn+qXUP5ykCjS7A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez5OIpyn; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez5OIpyn"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a451915d8aso77492b6e.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207328; cv=none;
        d=google.com; s=arc-20260327;
        b=UI+YQJR6gTpjHMkvPmnI82KIS05ES4hcnQnls8H0UA+g2WNGpGfQNPFA7HI7Mf07jo
         JZMHsp3adOAhaSAjB7tE8KYpzRh6VBNbRfLR5AqUKSfvoUFsjysfZKfrBGHWuWoQx7PQ
         A9cR3IGGQ9CfusosAbQnQ6b5vnVXX+enycBZZDynRzTarowg+xLdfgPMb6ihvu3W82jq
         7invWqhIYvA+SA8hDMnMGivO88TYeehGZtkQka2O+cDmtlT6F3PBkK3rfj99S/G/oD0y
         qrTjmgH5jL0guMWu40CGCdXfAcUp7QY0JzcnzyOJAPB7beklIdhNuY49D/qxm1wHIGHc
         N5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ONLbdtQwNTYemip0icTWZK5Zr5wKg4+l2c1pjkTBBwE=;
        fh=5b0i/R5moK0gg2R3eP8WsGJgUJrggPnpM2UtXiGDeIk=;
        b=OYgOysT8LYCYpOHr73m7jTasuMJvqreZqkQcZILE35Kaa0w4GWs/HttsjxmyX8gViD
         Bs7fhBaQ9p45WR+K3JLwq8lrCrLQe2ihYyulJVCNxmmaaj18Ho5gkt0NJrnhyi54teuE
         1ABEM/VJgpi1VZzfD/oG8//Sevlpxpdb57+GfVMCNRUMFjpPYH9oBgh9uwZo16n8tNia
         YYlHyNxTAMlQZ15T2yJIOQ51FoilbKaXi5tRd8/2UaW+SaY5vbM3MVyB8u0VCqdlggAt
         Fewni7QV/JY30OeoDCfdfRivnWNZ4SduBAmJYkt+mnVTkitZk+F/A/sPYmLUlkzquX7X
         J8/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207328; x=1788812128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ONLbdtQwNTYemip0icTWZK5Zr5wKg4+l2c1pjkTBBwE=;
        b=Ez5OIpyngqpTRWdskTdFtngPLQ7P87jiNFpMebUtFH2tmLUTMLjKZQNydXmCoUvUXE
         27rd+EC8MjtOewRJ+UkY7xbaIa/y4YTxiF4EsLh3XF7LipjWxKxBso+q2jlHXGe0iHMV
         /xwxFcKL4GiRhDDMqJQZRVkIl4OeJ0OFZLlBMAztBKbUnm1hbyofM9zrt9OXhPVHPvQB
         R5zz40GMEgKwjt+aOP8e9YcFblsVPDthrGnK8vb3tmmCpABM+ofPGZsD5MW6jd00XW7B
         Y8mJyOu2BzWYc6kdvzSJwd+SLcKb//KF87Rx9r1OJhPJGiNDFR5axqhnGTYaKOX0rNid
         H1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207328; x=1788812128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ONLbdtQwNTYemip0icTWZK5Zr5wKg4+l2c1pjkTBBwE=;
        b=JmHZcRB6/PcHy07J5nXRe6aA015LwWwyDfb9K/vggWFQXO95IekqintwW8nzE0HiBW
         6zpaatnKbITFSiXnIghAf7jFyCunUh5tMNIeoSnS4YvJKjevrOgXjRqiNFurHpPSdeIk
         XOymt1xdIqe6EWqPTNEedzxgKo80O78lfQIAiRPDbPCuewIAZ0/29LbiG8zsuUaI0WBb
         jzO/KXiXDZNZMuBCA3eiFTGsTW27sr+T6MEOeYF13hX5LbbFvz4my/DwMWrxhqWZl2iU
         /EHhOUc60FohqVJDxSHgWAEtgOT8Fimpxs6XDPDB2pJ6fWqZX2R1vuPizeVful5uoTAV
         6+vA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9OBdh401O+OdrcacN9wk7iqUM1yYvp3zaVBdwZ7wgZZM3t0QnkJ1Dwf/YTwxrIY6686H/ZpY=@vger.kernel.org
X-Gm-Message-State: AFuF++nRT8oILbN3KJ0omNtHGp1F3LPLqyddzlG6ZSi65zeE3UZKGOoV
	D96MS7ea/dpl5FXUApaBt7uqWCG2UmjdN5/VFxH7CIIAclIq6RPABdy8NorV37IVUh02aN5Bmn1
	HnrdStbI7buQ7+CFEyHqSjgpTEqbfVm7wZWqZ
X-Gm-Gg: AR+sD129bj5XFIpTMtfSWT9wIp3yDQ5AtXdcc7GBAI+gBD1Re4yLB1QuXB28NuFpf0J
	xGguJkDPTzkud9JOxSmmaWQxdFRbZExMyXekBqhbsU9ezyjjLaGispT+HVvH3aeP7IB+BeXjtR4
	SH9HvLdB8iKTysqwWXtgwu0oPf01ENyDYvCoqJ29yTs33WVo2LImTF4HgkiNKUw0FGsFu/ihvSt
	GoEb0l1ljcLLIwiCJNzv6rKZltKukOmkNeTKS08Kg7KH74SD77xvIqZLI1qBZEr9vMrtNt6GpXc
	1uUXBFwPAVGk0e/zglCmE8ZVkL6MOJwsh1nlmJz2prZ2tJLDUl5jZ8Hte1Q=
X-Received: by 2002:a05:6808:1926:b0:4a4:866:c395 with SMTP id
 5614622812f47-4b3981be305mr28057591b6e.13.1788207327565; Mon, 31 Aug 2026
 13:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
 <2026083135-hammock-bagel-3147@gregkh> <20260831155815.70167-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260831155815.70167-1-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 31 Aug 2026 13:15:13 -0700
X-Gm-Features: AcwNN1XcvPJ3Lcft98Uo-XEUwiY2jq19J4JKDFgADciBwgFZGA6iPM4vM5_26tA
Message-ID: <CAMB2axP4dbiTLNStUZ=6D2p-MtjW2Wg4Sfbp3KSuv+DByAC8xw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y v4 0/3] bpf: fix dynptr release handling
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, joannelkoong@gmail.com, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:58=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> Hi Greg,
>
> Thanks. I understand that I should drop the three stable-specific
> implementations, preserve Amery's original authorship, changelog, and
> trailer chain, and cover 6.6.y, 6.12.y, 6.18.y, and 7.1.y.
>
> Before rerolling, could I confirm how the prerequisite chain should be
> handled?
>
> Commit 308c7a0ae885 ("bpf: Refactor object relationship tracking and
> fix dynptr UAF bug") is patch 5 of its upstream series and relies on
> these preceding commits:
>
>   bab08d1f70438 ("bpf: Simplify mark_stack_slot_obj_read() and callers")
>   b5c0a07eb2c23 ("bpf: Unify dynptr handling in the verifier")
>   94ac7553361f3 ("bpf: Assign reg->id when getting referenced kptr from c=
tx")
>   06d518a5583fa ("bpf: Preserve reg->id of pointer objects after null-che=
ck")

This patchset is too complex to backport properly, so let's not do
this. This is also not a security issue as dynptr is gated by CAP_BPF.



>
> I do not find these commits in any of the four target stable branches.
> In particular, the latter commits establish the reg->id semantics used
> by 308c7a0ae885, so applying that commit alone would not be semantically
> complete.
>
> My plan is to prepare a five-patch backport series for each stable
> branch, preserving the original authorship, changelog, and trailer chain
> of every commit, and adding only branch-specific conflict notes and my
> final Signed-off-by.
>
> Is that what you had in mind?
>
> Thanks,
> Xu
>
