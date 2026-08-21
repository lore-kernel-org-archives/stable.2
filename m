Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1B39CD14
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337583; cv=pass; b=B+VWF++OI3TA5X0GlVRCnb7TtO1qFQjIxeNLvzXpvBnMWPrzDlpnIlXVl72xQRlVJR2o9j9/QzezjNPzL89J7RzMor6u6tyB5c7PC5o6uOKMDn0lqDEZmI1+UfEZ6DZ5AlVh0ZfQLTTXxQgIcNn6Q5Os6M/ookhU8IvernoDj2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337583; c=relaxed/simple;
	bh=H5ipRC5ikWPs4GHwCKt6WGiprEkcyH6ySvuXZqumRdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVmfD2nh7uA5tE8RZrQuRCzuGB2GdnpXpauGZtMetNwBHpylcE+73d8CX5NQ2KaC4+phSVqnQWnnBszQq3zeVQEu7aJkIhVbKalAxRNiL183RJttSWYsT5KaaatgMeZUH3vxhvtFvzf2wl8cS8R8xS8XQmBYfu/drllz+KceQaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxsouX6A; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxsouX6A"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-908934450cdso10235746d6.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787337574; cv=none;
        d=google.com; s=arc-20260327;
        b=FPzJWmk+WZDoYDThIlgGUwrdFg+v8iG8/Nr929WotiECcxa/tdb3y88RPjEM8bTDuS
         QjSC+zC8327DjC5KN6dGLP11lxm9P4ijRU1DUDhiHqsbIghxLo2PW1wulHEZw8VE8ZTI
         QfbahvgyiCAaxsACDjcT9z+iOn4E3IKfvZ04rcYFxKNUNJN6fvOHTWNH7fCAlDfjho7v
         aLGDLqnDcAYTSbOQ5Cp0blDaeJk5CceySdHgNYv0eNDgmc4CW/PZcGSQBSERwMXvhTxZ
         Ab3yCaY76VXyxhG6xZKNHDBAajVR7ffHsONMG08WVr+zmRmoyqB2IX1l34nSfIEcTYUs
         EoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IThE4nMDn/1KYzHCuK6EXhKBsZ+s3+Zdwpu521vHb0=;
        fh=nVKF1BQyjYFzmqY4HrkTqNSCmMJWYaTaqVAhP3FZQRg=;
        b=H4nX/yNp6vwMzBXbf0vDEqSCpoi9n+SiMhHDoT5FgeIRmz3cxRujkm6gXZUmVqdWGX
         0rXW7rwewCE6zfx2BN+565A67gU8KSEu9pfANb5XQC6EQOjKZtP0uRXTonpiKdMNYfbP
         dR4M56UW3pZ/Q/WfKiBYldTUgxU/cxU2Ktpj2xC4tuCO661MY33S4vIBoc8LVBmXCAlv
         VcHoG8dfs8EPnbB23TT21IzbjLFXEZhsauOoUTnvwjwWeHiuJMccoERf3Ta6sLDdd6EW
         4gofNxOeuw0TzsHdcbpLBcRAwbpTGlTCZolyHhmmux5LgW/M2RtceSF+ywui0cL3rImo
         gkUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787337574; x=1787942374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7IThE4nMDn/1KYzHCuK6EXhKBsZ+s3+Zdwpu521vHb0=;
        b=AxsouX6Am1z6mIFATKB2wf+1uiSg6Jz4ujyimlTx0P3DvvvAQd4IKX0wlLY5pcPnwI
         Z8H0CHDan5XbRuiT0x/3bnYE6fkWSb2kGpek4eIjQKn29FhojK+keY2B9F+uYI/95Ep0
         bns8vtmE88fJdYBNq4f9g5dSdbtYvJs1bDdWZWa2v0bVqXPDGBULcv1qURl+ltp/lJDX
         YFw/l6mczIZRSYHHPvf8fqo1YkOqZZYsQuP/yH6jD8zbOnvoT7f1XSX3g5zAdI3KsonS
         H5frOTCBNb+FPo/ybRy6sfwYHcq8dFW3s8k4MfiuAhn1lU4G4NAcKZgG5dBE4h8QiR+/
         FFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337574; x=1787942374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IThE4nMDn/1KYzHCuK6EXhKBsZ+s3+Zdwpu521vHb0=;
        b=tR3vyFzT9LZgS7NPWqwcIHr3rhixRbplC8bQ7tbsLLvVycIPi9tPCOV2PXWfc1107L
         scFax3LRif4bXofDcJSrWN+zKFn843enav7GQtzlhG+ziFWM4gv39Fnah4XHlDOIn/vP
         FsIbk+UyT8s3JVvNfDwDLQnGBmZQyl+OUNNtRdOz5w1S7GDDIa9QpwENKY5A2jGzPimd
         +hu43AKjuTYBx6lXpu2yKAgG66ta+NIQDGkThblWZpKuMCt9RgMhuLajjLYvUztPtG0Z
         0RowiTs34GwytdHliZT3r5bPM12RpD6XIHiiXia6pO6QBiLR8rKIhWyimEHRrszSDHZz
         sLcA==
