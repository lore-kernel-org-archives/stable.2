Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAC49F130
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418518; cv=none; b=efeYMd5s6W+YWzZDeS0p6mVAPuHxzTgoLrRYuMXZMj2W+NGL58AUaEijWGbzA//jmDRvCNc3yVKJF4ZQcqaq5Xtw/JsqZ2kyu9AYC92L/0cfdVHAgpwYp0+ym7oroDQSZ2JiZAVe6xUqTb2oB4OpWZcBbSgM77zTHbiqku8k6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418518; c=relaxed/simple;
	bh=NGWB4j6Qtj1I45qJXTxUF3DXiZ03+1wrOcaEWMEdRtc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mxcp4ngSRMO34HH+US4HoL86EI93qsXQaey9iQNE+sxwhC/afzsUa23PDyJgJYWRyX8TJZd6Yo7f9fufUEsIiyQjTMMGlrhriwEa9oRLik6lUomAuGm63xAHkjuMrfHf5f6RDNVDEG3S7oLoInvr/vpgBsjg7muQcfh2uJY2QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BKJZYJqx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BKJZYJqx"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5303932c4f3so19978581cf.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418512; x=1790023312; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=BKJZYJqxLJgFemMBcjr5I/aDXNKPtJB3WRJtLpLBN90kCCOc2ISZa//Hx+A9+uy7hz
         KotROizMJXWX9tEzVf5O2jdHFH3zcLlGP6MzE7D9BcffRwl5dnFhOwNpSiEVpj1HEnJ7
         EvvPhvn7MfJE76qXhcCt4bZKswpUqfwd0aWhG8mfZX2zxmbfWiqBIzrihkzUvkRM4+pU
         0txeqCV4C+FMMdpJa03B+HismbOogUi7Ezhk+FqcN08IynGTUWXRYeAFxW76NBiVlJ0L
         L414LmF6/TYULPjGTgneeLNYrcAk3bxDHO3JN/fQrYxHr7NjczBjhvGl0Vfc2MBYNYf7
         gRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418512; x=1790023312;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=dgVR2RvtH8y8sh+1joej3wjFZEnIJqSa+Iq9AwDI/Qy6m4XS+mjWKio6Jj59N/nvNT
         PTBeKsfHY2sLpyPa2T2Rix+pBU9rMIQTBhwh7jbIUUU2PusCXC7pUzLZldOyE31c1BZv
         Zxq0/01ntmaaVpZuDSLb1wr4XhjTaWFMHlDBfVUg+gAfvdF8z+vtVmQkVPnBku+kOCwL
         0a/BIyppaX90HVY2mHyQwcQ7oqPvSoQqvymXMBbcFliWqpIMIsZlWyAEU2AOk2Uj/xlu
         Ru+y6Kock+vTFd+oP99YvBwFSqpSp7MCprr81A/42ER169HzDLByWcmtBcrX45HXPVIG
         d4kA==
X-Forwarded-Encrypted: i=1; AKwUvBxZ+xguffXCLWDx23dcCZByAcJN/MwkA4JO4L5TJa1s1S17JOx1Q0R3o+CXiMgKOgWTa9moi7k=@vger.kernel.org
X-Gm-Message-State: AFuF++kST63s5QbTNVUT9bpxlJrwEh0/QzRupHQMLJYxKgtGRs/Vv29T
	TGyTXw+ML5cDIhwz+YTaUffOQIQn/Jq3oZ7OZWWr/aqQg8FUm9z1jqINqt+/H0Zxwg==
X-Gm-Gg: AYBFou2lALtkI4l2/9pCmgxdy6SKgwBZe3TVPi/9FrRivERjitNUj9BoRaxvqWi/Zi7
	g7rHd8SFazrvseG9WaMiIp0JrKs66v6VKOpdUOZ1kQxmpZBFvipmj4kznpRTbb3Pi9e9KFXBcgu
	MHWN8SnzPueUOe4a3wU8FchpGYrA65C1Xy8ERvq96hgJ8CY0BT8mGkbHHCUJH/ZoxCEVMnWr6Lf
	jD/TwLoBSLulb3rjo1om/2r32Zpp/0bv564PskFO/vU+d0Kv9YmrBa5V1JeNq3DX2Hot05ZGyDX
	Wy4Z9cyyCAxVi/GyG7CPhx6qSRcDLZd/NFPIrO9sWRY3wAmsaz2qj7UxJXLAJ6cJoee6UVeyCuC
	/3uHfgrnNMiW+SUGhS45gTYckKC8ws0Yaesr8PVUmTNR7xEz1UAOBqMY/FRvowXza8vemkCK2qv
	sZ7kStr+ZTRrDsuURnyLWTtPqLxHmCn8FLZZ9Qy4Wa4FT2raqNenW7/bb823k6wfYKSNGKQtjcK
	jiGhEHKMQGUBR0agCRMUVVKlnjG8pPKk2RetB9BKPqPmCJpu+XKKrW/s3klDxcnowM4xZyHPfTo
X-Received: by 2002:a05:622a:15d6:b0:530:b2e1:8e38 with SMTP id d75a77b69052e-5310d063e03mr64295201cf.51.1789418511760;
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca3098easm108403901cf.3.2026.09.14.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:50 -0400
Message-ID: <af4448a7a2b428d0f4af0ea4c19abeff@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260914_1619/pstg-lib:20260914_1251/pstg-pwork:20260914_1619
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] lsm: Preserve full ioctl commands in audit records
References: <20260910144837.381855-2-mic@digikod.net>
In-Reply-To: <20260910144837.381855-2-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Ioctl commands are unsigned int values, with their encoded direction and
> size in the upper 16 bits.  However, struct lsm_ioctlop_audit keeps only
> a u16, and the common audit formatter uses %hx.  This logs 0xc00ffeee as
> 0xfeee and makes distinct commands with matching low 16 bits
> indistinguishable.
> 
> Change cmd to unsigned int and use %x.  Pass the full command through
> ioctl_has_perm() as well.  Its driver and xperm values remain u8 values
> derived from the same low 16 bits, so SELinux enforcement does not
> change.  Commands that fit in 16 bits keep the same audit text.
> 
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 671a2781ff01 ("security: add ioctl specific auditing to lsm_audit")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h | 2 +-
>  security/lsm_audit.c      | 2 +-
>  security/selinux/hooks.c  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

This looks good, thanks Mickaël.

However, I am going to drop the stable tag and merge this via lsm/dev
instead of lsm/stable-7.3 simply because we're changing the audit field
(going from a 16-bit to 32-bit hex string) and I don't want that to catch
anyone by surprise in a stable kernel release.  I will leave the 'Fixes:'
tag for reference in case there is a downstream that wants to pick this
up as a fix.

--
paul-moore.com
