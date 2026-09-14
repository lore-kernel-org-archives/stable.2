Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25653A1A29;
	Mon, 14 Sep 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372448; cv=none; b=QkMPB2WLE9V9ormMpszYFn9WDhpKwiXz9k5QzNFkcWkrtdjTnFd4IAeB2oxXhMSwbb6LpTG5bualMKhPGU0sxlJenuvs5NrwjmQPQEnQdcEb4rLY2bRdyJo3YnH7AOf3iybJeo8fgBEiVOyXZW0LaNe8r3t/cvKq7N2v309AXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372448; c=relaxed/simple;
	bh=MwtG70X5/HnNPKiQSubwTio3sKmcSt3Qz1PEE/NkjB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEuTnAqhoJ5DwTGPZpKwRnns/vAGFmfFQWjMIYK6a7PtlaBIf6sSvUTzHUj4RJffVkDKV3zG0jTJEJMF4F6dgtO+eHyP3YkcJwNNV++8ubkgTFHpg1mTUan9DWud8SDJUouLOqIyv6VJtzWGBYtQZxWVXveM0voImCguqQG+CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=w9J4n5ld; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="w9J4n5ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1789372397;
	bh=krYwKqaXV9L9gMtI7gBlvcr6yxv6wvXrxLq7QTfaaow=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=w9J4n5ldU7aL9PlC1IPfunhFyr1IbXv1LfXfiMm2UUPml+gnNUNpAwDrRySFHz9cu
	 Z2M44QDEgD1CrQwZpLM8tH5eUSgi/aeUqisO5r/0cG15Rfxn93JgHGG27VEsznDI7t
	 CiC6XS7KAddSSGuaepOvrIvWBZE8GNHVeDXRUslY=
X-QQ-mid: esmtpsz10t1789372390ta0d266fd
X-QQ-Originating-IP: xN3+dVMDXw1EV0cTdqDEjsXnpMPfpta52DS4OtNI2bc=
Received: from [127.0.0.1] ( [124.70.231.75])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Sep 2026 15:53:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13085942193822309937
Message-ID: <D963FE7EED46AE97+22a33857-c629-4cf9-86b2-d30827a5ff63@smail.nju.edu.cn>
Date: Mon, 14 Sep 2026 15:53:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binderfs: fix UAF write in binder_add_device
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 brauner@kernel.org, cmllamas@google.com, aliceryhl@google.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <F6EF5FB778E87C98+20260913085645.1639558-1-peiyang_he@smail.nju.edu.cn>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <F6EF5FB778E87C98+20260913085645.1639558-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OUC5DGN0mB58Y3GDSJPVST42RbxMuZ6uwW4szOUxULgR9ybo2gY0tEvn
	cDk6HeHOwgv9a/KuEgjgBl+zqfbRDQeyZ2b/d/lIqdNbAdgEE1KkB4rc5DP0Pb2ulvs12+R
	jquv9LI5R1n3UrS2FkIF8mCtF/B56m08yKD0p20PQPxyXgJ96JWJvUqIwhCGLi/N76zgxic
	mjaF9CN7lkJ2fU72ZynJxiBH48JLKApMdOY2CxrFfTcp426o2kxQLpeHGXMlr1/01GXpulr
	2xKtuXspGAUgk2dBMktqQCDzl6Oe+W2nQO7pdlxeqrzBi4xLzpT/yvmckXA1X04od0X6XKM
	59Cra12+9gJGFxeJ4+XArKVir/wI+SAWt8vsvxVJi8O+g9JLSws4xJ5du1ySVcDsasbAEcB
	YjfcwRhlO9z3lx+e4FCS03Pf+EAjqjhH8Bq4QiURRYPP1ntLtjt5Zi7GHzDkFKi0FoDknAh
	kN3lUPNxwhV27Xy7YXI8oDeLLKbt8ye3vY4D0xrPxthxh3jbXOPdx0/ymzXXQAuHl59847H
	XZeQ0eAOPnrSWsp5zJ8X6KlDXJ5RB6xx2Mq8g12HiuhLL5N/NqCZRDS3ogPcbZrunHGGtLT
	4h05rNEfJLYc9+8PmjWtzvWLi1eRM+5GoqCETFJsAEFCVdoz7R5WECcDaxIMIBKVAWEr4+p
	j0o9bYpWJ3RyR7KRWC+Q2U1L5eINYdg2KrrnCWtVihZ5K7kZOI/b8PUXpOneaZlKgTEs5y3
	n7hvhspFwhGhHqdXMhY6k/24IKTJbmn9P1eE9AW72L5QR63ysMIYPFylEKQxLMxB5ggapF6
	Ed5a3FFSooHYVC3bneQjQtlQb8HsGuBQFJuPMCmbWsC+EKQjRYIaqZuEhsdQes37/KAGdzj
	fglQgOV9x15Wk5DhhQemh9LgvKAzSQZ6q0KM+RypbYR9+RTb2A7KeTZOt6wlERZJ2C65Jv2
	6QwBlVMEK1s0XzRM9yroBZtDgvk89A/jN+Yz1YTkHOgtCGmNHB7AEFjy4TS6rqQUIpqUdmF
	7Fm5c3S8X4r6ieANXd
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On 2026/9/13 16:56, Peiyang He wrote:
> binderfs_binder_device_create() publishes the new dentry with
> d_make_persistent() and then calls simple_done_creating(), which drops
> the parent directory lock and the creator's dentry reference. It then
> calls binder_add_device() to register the device in the global
> binder_devices list.
> 
> After simple_done_creating() releases the parent directory lock, a
> concurrent unlinkat() can remove the new device entry. Dropping the
> creator's dentry reference can then trigger binderfs_evict_inode(),
> freeing the device. binder_add_device() later accesses the freed
> object, causing UAF write.
> 

For your reference, I checked the Rust binder code, this UAF should not be possible there.
Also I ran the PoC against the Rust binder, it triggered nothing.

Best,
Peiyang


