Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB5411F91
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786056338; cv=pass; b=G7rhkfq5vIYgEHgoHhiQowV5nTuZvgRCFtFXWpBORomcG8vzyDfqCf/MP+XCh6firounvqnWyAfsqRgbm8yVtpeGddlXFEKHIjJ+etMudC5R53Hz9jPQXKZANenEtHs8ba4ZbuN9nhRx7NYtncuPgL/239C8HsPIGeA9KYkLW00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786056338; c=relaxed/simple;
	bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNLkgGM5WIry7+6GT4m1rnlLHHjbfZWlTWOtc5R1e69T/QOJk3yfh02VlXc26nZHS2Wwa+tjTXX7XHLHq79ELcuvvLSfFXk0pmwujwV2li6NOzE3GxI54MPWGOoZlGxKN0TXyecNQ4m6FF+/YLco1G5Bf2ZQQbGjNRuOPoatQoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJ/MepbY; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJ/MepbY"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so94011cf.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 15:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786056336; cv=none;
        d=google.com; s=arc-20260327;
        b=YlJC3yrnX60yC0MQMUGBnJCjOEpftwsWs+WnKt+XVEe0SME+C/KAFJz2WMxelq4CJI
         hgVcJ+YhUlY2TlVVR0nI5YO7ruRTT51Z1qaPMwoig/fzszJ9vtzZAZyU1Be/K6P+lVdN
         +hONymApTjNLULotiVkRPAvgyaZQGryY592mPbuPqotIw+4YtOL9QE5cofVN9q6mjQ0X
         Vy8hr5yCideggRLxh8y+PMYQXdk6+lla6EQDvoC+fOKvXdHcsEHwEbXQ4z+g3MHAH1VE
         V+juqc3ZUllVcp+Ub9ZuVW0NSnSPd/Lmen5ZK54uWTUrGCXnwDdvpY9wDwp8RuSpmYr1
         61lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
        fh=FfSJmzI5ibIIHKtZAaey2o56F5reLMdEvkCCt8EYCBE=;
        b=eCiJTBW0DJmjYp8x1EvfAfoN0N+fxysUmI2CYE7wurRp4sB4VbnwEtjBcOsizNpWmf
         CrfRMkkFuugqa9jCAk2AsxqwTmDRL7VkN3D9/i88TFwaftYgW0eIZU6jvAE+/Kk7OCaA
         449cA9n4HZ2ZzZNj1AtpkINwZsprp38WDXpI0wYpk+0GEOKYxQ3DrK8lkg1pW/pZzE5I
         C/gLfzxUtIlJRgSYIbXHOKrd6niF6BiciJStmFckLCNyFj+FWk3sRrh2lX+5cYuExQ35
         8as9x1sOH98OBnmhrV2/mJgk/cMNgr5G5JFZ1kNF4ju+2gSP/AOPMIJ/jcUX07S7Fd4R
         RPXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786056336; x=1786661136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
        b=OJ/MepbYZkMHaEoM8GmEMNqjhGV7WYqfkvTktR/c1wFhAxsdOALhPOffpkLm90tLnc
         vQHjdhMDbgYSwd6tvwdXmD4gJs2qoCBMBwezRcAmSymEavSLMLYf1ecVrODOEkh7RiJ8
         QLQVeiDP7V0yg/s09R1d9cWbRZ7plxOOQpYNVFPIYSy3XJQ5bVqOBeb/VMrV2SL/Lcm+
         2eSrrjfnivMAQJyWv57zPzMmXQLzI4L/p3CsWkcwDo7P6SiCEaigiNrRo3TvntbOLcYo
         pkqTjSy/Tj/fKcdRWKB6hQRNe8JVNVksAHIcE95wawzzNi9zaIHQwHBNYr7nRxyfLbsS
         XKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786056336; x=1786661136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
        b=EWRAcxJvgi4C4czfshmQrsKFrectJV2Fv/0crlX3FDDUH3OaVaU1KgAQJ/8EXEUYbA
         +EVlRDcYe7xXvBACp398t6XxrVNCUwOGSI5J2z7DTvHlfUb390HvgyIdPVCB3plpMeqs
         525iGoR+fHxstexTjtxiC08G+lPWAmzmX1V1u+7P7+/gV+roYdNmRY8kFqUclj7Ng0vm
         nhzYnofw7YSxj0dIEImfYy8q5hQWmjjCHqzmgcf6CGKjEbKy5/hjMcGA6hSPMOgEEBfS
         Rcw5YiCc8QnPMJzhBo4H32YlAbBMSsQHIYr0K6Bd76t5l2//DnwgARPyDhK+s/aWp36M
         gUoA==
