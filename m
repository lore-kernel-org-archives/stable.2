Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F853FF8A5
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422960; cv=pass; b=IMUjuLEFJrjwKylzNt4WOUf8Z7URGYM8vz2KKIEv1zMWMA3MhY5EhxGVw/BSu3Ku2ASqNJ8YnGD4BllxL84Oz1NvjMffBq3Y7ZwGpZSp7qID/vxz1wYMcQHtOoW4T0sWHRSb+ytiDvQGQ9ZC1ePYAqWp+SEpncJTbFkTo7Eoi/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422960; c=relaxed/simple;
	bh=dWEo3mp7frOFVKITzORF+6HHk5U6mbYoC8XrjT44of8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVubYV+oYBGbsnL1HsfcpsPTcsXMqHJn6juoXcyKNbCAOyd8YxFqVn9ywtDfS9HCgE2kLJpPSau9VZUzIWEpof+rtQc19YRwOz8iMSBMhUICK7uOLFebai34DV11y8/75vpiciG5pLV7dkbOs7sxEUFFZLeN1U+YiOfC1nXDbn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k+HhOoMk; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k+HhOoMk"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so14089361fa.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788422956; cv=none;
        d=google.com; s=arc-20260327;
        b=ctp/5ZSUAE+M9rR0rTGhjc/JOoLBhln/g2Ljl4ON1LY7ExlS697M+oW/QXhcqjH0fV
         F92m23HbE4L/iiXf4Baue9W9rZToBCIJ1wsLbEqiHBoAJGk/uhooW2UE9gb49yGvPYWy
         ALMtgOlH8AHq3H7NiAiKPvmLACIrLZlXJUdGcMAMCioLH80Kp92LJ3iC/ACjCl4TREf/
         VTZEmkdeF8JiOaG4ReqagID/i3qkmEMLR2kowhs8y2FeDhTythuijV2SOX9U4Mq0wZ13
         TwY2K8srcjToJu306Cx1+vzvRL1RP2v212m/QTqNWNQO7FC/t6mjG8EhWt2yMKB7VDDX
         ktXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTfy45raSGSmQ3CPJ+k8R7TpaweRcKOSHtZadmJbOaM=;
        fh=DFLzQv2E4A32lj7K+RQq8wEAO5TTtsrooHX9eOJuSrc=;
        b=KuUCWC1usNKX+XhiAfF8cTDQxXoR8Q+S/P3ugOc1L6Dc3kjYcie9c2NXH3X6ULN7GK
         7stHOKvDrE5A9DYhDspfMLWupEY+FENUNatZizuJ8qT1NLT5snBNklxMdJuy1Mtto/Rc
         T/9YtQWLUZGdefLn3rtoay+TcbdcXq0/SMkquP5OlUb9lJIt57ACYR52deCqOsipPLRq
         YSh4fL0gVx2DA9OIXNuh4r8MTAmJP5ooabbuHLF/fUhYaqqUwDEEyt93sBc5bSXQONLi
         XdeVgzgtsk5B2hYzdIbKk2tbyzxx5HI+BvcSa1fYeonCEb7Lhoa/pllttt1K8qPI3HfZ
         7nCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788422956; x=1789027756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTfy45raSGSmQ3CPJ+k8R7TpaweRcKOSHtZadmJbOaM=;
        b=k+HhOoMk6tLRoMus9fcYwhdY69VwLNTc+4p+IDImaI4AoiK3BLP67bD4OJY3x17luV
         tZDTqDifOEFMu4J4vHkZwLZMr+HsyumkVqzkU6ZI3pMB9g8U0ltgFtrlxD2e2/OxHa0+
         iO6VWeVs5t2Yg9zM0mVufn79jPdTNOC/ffoVl0tSVHCYcm+oEHePv4JGolDmo7ARLW7s
         eDNd/OkC703ZRdRC0/T7I+OwjmecjtMnyHyvq6E2rbRLgW9o3YmVn654PbY1CDt+8NTB
         WMItEVfAcnlyzJkdSY6t2/9TlgxJtmbjfOXDXgRHiSAe4U3nJf0XZjZgTkFQqC2nsnJw
         0jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422956; x=1789027756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTfy45raSGSmQ3CPJ+k8R7TpaweRcKOSHtZadmJbOaM=;
        b=DY3k55YE87zHaypyLj9Yfks9M/PeiCKt2ujCRZ7dvzZ3JCB7OdpzWqxKC4tjVvVe7J
         fIY9sI8DsIkNZXDY6A4e17yvC744hSXX7PqkEgfzujiCCwZAetVrk79vOGJw7VPefuLO
         t8A3l7EH4rOkh0WUcgwKgvkoqyt4PnCj2DcnMW8pVFMKSFHM9vvYPZ9SXMlfeYEqpsS6
         t2kvNz9r4T+4o2r3WXaVu0Gfu9d1L3jWvOo6JPC4xqfX6TgIJu9OR/wNfmmo8BtJUxZ0
         myXlYkM9LgcA+XGPJlhzgJfi23C/+csGl3BKh7RieJFN3ZxzkoYiDeigMZAuNUlCdcR3
         JxOA==
