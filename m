Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B162EFD9B;
	Thu, 16 Jul 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187828; cv=none; b=d5CQUeHzWFmVFCLORBXOvLctSON72KhqNKk8UfhVpYc5TH9Xx8Rff1pLXRDqeywRqsZmijDVspv8YG4YTZEFvYf0RaeGmOFFE/Sgas5cjNefOVCtxFrAmkodWLeuSVBIVXH01uIWRZPqb+bQBBfs242WiyuAplrle8eQcCpofLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187828; c=relaxed/simple;
	bh=CYIU/WfEdsgYpmklPpL+V57MQb2lAQ6u3qXpxCoErvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXA0LwJnW28REoD+YVxGq49age0GQyZk91YkqJ5ui1F9GPr6/40kGUqM9Fcsri9R9usdVeLRMgX43R7MHzI3gCLNIdk8J9q7wBBWTmt6Gp5ksZZcpM2QVGhZp+VQm4Mzi5wFSq/3Re4iRAGCDvfNzL8+7FINRvM9TMtStUf/0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSZXU+ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSZXU+ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043111F00A3A;
	Thu, 16 Jul 2026 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187827;
	bh=70PNDBvM1M/PoK2rZwGoe/F2/3LKI80XvueFv8+d5pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WSZXU+ra7+BavCMLVGS6bVy7xf5bO23HFO0zmGLEoPNIL1a5TEcJzlNeg0nG2I7Ej
	 57BpzUSunooMtK0ih7S8Sn4nr9O3TfZQUJaK1N6T0KC58G7O0MCtPPmzI7LCvboPXz
	 niyT9OZzWPchDLzuI1ji8/gaRf5zfY/Sn63M2qbYOAXuSQ0l1G+C634pEpxtFZ3/Si
	 YWh9LRnT24Wr9cR17bz75205eZ3Y+WdD+T2a7PyCUZ4tIqYNOYckTWizevrpoJLzN3
	 oSCr03tFooAcbHMuX8nVoaYTWXB5J7XXpL+yJlSdoBlCiTElv0SdDsHZbpj22lMbIj
	 sWlFxON/ckceg==
Date: Thu, 16 Jul 2026 09:43:44 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
Message-ID: <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>

On Thu, Jul 16, 2026 at 07:44:20AM +0200, H. Nikolaus Schaller wrote:
> Hi Andi,
> 
> > Am 16.07.2026 um 00:07 schrieb Andi Shyti <andi.shyti@kernel.org>:
> > 
> > Hi Nikolaus,
> > 
> > On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus Schaller wrote:
> >> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
> >> and the I2C adapter lock, which triggers when an I2C-controlled clock
> >> generator (like the Si5351) is registered or modified under the CCF.
> >> 
> >> During a clock frequency change, the CCF acquires its global 'prepare_lock'
> >> mutex and calls i2c_transfer() to update the chip registers, stalling
> >> for the adapter's I2C bus lock.
> > 
> > I don't think caching the clock rate once at probe is safe.
> 
> Ok, valid point to discuss.
> 
> 
> > If the controller clock rate changes afterwards,
> > jz4780_i2c_set_speed() will keep using the stale cached value and
> > calculate incorrect bus timings.
> 
> But: is clock rate ever changed during operation? Usually it is defined
> by the device tree constant.

That's what you are saying in your commit message.

Andi
