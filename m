Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D763CFF51
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629512; cv=none; b=MbsHU5mOd1dsH1NKi1QXbOLyapZEqlO49MF0jqQ1CqvRfhKp0JcNaBy29brd6G/mvvsKbnLO074zqiVc63vvTbkxfdT3gZM+LACuSeNUIVU/aaUt28RfzJ5Wz/E11nU4e9PtR/Gl3KOgN6Z8MKALFqvgfCOvg1BYN3dkSE7gpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629512; c=relaxed/simple;
	bh=bEKlKi/+IZFKOLDzrR1dsce/+n64lxtOKI6KSgMbKVU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JJWXwjfJF5fZOHxgspIMmU+t8RwGkI+mz9oiccMdK4PysZRey78oAbz18Iq/i6cPg/nWzA4ePVNiIdVqoR9UuvU/h4//l93SpWRzcoD7973XJKEeSUvIINqWZzNl20visC+EoNiin6rQ+4CguCadshsHdvMhRplK2/GIXkiqcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=QdhLavMT; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="QdhLavMT"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so4122109eec.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790629510; x=1791234310; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SuOpjRo0nMbIZrrhGtIjOTHizEzVqe8lHpeMn+L+x88=;
        b=QdhLavMTqGXU3Z5a8PzskU/taf9cO5W3uXmP6Tk85uhnxI2IO7/A/+G/xtzFSNY5b7
         G+p09D9ClPRzih0/WhdPeYdJoh2EHJfwoiNI2Ubk+DI5dWMSzZiX1tvzpgu/75fhHQlM
         CL3vOYXzE3gveM5qUj2pKSThWL/wThqtI4tebZjSbkGQHL/7l49DMvD/4qx55bWXFpHs
         gQESL/pPuToUSTAxd4hGR5yvVc2DtQn/QtRJ8Rqiy28TwvB6vp/Xcm5twL6ViorZzJxB
         wl1Xot2cGCmuEFDsAKXFbialIf4ExWNTQK9d4D/2WU3+jx+p3Ajrq/zJ2pBHYsenzfaa
         FV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629510; x=1791234310;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SuOpjRo0nMbIZrrhGtIjOTHizEzVqe8lHpeMn+L+x88=;
        b=FxDRYq1pRfhQDVdJD60lkg85KyqEbaNnEyvTbR5r6zMwGCEHdWEXpHC0srlkkbgofB
         sXI7vugS61QPeXPCm7ScTSH8Wlp1rbQ1gowdVKC8XT8Lzj4yWdEEhIOvtZ1/uLZo3D+V
         hjpdejIeMk/c+fyMSidiK+Z6U+sYugyaTAQ0Nz0vvhVbrIQhjkjYDyY7IcsdnNFIhBFI
         2LcYJ3NldooEMyPba1X6DvEabBNGuRITi1DzOFbUGOpE+6SE4EgTOMuVSIdIAoOWfwwk
         ZjtTvsUftmmrIIs4aU8mzGBDQRFjxB6z4TLkGDgcQ56Vj9/14e/Bahfgxe0xd4Jswohj
         TaTw==
X-Forwarded-Encrypted: i=1; AKwUvBxGkiByibFDvAPAMLcWn/IKQEMBGCV0LKKGpEW767cfH8z8NGhmgPdFpv9nw6CNCc2eY4fAXdQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQyBtyGT3X3G9W+ll6tVFXbs2suF82RsqvlwspHWXG4D5G8BSv
	eqTeJ2z5K6sdbLpxZf/EcAMqLzQ/o8RzEvj6++EJJckzENmIVNfmdgFQL50ZEv73yHvKz5kDd6F
	gT1Ikzn8=
