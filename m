Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1C1F1534
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043171; cv=pass; b=PFm/9k0x79PO/SvM5lYYVbzEcFgKcJhIESoGKak4UMlNSwDhXSwJP2gFdLRsQ/kh2ev3yWi/pF3IEebn0759CnggIMsRsxjavSxTMWOdY0e+CcD3ZnC0XNgx0mi4hVoRu5n9oD40L5zVyf5sQ9qwyvaUtiYSnRTB/hpFhLJHP5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043171; c=relaxed/simple;
	bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIyDeOlnS3+XycKc54fZcQebwUd04tztVlUDVQmBhG/NYP5Z1zipEg4tCJRJZvYXhridZS4zzUUq5669bd9FOA+EBtb/G8IbqyzdHvsnKQp+AET/cZQxGBqa0+zXT3HQq2bDcmcgUNxlRBnjdP/xtxKab116w4FwLyLAJLU/iHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Spb7umaG; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spb7umaG"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e50968489so3404862d50.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790043169; cv=none;
        d=google.com; s=arc-20260327;
        b=X2eb9+5SCf+zZk4g/9tr4Rauz8tLxu8O5oO0AwsFoZT18a0rgICBYKefUFT4RS5mFV
         Wchuu9fL167StLSQCfDikDPtx+s+jruldhsHwP+BCbDETb3pI71nG6Kizgd5toscVKxu
         gXz0IKSNKZDEhodWUVb94SBHTIwWgCyVC7efjQMBonEthZE6Ib4ByKPmlDMq2nedRDfJ
         7qPXo/FPfJeze6YB1dSCHi/8V4n+1eJiZwPUAIkfgwDcgSoaDJr9Gkq9XwPWshWV+8Qs
         fxcumTODghx9TaTqf3PsNz3ORl7NUn9MbHErAtvtDVBwtNEgOx+74FuFemJFo7KAeYk9
         IYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
        fh=4rXtRAg4NybkXbpZ26oNMRIsp3BTRHwG5gEFt4Kp89Y=;
        b=fRjt9r06iFqSS44oYIf2OqiHrRvhgdHRLl1gbuBkp/NXo0ggmzNpy6YWcph50fXfmk
         mlO2WzUWdy2VHlOhpCyafWo+27IdgmcCa5ts3fGPCmU3/TZuepS4Ep+YO0YVWPyYqdUv
         xvJ0cuswQdezI/yiTNTjFqj3vS7iXj8S2DWtM1abS4YYCC1fovoJV0qDPeSWb7Hcg4Qx
         Scgg8FOF83bF2KZrz0aJ+Ct3PHqgunpNvv2HenZCQnJ3egl+mJ7p3imbgKjI5WOCWawp
         5aQwHya1Zk4i7Jr+5PglIbRt7qSJrFWtP82vQlVq8hZLcZhGsZ6emVBL2m8HwWMO+5oH
         FcRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043169; x=1790647969; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
        b=Spb7umaGVHS9WmfBhptaLE+0kwzfkWnwdXBdWpFB46nmupD9rwL8ITFCE8xkzJs5Re
         7vnpaufiSCHcnfxbYPQWhGb0aZodlPkgCyCNbhgBz2Fz36u+8GE2lRgHPWAYnwFPZUJD
         cwri/DXltIwkuPF0aFw/0lMhTIbqfnrBZbab6AEHwoM7givrKohwV9vQ3buuO2TmpmBz
         mF/dJSw9m+j5nDwSTokckcnjcFnM/7mHIDhQsBM1r9XDTrELwUZXsdVr6BuHSMtuAKy7
         C2I+WTPaZNpOjAs/LZs7kuRFVAI21D9hScg4cMEh1yq2aUi5tMD7grDwOUvMwLlzLnN8
         oEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043169; x=1790647969;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
        b=Vt9ZLbg37Kxlruwm4qd+F3iqf//FcFGxWVuiw5EuE8dPKSa5QjQysZWn2wHzw7toee
         IEe1S2Mwl32z7LtAjovEysO+NXQBZo80a+337+7nFjqZmhT+FGeDwpf8uPSSlbrK4t/S
         uBJTpJedcd8TsuqKbhy6DgYIaEAA62ZWBMfo5LCfJenNaSjNgia4kC+V1gRZprgfYnsv
         SWDPP3FrpZcIeQ+Lg+J1Gisq4qpk7xaxX2Pz3N5aeREbIwymhZQkXs6yqf7DIWwZUxzA
         ZPsX8UzUR43cXTzuqRozO4xOvI07Dx5F2Owxfmk90ogVaJH9d4hS14leuX4qn8Aj9FgL
         14FA==
