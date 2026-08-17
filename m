Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE973F58E6;
	Mon, 17 Aug 2026 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966479; cv=none; b=SpuUFW/3cu20Qbc5y4bTwrejEHASX/yjRIfOQIVg5Nijk2lB4Z/tTn1bMDrLGEe89e0rm3wn/uU9IE+jHuLIUjdT68W8w7ZfxMNmAyEdvGjVZDpvLOW8EwavQzzOhR/IoneFjwEo/rkOmkdA200af3yUn/W9UcB7UpfZEA2zDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966479; c=relaxed/simple;
	bh=9TGjuQo1mKQkcqlgKo57kJxlnPtH3Jv8XxcBD3A76JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It3bq3uYPY4cLQ6gKy8DdsHWIyXDAXZuv9p4LDn/99lOiTlE4hsH5HHySg8C+kiPFfTyVV2p6uoQuMTZywXUtUcFb46fo3YbO7cgfNl+n0fmflPByX68V8/17y8gx2wn6wQXwTmM3coYzMUXR3mLPePZMseBdJw+bQR170GvkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnp3ospn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnp3ospn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201CD1F00A3A;
	Mon, 17 Aug 2026 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786966478;
	bh=FjHlsmYEYzijKqgNs4Mx5SPcKYbT3PPdor0Bf0avHyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cnp3ospn5OkaQDkq5Itjxg8hE1vg3hKPqo3W1GsUtdWTAuWaglKlTfpS7mmzKn/RE
	 5L9LOcJFa5CKuT15jpEpNj7kWcSxhQ1OsCJuYGZFC5lmR5eosXS9tLP2Jn7lqiMFLs
	 453H6l686fx70UqrrPHtC9+BfnpTSws3cdb3olIZv5K0CRAKB6AYIHBcrMiVFelfYF
	 TyN88E+2IML5T0Mh+5enCkekscNd2AOX+GhmXU2IoQ3uRiMy9u67+tnCaFzc+W1kkm
	 oZ2xgOvlp7FHZmmLN1WdzPUbIqM/icgNPOTA4/H5yVtQ84DiIKga1pRz2u0OYXCcXY
	 CLWfYteKQ4ClA==
Message-ID: <c4047dcc-c0d4-4b53-aa89-a126d81445e0@kernel.org>
Date: Mon, 17 Aug 2026 14:34:24 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] i2c: pnx: fix device_node refcount leak in
 i2c_pnx_probe()/i2c_pnx_remove()
To: Liu Zhenlong <dragonliu2018@gmail.com>, andi.shyti@kernel.org,
 chris.packham@alliedtelesis.co.nz, jochen@scram.de, maddy@linux.ibm.com,
 piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk, npiggin@gmail.com, chleroy@kernel.org,
 grant.likely@secretlab.ca, neelegup@linux.vnet.ibm.com,
 benh@kernel.crashing.org, wsa@kernel.org, stigge@antcom.de,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
 <20260815181204.2321-6-dragonliu2018@gmail.com>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <20260815181204.2321-6-dragonliu2018@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/26 21:12, Liu Zhenlong wrote:
> i2c_pnx_probe() calls of_node_get() to take an extra reference on the
> platform device's of_node when assigning it to the adapter device, but
> none of the probe error paths nor i2c_pnx_remove() drops it.
> 
> device_release() does not call of_node_put() and i2c_adapter_dev_release()
> only completes a struct, so the extra reference is never released, leaking
> the device_node on every probe failure and every adapter removal.
> 
> Add the matching of_node_put() to all probe error paths (the three early
> return paths before clk_prepare_enable(), and the out_clock label which
> covers the wait_reset(), platform_get_irq(), devm_request_irq() and
> i2c_add_numbered_adapter() failure paths; dev is devm_kzalloc'ed so
> adapter.dev.of_node is NULL and of_node_put() is a no-op when CONFIG_OF
> is not set) and to i2c_pnx_remove().
> 
> In i2c_pnx_remove(), i2c_del_adapter() clears adap->dev with memset()
> at the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
> removal")), which zeroes adap->dev.of_node before of_node_put() runs.
> Cache the pointer before calling i2c_del_adapter(), the same approach
> used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
> ("mtd: core: Fix refcount error in del_mtd_device()")).
> 
> Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
> hardware available for runtime testing.
> 
> Fixes: b41a216dafe4 ("i2c: Add device tree support to i2c-pnx.c")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>

Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>

-- 
Best wishes,
Vladimir
