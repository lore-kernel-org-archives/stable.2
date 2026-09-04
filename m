Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B542AFAA
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512546; cv=none; b=kz9DW6CMKI4JpBxtORs0/vk3AEVHOd4pFR0yPNDTbgrngX6xaH9J69mwakOazQPuf+DHuJ3ONuUhAVWFTXw7yihkwtqZF1Hty78BTg9mC1n0hVNR8IfEp1BhU+DG3+Ybjih2JdhB0N+UVxZXVXbyc6Si2mAAS52JhFkkhHkAakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512546; c=relaxed/simple;
	bh=zwOgrFX7s8Bq/2iYUD9jj5MO5VT9r915r6LJ7serWUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8dycFxXE0MJDFWq8o/ltvsRaWigg4t9iD24/DlO1V6A+H/qCkfQw5dKliOu62Ft/M83v1SHpHAVyDj1mQYX90XzNWkhTLpvPJl1ZsKMZagYhhbHw+r647RANPoiJX76PBxKW2IaiDt3DVbKRm0V1kMrOHZzSU/3jPSVpXabRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DqbGfofz; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DqbGfofz"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260904085212a08ad4cc2a0002077d
        for <stable@vger.kernel.org>;
        Fri, 04 Sep 2026 10:52:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zwOgrFX7s8Bq/2iYUD9jj5MO5VT9r915r6LJ7serWUc=;
 b=DqbGfofztkaz5loDe1pvYHs+fSnVuiHF577LWy+0S0V/gzc+AFS6eJOU+RRdkG4gaJSFIg
 AwORgqQUBoV15D9z0UIyPQZBsNYXV1RyrBoFmwFwnyrekd4hLvJSSImKO8MANuwMUiYk+Oco
 Re2zvZVIrpfvXEIhXkOnk3DsdHN3LMrU1nHEaJVvlUNgMBVh3xzarVWnDS844/yG1l+Tok/v
 8+SSzFJlhmnO9YMTkTzHhVSdPeDFf5ATodCNxKFoCd9MpQ6c+OvtlnRzMgcUpEhnFTqBUZsS
 Z5USkNAdM2STGSeyHzcjZ0dErdxGQWBaoOwt9mEUTBgnW+cALk+UB15g==;
Message-ID: <63d5cd58e9b85acccdaaac9aed4a8c550cc7b868.camel@siemens.com>
Subject: Re: [QUESTION] Are these issues PREEMPT_RT-specific?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Ran Hongyun <ranhongyun1@huawei.com>, namcao@linutronix.de
Cc: axboe@kernel.dk, bigeasy@linutronix.de, brauner@kernel.org, 
	clrkwllms@kernel.org, frederic@kernel.org, jack@suse.cz,
 jdamato@fastly.com, 	john.ogness@linutronix.de, kprateek.nayak@amd.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, 	linux-rt-users@vger.kernel.org,
 mkarsten@uwaterloo.ca, rostedt@goodmis.org, 	stable@vger.kernel.org,
 torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com, xry111@xry111.site, chengzhihao1@huawei.com, 
	yangerkun@huawei.com, yi.zhang@huawei.com, wozizhi@huawei.com
Date: Fri, 04 Sep 2026 10:52:11 +0200
In-Reply-To: <20260904081149.3000727-1-ranhongyun1@huawei.com>
References: 
	<ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
	 <20260904081149.3000727-1-ranhongyun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Fri, 2026-09-04 at 16:11 +0800, Ran Hongyun wrote:
> The commit eb0d280c2751 ("eventpoll: Replace rwlock with spinlock") aims =
to fix:
>=20
> 1.Priority inversion =E2=80=93 On PREEMPT_RT, rwlock_t readers lack prior=
ity
> inheritance (PI), so a low-priority reader holding the lock can be
> preempted by a medium-priority task, blocking a high-priority writer
> indefinitely.
>=20
> 2.Stall =E2=80=93 A reader (p_read) holding the lock can be throttled by =
CFS
> bandwidth control and scheduled out. A writer (p_write) blocks waiting
> for the lock, and a timer thread (ktimers/n) needed to replenish p_read's
> runtime is blocked due to writer-fairness (286deb7ec03d). This forms a
> circular dependency and stalls the system.
>=20
> Are these issues PREEMPT_RT-specific?=20

No, but it's way more critical on PREEMPT_RT. !RT systems will see a
"performance" or "throughput" drop but not a critical system stall.

>=20
> Any clarification would be appreciated.

2. was addressed in 6.18 by deferring the throttling to the place where
a task exits to user mode. See [1] for further reference.

[1] was not backported to older (stable) kernels but the commit you
referenced at the top was, so the 2. problem is gone there was well.

HTH,
Florian


[1] https://lore.kernel.org/all/20250829081120.806-1-ziqianlu@bytedance.com=
/
