Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C653BE172
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454747; cv=none; b=hkmVlPWx7hRsEKDe867eL8W/4so7+cu5Wn5dj7LP38VPSRgPx5ZCX2uJfTX+Dh/Ip/OWA363/NL5dlMcztM+gxwEHWutOoFm2iI3fkDyqLefZukedo+4iPBEpsLg8FfHawkfIiHBhhzUbgIPRIlXHY2VrpKe+UMr/+msOqVkS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454747; c=relaxed/simple;
	bh=7irScfbRf2bXjKUhGEludzZp7D8UWNmY9IRXFNnawMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKO73BiPKsDx/5hT0Jj+gWacyNflPjynA9eXPipjegeIT/yXT62dOrocVtNexDnbKVew4Zv08kqM6GXWSaaz80mHTquVXMfeBXLAUvYmJMDc8TJKf+bb1mLjxobf1CNeR5nPJ3v/Y+Nb3iAseCJ/pCnk6NhelyTUmXUgJGCiBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jjKgvlti; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jjKgvlti"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j0mDj0PW8zMlG3;
	Thu, 08 Oct 2026 12:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791454741; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7irScfbRf2bXjKUhGEludzZp7D8UWNmY9IRXFNnawMs=;
	b=jjKgvltiUxCGP45bIPBE9mFFVUZAVN6b9W+v4rWlu03aEk3Uh5vnOLi5do5r0ECVHNgNX/
	HhvvgHLRuO7JtViaVTCucG4cSs4mqncavOEgCTNYml1nJzJbpzg6gYJaWmkzlVqcLR0VOI
	FUJyOlXlEB7UIhxo7sje6+lPwqvw7Mzi9YNET3TCnft3AZQjtZtOuiDqRdBXaTGS1IK3KE
	fGO+CJ9P1t8bBxU1ZAhGk5YYn3XL3oQlnlUUZBAMR3i8Xav+fcQLdeRQl3DBZbPdwI/Z3B
	s8iey9vYe/xNsYv6MlYqNoUyDtFzXtTGbSpKgbitGIwHBmtD+zFNolwpuMLP5w==
Message-ID: <154fd1c6273812a804799cb82d11655c1726a83e.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix out of bounds entity priority check
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	stable@vger.kernel.org
Date: Thu, 08 Oct 2026 12:18:24 +0200
In-Reply-To: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
References: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: swrufom8hw8fqtbejd8dh1e7i3t6q575
X-MBO-RS-ID: a03e0b1a6e3e0911d2d

On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
> When the out of range priority at entity init time is clamped to the
> number of run queues in the supplied scheduler the internal run-queue
> priority needs to be adjusted as well.
>=20
> There is no impact since none of the drivers hit the clamping path, but
> we still need to address it by moving the entity->rq_priority assignment
> to after the clamping is done.
>=20
> Note that a lot of this will hopefully get removed once again when the
> single run-queue simplification lands.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")

Help me out here; we recently landed this fix [1] that Luke reported.
Is there a relation? I guess not, since you say there is "no impact".

This did not exist before CFS in drm_sched, did it? Did you discover it
by review?


P.


[1] https://lore.kernel.org/dri-devel/20260915150557.62847-1-tvrtko.ursulin=
@igalia.com/
