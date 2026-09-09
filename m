Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A88492E35;
	Wed,  9 Sep 2026 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939889; cv=none; b=fKhTXIqPcJ5WdidxIhMSxsLXtzpa7cNLxLOSJrMdDoPtv/laGwc3eWCvRZmJ5qK+HISwqp1ekNRcZb/YpwrEvsV39SYxR8gto1SPyF6do11g9g4CpKrLNvPbVjfUeWjf4OEGtCD7ILMor+hu6MCU4eSEA6f6DfEkI+AwMX6vdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939889; c=relaxed/simple;
	bh=b10mfZ88wGp7KfLoV6nUByhsnDqOrPuHynKA2s9tIt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFSkYRhyX0K51BzTJUpOBpgephs2rHRcKYgeVwmj/1ACq69N7vnxJInipf8orFLTe9y+6W3wm9rfHCggMAebScVZNfvt0ZM0SeiBX94YvlmV9ISu0suetvjQdmEiOn3YXO8SwI24wOXymxs+bW/Tm5AYJlHTCk4O8l89s7yjAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FAksSGDL; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FAksSGDL"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hftB32BD7zKmVL;
	Wed, 09 Sep 2026 09:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788939883; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b10mfZ88wGp7KfLoV6nUByhsnDqOrPuHynKA2s9tIt4=;
	b=FAksSGDLnQZv069yd8pPw+HvCvPFXsZ02lgJ5VIVA7AIAVWuOkFMNS2fSdMgOqLX65LxYu
	f8WZ6P5HyHcD9RFC4dAETL2pIt/nhe1HZfOYDLxQnuER5hVYEsUASN6K3DBd6UBJUf8n0O
	KW0oTH6HxZ9pfhu1fjJjl/HFqfm30Q3uZlug7urylTtdjLV5Z7nETRZHUzEfLlGX0qU5Qc
	HYE1T3gux9erCWEKeUTum0gF5K9sHzFliwsKh2hB1Iwcfr1BDKsqeqdHFGgGHQiLBXGBVA
	4WzOFIuRmKThQ0HLS1I/tJm6m3E/BFUtcsYawXS575wBDZ/A4z/EcZODypI5Dg==
Message-ID: <a9903d42a115bfa5373e02c7ec197ed03ee7c669.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, phasta@kernel.org, 
	christian.koenig@amd.com, tursulin@ursulin.net, matthew.brost@intel.com, 
	dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 	stable@vger.kernel.org
Date: Wed, 09 Sep 2026 09:44:38 +0200
In-Reply-To: <20260909003754.1128738-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
	 <20260908104910.183638-1-malhyuk97@gmail.com>
	 <909f7ed1b2688fb2f727afb879642cda5cad9e5e.camel@mailbox.org>
	 <20260909003754.1128738-1-malhyuk97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 9d141xdfi4hdzqsfbg8ppo4w3ydtt4iw
X-MBO-RS-ID: defea9319307905a299

On Wed, 2026-09-09 at 09:37 +0900, Jonghyuk Kim(MalHyuk) wrote:
> On 08/09/2026 13:07, Philipp Stanner wrote:
> > Is this an issue? A fence can only be exported if the scheduler exists.
> > The hard rule with dma_fence is that all drivers must signal all of
> > them before they tear down the scheduler
>=20
> Agreed for the bug at hand - that fence is signaled, so 0001 covers it.
>=20
> My point was narrower: nothing enforces the rule. drm_sched_fini() only d=
oes
>=20
> =C2=A0 if (!list_empty(&sched->pending_list))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(sched->de=
v, "Tearing down scheduler while jobs are pending!\n");
>=20
> and the one path that would drain the list, drm_sched_cancel_remaining_jo=
bs(),
> needs ops->cancel_job, which no driver in current mainline implements -
> the only user is the mock scheduler in the KUnit tests. So a driver that
> gets it wrong gets a warning, not a stopped teardown. Not an argument
> against the hot-fix.

True. The cancel_job() cb is currently the recommended solution
(although there was disagreement back then) that Tvrtko and I came up
with a while ago. The issue was that drm_sched was designed with no
idiomatic solution for handling remaining jobs in sched->pending_list
on teardown, which is why all drivers presumably have different
solutions. cancel_job() was an attempt at providing an idiomatic
solution.

It's afaik currently being used by Asahi downstream and was used in
Nouveau, but Nouveau doesn't need it / cannot use it for other reasons
that have to do with page table cleanup AFAIR. So Nouveau covers it
with a waitqueue. We could add it to Nouveau again, but then it would
never be called because the waitqueue comes first and needs to stay=E2=80=
=A6

So should you see a driver that could make good use of it, I would
appreciate if you'd try to add it :)
