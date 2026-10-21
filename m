Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578249;
	b=yMsDSqIXu1B84SqZ/LEv0lqoE/+4BCSs83EaTdKFGkFoRFiMOuPvSWeZsQzoK2EZWVUu
	 PE2nvGugw+/DdOkeZ9TODButM4U5Z0diydJqj4sbFUcKdr2T7qEOaLXnpLsy3a6en/knS
	 tLIDMGReHEOvg1d4y8jiAh6/8XSOIQr6x0g0hHkDZBEuF/sAEfLxM+ZsqxmAeH7mjv3/d
	 4XYAapVz/DA9QTLeJbAhgXTyqhsDp7XOf1GLl/kAseI6xxrL1sWDmpy7Gh8Vyrw9SkGTi
	 TMvWiFuwsvRj6FgM7xhN/ImxKa/dQI4emWsh/jgUegy0Mu3ezFYqJ+um6ArxwMBNBbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578249;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qYDypIT7QE1F/eBnrsyHEhw9MO0/8jcAkyVwmN8UTzo=;
	b=l0AIedGKmYnSXTOFsPkwaAcQRG9d/jdBVyHF2687oKHCyTkl/5heMRK6f0FWdRUfskg5
	 mxh5p51kubT1ij5rj81fJBArBnieEpoduNdE1HmR4+9kxpW30V2wMFv1vmUPoOvHXdnoz
	 89zmChrTkg3OFmOZCf7Qy7YxgM7Gh4i9xs6AJhNYhQXSKGcJiFEC05ubkD0K+4/nNJdCM
	 j/6Sn0IACoFdZleIUl4bqtB3GXMYjUDqyBdddxraW2WxLGpqJqk72xrw9wsMwIMP3cmoP
	 vZ0SVf3aoF3TzaoxK06x2RN07jvV9z1bt9UtaH3frhXEZY2qoW107HldTo45/dW0ufw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgVuAH6R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 85D96606A32A;
	Wed, 21 Oct 2026 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgVuAH6R
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9BE531F000CA;
	Wed, 21 Oct 2026 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578249;
	bh=qYDypIT7QE1F/eBnrsyHEhw9MO0/8jcAkyVwmN8UTzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fgVuAH6RN7jNUQ6qR+SgyDBAnt8REfpRA0GBNGvKj9x9SY040MEqFioc8qqpOTQTd
	 LADBiBp2jk4P+dyuYDSatkuMoMFbvVq4mMlg+bl2jdNlbLcMlKdl4fw2hTg3GqBpga
	 bn7DO+gh0ueFUvy9Wk2aPhNsE4L0Dxbh7i9g1FsLSVuuqP+F+j9Ji7azfIN/ZsZ5ZP
	 brGvqJHDIfIvCyKqAfuMSSIjq/C4bdQlHt1xzCvPBL0o5u67Sp8VUEugcpUMNjh+JM
	 yHmJo25FXNJyahCUTwug8RDzEiM0AqEXc/ZOFBQ5Z9LUjn44798VTsOzqoZzSPq23L
	 fKqOBDY/286/w==
Date: Wed, 21 Oct 2026 13:24:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in
 tpm2_get_pcr_allocation
Message-ID: <atiSxTr7A4CaUo25@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
 <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
 <arwssp0czGg9XKv7@kernel.org>
 <arw9CHc4mIOm5C6Q@kernel.org>
 <20260930033300.30295-1-xuyuqiabc@gmail.com>
 <ar8hhrjQQw_yfghj@iki.fi>
 <ateJA_WanjASrIUM@kernel.org>
 <179257257405.72348.17698648428918034727@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179257257405.72348.17698648428918034727@gmail.com>

On Wed, Oct 21, 2026 at 04:49:34PM +0800, Yuqi Xu wrote:
> Hi Jarkko,
> 
> On Tue, Oct 20, 2026 at 06:30:11PM +0300, Jarkko Sakkinen wrote:
> > OK, so now that I was writing summary of TPM pull request changes, I
> > came into conclusion that this is not a bug fix, unless you can show
> > from TCG specifications that this is possible spec allowed behaviour.
> 
> I cannot. Part 1 identifies a PCR bank by its hash algorithm, so one
> hash is one bank. In the TCG reference implementation, TPM2_PCR_Allocate
> keeps only the last selection when the same hash appears more than once,
> and TPM2_GetCapability(TPM_CAP_PCRS) returns that allocation. A
> conformant TPM will not report a duplicate.
> 
> > So I can keep the commit but would remove fixes and bug related tags
> > from this. It is essentially hardening and safety measure but not a
> > bug fix.
> 
> Please do. Drop Fixes:, Cc: stable, Reported-by:, and Closes:. The code
> change can stay as hardening.
> 
> > Do you have something to say that I might have missed?
> 
> Only that the commit is not on the current master after the rebase. I
> can send a v3 without those tags if that is easier than reapplying it
> yourself.

Thanks for quick reaction. I can still get it to the pull request.

This was just a question of taxonomy. I think it is otherwise
useful to have this validation in place (i.e. not disregarding
the change overall).

> 
> Thanks,
> Yuqi
> 

Br, Jarkko
