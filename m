Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503473;
	b=iaxH+hfnFpMQP0j5S4kDD4ViVHDuKfWy4zsc3uXAguMTZIqA7SpGruMIBEGJg01weWnu
	 HsLRECfUWMpcCLUZoAsqs1CWeXnCApgL77tFlacePrBNeXjX/kcdbnXJQwJIUX32QdmIT
	 70eIrgtofym8vCigi9o2ya5RsdokqrZQsQrW4v7RE7kzieS8+KbTDH7UYYcuO4Lsj3PSZ
	 8v/zypkMjmi9Ic7Jd9ed1ABTvRcO9vVWqDBPy7K8kMgo3N7HowMgpIt3ku2xF4HyFl+Mz
	 hHsQrZ623jL9yeT5CSbVuwkcUbqpbCPWtqqhBZrSuDaao8YHJFRzD9PYWDC9b3Tk5cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9LK7DTiATkiZuneWGmRFMWmw25q7gIVXvh7CUGQF4zY=;
	b=GmtgY9ZqtfW6vL7bKo8NECzR4VXHs+f+VJcE6yINRInmmjDxXy8VX/0WXJxha7V+hm6Q
	 8kqXkX+IKJvuD+H2/YAR+KpwAg5boSSkFEPJw8Cvdn0veLdWYnknIZBH/EPsr7f/qIUSc
	 ca75/tFf+a5sJK87kd+O7JCYPx6fol+jkdSu9iPhOqt1bdnTwHMDobD3NpAPjApUk50is
	 ywebxm1Y3PhsKTGvt8ZdCGdzNHAsd4KwtrkTUF8kiBGM86n9wsU6sX+nyve9jbNCf+F7B
	 LqefSJpPIR6IZxmVRnihpVgv1zBiDHi6t5fOcwrA//Er9aGOZP2JVa4RjuiYH3pR8Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OzjGAZPp;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1442606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1442606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OzjGAZPp
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0a7cbf164so4876794a91.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794503472; x=1795108272; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LK7DTiATkiZuneWGmRFMWmw25q7gIVXvh7CUGQF4zY=;
        b=OzjGAZPpYaUfKD/aCF4/njyVl4C+MO/7S3hQnf+RjjAp8X3f4IAynGqgK2uGSWuADh
         n3WpTnH3x3aXGN8aupK4NAUB3+PB+LcLX/BziHJeGhP2gr2aK/RTqiK3Bgm7Yo7EYSQL
         HbQaWItgaXcwIlfbLKtzaktI8uQMTbFqlf3VGHzZPQXguV2V7qIGINPjn92WrS1MEGkD
         AkanQbZPxMVaSG06Z6MiKPxwa//5GUkaQQ+uBlRkghN6YwPAH/HuRm/GZYmoEwbtERRC
         G7a0utZrRSM1gfaLOai+Du33nnGm1IlZgUwQ/GWEBnqvTVlau7b/da8lDPQ66on6yVP9
         rEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503472; x=1795108272;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LK7DTiATkiZuneWGmRFMWmw25q7gIVXvh7CUGQF4zY=;
        b=x6rO7CEYmTAe6e07NB2NI5ZoU9nPQwdkqbeHwyGaiqgPkelzTsMEtGQ74p+9TFQuG1
         u2E6km+j8IJBUsy5HjCNxqvMh8O3znV3H91Ap7ZWWWNbvDjrlH6+cH4zgoI/0AhbuzlQ
         RvYiU313rMY3nSa3k/2sTDN/+RUVdgXm2wz2cZ7C8eG0Dn/Fum1SXkTWqlvvuLG6gNAi
         NiLiB08htKAymJMks72UkzZXWeCW7gFIbbnBWZ0+cSV6hK8SmzhoPjZJ4CMk03ILDeOs
         hRbUkVFsdHx9kWhzg+Amt1/6XCI2wHpehRe/dEqaKAzKmYLS5pngQVTvUfhz128h8+Nm
         6/jg==
X-Gm-Message-State: APuU4Z8ashSEhQ9uTZXIVW9ax0BIoe+bMjqJl42ZdYK42BCFy91F4PkZ
	JMnunRLT9W9k26DnXB0Uu0/KDE6MUjIzWqjE/MdaOeGGUotoBRrMzUDsnkv0yaiYbIE7G9Juc//
	YZwRz9A==
X-Received: from pjbbp7.prod.google.com ([2002:a17:90b:c07:b0:3b1:2eb3:19c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f4e:b0:3ab:36c4:b500
 with SMTP id 98e67ed59e1d1-3b182df3d4amr6490056a91.5.1794503471648; Thu, 12
 Nov 2026 09:11:11 -0800 (PST)
Date: Thu, 12 Nov 2026 09:11:09 -0800
In-Reply-To: <20261111170439.3395604-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109200129-failed-7.3-053621535f01@kernel.org> <20261111170439.3395604-1-sashal@kernel.org>
Message-ID: <avXzLcD_56mvDYYz@google.com>
Subject: Re: [PATCH 7.3.y 1/2] KVM: SVM: Add a vCPU-aware helper to get
 supported DEBUGCTL bits
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Sasha Levin wrote:
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> [ Upstream commit cd0e6f4d7cec11be97fe6476309719b23ab5accb ]
> 
> Replace DEBUGCTL_RESERVED_BITS with a vCPU-aware helper that provides the
> set of supported bits so that KVM can handle bits that are conditionally
> supported based on the vCPU model, e.g. for features like Bus Lock Detect.
> 
> No functional change intended.
> 
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> [sean: invert from reserved => supported, massage changelog]
> Link: https://patch.msgid.link/20260930193634.3415089-12-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 053621535f01 ("KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

The superficial conflict could also be resolved manually, but I don't see any
harm in grabbing this refactor.

Acked-by: Sean Christopherson <seanjc@google.com>
