Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196336;
	b=4sz0lv5Z5S5F8sE3chdsmTudFzFFjtcQSE6j3uNjp1Egy45sJqDTyYhIN9JZd6HtAM8l
	 VQUdc3LI0+R/3aarbggYaS3PhSABWPoZbDI4zme06MOZrgTLLnKD1C3BPDfFAdkXIjqrB
	 vP5BKXrXcnfUqhBsrGxXlPNJAgLQYy1x8g1eM2hf+Md5XmrZbY+X6zWNUGp5UJDVDJDoT
	 EkvRPryLFk++LSMj69tozg7Pt7CbataYxwzLAJu8xMG8axnVJaHIrwH3ttPucVd66GgYU
	 4yMvuGYnn2bk4xwnulwJ23hpP3zRH3FrlDqiqfKRWF6Sk3AYC08EJH7iYYPX6i012Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KTQmlFfwUQU4v+NLA+yUDpQoUdLsc1gGPYlZIjQ7eEo=;
	b=2WPnkXu7CIwt6G7XrJSkexOC9eCtoHR3suIrZZKkbU3MfI/60gIoXO1HQwe9DFrzClnu
	 UFe5VTHMHWAGd7+UFiDzrguzdNo2/l5F2Zeabu4f+AYhqb5ifn8OeAer6RqCceVrNzdrj
	 w8Qi2L6nRD2fC29eUN/S4/6ACBLhYTC91WrlNhCKfnpRah/bIAbJmo21yMHF7YeqNjXIz
	 yXKU2ssq9zqbJRPol62A0Opu5Cvr+0IqB++Q064Zex1siduNuv6gvQSaiEPp1SqXU3d/E
	 /FbLwGgxmdAb6V7h6ECto4npXbpdEyXk1xDvuasTKx7bX3tYqaJ9eIBxuw1nJFOmoXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLqTU0I+;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D0606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8D0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLqTU0I+
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f0458cc9easo7638225ad.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795196335; x=1795801135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KTQmlFfwUQU4v+NLA+yUDpQoUdLsc1gGPYlZIjQ7eEo=;
        b=ZLqTU0I+DIIHMin65pUJcuDQgDfSkiYKNkHSq8jQ2W1y3uMQaQPbei6+eu81GWf6Vn
         KfMyIv597LZ5FDfOmkRrYz6QA5ZVwklvvIkdS7QUpmDkbyA4nTtBRgXM72IXzfhAeP3W
         KnXGCWDrVBPaNcPYgQAPiwVRHiH48IWIP4jw1/pM35UI3IiPlG0O/c4k4O0yd7gbNsM3
         81YCSm6zO16/6p/yt98D/h0Isr8KQ5k2zBEa5m6cdNPqxQX18ZHqgxKDzVTvmtpZsmkT
         zbZ6YQPYIEQu+Y/TT7Tm7ujj3OxJ1vOEgM4VTNcKBV5LHzJ3MjXuqmaRaP2FvG9ghfN/
         ec8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196335; x=1795801135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTQmlFfwUQU4v+NLA+yUDpQoUdLsc1gGPYlZIjQ7eEo=;
        b=zEN4+Pnkjjcr6X3opitBzqa4KgeZMj4rd5dN2hjIj5B1F+cmCoJiGNuA1SWMcMqQLQ
         l/Eu0F4q30r5jKB5STF4gHmgS4I3yU1Gqy/AJRRj5tLIKVjvHgUcXR9DJxP+ETBssCiv
         GJOuue9q8Z63yXg4PY3hLS/H9q8fLM8paqguJ2+RkaBofcVsBA5oP21PCyda2QLG7w1Z
         s2uYT5osAqFJDEX6WS3pcKXW1QLg5rK9Cyw0pfOjRQUhmgn1U8baly3KG5J83spJDuqX
         6EOn62EIlmDK8iO+15xs7EOu0xD7rGYCYBDXwgHkHykTi8mpIsENNsyGURmEYJYvSwLI
         Xrmw==
