Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373073E120E
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501642; cv=pass; b=uv6wgLNXGl/HIQn26N/Mj1F8u1zp/smm5FZxUJgaMyZpRZ/1n0SisnpqfO02jodbwmSNQykzCFzEmzqd4/c0AamOgnECIF1mlsfr/l1AVv+t5nbTKRgKwNRQNF27+gS3n7ikT/1NhwJBi+faDsFZPYoCZ0u2biTcU5K5FgwxLvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501642; c=relaxed/simple;
	bh=0lxygLEXSve4NnrQ3v/EgBOxPu2ErB6he8S58LynGMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuZJZbfz5njqrpmOpASQXl2b8jC/C19iq6urrUZlR52SA5w91L7cMP8mv2jwxi1W6Cj8TVnH64JieMemAPyv+dDR24+GqmFQTvRIeKNubyiXLtToXfcw0P6cwmWqBK1PmbOV6c2d8btR2GZc7NRR3QpLcgrCtJMxT59guLJlP4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2F0p5dW; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2F0p5dW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f6609c657so473630f8f.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785501637; cv=none;
        d=google.com; s=arc-20260327;
        b=DjjkrQiP+vBnBWvj7HmqTmGGnH0DEGPz8thzkAxps6HriAiz9UDpakyHQSV3PNr81j
         /bZkuCv6jauH1PXOFvhEId2letAktfGvbwpelFD93XzCNQPHTQ7YYb6OqaGdsxbCFbho
         f1htNiXgWII0Sf6xwJ3yJPh9JcEExtTSCvlRl2S2fMVB2IZ/ThjXFHuwPV2E/KAWmYta
         0ZwquaTbaBjDBbPj2Txjc5sccpxSFBsrT4rFvydQ26y6/X5uAtsT6JwamlibToGfxMyv
         76rzUliOIDVDN3rvzj93ze8sBwQTRUZ68Gwkmcvv3TffdsWpVTBNV37Y8Q95XTQiUec3
         9Z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6sjvX84rg2rWMCCdE2PP1jfCG+hdaHrWhj4tNdGUpeQ=;
        fh=J1NKMLHHNAEARiQfLa69jVBsjAK/EPJYaRaecFRk7zg=;
        b=LDCOTPNFmOWzqTubZHGXlgY7PXsnNn2rnk4oL0oNFA3jFX7eXR764lo9mSvyoChJwX
         wntU+C05evfL539KRVBwHq/BNxXChYN8pG0BXSBe0Rsvp2nLuvDgyG8/fzh9ZeXOMv3D
         PyRHp+QNK0hrmmc8eKnmAQMU5xCdOXrp7kibwgrdxTXbwhp0oY+3A88hgMra5z23DTID
         IrouDyYasM6LqGEccCqUSxeY+edG6LD4MKhK3+G3SDGIAtxffd114sVg5sAbs3C+WP2f
         1P5SvM9nzC52rjUR5VVtq7YNKvwOwaMCrMmGVqMDU/sxfmOlgwdhZqrh2tI6TcWZVXQy
         4OEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785501637; x=1786106437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sjvX84rg2rWMCCdE2PP1jfCG+hdaHrWhj4tNdGUpeQ=;
        b=X2F0p5dWVUhUOvZSkg4tar0hcbzIiAF01tHKnKN4mmRgD35F2RizJ/k0q+Z0RUmy7Y
         5xe8UGqKvafxfto6JzGCTVo36XTLmS++VshjUeSfjC7a3+yhbx82IRjxHGtwDpXKYMiz
         holWNcuWSebk4TRvngB04s7hEF4uOvtbP254yc6lfUFPmaE8sdSyDcvzdE/la0647BPk
         cRsVAzo8//ucnJ+OXNHhIDh0ytAEpAbcsmqjG9RpQGlVoZxbYXIAV9L90tTGZ0zK/XkA
         +DnXn/s1Qkrj86W5a2FtMwbVjoMdvAjgmWGIzJQA3r4EwbSaw9yuvdH3SqjEd/NZ0cyr
         Q6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501637; x=1786106437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sjvX84rg2rWMCCdE2PP1jfCG+hdaHrWhj4tNdGUpeQ=;
        b=I4rl2Qir+9ZH4dJnN8iEr89rYvf+ntGWO4x7f5Ln1o/73vivfbu26D7/DpKFIaAk85
         zDa/e3IaMsQvgqAbWCeeyNfD915gtg5dVSeg/kFsEJAVjMmffxjje4TJN+7eT0owjqvI
         ilJFFOKxMIXZf3LX4oazwIRi/iP9vSSmps3fJLIgu+3djhelm2AQQV1kCEjxRtKLMgxS
         9zijD0joxNzE7R5QIeZc2bA8xRyipLnmehmKNRIFwxopSEF6gth7ScwnofpOF3CGwKgl
         QZo6wIlPF+/AY3laODlGBIchyJKX6Zd13cfDO6O4MsNqlOc/0SNgN6YC4L9gyo0ZOQFZ
         DXQg==
