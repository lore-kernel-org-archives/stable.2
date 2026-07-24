Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2093B19AB
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887648; cv=none; b=BYE4kCXIiLmj+xYBIq0ehP5zRiPRTnBxhurd9II8eb2Sf+3EfRyLbz6e1AeYwYss5b5dbMmWWnyVsWGPGGkaveeRd3E+wWjD3Jq90vQZx27ZKrsg4mKOv/4Xr1vZ2DcuJ7gG1q19WEPMwX80/WhGz2s7B42pzdjLe5/H6eiNZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887648; c=relaxed/simple;
	bh=tTK/Xv4EuhdjSo6QzRV7l1c1SvQdyST6lUsIk0NgKBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgYW65qHytNNEHUdp3oV8cM65hMutySexc3y83Gj29D9Soq2s5HZSbmhYBaZyI6PKo404EIvPjrnCaL8950ZJcvJhJ4KDORB3QVAnAgyef0epH12BArjTWVLOmHVHVpcmJCKQ2RHLD86rwII+pbLjbUJ6cIqfw8IbaZ/Pz63iZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Y24JGD7Z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Y24JGD7Z"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so357691a12.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784887645; x=1785492445; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTK/Xv4EuhdjSo6QzRV7l1c1SvQdyST6lUsIk0NgKBg=;
        b=Y24JGD7ZibsNEb6FwF4z4InP1TTEqO1jqJLhwr+YebPL3UCoN5K4rIGQEv5HLJlHqT
         3uJVLukB8KwaSIxdlpyoD0YyDqZbKO+N12MWr3bj5UkGQi4vyFqBFtPQuOBFl4xMSNpI
         6ZLBP6//IZVIr1qJvp5ACFiVX8tcv3ywjUQNuVtEEUo+D498mKuDGm3wX0W36tEHDK5w
         Qd0z8/md2ADzFYVvuvrElhDH69rGQs06Hzlf/wiUfARslnbNGwBN+cpJz+79xDa9sCrU
         YIawR3SzYWFSaD1NIgkN+l6WmtrpkKzm8SgSoBUrOIJGDpcJuA5pc/viYwgTpHaXIAcJ
         oztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887645; x=1785492445;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tTK/Xv4EuhdjSo6QzRV7l1c1SvQdyST6lUsIk0NgKBg=;
        b=idVhY94X2RErPMU8JjNm5lZSzZKioVJIiN9wOxCyGn2KLEjhY8ArKoa8iQf3Wjcp8j
         8zz84YPt93qgiYufMFsA+9EssgT8Eu1yxlpOmmpiX5a+AMGU2pNvc9ltiBRWAq06x4hx
         lP4SPkIFPy+EFJH3qXCWNKwpuZPTHSJHulzolSjDasaRhBPHVcEPxM1g7Inb+Eqsw/u2
         uJvU/C/PYETeeDELy46v1SGLyty0x4NDihgk98GkG9sSyiKK5eynhCR1Mz70Hjt00Prt
         JcWOSoQdxzvQhj06ddYzA1z1AoQ29ChZ6vvIsnXyeHlo85l9SRqEY2kJQRYSDpCB6SI3
         Hyzw==
X-Forwarded-Encrypted: i=1; AHgh+Rokt1qdjipENu8oXYFW8pnaE41J4VTQg9Rhije4a2pR0SZIovNnoGHrGUJwrwoHuwOF09VPtbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yv+Nrd23xpd3spAlBdQd0G0/HuJ+PV/IrAb2zJ9IROrly2+Y
	58CPYasEcWz7eI5KhdJ/i2X/9VZKA9ENpTS1D7oeGxO9ttqiv20G69I6m4o5GkDFWbE=
X-Gm-Gg: AR+sD132M2SmsmuhN0Jwj16DVkiyKwotwUNRlKK52CW5GGiWLRZN8G+eyFCt8ck7Vth
	/0FJzyVmwkJ8n/pHahguji18IAqhMFkmoDqUgTYKYUCCpgb0t5R5k4cpX9g2zyIx7qdlCb3JFsr
	esN0hGtUDIK9vI31VaNOZVm9dGTp506JCievaMR7jjottaow9Tbvu++OExLhVDVoqT951SdYhB2
	XNWEEpEGehA2F2tvQnJEODiRYHklVZn8ziCchQYXSDFYvzOMYW7vDURXUYUHDIQ9ctjV5ciazcq
	+Q/nVnESm+tu8p36aE01NeC8nDSKDJc+PiRcEA4HiFTnm0zmnmN3RTtqAArKpMUCmFuVy0AwAHO
	6ODuZ40cu8NW+RZt4tsHanhUtcgEVNm0I7ZkSc+LCLcnGq5AKFiEfwtPdletDy6xHnN5eJNr4f6
	nXRk4q7iOxotNphEA=
X-Received: by 2002:a05:6402:1f12:b0:69f:4b79:6374 with SMTP id 4fb4d7f45d1cf-69f6bf0ac12mr2926275a12.13.1784887645054;
        Fri, 24 Jul 2026 03:07:25 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b610sm2893839a12.15.2026.07.24.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:07:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Eric Dumazet <edumazet@google.com>,  Neal
 Cardwell <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  John Fastabend <john.fastabend@gmail.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
In-Reply-To: <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
	(Chengfeng Ye's message of "Fri, 24 Jul 2026 18:02:33 +0800")
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
	<20260723162602.3275661-1-nicoyip.dev@gmail.com>
	<20260723100030.3eee6d51@kernel.org> <87ldb0lo8t.fsf@cloudflare.com>
	<CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 24 Jul 2026 12:07:23 +0200
Message-ID: <87fr18lmzo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 24, 2026 at 06:02 PM +08, Chengfeng Ye wrote:
> Then please just take the original v1 patch for reference and ignore v2 and v3,
> and I will stop sending new patches for this report until there is
> further patch review.
> If there is a new patch, [PATCH bpf] will be used properly.

You need to resend v1 with "PATCH bpf" prefix for bpf CI to pick it up.
