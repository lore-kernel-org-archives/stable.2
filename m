Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0212580F2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034756; cv=pass; b=ryz9cTZl+XS1pLIgtPaDwc3im8XzaiuKBJc62cTwmULD+TVe7fH9XjoM31aI/3M0bx+KMFcKDxSrwj3mpZbeYZ0XhbncIepBRrqU7g8OZWS3Sz0kbdVF8f/IWXJ4dBqr/BuEYCntbMUgp+gN7oA5VpcZ60t0FVv6YFGEg5DYqcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034756; c=relaxed/simple;
	bh=nzpQT5SxsdB/xegC8rYZLk7oxk3ddENzDmbUKGnvfVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ1XeNFkvqXGGTpT0KPQXEEev9FJswI1PDF+hlCBpUJPCGWzw8icnah3YsSui9YWOjYS4AqecBAhkKuG5nboUDRxqwZWBQsADTvfBSPKxTt0aEMOe/bxUa2U+mxJb9XtG1E3OE4EStNcAJw5XjQy8qJ7IErdSXq2WocSElBkVlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmP0OyWW; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmP0OyWW"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so2321681f8f.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790034750; cv=none;
        d=google.com; s=arc-20260327;
        b=q8g2os6QCM2KCEORhJ10wudIWaSnRzzXL//J89DH8fFgBhVsk87fjpxMyc24n9mmRE
         JvMorRyZsNcGbcDKyEg0w5oU2pDpFknQrN1U3djdzdjGfzN4LFEQIBGhRcsYhxwAt5xd
         K6bhmecGc6mSSrY+9m/cE93WXT2pw4bVjMPzyRaZdMvitcxI5UmO0Smb5gtvW7hG0EI7
         i9KrQm9HYQeGOOwRlpzZ0K7fHogkLZgUf8GsW0TuJgs557kiUKAxQLTx16aHjelf3mCj
         /zdy1NNDKZn67kM4/ei2twhkll5U57/5UXutqLNM2RjXZWcvjTCUmAMmAELvhZn7PO6A
         D4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nzpQT5SxsdB/xegC8rYZLk7oxk3ddENzDmbUKGnvfVw=;
        fh=SRsWJQa7FhvZHVV89QI13UhM86TI042uKheOuEnefT8=;
        b=nW/iAaAwYXwX09LdBDpg3G4kHhA9PN/P9P9AE60ekV8Olhs8Uec2zdyXuhw92b50jT
         dlK8cT5GwBOSihnfdv4bTKzH7jXFg/1KPgqe69IZdjVcEf9/yVnFxRUMXelj9TEl+Sg0
         PULxR5AcnJcFEFtEKh4zcu5/f7SO1HtE9r0NVAjU3EqUvlCy6fhTI3EC4cfuCU2tKyUf
         IR1eKdLnsTmtv+9H/SvdZ8WsKD4DKY2nC8+6PaH18DtzTBHKItpHNDPURJilZtxoF+aA
         U2BgcNdF/52Ay9nUCVSMHwkKQ9Z0QpkzygdAWJOv+SSCpKVxP2tRvnGlGxFouY/giIUp
         AgYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790034750; x=1790639550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nzpQT5SxsdB/xegC8rYZLk7oxk3ddENzDmbUKGnvfVw=;
        b=AmP0OyWWxgWWBkREgD75gXRVUal/Zz5e7aP9gzyLaaMKHhltPEE8qe9lDgqvFC8MHX
         Qt4VduenHBLXejvpCk5THEw7iU3JlLUVpXkLU4eMM/CSAczrBbn8/Av/2ejUAmLzPtUa
         no5DzExMjBlNSeENmpjc05eN0BQZApvyRJOPx7jT79v1EwyNbxUKHqV835q9LySg1g0c
         753vtI1dvNvB+aBqorRgiLtEfMBz6TrXcazCq7pMNcZ/5fMQKCEfROgb0v5uiLgvy8A0
         GO1EfeQWBBWmPD/7PnsIoOaRh8Z/BKLLMaL1MMgw4i//RK7MGmA2eDGYTShxIyOOxLiJ
         uxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790034750; x=1790639550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzpQT5SxsdB/xegC8rYZLk7oxk3ddENzDmbUKGnvfVw=;
        b=tu/gnyUqgkQMSLlnGF2jdSDVtwjnoNS75ml/1V5nQ2wICcA6SXOcydsf0mS/omCzrY
         arTgF9QwEnTTj/qtA/o1uCXy3GNsOz4gt7RwQ5xvQNHGWhvBO0hEWJGwWhItIKceJN4o
         bpN+xXx+LXNYZMlNZz18h3ConBaPwOKvBrviOKLzHhFZaaf1BG5g6uzC2j3Qfvk31z2v
         kraX4dMMPk91fwnHECMRVk93phDTQSUa97Jug8HhDDvOQrElCk5ypCsjk8tjS9v0sQyT
         wRpsddd6YImaTF2PudfC4l/JZ2HXWtbaPQkhU/1D+CPN8Yga2Nr0Z46j9U7n1LsbxP4G
         xWRg==
