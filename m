Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858F2222D9;
	Tue, 18 Aug 2026 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078755; cv=none; b=joA3OSuc5NPiRJEtG+b2KTcop8S1SspFzv5xEegbxPzek8ylaYvSaLGX4C8PnfzuPKQq9+bH5H8cFEEmNXP/AXjoOPIaqEOMMojoPIxdnKAYqSdIorTJWge1EmgsV0QrE4jU9dG/vXCqmcFQUTS8Cu3+6BQuBn7FBmkXTIXVPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078755; c=relaxed/simple;
	bh=rVv+beSIE4GQl49THNf5fmyLdbnzLP3wcwZ1ob1Xp4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RVgcF30j1v7dOPuNLtL17/CtBlrERYQUMF93p/mdLWhLJnMm8eHHUD9AiI3231p9cd14Rqmw3YrSCeGBIWneVl5qk+oQa95Bz9VPBV4jGYw3jvcJsQTC56D0eDwiMjnSEQdXGtrp6CGDa4xMb9hPfEpfZjgaicswxqdveuAFguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=J3SeZWSE; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="J3SeZWSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787078749;
	bh=Chux8EQfputnm1UsBXAnP7Y/g4C7XYnKFbftytw/k78=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=J3SeZWSEzHotDdrBGucxPU/IfOxnxW/mDI9EtSuUcR+AmgX6wvIt2wBiReUqQyqVI
	 dNQ5xBRLi53r23EzUgk5vXP4X6yAP2GM5rYLv9rWAd4qxaSRir7NBDPSmtbzxZ4CU6
	 1htZg6ZceIAZPnWkyS2XfG9NzcsUMkWfPz5YAvQE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hPdv10Nn4z10tQ;
	Tue, 18 Aug 2026 18:45:49 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hPdtz5F1gz10qm;
	Tue, 18 Aug 2026 18:45:47 +0000 (UTC)
Date: Tue, 18 Aug 2026 19:45:47 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Petr Mladek <pmladek@suse.com>, Jinchao Wang <wangjinchao600@gmail.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, Rio <rioo.tsukatsukii@gmail.com>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_0/6=5D_panic=3A_fix_panic=5Ffo?=
 =?US-ASCII?Q?rce=5Fcpu=3D_redirect_races_and_NMI_bypass?=
In-Reply-To: <20260818114158.cc20b0cfcbe730a30597b466@linux-foundation.org>
References: <20260818163806.17460-1-include@grrlz.net> <20260818114158.cc20b0cfcbe730a30597b466@linux-foundation.org>
Message-ID: <0EBA4DAD-7B63-4AD6-B1E7-523D09E1305D@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 August 2026 19:41:58 BST, Andrew Morton <akpm@linux-foundation.org>
wrote:
>On Tue, 18 Aug 2026 16:38:00 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>
>> The panic_force_cpu= parameter redirects a panic to a specific CPU so
>> the crash kernel runs there. The redirect code in panic_try_force_cpu()
>> had two races and an NMI bypass, all found by Sashiko. This series
>> closes them and kills one more hack that the rework turned up.
>
>Thanks.  Sashiko had more to say:
>	https://sashiko.dev/#/patchset/20260818163806.17460-1-include@grrlz.net
>
>In the first one it suggests va_copy(), but perhaps this would be
>better addressed with va_end/va_start.
>

Sashiko said there was ANOTHER bug, I might just screammm, at this point,
some sort of superhero needs to come by and suggest the fix that sashiko
likes :sob:

Thanks!
