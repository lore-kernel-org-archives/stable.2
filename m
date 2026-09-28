Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A54AE8A6
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595849; cv=none; b=nB+JSpM4VdydSqSKEjJgI6aYA/AtR7a2U4ElTx2gFTiSW1e01rVcde8+1bwtzokB7sAroWvWyESVr9x/ldzkpDbZFVXTEqQvZn5PPkDI5QaWoscKImL8VI98Kswv3v01ree6jxLvCWqMsrGObYHwp/hn7CIGD0dfVroK/nbf6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595849; c=relaxed/simple;
	bh=cin3DA6LiiavF71OaCw7ERldYl18r+ePcBDy/rOokZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSzqkLy86VfE5BiLDe6JAPYP1hWG+/BgDprOn7ViftUowN0or+o+nxRxW6V2soRtUyKg5KD2v/It33z7dth0uX9TtmoVcj7p5x2eZN9n2Qyjix6qpbbXZ3viHJT1Qa46NbtG7/griqTnIYxLM54zQcLPnLZwY3HTyGueBArDTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=NnqQ7GA1; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="NnqQ7GA1"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc79223bcfbso1446568a12.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1790595847; x=1791200647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mM0tUwt9blVsQ5lfP9VYBXJMfXAVsYP/kX/KBYmBv4Q=;
        b=NnqQ7GA1r7wYXuKWAQSR708sRw2nmPDhhOLjAcaLlS5Vag0uGBZB/AwRKx89U4dM7U
         0JJdoYsiWPvndg0hJWobjakfItElaJafFlPAXnl3MAYUXuvms7YFC/PqzPmMOPGGupHH
         pxuQiNOIq8TOI2/OcJiM1wljGExsmHTUdoT1qQkXi3y7ELRlIs0dU8lp5SUEn5uuLnH1
         A4p2beU4wz/M7iH9hRUystlfkGOw4/VxrDDoJK/m15Wy6iJ22w6VTx+UxHImPYLW4icI
         vtlGY0RNqJWUP8GH92PezqzxdpZgBOYo5l6owF6toVj6TIoefBaN/d9kwZJgmG/yPl1i
         roXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595847; x=1791200647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mM0tUwt9blVsQ5lfP9VYBXJMfXAVsYP/kX/KBYmBv4Q=;
        b=JQegizr+qgxN+qtCAbPn8ZQIqCfo3QO69/pd76Nl3xQsMjbu3e1xpScF5yxHDTb+7j
         4KDWMY0yB6AeoBRTWb/Y4grV5ADpH6Qi+uJN90sVyHcokw1zTnkXUXBglvh7lR0lteBV
         qRJps20D2HuFjPxpW8wBbNVcHby5jN2SbVRayW4/MPhZbc65b67c34+6YdtJRB81L0z3
         BNRORSCyr2mFOgQVAlfPu4RhMNg+0EHz0kzKiVHKE7CwtTZyc1AjZdId+za4KGfMrzSK
         6yG/CWfAQSL6KaAwWifRowZ0DGBkKkdUtfnPJl+tZ//4f5PTeJvZUT/W2wSfpQeQojsL
         P0lw==
X-Forwarded-Encrypted: i=1; AKwUvBxniMJa5UtTSEOWzpeopfoDipim5Jldb5N9Nm39oIwG1gaPCwAFVYO8DRN519UZq7UbjiHTuds=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwSPsOCkap6YMqkvWa+La+Y3ItFw46sNRoLlzTftzN6A1h0tUk
	xDHHS6g+Q6FhVGjmLJ3NNUJ+iVqLlBgQP/kbd7PkH1R0PsP//t5BUs+cIlgGc+DtdB76
X-Gm-Gg: AYBFou3iSmgXnSe3FGie47R/+waeYokpJVkSHfy6nViPpQ9RpN916M/feFuSWUsMwbb
	dB4K8MrjPuQJ9e0gy1A3ELIJnL/KiuU7/bTDaOkVfxlv/FSVcGPLtrBpzJeLZnOcFGaeuvZ62ZX
	TWlxzcozP29949gVT4s5QYIky08kuv0ZhD47u3bu5Ih18mMymhtaUm0PEzit40x3zAFBkPyRzkA
	gBuNGAhwwTemd2N8MWkdlhK4Rl3VOuS86CeEijAJ+b0OrBVdclf4angpBS9A2532a3iyeQwI7oQ
	AUVLM+J4Yz5pKHgepiE89EsD0kWOl7a3sGuysyE+pW7OhqhPBOSX8jJOR9h/CjUH9ZOIPnk7WMe
	aMwZVDFkMQaEICM4qFKbwAbkI3PrPCOqJ7Wr17Ote7mw478KQJWn/9EE4uXNDEs1cUpDC0V9tAe
	CwdsaLNrVX5HYL6MR8Qdxc5fwDJioFMYeVzF72SFJu+3vTXfQnVAdnTa3NfuyG2St04gb1c2TuC
	jjgWXQgx5wND4U519t5YDxFN0gg70tl+sWKSMi4bFLL25TduCrGJS/UR025usA=
X-Received: by 2002:a17:90a:e7ca:b0:3a0:e4ce:320f with SMTP id 98e67ed59e1d1-3a0e4ce6d0emr5463799a91.9.1790595846977;
        Mon, 28 Sep 2026 04:44:06 -0700 (PDT)
Received: from lima-development (163-53-146-100.ip4.superloop.au. [163.53.146.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm8196746a91.0.2026.09.28.04.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:44:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 21:43:53 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiale Yao <yaojiale02@163.com>, KP Singh <kpsingh@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bpf: Initialize IMA hash helper output buffers
Message-ID: <arpS-YZMmwRN0oUT@lima-development>
References: <20260927121400.1188165-1-yaojiale02@163.com>
 <DLQS1EUNZG5T.1ZCONM8DQM45@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLQS1EUNZG5T.1ZCONM8DQM45@gmail.com>

On Mon, Sep 28, 2026 at 07:38:57AM +0000, Alexei Starovoitov wrote:
> On Sun, Sep 27, 2026 at 08:14 PM Jiale Yao <yaojiale02@163.com> wrote:
> > The output arguments of bpf_ima_inode_hash() and bpf_ima_file_hash()
> > are marked as ARG_PTR_TO_UNINIT_MEM, so the verifier considers the full
> > range initialized after either helper returns.  The IMA hash functions,
> > however, leave the buffer unchanged on error and only copy the digest
> > length on success.  A BPF program can therefore read stale data from
> > the untouched portion of the buffer.
> 
> That's not a bug.
> These helpers are available to LSM progs only and LSM progs
> require CAP_PERFMON to load.
> With CAP_PERFMON the verifier allows reading uninitialized stack
> with or without the helper call.
> 
> Since commit 5da4a9f26fca ("bpf: Preserve stack initialization for
> generic output buffers") MEM_UNINIT helpers don't have to write
> the whole buffer.

I suppose it's also worth noting that the return value already advises
the caller how much of the destination buffer is meaningful. On error,
nothing is written. On success, the returned hash_algo value identifies
the digest, and only that many bytes are written, so an oversized buffer
is expected to be only partially filled. This is also by design as
bpf_ima_{inode,file}_hash() already recommend passing a buffer large
enough for the largest possible hash (being IMA_MAX_DIGEST_SIZE). A
caller that honours the return value literally never needs to read the
untouched bytes.

With that said, this is a NACK from me.
