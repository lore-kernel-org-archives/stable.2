Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5931D7E5C
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675164; cv=pass; b=Qhc4/OLqxSwpgEYKEle+5ByRW+HwbFpoeueo4juChSvHBDs3n229w4lLzdNlU+R6Ads8G8zz3aGIaun7fnvL6hauUy34ApIx0AbKWkQaff7Z69+XmPeGtYzhqJiQzgYBSlKQLtJjrqZKd5mq8kgUQyadViXG6s02sTiUhYx5uSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675164; c=relaxed/simple;
	bh=yDUlUZyOjDuadO25mlevewbZFqk4aFcZYwXrs7HXeXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI4ho0dalVruYJBhqE6vw52d/6PoSr+PRf3/Uj7GoWMTtdLz7qtbgMhQy4fWzTXHOi21hRTWl3oB+T6NshHG0xwoIb7ETQQ4CZTWAA70Bf35RpRg24nrZfxdD6OUHsZ68Fa8KMceSigXP7OfRJ8BuTmErnmIQi4osmpPR0kNoWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyHz0up+; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyHz0up+"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a9cc82ef31so6525891fa.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 16:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791675161; cv=none;
        d=google.com; s=arc-20260327;
        b=gTOykQj63bIQ8jehMUor9vciJ1h2LC3m+HySIJ4qjwlpoTQ0rARE1vV94XiRe9AM4/
         cCYs4EFOohWWDmNr3baRHmQbInTcB3iIt+h1G7m9F7iwPL4DjmclI61Os02h7quYG7cg
         yh8hATXgp7e4J49wiGn5YDDOMlDGVq+fnH5YzNcBQDvtwutVY+VAVddralxql7VZ91yz
         mpSVVNVx+SpcYcGN/Hsasu/ig4/NxrA0E6rcDdmf+hMPiBjTM4bobP+ZgNcc3pkv7Bgh
         yZtBaFZuK0q6pyTDwrTl8UDovluI4gYANaKCLOewVPYEkdJn5gPmKQXnNJEfpmhW5Nu2
         oRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yDUlUZyOjDuadO25mlevewbZFqk4aFcZYwXrs7HXeXA=;
        fh=J7CUlqVcBjV00LTd5vR29mZukVdcRAnigcM/Y0eAvXU=;
        b=sxGh6fgwybf8kIwfXaCuMWF9o30iDuHee7aBE1bSOj0gXqrhDNvEXRRz4fT9D2w6fv
         I3JUOTj/nnQ4edCo2yWLKkbsCRTYUKJkRdkAdlgOayQlB/0HBvNrIL44BI2zvivuqyYi
         YoYAfny9jKP11dvRNOPewSI328eBjQU/tTOULjeT7EkKgmyBF0/AeAbLjarJtyucuHI3
         NXm5AuTvsr9Iegg4jtmn8iwaJY9QeBqP8pj5CjaaKT0jOyoWHM3lFkIMGkqRJt5kcQRF
         XmWyCL7HujgMjR7GcxN1sjhpUITu8m6LJna4DswuzkbvhWP/BQ4mRkKVjZhjHQsWbjdK
         7LdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791675161; x=1792279961; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDUlUZyOjDuadO25mlevewbZFqk4aFcZYwXrs7HXeXA=;
        b=nyHz0up+SSnKNt3TULfv1hrau1k+3LTxtrQbO1lvzoOVgqoy7QKpNBBUOvP+DxWOYs
         1wKRfV62LscPNTsW9858VDdRpyu4BH/+AiBcnZzmwePZqddloB9bJpILa0EDBjW6DkeZ
         w98n3jI/2QdGWubkTNdpBZnggb/pHz05xh/lWNtUs4fq+Eluhf5Na16Z1NATEDUWnsjU
         8lFGtM8t0Jk9Mhqio8+1/FRmJV0ZWwmzzKt4f6WehjYJk5ZBMx727h2fKyByW45EVeo0
         jaAi/OGllP5oHrtbFNa1xfmZB5BxgOCaqIUvSzkqve2uFS7tDq3fJ+7lfssPCVdYepMM
         6JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791675161; x=1792279961;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yDUlUZyOjDuadO25mlevewbZFqk4aFcZYwXrs7HXeXA=;
        b=sbD0WoJEyxv3HggoVT63SOfkFThzZW2dRr55K3ucJW1ylVgFk/rrQComKyW0+/1XY2
         +73AMTMURBR2JB1HDD6LmGw7GA5loeNHbkaIFedgrCc7YjlVcvki9Uw9aJYlqz2wUBX9
         ZBwOFvCfmA8hVPy8B440DqLHPTI2z126yp2yUUOWDondqsDOY5q0AlWuHcBsBfhTHDt8
         SoCk+Gwoew1dpMVQmiGR3MbJbspaPgm0K1QoqA2K+h1XwOKnJWfBb9yhAsZ4us5etvNk
         Wlywvnr3IxzW/C5sI/113igTRu38UNLRX0L7Q0KXyE3SVTJkiF/O9skmxbr+vH2AdkXe
         IGqA==
