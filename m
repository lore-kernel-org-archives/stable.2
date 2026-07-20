Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167A3D0918
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581781; cv=none; b=kdsx/40lyo8Pp/iMblYP3rAyQ5NBgbkRkO3sC8Zg6wMzm6tGuBExzNJ8kdrvKAFLv93NzRx2R9y2Br1TUXBHb1m70geJqfTjcZyH0YkEMSEWj/XFxIhBo/uTQah/f//vz2ZoQEzAhVDaH69B/HZtLLc3lZ+Jaz4GfPIkVXveb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581781; c=relaxed/simple;
	bh=3OxuOSFszZXF3S46f0Km2fvZlERm0oXs2P3kGZ3F93w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VD6NO6YLiDdAjRQr9iV2b7gVjKzp46DhZpKYWdzLFL3QxDXfSiO7J9rXAioOY2PhwFZD7tAuz+jeUmy2p3VOlN6BZDARoY/LhFiY5KXDiX534IGhpnRl/4q+YaVYKjzzOcBLQEz6iSFDUYCH5oiWzfgdVcex3qgaQglfduGueCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3hRR1NZ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3hRR1NZ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so76417365ad.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784581780; x=1785186580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZeIrkD4lxJKMX4vsnXjnYHOcVH8rL3Pij8PiT+ggis=;
        b=s3hRR1NZ1KySeqULjwc/4OcLLuz+Nw4JaU4eeI0F+WtaULYXbWmPJw/LM6esc/DtVg
         YPAjemLvTJKliYjiqPbkdqz1jZ8jsbMFruL3s5IvVqiIGE/ZH3QT2UCTf02aLDLJie3/
         j9jTnHuE9t6Uyi7KlSBeLKSzrWSycxcGdGO+7zbbkUlbRlmFwM0u+3W5DqoVwtciswDz
         xlW0UwL9qg5YiHS2CatkWWyR4IbDmKlf33K8KBpd8B4tl3Ergn2aOAK65cft3cUfWg8p
         fdcpTk4kYCw7p2PfB6/BgJuXorkiRKGckQH0ydEOJ0eEgbHt201ASB2hJf5ZlP6DE6ju
         XnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581780; x=1785186580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZeIrkD4lxJKMX4vsnXjnYHOcVH8rL3Pij8PiT+ggis=;
        b=bGHtIgm0uP4gdxr53yNFgdydYNzgxPir1uaqo8ghNXMxWpVF8hctTS0K1N6aw3NCPj
         6ja2xqk5z1GoYhGyrAYNW6jd0GFUkTD21JMYX6ZnGSfnSee+0xYHUJA7zzrAisvpmnh8
         VDox+VDvXZ9MSE8kS5/MvMCb3WkVl9wAKGfMBFmcSaDHoLJB0NuXXmQc9pBnePucfwit
         CSfTCsrWoauNyN+c/SQD5+uKksGH4/dbM1IDl0BDuYgXgDzj4MjO4oJ5Qmqmq1RmgCdK
         hmMagw3FP34/QMefwcGP+/2vc4PMiOZ99Wsa8xz+zh3x2JJXThySBDelZiPQPBzWIVxl
         Y/iw==
X-Gm-Message-State: AOJu0Ywe7cXJxD2VmmQxyPmQ//mhQ3keFm9wed+sggeIhjnyu3mYfiiH
	Mzdn589kOtYlYsfYEIBnxlcXVwXZAOmomxL8lIPDuoFMQYMDEdY5A4QSJIw2gWoEeIf7xxdAK0L
	d8FmuFQ==
X-Received: from plhn9.prod.google.com ([2002:a17:903:1109:b0:2cf:70b6:d7e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1249:b0:2c9:d277:2cdb
 with SMTP id d9443c01a7336-2cf3489529cmr155830705ad.9.1784581779375; Mon, 20
 Jul 2026 14:09:39 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:09:38 -0700
In-Reply-To: <20260720030329.744758-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026071641-falsify-antiquely-4d9a@gregkh> <20260720030329.744758-1-binbin.wu@linux.intel.com>
Message-ID: <al6OklSfwvW_cdfY@google.com>
Subject: Re: [PATCH 6.18.y] KVM: TDX: Account all non-transient page
 allocations for per-TD structures
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: stable@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Binbin Wu wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit a8b2924676ec42d76597f849baba31acc3ba1bfc ]
> 
> Account all non-transient allocations associated with a single TD (or its
> vCPUs), as KVM's ABI is that allocations that are active for the lifetime
> of a VM are accounted.  Leave temporary allocations, i.e. allocations that
> are freed within a single function/ioctl, unaccounted, to again align with
> KVM's existing behavior, e.g. see commit dd103407ca31 ("KVM: X86: Remove
> unnecessary GFP_KERNEL_ACCOUNT for temporary variables").
> 
> Fixes: 8d032b683c29 ("KVM: TDX: create/destroy VM structure")
> Fixes: a50f673f25e0 ("KVM: TDX: Do TDX specific vcpu initialization")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Link: https://patch.msgid.link/20260129011517.3545883-4-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ Binbin: Resolved conflicts in __tdx_td_init() due to lacking commits
>   eac90a5ba0aa and 69050f8d6d07, retain nr_configured_hkid increment and
>   kcalloc() call. ]
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
