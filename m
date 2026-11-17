Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919523;
	b=FuUtTEuuzZyaQn4a75ea+ygc+LRbxDceGIUVnopUhtac+bTvYJVAPGBt+D5nWXjpKWoB
	 /1Tz28UrA0B82SydtWkhskwj69UCJTwAp9u+Sc0ckeuZJpGiNE9vbivFIbZW/0P1Cbdqf
	 F8Qc833o621TnM0oueU3Ry6cg+wLtSuuGPTdvas5IFBLgs+vR733NR6SjIPuxQN7Lk/zP
	 WsRhQZzmHn5iofBuM4LEBSyZ91QTLO4UGHsLVWfSOdR44zactjPiCYI9UoM2HUQJVAFa3
	 YOzTAevEwMnCdlQONS11OY1BzWYxpECCD4fWUOHtrW+qluqBsWTgey8PsY5Mnrx+ksA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919523;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=cjWtc+9FOv9qPhdPN8YTpyzSuRbRmE/Ndq/POWtbu1M=;
	b=uq+InQAlpyIqMS2OFXwaPj3w0Ge6u6S8k83mqlhhCjd5Gh1kHnl5Y8Qss0aIXEk8RQWq
	 uHXKYxcYFQT3nT9LVfQDJasX6aVLQ3Pb78w6IE5hNXoYMoksiqaOXiAdX30nT7NTlnH+I
	 ZRT1EgnEwdQxH9XzPsf0Jm3xhTeSJgIQavykeclJlDNp5bGtFQ6qSaQusmhJxnst8m0C8
	 yfQQ2/kjq/0SZ0BEHhmteCigOfUOV0gDZCKKKKDFECrh6PsuSbBQZLuKkHdrhXgUpnRFd
	 LbEBpFzVsEGovGleX91ajnGCfHnNs4mPCQWAJJAGG3qDscqjt5jM90yNBvVLPwVjMoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlZYEe9J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88B606A31C;
	Tue, 17 Nov 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlZYEe9J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBE81F000C4;
	Tue, 17 Nov 2026 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919522;
	bh=cjWtc+9FOv9qPhdPN8YTpyzSuRbRmE/Ndq/POWtbu1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HlZYEe9JBLPLq2h6nZR7T48h2PfaeLR99uXEh6Ex9GBBB4pFSTSrCDjrSOCvtpIjp
	 RvzJ/9RMDQ2eC4U7+0qp9ALVl+TddAG56fiV4i4dBWdR3h41LcKNAyJYaH4SdoF+qQ
	 AJGnPIou5n9DQTzEw4jwO2suJQDyhGpTzw674OAEGkjRojDcR8962rAIKEkEUXPQcS
	 EgYHKbgkyB5jaKiDT5AZPKA835jXQvjKKajt8jZCvwnfIfbxP2m3beHXVIOmFibq37
	 3tBzCwkyeYSdspVJH84sbezlOOsXQulmE9790gmqyEar1pE7DLnfrO0nz5BxEYWAka
	 OYGOb1cFMERlA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 "Martin K . Petersen" <mkp@kernel.org>, John Garry <john.garry@linux.dev>, 
 Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Justinien Bouron <jbouron@amazon.com>
Cc: Gunnar Kudrjavets <gunnarku@amazon.com>, stable@vger.kernel.org
In-Reply-To: <20261116205430.44305-1-jbouron@amazon.com>
References: <20261116205430.44305-1-jbouron@amazon.com>
Subject: Re: [PATCH] ata: libata-core: Add max sector quirk to INTEL
 SSDSCKKB240G8
Message-Id: <179491952051.3464613.10156120067978467700.b4-ty@kernel.org>
Date: Tue, 17 Nov 2026 13:45:20 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 16 Nov 2026 12:54:30 -0800, Justinien Bouron wrote:
> INTEL SSDSCKKB240G8 with firmware version XC311102 runs into FPDMA
> timeout errors when queue/max_sectors_kb is set to
> BLK_DEF_MAX_SECTORS_CAP = 4096KiB / 8192 sectors. Similar to model
> SSDSC2KG480G8, the issue disappears when setting this max size to 8191
> sectors, thus apply the same quirk.
> 
> Firmware version X5A1ME59 for SSDSCKKB240G8 is un-affected by this bug
> thus keep the quirk specific to firmware XC311102.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8
      https://git.kernel.org/libata/linux/c/3dccf22a

Kind regards,
Niklas

