Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888982;
	b=4X6b6d2ATVPE786nbaBQnqXd5FUZIDHbKZWSGTm+M1tYNk5rd6UFNWwR722K2top0MET
	 egWk60/1EsqtLwetnNZ9HPIcfe9ZzOzvyhzZRw4DDn4CcsAS/jbJWtxv+dBfW8SIVMKnZ
	 XbwID5wqrAyHvML1Oln2ynNf3PQEyowMGbB+LUGBXZwp5YKDVrbJKz+YQrHxegwOSL3Qm
	 Xvp+ZEi6L/VQ1BUNjTFJRzuJUJ2hz6beagCJjt6eD+VgWypth2icx5i2Vaf+pot71mz4t
	 nPmhtrWtF5UPPA11MfaP0WesAfgFLZJfSEearNBP2dMU2JLwr3GVElEzP4Bg5gLXR4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Pqwo9iamWbv2wKXM8/6RAcS6fQgXjlRbD/dt3H8kjGI=;
	b=w28+fyfQYmaKRgLkHjIJJnxL4A+d5aJE9cZpSyBoGzw96EA9yedTXzt6HYMtFdjXKVDc
	 4wGeJwM4ZEuLEBjoBPwpVgaHYX+41rjwStVF9NnpgtD1agM36JAE41axla7lcj62BCxeG
	 kyY1eFskp/0tgFuJDKfCxsr8JZB0NYX3W2LD40hNG86bWAaav7Bw0BPNq49oNMpVV1hGt
	 mrUnzNacHprMt8flzaMTP5aSawk97gJC2701oWBkyRX/xQQPtccx9CTgD2RTQpofeJMP/
	 yCYOF/p+1HxH5/wqNC6nwqsgFzcylO/yJm/zUf0v2gh4t0vM6KzILdBfgJMWWjInY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WYafryWE;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70633606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70633606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WYafryWE
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf3f829b3so17531445ad.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793888982; x=1794493782; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pqwo9iamWbv2wKXM8/6RAcS6fQgXjlRbD/dt3H8kjGI=;
        b=WYafryWE6q7TMP1IYAgEd6jl/xpGzwNOJ2ruh0xUgQX+IKfw9BjOyowDwE/vzQsRof
         gyrRCDi1Swxir9ZoZwuTYqM1UxM/9EC/DDNUw4lsAeipeDqwqhgSmY+TQkNxFMdEeAzQ
         4ini0j9S9VpZp2Rjhs/Hrk/ZZQxwxQrUymXjRqeNzP1Nf9bw1/vLyEU2piLoYoS9etPU
         7Mz0+8wUf5orLvl5RanmsR7S3AxmArDgPoeqirt7/nhO1oO+j0oTAsVz7YHl2ePkvHiY
         IxbneyvTfK1srjLyRS66HbCwZbE2YG3XbtgeeLOA7B29aDbRyb0akcFGHJymsD4okYyH
         1TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793888982; x=1794493782;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pqwo9iamWbv2wKXM8/6RAcS6fQgXjlRbD/dt3H8kjGI=;
        b=FHdf31oTofz6zZjueNQdz9ElXwdWhfxD1Yl1dOxToMVGBQv907PpOOfb8o9LSOU75h
         d41RpnWLUEN7zyvEbSTYW31HgnsqmbHxJoiWcF/4r4ewEF08f3PDjAakjGnYTZgNzB3R
         kGViTHtQrhzt31IUN9Ei2oQXIaOSUa5tXz+E0issWWCb2YSvu28Ab/kciUj974s3d1gW
         nDGbR9Oj6bP8OnuEsc68Azkc2xeFRnmvYDs9VuUauc+zdHPIaC/w2uqUKptOo5zh69Bu
         yjUfIAStfTX7meghaSzr3i3s8b2qX4DyH8LlUwR4CvTFX4iF4giHvN6dBP3gXN+cUECp
         +fNw==
X-Gm-Message-State: APuU4Z/dp/hHtBYR4DQtwj8Zq4JFnVbJJff2CpinPDrlsGcF/uAAEVF+
	bQcOnk1AT0nazWjhN02PgeZRAsrVJTGN1nTpA8wLBUEupWPE5ATMG1BAc0M79tRKntEgVnJD7hR
	B/PujGA==
X-Received: from plof6.prod.google.com ([2002:a17:902:8606:b0:2e2:f305:e980])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84a:b0:2e9:7dda:bfc7
 with SMTP id d9443c01a7336-2eb3648eea3mr161939385ad.66.1793888981541; Thu, 05
 Nov 2026 06:29:41 -0800 (PST)
Date: Thu, 5 Nov 2026 06:29:40 -0800
In-Reply-To: <20261105120812.2037884-1-xiaoyao.li@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026110439-makeshift-acting-834f@gregkh> <20261105120812.2037884-1-xiaoyao.li@intel.com>
Message-ID: <auyS1P0cK7UC8e4l@google.com>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Formally define KVM's "0xdead" exit
 reason used for failed VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Xiaoyao Li wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7 ]
> 
> Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
> to stuff the exit reason on a failed VM-Enter so that the magic can be
> reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
> defined value (though the whole "dead" thing makes it pretty darn obvious).
> 
> Opportunistically add a compile-time assert to ensure the KVM-defined exit
> reason never collides with a "real" exit reason.
> 
> No functional change intended.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20260921235656.1107929-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---

Superficial conflict due to lack of upstream commit 3c75e6a5da3c0 ("KVM: VMX: Move
architectural "vmcs" and "vmcs_hdr" structures to public vmx.h"), and there's no
intermediate vcpu_vmx.vt field due to lack of upstream commit 7172c753c26a5 ("KVM:
VMX: Move common fields of struct vcpu_{vmx,tdx} to a struct").

Acked-by: Sean Christopherson <seanjc@google.com>
