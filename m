Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.234.4.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475426;
	b=e2gfBITquUttg9L8fgQsZKCfPjSIQGSAQTEErbLew0yBcHuKsh6QyvL1kjGGeTzxdVbi
	 1+PkCZzgzjtr6/sqU9mrw2GMnVyqwaT120+2CZriWgwG3My66va0NzBabf6WVcD6X0+p4
	 6kGkZTnlwVTFZrH8tHW6yFw6EEI3asafV9Etc59PgJOXiVlouZ/0TV96FAlIEwZm8KaG4
	 vklA5u5Xe1yruEDw4CVnFJeI7vLuYQriuq7bX9aojLAqBZjy2gPkUDYEvLUvwc5s3L5xT
	 w93E+e77jIV3kjn46LKisE6/rBt1jxevXU0xSt0RPvx+vDFTM3nHrC5Eoic6Nd21J9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475426;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-GeoIP:
	 X-Spam_score:X-Spam_score_int:X-Spam_bar;
	bh=wvP1IpdD/AteWXcjJU0nzeoI5hxjbUtZch5zGuNerP8=;
	b=TLN7s0la5hfZ7pmAO4+GeRjmlx+T4E38BG42lJcJpvs3kYRUsQPkYqilUn9qKBFHzRQ6
	 BbI9BfmEJQS7uKoPy7JbSDEuIUNvwNbI7WBEEQiDUBuxX+ZUwqHOIMuM3kO9D880sRLyO
	 844naogEyq4vhcgqW+NPLMTgLSpr05QVihaN20T5rRSoMdTRy7F7jrI2IGumGyt9I6PMb
	 hI4WX3uhIRgbFrz9QuDU/Sw6ZpjIOhh+PgFVq9Zvu1jWk1t09t7luxnlITVczvoF4k/d9
	 rI+F9rH3duF9gzKwj8pI0cUt6kB+jOAzCNP5ahC6J3auwmiYpHBw2eeAKcxwCW1FTTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=orcon.net.nz;
	spf=pass smtp.mailfrom=orcon.net.nz;
	dkim=pass header.d=orcon.net.nz header.i=@orcon.net.nz header.a=rsa-sha256 header.s=s1 header.b="H+Ntv/v9";
	arc=none smtp.remote-ip=60.234.4.34
Received: from smtp-1.orcon.net.nz (smtp-1.orcon.net.nz [60.234.4.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FC606A32E;
	Thu, 12 Nov 2026 09:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D8FC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=orcon.net.nz header.i=@orcon.net.nz header.a=rsa-sha256 header.s=s1 header.b=H+Ntv/v9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=orcon.net.nz; s=s1; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wvP1IpdD/AteWXcjJU0nzeoI5hxjbUtZch5zGuNerP8=; b=H+Ntv/v9QVBOsz9oTSYZMoX+9M
	JvGFe0NQdExOREjXfWYswUeXGdmMeK6KLw0nStVcHCePJiOUNQRKLHDk8M8BOUt2N+YaYuMNnsbwL
	Npzx7m5G6iH+aY18SCsbKKqYg2T0uTksVBQJ67mp9hTI6BKuI0OS+5QoZhkrnUxV+GNrtXBDM39S/
	AXbKDAqbF3hr/oqjemzKG6Qzslw6r26cbF+v7IIiOxvEogwl2s7oBu7tFHlsDsVdxv5chCkiSo1xO
	kvuIqZgLc+AIqlIUNZ7N9EQdglMec6xtIJFvaKxeNi49M+6cYpeGiyuSVz0GAak9+WeabAbHM0o/x
	VdZPGsQw==;
Received: from [121.99.247.178] (port=59701 helo=creeky)
	by smtp-1.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1xRR1q-00019G-MK; Thu, 12 Nov 2026 22:23:34 +1300
Date: Thu, 12 Nov 2026 22:23:33 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Matt Turner <mattst88@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
Message-ID: <avWFlTsLx28YI70L@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
References: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
 <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
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
In-Reply-To: <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Thu, Nov 12, 2026 at 09:47:05AM +0100, Magnus Lindholm wrote:
> Hi Matt,
> 
> On Thu, Nov 12, 2026 at 1:30 AM Matt Turner <mattst88@gmail.com> wrote:
> >
> > On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
> > enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
> > hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
> > NULL. vgacon_startup() then probes video memory through that NULL
> > pointer and oopses in console_init():
> >
> >   Unable to handle kernel paging request at virtual address 0000000000000000
> >   pc is at vgacon_startup+0x174/0x910
> >
> > VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
> > failure like a failed probe and fall back to the dummy console. If a
> > VGA card is present, locate_and_init_vga() still switches to vgacon
> > once PCI is up.
> >
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >  drivers/video/console/vgacon.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> > index e7e6750f1f87..09f7c376b468 100644
> > --- a/drivers/video/console/vgacon.c
> > +++ b/drivers/video/console/vgacon.c
> > @@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
> >         }
> >
> >         vga_vram_base = VGA_MAP_MEM(vga_vram_base, vga_vram_size);
> > +       if (!vga_vram_base)
> > +               goto no_vga;
> >         vga_vram_end = vga_vram_base + vga_vram_size;
> >
> >         /*
> >
> > ---
> > base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> > change-id: 20261111-vgacon-ioremap-null-ad4c7184b807
> >
> > Best regards,
> > --
> > Matt Turner <mattst88@gmail.com>
> >
> >
> 
> Nice fix! this must have been lingering here for a long time?
> Cross-builds passed for generic Alpha, including Marvel. The shared
> vgacon code also compiled successfully for x86-64.

I wonder whether this is the reason why my ES45 would never boot with
an AGP video card.  SRM could bring up the console but I recall the
kernel crashed early on.  In contrast, it boots fine with a PCI radeon
card. Not sure if I am going to get a chance to test it out in the
near future though ...

Cheers,
Michael.
