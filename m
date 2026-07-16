Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF23290B9
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170917; cv=pass; b=dOff7xhDRsxVslrR0SKhUoRVc0PijaGa3aMOQXH7uHS7gogTiphp5kHMn6mYCdrR3PB3IiYuJQckJs7HzGR0msKAQFJbcUDd2XLkeOufrftN9o5XYRfhbYR0dSqMVf38RzmDVndJV2ypsgkXMerSs+z0lrHiEAslZwRCLkPQ0+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170917; c=relaxed/simple;
	bh=Q/O4O+Tb8F2DDC2Bde3ADmEp8EWDMN/oIqjeQQ3lkag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiStbr3WVx71PCIWAFnkp83zL/R8lfF/4hA+o57wtZx5rJggYW8939tzeJnJvhcTlEptq6i9VOOBSCw07eNFLFhK08RcFYLPDY5tkTKa1Z1jBGeyYQLULwbjKV31HRLb2WFxjVvzOrmRSYU9t4wDbeR/FOh2h/iTaTz6iQrE2O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhlkIEZn; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhlkIEZn"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a818fc4so49723221cf.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784170904; cv=none;
        d=google.com; s=arc-20260327;
        b=NIv6qecgwwVwkCnnE0FJCMSgLUDVqg/jszLvdDaqy5HNc2JD26lPcnVqO8Uxt1hT32
         SZGTqfz1a8edfgNQXVLT76CihlQ6Kt9+RsDA8+DyXLsuB2/WsAJw3+tgHVtjWrtBGB4/
         cvQiCotcYHjNgotSlQnsYhzCf0ewJeZdPslMM8isSEMP45Eimcf4RwiHMSqujbjjnOoN
         5xNtE1vJXN47KGzYnib3aBrvTytRln21fPOoR7wl03GI6U49Sro2Vq/gW91vd515VfHh
         XZ7wqUqPqqkHalqboN9L2h3tLibPybanohdh/UUVpNEM3hOxCeoQyaf4JdOmOo3zYki9
         8ReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/O4O+Tb8F2DDC2Bde3ADmEp8EWDMN/oIqjeQQ3lkag=;
        fh=p4keEl7w1yPvQ5E/KZ3N3XEFBGvG+DmrbH8V8TyBYYY=;
        b=MDGIcpqB63TMAWtrOBvLCFMugLV0i3rmFJiLWv0GG/a0Xm4UsqxEvmW8I2pHQoqt2m
         yGbBpBt26rKtwNDPe9DmjxApTcCq4WvofZosSwOOOc0PFhbJ8vs5BD4pIAUUSZweqnPo
         XDC+Arjfwt39BFKK59S9aatPy9dmSlI8Mknh2g3Eo0NkGe6kxXpX555FvdwhAIDnVTbN
         kVuMmhLX6MLjrqbq7ctP2ZSnJDzUlap3FVjly3rWEjf0qL1L8I6Bbqjb+7jcl1yljkOl
         GCvIW9xu2fHOXgHBJJAzGcu0ffDJzlOmMf8VrikshLudwTGHEX4jm8xuNCkQS6LuOIol
         y+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784170904; x=1784775704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/O4O+Tb8F2DDC2Bde3ADmEp8EWDMN/oIqjeQQ3lkag=;
        b=jhlkIEZnAlpZaMdEbHiqp1ny958zleda9n2i4v6d1LMtpZBHD/qtIjKXzr4YE/cWyS
         ++jzxgTV0KStgWy2glXJ8tC6ZZp701MTH15AKW5Eo7kqJOzTvl3KrPox0tR+6sLrJQts
         beQovZqJvimvs5WczyYnoJGpp6/bVoRK1wreHzBh268K3wSNG7OC9Vn4359pSI5DItv6
         3zrvPfixVaDb+4YQKt3DnkLIHGxXhKgkSgtV/xQ1oAjCPJYH+3DO5zXw8e3hR+cvsCQe
         076zsPPwketyvbleWfoQcsXHxYR6f8mqP/twzCdi8WQ7dD/8PQD7iw8gzA9V6OQg5n5C
         3UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170904; x=1784775704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/O4O+Tb8F2DDC2Bde3ADmEp8EWDMN/oIqjeQQ3lkag=;
        b=cbwWC6Oh4a+01YV27O/+uJSKAYzE3yWL5NMJpkEahQFOPDrrZGWpSNGaKU6g1xgMn0
         zz2V4zLD/0a1Kd1LJtYYRRuW5JDfGr3fEpTbBxt6Cbgmgvna7ih5xGvLXnrLtxakh/Af
         4PmMX3uvmr8qgVqHX+8rQsKp5Yxht8ThKNhu1EOULJOVRcqFjVOB9kLAzRJgSbcpGpLk
         Q+aLSTqTRaRAPMEtwmFOMpwxCF74qCZMUg2ThOrjDy1O+UrI8rA9vPZIlcgt2pNZJCcs
         HqR0WgPJee7tHP/E5OocOvpLBI/cCoELYwyCzzHNdf3/DExR87O6fKcVyioC/iSNqAiT
         erWA==
