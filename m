Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303A479874;
	Tue, 18 Aug 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060256; cv=none; b=cfAu57jTQg9cCW4rOnmmv/pDAvoGdl3cNKfj+1Tuu9aud1OkRBVqfEF4AatFlZGZLm2itCcfZpOMfRZmNCbGS32mrtJPHnRSaXp1czXBEKKsbzKHoE//9UnH+AmazjBjjJcIFjyrBaRTolNbvR10hmb8tZEHQSv5oq3y3WCFGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060256; c=relaxed/simple;
	bh=bAqH+Io+91/tPcWYNwTXHjTKZCv0wSZoEGrlptyhYF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1/1lykzhsrEsXgnuqZAzTnRZbaxEYD8zQmnTzqNfq00cedwVHL5ZhZfNdXZHRE4zTSHnd7dzyeUd0+7MDTrSyNZvGhet+LNeitbfZaS4nuwTzvJ+1KS7GUL7JXaKWfjlRL7VIv5uTSBm66rrfe322u6FtHqqm6ANWHZNl1luwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lchbX8Ye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lchbX8Ye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5421F00ACF;
	Tue, 18 Aug 2026 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787060246;
	bh=9o2NgcEpXttlg6NfXMHTh7HTu3ILtf6I4MroKBAsIPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lchbX8Ye3ZwHam9iyu+djaWXZCByTfOMnBtNIhzaZe0Nm22d/DdrCA0aDwzlTAUDs
	 D1qaK3h1hnbmF+vy2eRzeRQh3yaHMlcMlKT9+QnjcjBNFp/IHf4UqcD7JfubTggPwH
	 O4mmgwMNuO71ffk6QjrIvx8VFTJu9NAycjAOXCjK4Oen4/09Ovy9ZM0Thmk77ORIMc
	 ziaHmTxKJdxrYAaRedEquOUGqk5Vq9adE/TJF5dJFc68m5X3RQbkhU1L5ZRHjtWWc7
	 nPW4WjJMVFI0L87BABeXpxPWm1jHxYc5UyHOP6kHwlTd4zTBU/wcVzR3xL9h8CLloU
	 /N23s1KgUfBlg==
Message-ID: <32509367-79c9-49f1-895a-d1ed48ab370b@kernel.org>
Date: Tue, 18 Aug 2026 16:37:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] media: microchip-isc: take a reference on the
 parsed endpoints
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
 <20260817-balki-isc-prefix-fixes-v1-v5-2-2514df336c5e@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-2-2514df336c5e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 09:51, Balakrishnan Sambath wrote:
> for_each_endpoint_of_node() drops the reference on the current node as
> it advances. xisc_parse_dt() and isc_parse_dt() store the node in
> subdev_entity->epn and release it later with of_node_put(), but never
> took their own reference, so the stored pointer refers to an
> already-released node. This underflows the refcount and can
> use-after-free, reachable through the camera device tree overlay.
> 
> Take a reference with of_node_get() when storing the node, and drop it
> in microchip_isc_subdev_cleanup() so the entities the bind loop never
> reaches on an early exit do not leak it.
> 
> Fixes: c9aa973884a1 ("media: atmel: atmel-isc: add microchip-xisc driver")
> Fixes: d6701f13bd07 ("media: atmel: Use v4l2_async_notifier_add_fwnode_remote_subdev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---


Reviewed-by: Eugen Hristev <ehristev@kernel.org>

