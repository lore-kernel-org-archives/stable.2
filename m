Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992443;
	b=d2cD1hDzjT1rCJKJxzMLtEagZY4PPsfv901CbnSVuqQTgwxXPiBRBjYvZrhSmnzWUZGE
	 wquTA8LbAWGQIELnAsDBplqdMmobnBc3YbRYRbNMha2u+07XSv4kKGkC9X6UKCzYySuJV
	 HlToOs7wDZYfvXN/1CicZgXEfMo2kGhNxOSOditMTkl+MHnQ4n9jMdr6VCE2DkQ+uiHl2
	 acITwxbA6FarGvcl2jA810j03aQUGsPYW6DN/Y9i/KXeXDkb8NgylRsMvjUOQOsfJrAiC
	 oR28SAoMjFZnuK6cddMJrImv0D2xdShm1VfoO+APivo6d8FJcn9XIRBMeufxMEKEBww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jqxyrzbxVSXD607utnRg/dtiDVgdF2PcAOp0S72RBFQ=;
	b=eB4o5uncYZbgPeO3QE4UfwEfvSKq5Mr5w8BiptTuNVY0H7wpPlyw2d6BPJYaWHtglbhJ
	 DDn57gpW8gPb43CpTV34jNH/bBnlYVR971C8ZXyjLz9bbjzJr0YP/gZPnx+d/e9w1QsF6
	 qxdtw17ta8VZ4a5iQkhpRtvXvgx2WNONDE+6ga9XjCGNxiUgzIgohjC4FnGJgG97TPbCl
	 305WO74gOhH0ybFPRroqNRS9VLVAtNINl9XtCCVHx+DM/DcpYFXWxw2VSh2agSb8uzH23
	 BJ69KEbxKomDBIASDyvaLTbxRg6V8e890KkwitqPbKuBzb3eUK3DNX96yHeBgpb5LRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKwPzUGZ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58820606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58820606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKwPzUGZ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso6183055e9.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794992442; x=1795597242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqxyrzbxVSXD607utnRg/dtiDVgdF2PcAOp0S72RBFQ=;
        b=zKwPzUGZYmdddYPdPMlo97JJvnFLGwWmfOZ2NpMlLSl2+n8Auivewm5aGXoLjURAxQ
         I1heZ3JZhkSdFNxoDh31PW1FSzHrnBG9kyJMTMvuA1y057v5Ivks3AJuhHbR4WAtmy+y
         R4TKWqFzoRYIjwGeHJEjfTPM6cnkbk3rM/TUkbb6BDB4wl1dEx1VbnK8drtttqGrcGTk
         pGRWttYEMGz8iS6TsKajCCkGuqVyCNriXWYVikyvuCEsYfaqNKHJP71fLUYIk89zRDIF
         nggT8+l2Mip1jNisBJLGRcLWc6arfR9T2WqN41GNM0FN4K8iVCU6hYQkxoBCeNE6zp9U
         ADpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794992442; x=1795597242;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqxyrzbxVSXD607utnRg/dtiDVgdF2PcAOp0S72RBFQ=;
        b=CfQhJkORPrs/yF5e5t6Y98O2RVr5uTvrPV346eIpnZng9PSRjEszsxUYLuCfHTPxmX
         snS2AvCVLFL7Vk3YK5csqHdK8nBYA3GicVRpU77shONKACHtRyufHEVHOopsPj4Vo3QX
         wVmAc3M/FTHv4CoyUCEp6tGRcdBSsRxkltQbsXFcRj5UI5zg/pc+4ubujyq63wQdmnfO
         UYNClaWYNlivDUu3r0V8FqnBrvwhA/9Ld/gnSPTZeQR5TY3MIUMWaI44DFpzoa1SL0M9
         MCn3+q30VcwwyQBxBbzLCvm+2G/hkhcdXUFi75XKXauAzW7vdszHA7CYwpJfcs8io4ys
         couw==
X-Forwarded-Encrypted: i=1; AL+hErGGUiSV6OyOeYmQe+0YVKc2a7sfgMReTAyX3jo0yo/tTYuxj5atIV0uEAsT//EQnKm8Fhxqx2I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9INWBkXxJJhcSgoKANdZsi+XwNwQcB4nDT4b82hzJcUOTRR7Bl
	dwaNKaSKNiJAuwOHzXwCCaxnvGD92qes0rEutLSzyZMyOLpk9PJEoKJju9e/R4uU
X-Gm-Gg: AYBFou2a63UsVcM9E6NJAIBXuWMD+MvoUc+9jffpB4Ui0aCosTGLWU0MmfEmzwkDGRd
	KvMd6zyzodcydCFHW8BOkDFVVTPXcX9kwisadd5GLurORvcpLWOYr1q5q+jKt5Lnv+SejJ/t7VP
	GJWdHQtmFNByf/t8jP25JIxLWnAhecDyou/DO672VC5kVJPQjFWlZIvcxHKghH/uTzjnwacicYB
	6pPb5uK30KUWutpFwQq9Whx4GK8iua2UUe/4THQIRXKmnhIs733mHGZa98s6EZo6WLuHjvFUkcr
	OZpS2Hzjnt37LoxpJB70Gfm5sytAtW9iHc+8ejb+FRA6AjobbytHEAoiOSPT45oHJUfzKVYt922
	20qNt7HQaTR3x+lRLnwJWM7dQJ6K0xsLHMjoLxMQPJyVf9fv1oIZqkGEfgFt/8TU6xsrsx8Zbiy
	zuibJ06OLAAqM+X1peeKa6apQ4QLM+l/+FvzSElx2ZLWlSX7uUyJVhjD3UyPUK570Ko/LV2zhTQ
	NvkQuGoyOo7wcFhOGXM11WUXhX5WFViCcAyTtbjohJtm3McJc34Rg0mHWOwDQLPBSdpH5YSz3gZ
	TpyuqvmpnJQb3IsN5PW24PWVaZVbAc23gDVe3F8HMh9P3wXh4qvvV/bTGVNe0Hs3FQ==
X-Received: by 2002:a05:600c:8904:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb7daa7fe1mr24609405e9.21.1794992439985;
        Wed, 18 Nov 2026 01:00:39 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2b979bsm50470825e9.11.2026.11.18.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:00:36 -0800 (PST)
Date: Wed, 18 Nov 2026 09:00:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar
 <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261118090035.15ced20c@pumpkin>
In-Reply-To: <20261118072848.GA325225@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
	<avrPcQ4sOkgJPbkZ@gmail.com>
	<20261116130159.GA1327949@ax162>
	<CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
	<20261116223628.5a6139a7@pumpkin>
	<20261118072848.GA325225@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 00:28:48 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Mon, Nov 16, 2026 at 10:36:28PM +0000, David Laight wrote:
> > I don't even remember a check that the compiler is right for the architecture.
> > I'm sure I've got strange errors when I've forgotten I need to specify the
> > compiler for a cross build - and then forgotten where I'd put the compiler,  
> 
> Yeah, I guess having some internal check that the correct compiler is
> being used could be useful/user friendly but given how fast things
> explode otherwise, I am not sure it is worth the additional complexity.
> 
> > Oh and forgotten all the things you need to set to get clang to do a
> > cross compile.  
> 
>   $ make ARCH=... LLVM=1
> 
> is generally all you need to do nowadays.
> 

That requires that you also get the correct clang on $PATH.
I'm sure I remember that not being as easy as it might seem.

David
