Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236206;
	b=kVuBr3FiXHJ7rus9PukupAhPUAvwzpV0OmeI/bMTYWg0eeVGMdRbJgQ1gCORoTfsBARF
	 /5n4ckMxZHOb6LYKqXZfswKC44hfdEhPs+JGkaZuravXDTxU0IhuoNfuspmmBI05UIK5n
	 +9ejeuWoipg10DNqAOWxjPZT3Yd3ikO/5/gcfbQySzjpK+c6Zqfb7Bdf0MZHtWUB6F+GS
	 v1bMFAe7UCnfa+ye+EVEcx1UNsKsyxhIQFv0Kd0gL7i1ekpehz0ZjrK4ZO6R7rniWF9kj
	 o0+ZH0ppo19blNrHztdlb9V8PTHFAYXMsZ351gI9Pu23jS0GDA1wFt0E7tx7PlIwHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SemDBtKLwrfbPZLwR+LX5x5eoAOLCTArAvt1XOzS2hs=;
	b=d8T2BCaEWwf9dphT7b9Zn1vMDTiuCAyRtYENjj8mXzchmMCoymTXlK2uQDSkSynIBdbv
	 XfFFYPiFeY7a7AdC5X92PzFbslWLcPtEDIjXKAKo6w1wUVAjI8E7yisQvOgjP7cQj40Pl
	 qunVpX5R59xc0bcLADVFWlf6/oFVlIhB4Ogjr9IPes50rhaeq8gYAPPW1NcpIxtEHTWDo
	 lhc0AiR+r00ufPE4zvTdOUK5aZRgZ4dq5tDkk0+vmGLsaQcDNjtuTGAQQYAupc/wXb39S
	 cUgaT9N4lhInodfGhOVnfVLMDjRR8no8vheQ8J2uDX/RF4Gcj8bCyniBnQ9ZLcIYZ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQXDyNKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04377606A31C;
	Mon,  9 Nov 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQXDyNKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C7E1F0089F;
	Mon,  9 Nov 2026 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236205;
	bh=SemDBtKLwrfbPZLwR+LX5x5eoAOLCTArAvt1XOzS2hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JQXDyNKBNRqHNLoZgiIEi2j10l3uSHijHbnXRdkZO4eolUWQmHto641HSSV057+Q6
	 510Mow01Gmk0d+VNLO9dkxsnDoJktmGd3bD2ItDcv9LrznVct1xYWxfDRkrBcXmNAH
	 6qAKQnHq1U+w0jYfeZFb2x0FnlAhmielDCDaJiOx6Rv645rP7o/PirTjclOeCfs+wA
	 Bcqgz96NeRtXrt4aulnJ0f5faaogo2AoDxp2AuARb8a/rWt8Y1uoCkbYLcHQ/ul9GS
	 3iiuLzskV56ja/lGHM++PwpewhbrRFbTtFKipMUg9K70deT/rbujjnn/Lvn5urTwBO
	 /VCHbOwiyVv0w==
Date: Mon, 9 Nov 2026 15:56:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NO_NCQ_TRIM quirk for Samsung
 PM893 (MZ7L3)
Message-ID: <avHfKaY-skamodEr@ryzen>
References: <20261109134541.3766394-1-tobias.kriebisch@tecbeast.gmbh>
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
In-Reply-To: <20261109134541.3766394-1-tobias.kriebisch@tecbeast.gmbh>

Hello Tobias,

On Mon, Nov 09, 2026 at 02:45:41PM +0100, Tobias Kriebisch wrote:
> Samsung PM893 SATA SSDs (model prefix MZ7L3), the successor of the PM883
> (MZ7LH), misbehave during trim on an AMD 600 Series chipset AHCI
> controller (1022:43f6). The drives are three SAMSUNG MZ7L37T6HBLA-00A07
> with firmware JXTC304Q, and the kernel reports "Features: Trust
> NCQ-sndrcv" for them.
> 
> During a full-device trim, queued DSM TRIM commands are aborted:
> 
>   ata3.00: exception Emask 0x0 SAct 0x40e0740 SErr 0x0 action 0x0
>   ata3.00: irq_stat 0x40000001
>   ata3.00: failed command: SEND FPDMA QUEUED
>   ata3.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
>   ata3.00: status: { DRDY ERR }
>   ata3.00: error: { ABRT }
> 
> In the same time windows, queued reads and writes time out and the link
> is hard reset:
> 
>   ata2.00: exception Emask 0x0 SAct 0x4 SErr 0x0 action 0x6 frozen
>   ata2.00: failed command: READ FPDMA QUEUED
>   ata2.00: cmd 60/08:10:c0:82:f0/00:00:d4:02:00/40 tag 2 ncq dma 4096 in
>   ata2.00: status: { DRDY }
>   ata2: hard resetting link
> 
> Both kinds of errors occur on all three ports. In one case the system
> hung and panicked shortly after the trim started.
> 
> Booting with libata.force=noncqtrim,nolpm makes the same full trim
> complete without any ATA errors.
> 
> Add an entry for "SAMSUNG*MZ7L3*" with the same quirks as the existing
> PM883 entry, which was added in commit ead089577e0f ("ata: libata-core:
> Disable READ LOG DMA EXT for Samsung MZ7LH") for SEND FPDMA QUEUED
> failures on AMD controllers.
> 
> Only ATA_QUIRK_NO_NCQ_TRIM and ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD (the
> equivalent of noncqtrim and nolpm on this controller) were tested.
> ATA_QUIRK_ZERO_AFTER_TRIM and ATA_QUIRK_NO_NCQ_ON_ATI mirror the PM883
> entry. ATA_QUIRK_NO_NCQ_ON_ATI only applies to ATI (1002) controllers,
> which were not available for testing.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
> ---
> 
> Notes:
>     The patch itself was only build-tested (defconfig,
>     drivers/ata/libata-core.o on top of for-7.4-fixes) and has not been
>     booted. The runtime test was the equivalent
>     libata.force=noncqtrim,nolpm on 6.18.60.


6.18 was released a year ago.

Please boot the latest kernel, 7.4-rc2, and verify that the problem still
exists.

If the problem still exist on the latest kernel, apply the minimal set of
quirks needed to fix the problem.

And yes, build and boot a kernel with your patch to verify that the problem
is actually solved. (Don't take for granted that your patch will behave the
same as libata.force.)


Kind regards,
Niklas
