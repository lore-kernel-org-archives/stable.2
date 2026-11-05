Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892946;
	b=CKINh/rvD617SaCn5u5gqGIREVWya+vU+J8Uddev5FQU5MwCBVDkAnyptQDKiSAWsHcH
	 a/dYIVoe2C/aR/XvWbXiQSWr/Ijqc7NI/VCRPNE2Oxoc4XaYCY8bJ7r63uw3UOQC8Hqhy
	 mQiALfeZs7Nk5U91DjvOQ0gfo0F+kRKQDpe/kDp3PwrCIDY6ampu9fo9SucPPek8qXpFQ
	 J7Y6hDSvm2xtTt0zWJnoe9ZuVR+klUOXL5DfNy29RmQ37DrShyJW1d/FAVCFe8G5B9FLv
	 az701rugeDTL3whnBTjz453wypZHEc86lFayXrEuKzDVdnpPHg8e7DSoWd/Nbpm8GEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvinUM9bdOIzQQT+vOy1XPr/IQD9o1XMDhdE9KnkQhw=;
	b=pHmW1zFmxvM63Gx0Iqbd3L5S3zQkyJga02NJXhxW+9lj3i2EgeO1pszJtXtTzsjkMWQu
	 Zi5kYhanV0o6gRN9txHAxLCVMvFF2jdNQhlKlxj2xI7li+1ye2YNoPsNj0JSYGJj4O4vc
	 LUdCZG6TmWAaCdsx/BxPkCAHP1JPc2G+5Lq6Faa0KHbQCyjPUtSBmX4ziNxcgO1McdzP1
	 kgayl7r66Shl0GGj3rXHhUFNImEyEiM81x9sfHmnVfpJ+T79xVUlMQShzBBv0maGdqtIM
	 kG0KB5rhyusiIlS6sLmnxHdOxVfqhv4X9V1guqXQdX8tgJR0wSiBtAhZbDsEp4q2sEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=PWCM5JUG;
	arc=none smtp.remote-ip=209.85.208.97
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD06606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD06606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=PWCM5JUG
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so2404430a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793892939; x=1794497739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvinUM9bdOIzQQT+vOy1XPr/IQD9o1XMDhdE9KnkQhw=;
        b=PWCM5JUGt2vM7IoWvZ2VRy/K1pZWjolfIrZvNnnrIcVUCmKuwQSNtxHRCsfWsYW2YN
         n5RR3UmHSzqRH84ms8sRvR55ma2onqpmsjP2uhFSHqR9BEXm9vzd4rhtJfYuLMnwcLaO
         4ekvrvwBN531NBXuN8cWbQLvzJVzFsLFQt9LSbiQNLBCPSl8vs+bpW46ZBeEY9hN6H8A
         OQrjLyVKDMSFH/UZTUmIuB5WCmhpYUt/GjaDqeIKC1Y3py7x7L2eSbF2T+dCNRfeWAuv
         IR/ajfFa4PACXPv1H+8IfPasF+e86OENGadezOhGXXbOZhaFtDX/X8ukte0DnN/fcUUK
         2X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892939; x=1794497739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvinUM9bdOIzQQT+vOy1XPr/IQD9o1XMDhdE9KnkQhw=;
        b=dNwQJb3c26hWw4bDrsYtGxlLRrxfLs1Qtm+XaRTWrZHNObEEnwpbjN7OsVMAiLivAA
         1SX1uk6xMtRzD5/X9c4mdRRBamd90qSGqZLcrxTijREn1rU+XEb84MoDfHvDfExLlxkc
         5sS5V21o9huWL9HWLxjzpwQUfXvjFiBYhh8Ode/RJuSKr7FnBJF8iu5O+MH/WXaUIkG8
         9m0U/6P1ROlCjQDr+ktqQ9f57IiPPm+n6AfC0C/BnKBjHuK1Vd3QqHJed/GQ9EsA8nMY
         Dzd2q3uHLsxGIhkulhMBcuJr+5WerUz5b/r/g/xmljageLUyopGBwkseOtFXMvoQqA1X
         gyzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQJiHAtceFVTI6rDvJmlBE3auCdr1xHBmB3mnDFazVWDPu1Hh2oLfDW3FrCu9jHC5K5IuuDus=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KBe1FSBqNxQIRitYvr4pxmXZ8VpSQOtmIZ9KGYtcJqEsErJfq
	7sdSZ9pOytSeh9nqIqs0KKA3MRollMoIDc7QH0icQGx/lvAnjJv3SEkpjSE449C/gEY+tUnf9FH
	OQ7971g+s2VIDf3q/qrbpp78JYu7G+fiU3d1X
