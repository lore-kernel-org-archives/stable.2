Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5730D403
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788898; cv=none; b=NXT6z/koJ/LYIaNWOtNnhL//Lz+ni8qWJhrjzi1eg0rm6Iv+2C32b8HugTEqkxXx0c6CA/f7hFYYER20kqhdUZFNSfFEAyiRhQFLDYJjj6SbCj1ss6BJU2hip66JO4N4SkftAadAwcCDZ5M8p5Vtz6zHkYhJCPTCDl6L2FqXOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788898; c=relaxed/simple;
	bh=DMyHLafdGRp2TK42AThhS6zHgRAC9enbNNZVGg6k9nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxS5mA8OBLbIv18j3s/0rGBomgZWwQd1eEK3vTzNqPU9MPhPESJe0r6UdhOCAIielUnkfBinpp6CMcT9ZhN/lTr4cx18wNnbiJsZYDn8b8hfH7W7VABRZ2Wo+1rpLt326EE50aUXHwBHQ3HHApQNwqiftuvD2fD4dnYxfHiFaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duq+Syu+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUWyjNV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duq+Syu+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUWyjNV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785788895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wX+bqNXzbUvOFq+BzRqzbHoTdraqMXAamIS5FpWS7aU=;
	b=duq+Syu+QAQr1yMkoilHt0PGRdqe/Ae8qb+dy+I5Zv2T9kyZ3UY0T0Z+PdygpScNi6otAw
	pgcKNnPGsvbHIYlcIivzVe57wKQE6i4JB2G9+89bYai2eQg8OvCn0oq8M9bSLaQE1IS2g/
	XKpEiF4pG7dPAjuVoJsd9Pyl21V93WA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-APL7Cl_zPDejQJN-RBPi9w-1; Mon, 03 Aug 2026 16:28:14 -0400
X-MC-Unique: APL7Cl_zPDejQJN-RBPi9w-1
X-Mimecast-MFC-AGG-ID: APL7Cl_zPDejQJN-RBPi9w_1785788894
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so373093785a.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785788894; x=1786393694; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wX+bqNXzbUvOFq+BzRqzbHoTdraqMXAamIS5FpWS7aU=;
        b=jUWyjNV8KhgGKkADBAxjAF4nSSk62yClO7pJuA8U9CMIF2jnzOUsn9scDSrcXN/gSU
         1RmQsKNoy0FjteKgDpijUY6pZOJPoq9L5TEX8I3sYayQpBz0P+1PMnCCpVBOvuxNQ6dF
         36+q4qw+xXdcFxH40N+m7UuMxzvAkOi+breFRKp3VmfwLjpPwGCKlp9URMGSoTt9XFHO
         Pj6ovye90Vt82EjtCHQoOXEUbRjclWOpZ+aI6WQkMujEePicfg2fgsx8CDPuUYbLLfeA
         n7rvWGiUIFOofIxq0BVUiErGnTUgzGxOZgkLarqETPIeZd6JtIzvKOk65PcTlzKwx5Ty
         pzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788894; x=1786393694;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wX+bqNXzbUvOFq+BzRqzbHoTdraqMXAamIS5FpWS7aU=;
        b=dlaN56eutnYHZN673y9jKd3K4QesQScdP4cAiwO7z20bRbMITNQC9pVNpTiPl43vAU
         1TOynidTgXPINoXNsLKIn1qDMNwrLjQml9a82xOEkNNYbeRQ7hk+eU3Tgqpm6EtPk85a
         NOOD6abaUWJ31EB7XTqMr/xdhJAaRy6CZ072KYZaeYKvl1nouX2m5CzKCpaRguaTmg1C
         F3K2ycxvZMO+rd4vywDwljfp5EAaOz6zW1Dqz7CsY1K0oxe6JzamKPNAdyH62av4gy7i
         ntedYG447sVlDnpml6j7nwAaPM0uSjc5iD9LMYqtZDlYYYvAFojSGu6dpCTFH8Z2njZ2
         RkAA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2BXHCXggdfoje70ZYQuzL/RvDGlfVw+Va0Flw+d8eYYPMFwzAdmrivC8TXofP6xwePYwvUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEUaxoGidiOl5BYH+LHgtYNAUmvpQhPuSJyi0m3br3yJcN8J8
	VLx68rvgIvXZ9VKJet+ClLWEd7KiSUkBOAQn5TOC9YfntlHqzxdG1yRZfxU5X/Sdkp5ALfVMlvk
	/wT8e9vETZBT01VE1rNO+VS40fQqxQZgKkDpBP+g9rCXN7pPtOGTLeiDejw==
