Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142A44C648
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327728; cv=pass; b=mZl2hl6nTZ0co0OAdrXxIOw6Dl5pBPmgaMpGgLsP6Q7cCSmHwL53EhQw//ezsf7LpUnsZJvOY5ZUdUUvV05od9HgahXfK4iUNdLsgrP0ER2dX1Nv9OxCO7WgtoMkuA4wF2lY1L8X6oa/CqaskDu2nnxcclbOkhnGBIRfKT1x+Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327728; c=relaxed/simple;
	bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8kVA2UhI5fKFlojgFMHaEzcUWWl3/koXL9ywmpQgOK+jp5TZWqh5jJkL5PyNXGq3qx6UcK4F2q7pdXZWgfQ11muccu1jc5ReKkYKh72EoE7sV/mpA+TJtRXu37HudaKT/tpJNdB2dV+E+SIO72xZVSut5MJoxdPu6L+2m82uj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdcIL6HJ; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdcIL6HJ"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44aeefa1c00so870588fac.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785327726; cv=none;
        d=google.com; s=arc-20260327;
        b=IZQmXCBRh7CU0zW9FuV7xSR65HyFpu6THpoFaCi+dvBCCc/ftiDmv6jqCFxZy9iov/
         BvdGKPz3/DU/ei+SB25hVVGqOVcFHuyBELxRTwUmQk02AOJGM682rLAUXzZEiKrqNPc8
         G/ZANqKFMgQenfBdg6m3H/Xscv1jQ2pUYTLuDNob5HVd8gu0P/xSflvnuUl04us0TcAW
         oIw2njyOqbI+YLmQlK15u1et51x5rYTiJ/3LANfa3w+EEs63lbmt6zk9C4EFRuhncKQ0
         Sicop6HNaUFvdSuJ6joND9vKzKdLkZhXFRNchD62nR0uNt2k3BEsdCL/x0U4jZ4WoO7V
         f/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
        fh=Pgu2woJGTp+ctLfNfCGPaClzEfYN1U4Xa4xsbh0Id4w=;
        b=mskeXlW3UDNIkYz366fi3Qb5xc8kT0Qgai5/3FQxTUxVA5Kzrmo9Lmv2cWJRAAe4sl
         h3ORbf0sXR18VFRnZSJbvwh4rEjGfxB4klmZDBQr8ZHAS6/Pf6DK0LsaggSAvypAqvnt
         HmTzW31D6MXTGrmLLAj3gFaC/WRnzDZX+E0BktsFIrdbVMebBlXwc2IzOG0KZJA1hvXY
         IDE7VQbOO4mPScuCCD4rvfg6CG3bAxs00cjG8M7H2OpDvYObGlRQjeJbUa4pdkqvdlKD
         Mi7sAXnfOuTd5DS3Kprs8ME1PSnQ9g++Tqf8l0gUqggLVS06HXZ4iORDYq86+TWXmIQk
         Gh3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327726; x=1785932526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
        b=gdcIL6HJgyjCZyT0hO5KUpi+gn5BVkq6ht5wbR1sg7aAJ/+D8Z+/p6T2Lxct0jdl3v
         TB8N6rcUUw4AlOWqFhLq4ibhaI58a2xq24ASYtM4GInbZhw4om/ggra8bp4Ay6nEKeHE
         bFi6YSaBnbgXNUC5DpIfp+f+g9y4I52c/0AEl3aSRo4ZC0ThxkfNPnvkVxLARFG/CtIJ
         jm6sb99lImRyjXWnuO44KW5mhYtmrKIJqaHesgf7cGsxC0jqKQMGdvMeK0l14MZ50JY8
         Qx/94aHKtSUf1etr7l4rH5fngBDt877n6z3sPKjXmtXtlYWt9uKsozPs1IKdaBEQYSY+
         AWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327726; x=1785932526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
        b=K2emxxYOUPjDYpWvjMfzW9BMQQ2JYwOT4Tn2IQqWKUKiuatk9VOy302vZriJb8Ryri
         w/DpG5YNyfKCWYKUAq6AlgtCQdAZht8lpdMTWa4X7zaVg08TcmmEXQ7kK+8G77NCmEna
         oesr7xzB5U6L/z4ED91Z3tFjwkCAnaq1zV94gK6f0Rpc9VtkttzFoBdi9s7VJOq+s8tc
         xA2/T2CkKdSYBZ5RbUdM14DQ7RKNw7k8m8Sa7DlzYrYtY/mUe+zMIxQsWo2Mnow6t09O
         uAyOfb0PHr1TvHP0bga+jOEgB/EmQqiQhpE6Ee5vvFUiD/uydgrq4gsbWTkdQXMF4Dqj
         Q0xQ==
X-Forwarded-Encrypted: i=1; AHgh+RrO2MyWFxu4e3OEyzyCVzPzTV5CWhEtnMCOHkTJgzkb19K8NfR2t2yBV2icDPucZkms/Z12JmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGoEQvSXxHVmlgv9YpbzCjE065JPNcjxTey98tGItbyX+5ZLY
	Gl9CFjB8LAfjoHSL8TwwtFqUvYdm8cSKWpMUNtnideCXktNEu3Z1DFbNhjv2QMwN1EAWjNHOLE+
	WfYcsm/iwICgkknzqTC8Bh1GFez0WZdI=
X-Gm-Gg: AR+sD13aASdowKF/UxxZXnmgAga62LOMnUIhHHmXIigLf1W1oUmEN/LnETNZXiauUnQ
	gwKvlU8Qo0IayTQlCW4k1s5XCszggGo5fdaQNsQdgBHk3mU7aZNF8XTqQJ1/8fkOd4xls/vhJiS
	KpG6RPzlEE26IXjC/wUfU3Q2Ts5xWecAbzqT3py3mY9QTPkv7R02SqQ66H9Yd7I4yWm0fOl3v6s
	thbJqlAmgNm3EAYgCZnAgj0cUB5VLh0Jp3ORQtjEhFnmBl3qCVMigrsxEsAijDh3FUbNd+DrTl7
	bD3CSpLLrQLKx3bqr/pSbNXbSldHp/Ndio6e0bMVw3m3
X-Received: by 2002:a05:6870:e247:b0:451:cba2:10ad with SMTP id
 586e51a60fabf-458962765e3mr1107636fac.20.1785327725741; Wed, 29 Jul 2026
 05:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729032912.55800-1-syjcnss@gmail.com>
In-Reply-To: <20260729032912.55800-1-syjcnss@gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 29 Jul 2026 05:21:54 -0700
X-Gm-Features: AUfX_mwxHxLlLzvfY8UKucbgkMwP9mUlP0NW7afNP4hgJLh-et-iSEW_6sFpXFQ
Message-ID: <CAHsH6Gscf6R2-+Uyo+Hu6DqTC67DRO_4sf1crVXgM7u8g5hT+A@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: do not take x->lock under xfrm_state_lock in
 the NAT keepalive walk
To: Yuejie Shi <syjcnss@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 28, 2026 at 8:29=E2=80=AFPM Yuejie Shi <syjcnss@gmail.com> wrot=
e:
>
> nat_keepalive_work() walks the SA list with xfrm_state_walk(), which
> holds net->xfrm.xfrm_state_lock across the callback, and
> nat_keepalive_work_single() then takes x->lock underneath it.

Thanks for the fix, but I believe it has already been addressed in a
different way at:

https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git/commit/?=
id=3D763fe700b7c58ad64fe5202c5638848244dd4127

Eyal.
