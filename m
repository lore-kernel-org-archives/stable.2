Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361846;
	b=Ilw8Xvj/EF38ouCfDPgWsmV5ZE/I5HDQBuCH5XFSsQKMYw/UdntdgBfYw1g8VCCWppNr
	 p2tylxMGheIVp9VAPpiSukHAI/8v7aBKi8M+l8IZeYj+34oNN4Z2/fnNO/P7vvVc+I7Qf
	 K6N31dL3qH69dNNfPKOsJLoJe+jZcvylg+VNhZ0DNY8Ok6D3A85dOjRJEzwJtqasNJp3b
	 ObXA4Zw1Fdqhtcae+UQkhbezy0KEopYt7Wy+nBaezesmu4LVEZBz/Yb8B+Cbj2bKcwKnZ
	 bqsRV+nqDqfIRDNzdcckGGudSgnQ8UJlsCzwTKG+A8SVx3f+wjdQ7v/7Mf9V6/NpTww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361846;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fFskA7BssClkLrdVAmdRHZnh5MEeIpbMmJ/sYbXMQIA=;
	b=oVBlKDpmGI3EPmuCUA1cqP50/NvaCfSCLl0W7gUno8B2LjKmkp2lqHwKQMnZ6nnGxleo
	 8nyco+Mp39y0/JAqvqjN7vbJKGXWxbAZZfczqRk9FQYuaj3RK1nLh9wj5mWp1mYLIk7DQ
	 zy+QF8MiTEiy5E/hHNh1lAZ6mA65nx+kIuE+fWqml9BOgESunKUSJX0VYAEMnaZWlosc8
	 L9xtpzZMRvbu9vInjrBJNDHQqEy6rHVL+402XZrsUqs/tZRjjNlKKxHc1JQY7NFe3UbJl
	 rf4l0Cjj7gWXzE4Walv/uobcE99liRGNZQBCNmCMPDnV9nhKz6yefLFgyUHuM2ZKRrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhHYbPbm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5E606A336;
	Fri, 30 Oct 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhHYbPbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A81F0093A;
	Fri, 30 Oct 2026 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361846;
	bh=fFskA7BssClkLrdVAmdRHZnh5MEeIpbMmJ/sYbXMQIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JhHYbPbmPlUKk7hL0xZnl4tgMCzcNtzmSMl6EYeMpMLyjiAx5yCoMsfsfzPtKuJl/
	 qgItBmRDgUfaBST95tzHm1Twm1SMXoOdawPuR3zhruZji8D6VlFKD8Uxux/zzRSMPC
	 ZYnW8z+z5GgtC9Sn4E0nRDJJZ0c5jwwTGBaVo8ZP0hj4n5gg1EOR9MjHCA/Ds3B5uV
	 YwuAZcc1tUZrcZyhHDpOl/Epyoe1MPGBspjwc7O+y31/8TB5QfSC5rzaW+63Diq5fH
	 +bO1N2sQ8zZXg43wwWvmybfkCF0+VOYS9SQ0k7c6Y5rE439S5I/2OdKCu8S+WN++Eq
	 1tqoFwsbS2lSA==
Date: Fri, 30 Oct 2026 12:04:00 +0000
From: Lee Jones <lee@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
	"Prasad, Prasad" <venkataprasad.potturu@amd.com>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	"N, Poojitha" <Poojitha.N@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 13/21] soundwire: amd: Check ping command response for
 timeout
Message-ID: <20261030120400.GG3774906@google.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-14-lee@kernel.org>
 <a81780c5-5692-4cbd-9f7d-1f64e78e9017@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a81780c5-5692-4cbd-9f7d-1f64e78e9017@amd.com>

On Fri, 30 Oct 2026, Mukunda,Vijendar wrote:

> 
> 
> On 10/30/26 16:16, Lee Jones wrote:
> > [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > When amd_sdw_send_cmd_get_resp() times out, it returns -ETIMEDOUT as a
> > sign-extended 64-bit value.  amd_sdw_read_and_process_ping_status() and
> > amd_sdw_read_ping_status() extract peripheral status bits directly from
> > the returned value without checking for -ETIMEDOUT, interpreting the
> > error code bits as peripheral status values.
> > 
> > Check for -ETIMEDOUT before extracting peripheral status from the ping
> > response, matching amd_program_scp_addr() and amd_sdw_fill_msg_resp().
> > 
> > Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
> > Closes: https://sashiko.dev/#/bug/linux-c3a53ed5-eb8f-4982-a3b6-db189e009b68
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >   drivers/soundwire/amd_manager.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> > index a3316efdf8ac..a8220235a2ae 100644
> > --- a/drivers/soundwire/amd_manager.c
> > +++ b/drivers/soundwire/amd_manager.c
> > @@ -448,6 +448,8 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
> >          mutex_lock(&amd_manager->bus.msg_lock);
> >          response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
> >          mutex_unlock(&amd_manager->bus.msg_lock);
> > +       if (response == -ETIMEDOUT)
> > +               return;
> ++
> 
> Response should be u64.
> This patch can be dropped.
> Please refer below fix.
> https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m786cce22308c97d055566dce17be5a38b5d98e9e
> I am going to post V4 patch set.

Excellent.  Will do.  Thanks again.

-- 
Lee Jones
