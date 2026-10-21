Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.116.240.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591391;
	b=jaU/SbkJH4TxTIdjIWw7zofHMO7r7aGoK7cULfkMJL8xVPc1tKXjoSwunHyeq+aX8wTo
	 /dMA1VKY35ZdtqYsd8Ok/b9dKwEDb6vgpQ8C1si7zD0re7dFbeQBtFqe5h5Jylff7kfuN
	 Z6p68BL//L5oBYqMfiC49zKY/V4CKplYRA6hDgxxJ4hjHIYCs9AYaVhzTZaSFLf2coSe0
	 ZeD/OVaEkupaMuH6l212V8L0vrus0TKE/q6ygy1A6U3ttAmifG+wsIA/ZFPQfSJrVJV9/
	 DW2Pg7zqNs3IXRfKFoJADxN3IJ3QUiOltemQY3UZ1n+a2AhKPexFW5UdAatV1ovUxeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591391;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=/r0AxVVWGLZRXANdtf3mhSCkftv12XEmvpE4y1kyZFE=;
	b=bltoNOXjNuBwCXT4aUDdVwaRvUEOY6azJitLTYdlBQ4fUv5nE/SmW0z3BfmZJRiNGdAa
	 DOzJCszNrTvXWRIlCj3DaISDmUE48/HQuD2mhg3v67vhawaOfzk6tD23bXmLlUhULYzYK
	 KmofFsscEz7OB5b7kHitlxWvpD5KUTmfM3F696B6cgif9yw5vNP9KKQ4ZiFRMLe5MYaaV
	 wfhBcVkCqUMFLqXcL5yDCQabC2OSt5OxlNrD7lvz1KsRfxW6Xcyn88h9ryeHVd3FICo+s
	 eSXzNjMpZ2EAIzEJuklgkvbDMyDNrEQVu9wUKLfJ5/QfjSDBS71LYXBZz1y4RPH9q4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamax.eu;
	spf=pass smtp.mailfrom=arkamax.eu;
	dkim=pass header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=ZM9s7tSx;
	arc=none smtp.remote-ip=128.116.240.228
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2346606A325;
	Wed, 21 Oct 2026 14:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2346606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=ZM9s7tSx
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=Uke4Cy4YCZOUDu
	A/rCbWYHMHT4sU8wffe55QX/Y+8xk=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=ZM9s7tSxTTv5A2+xzTaxDhNjGwuY60LWr+mDKEuV
	3tFbZ9hCuAfZK0JdhVKuhpkcXGe4xJUz7+MpPPyv+1xn3ULEyKva9tTkMpKuozcrOtDCTW
	73++HmX0V3WieEGS3KbZmlvuAjSynJonGlPuTP3tBcRV6a3zVKyYnqfEqILdapOuKH+Y5j
	/twF/IbCZM3XNFEpwOMsrB5HHucm11sW6fOmjtpfzBiZw/i23vifHsHvaeQQrlDHtOvWvE
	06t8mi68kFz45nB0yJuCUPrCxQmzYWa9wDGNBeBZfdO6b/Ex/NnUVGIGMz7iATgzhpG4tK
	T57zI2rM36uhvjYMFggs3w==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9a5ef087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 16:02:56 +0200 (CEST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:02:55 +0200
Message-Id: <DMAKLXGB0BLV.1S3CO480V3JJM@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Yu Zhang" <yuz08559@gmail.com>, "Keith Busch" <kbusch@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>
Cc: "Maurizio Lombardi" <mlombard@arkamax.eu>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: take subsys->lock while force-reconnecting in
 nvmet_subsys_attr_qid_max_store()
X-Mailer: aerc 0.22.0
References: <20261014054727.53183-1-yuz08559@gmail.com>
 <20261020025047.88297-1-yuz08559@gmail.com>
In-Reply-To: <20261020025047.88297-1-yuz08559@gmail.com>

On Tue Oct 20, 2026 at 4:50 AM CEST, Yu Zhang wrote:
> nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
> subsys->ctrls to force every controller to reconnect, but it holds only
> nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock=
:
> nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free(=
)
> removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
> The free path takes no nvmet_config_sem, so the two locks are independent=
.
>
> A controller teardown (host disconnect, keep-alive timeout or fatal error
> -> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
> therefore list_del() an entry while qid_max_store() is iterating the list=
,
> corrupting the walk.
>
> KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
> nvme-loop controllers connecting and disconnecting, panics in seconds:
>
>   BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1=
b0
>   Read of size 8 at addr 0000000000000090
>   Call Trace:
>    nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
>    configfs_write_iter+0x1a7/0x250
>    vfs_write+0x5df/0x940
>    ksys_write+0xfd/0x1e0
>
> (also seen as a general-protection fault dereferencing a LIST_POISON
> pointer at the same instruction.)
>
> Take subsys->lock around the list_for_each_entry() loop, matching every
> other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
> controller teardown, so it does not re-enter subsys->lock under the loop.
>
> Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> Tested-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/nvme/target/configfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 2b69ffc..23418fa 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1684,8 +1684,10 @@ static ssize_t nvmet_subsys_attr_qid_max_store(str=
uct config_item *item,
>  	subsys->max_qid =3D qid_max;
> =20
>  	/* Force reconnect */
> +	mutex_lock(&subsys->lock);
>  	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>  		ctrl->ops->delete_ctrl(ctrl);
> +	mutex_unlock(&subsys->lock);
>  	up_write(&nvmet_config_sem);
> =20
>  	return cnt;

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