X-Forwarded-Encrypted: i=1; AKwUvBxIFIpx0XvQvmYeHkPXzjWfTXMlXzk6+xHu62wk+XTw8BNUeiYY0+Zgwfz117fZ9zzOXQ5YfiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdgfkNY9FfJroRWSNWvyxgXh7N8so/jVxI4I/HvzQPRDLW7c9X
	q3Ve5Kh3ziaoQYz1bA2pQNpt6t3Tlzn9+E2PXBg3ovWLQGcEi2iYEif+RyrM87eY94TrdLaV5XW
	9LjwgJb9D1nS8ykLIPcPemBzkwbbp1lfWJJq1d1M=
X-Gm-Gg: AYBFou1+5G6Z24LZS1fl6arF7oHx5kkI2whdQCdKTeyFiJzSYsuSQHOtAM7vn3tvRO8
	A53qwrrjt88t76L+q9/1Bygqp9uhjdX5TkTHxjbE0EnTVc74na3cRHvikTM4x3oCRJtc2Gk/SHx
	ybNoE5k5/5/LcAniLkdczEP2LqfPJFzUzli7UKaIs2v/wHuxIw3ayi623Z7iG4JQfgsmltuzbDX
	a8fSexCBiSqOGB/nZd2Pp0xa+gBigdVbH5pKGvPa7xPx/aGLXqo0mgq+hZMWwJlxFMvgsrkVGFm
	Lq609F544KZBVyx9I1efBBfBMK/TH3GNILrG9YLwRfKlMH8Mr6rADaPOeVWNKMowgDcVYnBGMBJ
	qsR88jMzdnxVgqTwyyRXkY/3y7XFMY5ug5tPmi+w/S5wi8mTZw/70h+cRP/Ez6vB3t8QXfjY=
X-Received: by 2002:a2e:bc23:0:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3a9c5384f54mr12392801fa.16.1791675160999; Sat, 10 Oct 2026
 16:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142533.974797-1-linmag7@gmail.com> <20261010142533.974797-3-linmag7@gmail.com>
In-Reply-To: <20261010142533.974797-3-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 10 Oct 2026 19:32:29 -0400
X-Gm-Features: AclHuK-gvxmspYL8uhJeKZU4XuFs3ltc1WsM9uJrh1XP9y6npltcI5XIXewgq5A
Message-ID: <CAEdQ38Ep+cu5ssTGtb5OQwHGRB5wz+crTfbV9GM6wVDdoZqfmQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 10, 2026 at 04:24:28PM +0200, Magnus Lindholm wrote:
> code following alpha_switch_to(). New kernel threads take the same
> path through schedule_tail().
>
> asn_lock is left set on that CPU, so the new task can run with

I missed this in v4. New kernel threads do take that path, but
context_switch() does not call switch_mm() for a task without an mm, so
they never set asn_lock in the first place. Only a new user task leaves
it set. As written, the two paragraphs read as if both do.

Changelog only, and not worth a v6. My Reviewed-by stands.