X-Forwarded-Encrypted: i=1; AHgh+RqfIECf38o9Y1o+r1veW5WSVJ9qaRyBFR2yV1GfsLqp+x8gDmQqRonT4OkGDdDKiZY4LICsJ/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Re9ACwkrCJ75ZIqdgoQSvvPPiMWS3ZBSyhDTeCsrQilC5Hsl
	qBqm3Lj9qjl6rzamULvfFOW/tQSvg3xULYtILB6v6GkoyWMORjylSwRb94Mgq9A59Vz2L+CvpUH
	wBAtDhoPJJ6i6dhjRJboI5u0oV9iX12Y=
X-Gm-Gg: AfdE7clkCeVL7T2ZNdR0ErOpk+dOb0sBHlKNZbo84jQ2kEJjBfbIPfVllvP6TSmmG1x
	2zGx6hWsft4Hs5nRIZB9hltQJC3NG9FKKJdgph55Ed6Yz1umglw/+0dK9MHH6gFo7/tHwTeQbkh
	4CxI1KgBcEY0vOlZfz3A5VKliZZ4KGXzSg0Srri72pdFDbP+3yIkkyDvE01ZykAwwS8T2LAXiXW
	94K7Z3vVAynA5ks+oCcwgjod4LnPpvAnjYuCyF0AuXWVuCFGJPL3cmc0n5w
X-Received: by 2002:a05:622a:164f:b0:51c:7b12:600b with SMTP id
 d75a77b69052e-51e4f267a68mr59945471cf.87.1784170903664; Wed, 15 Jul 2026
 20:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712022618.1665-2-muhammetkaankilinc@gmail.com> <20260712105304.agent5-0003@kernel.org>
In-Reply-To: <20260712105304.agent5-0003@kernel.org>
From: =?UTF-8?B?TXVoYW1tZXQgS2FhbiBLxLFsxLFuw6c=?= <muhammetkaankilinc@gmail.com>
Date: Thu, 16 Jul 2026 06:01:31 +0300
X-Gm-Features: AUfX_mzU6TMIogSxrDNTuEjEZLGeqckoVjCgv3nE2wt3_4DMq_EgOyFxiJulKcw
Message-ID: <CAAGBmJFRQ7VgYbTXrhO3=M5tH4mcX=abVEjhNEgQSfXPkga-Qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] crypto: algif_skcipher - snapshot IV for async
 skcipher requests
To: Sasha Levin <sashal@kernel.org>
Cc: herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Sasha - you were right, and I confirmed it on a running kernel:
with the v2 snapshot, two 16-byte MSG_MORE chunks over separate
io_submit() calls produce a wrong second chunk on ctr(aes), cbc(aes) and
both cryptd() variants. statesize =3D=3D 0 means skcipher_noexport() carrie=
s
nothing, so the chaining rides on the req->iv writeback that the snapshot
redirects into memory af_alg_free_resources() frees.

v3 forces the operation synchronous instead. The result matches
mainline's crypto/algif_skcipher.c as it stands today, down to the same
now-dead -EIOCBQUEUED check. Sent to stable, since fcc77d33a34c never
reached 7.1.y and all seven supported trees are still affected:

https://lore.kernel.org/linux-crypto/20260716025838.2672-1-muhammetkaankili=
nc@gmail.com/

Kaan


On Sun, Jul 12, 2026 at 11:27=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> > MSG_MORE chunked chaining is unaffected: it is carried by ctx->state vi=
a
> > crypto_skcipher_export()/import(), independent of the IV snapshot.
>
> This isn't true for cbc/ctr: their statesize is 0, so export/import carry
> nothing. The chained IV propagates only through the req->iv writeback, wh=
ich
> this patch redirects into the freed snapshot - AIO + MSG_MORE cbc/ctr sil=
ently
> produces wrong output.
>
> --
> Thanks,
> Sasha
