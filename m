Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089147;
	b=tIA8qM8gyy9eeOYabNg7SON9WPF/AgG8qw+uqRyyrnD6I8aXFddsKnnvZtta6IJa1obw
	 DW3X75DblcmMCCVFvUdOc/k1uNiluSn9J55dhxxH8HgnA6+jRlrlHpnxO6lQiwZP6hNKo
	 QAf8+0fcy/Il8BfuR7WatZnBAiVDRXCYS7XD9AO+vCYzUGNuLIOYLS7pVJPfssLZy3ULG
	 DUZTrecAuHyvgZ97c2w5q0EeVzLrvM73qkjgcFI6MdJrH+QeFjZfNh83rNtFfcXHAHms2
	 mppnNta6toViA3930UUPbWc4cgV9RsTtV5eiI2dHWnF5798EtTShOL2uWBpQNoSo7Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089147;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b2nlTxRHLxUzz9SMo1MtlIFyMY2HxFy4FtJp9Rq7rss=;
	b=DaFaPM2uEWWWCG1LrCzPGoZ4Q4Rxy1aYGSF8rG40+qceXd5iqSqzAkr+oUAtkGkki87q
	 Dl1//tE/sDBnEkCBcMollBp29+Z+Ilnjlvx6VgCwa8lzq4VZK5JlDRjA1xNXh1I19Wf4b
	 Ua0SjHh6pjMfHeNsQImpxMGIr/nXo6s9vC60PHZKWa8bLg+FOdU1n/2/QuWb5/SSQYbPS
	 7CYKaB/1wNdRAmXVcfh9+EA3X5DaJi2fbqOZlG7bCR0GuLq0REoyGOrqw/i81l4SZyagW
	 bqnUhsZeHmLuTCHrMKaXBwxOBi11Ptc/wWLUC9+s+uWfpW6YaKb3MYB36JpWUhff6yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMzC65+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EE606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMzC65+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F081F000CB
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795089147;
	bh=b2nlTxRHLxUzz9SMo1MtlIFyMY2HxFy4FtJp9Rq7rss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fMzC65+wDLVYxkRWtrrel5Gz3z1gdzPEBWCD79LTgUuDlvj3XkVjLJNZ8lupjHd5h
	 Ft2FkxSQL+6qxq1cCIErKl3YYlo6zpykWHZlFrW9UA68ou1WlxWiTu9/ndxZoS6bl2
	 RoJUPVXScjPTUm1EZvSPLMRyI1TR71y6cGjBwOBdsCmk8yIEr3i26fPdXIur5HsA14
	 vLB3n8mYYVxUgKPNzLaFfAkw4HIHnuR848hQ7ixWaSkyL5NwvIPNXi8m7s5e6jxVPl
	 zpIE9DiRnYJXOZDcPVMtKAAnxJ+JOMOj2I6LMZXtL9oaM63tqfsiEf4Csa1iQ+vyh1
	 6Iji3qMKOPeUA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b85b58d303so583128a12.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:52:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFmFdiy8kevdLzqmlBrHNvWvPiKrcqCcMZGLpZp+fRlEeYmWtb3PHbsFKvsTSwadp/ejUiOt9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EaYUnfE3JJxmOuyP3eWxD1YBMfPjoAZmYge7ic89EyvGj9WVN
	EW1aOyMtRMK0EhCDIaIWpp5gdCZn7M2UvxAITChEjywZo6qpWI+lCekrshE/Qxl5H7jC1AddSEM
	+Fu4Orl8DcmV1jOtMhNubzKvs0jnYoQc=
X-Received: by 2002:a05:6402:3642:b0:6b8:b0d6:53e4 with SMTP id
 4fb4d7f45d1cf-6ba1f76a935mr1052480a12.3.1795089145657; Thu, 19 Nov 2026
 03:52:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118071444.10258-1-dongtai.guo@linux.dev> <CAAhV-H4TNuXk60LyzZhFwQTfNtdzLEFQTwS84u3ZMQ6b=8S0NA@mail.gmail.com>
 <0f79389b-ceb3-8c2f-16bb-1111ac40fc43@loongson.cn>
In-Reply-To: <0f79389b-ceb3-8c2f-16bb-1111ac40fc43@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Nov 2026 19:52:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5F-T1QqnKaz9GY12qmx-NMFQxw5VOPvkkhWee9tiJBkQ@mail.gmail.com>
X-Gm-Features: AclHuK_c3lTQadkoQKEF9eyTGKOydeIat8h__CjivNc1X8M3Ip0VknAEs3E4RMY
Message-ID: <CAAhV-H5F-T1QqnKaz9GY12qmx-NMFQxw5VOPvkkhWee9tiJBkQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: BPF: Fix the offset of stptr.w and stptr.d stores
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: George Guo <dongtai.guo@linux.dev>, hengqi.chen@gmail.com, guodongtai@kylinos.cn, 
	bpf@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:11=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 11/18/26 7:59 PM, Huacai Chen wrote:
> > On Wed, Nov 18, 2026 at 3:15=E2=80=AFPM George Guo <dongtai.guo@linux.d=
ev> wrote:
> >>
> >> From: George Guo <guodongtai@kylinos.cn>
> >>
> >> When testing bpf selftests "jit_insns" and "jit_insns_blinded", the
> >> "ldst_offsets" subtest fails for word and doubleword stores:
>
> ...
>
> >>   #define is_signed_imm12(val)   signed_imm_check(val, 12)
> >> -#define is_signed_imm14(val)   signed_imm_check(val, 14)
> > Is there instructions really take a 14bit imm (not something like
> > ldptr.d/stptr.d)?
> > If yes, I suggest keeping is_signed_imm14() because maybe we need it in=
 future.
>
> According to the LoongArch Reference Manual, there are 8 instructions
> in total that take a 14-bit signed immediate (si14):
> ldptr.{w,d}, stptr.{w,d}, ll.{w,d}, and sc.{w,d}.
>
> All of them implicitly shift si14 left by 2 bits when calculating the
> virtual address (vaddr =3D GR[rj] + SignExtend({si14, 2'b0}, GRLEN)),
> so none of them take an unscaled 14-bit immediate directly.
>
> In the JIT, byte offsets for all these instructions should be validated
> with is_aligned_signed_imm16() and encoded as (off >> 2). Removing the
> unused is_signed_imm14() macro also helps prevent similar misuse in the
> future.
>
> So there is no need to keep is_signed_imm14(), and v2 should be good
> to go.
OK, make sense, queued.

Huacai

>
> Thanks,
> Tiezhu
>
