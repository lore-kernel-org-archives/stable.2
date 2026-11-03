Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720197;
	b=bJkh/tg5e8OHW/eL/XjU0iXNvjbFXHRe6bc20gRNKFWStFIprgkznzp0V1qGgFgwu8vd
	 bQ+S28Cz2D1bFufq+wMSqSKypQ/AAH362yjJyY8yIM69Ep0ELrZIhlEgBtcsWyA50f/k/
	 40U8ubQ7TlO1zXYdMXyHkeJd8eHliN9ylIJdsez40fhB9ARfuqT5D1+c7m6haNwmrtrBf
	 nhY+MhoCFUgodBKhCmBMcCiylba2p0ie+rFp3tPdFu/PkeMO/b+Bw33l5ky120yq/QcI9
	 NsVUYh3iLw3aQ4tDxgdS+exMWKYU+YNQZMXlbH394GXXoGS1uJeO+p9PSUKULVc9P1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Iwg1Zlh6Ve+tXDUlSQA2Op+Qd/hTm/8nQjHs3UTZzpg=;
	b=hKVMM+apvaSLON8DgiB+2O7LbWXFite9KrvSvJ2FKfkeR8HS5Uicq0EDVfuFLx+lcGEC
	 gyMfYQ5vVYc0DIY17QW25OFWFGG+HcuHdsKPMD2IEjKnN0815+6mk9Fo3WdZN0UKDxqwM
	 kfb21y8R2VcLloCD8usT0fkan8myjRCjK03D51GL/PczXGHed1YrSwlZTSUcRWGfMvQoQ
	 J1pDjeY3DOnuvadShAwgjNV7jNZzySavpRBMZVvfMBvWjZtmnqC94XYkluu0TOi/afzMr
	 F6avlgrj/Ifv1nnEMTvIX0tPCE3xk94c8QwqiX1bbemAW8cSqBQAXAvdDNuWnkPqOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUVqsqMW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA4606A326;
	Tue,  3 Nov 2026 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUVqsqMW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493AC1F000C1;
	Tue,  3 Nov 2026 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720196;
	bh=Iwg1Zlh6Ve+tXDUlSQA2Op+Qd/hTm/8nQjHs3UTZzpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VUVqsqMWwtEaBtBHu8g3D4rR+IxkprPQb56eYTVLmNu4NI9VXid040ldUrjpgwKkc
	 /661Zbwau62FdS8ErVGQKICxh1txlpOJ4Dke/obA4cW3cBNzICAHmZN3Qf7YnTVkxG
	 0+wXbPsIDVCdnKcznqHOLrQtqzORxrRhDTDh8V1BV1HEvR7J7UOEUenGeHZd420d6N
	 B4S1pZ3GkZV6NI+0oApZyBF3EDL63N/yZdCwiEaDTyW5uSH8qGfZt4zN55Oz6gUy+d
	 mRuxA5bLF1Bry7DM9WEmb8gA3J/frx8mDCX5/wRAxrLm0Mj9EebuI+2MAfxcDxak02
	 3bnP/I+9iQgag==
Date: Tue, 3 Nov 2026 08:36:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
Message-ID: <aun_gknBOPBjDbGu@kbusch-mbp>
References: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Mon, Nov 02, 2026 at 01:24:19PM +0000, Jérémy Jean wrote:
> Commit c9359401036e ("nvmet-auth: reject undersized AUTH_SEND
> payloads") only ensures that AUTH_SEND has auth_type and auth_id
> before nvmet_execute_auth_send() starts parsing the payload, but the
> DHCHAP path reads t_id before it verifies message lengths. A two-byte
> DHCHAP NEGOTIATE payload can therefore still trigger an OOB read that
> KASAN reports as:
> 
>   BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send
>   Read of size 2 at addr ffff8880030d8364
> 
> Require the payload to cover the minimum DHCHAP message length
> before parsing it.

Thanks, applied to nvme-7.4.
