Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577717;
	b=x32kFav5Od0YdxAxXuduRZ0vhrNlU5W27sRxgoT3Vvge4qQSR9j5JyO7fkzThulSInli
	 nW9MJAm8HHT+VZkuM0D0SV3630UDUz43j9mMixbd84MASTlcYLsgeRxvSmEI5q6gX7XeA
	 nGc5X/naa5rCpz5KzCJ7BAeaBd5681eCqsMZHb0hxwScxBrFYyDSf6td8srgvDZBfwXUg
	 Fw1qC8kithcSOSpsfJ7sYk07DCkz5TPfORQbubwcfiXT676uocendGypQLvBTNmh8FGqG
	 vQRV/wCfbyM0j1oF5kXcYlLyYgJEjPgGKMZYvdYR5XPx85KJHRwVUNmXAXrrAARKBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MRt/+n3qpNWP5atygjxku8RJqbtyvsNAOovAuzylIO8=;
	b=fh5SzDKdsgWZG4QQGfL6NA6gDnzkofygYAzb+kMZw5FrbYJhoNSUHBtxETUa6o9UJDZ9
	 7Z4Y1z9S6yU1HMflpvqh6lOkxXfd4TA2Y8dqPetfIdb8tRG8CGhzzRZZEk3e3RrFdq+6f
	 kBk1Yf7Evkkzmz/sMettSgUn+gEEl6/ZNRhfIc1BLgE10m6f2wVr4v/Y/zqCWt3HctLTx
	 Dd2CEQA+fzX2YhKwCzAO3y4cJccMcD+7wibbUu9SQcdxLQ/+H3T5wYaYXApqVbLnv1Gfq
	 qhktTAdeQltumOUfTEa8dyl9d+V0W3iWONibEGNbLDS4vDDoS6v94dwd07bABlbfPMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H7l3hkV9;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796C606A33E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0796C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H7l3hkV9
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b167bc8e16so852188a91.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577716; x=1795182516; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRt/+n3qpNWP5atygjxku8RJqbtyvsNAOovAuzylIO8=;
        b=H7l3hkV9qOW+6vyuUekiTht/VgeOUD9RY6ujvAaePTbWFCrkmneK+9URuCWnM4Idif
         nch2e3YuYB3HYE8YyaksiOy+sz+dPIgbz2pgiVFDHlKax3ow6perDCufFHfmW8b4vJc+
         81Lgwz4RGwV/C5+UsUDMJRAsEj1k/FdBFiL1HpUAWQnCSntqNX+L8s0MviUX1ZLfBTmb
         zO8HD1J4iQSnT12Uc9OvoZ7VZq8/DkBMzIgr+IqbUR+T6swRCGybzhPUoqSoDcGaym3l
         rEAqkj1YL4C4cFVzh1abOH6LXn7xq3Ql7P2pisU1h3t33RL1M/EAUhhGcxTC+zki18Su
         42Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577716; x=1795182516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRt/+n3qpNWP5atygjxku8RJqbtyvsNAOovAuzylIO8=;
        b=j0LNiZ0WyGVWA3Jo7VnhlYc+mTolry916P88yziIbaJCo8S0DxQ/SqrJKjf3v/GlHA
         FJSlUM2Zmr9qbgpvKho/LQxTq0Ami9b2bnrIq4AfDFENBaTQmQxbrCOcKsRggQ0q9dbj
         FvOPAGZrtaRehzLxK1YT0etyAE+qT+dTayHqOBRlK28NUPFOeHtp5NinSn1uTqfKnFJv
         R4mO1PeDj72D/yKhuWiHnRuVTBVwKSc1KK46EiAF1YOcAq1Hqe2ZQ2S+8KDSMbs328kp
         SuT7gHsjJX4AKzkeWPeOVSaxueVHyjc0KECzQLQ6etL9LgTvnBrVVMAU9i27S7ZPRJZJ
         JQWw==
X-Forwarded-Encrypted: i=1; AL+hErFmuhBdeidtJOCGXm91rKu1cL1OSrKb+l0L/+NVBlrjpU2ntDC5qzjTaqtD7KdCatI8RhqqaRE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tqCFoY5bM80IWcxSSVAXOdi20Jr2SPmPmKqBm18BVOh5s+Izn
	dkmz9eW8foltNXXeShPoqvk5l4Cg29tZl46a3s2YACl7OvRYDYuVVHLKcvSg/BsOuur2ibiVH5r
	bEKM1cg==
X-Received: from pjzb15.prod.google.com ([2002:a17:90a:e38f:b0:3a6:d839:55d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:49:b0:3ac:bfa7:b079
 with SMTP id 98e67ed59e1d1-3b1b081bbd8mr2314779a91.7.1794577716202; Fri, 13
 Nov 2026 05:48:36 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:26 -0800
In-Reply-To: <20261013195358.163375-1-yosry@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013195358.163375-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441826991.81142.10798231327707439438.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: SVM: Update tracked pCPU on pCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 13 Oct 2026 19:53:58 +0000, Yosry Ahmed wrote:
> When a pCPU switch is detected in pre_svm_run(), update the tracked pCPU
> and mark all fields dirty in both VMCBs (if nested is initialized), in
> addition to resetting the ASID generation in both VMCBs.
> 
> Commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
> VMCBs on pCPU switch") reset the ASID generation in both VMCBs on a pCPU
> switch, but only updated the tracked pCPU for the active VMCB to avoid
> unnecessarily dirtying the inactive VMCB. Leaving the inactive VMCB's
> tracked pCPU set to an old pCPU still allows an ASID allocated on one
> pCPU to be used on another:
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: SVM: Update tracked pCPU on pCPU switch
      https://github.com/kvm-x86/linux/commit/d41766c45065

--
https://github.com/kvm-x86/linux/tree/next
