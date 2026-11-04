Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790265;
	b=NrwkECp9hBHQJytPAxcIcPF64mtdrkeYkqfhUbZNKYQmKFUNUGoGd5jCFJmWEjDUrFyh
	 FXGUXv5wX7zLXUVKtrlYf8lACRVYVZqkkids+kWnRVhy2zp0eEydiqu2Tbb49w5ElWte4
	 N6eEa785Ck1K+Dp60yq8pkPfzMQYAl7Ss+LTJiXy4X5B0YaBogN+r2UcoY9IxnZ/Qdo/O
	 qnC8dy18yPWIdUyiTOkWU+QwN71mOQnH7w/pE+WSRDOHCdGXiz7BoOqOsjMJrLYSh1EGC
	 FTXUaR8R1kQ52HNKQrzhskJmHBKV5hFa6z4NRWRpk4sd3rWb6mArrHGGqF4PyPlNFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790265;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-META:
	 X-MBO-RS-ID;
	bh=W7vWa0flX1PsKvHiGeb5kFf5432F354CuXzCDkcbp1Q=;
	b=rsQvoPXaM/x6dXfHG5csvBlXfX/ThhjAToJhKNnmK42CuKtVdm1sXBmLZ71HVuogxeS6
	 23MlOfq+cyiwRIWQ4F5ukaEmj86tVURXdOpP2vtOHVmYBlyWYGoj9UgKbQofIQlQswTxq
	 bOHRXOMgGd6UdUsq2zsCnxKGOVO+pe/aCuto38t8VV6UK7ozOsJ+txRQgpxCDsaP/8UFu
	 ytcMmYW+DheD6Z7aiPJJo/tYKTl1oTfJNtsKQV14hEO/aeaLDcNL6Co36nDjFE8k7Zm3l
	 C85aXm9s3DhL3GEDVWXeiPZrvrVqEmOyF7sfTrOV3cv9AqRhbBxQIN2VgL/BT1JEYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="OiMIgPv/";
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82E606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF82E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=OiMIgPv/
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKMyX1DRHz8vmb;
	Wed, 04 Nov 2026 12:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793790260; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7vWa0flX1PsKvHiGeb5kFf5432F354CuXzCDkcbp1Q=;
	b=OiMIgPv/sr3a9MmWXb6EbBTH1G/G11Yb2DD3j04rbrv053pACO+9UYaQpqc+G0BYY52fJG
	O6gl6OHkujIM4RrgYmWNt7nbC6nKOEhWtHG1+a5UH8F7zwlnhzDiLCdXIcWxlZnOwHYayT
	ZNOvhi6RJJ8F+bZK6+iwSJOD4piUeTA8UHGre49DKhnG7hcLSz+1fP1wVQpEDQ9k0IT1nQ
	PQ2rp10kgdFf4zaeHOOPV0jFT7P3NCCx1SGHD7XXYMR2FbOjFzBOXnjk691luqCR0YPSMS
	ViIqdFLBkrgBfPw/kpUkjpViu4V3WrJOyaVTMH+Wp6oogJFPV6gcY+W/f2Uo6w==
Message-ID: <b93eef3f44db1cd8018a742a39cba57b67dd1d94.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>,
 stable@vger.kernel.org
Date: Wed, 04 Nov 2026 12:04:18 +0100
In-Reply-To: <7277f083-2d17-4bed-bdaf-e6c616cc5ec9@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
	 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
	 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
	 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
	 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
	 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
	 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
	 <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
	 <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
	 <7277f083-2d17-4bed-bdaf-e6c616cc5ec9@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-META: nerq6ks4ixrp7ddkrsti497zumhn496k
X-MBO-RS-ID: d9f4ec4cfe333c3fab6

On Wed, 2026-11-04 at 10:43 +0000, Tvrtko Ursulin wrote:
>=20
> On 04/11/2026 08:48, Philipp Stanner wrote:
> > On Wed, 2026-11-04 at 08:33 +0000, Tvrtko Ursulin wrote:
> > > I lost you here - what should the comment say?
> >=20
> > Just a "TODO: entity->rq_priority could not be fully removed due to the
> > partial revert of the CFS scheduling rework. For formal correctness, it
> > still has to be adjusted here".
> >=20
> > Just so that the reader sees that this is in an intermediate state
> > right now, and so he's incentivized to git-blame the TODO to find the
> > associated commits and mailing-list-archives.
>=20
> I would rather not do it in a patch with a Fixes: tag, or actually at
> all - it feels arbitrary to sprinkle a TODO mentioning future work at a=
=20
> single random place like set_priority(). Could we go with these two as=
=20
> they are and continue from there?

Help me out here, I don't have the CFS series paged into my mind right
now:

Will future callers, after your redesign, make use of
drm_sched_entity_set_priority()?
