Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A88175A66
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782085541; cv=none; b=lsp4JHGI8CUcL2d9r+VgQApCYBNyw5KgsFQw4jhUFLf4ZD84vaErdR/cYYJ8Qq8BQ5Yt2wgjCdFIqcxcD6Vx1OQwLsWcBjZysP4aODZM3hVejY2E30XUtx9B6GpQz6obUoz6FIBp+8UsFlDat25c4n0ouWLTk/h6m9bpc1kC5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782085541; c=relaxed/simple;
	bh=ZZfaNqTNNx9mhw99oZCuVOFnAcpnJCCrILs9MOE6uoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siZQkZAXbdFkZ7j5LgKATCZY9FtG/3jjfVsxgIG6KLhxieI4RCEC0VX9uAuQQ0hE2xu1ielsEhdC1IynE/Q6mzP/ThLIrCjls/+4f5KdoGHJ5wteSHLT9owHHqZhTZHV/alKnAhoy5Vabwn3LYDSxOaGh67P4i68rJONeC6vp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekjecCfn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekjecCfn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49241a577d8so16371935e9.3
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 16:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782085539; x=1782690339; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZfaNqTNNx9mhw99oZCuVOFnAcpnJCCrILs9MOE6uoM=;
        b=ekjecCfnj+sl84SLjBsxA8bC4z9HY1vDU2G1UyXehvvTOUZ71lTgmXAwzkTkKMUlBT
         B2UxjUB/EBLZII65Xz2jDb7FvY0/QuQhYr8cQae/RaZWWnRFIi47t+UYbrqs9QBou3fe
         DEDb/hDtNv3HHSJg9uEgzyZ4Xl6+AzUeQYcY2fxfju8Ap8I/9OnYPgkgV8QmzBBEll8L
         aYRR1UGifvRyaBXsT/aQSFv1C7T50RrzyZqjhQJ3exdWtaIoy1PnDxY0zEZElpNBcKHG
         NGlgLhDho4QrYWri0Rh4KlbjuReHc6SMUiJMrB7SYRgiEKutCvVr6Nq8dAYo55ssEInd
         F1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782085539; x=1782690339;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZfaNqTNNx9mhw99oZCuVOFnAcpnJCCrILs9MOE6uoM=;
        b=j29u4vJ3WNnDWxN+NPjEPjUGaANi5sPytAsmRkxU0xT5IyZ8xPxkdd3fvAHzy9j4gb
         DUuqJusSJTREeZtmXGJ/LJHIM8bj0f8BhSgRdxh77FUwSkFFgtQMBTqQDzUeALfWL7BW
         CkXtD5VyyIK3A+7Nyw7CFRL79kzx0FkiaD4ypacFmHkRjbIP5PUm+yK8gFlrCYk3d0gN
         KgdNkXEW8d+X5zHBnOccSRwnegm3bHxA/1THTuZizLIbZEIEb8+hMxGPhNhxQT3zIJOL
         U5u7vw05JNrQOisBc/EDVzWSL2EJ/OlzPjHxnjP3hzxB2bPZK4IXbXlOOtotHCwclWGb
         tpZw==
X-Forwarded-Encrypted: i=1; AFNElJ8hULAKGTTDQk70LQCSxtOValnVQt22PJ3OfdMvB53Pslv3RXB3N/5MseqnQk7Q7ea4jwJ2wwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm9m1dX21yLFe7fEpsZUExnpZCU/XlsxPC2GSqAwc4OJqqCZw
	kT4iKvwYlaY9shWKU7U3L3hHL5uv2JJrjfgK/3z40j/FPza3r6sAi0T4S+9X
X-Gm-Gg: AfdE7ckB/Zvgl/xPaK3RgiXmVcMdxYJ9mpBy46fZoM29DHiXaKevd3/dhMe4bCmHo4M
	a/6X5deKc5egRqXXemmXMNVfNFMLQu77hm4+neSGP+5iTWexGyx+OreB1I0c1LXu8sDEYYrP0Md
	o4m2ajmPuC2T/sU4q+ZTzKVLgcCskZrp9vGzl0i6qpRssSEXNBAB7FGMz+757x6WlW2OrCHCfxy
	NNf3DJXznkQlkgWPtW1kdylkMgHRdZrfKJtywDH/EMqTedy0AvNyaBA/F18SggIxuY1N1DRqSU7
	yuncKUvfY9jUAewpWwVOBLNdettRridpEgn+YXNe5TsICvjEmRr1j5XrM6AmnL7aPugpxT/CSEj
	FpCmTqFkw3a5MDvDEq6wyut1CzggpAqB0FmarI0lDH6Gic7g1kBTUyaY=
X-Received: by 2002:a05:600c:3e06:b0:492:4fc6:75e with SMTP id 5b1f17b1804b1-4924fc613bamr87802335e9.0.1782085538626;
        Sun, 21 Jun 2026 16:45:38 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338e5sm183359795e9.3.2026.06.21.16.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:45:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <dave@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject:
 Re: [PATCH] profiling: prevent stale prof_cpu_mask access on init failure
Date: Sun, 21 Jun 2026 23:45:37 -0000
Message-ID: <178208553739.3350560.11630245626644331749@gmail.com>
In-Reply-To: <be257038-78f3-4a6c-8a57-237f5e2676bc@I-love.SAKURA.ne.jp>
References: <20260621192324.2062795-1-tristmd@gmail.com>
 <be257038-78f3-4a6c-8a57-237f5e2676bc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2026/06/22 07:49, Tetsuo Handa wrote:
> NAK. This is a use-after-free read bug.
>
> Correct fix is to remove a commit which adds "free_cpumask_var(prof_cpu_mas=
k);".

You're right, the flag check races with the free. v2 will just
remove the free_cpumask_var() call instead.

> Which tree are you talking about?

This is for stable (6.1.y, 6.6.y, 6.8.y) where prof_cpu_mask
still exists.

Thanks,
Tristan
