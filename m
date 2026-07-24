Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B263D3485
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887372; cv=pass; b=muB/wPbInm3tCjqZunrWZ8GqZQXsZLh5hzEaae4jWcSa0M+1K1B4H1x6XiT1Bcdkw5tnqt+83NpwDKUHMKC0thIwe2zn3Tww9z7vks8pM1f0PtEcngF0wPRFPelN5vdDt9/k33F/MPgVKWfnci5jvVQjILKOKgiM6RwxuEZSiMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887372; c=relaxed/simple;
	bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkUHanFHRjf1h4Z2ngzNATXVjMuB1tU6NElaa/nfWj6hxR3iHGYvVfRUxRtqnkbOWfZKVZyGU3HXDYS9A/FD/XKdFn1cfZZCc/zbe/JT+oRVweoUVSqLtBKnN2TFNiMw5mzmevX9G+HwAbATAPPVfo/1XeN3rp8tvQpzOP2gtvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie9j1sjQ; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie9j1sjQ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69edc72e513so41525a12.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 03:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784887367; cv=none;
        d=google.com; s=arc-20260327;
        b=nyENbiFwjJKN/w9KSAdl9jdN2J6t3kODZ9w19liU76su/j4/jrKpMfeBjGovAcSjgS
         eBgY+lfLPHuMFDpne1gfgbnuJeMLwHxVhi6GY+QPmWsDEqwQzOETTzazuJ0dILOb+Esw
         q3c7Py/fZpAQbt/Uu9QkvfZ7X4zBF1kNyBkoJZbIizbdheUnFJiUP5gNs9+z8TEVJAEL
         3rlAahP8j/fDyiXk7iI64ST3utBnpyJVjNovjgzJ7Kaie6SS5Jaxv+xknWqYKTNSsCUW
         nJjRCMgaCz8Z74mmupniEjc3HxUpbkOET6EBK60VJ7FqUoDXgCbbTp3yQAPAvZCuzZrz
         Vs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        fh=0mMfnQ4xOr6Iq+yvc6uYxTgOjy5himwl8r/h8AqULiU=;
        b=lZ5cEDG1ilszhdTZv15Hy0bu5dz3awTwi7UJ8KaBBWA4FS2m7kb4Pweh5xiBgjHFme
         3G0ZmVxRnU/YaUFxKaKhBRDXazSncW2BMhaf25qa8Ijjzba0Rcf1x0/X5BR3u3VD1jtX
         7mL660SirL24+wdBVxwovIVWgcuj1Cwsn3CRup0VCtmMR802QGbxYyfn3hWtZzgbI+Yv
         Jmj1v0wd6POWKm9vzYI2yU45JfMefNuG48NjfsHie7t+q7Jj2B4Qw9+gOUzpAASJ22ob
         pPV0g/GTB5SCIhT4v8HajQsceQGaMZ/ec7jLrt83j16g1s/5RLrHOniIIA3WlBdOih80
         Pe/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784887367; x=1785492167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        b=ie9j1sjQXi6oO16pWAfr3yBFSJQx7smD72iWnrR6HuFhZezierdTz9lEWSNQ7hWyrP
         I5XOYGDz+PvTRquSJzh+J2J385R6Wy16WXQsYcB7nw+ra0UWCd5gOsQWVG9BsNau47kX
         gQkc085nqcD/4p2mjjLf0GzWsW8H+PYpoBK6OUhP5ire1rHzVMabp4/H7GXTmYXTnvvC
         3vD+M+lJON47R3LggGp7RVcjyE++7qTwX3DaMATuOSeFj8tfs/h4LUxA3habHSdHjKIz
         CN0n9EX5mUUqSb7pGuvw7+/ZLzFfEzS6E3ku2ElbpDH1B1547K1ephUeXIxsXLsZzmMz
         GV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887367; x=1785492167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        b=JtXU9GYOGEbP86uJl46IDCOwOn6v4/Kjt7/+rMJHazAEVRxK3irxJhErcYrv5k37FO
         wrdcluNBaoZiLiYItbTys4PoB+Ql03r006DA1CZ6AFxZk0vMwWY8Ql8EE92df576Rk9h
         wG9cBe2hd27fRMfk1UvRsD9fMLkU1bDPbaS6Rb87wBdSIuzISTypZU87fJ/s5KcNcm5U
         kxbLblPAcUfYuknYDinmwcf7zRmvPe25AR8/JnDbVvmLBdINd2Am/FadOXq4CnhvQ3QK
         2+sm/O195OwtsOAs3pDtdFIX3MwiMurhoVoNl+qPD6plTovTZhnDw/ARfdyjdDeuiJ4A
         9Grw==
