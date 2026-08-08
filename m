Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D36383C6B
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786171476; cv=none; b=pK4esY5PdPOILlLMC3twIFncYCoXt8nbTLjY+lCjLPuClsWaRnGUr2x731IziUAiruu3pUiqOcKuqKvJ5O+8PLaN5kH76S1B1Cf+z3+KpguJeAywGvAq1kAdnomHwLkXN77XPQdzvr5RxWO0M3PYEmQNYSaq380h0IB92IFgIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786171476; c=relaxed/simple;
	bh=M/Qp24d7AQPobPqz77kL5+0YRq2C+cjqQ9d92ywDsYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+6s2JtNGoP0g3naWPjHDgLkIywO4Wbhghlgoub62ZQZ84ReiANJ0JSq/GIlyAtC4oFMSX+Qr7EIf2IBvGfnj/42FlWIYZvu7VUGHXs086vQCdaP6eUwvFp7HI0NA2WDrlFOY6kD5DwMa/l4cFjk+Us03OHZZNC4c3E/MM3MzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhTu/RL2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhTu/RL2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacb8416a1so2807305ad.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786171474; x=1786776274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7PHlSYB+1wYgvGMRp4f+WoEwtmY9OUjUGH1XA1YdgyI=;
        b=YhTu/RL2UpkNWL+xFXybxigHn9N8X/3cMQVTXs/uUD5IZ68EA2yxhluN2zJCBgJrf0
         qsfZ3ZL9jEXYnXg1EHyGiBAMEaUlG4ykCwjvhUPRj7ku+Ta8Sf+wSRcndOhp3KoVtxlq
         Taa5ThvEkV5bHzTuHubc1tU4TXUjPvT2TVTXTPwXJjfKC+xTUNd+upt8ahv8xnD+4ufh
         AwJ6de5T5F2KSIH5Diu0KvEfdjGUBcCQdtwc5nJkQJFCOTCCpx6/gOh00yO0U05Nhdn2
         FkOxY3o/xA1tP97eri6pnwkSviuNlunGLa0tW890et6/s/lJCKL7rSkzqr4dh4MsEU1H
         ckCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786171474; x=1786776274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PHlSYB+1wYgvGMRp4f+WoEwtmY9OUjUGH1XA1YdgyI=;
        b=HwlQzBnEo0CE53GxOQG7fwrCFxIGFoKn1hS1/cC4upqodyynNTb51VkR9/3bWNrd8W
         Tn+P4fO+rHy8lXqzSmHWN+E6qYykcGsyGGItIrPaF+OA5+acZblei1EvYJrpMui7jV1t
         jiCSLqKHdcAZpYkGESAELvF+2zDL0tnn1DG95Yb3iBnycwusKj51tYcnbCTv8O9vKUgV
         O2QR1cA+kT+tQev3nTMZnwJrsdOlrPABFvDaPP1KhK9RP0yha1J2An2WXV91WxNy7DtL
         VAwXOFjrsf6N89QuwMPo7e9AoCLftIdRrK+fyAMMT6o3Xww3gs2//0dSyGa//VVsuhNm
         5kRw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+/7NXYwQ1KHAB6W/6QJisQQ+PuYEQL2dKsNLyLpPn+1hLriPBmOn/VEkao7ZumSf22hzlHSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAJaDv9yXedIUT4Yb1/S1W3V+IghNRDVPG5P3SNf6DZ5PYNmZ
	YzkauvZh0BwnkF56ZXTOK6Lo1MkExTcTL47QvDEaYctvG8ywxoszuYRe
X-Gm-Gg: AR+sD12WCUoaHDGJjLmE5iEKav1e2xLvM31H7PkRbpsvZeV10HdDLp6LUQedRhu1zVL
	TODMvF5T+fkzHZ/nATAsyjyXFUMx5mddFmyRXfBJWnH4m5aV9BpRicEaYkaDRKeUOgwd81Uqq4p
	rKSH72hJRCpClkXhjGXvaHxx5VRn1Mg2/ipWQZ1hTx1yjl9nSyobT5HxasI/tf8lWUyGNSafnZn
	/QTl6h0qTWCuNcneOC7BtXIaIl2U6KmMQAFu72uVD5YXKL/XwrIJo4eOLRSSlH3M+BnnqckZebX
	GsAaWTauXjj/MvUFZxG+YtbyZxhM8fFlRkG4cNAejOtp3zqzxmT6Y/5kw+5NfDDFSSQIchMHVgY
	UlmvtT4LAlN0Qhdg2BL6buFSLbd7XqlQz2iPsBca0kPr1d5qxDIng70JTdkHBdXLxu+jJPH2OR4
	NQ5wvrtKBmb9sFzYZgBSjEetKX164f4YdcYXy368FntvVoPz75SQ2fQkE=
X-Received: by 2002:a05:6a20:2d13:b0:3c4:396d:4a7f with SMTP id adf61e73a8af0-3cbce7d0551mr6695809637.15.1786171474289;
        Fri, 07 Aug 2026 23:44:34 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b3adsm1518804a12.17.2026.08.07.23.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:44:33 -0700 (PDT)
Date: Sat, 8 Aug 2026 14:44:23 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com
Subject: Re: [PATCH net v4 2/4] net: hsr: shrink seqnr_lock to sequence
 counter updates
Message-ID: <anbQR-XiDQ0G4cPo@fedora>
References: <20260803222211.877-1-xiexinet@gmail.com>
 <20260803222211.877-3-xiexinet@gmail.com>
 <anXrR6-2UVYF1iZa@fedora>
 <156d1de2-927f-450c-a809-dff6892d527c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156d1de2-927f-450c-a809-dff6892d527c@gmail.com>

On Fri, Aug 07, 2026 at 04:49:36PM +0200, Xin Xie wrote:
> On 07/08/2026 16:27, Hangbin Liu wrote:
> > 
> > Maybe use a shorter commit description.
> > 
> > Note: Avoid these macros in fast path, prefer per-cpu or per-queue counters.
> > 
> > And the counters in hsr_deliver_master() also need to protected. Especially
> > multicast.
> > 
> > Thanks
> > Hangbin
> 
> Thanks.
> 
> The long commit description was from v4. I reworked and shortened it in v5:
> 
> https://lore.kernel.org/netdev/20260807140751.1351-3-xiexinet@gmail.com/

This length is much shorter. It would be nice to mention Felix's patch, which
is why we can remove the lock from forwarding path now.

And use tag like
    Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR

as Simon suggested.

Maybe also

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481

> 
> Regarding the statistics, Paolo previously suggested addressing the HSR dev stats races in a separate series, since there are already several occurrences:
> 
> https://lore.kernel.org/netdev/4fc3b9f1-4bef-4b34-ae7a-e89037cce829@redhat.com/
> 
> Would you prefer that I drop the DEV_STATS_* conversions from the next revision and address all HSR statistics consistently in a follow-up, including hsr_deliver_master() and multicast, rather than adding per-CPU accounting to this series?
> 

Makes sense to me. The counter problem should be a separate issue apart
from this one.

Thanks
Hangbin
