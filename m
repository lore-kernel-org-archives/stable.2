Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2438B7B4
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570456; cv=pass; b=dwF205Ff7SFVdtecBWzPAToHdfdl/Zp5v85FsMC0M5inuW9dfo6TdeQVnAS45+d1ah1j+zFReBwVWgvnGsWRNlJQUVTZzkEM1pKACWw6a37Ag3mPvFUCYRNmBrpsdh0xzUKOO1SsWa8dV4GPIhMg1hIrWh63JiVUb/gJvV0K20c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570456; c=relaxed/simple;
	bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FibE/uY9FWpeE+2a0PrTkXa+Lzdy8jzO4tHdTqdmOECBETJcF3d18WvF7unEkJ6OMecPCeUrrZh6CtjPpWZVZaEESIeqTy72wTx8zvv6iac3QOzevRO6hlWjNFC7dTL+Gw8UDJn95fe/9CTeK0BZeZL5jvogpHwfddXCRPTS4yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOU7Nbhp; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOU7Nbhp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so609123a12.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787570453; cv=none;
        d=google.com; s=arc-20260327;
        b=DYMhMxSS2Cgmqd95T3DwwkDHaF3OQURMJpx37GiQiXUzFZCAqNtm1J200JKsowaFZy
         cHq0GMhFFhLxeuNyOGyWo+fahJRMVwGKxQf/1nER0M9ccGjop8mDAknQX/ntrbVnwrAX
         e5IufqhOQyFzq47hDZymhFlH1gqYulu2GjPgerQ5NFZ5mh7ukhiBCt/BWtcd9fVcgEme
         m35eu94mWyD9kBvnm57+zhGZZUsF9RyKrAj/CR4D8LnbnTUf2C2el3zqV+6Q9AjKWTrV
         VZcnpR8OZ2UghbTx+FLkHuAkmRw/joh4oPQi9XdPCpVu3wJXgzhuyAxkmf6mrQQ28yb1
         dc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
        fh=EGfZThsPbCKqqghti6eDSzlPt/UGQG4qSM3QWAPcBuk=;
        b=hdobN5Q2R4vxFpfGWvhRfhVhK0hDaTntHQgpM9EHzJmTCykZR/8D/SsilQZaaXtpiu
         kAxQ3Yf6zoHihe0rRVgDn2L8OcBa3/wZ4jf3/5SYIBUjGqj+H6v7wkefeg4LBuA2k3SK
         kurasc922H4vA/7yCIaKoQP/ksDXdu05MdUGcXUavoRnlGQXmm8Usdg0xAWQ5isBVjj9
         csOt99nNwj3eFTD2hDBad9l/9T6lmlJGsV2FzEZxM7T15x0lBgTXs3avyfgciQYeUgb3
         zOKGuJz6xyOO1D8FYVia5ALD1SQDlpJWP9dAHY2G5hlsw78TVb1gHba+jPw/4taL4OMf
         u6TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570453; x=1788175253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
        b=iOU7Nbhprl+ErIRVM0SKVTgNZoV1iGrWBpRu1qvJ9ZBorYKeJeE3SyZSnF9D8reAPa
         LZaj6MK+vNE5VSHfWdDCvWXOu9PmNQ+IfohxpYI+0coxmrCaVReQEnwjwVF+PPAlDOtX
         Ljnxd2ZVuZCpq1sUQEZ81QtFQjmpoljlA9a//h/p6oJhQKPzcvPTrT8jXoEwuNQSqGFK
         j1xvgGO+vIkh3fvCI2GzX185PH49aPLaZyAyWR2y9zTiH2SDtUwGK5O7RtvGjLit+YqB
         J9uCX13rhl4+f6pvqzu8YLI72srqEiZuHG9wjhFVWVjf2Uw8xkd+Dgkswz36aSX594ns
         V/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570453; x=1788175253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
        b=VtZYMTdfkcPEkUs25rJOrUGNSb0nQ1UMa5TQcyMKPQAYr+5MvjLnAqu+LUaY+k0Gp0
         KaPb0XJgGzSYtON2DQRbUFdrKpcQxw7wZPzNgk/Q8Ue4VeRWimLlRB4K178aK7GlS/iG
         UzFq2Zt+NuIzyHSsKICzH6XR8+DiL8mmiJcRZVABfRxexwRzdHXYxA8fYt3YfSv3jiZ0
         uvCaL6gkeQysCkGkLpqBTuQQJL7hyxrc9E6+oqU7JBsxJhvyFmWPJlYmZFfgU815dlRw
         DQc9VEieCwFZRgxf62gbcn9/BDVMPYA+ZbpY861Z5V0UUIsaqySuxmahZaulUR1l6BdT
         fapw==
