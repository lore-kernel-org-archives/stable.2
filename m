Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600302;
	b=P0dJryOYDQg4X/lwzZYXL8V5GCR/1J4TC3xKD2sGdfdmQMRxa0uHFCpjC5o5u1xyCsWn
	 WPk7fLWwg8BZ1AYDFnNwoNeyaPMsvixmHjhqAO0ZvsA/MW7PcaH3NuCVhXS5RQjlWDcXj
	 orZSF2Nfhxpnm7eYDlGRfgNqTMYuAmtqV3SxF0p8iXYlaSdYE3Ot7jzBSOw6HFXa2Ix0r
	 1I33QvsdLsvuXNjjGKPQpqLPrIOEAIAQk59AD089Xx+3Jay0yH0qImPLLNYV7GLk9+Hqq
	 fdcjtOCrLwVwTBvj10BUfFZezOzgcUdPcFAlA9QD4DNuQ0tAeEkPWr3TKkyEqRFhlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600302;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iyeZf0XP/ze98T3O+lqqi7V4HOHfHGgZqjL9qn1bdgw=;
	b=kzlhNidYM6YEqDXh/WQpM8PfNSn4cU1QljNsVZvQqyph8Ml34EbQP5Xp2WONVhJJMRL+
	 M53Yjqk6vbl9ApP6ZOE+BzR6dc93VgsE9yyEUnqGoDAP41YV/mitAMizN4phyU5xKwzy0
	 0WgCG4WxCNQAtfEBQ6uuMCRKLlusbccPB18eID8gc5qlciJoiBlzMk74SXYrRsc1Ndx37
	 bH3tbnHbnTmUh4uCOFaee02uPUo0C0iNUha1Qm1HRMtVhuo6028aJiEEI9t50eNz6crKG
	 /mH9Pf/XGZTPTUTfaZ/4gdbiUsqvTEog8jNywt7ObbRl2jsldxbNml7FsP4rWhHdgNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BjtOEiZy;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37928606A330;
	Wed, 25 Nov 2026 09:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37928606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BjtOEiZy
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795600297; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=iyeZf0XP/ze98T3O+lqqi7V4HOHfHGgZqjL9qn1bdgw=;
	b=BjtOEiZyfLncJ7SGuesfw0oRrIMyEMbeSruAxcYnktTOTruziroY/0hdljj54D38imLm9ihSUrjFoRz13NdIZqt89vLTEh7/2KRSS7IBz4rg+B/jst4T4lv/RCuR40rGgQyKmxeG/reIe2eRl/sDGveP/kTCK+P6PW8hzGDu3J4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fengwei_yin@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XFRAeva_1795600295;
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0XFRAeva_1795600295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 17:51:37 +0800
Date: Wed, 25 Nov 2026 17:51:35 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	Ashok Raj <ashok.raj@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Cong Wang <cwang@multikernel.io>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_sdei_nmi: Send the backtrace IPI to
 CPUs with SDEI masked
Message-ID: <awavp9a_33NX7rtJ@U-V2QX163P-2032.local>
References: <20261124194707.1030653-1-kas@kernel.org>
 <20261124194707.1030653-3-kas@kernel.org>
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
In-Reply-To: <20261124194707.1030653-3-kas@kernel.org>

On Tue, Nov 24, 2026 at 07:47:05PM +0000, Kiryl Shutsemau (Meta) wrote:
> sdei_event_signal() refuses a CPU that has SDEI masked. An NMI
> backtrace then gets nothing from such a CPU and, after 10 seconds,
> reports it as not responding.
> 
> The CPU is in a power-down idle state or going offline, and the regular
> backtrace IPI wakes it. Send that IPI to the CPUs SDEI refused; every
> other CPU still gets event 0.
> 
> A stop needs nothing extra: smp_send_stop() has sent its IPIs before it
> signals SDEI, and a CPU still online after that is reported as not
> stopped.
> 
> Fixes: 0c2c56598cc1 ("drivers/firmware: add SDEI cross-CPU NMI service for arm64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>


Regards
Yin, Fengwei