X-Forwarded-Encrypted: i=1; AKwUvBwpS4qV7g8EO9gZCx87VrgOjUh1VWbGCFs9XV7Oel4bzFrySFXYgP0JdQjfB2ubDdjWDlJ2ZWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kpFjEEmjbVOd3RKpq+DuMIYW3sbdfWkCiLOFyJgKSnKwccl7ZB
	AAsnhIE6D/2B7M0OHgTgf7wYtpYn5BBr7sXS68VhEJjZg4BBW1Aqbkllc8jhzecUZxogfjreu/w
	jhx4qjc01EEc/nGnj2/mI7UUrcO4OnKo8IgI8PmVt
X-Gm-Gg: AYBFou0OxszbPpDn5voS802vAiP1zmYltnH4AOBSIi9WtMJXSG+t46I0GTiquojaL2M
	yV/fZD4QgRUejZ3IVxvHOY6BiyjYBONHFmu7WCKGh+DmGHx/4JKSntP52GFDJeHksu3lq64Gic1
	lRqwEP5PwxCBt9tPvXrR8vOGTX1VHzU/Ubu/PIlVtmAU6QGuGMzg+Xt02QnDrY5xkqISn4jMpAg
	K7T8w4ZdD5SEbqAt76L0EHJ6LR4r39O/mlmHMDHQduJevn0rlKTvXC8mm/jqhgENdyJD0UsH/+Z
	ylr1yPWGPBYg45KIUsp5I0mOxU4fAlDSnew5X7mlPIuarunGmNgkpuV2PAl/7PZJU06SEQ16XIP
	2eUOAeX3p
X-Received: by 2002:a05:6000:610:b0:485:8c16:5ef1 with SMTP id
 ffacd0b85a97d-4871e36d0c0mr19371848f8f.43.1790034749762; Mon, 21 Sep 2026
 16:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917204209.97699-1-mhun512@gmail.com>
In-Reply-To: <20260917204209.97699-1-mhun512@gmail.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 21 Sep 2026 16:52:17 -0700
X-Gm-Features: AcwNN1XmQChc3wF9M46vgBU40k-YCjqTLZqTMWXlA9L7AxR5iUA5AqwBC1HrUWo
Message-ID: <CAMFSARfQfOVJ7McNDfJC4uRRhmgyh0iS3T6L4Rzyc_gxTTg=qw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Stop altmode work before
 unregistering ports
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Andrei Kuchynski <akuchynski@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:42=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> DisplayPort and Thunderbolt port altmodes queue work to deliver VDM
> responses to their partners. Port teardown only cancels port_work and
> then unregisters the partner and port altmodes, leaving the separate
> altmode work able to access released altmode data.
>
> Disable and drain each port altmode's work before unregistering the
> partner altmodes. Disabling also prevents a partner callback from
> requeueing the work while its driver is being removed. Use the common
> port teardown path so probe error handling is covered as well.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: dbb3fc0ffa95 ("platform/chrome: cros_ec_typec: Displayport support=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Jameson Thies <jthies@google.com>

- Jameson