X-Forwarded-Encrypted: i=1; AKwUvBwrTzFKNI5TbYsGAkxF8UNAwTG4eJ8RCzwr4n1yzhA8M4mo/q3RNgUxlZtlc1o5QfwdEjKb5Q4=@vger.kernel.org
X-Gm-Message-State: AFuF++nx/QluMLlZ3bbwgCUAxIlSrXBhJip3adCjvW/6Ldvxr9C8craM
	xYb72hJNQyioEzC0L9pjCBhjjk6+pz8+nwTuqhSa1S8wiF/2xUHdaGdcOvSs59GSEqZGtFqsXmg
	TUfOK2h4E+Z1OGDFlj4reB6yu1dJOwn4=
X-Gm-Gg: AYBFou0FzGR0B441NC0UAdsznURpMeGkKp6J4Yc8SLxjdp28izuPhgy3VdV5VLOHtWg
	w8LlyYF7YIN9U9dZ09A6czkhgzK2jkJWl8+T3scLPrZ1Mv2l2xCgHnR6mW3+WR7wSivH6Xk22rd
	82lSZKgtybzB6Kipc3czZl2WVNwlQl1iSkdtNbivzEIc0iyimAnwJ4+ZfYxekGb/ts1d3ka/Bml
	ql0lDRgRaF3zMl1KH6ltLn0XipmkQdJl3qUCBTO7tJFuVpkt1j/2HS9XXwD/Fo1nZrjrw2AtNAb
	AO0C5K7XxgF2bSGCdVK1ygLVw1W/OZiqVZYjpFCONFqSmDC1VYNmS8OgqNhqQxt/NVeh
X-Received: by 2002:a05:690e:128b:b0:672:a546:64a8 with SMTP id
 956f58d0204a3-672a54668a7mr3570659d50.107.1790043169134; Mon, 21 Sep 2026
 19:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
 <20260921154202.471662-2-lgs201920130244@gmail.com> <179001756287.8372.475254242129499819.b4-review@b4>
 <1804a859-371f-4bfa-ba48-d5cd26819cd3@kernel.org>
In-Reply-To: <1804a859-371f-4bfa-ba48-d5cd26819cd3@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:12:36 +0800
X-Gm-Features: AcwNN1VAnINknji1fkt2WEpdwkqP4l6wafMfAOYzvmtdGrYl5oQg1J8YZy6n3vs
Message-ID: <CANUHTR9BSNmmrMQqXNd-qap2qoOxWf-ZtGAaV6icw4wpFaCFSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: ena: fix PHC cleanup on probe failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Sang-Heon Jeon <ekffu200098@gmail.com>, 
	Dawei Feng <dawei.feng@seu.edu.cn>, Amit Bernstein <amitbern@amazon.com>, 
	Netanel Belgazal <netanel@annapurnalabs.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Tue, 22 Sept 2026 at 06:02, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/09/2026 21:06, Arthur Kiyanovski wrote:
> > On Mon, 21 Sep 2026 23:42:01 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >> ena_probe() initializes the PHC as part of ena_device_init(), but the
> >> probe failure path does not destroy it before freeing the PHC private
> >> data.
> >>
> >> The normal removal path calls ena_phc_destroy() through
> >> ena_destroy_device() before ena_phc_free(). However, if probe fails
> >> after ena_device_init() succeeds, the error path reaches ena_phc_free()
> >
> > This part:
> >
> >> without unregistering the PTP clock or destroying the device PHC
> >> resources.
> >
> > is inaccurate, see my explanation bellow.
> >
>
> Don't waste your time. This is AI slop agent posting (one of 500 more of
> postings where agent does not care about replies).
>
> Best regards,
> Krzysztof

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
