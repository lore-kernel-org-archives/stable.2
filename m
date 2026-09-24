Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB3424D65;
	Thu, 24 Sep 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280578; cv=none; b=tmWgDKdzTU6a4avns1ivCtZzoKfGGeehRJY6HZewOT+brNZUoY9/UZ68YNb2T8raveO4NDgLPcrewt2TVKfEUTlkuWaEeICpibT/6S0K2k/DhHbXXgLw7gJ1lqFdrxM0ollGf0wFsEJEIrkE/5y8MoroO6uSFLRt83tvUBleoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280578; c=relaxed/simple;
	bh=xiwGboSaFFzAzwAYu4wjGf/cNiXgL4uwgNxcO2eZUeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3ekyZWgxrssmmX085z1SzWba6WzKe9g6FRYFeBbHiQsAUS5Ta5K/jmP43kM22+k0R9dcYMbHTQbnI+tviK1vLaP68xpTviclOuuLB6ltcjNoXR2IFOFrMEEzdfCT0H7FMeY9W0HgVFv9QXh9/qPfpcBYl30lPUDZWK2odF3CWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THlq8f9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THlq8f9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0CB1F000FF;
	Thu, 24 Sep 2026 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790280566;
	bh=Hs0BCzAcMdmg/2IuD/yqkyZ4uXNT7Lvbg77vbPufmLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=THlq8f9Hl62x4ls2dnUjMGhrSNes8l8s0YvvCZd69ctiIPvfrl84s8BWLONgNX3Om
	 Y41uD0ZJup5HtZVPKuEDfPPu16HveN65LgndtH65a4N4x9/EOZ1Kf5lgI0wpV3I13L
	 YUeKarcmAO4vivCopo0vV7/kwtcC8YVwax3AtlZFgL9vbnOuYpf/kVujCdXf4lWWQJ
	 VC3YYrUN6B8YbxWlIo4ZQCm2iM0DbKmp0/QE+djN2MPei5KkNPvF0XxRr4/9yZw1Wx
	 cEjg4pJ2zeS2rxkUFCo/TzENjw9LOf5PuuOuWc/DB6GyJGA0qu2UzmZM+YvSAMRy4B
	 NLwNNMuZei1vA==
Date: Thu, 24 Sep 2026 22:09:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
	Wolfram Sang <wsa@kernel.org>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
Message-ID: <arWC6PFh3YVgU1Pd@zenone.zhora.eu>
References: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
 <20260923-i2c-xiic-v6-1-3a15b6397f5a@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-i2c-xiic-v6-1-3a15b6397f5a@nexthop.ai>

Hi Abdurraham,

there is still another issue here.

...

> @@ -546,23 +552,26 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
>  			 * Receive fifo depth should set to Rx fifo capacity minus 1
>  			 */
>  			rfd_set = IIC_RX_FIFO_DEPTH - 1;
> -			i2c->rx_msg->len = rxmsg_len + 1;
> -		} else if ((rxmsg_len == 1) ||
> -			(rxmsg_len == 0)) {
> +			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
> +		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
>  			/*
> -			 * Minimum of 3 bytes required to exit cleanly. 1 byte
> -			 * already received, Second byte is being received. Have
> -			 * to set NACK in read_rx before receiving the last byte
> +			 * The HW needs SMBUS_BLOCK_READ_MIN_LEN bytes on the
> +			 * bus to exit cleanly: by the time the ISR reads the
> +			 * length byte the second byte is already being clocked
> +			 * in, too late to NACK. Pad the drain target and record
> +			 * the real length, trimmed back on completion so the
> +			 * PEC check sees the right byte.
>  			 */
>  			rfd_set = 0;
>  			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
> +			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
>  		} else {
>  			/*
>  			 * When Rx msg len less than Rx fifo capacity
>  			 * Receive fifo depth should set to Rx msg len minus 2
>  			 */
>  			rfd_set = rxmsg_len - 2;

what if rxmsg is 1? Before this could never happen because we
were checking for rxmsg_len == 0 or 1 and we were ending up here
for values greater than 1.

In patch 2 you fix things, but we don't want to have dependencies
between patches.

Andi

> -			i2c->rx_msg->len = rxmsg_len + 1;
> +			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
>  		}
>  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
