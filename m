Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920125;
	b=W3dVV2+ZL8fGihuRkseMNAsYE81YNSHDk0C4tkJp9HhwB70f3RzraE7ek4vdQpegjn65
	 l5M9Tm59dRU+/kBuSVTLTA/Gz++/+noDrVJQ7lFkyWP5P3DETAUny4j2VuYLE0xuzHT6H
	 rf71Ak3G9j+OOWkqw8XfxJ6k4dRVohofUk1maT1CkBYnMiH5IgN9EU04+13Wl+rTX9Dj4
	 s7xkba2yma+7pd8NC45NG2iwz+NcMuL0YUK2PsVJeSlZdJx7pTUCFXBQMbFw3laeAfO1k
	 bBoA5bDbcQy/7WVC6osVFZ0kz1CVRwEPN3uW9A+9MuoMYxQ1mxtj68S3TRC50bRnSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920125;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eMdm5R6kr9FBKHBQZ//DR8je0iHDg73uHiHu/KHyhUU=;
	b=dI9slvKdF+iYxWY3L+HYeBAD44e4rdlYCH9d0+MJz74vnsJm7A08wgftyea6RKWY+oQk
	 3a0cEnNwra/YDuxxTK1k61vJRXhclHUauD/KMzdQ7JiN8gA/iDMTew/fNIggk59M/u7Zf
	 9SivlcXhCXuNbigMmZJlsroQop+nsxPNCBwwRsoRgeX356SwvDSOyye7tN/rwtqBlXOaf
	 f1j1IeTKnt6It97YHJpMIYKbo1IUjpO7AJ+tkHmay+X6hTV/auoMJdnmFt5w+srUE3tQ+
	 Br/tB0PEK3pJ+nOMxrS4pVTs8t0br3CLQQcLanPkBjpaZA6qQacje0yYV1c85br3qsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghSrE+Kb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B19606A32F;
	Tue, 17 Nov 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghSrE+Kb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F21F000C4;
	Tue, 17 Nov 2026 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920125;
	bh=eMdm5R6kr9FBKHBQZ//DR8je0iHDg73uHiHu/KHyhUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ghSrE+KbMEoLJMEAyMAz01tGCL/ewJ8Ly84wLkOtBOCzWOcKNdKdT5/FtCixN+/NX
	 OewAjrdv4UDBxYRE1K8IhBiTXM2mpUihYbG/CNsUEx0dRg0xak+hoah9PesLLTaEqX
	 lr+iQDN8D/gVvJNqSBg/EH4z/IKISX4LUpjCEmuTy9UcX03nOm+eGF6UzwSMWsH0VS
	 BN2GdyyDAWE1Qy23RF4E1AA5IXeyOPR8ZhVFgizvqH//sXFlg07lFnxA9NI12HaeVL
	 ERTUG8VLY9Eq0gtYaDv4E5VerKtnxqFSCSdAo1NjooOCi3ywFvvi4MZ3F43OcjcwSX
	 URNHic/rdHS3A==
Date: Tue, 17 Nov 2026 13:55:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	John Garry <john.garry@linux.dev>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Justinien Bouron <jbouron@amazon.com>
Cc: Gunnar Kudrjavets <gunnarku@amazon.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add max sector quirk to INTEL
 SSDSCKKB240G8
Message-ID: <avxOtx5ueJXmYMlz@ryzen>
References: <20261116205430.44305-1-jbouron@amazon.com>
 <179491952051.3464613.10156120067978467700.b4-ty@kernel.org>
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
In-Reply-To: <179491952051.3464613.10156120067978467700.b4-ty@kernel.org>

On Tue, Nov 17, 2026 at 01:45:20PM +0100, Niklas Cassel wrote:
> On Mon, 16 Nov 2026 12:54:30 -0800, Justinien Bouron wrote:
> > INTEL SSDSCKKB240G8 with firmware version XC311102 runs into FPDMA
> > timeout errors when queue/max_sectors_kb is set to
> > BLK_DEF_MAX_SECTORS_CAP = 4096KiB / 8192 sectors. Similar to model
> > SSDSC2KG480G8, the issue disappears when setting this max size to 8191
> > sectors, thus apply the same quirk.
> > 
> > Firmware version X5A1ME59 for SSDSCKKB240G8 is un-affected by this bug
> > thus keep the quirk specific to firmware XC311102.
> > 
> > [...]
> 
> Applied to libata/linux.git (for-7.5), thanks!
> 
> [1/1] ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8
>       https://git.kernel.org/libata/linux/c/3dccf22a
> 

I moved this to for-7.4-fixes instead, because of the severity of the bug
and that it is quite recent.


Kind regards,
Niklas
