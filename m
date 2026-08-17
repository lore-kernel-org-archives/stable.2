Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901723A9871;
	Mon, 17 Aug 2026 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952783; cv=none; b=iGoo4cpbvNwrtN/DF1k7OXiEv+NlngENc7Novl0jwDD7X1dKOX9r6mQplKkC1cTD7nyuM7aAO0DqU240ayfaYjGBp5bIkXK9NgWtJY+zACX3jTywSQ0RtfdOamQOQiSdjtbS65KzfQ/qRFKQfcY8bF4tPGOK8iZZ48U8KmQPzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952783; c=relaxed/simple;
	bh=JZZXEFDYThXPDeqagEiJtWaSB7camyOFAL2f0M4H82A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA6YNWe9n9c2MJro3eul2lpcf/i27XIn5m0X1wgU+kR2kjiA86qkfB3PMmhoIlTBt5wcVPqUoHv7gY2BGTo3PPiIoM6i8Vnd743im5HwiU+OVGRnI+RCprLzxyzX0Ys9A8aDe8oyI3Ult4BWGoc+Bt30ekLp7F+1/rPC4lcRdxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5cCwZFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5cCwZFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB881F00A3A;
	Mon, 17 Aug 2026 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952782;
	bh=3EvQjw+wWOIIOHZmFhG/4lQ3ETvY/zjgD1sqcMFevPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h5cCwZFmSnkWiyzty/pQ12jW/TPWRirRxWX7/AqR4M/Bd8/2MGjtBpiRoaydQzrDZ
	 YDRANLlAaded4e8kMnryHktioBtFOSIVc9nge4YHvecM0NJCc3E9qI3IFXNx3Fku5I
	 i5fOR/CW2OQkK8qG7aCAMzOebUBGLdA60s/z0nM8DrfdBYP79+Ru4DTSyQBrJcMZHF
	 jLxOxE7McfjdHTrWR10YLKauf/24I86ywHia3dYN7QRnbJ4MTT5DsZVKJ/Tr/e+Xqh
	 +EblOYe12KIitI5JsIVa+DccMaeIOwZGDtdoFmJX597HWQsaCBgX9Bl2AA0n7YLpH1
	 r7gaj4Uvt/S3g==
Date: Mon, 17 Aug 2026 08:46:02 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Wei-Lin Chang <weilin.chang@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jintack Lim <jintack.lim@linaro.org>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: Fix spurious warning for benign stage 2
 teardown race
Message-ID: <aoK7vLOD3oKKAxH0@lucifer>
References: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
 <20260812-kvm-arm-nested-virt-fix-v1-1-4ad883f1b6a5@kernel.org>
 <qfhlmmidzdmmsfopfhxpddgwa7nob45jwgb6sabskawaxtox7i@mnxplk3zn34k>
 <an3gqCJ1fzloWB_N@lucifer>
 <v3vgnteumpaxbgqjtfwoilcbwpwohfci3uwu4ooykls6zjwjwe@rukbigno2m5o>
 <an7Tk0qrCM84zS54@gremlin>
 <dlvicg2jykp4icqkpa7xjm6bmim7sbp7vventkzgoihzpombcc@pemvii5d6qfj>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dlvicg2jykp4icqkpa7xjm6bmim7sbp7vventkzgoihzpombcc@pemvii5d6qfj>

On Mon, Aug 17, 2026 at 08:38:37AM +0800, Yao Yuan wrote:
> On Fri, Aug 14, 2026 at 09:48:39AM +0800, Lorenzo Stoakes (ARM) wrote:
> > OK so - I confused myself here :)
> >
> > The underlying issue here is that I am working back from a situation where
> > I can't quite recall what I did, but am rather reconstructing it based on
> > what was observed.
> >
> > And you're right - this stack makes no sense for an L2 VM being torn down,
> > rather only the L0 being torn down.
> >
> > So clearly this is what I did, and the correction should be to say this at
> > the start of the commit message.
>
> Ah I see.  I agree the race is there. Below is just an idea
> in my mind for reproducing this, hope this is helpful to you :-)
>
> migratepages (https://man7.org/linux/man-pages/man8/migratepages.8.html) can
> help to trigger the MMU notifier to qemu/kvmtool easily on 2P system, meanwhile
> kill the qemu/kvmtool on L0 to reprouduce the racing. For 1P system kernel has
> numa=fake parameter to generate more NUMAs there.
>

Ah nice thanks! There's also /proc/sys/vm/compact_memory so you can do:

$ echo 1 | sudo tee /proc/sys/vm/compact_memory

To trigger immediate memory compaction (and thus migration) also :)

--
Cheers, Lorenzo