X-Gm-Gg: AYBFou2hO3Lc4uxKNcso+hoS+IzfambX6wKTUl3O5oIPueWP/fJ7B5ZNnVo0W9BGXg+
	rWkMz/O6j+S24nOJZp4zxkfO+AOSZGdO8fJ3eMNV9wj8ABt3uRMe8SJa3xrBJhHVNP6HXpAZdSY
	tLdElKrvk6ZkGz9QMRPEmEC2hW8tTVOSNv7c/ZhytZV4CLJkTfaCTMfRZsdtfuBrG/3vik9REhc
	hNB/CERvrKtX6iR4CkrU/bh0B3kpdOQmTR3pnOkWeH4VIqQ5CuEZNNLteD+OVFkbl/k7domaG9P
	6C2wSAcKAIPqmY7TH+cBpmaCvJ45qX9f3z23JbhpQMQlNzJ4tndcc8WcyHGU4wELeJQ9uMIN3Wd
	kJ2Ga6ATX4H7TGYOQpgddFFIzGsEXnagw/NH7t80BuYTo8xium26P2orvxcvfervxw5ULVgmM3G
	6QZ53nLV+YDCR73FMUCw2PbzWhDe0I94s3kDrwulsdsEHae+Ag9mpJI4ac+3WruiijrPLlaXk=
X-Received: by 2002:a05:693c:65d1:b0:34a:e7ba:863c with SMTP id 5a478bee46e88-34ae7ba888bmr853763eec.18.1790629509296;
        Mon, 28 Sep 2026 14:05:09 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3433628f5basm22264934eec.18.2026.09.28.14.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 14:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:05:07 -0700
Message-Id: <DLR96NR3FB79.2NSK3I6JR8RJO@nexthop.ai>
Subject: Re: [PATCH] of/overlay: don't pass the changeset's own id to
 of_overlay_remove()
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Rob Herring" <robh@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Frank Rowand"
 <frowand.list@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko AI" <sashiko-bot@kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260917-b4-of-overlay-remove-all-fix-v1-1-920441cecae2@nexthop.ai> <20260928182658.GA185307-robh@kernel.org>
In-Reply-To: <20260928182658.GA185307-robh@kernel.org>

On Mon Sep 28, 2026 at 11:26 AM PDT, Rob Herring wrote:
> On Thu, Sep 17, 2026 at 07:28:16PM -0700, Abdurrahman Hussain wrote:
>> of_overlay_remove_all() passes &ovcs->id to of_overlay_remove(), which
>> zeroes *ovcs_id once the changeset is reverted, before calling
>> free_overlay_changeset(). Through the aliased pointer that zeroes
>> ovcs->id itself, so free_overlay_changeset()'s "ovcs->id > 0" guard
>> is false and both idr_remove() and list_del() are skipped: the
>> overlay_changeset is kfree()d while still linked in ovcs_list and
>> registered in ovcs_idr.
>>
>> Every overlay removed through of_overlay_remove_all() thus leaves a
>> dangling list node and idr entry behind. The next ovcs_list iteration
>> or idr lookup walks freed memory, and the ids are never returned to
>> the idr. Nothing in-tree calls of_overlay_remove_all() today, but it
>> is the documented API for removing every overlay in one go
>> (Documentation/devicetree/overlay-notes.rst), so any module user hits
>> this deterministically.
>>
>> Pass a local copy of the id, like every other of_overlay_remove()
>> caller does.
>
> If every caller passes a local and updating the value is not needed,
> then we should just update the API to pass the value rather than a
> reference.
>

The value is used, just not by much. of_overlay_remove() zeroes
*ovcs_id only once the changeset is really reverted, and unittest.c
leans on that: overlay_18 injects a pre-remove notifier error and
checks ovcs_id survives the -EXDEV, overlay_19 injects a post-remove
error and checks ovcs_id got zeroed. The return code says the same
thing, so by value I'd drop those two checks and keep the ret ones.

The zeroing is also the double-remove guard, via "if (*ovcs_id =3D=3D 0)
return 0;". lan966x_pci keeps the id in data->ovcs_id and
of_overlay_fdt_apply_kunit() removes from a kunit exit action, so both
would have to clear their own copy or start getting -ENODEV and a
pr_err() on a second call. Easy enough, but it's a behaviour change,
not just a signature change.

> Additionally, if there are no callers we should perhaps just remove the
> API.

No in-tree callers, yes. It's the EXPORT_SYMBOL_GPL(), a paragraph in
overlay-notes.rst and the same paragraph in the zh_CN translation.

If it goes, the bug here is unreachable and the patch is pointless, so:

  1. just remove of_overlay_remove_all() and drop this patch, or
  2. this one-liner first (only piece that can go to stable), then the
     removal, then the by-value conversion.

Which do you want? I'll send 1 unless you think the backport is worth
having.

Abdurrahman