X-Gm-Gg: AYBFou3j7BunnsizAKpex9e5iTfHoAYYJHXyN96c1tXiaK7+g/3ginHb/nA+Hu5d5P4
	aSt7WeGCJlWwM5j3rsb4v2iy1oYFc2vFiCV3o207XeK0ixv/La+4UsheJKPnkwjErUbHxsxqiJZ
	6sHgy0VAhpFDnxtIwKqCV7DJGtfpNiWY2RDFB3tHEjUnIvz3LUC+5VX0aWHQ/Kk3s9Y9H668ljz
	xM5x8ChUH+AE8faF3DI+UpR7GiewNisgBmo7x91nJyuwTLFzgwVbyEYPNCSTtRS8F3WIp9Nqub5
	fQ038YBYY+uDFOTNTimCXBwJMfDiU9QXO18PCZUYK7kaD/0XG78YjuaGK6QoEGfnmdWg/8wqK3R
	ppAlEBZbd02wpRckLkY9ef3nQA1Rw3GLzMTiYbg==
X-Received: by 2002:a05:6402:ea7:b0:6b5:78bc:406b with SMTP id 4fb4d7f45d1cf-6b578bc4265mr1906328a12.23.1793892938711;
        Thu, 05 Nov 2026 07:35:38 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-6b55ac1beefsm1194828a12.4.2026.11.05.07.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:35:38 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id E2A1E34040C;
	Thu,  5 Nov 2026 07:35:06 -0800 (PST)
From: tmenninger@purestorage.com
To: trondmy@kernel.org
Cc: anna@kernel.org,
	bcodding@hammerspace.com,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	prabhakar.pujeri@dell.com,
	stable@vger.kernel.org,
	tmenninger@everpuredata.com
Subject: Re: [PATCH v2] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Thu,  5 Nov 2026 15:35:07 +0000
Message-ID: <20261105153507.3145077-1-tmenninger@purestorage.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0a489565ca1693403d08eaef7c3545f5b8366bb2.camel@kernel.org>
References: <0a489565ca1693403d08eaef7c3545f5b8366bb2.camel@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This claim isn't making sense to me.
> 
> If a layout segment is recalled or revoked, we should always be
> clearing the NFS_LSEG_VALID flag bit in order to prevent it being
> looked up again. New RPC calls should not be able to add that layout
> segment.
>
> So the only thing that can be found on a second run of
> rpc_cancel_tasks() is a task that has been attempted cancelled
> previously, but for which that cancel failed.
> If you're seeing actual spinning, where the RPC call is just being
> requeued by the rpc_call_done() callback, then we need to look at why
> the latter is failing to handle the situation correctly.

Agreed. I am not seeing new I/O acquire an invalid lseg.

The issue is that the set of lsegs affected by return processing can
expand while the original I/O drains. Newer lsegs can exist on the same
layout header, with I/O that has not previously been cancelled.
Cancellation and cleanup of the old I/O can then redrive return
processing against that shared header and bring the newer lsegs into the
return scope here:

  pnfs_put_lseg(A)             [final reference]
    pnfs_cache_lseg_for_layoutreturn()
      pnfs_set_plh_return_info(..., seq=0)
    pnfs_put_layout_hdr()
      ...
      pnfs_mark_matching_lsegs_return(..., lo->plh_return_seq)

The zero argument to pnfs_set_plh_return_info() resolves to the current
header sequence. If that sequence has advanced while A was draining, the
pending return cutoff can advance with it.

For example, my trace records, on the same header:

  final put:       lseg A, pls_seq=336
  return info:     input_seq=0, resolved_seq=529
                   plh_return_seq=528 -> 529
  header-put scan: seq=529
  cancel_io:       a different lseg B, pls_seq=529

A was already covered by the previous return boundary of 528. Its final
put nevertheless expanded that boundary to 529, and the next scan
invoked cancellation for B.

B does not need to have encountered an independent I/O error to be
selected by that expanded scan. Its I/O can be cancelled for the first
time because cleanup of A broadened the return scope. As B drains, the
same interaction can affect another newer lseg:

  cancel I/O on A
    -> cleanup redrives return processing with an expanded scope
    -> invalidate B and cancel its previously uncancelled I/O
    -> cleanup of B can repeat the process

Counting only newly requested cancellations does not break that sequence
because each newly selected lseg can supply previously uncancelled
tasks.

This does not require new I/O to acquire invalid A, or the same RPC to
be repeatedly requeued by rpc_call_done(). The feedback can proceed
through completion/release processing and cancellation of different
tasks on different lsegs.

The cache-path sequence update is what I tried to address in [1]. I
asked to hold off merging it because later recovery in [2] ("SUNRPC: let
cancelled RPC/RDMA requests drain before release") testing left some
ranks slow even when the reconnect loop was gone.

[1] https://lore.kernel.org/all/20260921235520.502987-1-tmenninger@everpuredata.com/
[2] https://lore.kernel.org/all/20261105030710.2652306-1-tmenninger@everpuredata.com/
