Received: from mx-relay38-hz1-if1.hornetsecurity.com (mx-relay38-hz1-if1.hornetsecurity.com [94.100.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B835C19B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295067; cv=pass; b=Tnp+3pD3WBSfToT6pmRUxbSpmR0mcFrS+bjA0UYECey5HTggweWlY7ZGDM9Cjs8oGlKTjj0h78XoEqexemUg2Z2Ub6NhhB59l4wCtP7DTCsFiJ6mUMVu779QXnzB3imf+Tp9yt3LmBG17AzRl4rTARwq2WhQsUcuJZFsohk5VEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295067; c=relaxed/simple;
	bh=dmqPZVgfMRSVKaGhmQWhxyx2Fl2asnnJWzRYPeVvggw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tw22rPJxL2G2Zmn7fpNnnLhiorTrAF12b2Whd4fVma59VoWFsAGkXLDjIZfOEUROE0FbiTODNvnR0MVgVmpCCaZah1Mb1Xv70K+pVXxIgv7ylo4dCfMH5JfmAjxVD2ws5L6fRujt6nx7S4coJy2D2Rl+6tY94rsRey2HXzsVNpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net; spf=pass smtp.mailfrom=marcant.net; dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b=BorRw+sD; dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b=KU8o6apb; arc=pass smtp.client-ip=94.100.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcant.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b="BorRw+sD";
	dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b="KU8o6apb"
ARC-Authentication-Results: i=1; mx-gate38-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=217.14.160.69, headerfrom=marcant.net)
 smtp.mailfrom=marcant.net smtp.helo=rossini.marcant.net; dkim=pass
 header.d=marcant.net header.s=gandalf header.a=rsa-sha256; dmarc=pass
 header.from=marcant.net orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=dmqPZVgfMRSVKaGhmQWhxyx2Fl2asnnJWzRYPeVvggw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1787295049;
 b=hPuJlaicCGyag4Vh0RGJGziOGBXOfyqgZiXJMmdkjAa9yIEFlDnFzW8nwntktfVwiLTzY74j
 YIi9D6WDimMmTYiC7xIwldXmcVudzt2mJS+R58GoqAW3ALdHe6jYGKC4rh7ATIYZvzeyOR+NRC9
 1vvg4fh1JUbbuMANUc8VjNFYBOBMonTkorfI4ZUz2Mh9VxoaXSxJkC52yeFmaqvzVc4jh/n2d8q
 mozcJNVKbOXo0ikv+KEa2fGRka2YAA27Ugcgv2Me5iLBfe1NkIJ5/3RhmNRhtJ676PJq/0xf+YV
 1oQPCDNLbxu9mjwTSrZTSY0g17XKkYTslHpzQe8WjzmfA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1787295049;
 b=X5JBeJehreNS2VmJSodmzMdkHOoMdjITAICZPxD0C8vxr96M/hhXCNIuKffS/ymrXFW2b7iw
 SM2k00ahUyg5qUweQq2AczHTp/vQQTsGLpFPTGCUGY0LWKe0a47/lprOx3RPTUqgPfeJk7VZYKL
 tave0lptefK4pXE5I+7yKxSbNt5Nmdpovir9WmvcweyKIuuTuFk3foAm5BmxV6DAM4ZoaY0IunR
 MiiiW4dqHs3VlIUhUtQx17pJMSXU6aJEsaynQentVKLovLMXKNzMaEGiyrycMdfDGFjEa3VkrQV
 mYhzJKl1VaMkitqs3Jor+v7Ljmb0BHzKXjsVuUMK4kKnQ==
Received: from rossini.marcant.net ([217.14.160.69]) by mx-gate38-hz1;
 Fri, 21 Aug 2026 08:50:49 +0200
Received: from [192.168.203.16] (unknown [192.168.203.16])
	by rossini.marcant.net (Postfix) with ESMTP id 6C8E896163A;
	Fri, 21 Aug 2026 08:50:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 rossini.marcant.net 6C8E896163A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcant.net;
	s=gandalf; t=1787295041;
	bh=dmqPZVgfMRSVKaGhmQWhxyx2Fl2asnnJWzRYPeVvggw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=BorRw+sDKf95caVnrYk19DWyZRj59G1T7Bkq8zIxpAGQuS38ERyBwcbXpb14iSWp5
	 4IcF66CjN4cuCQ2Q8noP1WT/ivVzPBj/rBtnzkpsPvx3rUrJl0FYTEXG7KERE+5rqz
	 3BZDzHjKE6qe/4/3S0cnM5vHPhXp9soegvmZEXz8=
Message-ID: <a1ff9ecb-7338-4b14-848c-d4034a584b4d@marcant.net>
Date: Fri, 21 Aug 2026 08:50:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Andr=C3=A9_Valentin?= <avalentin@marcant.net>
Subject: Re: [PATCH v3] wifi: ath11k: run ahb shutdown() teardown only on
 WCN6750
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260810192859.949348-1-avalentin@marcant.net>
Content-Language: de-DE
Autocrypt: addr=avalentin@marcant.net; keydata=
 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 Gbeh
Organization: MarcanT AG
In-Reply-To: <20260810192859.949348-1-avalentin@marcant.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:avalentin@marcant.net
X-cloud-security-recipient:stable@vger.kernel.org
X-cloud-security-Mailarchiv: E-Mail archived for: avalentin@marcant.net
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate38-hz1 with 4hR9tT5MS2zLlxs
X-cloud-security-connect: rossini.marcant.net[217.14.160.69], TLS=1, IP=217.14.160.69
X-cloud-security-Digest:4ec1c4b26dbc0c14e3d9a22eb319e47c
X-cloud-security:scantime:1.230
DKIM-Signature: a=rsa-sha256;
 bh=dmqPZVgfMRSVKaGhmQWhxyx2Fl2asnnJWzRYPeVvggw=; c=relaxed/relaxed;
 d=marcant.net; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1787295048; v=1;
 b=KU8o6apbZH4Xk3PCBT6QY/R/tCg8eL2wllMSj+sQ/4195d8BUq7faVkj28lZQhzjS71OHqcb
 YfgtxHYBAZ0aRw7bNPflR+qcWhSJhXyQ5UkXzFlgBNySpUb0PsYjEd/85wBi3CyRw1g3PNXTsE1
 2CuNOBr1fwbLBXfiqMsLXpC6npBC0eLu8ApT16agi9NWI5G2RQzHvlZlyIRwSerGq/oEyUhz3ZW
 meX4QN+VV7yHNU+K/kvCuiwSUwKHUMeFjU64qS6qavl7k7akOdtPOJePNp0Zb4JQaHGpyF43iZM
 Z47Do6cPvEnNj7eYrgfLlNHJue8Gf+87G1JrufjInyOIw==

Hi Jeff,

gentle ping on v3, sent 2026-08-10. It is still marked "new" in patchwork
(https://patchwork.kernel.org/project/linux-wireless/patch/20260810192859.949348-1-avalentin@marcant.net/),
so I want to make sure it did not simply fall through the cracks rather
than that you are waiting on something from me.

v3 addresses all three points from your v2 review:

- ahb.c and hw.h use the /* on its own line block comment style.
- The comments in the generic code describe the behaviour only; no
chipset is named there any more. Only the ath11k_hw_params initializer
correlates the feature with the hardware.
- .shutdown_teardown is now initialized explicitly in every
ath11k_hw_params record (= false on all but WCN6750).

Is there anything else you would like changed, or should I resend as v4
with a fresh base?

For context on the impact: without this, a plain reboot on the IPQ AHB
targets (IPQ8074/IPQ6018/IPQ5018) stops in the boot ROM during DDR
training and only a physical power cycle recovers, so the affected
devices cannot be rebooted remotely at all.

Kind regards,
André
