Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640C2FC037
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665840; cv=pass; b=TnldlIyz8T2I1yKud1yRBaXRFZDYhsrl0SxxQdn5Oy3i+uvgwuxnEMbra0d4vs9+mIJmz/LLBupwdQvERsKvOqrambIlcvMeUi41F/XggiXdFP+KCw+VqOqOMyph9QnJczEoI9w2MVCgQuWHLWpKWc3Ug3ANRhmOaWT1WD+FLZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665840; c=relaxed/simple;
	bh=qW3BsbQGsGgKULV+hbJJQuiSOz+Kn3lDvAFF1WmVP9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf2f8F3rD7Sugps6vZP2CyjZfqIqpxzimw76u5ImzueOF/XE+uToj0MLbtdstjfC7UwNNB9zn1yiQmqIhohgcFsvRYweIcukDp0XFPAEpZkL8wBVO/9bPnhcumoOeazdwHzN6EPOHaeoAjlH3BwjvqVJ+yTItcosDf0W/gQsg5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQwMjOJQ; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQwMjOJQ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c85893bce34so2245103a12.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 20:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781665838; cv=none;
        d=google.com; s=arc-20240605;
        b=NxLw2pt8J6q36F7ezyE/4ZkM51OOJrTpqEiET0Sfczd5jCO450OW/DaRpn1rBXbnly
         Wc64HS9YeuI2kFVabKZh93g6/ifi9XurkePWCOBjLf25QGyjwnbY6JyBPRkPuFX1CzKF
         7KBPfgjBWqwMOGNiYJvypt9IwX5IQEMDGFKDjgGvxnZHCsIRqNFEtR+JzQyPbnmogEiy
         TLGwh3t0pozrlRNcSxSguV89W3qetUbIeHcNDMMzNG5Zx+gk90hoaVBiDangou7inlBZ
         ZZJJ4+gDQ0z/OBH4eZ3Ds+jwVAsBQsPQ3nx3hejytUmiyZcMYqWcyM0c+WhRYpyj1P7Y
         Z4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        fh=twNZpUDsO4zAVuZ6HFm8UNBEO3fdjqW851KkopU4xhI=;
        b=O3dnNadtEmmZw1ok5hKg4zz/VAiN+V9LrsVFxexhE42dYmZQ3ADnxU/bKw6GgJF9zv
         JWUB5ikAsCYHgMuGUa/OyHrs5XSOu8lTTlRzyOqr1DCkBkISuB07QkGX2iZafvzy0rw2
         c+OZ9Zz0Z4DcuTOT1yMJvlMvpST2EmLqbFBuzIrgaX7un11sysAdkZM9abNOUCUp4VWs
         3FhMtqPOKQKFyYWVPuMId8QAnDcK8k+tMOfJSX1IzlgxkDUQ3IZF1oET1rvL95Xfj6O7
         fDQKQodTJIcQYDvpRnJ71c9dEb6QKhXr2EU8de7Ukruo2TKWIt+TZgdEwtySLIslLqnG
         ou2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665838; x=1782270638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        b=oQwMjOJQuFjD7/KrNVYg9punGeV+QqkYjFVulASJdV1qtHzQb8Fxb628Mt0xyoEPiU
         Rga3/zakCQsdCPZf60O3QvicpNj6lAkkm/FxXulF6+hknx7W4WhArDQ/x0QxL0WIAh74
         uaRiZ/caakdHS1LRyhhQYjxFbQl4ShA1jwzXhOnMhScH76lRyshGhy0PjhS3bPAvhZ9C
         y7lOwn90iBA6w9aH0dBS1wGB9sbXUQcw6KfpFv2O9kaNASI2lHk1iZA9Qmhud7lmGRpR
         xF8GWH7MzNpbE248cjjxBnvgRw0EaGH//5Lo6n9NmB45iPMXzTQdAE+3idDrTtkT33TU
         FYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665838; x=1782270638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        b=n6qhQU4q21MxwnulJl0xx2KQMEhu54URIhfiTiWvTiwcFNaQ5gNCEvQKrjjU0iZwpf
         0Qk0rIpR78gDGPP+JQ4ctMD1HIQt2NhntKEfQDdRzyawp1LvLWx7Pxk7+4vCeLUt1z2w
         mQvxQzZ6ClTR2IDP+jipRpei0ApcfsISEFN/zdFzQ77E+ZaBJgH/jSD1vDC1q5C+9EoJ
         9qbic887Ie9bti618wKhyNSLXGD9PZZlMTDfjwJX41bIvvNFXCkyX2S9OKAm7gqOhO/w
         3QAa1fJFl39pj1WYYyBvvwK4Bgtecqgfo62xR34ldisxeyWAYR2FAnM5BdHhNiT9L7gr
         KXOg==
