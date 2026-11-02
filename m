Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640421;
	b=KfkyZ0yJpNTjIoZo13TMSgHeRIbg1WiWZZdbSAABRNIP61amUf07LzosdHnjgQ3iFrLP
	 Tqblk+vrDc72OrHnoNWho6gQ389y3Ou4GDympQngUbRWqTHVZHMVvmDmhZbQR3Qv4PUR3
	 qszUe2EMlHo0KhwSjIOkEgYpWS6jsJ8Nkfyd6Z1lcM6pIHVWOYpOG1HF4SO6WB14HVedU
	 FJuATxfs2iaiudqn16FvN6wj7iuYhKjXBeata1XkI+OlqGGJS0ZSxzug71UTKVuz9lPvr
	 zFEQhFITd+ayjYapX99hOMemhSlgONPDdjs+A9N/eEVrebwLG+cZTmnaJjPl2Bch9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640421;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=otmJpmEHmTauhUXesVvvVXQLO4MKBcNR6LE31jcten4=;
	b=QAhxs6TIr6LB4Bl90+JjCT4KyocUR6TTkcff4qIZEhcdSGFMWNcX+y98uLAcV2ITdUNi
	 n3TZVcB1CbGefZ8EjuE5cigcziqs99Gm/43ubGeT9Y9P8A8uLfBxyasW+PJTAnEA4mub/
	 AYuErLK8TeASMPkHyd/0z6zyeIUcsNJ4Tj7j5svY+0ItNjtgyizEIIZuaENgy5eTnQ/zI
	 UijG2sY9on956gPGAgdy6JGabJ/qEweLayE6XMizAwjCL0kjsjM14HSLgQ74fHOAg29w7
	 M9YpeoxaQONFJYfxiQwGpeNpBYhe8URQgGFNCpVvKYyhd1kxT4jp/cc4LFeg224MXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7DPc+YA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2500606BA72;
	Mon,  2 Nov 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7DPc+YA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5056B1F00A16;
	Mon,  2 Nov 2026 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640420;
	bh=otmJpmEHmTauhUXesVvvVXQLO4MKBcNR6LE31jcten4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7DPc+YAb8lDqhnqEyerQhjhBZnbVnndxaxSHlV7MesY1qY1PJzDtnlXwRBuGUYxf
	 cm/oadxTy+Lqr9HbVI3806axafz9tyOszVeMCFbyGHPSQYlczZ9bOLOJjL3vB0P+ar
	 l2+EYfbpC37xaGo/VuTnMnnN9GJOHKKvV47ChpU+M35rFc5nxjF45/mTynG2I5Ax6G
	 DLtmJ35NTLiE7GXqFm+a4aMJqIfK89SbR74N+/DeL0Fx/KfGUvM4n8Kuuj9cjKLKQZ
	 SR6ND2+YJ6Yjy1VHWBnI1ynTGFyJfFmExPwJtrWORy/F2ITAENEWLlrAXB4RAJT7mx
	 POejSaN3wKHQA==
Date: Mon, 2 Nov 2026 10:26:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@kernel.org, nilay@linux.ibm.com,
	wagi@kernel.org, kanie@linux.alibaba.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
Message-ID: <aujH4ujBJUe5uFYZ@kbusch-mbp>
References: <20261030170151.49844-1-christian.aurichzm@gmail.com>
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
In-Reply-To: <20261030170151.49844-1-christian.aurichzm@gmail.com>

On Fri, Oct 30, 2026 at 02:01:51PM -0300, Christian Aurich Zanettini Martins wrote:
> nvme_tcp_free_ctrl() reads ctrl->ctrl.opts to know how many queue
> mutexes to destroy. When creating the controller fails,
> nvmf_create_ctrl() frees opts as soon as nvme_tcp_create_ctrl()
> returns, but a concurrent open of the character device can hold the
> last reference to the controller. With CONFIG_DEBUG_KOBJECT_RELEASE,
> which delays the release, every failed connect reads freed memory:
> 
>   BUG: KASAN: slab-use-after-free in nvme_tcp_free_ctrl+0x38b/0x430
>   Read of size 4 at addr ffff888005b93740 by task kworker/2:1/51
> 
> Keep the size of the queue array in the controller and use it instead.

Thanks, applied to nvme-7.4.
