Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBB45D930
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730142; cv=pass; b=bkAYK+vj+bqjFcrEh/gdk9oPkRrVORB1Czsw+m162hKNTQceskXIDsc3/0luuDBaKjJ2B6W8i6h1Jvnysw5pqMZHT2gNbaa66XO54sgFZDFU8dX0sAXkbHbsRvwlaO9FduSQkMQ3TgyLGTUZy6MEbGta6HV1T6LrFoOgFqb8TXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730142; c=relaxed/simple;
	bh=N7/bXLCxSKzME25oFTCMjTUc1fspZktULBquef1LNnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCZA1lDD6S/mvLMyciLxy/h01UfpmZXmhFu3F61iWYrr4tKLyAuZAlMd6oSjsCRCE7dn/zOyWrDIBQ4vEhuT0HziIzXVrAdUrUiMlgaxk5jNjR3Q8yEcO3CeGno2mbeW/LLvAisF4hX3jQ1/Cunfb2w/8Vwca5bE7Xb0CRMfE3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSIm+ZuW; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSIm+ZuW"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e36c3478aso148816566b.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791730139; cv=none;
        d=google.com; s=arc-20260327;
        b=m9GPmyosF+ohGIXfjVWM9C0bAVA1/7aq18EmHwJafxAjsMv0kEU4k48EKfH8B2K/HD
         mOvxMKhUSXUEglT0Md5XetrtaVfasiEBbYLyzu+ZwvSt/sHJ13zZgccXMocd53vHDu64
         eQZLd8gwYcUbAZhqHHy8O/Miq8zSMKoT8DlNCLAjYGgex2WDNYHe/TLZzu6h/57ZvXWu
         hXamD5tGPS5TmyKlyAv9QvvuX+yMbGmboSzz5V/RocTJ1slVaT4JgIEoJBtwwDJyTK7j
         yJTpVQmD9UvBQqzuSDb3zYXYGatKTbNJCdlCGqXxue1Z0Wja7ovEp8bwYrOmuCyG+5Px
         AZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4RkeVc6VkMZ4IMU3dg0M5Mik1yz8UTsHowUxZB7vFDA=;
        fh=hKfaHPL8+YoCotrJzJf2YRYIUUCQAD1zLzNYmvgrozU=;
        b=O7cZ+rzUgl1QYCmCqveCT8i2DB+WSWr87DIDtOqLMjrmK8XBZX3PvPEb5ilbx3eOjt
         349pe32v6vjegO+ol69+aXLJEZK2DsErjsTWImvEb0pb2e7+sHj+ppQ2HqSX8ktUmaq9
         uMr1cL31Ghue8BimKCeBaRfG81jY9+AENC9gI0W2QvAvwqJsvtxCH2CFUBcKeHm0rAeg
         AjZ7n/26wcuoh75Ov0IAMHccC5W7hYD76q1EsqEIBGkstkFhyxlETwNTm1qWTmMll89S
         /gD3gf6Ir6swe1Kt5sdRLzeIGzOB1T95Oqbni+idtAuv+5cicl4Olump+gF08/WTrj2d
         DYvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791730139; x=1792334939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RkeVc6VkMZ4IMU3dg0M5Mik1yz8UTsHowUxZB7vFDA=;
        b=hSIm+ZuWJ7GvatqAO/yMWyqLsatlGbn3H3lVNLELHW1jNqe4Qt6PO6vaMgr5MEo7WZ
         bRa4YmFE4fzg7YXJ3AapJS5ZUdIa+LPo8VchpWjdODvbwsvBOnyov9XxlxPvr6l8Vd8r
         UTWN5TQamHBanlyeH/pu6RIffAJKQ+q58OSM0hOsStmMFWkBOzBSbkILb3TQY1b6Dzq6
         c+QEe+euvby3jUReoMel9pBiTAPMcFqCIWD6T2W6kEx0L8WM35+VWMOfNECWhuB5Zrzv
         7ts96nV0xqeRGonK+9PX1crZWfjJLf0UsAvWpjPT7TDyKz0fTO0d6aNCrYlDbN3lyZsW
         181g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791730139; x=1792334939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RkeVc6VkMZ4IMU3dg0M5Mik1yz8UTsHowUxZB7vFDA=;
        b=dr55PDoMFBprAlQcFsiBA9Oh/BkX5TJ3aJZBj7O0gFnw775M8CNZW1crFZdsGRbZUk
         LdoBvZBOOdJvaFccpx6DUXflJ8fqTArTz+PgVljZAv87fU+Dyg1dhAJ3wlFuEiO1FcAw
         6SuhITcl8ujUvJCkZKEnPBa6yO9EfCwEtOcViMEbgRYevgPkAChxVeQ2oXYTiC2gbCzY
         yMV45hLqKtASpGe2m9cW6AF2UQp73s181Mky/EkEDSZB70ymSanD8nubyJlkDam76w3N
         XYvulqyROp/LOgNLChz481jE5/BfEopQ08B7N96ePp4mfJUl8MBnHyQfIaSJH/5vhkfh
         o/cg==
