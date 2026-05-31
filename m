Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAD179A3;
	Sun, 31 May 2026 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780197927; cv=none; b=ONOZRtSrjTsq8TCyVvvr42mmx6xrIxFsCeZaRoY8cj4IIG/Fu1ToZj6D6kGEMc06ymnat91NwaBNZdHOT59ck5pdk6N0+m/7fyDvMp0mraeD4tPSb0JchDUxrKcwDterighYMuqXZQetKxy2/2dCHtC7a6lhCq5oS/DtlEYw6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780197927; c=relaxed/simple;
	bh=NMTtAnKD5roBQ5jQECZQny6q2BQ7ID9c8zrGbwocByY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6d5Hhpe3VQh/TtfBgt+YGyf11jC0iXGiRNPEDPYGKBlOTlsmcpHIuEgOB8aZMC+nE/IULaZq/IxuCABO05M7rrlDbKUiHZIPCBakCb/T4zb9wqriXhTC5QGSwNI7cGThJAVhFyzSnNxU+1D9aqzBua7XA7IMsMMaTTS2CLgCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrnsVJrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrnsVJrn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D8BA61F00893;
	Sun, 31 May 2026 03:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780197926;
	bh=1SF1n8Rb5AYE6232mmnvxJq8oANyG2eYLIAPbuU17B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZrnsVJrn3Km1ehrBYXC89UpXlpVMbMUhXWb5lYCA4kYdbEK1ycMGFYrNhvL2IaWT5
	 okpoEPMkKoVqnVSbJnr5J32ytY2nqsyBR6J2ALeollm43tZ4Gu5L8HDg3FJxuIPCT3
	 Kyy3mHOafRYV+6Hu2dldVYIjoiJJOjxUZmIagHHccovsTwq+eCzmLydxecokxBVQ3/
	 uCDDoHVQyfOtFEybqOs1gs94gau7NcPbxY+54/F5HtdwMnTJuoQVStbZjvkWqMSJmh
	 p6UsG9zFxPsu6aejeM2junLqWhMQnVo4BBaMWGNA0fO9pFZfT/e6Zhm6lC61QAaFSo
	 o6ZbO+3Madcmg==
Date: Sun, 31 May 2026 06:25:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyringsy@vger.kernel.org
Cc: stable@vger.kernel.org, Alessandro Grupp <ale.grpp@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Denis Kenzior <denkenz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: fix overflow in keyctl_pkey_params_get_2()
Message-ID: <ahuqIqUninpjqfpF@kernel.org>
References: <20260531024914.3712130-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531024914.3712130-1-jarkko@kernel.org>

On Sun, May 31, 2026 at 05:49:13AM +0300, Jarkko Sakkinen wrote:
> The length for the internal output buffer is calculated incorrectly, which
> can result overflow when a too small buffer is provided.
> 
> Fix the bug by allocating internal output with the size of the maximum
> length of the cryptographic primitive instead of caller provided size.
> 
> Cc: stable@vger.kernel.org # v4.20+
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Reported-by: Alessandro Grupp <ale.grpp@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Should be available in -next within a day or along the lines so please
be quick with tags/feedback. I'll forward a PR as soon as all is good.

BR, Jarkko
