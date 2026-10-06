Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F83B83E1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272944; cv=pass; b=AQQiMPCrz+gSPjXF6h95lCYeybwchjWpwhdCFMxxbWi+VZElvK5veF0daViaKum/a0MxnNMQGTk3o3hNvyPajulNNPxwNKWA7tg2E5W9EaD56dlB2ycm5y6mGhZ74+XH+5PxrijR6czsinScxMKm0wS8o9slIrD0fO0SV792Lsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272944; c=relaxed/simple;
	bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyz8vvWNsARSwVgx1ok0C+jZlDQUGStENkQVC4qBQtLqiXi+Skee9F16FMkEotxPQuwlFHxadgc2BLVp1uBLBBdaSN9CALkoetVU9Ids1CkU4r44XVO5lIkvFE+Goy7u+LD8OMQBijxJpvR6I/BoTqt3lWJ9QFfN8D6yQrRYVRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=0h1G0AaA; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="0h1G0AaA"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c315a445752so29304466b.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 00:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791272940; cv=none;
        d=google.com; s=arc-20260327;
        b=Rv1C47A0mIFGzxehrFhDUjajTViRFqEmnauYWUSjlBK2FCLbV9/gpp2TArbcMDPb47
         RVpuesf1q8jmaG9Q1a5CWm6GdpzxR1yuUIno/2piUT6HZSarqe+Uwpgrpfct0Ro+Dqgz
         H8UaKB6Vs/rSnO810q7cewR0VqVCx0JR3KAsLPwhMl9xq469k9OU0Qml9U/3QMdO//qU
         jDtH+tdolvbjR20pGB8NMqqBgk+yZ66Q3jRTBqILkWU4ZQCjN5dwj1iIlctl5DMv9HxN
         4E5eAslyY2AFtnrAACAqcnA6mzVu43amaFp8L3AnrZZ1lUO1w7hLwdsTyTA2AVPEGya5
         DBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        fh=ATu3cwR1npPLt3LYg89mnbwyeBQYd6L9QB9f2GVk1qY=;
        b=CKG8mLVtjxF539urjIp6fpHb5dsISeC5nT2aKDZWutpwn2MiEaSV1yb70q/UQvuR35
         ThIcCQCy7rAc4V27IoE6gLLsYtlyto+LhFkh4M+IwhfmPWsBseWWF9wxdpPVzElRbY91
         X2NUVw3xO5mrtOU+2UWm7wqKVOqzbpk+39OfmDC4wCL3aNIp19ZJEZwtswpilHpNhtf2
         47I63xQ9UlW7R6A796EFVy2WroWjGulIVWQZhD+aWcNZj04qQ9ku7sQoRRcntPhlPb/r
         AidPmXas9YuNcxhuMOerabECp8/PM+m3pAb8Kq2DgPrvHzUIb8huDYwAy954Inp3abwf
         t40g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791272940; x=1791877740; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        b=0h1G0AaAq7RVxRVXfAbwaro/2HDV3FBWvJwzCLiCJTkXK+nX0hpeF1kv54Zkee2J70
         jzyNBFUoDFtbk3WY3Ef3nv9Ah1O3Lv6b8MV3jN/IJIzjY5D45Lan/BusKUJTr5an527K
         Czaeoz8jeAZrj/av5D/iSi1bghFPAK+7ccFCPizsaLbZYEcCmEXTIbPIv1xekJikSofN
         sPt8HqYgBpe6mwo5h8F5FIB5f96PKijy1IsnHdq8QGjj1nEYePbw0RcgJA7E8MKp3nXs
         Gkp/iy4l172Wwu43y3W56heqGWtSBKTyFFAZ3r+XTjdclWsDfWWdIaoedJqpHNYfIcDi
         i9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272940; x=1791877740;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        b=J5BVooIQKG/7Bav0GblVIYxwdUA3345uRB3U4BsvRd1VdPxqQFKdg9kgXDeFoGsuyo
         zKdQvkZrQwXnGNjIEz6rFfuowbe9NoSscU1smB30XnfN1b4r7Dxv3grJ6qJLzDu5blvo
         o+6aZBDGfUUf2rL9b8wgfg8GwbihoXm2eqrkleBuSTrYONR2N/90jUXBLgCDhD2Yr8hK
         P0G3mcrcmaBfNuQPWIhOdFrHufsvwXg1wrAByCUXpp7LKCnnHD4QRyuU4l9uCnXlQQwh
         hr6qswUXy80OgNPC8ib1r+FAllVwkBCmiLw1Ydd0vtFJ3e/sifjAMEBTs+OsoxaAmAen
         TA1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwilnvzYtZEY3w9llmrMBuFrECPQHsGnmelngqZdB55zWKP9Wdg2Sb6MCgpvsqBbLlNH+SWAbg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIjOqMuYMntZAbtavAQoUtGkhPIKn4lQLS6rJVJs+QGroNk2PW
	gl+8TqQ6FtnYZF+8MEOPqhHfl0btENA0eegtPSCAoKxnMMwxnrSynUpuy3nqlaIvfRtgtdUvQEO
	MvENsB+g9FtDZTzR+075DG+M5cMkaFLuEsabykSgevg==