X-Forwarded-Encrypted: i=1; AKwUvBw6e7/B9raeOmkT5fNw7bYowl5H6e16pZYbBZD2qH6gVEKAutwz0b2CzwkgRvDa6d3me7VQCtk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpoKMGnHeXF3BiSozGE3hVTrDjBItSBdyfXvbMMcy+52012ypa
	i+6Hgs7V2gY9W9W0v0ocvajA66DakMxRvgnLaKl2yDMO0V4XpFlljBTOLfsZFACKEERGBkL5IKb
	7tXnOjQnFx6uLmRvWjJwEahc+7hg/HMOpXKf702Q=
X-Gm-Gg: AYBFou1ZZqxcGrk9AM9ooDz0HrwEEFVxG9omA6M+cA6qbhiUiYZdNhT13zGA/binQJk
	epko5nvjke5x2+g9AXK/ytRYcNsNLKnqduDxDWMmDjliLESGjxZIEflXurEbwKB0BpitfflxW0f
	lfPYFc7YlvDqU2EYidKPsDSq/3Fl6lmR+Bth4xWVgUxiD7u0Cch5L0FIagYKn/2MXI25IfNNPif
	GiW0oS6LDAELElY2cQhH4atQdJZEE3/hbCpoBhBVWZY5YdpN0Szqie3Enx2k7ZReEFtAwH8SZAM
	dC/iZB65XL2ZZXE1BcPfKVOzZ9yM95Rg+xRP5Cwyf5NZyT77uVOcD0W0zmqEN/8ZKRQpjgMa01O
	ZsHxJO/xnP39O4HzO3cTsByDBZ1Oxa7X/pHJWB3KPFAk=
X-Received: by 2002:a17:906:f59f:b0:c31:7495:e57 with SMTP id
 a640c23a62f3a-c31aa0dc6b5mr668779566b.44.1791730139254; Sun, 11 Oct 2026
 07:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142533.974797-1-linmag7@gmail.com> <20261010142533.974797-2-linmag7@gmail.com>
 <CAEdQ38GtjhbEipnuTbo1EmzNNAE9=6p3T6MfTnMq-6okmE9-tQ@mail.gmail.com>
In-Reply-To: <CAEdQ38GtjhbEipnuTbo1EmzNNAE9=6p3T6MfTnMq-6okmE9-tQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 11 Oct 2026 16:48:46 +0200
X-Gm-Features: AclHuK_Tz9vD-0GaHu-Hko6cZBr-CRRYjqry0SEF8pHQaIVGQ0ve8CeJLxTsgbU
Message-ID: <CA+=Fv5RTAXFbGTN+YPb3RBsw2s-52oVRzi_HgMuiB4R86YeY5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] alpha: load the MMU context when switch_mm()
 switches the current task
To: Matt Turner <mattst88@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sun, Oct 11, 2026 at 1:32=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Sat, Oct 10, 2026 at 04:24:27PM +0200, Magnus Lindholm wrote:
> > do_shoot_lazy_tlb(), which switches to init_mm from an IPI. None explic=
itly
> > loads the context, so the task can carry on running
> > under whatever was loaded before while current->mm says otherwise.
>
> Two small things if you touch this changelog again when applying,
> neither worth a v6.
>
> The second line above is short.
>
> "while current->mm says otherwise" only describes kthread_use_mm(). The
> other two callers change active_mm and leave current->mm NULL.
>
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > Tested-by: Matt Turner <mattst88@gmail.com>
> > Reviewed-by: Matt Turner <mattst88@gmail.com>
>
> Your Signed-off-by is last on patches 2-8 and first here.

Thanks, I've reworded the changelog in for-next to distinguish
kthread_use_mm(), which changes current->mm, from the other two callers,
which change active_mm while leaving current->mm NULL. I've also fixed
the line wrapping. There are no code changes for this patch.

The combined TLB v5 and MMU v4 stack has now also completed an extended
SMP compaction soak on the ES40, with three CPUs online and
CONFIG_COMPACTION=3Dy.

Over an hour, all 23 cycles passed:
  - 207 lost-store rounds
  - 207 stale-read rounds
  - 230 shared-mapping writeback rounds on ext4

Compaction was triggered repeatedly during each cycle, and
pgmigrate_success increased by 193374. Continuous kernel logging showed
no new warnings or errors, only the expected drop_caches notices from
the writeback test. The writeback settings were restored and checked
after every cycle.

Thanks,
Magnus
