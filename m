Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611911;
	b=TK72gxi1cnZ81WB4rLL2S1mfpSSUFoJSbzMfxDk4B2cPpJKMIE3gUqUr4NTVJKkW6jyR
	 JzVlYTUt0Dvj4peSbp/oSAD/o1IhNlCF1NAYJYCbr47pumO59oBZFQfPDp7IR53tKfTv+
	 R1HeaHHWN6Yd23lD2MNYmfHcDkRKf+2/RRceSneT8RS5OloSL1afwr2gudEpQhtjd9l9y
	 sL0faa97OZn7TeH7UYtbXt7kaJyjKkQm8i/j6kREibMPlom0+R/I4Xt8aO2t1SPxGCWrg
	 oEY/Hmlthb4vog874d2RzAsm+Yap04Zvuq2EwTrYzZHk6/64OGjh0YvJIxybo0znevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611911;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=0O8J1AJDW3RflaJPN7IuNL/LtU/ZdZpwEcplV5q5I3M=;
	b=LJb90EIbTHqRXytvSC0yHd0objl8XxmioZ1p+LKGy6XlDfGvXYY/Ll0VeFHFiXPQ+H6J
	 eJtjykNCOUJRNqSH+H1pGRNr8JlM15m5A69ZhYk+uvwXa1WdDoI6Vo8nQ+EMAGpgPoPoQ
	 1Xj8u4eE1NocPNWcz6cP4lnWDJxIY8T2mkWCRIbN3wHVt6fRrlwQSh2Yda2hmtis2ex4Q
	 RJwK9ULT5Kuw1pVYlK8xa1e/zeZOWfsPaU1J/Z87kbMbUqJnxJAIutohf+TA9suAs8Aer
	 fkWSfGdWtOkZVo9zzgKjXiX0wCA7hdDil4fx0qCoYPX8gkQPePnC9HFf7FZOVJjOfjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNZiKyNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F85606A32D;
	Mon,  2 Nov 2026 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNZiKyNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B865F1F000C1;
	Mon,  2 Nov 2026 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611911;
	bh=0O8J1AJDW3RflaJPN7IuNL/LtU/ZdZpwEcplV5q5I3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNZiKyNx9JSupF5Wj/aYtT25Rv/iSTckPVQGrowzr0vKrfPGABwJIiJ1UZik6bsxn
	 qi6+AMjS8ahx/HZpX4DZJrkPITRtgrX1ptfEEqKrxsSL56OaNaIaPCKLZpD045y0+P
	 hAHgardWZk30myrKjPeDBZPKkCQ9/yXjZXFSljrdC0hu56PziiPExklcgZC1X3LP2s
	 AfUydW9yW0Iw1AU4NQ6UwW3wvsSgAFdodE+LWLjnauvhC3gSwyTH7OcLYYnWl9FjGm
	 PyakdTSI06QkegfnZNB71SiI+FwsijyhCTmEGRUu2c1vEgkT/NM7sq5JLLNhGYHoMg
	 twKmqCkuTTcsA==
Date: Mon, 2 Nov 2026 09:31:45 +0000
From: Lee Jones <lee@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org, "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	"Prasad, Prasad" <venkataprasad.potturu@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
	"N, Poojitha" <Poojitha.N@amd.com>
Subject: Re: [PATCH 16/21] soundwire: amd: Initialise and cancel IRQ work
 around manager lifetime
Message-ID: <20261102093145.GB13023@google.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-17-lee@kernel.org>
 <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>
 <3f883f3f-221d-4355-a39f-8321f2ebce49@amd.com>
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
In-Reply-To: <3f883f3f-221d-4355-a39f-8321f2ebce49@amd.com>

On Fri, 30 Oct 2026, Mario Limonciello wrote:
> On 10/30/26 07:13, Mukunda,Vijendar wrote:
> > On 10/30/26 16:16, Lee Jones wrote:
> > > [You don't often get email from lee@kernel.org. Learn why this is
> > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > 
> > > amd_sdw_manager_probe() publishes amd_manager via dev_set_drvdata()
> > > before initialising amd_sdw_irq_thread and amd_sdw_work, allowing an
> > > early interrupt to schedule uninitialised work.  During removal,
> > > amd_sdw_manager_remove() only cancels amd_sdw_work without first
> > > cancelling amd_sdw_irq_thread, allowing deferred IRQ work to re-queue
> > > amd_sdw_work or dereference amd_manager after it is freed.
> > > 
> > > Initialise both work items before calling dev_set_drvdata() in
> > > amd_sdw_manager_probe(), and cancel amd_sdw_irq_thread before
> > > amd_sdw_work in amd_sdw_manager_remove().
> > > 
> > > Fixes: 65f93e4096a0 ("soundwire: amd: add SoundWire manager
> > > interrupt handling")
> > > Closes: https://sashiko.dev/#/bug/linux-9890e8dc-4b7d-44d3-
> > > bfb0-171dc421e28c
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >   drivers/soundwire/amd_manager.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/
> > > amd_manager.c
> > > index 98b09d81f3b8..2e1038ea0f36 100644
> > > --- a/drivers/soundwire/amd_manager.c
> > > +++ b/drivers/soundwire/amd_manager.c
> > > @@ -1185,9 +1185,9 @@ static int amd_sdw_manager_probe(struct
> > > platform_device *pdev)
> > >                  sdw_bus_master_delete(&amd_manager->bus);
> > >                  return ret;
> > >          }
> > > -       dev_set_drvdata(dev, amd_manager);
> > >          INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
> > >          INIT_WORK(&amd_manager->amd_sdw_work,
> > > amd_sdw_update_slave_status_work);
> > > +       dev_set_drvdata(dev, amd_manager);
> > The probe-side ordering issue is valid — an interrupt arriving after
> > dev_set_drvdata() but before INIT_WORK() could schedule work on an
> > uninitialised work_struct.
> > 
> > The remove-side fix is already posted as part of our v3 patch series:
> > 
> > https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-
> > Vijendar.Mukunda@amd.com/T/#m60177687bb84758efdd6f5f09eba8ad32f0e4631
> > 
> > The probe-side fix will be included in our upcoming v4 patch series,
> > which contains major driver restructuring and customer-critical bug
> > fixes. Merging this patch independently would conflict with v4 and
> > complicate the review process.
> > 
> > Could you please drop this patch? Both issues will be covered by our
> > v3/v4 series.
> > 
> Lee,
> 
> I think as a general statement since there is still these big pending
> changes already in flight, could you either wait a few weeks until they
> merge or rebase your series on the in-flight version to see what still
> actually makes sense?

I will leave the AMD driver alone.

Please be kind enough to add my Reported-by for any issued that you fix
as a result of these reports.

Thanks.

-- 
Lee Jones