X-Gm-Gg: AYBFou25gpQnYjy0oc3FBGz+YE4Xy/f0IwqJllChVOZuwpq0TNKZJaEJFdq8VdWzsOx
	sVlr6CI5jQtfn4D9t6cZiPXXdYAwvyhyh0FMEvuUVpY2hUpehibBuf3rjHGNCRhHFmcTGgU8ccq
	t8ExZpCE/UtpC3Ktxys5PxybAK9p7TbfGMhC6TPmmCcHiV74doQ1ooCS+Tb0UDOP8Z8IMOrSxZN
	1ULf2xOzF+pOPfL8XRzP0y4UVnRnXfRNjn/LWue2ZAPp2Qg/z9+YXKtCmwKPBGlmNEe4vBcX0Tr
	NylTyUBrCyY52gjBkRxzN86OIRLruUXamrqC0Y7MbvOgPGq00K+bq1Pn5WU=
X-Received: by 2002:a05:6402:1907:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6afe290339fmr597357a12.3.1791272940042; Tue, 06 Oct 2026
 00:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 6 Oct 2026 09:48:48 +0200
X-Gm-Features: AclHuK93qFWTt0rPdrolX-1FvRtK-xCdn7iYpv4S1vx0jkfxOiNyhJFdse2ACcs
Message-ID: <CADGDV=V5NJViqSKS0JpFrm1U_2pGRBf1iE30hn+yuR7NmN9iXQ@mail.gmail.com>
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a
 compressed bitmap
To: yhlee@isslab.korea.ac.kr
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
	axboe@kernel.dk, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 06, 2026 at 03:57 UTC, Yehyeong Lee wrote:
> recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
> accumulates the bit position s across the runs. The upper bound
> (e >= c->bm_bits) is only checked in the branch taken for a set-bits
> (toggle) run, so a clear run advances s with no check at all.

Thanks for the report and the analysis, this is correct.

> + if (s > c->bm_bits) {
> + drbd_err(peer_device, "bitmap overflow (s:%lu) while decoding bm RLE packet\n", s);
> + return -EIO;
> + }

Checking only after the loop is not sufficient, though. A single VLI
code decodes to a run length of up to 2^56 + some, and one compressed
bitmap packet can carry a few hundred such codes.

Please check every run right after decoding it, before s is advanced:

if (rl > c->bm_bits - s) {
drbd_err(...);
return -EIO;
}

That keeps s <= c->bm_bits throughout, so neither s nor e can wrap,
and since rl >= 1 it also implies e < c->bm_bits for set runs.

Could you send a v2 along those lines?

Best regards,
Philipp
