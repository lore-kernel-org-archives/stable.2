Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065B372EC0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779644; cv=pass; b=RUfryga8/+wRt8mAQg7pTf3ym1nIqkgzw2KFYaDCOo+yObJsf7z1qByCqjDW9KXvePn4I1c5s/H0lF1dVQG3nVBuE46vkTJFepJXft3Ey94J+UOlNMkrwcWhnbJ8qY1Ey/XW5VgUeImC6xGqUDP7inllVlavHyzA6O8qa4Zg8No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779644; c=relaxed/simple;
	bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/vQnNFP+Zjvz94jTYk5qcAOUrFRBHc7QF4mzofarcZ45Wmj7vz/MSZb2BsotWfX0m452lbFuVKZKswlWHRytSQ2XK8sPw18TspxIHFdDfyC/Q2Zf30dDEY6jJdLE78FmVfYCl3auOsP+Y/Ecwgq8Hz3QNRHxtARwtTPBiJlB6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGfYmYqK; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGfYmYqK"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10e86e52so70511cf.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784779637; cv=none;
        d=google.com; s=arc-20260327;
        b=Fx5oYonsl4KRLO/HZzXVzss7Oeq1AmgcGIGKQq2SNbXbQ0Ixc4xYyw+XvMuIA4zsur
         W9NQ7pG2QgywGfMk+eXJEI58NanA1Z+6BfGYHR1rqvH0M1hx5jE0kjGvgDF4Mtj7c1V/
         EmNWM2YDpizMIMY8AuL2mLQYaROam8AIV+SpscZ7gZh4xSmsZq5mykHcFSSeX+R/6Qh0
         rrU4DJy+uTD9z2IysD72f1WJX3Wa0S0GYWOQKZJd/HCtEFmJinw1jPzDPFoWGFkNvo/9
         d01nyYUOvpN+P3DzjwpstqVtYrna1ciqvCW9yPeMa7A9WyFtXAwf6ikyee44LLUYnBNo
         VNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
        fh=1SRwH2fhTFsP43Un/Zi1P+Pg7l7iC61VUDBQdVi4/uI=;
        b=HrqtSdfbn6XR2t24jEOutgoNamU+9qZgjSVqJwQAd0hJuTGZYIdbUGnUWGMxEjFHhK
         ipxMsbhcDa0Lqmm7HNZLp1irZH1PRlASLk4t9XTuXx/73fKR3f4DU5BtY18zOB9gDE3o
         +9Uzqtg9DV2JOHfsJiPHmxzIRo1dy5P5t33KoT6G/2ddLStO2FzPU5w4tHrucnhwuzt2
         upxzd8VzoMVnYj/SNvEJA6cpCC/KNkevUkKtGveebu8ucRQkzf6+Ec3wrFjE8oFSiPm+
         H0jxwKUiAHFaGCuaCTpmlHNuIGR0qS4rWJYJrPh3a7kwrYLAkZtWXCOkAv4ZiQ1HlPll
         Fkdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784779637; x=1785384437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
        b=MGfYmYqKGG+L7OG2JAQ436UcSXS/ESuBqhia7qHaOnVF9nOFoP4ypahkZm+RDlgOcE
         bAclx9Myef9Q3FRZOKsAod6rY4qDpPM7mkz8C47wmmzkyGLuLaJfmkuXmb+TfSLd4zbs
         gsIaaI77wlLiK36R6vlnFCdN9/UgaKvWHd2ndDmGT/bXqw5JEcbODgBM26m2EFCT8Khr
         hSJZJphzGTu6Il6q+JYy0CspawUBcbZQDFudX9Y7qHlF2RwiiS61F47uHIrOWjoncsJb
         IC67AemWqSw1UFzdY8xx3c2xOOgTfmvgXd2OoC9CpMdzl2veSUJuuV2aAkncj7qtvPVN
         WGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784779637; x=1785384437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
        b=i4TGwJuMxGd6DBVSTWuif62KvrUPpkqQE+wsBb/jKFRNBjV1tGy0Jj8tUbfnMD3mXW
         RFO5QVAIJQ0gGnHQTORwcy+/7OoLSqBzaCzHZZ248nO6Zc1LXkeFRs+YKPUgpItkhSS2
         P0Hto9nJ0cpgoHfZhsoKgV2kTt1b4lqoz0+6lz4E6pToHU1OE+m8f3QXRq326VW7VvhQ
         vaACCip151BuVmBcsGOjqpA0yvi36l0q2k+RFM3dTw9/XmRI8Y8ufdIGkyNVAIqe6xse
         IpNiwzVnBhnuObtEmEUop/y+cGGa1vGK+m4PVxgSIbSnlvGYP2t2pBGDHHA8n4Q0X5FM
         xksQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDhE8qf5r6pREo83FYib13nLnJJRMFCq/VRU1lcJh72kFstdyuANhXa6iLBzevOd+oVYEHTEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpI8BnEpI8dkpAiHSelfNGUxHQlMchMlvb5YrewXL3+XqFCIFi
	hmgG43tvW9qoVeN/BgHY7YdxZCGfHSLtdgpjZMmjJ4UCZtX+lGM/xRUEp2DnAUh19lXkyxciicN
	Jhs/rUv6TnwMxHG/8K2nm0CnCL4cMwUAVFUnr47Df
