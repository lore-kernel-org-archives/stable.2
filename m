Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3D303A04
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705994; cv=none; b=mBKL4+j+GCx5IFKqJ1iZsdx/X+YmGMol9e0olTEpE+4EAfbZ2/2nd9Zr8+5ID7L7p+YjbC5ndjx+xR30CuHnexh/pW8fbA+L6wBmvGRSKS+EJ3cC+9FzzMCbP5U84oRchSzJC38Gk7Fkr/yKMDAdxTBd+TDd/P3nG2CxJnq2GxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705994; c=relaxed/simple;
	bh=BHaT52wstLR5JIyPVlpC0s9xU0VwLxcHNvb2KCQJXKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4pzimddOPXdbo9GXfYtO8oPrMFJedv9W3CQRNqp7WUBrD7w9WGAW8Enrd6BT9tW/vxFgEqX7e4QeW+90TGrd4HOGZlgmy6jHOvPtIgA0RKSCdGUjCCo/+st+99xbnyKGmPATsisCXdTmnTsxXJxW9KnLQSDDezlprmmgm1HOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDpA6hXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDpA6hXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E085A1F00A3F
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785705991;
	bh=8AWKY2/647Z/rBpzq6WyGtvFnqnH6on/zVbW7HtZYzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EDpA6hXBhy1BGpVNcgUGcwZ6AcJ9hY1uzkAGiw7W3ViDkE3qm10nJZugT1Fy4EwrJ
	 ysmQUM65dFD1+rs8iHc/zbhkXnwnOGUNUWfuzocrxOqa2YssQYZi3sEC7IVbvpGuGS
	 Nt6u3roC7Tr/kAdtkiPjQ/iVqJpEdCgWF0lWo34pLtKWj8Dz/T3SU4eKID+yUpQ69j
	 ACA39N7DuxJCGy6M7JczhPHG0tSPuIHp5MMjEQuBochX27RDrbyN4YY9hXC/XOZl0U
	 DB5jVC8veXDEqE90V4A2fvZbl9LNGLPwXaJ2bk74o4C6u7f0if+ielGNudBXvw32c7
	 g+1w6e5PHXjOA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39f75e1e9d9so19025201fa.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 14:26:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp236xZX4J0E2KScCKAlbi6MSe2cnOwpC8D3ewcGHnma33+pZ8Zr3+fgO52bw4hHeEPxSoYSZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuRNppdTU8wP+KZMhvF8PHjNFx4KFLtMqNC97NRMwOSiHO3eu
	0sxs7oVhoS6DuJ76AkciXKWBMgpLG6tF6s037R6J7AC2TkJgjzeksbGjXjbYJ7H/zucvfi62bGN
	6EqI+8/FeyhLJufjCPI3V3YrH2fWXvIA=
X-Received: by 2002:a2e:a806:0:b0:39c:6928:9b6e with SMTP id
 38308e7fff4ca-39f86426f57mr14557451fa.29.1785705990676; Sun, 02 Aug 2026
 14:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802020316.417757-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260802020316.417757-1-fanwu01@zju.edu.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 2 Aug 2026 23:26:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLn3whP6JkQ7gViR=wQKOUxH7h2QYt2du5k=1Eu9u-LdWA@mail.gmail.com>
X-Gm-Features: AUfX_mxy2qMHeCMO7AUGRkbFhoC74VYLbN9_1A4hf1P7vPfBRPHQMFjKQ4-OFgQ
Message-ID: <CAD++jLn3whP6JkQ7gViR=wQKOUxH7h2QYt2du5k=1Eu9u-LdWA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500_fg: fix use-after-free on remove
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, arun.murthy@stericsson.com, 
	anton.vorontsov@linaro.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 4:04=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:

> ab8500_fg_remove() destroys the driver workqueue while the threaded
> interrupt handlers are still armed; they are devm-managed and freed
> only after ->remove() returns, so a handler that fires in that
> window queues work on the freed workqueue.
>
> Tear the workqueue down through devm instead, registering its cleanup
> after the power supply and before the interrupt requests.  devm then
> frees the interrupts first, so the handlers can no longer queue work,
> before disabling the delayed and plain work items and destroying the
> workqueue.  Disabling the items, rather than cancelling them, keeps
> them disabled so no producer (including the power-supply
> external_power_changed callback) can requeue them.
>
> Found by an in-house static analysis tool.
>
> Fixes: 13151631b5bd ("ab8500-fg: A8500 fuel gauge driver")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Neat, I like it!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
