Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0926364927;
	Sat, 10 Oct 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643886; cv=none; b=FeBu/s3v15zcqbHSlsw6GFL4+jese2Ch25VPubp3eXjynJNcmoeRyGPRx3V9Vz5/CYJPicRa1JLN/+X3UhA+FyJ7r5vZSFIHeRXE2rx4MujabEI2UqVoPld2ZWuxVrblt5Z6z4HStRD29WvC0Oq+oXdpzLGXVOTaHnuZpVLXieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643886; c=relaxed/simple;
	bh=rkRWui3LY6orgxucn2Y46UtrJ1dD/K8Rmw3vAsBp69o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVyXmk3KSLvv3aIvByKCJCZ7nlR5GrLIYQYUbrmrMgCXZJa14EHnnrB+GrXr9x5ha42fAp753SI2obA3fFTUCxTH7evqLl5IWbrvr7nhp9dHWw9PzVtwe5Cy/fbwZN3Iuz5dIshRZWFUh2MjWHAYbxTM2l3TxlsACwkeC2Cma7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1+7Ui9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1+7Ui9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF89C1F000FF;
	Sat, 10 Oct 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643885;
	bh=9Q5gjJ66FTRizaXe0WZgZBw1+G2lMnbokKf1f9WGivw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1+7Ui9xtgv+QVg1uR9ioSkralEZsSJgDkNbrNKsvqj0LC07QC8WHmhftgYebYizy
	 dRhkpS3jusVUXGD97QhVJ4vTKQ9kVuxZGgJk0p3VlOVxtNN6JrB6kEKr17o1ZuQFVl
	 jsxP6pFIGP40KNCS6sliAHIQ8UbI71VavUzDQ40zK4Yf5ISXAb3yzAWxNgYH5OvxfV
	 AA8T29N44Z7CbwCLnatnzpdL6b+e6vJY08DYNFbO7lBWRVux/jCfUDRBDZO+qs68vn
	 yWGjO8RCMQb2sh6sj3l1rlDCDsLqVV397TTBmTtwN69gQfHJ9cexIFj1/iZgrGFO4Z
	 Td3axMYKbX0ZQ==
Date: Sat, 10 Oct 2026 15:51:21 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: fix use-after-free in
 __tcf_action_put()
Message-ID: <20261010145121.GR83879@horms.kernel.org>
References: <20261008181348.527035-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008181348.527035-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Thu, Oct 08, 2026 at 06:13:49PM +0000, Jérémy Jean wrote:
> __tcf_action_put() decrements the reference count before decrementing the
> binding count. Another thread can free the action between these operations,
> causing the binding-count update to access freed memory. KASAN reports it
> as:
> 
>   BUG: KASAN: slab-use-after-free in __tcf_action_put+0x327/0x340
>   Write of size 4 at addr ff11000000d46420 by task tc-put-pause/64
> 
> Hold the action IDR mutex across both counter updates and IDR removal,
> keeping cleanup outside the lock.
> 
> Fixes: 16af6067392c ("net: sched: implement reference counted action release")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
> 
> Change in v2:
> - Invert the condition of the test.
> 
> v1: https://lore.kernel.org/all/20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr/

Reviewed-by: Simon Horman <horms@kernel.org>

