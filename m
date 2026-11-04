Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782087;
	b=KBvrlH7AqJvNTMW+4Aj73SjlULEBP4ffAvqEaTy4mivgrS2irkFBDt1j0Hb8p2p2AOH5
	 9aK+xGORB+9ouvx69NYApgLx5kdzUAGqWaBTSDW233X4wngZMSIX8gMXPht2ftrRZgfRm
	 UAGDT8rDqvn5LGjWDRQ1p8q35HZLr6VkLLDCF+OQG4Mkxy7iU4zmW7ItpV0RwwxtnJeWS
	 qV8SZ9BjG1APSoTvUhGf6KvCpGkCJvFM3vsh/91kDoScqI5Cf7DoYOhvyvah13Q57TZ4y
	 E+bTbrQM0E4ExU1QwIBhUoapsbHqCMJuw8roKuhlJqfbxswmk21eIm0QlAzZaL9NcPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782087;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-META:
	 X-MBO-RS-ID;
	bh=gTcKGaMEFZJ+gKcb8wNFFFYabXj82mL3rKDihJVqD/8=;
	b=qoR2cEzyP7kAi5m7pyIjjY8TfsV84HUDEe5leS6QC6OzhLQ10cXMyllR33eZU5z1867U
	 Y53vUK4H7SzV+sjeRKvycY3OqO6Vhhrf3XPX0jJQnidbSlzixlHrBy81kl9ycKL743k3T
	 +yCACShD7sOUuFLJnZBJYdk0ACkUoVOpc4lUj51K2Xa/nyzul2ZwC3KE6kNWUkUZuoMfj
	 P6u6NiTq4IF37nZbaQPuR2QyzzcnNs/c3r4/8l5AWD28DPKEe23Q2Yex/h7aVRGT0vJ7M
	 fwIpyXh2WRujrZwFRllWzt0+4YTCjV9cnv3jFjqiH/UWc3qTSgVLKLKXTNbmZuEw79g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=SwtvEyPL;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CC606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A4CC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=SwtvEyPL
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKJxH2QYNz8v1K;
	Wed, 04 Nov 2026 09:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793782083; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTcKGaMEFZJ+gKcb8wNFFFYabXj82mL3rKDihJVqD/8=;
	b=SwtvEyPLIoWWaYpSkGb0pIfrSexCQ+WlN8vRZk4gX25sJpdbwKd7+Hap2hmLDOpQVSBctB
	cLFhfQRu2zCgu0ijQXh4bEDrGsIuQf9jR2XxGEraRmWSmJd8C8Q/q+2OUqdSKMQlyM735p
	SXIkuaEvoEfsZCf5K8esIG6WpJvlV33Y8qkAWUkZzHc3Ri8clBjRIY97BQCprrguHlaLhM
	csK1S0nJ0AjeQ7MyVpKurn1idcSHfKjUHcAB5De2hfp9F5GjD5OCtpFagiLCRWTg14N3HF
	rFXSWAWCQpP0zrCL75Oe/gJ7mF2tdSpwKwZHO/z7x0rFrrCKaRrHg/aKe6Gx5A==
Message-ID: <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
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
Date: Wed, 04 Nov 2026 09:48:01 +0100
In-Reply-To: <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
	 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
	 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
	 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
	 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
	 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
	 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
	 <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
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
X-MBO-RS-META: 318yyz1zitody3gc1eoi1khtmm5qk139
X-MBO-RS-ID: 8727d1ffcbddc88b426

On Wed, 2026-11-04 at 08:33 +0000, Tvrtko Ursulin wrote:
> I lost you here - what should the comment say?

Just a "TODO: entity->rq_priority could not be fully removed due to the
partial revert of the CFS scheduling rework. For formal correctness, it
still has to be adjusted here".

Just so that the reader sees that this is in an intermediate state
right now, and so he's incentivized to git-blame the TODO to find the
associated commits and mailing-list-archives.


Regards,