X-Forwarded-Encrypted: i=1; AKwUvBx2KaxiRyEHUJlOu8gyrgfCfJ3AITVxoAcZ1pjKzgzPiXm9R3P7MBZQtnsqiZK76gxT/g1i19g=@vger.kernel.org
X-Gm-Message-State: AFuF++koeuFcoGAGhJWbRkwXYKzfVPhnPbyzYZsk6SFo8dfw6vr/QzMC
	cW3eImx/TNZxeB9N8tvhv0G8nUy82iH/SIfesJ2fD1DNPuh1O399B60CxbvYz3pxQO5pJHVdnhZ
	DhHRE/xwzdF2OxyhqnkCyI6g7HKicFxgfg9yHUQF9YmU=
X-Gm-Gg: AYBFou3+HhfhKzdrYQHGArnNIykPFktzW2qvZV0Zd8HRabmfMdZg5qpkjQtRfxP+E1v
	EoMFCBTUITkWbs0jOfqwYblkWfIR+ZNrWMp4sk83172MW3jbdCUjvPDwJq+SzkFXUkGocRiL37o
	/LGO86/4zGs3o2PqCfhvJ/4pvheLxEX4aCLsOljjd8LPVZxEZlpPaNdksfgbLW17qw/SrPwcobt
	OtF/CZ2bhqsKqqkaCK5bJ/tlwvcDYguL/g7QFw6IRBRKr4eesZgfXk40NYJ0YUr1pWED3FZ5oVR
	HH3HgbaTPT9Yt6ot/Miek6Mra6torA1sjIZLFeccirSXdBI1A1T+x8E+ss05fVTX8yQdBcL6N84
	=
X-Received: by 2002:a05:651c:4ca:b0:3a3:115d:daf0 with SMTP id
 38308e7fff4ca-3a35008931dmr18616021fa.6.1788422955902; Thu, 03 Sep 2026
 01:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787903722.git.zihanx@nebusec.ai> <8e45ea5d0cf764267a90d959fa40f0f831aabf08.1787903722.git.zihanx@nebusec.ai>
 <apKl65BbdyWCtre7@strlen.de> <CAANe3eT8ycDkomgpzZmni7hMrUX1fr2dE4QvQOcKCPEcw=J=2A@mail.gmail.com>
 <apkahwSdQhuE6gRV@strlen.de>
In-Reply-To: <apkahwSdQhuE6gRV@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 3 Sep 2026 16:09:03 +0800
X-Gm-Features: AcwNN1Wd0FgsqLjcXjqWHA6w1DrMXZKkBLBFaJpau8ih4FBDSOgZEW2Xg9zNQoQ
Message-ID: <CAANe3eS22cFoqz1DWAkLXkskZqO3istpX6ARSKvBKBBVKKKdtQ@mail.gmail.com>
Subject: Re: [PATCH nf 1/1] netfilter: nf_dup: prevent asynchronous duplicate recursion
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:58=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> zihan xi <zihanx@nebusec.ai> wrote:
> > If you do prefer to keep a small nf_dup-only change, I can prepare eith=
er:
> >
> > 1. disable IPv4/IPv6 dup in network namespaces owned by a non-initial u=
ser
> >    namespace; or
>
> I think this is the better option, someone would have to explain
> the use-case for DUP in a user netns.

Thanks. I will take this option and send a v2 that skips IPv4/IPv6
duplication when the network namespace is owned by a non-initial user
namespace.

Best regards,
Zihan Xi
