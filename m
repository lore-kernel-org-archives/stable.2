Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EF2D061D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448752; cv=none; b=Yp/6+fhupLLqHLAUGVbMzf8bTmd4U+xig6C3Fia1LIXXfV2L6nMqDBibji6l3tOg+KyPzqSsCrRUziUuP7cAfiP4ZwH1Gs9kisL7U/eTnJt8y87dco1Vo/RgDjsvHtiYDofOIvjgI2UquLAnRmVtJnJATmukO0EoKYwYYPa5ji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448752; c=relaxed/simple;
	bh=u4ZwvdtqyKkvqfZ4xOXnUQfX+M6r5bs1mqg9vWH4izY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltF4wQI0g3ucEHAoITaeTsiSWxUjKVSf6pTLWnPzpFWh4+p+GXCo32ViM9CaQFaQgipa4LpbnjlqmG4VUCIpDnp7W8DmnC3xZU6vmYL3aEtewsTR7JkPdQ5vd17U7kjQGZI75QuEcWpaRvHIm5lvoawDnif2PhvCcnv9jUK2sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vb/IqGD9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vb/IqGD9"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5176fab2badso8219401cf.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448750; x=1781053550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nF9EObNDEmryj31PflampZ0Pq/iKEgkudnP3BX3S/AU=;
        b=Vb/IqGD9/62/BIaKGrIR97P2I/GXAC662Sggs9S78HDf0fobGJc2/vEkpLplHqBWoB
         xCMzsdzLXXiBVsPblWOR5W/XfIElIfei8vaUSCFIsr90zkcd6jtLr1h70i5l4t2J7DAT
         4O4xbWrrfMMfI1vU0fpwMLEzojfBK1DmxbFeoPvJQ/fa40QsQuYk4h9oaLj/G7Bn1/Fn
         06XMVTzgL9VgtH37FyPgDXp223hu5PfyqJyVlZc7H3JTfQKt1oX2vRbADp1F7/ZJEQ9f
         2SeskE4cOCA7RZ9toCEx8LE7BnROL8gXECEbv41grH/51KjrRrnYeaoy41DPHV1CcoZm
         LZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448750; x=1781053550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF9EObNDEmryj31PflampZ0Pq/iKEgkudnP3BX3S/AU=;
        b=PqZj3avmb7bNP+jlsl06nwpB7BeyUklWPt+BuDB3qASkTHxCxloRlQ+xg8jWrLUupP
         t9psUH52Ex3aDK5pJBNptFdhvuey2Ayb4Klh7ziBsyNPoLh4Sxq0sPZxTCsiBbrnHHFv
         AOsX6m6Z8MOZSlesRk5iQxiShoCttws4YwDa2MFuy7TY0jo0JGM6KBoMku2lQPIxOTYY
         QS0UlslNSWPP0JrLDrC2iGuDXP1hwHEDPsncgIH7EyF1uPrXDKjRRfzTy7OBbLdxZTSl
         V8aUbByNb023KOZyqtzKhIvc5Fouff06uyWihh57SJSTGOU3YM0TPMMUuzuvPqb+qcLp
         1Rdg==
X-Forwarded-Encrypted: i=1; AFNElJ9KfY5tJ5UNWvGJ0aiNUhVGdu5LAjbW0+eni3hFilmLgKHeta9oKVPnAc3TS5QHf9HXV0pBE60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvxLKda+7+5xIMna36Ngz/EPcVEaPaTp3dzx7R96sTW0WfFUK
	aADa65MBmH61OJHi9CrUFxYmJ8XIySVdTq9Ch5ZDl6Y8fxUlvDVVcu4dzmvsWLbvRjU=
X-Gm-Gg: Acq92OG01ac41KKkWP2L0HP7HCvrviXXriDdIhxrQUc1SN0X5dMwhR59AQo+0SeeS6z
	qtxppAP/tl+tA+JUTQi4FNZx7+RCZGQ/iPEuGrYN+UUuQE/uVpCER/y94ZZDZCrCY35Y6zaEUZo
	pOwLD8A1x7iySeMMn5CUbJZM4igrPXX5zcHBkrv1tgyWY6jD24FzNGjfqF9S2VuCQ2FWz+Oo8DY
	en1qxveaGZXpgb29WC2qhvLxtDFiZSFx72TK0HbEGLpgaWfpea3BueEefF0+KbMEYBJ+VUwhj3w
	jd2HReJCbopjR7g1yHh2SDtaHLh7mNls460oIAy2fXEY3QRjorD+SHWQ/g+srhGvjPO1vSJyJqJ
	M/X3GtHcRdp8rhh4eoHcIYLL51lJXSNVjM638gE6nkh3doFmkEOqOcmgsR1DPSVEq5cRUdzp+vD
	Ir5gcUVA/MpQdTdGDlvjJE4V2JOrZ//LMLPcTdZrned0B2msBjPPGviOy981275ZhXIlqPpM2Cv
	whRcqjmWhyn4YSc15NRgKFShNg=
X-Received: by 2002:ac8:7dd6:0:b0:50f:b257:9301 with SMTP id d75a77b69052e-5177877c12cmr23156881cf.52.1780448749904;
        Tue, 02 Jun 2026 18:05:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c297a8sm12256991cf.8.2026.06.02.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:05:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUa3I-00000004y36-1UNk;
	Tue, 02 Jun 2026 22:05:48 -0300
Date: Tue, 2 Jun 2026 22:05:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] vfio: prevent infinite loop in vfio_mig_get_next_state()
 on blocked arc
Message-ID: <20260603010548.GP2487554@ziepe.ca>
References: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Tue, Jun 02, 2026 at 04:58:48PM +0800, Junrui Luo wrote:
> vfio_mig_get_next_state() walks vfio_from_fsm_table[] one step at a time,
> looping to skip optional states the device does not support until
> *next_fsm is supported. A blocked transition is encoded as
> VFIO_DEVICE_STATE_ERROR, which the trailing return reports as -EINVAL.
> 
> The skip loop does not account for the ERROR sentinel.
> state_flags_table[ERROR] is ~0U and vfio_from_fsm_table[ERROR][*] is
> ERROR, so once *next_fsm becomes ERROR the loop condition stays true and
> *next_fsm never changes. The blocked arcs STOP_COPY -> PRE_COPY and
> STOP_COPY -> PRE_COPY_P2P map to ERROR yet pass the support check on a
> precopy-capable device, causing the loop to spin forever while holding
> the driver state mutex. This can result in a soft lockup, and a panic
> with softlockup_panic set.
> 
> Terminate the skip loop on the ERROR sentinel so a blocked transition
> falls through to the existing return and reports -EINVAL.
> 
> Fixes: 4db52602a607 ("vfio: Extend the device migration protocol with PRE_COPY")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/vfio/vfio_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