X-Gm-Gg: AR+sD108xbekzQYuP49tvtkewdqfmK9/Q4zw9a/a4rGJcwsWcxtoFYy9DS17XLGk1e3
	SsN08r5MslYG7W6zjo2XhzH3a3Q7cVmhj22Nq/kNTLgMa8tRyhZ7nDfqCegOxmLzz+/1aNymWrg
	wRGpEArhoAabkgmAklQFadYv7e419FObo8VpEzBCotrDbxwbWm2l6ZEznwZBX0q4Bk1c9fFvlmJ
	+9gcbTBh8BqYKrsq0lv8iQnxNaaKbBSxy2Lnqxgz/IsznHBPY0SbU9JjoXfu20SeGEWVwpoO8Xr
	sml4z1pwiPLRPrp1tVqMem/hivSMoBdqrIoKJQYoR+y5qqDpyy4AY6DZ2CJTE0XLoLh8mSVIgA=
	=
X-Received: by 2002:a05:620a:a0db:20b0:914:e3dd:17ea with SMTP id af79cd13be357-934a07873b9mr1716839485a.12.1785788893643;
        Mon, 03 Aug 2026 13:28:13 -0700 (PDT)
X-Received: by 2002:a05:620a:a0db:20b0:914:e3dd:17ea with SMTP id af79cd13be357-934a07873b9mr1716836085a.12.1785788893100;
        Mon, 03 Aug 2026 13:28:13 -0700 (PDT)
Received: from redhat.com ([2600:382:8125:3ab5:9f4e:536:3d0c:6b89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc25410sm737190485a.7.2026.08.03.13.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:28:12 -0700 (PDT)
Date: Mon, 3 Aug 2026 16:28:07 -0400
From: Brian Masney <bmasney@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>, Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/32] clk: mediatek: Migrate to common probe/remove
 helpers and fix memory leaks
Message-ID: <anD518s51UBvJHj4@redhat.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
 <20260803125034.49055f62@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803125034.49055f62@kernel.org>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Jakub,

On Mon, Aug 03, 2026 at 12:50:34PM -0700, Jakub Kicinski wrote:
> On Mon,  3 Aug 2026 23:16:27 +0900 Akari Tsuyukusa wrote:
> > This series migrates most MediaTek clock drivers to the common
> > probe/remove helpers provided by the MTK clock framework.
> 
> Why are you CCing netdev on this? None of it touches networking

I saw that message from you about two different mediatek patch series
from different submitters. This series has 38 files, all under
drivers/clk/mediatek/. If I run get_maintainers.pl on each file path
individuall like this:

  $ cat filelist | awk '{print $1}' | \
  	xargs -iblah echo ./scripts/get_maintainer.pl blah

Then netdev list doesn't show up.

However, if I look at it as a whole, then it shows up:

    $ b4 am 20260803141659.559129-1-akkun11.open@gmail.com
    $ ./scripts/get_maintainer.pl \
    	./20260803_akkun11_open_clk_mediatek_migrate_to_common_probe_remove_helpers_and_fix_memory_leaks.mbx

    ...
    netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_))

I think it's matching on this entry in MAINTAINERS:

PTP HARDWARE CLOCK SUPPORT
M:      Richard Cochran <richardcochran@gmail.com>
L:      netdev@vger.kernel.org
S:      Maintained
W:      http://linuxptp.sourceforge.net/
F:      Documentation/ABI/testing/sysfs-ptp
F:      Documentation/driver-api/ptp.rst
F:      drivers/net/phy/dp83640*
F:      drivers/ptp/*
F:      include/linux/ptp_cl*
K:      (?:\b|_)ptp(?:\b|_)

I think it's the K: for the ptp that's matching.

$ grep ptp 20260803_akkun11_open_clk_mediatek_migrate_to_common_probe_remove_helpers_and_fix_memory_leaks.mbx
-static const struct mtk_pll_data ptp_plls[] = {
-	PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,
+static const struct mtk_clk_desc ptp_plls = {
+		PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,

Brian