X-Forwarded-Encrypted: i=1; AHgh+Rry9mSj7W0mREpfJdZW3wviwmnG1szyr2QfOdng4r9aRNuUxOFMUq4k5Ux1pFufMluRiQwd2B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYPgxrQDn6X0ma9VciM73JkMzxMKC159pxpgpqDFIypsJ7WIB
	fmDskvtgvMGBovTH0wppXLK05KbNd7I/YUNf1xxWKAI87VGGFGWtXQZNlM81A+hDRm73BsfwJTv
	znwgM2YzqH1VQ+mtSX8L7mLAt24fk48M=
X-Gm-Gg: AR+sD13qFfn54GZCIDHF9Epr86bTL+95ZMPUtxes1r9QiVcgQf559YEmWqB8+lNBgJU
	WbkDT+wGC4meGARjY3uVx4HYLiwJlppk3djkPNnKvEOGOfNeAXhx8/9MIhApR63vbjRxdjpLhHU
	qVt3DzgibgDboB5hu+WnvZMQIWaqEWHAgC1zDSyYMiRCEeR6SJoCZQpijhT9drIQ0gKB1KbrVg2
	sIsc1ox/CED7dqIpUUfxSDH9elnzsuVq3xgaxWHSHCZ9fUHEL4WzVchVMG2t8w4KDjAVtP5xfax
	FUoXzWvr6AjUjNE=
X-Received: by 2002:a05:6402:3997:b0:69c:7a3f:9fb5 with SMTP id
 4fb4d7f45d1cf-69f8ddfa863mr771337a12.7.1784887366457; Fri, 24 Jul 2026
 03:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com> <20260723100030.3eee6d51@kernel.org>
 <87ldb0lo8t.fsf@cloudflare.com>
In-Reply-To: <87ldb0lo8t.fsf@cloudflare.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 24 Jul 2026 18:02:33 +0800
X-Gm-Features: AUfX_mxJN7h4yxh_VHEGxVwUbDqmPuLUq7be4uNYXJEjMRhF3AJnYtdiUAsj4Rs
Message-ID: <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 5:40=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Thu, Jul 23, 2026 at 10:00 AM -07, Jakub Kicinski wrote:
> > On Fri, 24 Jul 2026 00:26:02 +0800 Chengfeng Ye wrote:
> >> Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendms=
g()
> >
> > Since you are spamming the list with the reposts of this could you
> > please add [PATCH bpf] to the subject so that netdev CI is not confused
> > into caring?
>
> +1 because we need bpf CI to run sockmap selftests on this patch.
> Please point your agent at Documentation/bpf/bpf_devel_QA.rst.
>
> Contrary to Emil's ask, I'd recommend fixing one issue at a time.
> Reviewing multiple fixes crammed into one patch is harder, IMO.

Sorry for the disturbance. I was trying to fix the other issues
reported by sashiko,
but it seems it is harder to fix multiple bugs in one patch despite
being the same
function, as more issues are flagged by sashiko when a new patch is sent...

Then please just take the original v1 patch for reference and ignore v2 and=
 v3,
and I will stop sending new patches for this report until there is
further patch review.
If there is a new patch, [PATCH bpf] will be used properly.

Best, Chengfeng
