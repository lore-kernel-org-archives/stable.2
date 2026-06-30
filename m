Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C5373C1A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830531; cv=none; b=DGUOjPFQTnGcv+A0JBA/pZLwQP2WV8MqDDAiRommI/XHh7lKWR6kQWmxPqnO/AJybq47Shr6KeUrg7iJRJY7y0MelTf+BptFu1GHQ7/bmfNw0PJTLgP0tA7mDwOKjFJU6EgiAOTomYlfHZ2MeHbNFK+W9+1UJt257hz4D5Q1iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830531; c=relaxed/simple;
	bh=SyjZ1T1RbiC6JJyy8kEwQ5/d5KqSdyyr9Qqt1q/YU98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ukU0lTcOREHVivmT3her6Ncm6XxqtZRYzX6yCB8bqR5enOo8MweFSTUHcOfufPAWptXndjkX+tIABwfnLiVhHpFTvWStR8m/mx3fvopGDH+8iYbdQc7qVpgMxehMY6HR9+8oectllgnL/2EV7+SKi0EkUb8sCjy2tVaowKs+uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUXyoQlJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUXyoQlJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so1233181b3a.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782830529; x=1783435329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfpSe5BsLTu2OWH8Mq45o7qiUXplAdDFCSzrnq7l2KQ=;
        b=VUXyoQlJkLlnSJj143iLlx6VcyF1qmaO61R4nh+MLtO0RC/678FTZ4dIpIfh06WZw7
         bErm3y1el2ZqNnJX73kKb2eh2C5RI2DpjtmkSBykKpspOV/LABiSwBccIvurj8XkEpwq
         dbbvn47OsDTSsuibwmKhqjXOpaCrvm9iR4jH26d3Sqq2x+tbMlnljshkE1I3DZSM+uHx
         7KtoPFoOwsahrrQvFTpov1PmkUDzU86NMkfxHWnXVjOH3QBWI9/KY3CsNXWHryA8PTgt
         0asEcnAw7PFYT/mMG6i14WROQlxB5wa+69ko1SYHF0KOS7Q8MLX4gGoeI67tS4eqlSyp
         lrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830529; x=1783435329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfpSe5BsLTu2OWH8Mq45o7qiUXplAdDFCSzrnq7l2KQ=;
        b=hEGLBb2l0RXqmdDzhv1OKXAN1qE5D2KKv0udmgT1BI9IZkryL02axuunHExNlHcgeo
         zT6QGAGm+sY1yiXGwC5DJ4C8Bi7yH6mjEEY6Xs4UCQOTTkpe+tljM/vLwy1IcDfthXmV
         0+NcO5PogC38LElQx0nQ4jMHE69dVTSQnKNTDPcM8Gqq6GpI9w4x6U5YQKdhVSW7QEdq
         GgsfkRTDIxkzHk93Oieg/7Tw70FgYlJn1ySsAAXdzKGXOdR9JXTaCMTaik68O8PxTfOu
         AHYg4ypEHjv8Bb49/gJbK/Ge9iGQZzowhSmtmMC/DkKiOanuEazS8DrSdV7CZ0QDzTK+
         j0PQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeRhuykgrKW/WhAqpQQTkp7dD8M1eXAKRmbsz47M9N+JKx5rUmszLX9o8pjxu+OBuk3bPhpbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEG0VQKHrHRHMXrM/X1IUgY4OZqQhnX+alIAY4AwdFVVcxzpJ
	X4jlG8MQ14sfDQi+IXhGkvh+WjoMBUlTD7pWZ0pk1Af+boCnz+ROGOuqwtbLHud2KHNCQlGuM4i
	wX9iOtA==
X-Received: from pfbcj7.prod.google.com ([2002:a05:6a00:2987:b0:847:8f34:1b76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a0f:b0:847:9aa8:d3bb
 with SMTP id d2e1a72fcca58-847add72a06mr877659b3a.12.1782830528799; Tue, 30
 Jun 2026 07:42:08 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:42:08 -0700
In-Reply-To: <20260626193343.256956-2-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626193343.256956-1-jinpu.wang@ionos.com> <20260626193343.256956-2-jinpu.wang@ionos.com>
Message-ID: <akPVwJgnBuCcc4Hm@google.com>
Subject: Re: [stable-6.12 v2 1/3] KVM: SEV: Ignore MMIO requests of length '0'
From: Sean Christopherson <seanjc@google.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 26, 2026, Jack Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 upstream.
> 
> Explicitly ignore MMIO requests of length '0', so that setting up the
> software scratch area (and other code) doesn't have to worry about
> underflowing the length, and to allow for special casing '0' in the
> future.
> 
> Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
> Cc: stable@vger.kernel.org
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-3-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

When sending backports, please document what was changed.  Doing so saves
maintainer time and is very helpful in case there's a problem with the backport.

[Jack: Duplicate the fix to the split READ/WRITE paths]

> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Acked-by: Sean Christopherson <seanjc@google.com>
