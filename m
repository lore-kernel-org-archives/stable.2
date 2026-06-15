Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68D33EC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481906; cv=none; b=Z/9enU+4lOcQ5e/uFPz5pabTGZZnKlzfkEbGtT9cchzgiZR9Outxu9pStU1pICaU5lVy338EfL/tliw+bH+Tx7IXG6RfCgBtSgJPFt8bc2ilmnqSRWOMDZltw0OzKBReplfsdiWgFn/EHYEmV5Sfrm9Bin7kn6eNoLT9ABZ7gPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481906; c=relaxed/simple;
	bh=+sKO4BRSMEHnKqnwGPSXTQjcdkJi213RCzRbiN8vh3E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JumrMeXa0bNEi6h6v1yAH19AAEFTOLS2lw96f/u/d5Y0fjjCTFnX9MSO3fw0B+xNQYQrU/YavpX9wbBeA8HTUz/+V7Etu7u0juECAzdWFIYQFUCOkcuTPSExRwirjuY94wF78h9eW+se4xZ1VNIiajRcSnX9FggdAQi4Z3WDGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzYUiAfH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzYUiAfH"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-48662d16d08so1053374b6e.2
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481904; x=1782086704; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49/WFGBQV+h5/Hr/WXvhLPsB3u7z9gZgu6pPYMhYOFQ=;
        b=HzYUiAfHmZKHyNcSj/2Oomygj6aJSqgSM2hLpwhugf90Qnp+MMn8UAaQAYc5LIqKfx
         wwUcPmc0TI0Nr+7r6OymSMLXQ1i87VoK7ZJTHbM6SMjZdfb08k+hae+Jkwtiq/zrw3ob
         1B+SFkDJI1Njmd/K9kvG7JRysT0Vao+0ocSvBL8Pq8FUBNe5RjldSpjKXIYwyRbm4J7b
         krewGN3myL7EEvZZ3aWPgGWQGycWDt08GMHk8KEIyyONiN13bKOiu3QMQ/E7KKdG+S9K
         lKDet/lwF3af4a22gEAb4BtCBj32l0jDXnu4p5H+2kYHuqQ3RzJEtaJtiMgUPn3LcS3D
         fp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481904; x=1782086704;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49/WFGBQV+h5/Hr/WXvhLPsB3u7z9gZgu6pPYMhYOFQ=;
        b=cXJsdW+Z94jK1eZBbkhIJekVrO6yySZuZQpOZ7av5Mbr4OPV4aqGFBrN2LLhJCWINY
         4OC+xnbW+s4upzTq7N+pPW+EzjeZWiDbmYmxpISXsiAXSXfpo6XaZkH0JvYAgfJpEdHR
         lUyEY6R7jygqhWzjeULukVoq11tSavPfXG4QbFiRDoVqaSUdFCKcbeR9Oq2l0gWuvbgy
         AfPyyvpMFlFIRj+ObSkz45+s8hdmB3U8qOgRMI4UWsx8VOyqs8N7ItpjzKJaunzPNNur
         4UdYu5lXpUKey3hAUCQZ3Xc/uDYMR8z8rTAxhL5+ae2atONieogcUARoL4YGBFklZ0Oo
         tTDg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZWZ12lwGNtE5uE8W0UYdAju78qKnMu3OzSlELaWJCS4GBSvWMLzw3kQdoXmpnBcNNvEipxiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuvaHgVTVfMlAPfrvYMKZ7m3YI9EHApl7cNxIx/iTmM3LY4QS
	N0OnpnxOBEHnyv5fjKG//wdbbuJt7Z+OEQxwayp+TqDtkwCu1WVUY15a
X-Gm-Gg: Acq92OFYhdj94BtjlP5XzbZgtASRjNiZNtHaGdLrr1XubZZvq7tZBHlHAvW6vEExgOG
	63Af0F9vpT0ANsfUaaX+nyjU3bCIvZebMDNEtVWca9Aood0ZKzGbco4YtGx64OxfF/L148tGYAL
	4J0YjExrxp9CHxBuTKFn10IQfNVTHPvctrmIcVSFkGb524/zsEy2zJF/a4hMg5JG3rMBAt1BXbg
	d7Sey1lf3Q31yD6pbPPdqK9MOY0a9cpJEatdgiIj4JqApPe0lF6BIwv2sszTrwN3Cmm0gqCwHY+
	LVM7Dx+R3bxk4x3KXgdEKhLMvaQkQ/kWpJ5H7uVrmEk9MjRZfXRfHVhXcUNLRzldwD2BptLxgSu
	k9yDNcYNiY6CbWXnVSyhmcJ+Ej7GtqGflxFW69XaTwSnIAenZi8Ib76LXfuewz+/F9wnkRQKVeQ
	7TwNufAu2Pcpm2FYGhyoJDVawZhwFvCNFd+a6u3+qxD9yALrqx3kRhZStLBeV2BZx4g/Vi8ENsR
	Oc3FDckY+g1onNI+g==
X-Received: by 2002:a05:6808:1998:b0:47c:be93:9214 with SMTP id 5614622812f47-48741b03cc5mr7019470b6e.20.1781481904332;
        Sun, 14 Jun 2026 17:05:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875df7fc36sm1762551b6e.9.2026.06.14.17.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 17:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 17:05:00 -0700
Message-Id: <DJ96MMRGKH4E.TEU7DC2PNB7L@gmail.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] libbpf: Reject out-of-range linker
 relocation offsets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "HyeongJun An" <sammiee5311@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260614092616.165337-1-sammiee5311@gmail.com>
 <20260614092616.165337-2-sammiee5311@gmail.com>
In-Reply-To: <20260614092616.165337-2-sammiee5311@gmail.com>

On Sun Jun 14, 2026 at 2:26 AM PDT, HyeongJun An wrote:
> The static linker sanity-checks relocation sections before appending them=
,
> but for executable target sections it only verifies that r_offset is
> BPF-instruction aligned.  It does not verify that the offset is inside th=
e
> relocated section.
>
> A malformed object can therefore pass an out-of-range offset through
> linker_sanity_check_elf_relos().  When the relocation is against an
> STT_SECTION symbol, linker_append_elf_relos() uses the unchecked offset t=
o
> find the instruction to adjust:
>
>   insn =3D dst_linked_sec->raw_data + dst_rel->r_offset;
>
> and then reads insn->code and updates insn->imm.
>
> This is reproducible with bpftool's static linker by crafting a BPF objec=
t
> with a 16-byte executable section and a relocation in its .rel section
> whose r_offset is 0x1000:

libbpf trusts ELF.
There are many way to crash libbpf and libelf, for that matter, with corrup=
ted ELF.

Please don't send such hardening patches.

pw-bot: cr
