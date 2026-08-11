Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA035BDA4
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464238; cv=none; b=PF4XvOUhie/Ar2uOe1NiJ+zr51zOZTvX/IAoK2AwIUFG9G26KCDHbXwynhp7YEmesU/cBRAfNZaifS73WQuSpc1zw013rA2vtwPtRAPaoDFgJupE/sGEnGAM88a/fTTK74MLAA+YE9hMCRktijVo5a+A4OoTe8egP4hSJo9gSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464238; c=relaxed/simple;
	bh=99emt8x2HrDIgJ9BWyttAeHBGO4VSbdX+I+z+lETRCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXrc8bnfDeYPucCaMyBuAhG7InF9YKZueslKrdI2Js5cpvFbFCDWke3QCfkiBIO5sOMTR+V59j4Un2mH+xOfwkfMt6a4swPK8ed82ue/JAKPI2g0jYCEqqoLFitzyIwegLUHpx14fvjlFbBiQQWv/PXZe0dDBGHB/q9MvUv17xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbZmw2iP; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbZmw2iP"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484f26852dso26364b3a.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786464236; x=1787069036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9v29TC3yzCAC9R3Zjwzq+fvKSc+kp/PprRrh2ko9Eo=;
        b=qbZmw2iPcnpzFJWT0nVNe9JFhjWbTLshXAYBKFrixIdlcWT6aPdLQ3GI1RKMbAyzcs
         tJ+zfz+bY9NlQF639tLp5DfN6SsmMhsayYWZFID93u7E8qv4sW8Ye/Lk91hxpfuemJAz
         lH7+WReVNy1y0O73cAGJ08aQoGuwxaRosKooq7ZS+PoDJL4J6uhS3DDXOC52anQnSjip
         hbRVFMiosDySVSkTVUYbddx72lMqE+XlqQTpma0z1453OP96FdTfTriRd3s6P0CaagdV
         nEKiIMygKhE4zILrdOq5cNSQ70O6ybb7JLxlGHciJtzoKcXOsTy7NkuPHIwZcpuuHEhN
         LmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464236; x=1787069036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9v29TC3yzCAC9R3Zjwzq+fvKSc+kp/PprRrh2ko9Eo=;
        b=rlf5mJ52+ur146yx3so1NaWYPl6jCcG4e/E4xGV73fcFTL/5dQVX2HZvuahKz5KE/4
         Uzy76uyvdvGb150DgSGvmaEW66QrRHKX65A1V+/Lo/wLWYQ0KgElozDOO614h9kKAp/E
         cKMHDtP3swIHEdUYEVxuTITeHBR4QO1XOuBM/m7v4oAjSpO4TJWc01kJTgSJ+lmD3t/s
         A0PdwIpYw5jb1fHJBIUtWw+oraBuavoM+p9Cgi4MqB/QsAqjCI5O1JV5lpzHJwxd+Ibz
         AjNpXNU3xqXbafmbduVBhtHJxx9af7N0syJGsL7GsUKSldrSGnziQu9hMYpAfXV911CZ
         6Zaw==
X-Gm-Message-State: AOJu0YwjCHPxivPN8L4pTOZXDC/Fc+g8isR0FBSJSQ8usWWKdJCvOHZo
	zLY5bW3jrlnNBdV/DaI7gOV0YLVHoA29HeSEl99V1hfugYwsZSUDNYq1kHw0XEfv7Y+Tu2x68g7
	bvPFeTA==
X-Received: from pfnv2.prod.google.com ([2002:aa7:8502:0:b0:847:7765:a4c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c1a:b0:84e:24df:3873
 with SMTP id d2e1a72fcca58-84fa88c5340mr4413669b3a.32.1786464235809; Tue, 11
 Aug 2026 09:03:55 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:03:55 -0700
In-Reply-To: <ans1SMXHmdB3uEoe@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
 <ans1SMXHmdB3uEoe@google.com>
Message-ID: <antH6ysN2SPR2gyV@google.com>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete
 root *after* making MMU pages available") / CVE-2026-64561
From: Sean Christopherson <seanjc@google.com>
To: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="us-ascii"

+Sergey

On Tue, Aug 11, 2026, Sean Christopherson wrote:
> On Tue, Aug 11, 2026, IP over Parrots (with QoS) wrote:
> > Hi,
> > 
> > Commit 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root
> > *after* making MMU pages available"), which landed in 7.2-rc5 and is
> > tracked as CVE-2026-64561, does not appear to be present in
> > linux-6.1.y as of 6.1.182.
> > 
> > I checked with:
> > 
> >   git log --oneline origin/linux-6.1.y --grep='invalid/obsolete root'
> >   git log --oneline origin/linux-6.1.y --grep='2abd5287f083'
> > 
> > Neither returns a match and it doesn't seem to be in the queue.
> > The commit message notes the invariant being violated was
> > introduced in 5.9 by f95eec9bed76, so 6.1 looks in scope,
> > and both hunks sit in direct_page_fault() and FNAME(page_fault)(),
> > which appear structurally unchanged on that branch.
> > 
> > However the announcement[0] only mentions the fix landing in:
> > - 6.6.148
> > - 6.12.101
> > - 6.18.42
> > - 7.1.6
> > - 7.2-rc2
> > 
> > Is a 6.1.y backport planned, or was it skipped deliberately?
> 
> Now planned.  The fix doesn't apply cleanly to 6.1, and the resolving the conflict
> isn't super straightforward (though it's not thaaaat bad either).
> 
> https://lore.kernel.org/all/anpVAhjqvBvIuoa0@google.com
> 
> > The security tracker [1] for the Debian 12 stable kernel (6.1.y)
> > shows a vulnerable status.
> > 
> > I do not have a backport to offer, so this is just an inquiry.
> > I am happy to build and test a candidate on 6.1 if that would
> > be useful.
> 
> I'll post a patch today and Cc you (unless I get goldfish brain, in which case
> I apologize in advance).

Actually, duh, Sasha already posted backports[*], and his approach is much better
than manually resolving the conflicts.  Testing that now, I'll ACK those assuming
all goes well.

[*] https://lore.kernel.org/all/20260730121535.2208491-1-sashal@kernel.org



