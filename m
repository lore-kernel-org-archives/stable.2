Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362668;
	b=OdY6wJKP0jjDjSGQlLhLEXgH2+hQ+DDLX3EY6clIB2ZhW2n5uxUJzJRSrXW2xLdafFxw
	 hz84ygFHIHb+MkKKxj4HHJTI6zl47Rmy6eppnTdFysjhkR5LMbptR7zDyNbaWktiz0DPj
	 IzHKTMKbQTkQaH6Ns/jdfwAygNjF3hxvJ/8bZmoqxN05Z2RnBd/mEodmZe8lgMAzOupp8
	 EN36bZkJFLHP6uD3ojlOl0PstWypY3YnFgZuD0yee2KlaErjj3bloerdc+Nt+pcfzbj5e
	 12buH9fFDgXefXozgq1qhAjNbaFESWNZtgUxBts7yY2S8CHbhm3l+EdGufGw+30cTfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362668;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=UK6y1rvEetP4GeIpkkcT7eGv8kcGn/z16mpoP5T1g04=;
	b=V3y2oCBYHCdbsuZ91grUPLAMMqpLn+yFEW9it0tFdidM6DKZthNnihMp/oqHu7g/Y2qd
	 vlqFqgb/p0aOSeczIo2hldv4e2ukfcDuQY53yadiIdInZ796FwbCRswKHu2YwOndCjOXC
	 AEm4qQLepe4GIejUIoGnv8o+CFcOJnU93QaLEB4YLi2qpbtq2YiB0UvWtrcXV79Mvd5gP
	 pV75towuTgRHW60aAp8+6D5/A5JZuifIyfPu9E1IYSgU01emxBD+ZILr8xiQJDtvsj5f7
	 howpF6O0eiUnDnAEcrKKIDW1BGOpKoAnPpKJnYRcIH56KNGxEDtC3Y538YwS0XUVUzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XraIJ6OR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9EA606A31A;
	Fri, 30 Oct 2026 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XraIJ6OR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C16C1F000C1;
	Fri, 30 Oct 2026 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362667;
	bh=UK6y1rvEetP4GeIpkkcT7eGv8kcGn/z16mpoP5T1g04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XraIJ6ORxhn6aOLNJ1PzJuMnPc8UhPpMsnkW3aeRyNbbmlBmryRlydRPYjJrKOaFt
	 ipXhvkqGlCIx70HIow2DVaPIS7NFY2OQStQHqM442z5SEWSw7Xo1dk2h6a459dkIbJ
	 bYUGabJzgA1cZ+1OEJ/jj39U64gFxztd/BwD5UBJBFTvJ7Shjkqalaq8m86o213aVx
	 FR/Bp6BZrrvCUmH1cPR8jaLgirSMeIChIcj2t6x3wtFZ94Z82KA8tVNbiu6VX3COEn
	 qPPvNlfZ9s9Fqs1RTDisWAW7/uWEAKFYhCIfp0XOkgQ8o8zKyZ9ndP2YO/n++l3fp+
	 V7vRAuFTLdaTA==
Date: Fri, 30 Oct 2026 12:17:41 +0000
From: Lee Jones <lee@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	"Prasad, Prasad" <venkataprasad.potturu@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
	"N, Poojitha" <Poojitha.N@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 16/21] soundwire: amd: Initialise and cancel IRQ work
 around manager lifetime
Message-ID: <20261030121741.GI3774906@google.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-17-lee@kernel.org>
 <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>
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
In-Reply-To: <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>

On Fri, 30 Oct 2026, Mukunda,Vijendar wrote:

> 
> 
> On 10/30/26 16:16, Lee Jones wrote:
> > [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > amd_sdw_manager_probe() publishes amd_manager via dev_set_drvdata()
> > before initialising amd_sdw_irq_thread and amd_sdw_work, allowing an
> > early interrupt to schedule uninitialised work.  During removal,
> > amd_sdw_manager_remove() only cancels amd_sdw_work without first
> > cancelling amd_sdw_irq_thread, allowing deferred IRQ work to re-queue
> > amd_sdw_work or dereference amd_manager after it is freed.
> > 
> > Initialise both work items before calling dev_set_drvdata() in
> > amd_sdw_manager_probe(), and cancel amd_sdw_irq_thread before
> > amd_sdw_work in amd_sdw_manager_remove().
> > 
> > Fixes: 65f93e4096a0 ("soundwire: amd: add SoundWire manager interrupt handling")
> > Closes: https://sashiko.dev/#/bug/linux-9890e8dc-4b7d-44d3-bfb0-171dc421e28c
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >   drivers/soundwire/amd_manager.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> > index 98b09d81f3b8..2e1038ea0f36 100644
> > --- a/drivers/soundwire/amd_manager.c
> > +++ b/drivers/soundwire/amd_manager.c
> > @@ -1185,9 +1185,9 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
> >                  sdw_bus_master_delete(&amd_manager->bus);
> >                  return ret;
> >          }
> > -       dev_set_drvdata(dev, amd_manager);
> >          INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
> >          INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
> > +       dev_set_drvdata(dev, amd_manager);
> The probe-side ordering issue is valid — an interrupt arriving after
> dev_set_drvdata() but before INIT_WORK() could schedule work on an
> uninitialised work_struct.
> 
> The remove-side fix is already posted as part of our v3 patch series:
> 
> https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m60177687bb84758efdd6f5f09eba8ad32f0e4631
> 
> The probe-side fix will be included in our upcoming v4 patch series,
> which contains major driver restructuring and customer-critical bug
> fixes. Merging this patch independently would conflict with v4 and
> complicate the review process.
> 
> Could you please drop this patch? Both issues will be covered by our
> v3/v4 series.

Yes, no problem.

-- 
Lee Jones