X-Forwarded-Encrypted: i=1; AL+hErEHVtVOPBrDIORTkwIRvzvuU5iga8HH5QywzzswLb5In08C8Qdd0WVFsRvAkC/w6xzeT5SeTEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vCi/IxrKDU+pazpivnglyuFKzBDZc/YoxXfKzhvFJREXuHL8J
	svM4QWX4e9PTXKwSOnU4rOwxtxOuMdn7gEzmHeCD0NGHG7/J+4Z6sxFuBJvs6Q==
X-Gm-Gg: AZFdTZf3qMhGuV1yF3qYL2g+dXW2D9NHx9CsEUDTy6pyftei3D/J2oX3RUrIWTrosDb
	1T0tTWHtpZMrT7nVg8CFEasnSCRJEtpbdU9lOCzHYaZwu67iieU5Gru04U/yu/Xx+0FrcFIBzyM
	65wYK4e7GNirjZeZmvy9+KPSEjhvVqm/qFVAgG2NAujN6xKiopxe34BkFDV26rKN1AEqzviahoQ
	4+RhE3STN+ogzZQLZ+xsKBHBqpeps54hyEXGDxqLxP3vbExoFkl9sj28MZ6Dm+hVpbUilmYu7Do
	89yzoGX8oV1Nllwn4yopYjcCcLPPyuXMlBMBikV4lYMTByGxqRfwWS8WCI+aK3fcxgiCb6rgwfJ
	gFTwdgbaueXKgkmOLhSylYXrRgqNswpWqHMwZtxd1NofqADLNGapFFL3xM99YLJjbul2snB1cAE
	m9+gVu9TAhFD0bkghVIaTcCEqEBLpkPMmbTu/RlPcPjBRJEUcjlMaTGP+eQCuyayXtiDHhaeWdf
	XVsSBkNSCwG0N94gQyM4tifHoYZz3LUH77a4yvJoigHlCXoLqhMuqCPtYkCkAAnKHv2L+Z4gsJY
	VBLxwMSFfscVE6ii2iM47nvNNB49ICbZFrF6Jf9sU11s6i2clN73iugaUGWpqx1hxObG4t31AYY
	+zMFSGDfLwuyODTxRA1qd8aiz72pyKBGGsQ==
X-Received: by 2002:a17:903:2391:b0:2ef:f01f:fa4d with SMTP id d9443c01a7336-2f03f1e0f73mr43801925ad.51.1795196334841;
        Fri, 20 Nov 2026 09:38:54 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc4f2sm18100965ad.30.2026.11.20.09.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:38:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 17:38:53 +0000
Message-Id: <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
Cc: "Ryan Roberts" <ryan.roberts@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
In-Reply-To: <awAay4FFj1_wQtaL@arm.com>

On Fri Nov 20, 2026 at 10:02 AM UTC, Catalin Marinas wrote:
> On Thu, Nov 19, 2026 at 01:18:03AM +0000, Alexei Starovoitov wrote:
>> On Tue, Nov 17, 2026 at 09:23 AM Ryan Roberts <ryan.roberts@arm.com> wro=
te:
>> > The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but th=
e
>> > interpreter calls barrier_nospec(), which falls back to a no-op on
>> > arm64. Programs executed by the interpreter therefore lack the
>> > Spectre-v1 barriers assumed by the verifier. Contrary to the code
>> > comment, kernel-wide SSBD does not provide this protection, since it
>> > mitigates Spectre v4 rather than Spectre v1.
>>=20
>> Nack.
>> In bpf-next arm64 has no interpreter when the JIT is built.
>
> And what about current mainline/stable or when one disables BPF_JIT
> explicitly? Should we force BPF_JIT=3Dy as well when ALWAYS_ON=3Dy?

Anyone who didn't have BPF_JIT_ALWAYS_ON=3Dy were exposed to speculation
attacks forever. The security hole was wide open. We've been saying it
forever. At the next merge window we will say
"you cannot make wrong choice anymore".
