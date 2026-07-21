Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DD3E3DB4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653577; cv=none; b=kv0U2MFMDgbmsBgnuXgBgJh51QYaVvlthPJ6ZvHR+8O8JDoSPno5SmFlyPOT6pLP53WaCbzGwKsdJingIHYrm8+DSB2F/4irt4Yyh0P9z0QVA1a8zzPKCU4r1wErO4aCkYvc0SxHCxes//ZIKDiYRMzbt6D3LW9wPBIfni/CSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653577; c=relaxed/simple;
	bh=Z1kfHjZshRyq0OhKtA+4Xwyb45jgsWJ5RkfvK1EhOX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDa/glcbw80EvDMxiuo6yDLKsfPBnxpp5438OndYJ1qjL6pYlkxRwxulBS/lSTTVf1g25btkYo9O1u4X7C1KDfKZ75WPHt77t/py70ja9nkh0QY1P/tS2frrmFG3UdajN01ISRPBLA3r1kwQ583z9UL2FDq6N+1eCpiQu27Zokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+1nXKVu; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+1nXKVu"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso2686711a12.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784653575; x=1785258375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpgRh3CeErOqYeAN760I7EgBZOZeFXDcwxkCd+u/yDU=;
        b=S+1nXKVu4AynIbk7uv38BmmPZoxDdLC9ConuFm6ia5Je0h0B+y8EwMSWznWpltNXWX
         XG/Un9jV63TAlZMfXuoDtcEYG06IbQtJUlVJyicwF0iR8jmYR5Ruj6a7JxL2VI5Q29By
         lCH3BiC4cz6nRrrsuCfMaNNN01Nw2jTZt6KX3eWnqnnMD8F3XqBfy2S05drH0tfak+FL
         1yqQcw4CBvfbAorwsOS3xj2OAKZQ+lawNRbR+PJw+cIHp71hAHAZaIENTgBNYHAP1MYw
         DK3e98z0dD53eQXA0XOLLy1aZ8ifet5Cs3J6KSbIwyBiQT6mW3rnoxSppIPKE15CM2wg
         ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653575; x=1785258375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpgRh3CeErOqYeAN760I7EgBZOZeFXDcwxkCd+u/yDU=;
        b=tT3OrLX1X3+t3KSsIin9CkktxwO2OpY+7tX0Ac6ihyAVV88ZGmFwT+ra5UAkgGHdx3
         P5tdguCmHTrJ8nSiAizG7/X3ImuqNGTuWBq6IzX+q8lkjDREYw8kh/qq0Dgg2kQb4Kof
         Iid0xaQ5g89oDD5XDHStJxmUullvg92EG+Bhukyfdh3W3TBQseodeDDawgTQ4TaByN04
         B1RR10qQ3g0Vo9CwYWr6yx17Yc7Ap4R5w9EqpBqKvU3ecp2TLDHs/GkwIEIrSnHlSpp6
         G/f0smeqyz7qy3/w2VSNbqwvpFGONyT26PoIfIxZcr/1V6R+sfazYDUKtfqRDMNFxRby
         9Ylw==
X-Forwarded-Encrypted: i=1; AHgh+RoObol4vg86iI8pJMg6MGQUQPrW5Fyi6JRbF4JMGWUbAxGH6pgyqR+jQTVs+m01sKsZnlCsP8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmXXjAixwAS97MmleCyORAinL1+K2iI6JBkG5g+Q7T2JThs7p
	XWrncVXd76pawp9ZZ4n+0pZ5F7TofdQa8xz4uT+5zUZGfbIZGltk/N2PqhNRuD3xSIUDBqZkX1I
	QpFQBjA==
X-Received: from pgmk20.prod.google.com ([2002:a63:5a54:0:b0:c8b:19f4:6228])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db09:b0:3bf:b885:2fae
 with SMTP id adf61e73a8af0-3c3ada8bc69mr21255876637.56.1784653574972; Tue, 21
 Jul 2026 10:06:14 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:06:14 -0700
In-Reply-To: <20260721164746.376551-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721164746.376551-1-pbonzini@redhat.com>
Message-ID: <al-nBuxK5cOcJUsz@google.com>
Subject: Re: [PATCH] KVM: VMX: add memory clobber to asm for VMX instructions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Paolo Bonzini wrote:
> VMCLEAR/VMREAD/VMWRITE/VMPTRLD access the internal VMCS cache, which
> is not visible to the compiler; without a memory clobber, the compiler
> can reorder them in troublesome ways because "asm volatile" and "asm goto"
> only protect against removal of the asm.  For example, placing a VMWRITE
> before the corresponding VMCS pointer is loaded can lead to corruption.
> While none of this has been observed, it is better to prevent than cure.
> 
> Likewise, INVEPT and INVVPID access the TLB and, even though in their
> case the effect is only visible to the next VMLAUNCH/VMRESUME, it is
> technically correct to add the clobber there too.  So avoid any urge to
> special case them, and simply hardcode "memory" into the clobber list
> of vmx_asm1() and vmx_asm2().  __vmcs_readl() open-codes its own asm,
> so add the clobber there as well.
> 
> Link: https://lore.kernel.org/kvm/CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com/
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
