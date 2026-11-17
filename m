Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940075;
	b=brrqgyFpcrD7pECYbsjDkSvCWKbrc03B2dP1fXJj+6odGRDpCZQZThXXcuPXOHg7aTiO
	 ixuiN3frBc9gtr1dZPk7WPRsCRxNvyrf2U4sAgxCCuquO+NI9geZ2cCGCFVMRXgirrltt
	 c+kwYHqK6zQVIOTc79wm0QSb9qgTMwiu56taMouAvNzeBA0D5TPTcpzz/MxxiZHE2u/81
	 2jV41StnJxadeiGOR2g8qIlfiaTypSHdT/D7TJ89s9NbLUAvRrjcceUXT0YzPcg+qIomF
	 nWf9r0GknEKp6ZxCYw4/4Uxic0EWJGCheWu6/yfWswqIEUIK/Z5J3ITG9DnYePcwneQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940075;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=d2xN15dj3gCvbJHEB+TEBgOrVQFIeke+Q9K2cfCpikA=;
	b=iidXHr6dMeABWU2MOsAkIufbLr8Nywdu5CJfUp0kbfrmlu+ebdOp5UGkxjxukGMLFjs0
	 mBgjs+7Sbc1NsVyYS/vzpn43LUGxL8D8xAFlv5EHPF6vNqEm7k5BV5888osH7Vfr+T6M2
	 xo9856FVnsivpUBSM36nhHkRXMKk+fMOC0jBPdI0TTHu1vRt6IwBrMYx46eLUEock1WVl
	 FI8RBU6YJauz3RhF9GTxkhlB11n36QHAKFnoYTj5uuUbpddHG0bQ2zXSg6CvI2oMpmK2Z
	 aciTHeiqnyytjz56f5u+VYU2b/v+HUKE0svCuWGtlNkGW1D8Dd+RJ5wPxOokUsORd1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqULsYEt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424B606A31C;
	Tue, 17 Nov 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqULsYEt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340431F000C4;
	Tue, 17 Nov 2026 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940075;
	bh=d2xN15dj3gCvbJHEB+TEBgOrVQFIeke+Q9K2cfCpikA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqULsYEtt6CVaxlO9mQ6ePjg54L1qfwjVAX9O2MIZTa/dE0PKcBqvpx05FKgSVh5+
	 8JYLEdhpMkz5k2XlhWPYRuija2Xqm8oC/Wmg110tvZCjq2JqblBUP5aLUrY/z7J1LR
	 i4T7gU3FFD5E7EQpxZ7b15/60fdvrPCatwaKUO7PZ1QCWW3esoGE960t8aoT2vn/Sp
	 etj5+atmpx4h2AyUYebq5tPIl49tk4Z9pZ9os1a3dib+Uan4/Yy2jly+jjdkp5os/z
	 wq2Pr4qCj7UcJB17/2DLrYP9+UnmHZOxg5SmSrmnYUoy4dyX7imNgrprxXTJd3TLXr
	 8Hlx2DJdXTB9w==
Date: Tue, 17 Nov 2026 18:27:52 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Chengyu Liu <lui2012qwq@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	philip.radford@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
Message-ID: <20261117-hypersonic-beautiful-perch-bd4fcf@sudeepholla>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com>
 <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
 <avw5o7sTyriZ2ZiX@pluto>
 <20261117-prodigious-limpet-of-fame-3d72e6@sudeepholla>
 <CAE=Q7=4+HMtqbiK9v3jw4t31TQOYUfRXKRurZ7KcMi7GTi1v2A@mail.gmail.com>
 <avyS2OLs3XGcKXXn@pluto>
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
In-Reply-To: <avyS2OLs3XGcKXXn@pluto>

On Tue, Nov 17, 2026 at 05:46:00PM +0000, Cristian Marussi wrote:
> On Wed, Nov 18, 2026 at 01:35:04AM +0800, Chengyu Liu wrote:
> > Hi,
> > 
> > I think the current v2 may have reintroduced the second deadlock
> > described in my original commit message.
> > 
> > scmi_forceful_work_func() still calls unregister_reboot_notifier()
> > while holding sc->state_mtx. Could you also check the potential lock
> > inversion between state_mtx and reboot_notifier_list.rwsem?
> > 
> > The reboot path holds the rwsem read lock while executing the notifier
> > callback, which then waits for state_mtx. Meanwhile, the worker holds
> > state_mtx while trying to unregister the notifier, which requires the
> > rwsem write lock.
> 
> Yes indeed Sashiko complains about the same and the second part of the
> issue on the rwsem is unresolved and will need more work.
> 

That's what I was referring when I said
" ... re-evaluate needs_forceful again here after un-registration before
  calling below forced transition ?"

But then your response somehow convinced me that it is not needed 😉.

-- 
Regards,
Sudeep