X-Forwarded-Encrypted: i=1; AHgh+RpaURgVfC8H+9g9XTPcSaAylV5EDeEi03zfLUVufeTjjTnmMOSn3QVM8X9Jz+kGKoX1EHGnANo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxd6q2XTiPniuqAhHRTHFJ3LEoLnYFtGXdB83n9RP87vsNFo6
	kpC670whBT+HggySi5z5DR/zHatZXsbftohPMdwuOZbIJwXlaADiaK5JSnHJYfd1pfafG7ZTdn8
	zFTiilW7Eyr7bKsS2HU9JeLl1HoT8W+Zfo7kvd9Ls
X-Gm-Gg: AR+sD107MvoV0EYWI+wzkSQQgdBgHob3DOJvX8ejwZub4ohquAz2jckJSBhk/xycD8D
	lHNxNkvxds4qm70Zgfu8vkX3zP8Pnjvu2sCmIULD/fdJ9Gsxjsxc9oFx8YIo6Py0HL8AsJPcOnx
	YuP8Ltshmh1WFbFzXcXGCLLryaZtdC6xiCqtgHGz4oJzz0qcwH++tao3ETAjAARcufv19weOutO
	2BnrdP52y9mbcL+DN0jk/5CaEza6xl/OBl1bRIoBPyJrl9N593Tus4AcpJ/xY0/Lqc68OvQiHLe
	2TsFQjIhJ5PKU1ZU4tz1blDztn3AWXg0wB6PyssISCUxbpoxxEv+TNbKqfibVj6qe+naOGeFqyc
	=
X-Received: by 2002:ac8:5893:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-52d106def12mr5018131cf.2.1786056335879; Thu, 06 Aug 2026
 15:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724014605.3377283-1-linkl@google.com> <CALUx4KQfyRgG3ewQZMuU4+AMCyrh8+rH=-MOZLBv29PbPcnhYA@mail.gmail.com>
In-Reply-To: <CALUx4KQfyRgG3ewQZMuU4+AMCyrh8+rH=-MOZLBv29PbPcnhYA@mail.gmail.com>
From: Link Lin <linkl@google.com>
Date: Thu, 6 Aug 2026 15:45:25 -0700
X-Gm-Features: AUfX_myMFV1qJfbDkK0lr2_rAcEPde0PqT3TobQKcsNUoc9XJsFqir-koEVr8yU
Message-ID: <CALUx4KS-xRf7m3jPDN5BKfFrpbojp9+0czRp5-siFed-Jj1G1A@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio_balloon: add VIRTIO_BALLOON_F_REPORTING_PM_SAFE
 feature bit
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>, 
	Taylor Scanlon <tayy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Following up on this RFC to see if anyone has had a chance to look it over.

We'd appreciate any high-level feedback on whether using a dedicated featur=
e
bit (or a similar protocol-level handshake) is a viable path forward for
safe hypervisor deployment, or if there is an alternative approach the
maintainers would prefer.

Thanks,
Link


On Wed, Jul 29, 2026 at 7:52=E2=80=AFPM Link Lin <linkl@google.com> wrote:
>
> Hi all,
>
> Friendly ping on this RFC.
>
> We'd love your feedback on whether using a new feature bit
> (VIRTIO_BALLOON_F_REPORTING_PM_SAFE) to negotiate PM suspend safety is
> acceptable, or if you have concerns about protocol-level handshakes for
> kernel PM fix states.
>
> If you prefer an alternative approach for safe fleet deployment, please l=
et
> us know. Thank you!
>
> Sincerely,
> Link