X-Gm-Message-State: AOJu0YyBNc7ZPvgLmmzNs4QzuptYLEk8L9LzHNxc4D9BpHBbo8L/4e0e
	D8tW+wnD4nHb8rkEezgKLRcU71pYk9PL/InG4Yc1WRxHkxdFfErMX9f0cK2ypk/WQRl/415VXbD
	8NY5xFBBgxbTdlBvWEW3O3hjFu9eID4tdnvEB
X-Gm-Gg: Acq92OG429SkdX2SskpGcg0G/8MGRL2+zR5BRkvBcEujA8dNx4WEsyVwGrDF3vZzPPG
	/4ul/VoGPXmjpAhrAKBcrNZPWj7yK8m3eY8wE7jqkmJYptjQ000ymgBPsHe5mnkuqlGB+WSLvsW
	nma2BD5Xn4k5dmBZs2K6K5RVPJt3iVhv5U+EGMJ6qvOAr2ENNXcW5EVqW84CdjPqds1wsRbQHyC
	xK7j0x3ORBzvo8FjOMyy5tQx2B2kIv1qHvRkKwvxkBbWOj6FP1tkTrvyxTqKPYVQqaMBYBCcutv
	oDwOGFleGevQw0CAwz9tbz2W6YETS9kOLcwLGua4JPmwfOnodujkvLu3sZjqEkQUnyA1fuv9wA4
	M1rEs653D9HZfOw==
X-Received: by 2002:a05:6a20:7f92:b0:398:b95c:51ed with SMTP id
 adf61e73a8af0-3b8b7eddd0amr2155474637.35.1781665837570; Tue, 16 Jun 2026
 20:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617011303.3969027-1-clrkwllms@kernel.org> <20260617011303.3969027-2-clrkwllms@kernel.org>
In-Reply-To: <20260617011303.3969027-2-clrkwllms@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jun 2026 20:10:26 -0700
X-Gm-Features: AVVi8Cfc0CqsWHOwbee6X-rMFuNMy0GR6Pg8FpJSFXk-J0xJ0qCfLErAPY2sjx4
Message-ID: <CAADnVQKniB8TLvQkuVaPb4jrKLR5G894bMEOrT+GxzRxqgPVdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/lib/bpf: fix const-qualifier discard in resolve_full_path
To: Clark Williams <clrkwllms@kernel.org>
Cc: stable <stable@vger.kernel.org>, bpf <bpf@vger.kernel.org>, x86@ekrnel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:13=E2=80=AFPM Clark Williams <clrkwllms@kernel.or=
g> wrote:
>
> [ Upstream commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 ]
>
> strchr() now propagates const when passed a const char * argument in
> newer GCC/glibc combinations, causing -Werror=3Ddiscarded-qualifiers to
> fire on the assignment to next_path. Declare next_path as const char *
> since it is only used for pointer arithmetic, never written through.
>
> [ clrkwllms: only the next_path change from the upstream commit applies
>   to 6.1.y ]
>
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>

No. There is no reason to backport this patch.
Distros build and ship libbpf from official github source.
The kernel source tree is the source of truth though.
From there it gets synced into github automatically.
Anything but the latest bpf-next and bpf trees are irrelevant.
Hence, please do NOT backport any tools/lib/bpf/ patches. Ever.
It is just a waste of electrons.
