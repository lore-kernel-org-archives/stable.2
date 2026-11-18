Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027558;
	b=GWAG1/QCWW1+IVEC0JzwPY0bcOp5gBHAxUncmRyzI1RKoj+990P6yJ8kkcGnnLPjVOHk
	 7wsSMQJWRgmW22xj4Acq8HbIKxfMPCrngX5fM9xNebwtMYAEj9/jnC1vSfnlIK6flCqoE
	 BCd9+ZONL7Hhs7rWT6sxuT5oGQOkzcoS4ek/K8Y9ChwkTPW4rb+HDT+iCAdgDCO+LXItw
	 7PJe7e0jVYtxOofY/yE68rtwW5joatOz2qVm8stZ85OAsFarkcuUy+oO6I7BUOJLD4Ddq
	 bS+8MZ9O9JyrbF3954/kzNxcH+ryCMKOcW0B0OSgyvTj4hRjxk42gXbYkoK9RuNodpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=q47HBnsBXsh2bthirykI6rD+fkcQs2OaoEr05am18HI=;
	b=RXHYM9Euby39BAwziEj63a0NCVPorRSPP3qtZ/PJzgqjIWwW5bsiIdZEcuMc2N8JFrOV
	 NrmoJujoPC7nc6PlrTAUaGq14kzx35wUAnZCNhCG1toxQ4zavLd485dGCj5P/2ja3tCeD
	 Rev863SSR4uk7XHiIxMJKrItY3SKQpLJkQ2vtScl01iZFpjxAQt4OzuxqUSTPckFiqxsW
	 Hgon5LPcgIf9yF8OcWb35FCptmCEvK3leyjpwntcVOmDWYQ4nh6tFha3H6u7V/D31XLgi
	 cHkSlb3q2GXz7OcbENeYMtVlEOMyOAuIsIZhdrav4NP9Ad4WULZLGsV7jibIHZ0/C4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JWVFmd9+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F860A2607;
	Wed, 18 Nov 2026 18:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 580F860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JWVFmd9+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B61601477;
	Wed, 18 Nov 2026 10:45:54 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330113F673;
	Wed, 18 Nov 2026 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795027557; bh=RgXpgp1b64sl9UfssU3kG9kquYvtoA69zMUuuOQNjXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWVFmd9+3yNomI/qoopkleACN5TNxUN3On+VVyud7IpUCc/SG+Ig7dye/VtQj3Gz+
	 XscHeHYR6bZSkFh7ZNolGXymS8NH5Kbskz2yOHb3ZSiVXRIV0xMb2DzwXo6Pfv+j9w
	 MozS/n6dl2ICb40gnwWiNxAS4XWK/eIpmthc0otc=
Date: Wed, 18 Nov 2026 18:45:51 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Chengyu Liu <lui2012qwq@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	philip.radford@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
Message-ID: <av3yX-5WUt8bT8Jg@pluto>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com>
 <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
 <avw5o7sTyriZ2ZiX@pluto>
 <20261117-prodigious-limpet-of-fame-3d72e6@sudeepholla>
 <CAE=Q7=4+HMtqbiK9v3jw4t31TQOYUfRXKRurZ7KcMi7GTi1v2A@mail.gmail.com>
 <avyS2OLs3XGcKXXn@pluto>
 <20261117-hypersonic-beautiful-perch-bd4fcf@sudeepholla>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117-hypersonic-beautiful-perch-bd4fcf@sudeepholla>

On Tue, Nov 17, 2026 at 06:27:52PM +0000, Sudeep Holla wrote:
> On Tue, Nov 17, 2026 at 05:46:00PM +0000, Cristian Marussi wrote:
> > On Wed, Nov 18, 2026 at 01:35:04AM +0800, Chengyu Liu wrote:
> > > Hi,
> > > 
> > > I think the current v2 may have reintroduced the second deadlock
> > > described in my original commit message.
> > > 
> > > scmi_forceful_work_func() still calls unregister_reboot_notifier()
> > > while holding sc->state_mtx. Could you also check the potential lock
> > > inversion between state_mtx and reboot_notifier_list.rwsem?
> > > 
> > > The reboot path holds the rwsem read lock while executing the notifier
> > > callback, which then waits for state_mtx. Meanwhile, the worker holds
> > > state_mtx while trying to unregister the notifier, which requires the
> > > rwsem write lock.
> > 
> > Yes indeed Sashiko complains about the same and the second part of the
> > issue on the rwsem is unresolved and will need more work.
> > 
> 
> That's what I was referring when I said
> " ... re-evaluate needs_forceful again here after un-registration before
>   calling below forced transition ?"
> 

I know what you mean... 

> But then your response somehow convinced me that it is not needed 😉.

..but I fooled myself too O_o

Thanks,
Cristian