X-Forwarded-Encrypted: i=1; AHgh+RqLYAXvvJp9CLn7laPpWepjIHJUXptWRGokaIaEGRaxGomyYz6sduAsJ9bFIXj/M2ED1VlHrMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69QRjNTtAiDZPqxOi7OxPPOtga3RvQwoqKydsV/rB9vKw197p
	QZki7U26RsAWCEZOjf4KbYLQJdKt+YmqhDUif3CmhpZJul7xTT6J/PtwkJuyx9aZpkJEXq2XBS5
	q3Hly2qXsnz0Is5Vqk2SuACKsaK+uC4ixYbc0ZBN1
X-Gm-Gg: AR+sD11oDbTFfN4n9Zgyj7OghMQNfSjT9fyOzRGXJbZ/L4i1Qi3JLONcsPZuILBrei6
	CCTjRA8Hr99fcYmFF8Oem3aC0wW6P64HVvYYE9tR6m94V5lZ7cGwqOQdSEdfWXdICouOx3NxKfh
	8ppspac0To6eq9P02FyTL9ntN0najykr0cPUXMFxyGTat+BDRh03NbjUO2WtnvKieTZCM2Jr6ry
	qTNqTaprnE4HWj8SWpW42TWLGOwjw8EnqEPIGhVmM7uyWuG2m28rCXDlThEe417EZKHtWZ+16mf
	Of+uM2BGgoDrZVdUimrYaFh7sFSVKm3okgAiHCVjuqSiyiZZb7oyJZTUGTCwX4QoCTVTa+wL4gf
	L5eqBda62AlxY02toXTLiIuZad7sey8HCb/0HmrBGXw==
X-Received: by 2002:a05:6000:2c02:b0:47f:9dab:f676 with SMTP id
 ffacd0b85a97d-47fd2b5525dmr4943349f8f.31.1785501636773; Fri, 31 Jul 2026
 05:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728191448.349241-1-ojeda@kernel.org>
In-Reply-To: <20260728191448.349241-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 31 Jul 2026 14:40:24 +0200
X-Gm-Features: AUfX_mw9Zwg9VoLHTT8R79ujD8MOCPF53n-K-Uslo92UfB2J7RxiU37UxP5RVrA
Message-ID: <CAH5fLghop_n+vnBaiN+BuhDZ6Y_FYG840AT=DavmhpXAXxxONw@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function for
 Rust 1.99.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:15=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.99.0 (expected 2026-10-01), `objtool` may report:
>
>     rust/kernel.o: warning: objtool: _R..._6kernel3str9parse_intaNtNtB2_7=
private12FromStrRadix14from_str_radix()
>     falls through to next function _R..._6kernel3str9parse_intaNtNtB2_7pr=
ivate12FromStrRadix16from_u64_negated()
>
> due to calls to the `noreturn` symbol:
>
>     core::num::from_ascii_bytes_radix_panic
>
> The function was renamed from `from_ascii_radix_panic` [1], which is
> already in the list.
>
> Thus add the new one to the list so that `objtool` knows it is actually
> `noreturn`.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://github.com/rust-lang/rust/pull/159554 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Tested-by: Alice Ryhl <aliceryhl@google.com>