X-Forwarded-Encrypted: i=1; AHgh+RromJehmLcJrnBNXN0zpw30xbyfTNEOw/sSgOGcUHSGy5NfUTTQN3Fwj5wwZRmoodLrB9BvAl8=@vger.kernel.org
X-Gm-Message-State: AFuF++kykFWyylh2ZFq4h8SPlcXlVex9hv7Qx0wp1bxaCWcsVF24M4R8
	VBelo/WqovxFRSZyz+0vxn5XSRBhZUFMnIl9Ws0IuWv1BFYm14jYNrS4r9fPh69FKXcxTir7f82
	a4iklJ2xwju8cs/moEp6F6fNd6/0pPFd9/BS6Zi6y
X-Gm-Gg: AR+sD11hpWtsbve4RmXcC5IklwI2nB2gfNY95DoWgvJLq2giSlI7ILRhliPRJDZmLU4
	SD1tY2eOVtCu/Oy75GwcsqROt2Iace0rvtjF5Jt8YblB+Pzw/71SE/6W2iaXmHRDInqokLlAwxH
	Jr0dF2h6GqTa/d/CCH3SAdEPby0Mq4ujRat+wnpfMh5BoWdQLUW9NYu9njx91Nyy4HBOLCsg2jY
	sdD3aNHqFZckypWKeQrxal0Uuk9HA8+HibH3kEbdfdABwKy8YAhBKJRI/lwL5ppzvHv7uFL5NYe
	ZYzs8DfB1TQCnvdoD/URmF01Fk8zcoQnFQ4Ni+GpaQVI3Nf+ch2AraDt85uXYYTVc/QhLVI3Irs
	rspAnFCmkJHW8E2OU8g09Dfap+pSu083DKbgyyiaZbf8SKO0sT/kQXjADtw==
X-Received: by 2002:a05:622a:229f:b0:52d:8679:ba91 with SMTP id
 d75a77b69052e-52e09baceb0mr2165411cf.8.1787337573580; Fri, 21 Aug 2026
 11:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821182449.79785-1-blbllhy@gmail.com> <20260821182449.79785-3-blbllhy@gmail.com>
In-Reply-To: <20260821182449.79785-3-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 20:39:21 +0200
X-Gm-Features: AcwNN1Uzk2tJZgFXNwH3oaoWgTa7_Y-gFylOUpo_j5d9Jt50Dmca5FeLa3OmU_Q
Message-ID: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, yhs@fb.com, 
	kafai@fb.com, andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:25=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>   BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>   Read of size 8 at addr ffff888013701258 by task exploit/149
>    do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock().
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> The unsynchronized icsk_ca_ops load also constitutes a data race.
> READ_ONCE()/WRITE_ONCE() annotations are intentionally left to a
> separate change; related TCP annotation work is available at:
> https://lore.kernel.org/all/20260416200319.3608680-1-edumazet@google.com/


I don't understand.

This patch is incomplete. Please fix the remaining issues in a single
patch or series.

We have limited time; we don't want to revisit the same area  in one month.

pw-bot: cr