X-Gm-Gg: AR+sD10zTYBAoGcfQx9fmI5B50v2HIYWqN0y6x+UvQ+dS26gi5my2pUP2hUXx/6cZTO
	w/VOoCBII+mvOzJwLYM3Q4fo549iFAghyrm5XtQg/jPwQIPcbap1QKqmJOkFWalGzzXasScOMVe
	+nM/k7pVvmKx08np+ahiE4SIQxsV+17N8hqjTZnPmn0RQH1HRETfT7mKdw7/U8yWCNKkNtX/63x
	NfHOYM8+v+XwhKhQaTrcJr0rZlBPFwfSuYZkAUVQOqJWxlkj+cQWUDY8Rh3+PWfl3/AIrTU/Oy7
	taedNfa1DXQbFRj8Dg==
X-Received: by 2002:ac8:5a45:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-5283b8f3543mr6081881cf.0.1784779636303; Wed, 22 Jul 2026
 21:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721005603.1710551-1-linkl@google.com> <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
In-Reply-To: <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
From: Link Lin <linkl@google.com>
Date: Wed, 22 Jul 2026 21:07:04 -0700
X-Gm-Features: AUfX_mx3uQZpyv5zi_Q9zPvKus9UiXbRlkAo3cxV-vdSjkfxBWwgopwFhNLbarQ
Message-ID: <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
> hm, now where did that come from. I can find no such commit and that's
> the second time this very unusual thing has happened in 30 minutes! I
> wonder what's going on.
>
> I'll use
> 36e66c554b5c ("mm: introduce Reported pages")
> OK?

Yes, that Fixes tag is perfectly OK. I pulled the previous hash from
an internal downstream tree by mistake. Thank you for catching that
and correcting it!

> The bug is very old so I won't fast-track this fix into 7.2-rcX.

Completely understood and agreed.

> AI review pointed at a possible pre-existing use-after-free issue,
> related to virtio-balloon. But I think this is a rephrasing of the
> issue it flagged against your v2 patch.

I actually looked closely at Sashiko's flag, and to my surprise, it is not =
a
rephrasing=E2=80=94it caught a completely separate, valid edge case.

My patch fixes the UAF on the PM suspend/teardown path. However, Sashiko no=
ticed
a UAF on the PM *restore* error path. If virtballoon_restore() fails during
init_vqs(), it aborts without unregistering the page reporting worker. When
system_freezable_wq thaws, the reporting worker wakes up and dereferences t=
he
now-dangling vb->reporting_vq pointer.

Since it's a driver-specific lifecycle bug rather than a core MM workqueue
issue, I will write up a separate follow-up patch to address it in
virtio_balloon.c
shortly.

Thank you again for shepherding this fix into -mm!

Best,
Link
