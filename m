Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF76432E81
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620025; cv=none; b=G2Vfot8/wx6cwVu/23cdWE4+JYJw6OoEJCXBnh4RBdRCV9ReSrZTP9gZJY4o+pAFmwFQTFdQ+tfMwgTg8r744yKr+MGGvGbfIrMvzxlmqtOomJBDgJzp698MmnFKY0O/agM9OxIGJYFWzYPSYDmIhMb437lIzHJhPSoVdKWkeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620025; c=relaxed/simple;
	bh=TQtBUdZeHBQR3H5WljXeobVpMvRnxISqhvLZTrCRhTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pid227V/kGEyMbykkVCxrpfHD3G6GX0hZHgbyuLrwLfsKNVnc2YyNtOIpWATKjClQMQkq5RfsrdrQcN4Vk7ldY0/wqWE8njzaublZ4CIOXS1UOVHwm7tG0d/KUubEIyH1CBqo8h0JcKV0kRePCHZ7Wqfw8lyq2Tq7V9nWS25phs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYF9fDxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYF9fDxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595801F000E9;
	Tue, 21 Jul 2026 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784620023;
	bh=MQC0Gqxj91vlJOSD+ur7lhqdc2LgCxJ3yli1PIZURt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OYF9fDxgtRKdd5oc0IqjrTcYBW09cBdsrqVfxR2zrLTzhuFcbHQKN29uExHgTysj4
	 3KP4lIh85WkcjxcrwpLcLzZjycRWGWxyI8C6MMpTihR7NrOKZGGQBqS8xtBOjUkdU/
	 iY4+B9CC7miF1RdLduG8rENQu6FO5UzpdYaz3wFU=
Date: Tue, 21 Jul 2026 09:46:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: BPF selftests compilation failure due to
 selftests-bpf-initialize-operation-name-before-use.patch
Message-ID: <2026072148-unskilled-falcon-e39e@gregkh>
References: <al8dSv_OvhwxFCar@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al8dSv_OvhwxFCar@u94a>

On Tue, Jul 21, 2026 at 03:21:55PM +0800, Shung-Hsi Yu wrote:
> Hi Sasha,
> 
> I am running into BPF selftests compilation error on 6.18 (but it
> possibly affect other branches as well, haven't check) due to
> selftests-bpf-initialize-operation-name-before-use.patch currently
> sitting in stable-queue:
> 
> /tmp/work/linux-stable/linux-stable/tools/testing/selftests/bpf/prog_tests/verifier_log.c: In function ‘verif_btf_log_subtest’:
> /tmp/work/linux-stable/linux-stable/tools/testing/selftests/bpf/prog_tests/verifier_log.c:320:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
>   320 |         strscpy(op_name, "log_fixed", sizeof(op_name));
>       |         ^~~~~~~
>       |         strlcpy
> 
> Can you pick up commit 63c49efc987a ("selftests/bpf: Add simple
> strscpy() implementation") along? I think that should be enough to fix
> the build failure.

Now applied, thanks.

greg k-h