X-Forwarded-Encrypted: i=1; AHgh+RocdxHAyuO7Wa5KgtiVJddzBBFiSNXyA7/y0Z7pKkkPcqAShYSVImRUqiT66FPDPPJ3Fh6CW8k=@vger.kernel.org
X-Gm-Message-State: AFuF++kC/Pow4RySStcslpoNfyDDi8Z0pDiFxdKV9BPUVE58YABHhxAg
	+FEM13BdDEg62UM08f93hCok4j4DinYqOLeMCilEpXoqJq7YonAVJ9gjtt0Nd6Zg7Uja79V8o/J
	ZzQGKKIGftL4m31zrj6aKuxTuewJniVY=
X-Gm-Gg: AR+sD11JMVzx1BMjD4jjg7TpH18AiHxk1chk0aGnTUW7Ii9kbyM85cd9or3ucFRSEsP
	sWsRlVAEFmTuunOVez//aP6ubSyVmGy5u8cXaLtfa4BmGejCNQO9luFkCLG132nCs432Ue6MjxV
	7y85JlP+RuVPT51iwKn8AAWeZSl3JEQmlH4ltxWwMi3kXY0x9jUW9TvWP7WyEcSkntql4MTMr2N
	1/rjwiwQobuG9S2jpQulrQlNyEroljtfhXBf4WbxqiLnM+CWEjf9H7ooUQL0eVLUjwlFE0RRaWE
	ABn8Ae4qWHVqMo1I06dx/UdEWURnfx0sctsmz98DwFRgqkSYL2QF4SJKG+h7/J4V32zTRZjw6w=
	=
X-Received: by 2002:a05:6402:249c:b0:6a2:9c3:6926 with SMTP id
 4fb4d7f45d1cf-6a42f1bcc81mr14169194a12.1.1787570453192; Mon, 24 Aug 2026
 04:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
 <20260821145908.2829132-1-nicoyip.dev@gmail.com> <20260824075011.GA858321@shredder>
In-Reply-To: <20260824075011.GA858321@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 19:20:42 +0800
X-Gm-Features: AcwNN1UcFXyuU7hL-3GWhAB4rcYKRD0bjXeZfTZl0ULtNilBR6X5re8wwsqhuVM
Message-ID: <CAAo+4rVEbS4qq9_3OxMLMisD80CsZNjwN1ZD-obGQ2rxSy_30w@mail.gmail.com>
Subject: Re: [PATCH net v2] fou: ensure GUE headers have enough headroom
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:50=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> It is up to the caller of ip_tunnel_encap() to make sure that there is
> enough headroom in the packet. Otherwise, what is the point of the
> encap_hlen() callback? Also, adding skb_cow_head() in the build_header()
> callback forces every caller to refresh pointers to skb->head.
>
> There's a WIP patch to fix the same problem in IPv6 [1]. I suggest doing
> something similar in ip_tunnel_xmit() and ip_md_tunnel_xmit(). Note that
> IPv6 reserves the headroom before the encap push, so the snapshot is
> enough there. IPv4 reserves it after, so we also need an skb_cow_head()
> before ip_tunnel_encap().
>
> [1] https://lore.kernel.org/netdev/cover.1786088695.git.petalzu987@gmail.=
com/

Thanks for the guide, I just created a v3 to fix the problem using the
similar way as that ipv6 patch by adjusting the callsite.

Best regards,
Chengfeng
