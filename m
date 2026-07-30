Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5023783AF
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379945; cv=pass; b=Utye0AWavOBf5oAFll/6tAhCaEN6EkCZdEQDyuwfn9yTjoCnd1O/8np9GAD6HKhKuYsUZ/yqGFponfH0oEfy9OJTEHGoaCR3Sh5Bfo/V1pzvsv/Y7orefdejS3zJM2KqSqn8pwvwECHBWiOKrN/kkP/o1zkOhUkM8gMn/NGm9yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379945; c=relaxed/simple;
	bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkHpgB+0SCUsIyOKv16TIefqTx0oRfr/kINUiUgOg5EzUyF+bBf8OdgDoFYoiC+Un/gheJFfXHgxSlZ+HLhtqXv2qqKJjWsAURlJf1TfMBn3vBZrJpWQLaX1Qf+J055NJCUUkk1SSExi912Daai+nYpo0aKXRcKbr8EhTOwoosE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJgUkmTY; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJgUkmTY"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c10ed63c0so85671cf.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785379943; cv=none;
        d=google.com; s=arc-20260327;
        b=SiO/aHi9B9LO2jR/DoE0p5wtR8Wk1rplKgn3z4rsD3nJ67+l1ERatSmNIQfKznSAwu
         FUjGyHiCpdJczHXGybmSlhThkEpNNRUcMNFymmYXcgKApMHRkWh3jfMiHc2fFYpR7ilh
         s9ZMv26PPZRuWsiDb5QZxzWMolNqx4bm94+b8TYk1wuCfZoVgD5O+NlavgKDmjSIoLsB
         9j8h5FmVwyED68E8n5PTmEb4NyNuG0rnJJKmLVqBpLeMiCagcdAJunGPh0kI1ji+FKDY
         LiaOkKV3SkM7OkqkF/JNBX2oaQRu7G/uRiLV3j3bWzc9T2b2oS+SWvgEUnTBJt73hXRh
         vxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
        fh=JSVV6Ps1PbqjFs1IYokeWb7R1CkYihyDiVIzVoOq5y8=;
        b=QlXK4MM1dAILgVMdTsR0e2pgkygQ9vSEjVgZRqpez/Mt0+76K9jnDYsoliWmpR4g0r
         ahzH0WkKhEtm/DGDfNf+BVkYOLBWAYHOgeq3tdtDSZfXcX3Y2bYpNS8R0avyThphaigh
         7PWd7tYc8J3bUCM+JDbMi4O3+UzJtL68qIZcdV3wh/ggJk+lGj64xzKeXXGfgYn883dQ
         aHYN0hZcc+sCbRKiXPiexJtbOHGW/6XHe6wh655pPruqXfgXUcn5fhVUMLr/3Q5RFJL3
         dXAY6YeghG70xTQqosxmiwBATSaLw99wHkXAdLKnwZH0P5l3bwJ/c/wT64nwkS/firtN
         iiAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785379943; x=1785984743; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
        b=LJgUkmTYJLhxUuk/sxCRnVmztNbWBr9yIEME5zRlj/gKrMvIJA9mgSGZvYlcov4DQA
         HXdDdMW0gBThXTAiy7mHEFunjFHrCxSCUQZAa0G3HTOOyNHaR+4Jjgz/cq0+fNfA0qVU
         M7b5izyVpGj2dYZLhcoQo6kZeqr3C3rdmDe58gIKlz23YM+v7gxGH6g0hfv9TTAGH0rq
         sF4AVjWWD5oxD7S6DMm6sY4f0wP/OHWd9ZMZTER35XgG7F0S9o073yJPxxt4yIwDFTFU
         3Wr4DBfmIaawo8msJE9P5wXMaahX7SjnnVSMnDuo9ktQbxy6WpfZG2uFv4FmInX/PgoT
         Jq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379943; x=1785984743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
        b=AAvOYHpyzz9GlCdPgclNBGRbqK1k9RJzNVE5l1IPR5brstWEN0tDVZ0q/wTK3fQetr
         mbbcOTgb9QwLaJxZXDrskMEsaPB7d7mU37B22UhDsBq5k4wFFAfvRWmkSmVwzUk2BSoA
         2Bl/fy2DK2k9oZrEbrI8jhyPIW/rYDc1PfVWNESvg4+WEiD+KyS+vvakbmMDGsUPU1/1
         fW+AyTStQfk8owEEiYSmbIn2zCVRuWs1oWTnPh4MBk0LPNglf5N5NOSLBu6ObvZjWkOK
         Qzf/H/YhXnKNc+rxzyK4Iuq7x4rA++IfmGOOwv1oSR0Y3jHgNK6g54hENHgTYc6ggOzp
         kv+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrZGG4l2WKcpOoAJWeKsDcwGuy1GKCtqv4ML6M3N6rHLJJJm4yA2dMAccPBRm+DuHkEh+9rmT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocE6xTlir8d7/z1VhVjoYfAeidkUQTD48Cdbfkcts0P8QW+WA
	RSpUwobnmOReWCRtoArc8Xp6PHvnDgU3AAd4B5iFpXq73yBZS4kDXZFQZpXI6MlvGsDKmT11a8q
	P1lTgkDpED496eriDk3W74cl6D5LaDZq3pVr35SIK
X-Gm-Gg: AR+sD10UTAv9yP9cPxLHAWJZLWcKEa953hb4Vov5E6+oSVoLZZx9xkX4qT0NpNIZ3N5
	2WxS36p1LHm5cb4cd2V49AtTfev1VJRnf/VFAgD2JX2f2uX7xtf8ZqgyumxDpgEr8TAPODmbupo
	m+0/brqj8eJQiUn/ZrBGkqagPl0825X7tdJr9ntTJH2oOoCPBNUCafEI5n6Q7larMEpbiofoYlH
	w5ZOXG+l5goozTm8SjK0YQJTJxGyXntS0WX9d3zlxcD8JVEKvLak+dkGClpRFj2VgqII+jIWJet
	C4zjCWn2Nr8hhLz2g9+qawDHcSASe0IXDzGNSSQBlpAtROIgT+43rw83uQFKDSMH7dDvtMi5a3s
	=
X-Received: by 2002:a05:622a:aa8c:10b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52b393ed56dmr4235251cf.3.1785379942843; Wed, 29 Jul 2026
 19:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724014605.3377283-1-linkl@google.com>
In-Reply-To: <20260724014605.3377283-1-linkl@google.com>
From: Link Lin <linkl@google.com>
Date: Wed, 29 Jul 2026 19:52:11 -0700
X-Gm-Features: AUfX_mxpFzT0hpVdDxPUqKHkGPgYahhbPQV0xHfM6lq50s8el3BKANlDBJ9mwYI
Message-ID: <CALUx4KQfyRgG3ewQZMuU4+AMCyrh8+rH=-MOZLBv29PbPcnhYA@mail.gmail.com>
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

Hi all,

Friendly ping on this RFC.

We'd love your feedback on whether using a new feature bit
(VIRTIO_BALLOON_F_REPORTING_PM_SAFE) to negotiate PM suspend safety is
acceptable, or if you have concerns about protocol-level handshakes for
kernel PM fix states.

If you prefer an alternative approach for safe fleet deployment, please let
us know. Thank you!

Sincerely,
Link
