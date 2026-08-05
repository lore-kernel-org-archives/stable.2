Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CDA34D3B0;
	Wed,  5 Aug 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910666; cv=none; b=jyl3Pnk1Ota49qpje/msxL/hTGm6BeSs2GG+f37WNnr+5BhqSMajb9pylycII1MDDd4PbHjH8veleIiq9+pkLKlQbnR5JtpPreFDj8Bik3J8+tvuM2RvFEZpI6y0motNPkN4EV1b9xIvmrrVjcyowoNUSXkdPro97ITSeMGsT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910666; c=relaxed/simple;
	bh=FB/FNae1flyDvzc89wsGwwxKzPvgPsxMXDMZq/W1zZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4kpynCf2svx4ykZctOMtK+b6iEEwDOPFRHtfthZV86PmLrVivR7xv2tfSfCsTWIncD1fV4jBXw4tDObWC2RiYyHKMvmBPCYOOG9uYjPeM6vquS99OsB0JKrUGEQ6iQ+wX63i5EMAxMu0/8s7vslvLbCONPpiWBjv546PlX+iWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH4OHU3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH4OHU3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F801F000E9;
	Wed,  5 Aug 2026 06:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910665;
	bh=+rVXHv1fwJ4LR0goxtSqE6f0FJMeLLwWG/xlUwrX9bo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jH4OHU3WgHQ99zYnIy7T7m3RceivXUAqUy8jHor8JhIn76DYdfnTzC1ZFYXRw8JiZ
	 3gJBtBVU+kPG77nGK0gGiBcqb9ZYiNEJLR92JtDc+QsXJEV1Zvv4LPTLRqiu4xddy5
	 GkqxTOues/54e0rpsVR/QIiP2nY79t6hK1NZYBSFgiTDRz4h+ydazurN9jgDKpevox
	 +pHBmKMRQ/urHPGDCNTBNsopbIWWDfca9E3KHc3lD8kD2jlvizBEudkss4sKvwBWeK
	 vUUbYQ0KxsI90Qqnr+ee7xCNgStAnQSYCZf60IT+ShWghW7gkMvz42izIvljKvZH0p
	 ZxTtJ8C3nnnCA==
Message-ID: <86f21e7d-c5e6-4805-8b1b-c5239c610bb1@kernel.org>
Date: Wed, 5 Aug 2026 09:17:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-10-f625d6aa0ae1@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-10-f625d6aa0ae1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 13:20, Balakrishnan Sambath wrote:
> ISC_WB_O_* and ISC_WB_G_* each pack two 13-bit fields. A negative offset
> sign-extends and corrupts the adjacent field. Add masks for the two
> fields and write them with FIELD_PREP(), which masks each value into its
> field, so sign extension can no longer bleed across.
> 
> Fixes: 73c1a577b839 ("media: atmel: atmel-isc: reworked white balance feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---


Reviewed-by: Eugen Hristev <ehristev@kernel.org>
