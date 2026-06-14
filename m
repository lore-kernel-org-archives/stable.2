Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B01FC7FB;
	Sun, 14 Jun 2026 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475262; cv=none; b=jSKj1O0sZfGjHJZtny0giL0lt5UQEAF27V0vAS06fcP8GSZrCymPHe+NR2F/wvW6RAph3/TAyMoAgucP0p/2e9j+7JNYUvR1yoKbo8dv6fLK79X+nq9XxSsQOTFyIsqhNuWVknS585/kQl9Cvn25CE4esPlo/btQV6/HRTfwEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475262; c=relaxed/simple;
	bh=+E3d0LLzA0PaeI1TlJPLlKpJnQsoR1bCRLmFPH3SYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXAM8LOm1xkKQ0WNrs6w1z7ZrgBSjp3HCiE673tldAovhaq29Lbmg279a38bJ+KFEo4Lwg3LUmWiPWX+E1jIzVwxGTZv9TAW/c01iusnm/RdMoR/tOsN0QL5pb5fnW6oZNWlgRumlgyNNaD0iWgwfdau2dx+EbNAf/6GrjWBzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HIbAbVud; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HIbAbVud"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aoouwIl7ENWFJcsKQwFnZPx//JfMbetXKC3Kqh1HdNY=; b=HIbAbVudDeCzIlARtEGn/DlQl9
	2382Mvs6aHVELbjukDg/2u+y9823wKm/qSAsfk4S4d3lrCvRq/HWbcDuBua34khCh6J8VVTlZdbJ4
	r8ynAIJnhdpoSXWgM/oEtBsQAgPcpTJ3W0kOTvnRrkbf+ElP3qehqs6n6OvO1FQUKOt5x7hk/kMt9
	P81xCFQAr4T66cIGXAstuO+3EleyabhEH7Mh1kidvm1mev/VgWSAQXlWgugt8XaiTTiyEiFACdG5t
	927yJaXHunSXsm0nZJ2J7VRRFn0J6cn2sDbRs2VlF3O22P9y7QJGjLiuL5tlnvntMHE3mvysPgwKC
	aj8YdlkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wYt5k-000000004xx-2dXf;
	Sun, 14 Jun 2026 23:14:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wYt5h-000000008QG-2EyH;
	Sun, 14 Jun 2026 23:14:05 +0100
Date: Sun, 14 Jun 2026 23:14:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
Message-ID: <ai8nrc0ZUfPaqC_7@shell.armlinux.org.uk>
References: <20260518014920.135011-1-enelsonmoore@gmail.com>
 <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
 <CADkSEUjsS8bOXDhgZ2EW40xifDZ-pk5y=YqyWT-+vQNd8JikUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjsS8bOXDhgZ2EW40xifDZ-pk5y=YqyWT-+vQNd8JikUw@mail.gmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Sat, Jun 13, 2026 at 06:50:40PM -0700, Ethan Nelson-Moore wrote:
> On Mon, May 25, 2026 at 1:18 AM Linus Walleij <linusw@kernel.org> wrote:
> > Looks correct to me.
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> >
> > Please put this into Russell's patch tracker!
> 
> Done!
> 
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9477/1

Should be s/arm\./arm/

Also, you can use:

Link: https://lore.kernel.org/all/CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com/

in the attributions in the commit message to indicate where more
patch context can be found.

Lastly, too late for v7.1 as a fix, I already sent the pull request
for that, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
