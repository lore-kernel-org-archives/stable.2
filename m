Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958544A3EB;
	Tue, 11 Aug 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460167; cv=none; b=CVqrssKpSlPDu9C+um2xrgWfmeWcFL+avUH8V78ZpchAgc6+PZdqVC5uixNNz4SlT61LshNg3QToXH0T8mskZj2Un8iXP7vwjhmgQm9OONTZjYaxMwHgBGMXt7c0ONjQ5N6zAsUK+gJ1vHvWNe44lL1v5UNLutomJBXW3APhiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460167; c=relaxed/simple;
	bh=7fowTwkjADm+ulf7/Mq03B7N7TjrcjhCVzvvrJGq7LM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDffgOSA9irMpfMUEKNquZdvPajsZXYwIvwqUpgskad8UlLrz82dzPS91w7/b6UhrxGHUPyAeLLqUDW3x2wa6u3EdTFsp92fbLL+jG+U3zIyghQJqqpddIrR4zJ9JMjk51Ps4FyMdd9/UtPB8kewysuaagfPh4e6ga7CdeR57gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bA+qV2lE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bA+qV2lE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1786460160;
	bh=7fowTwkjADm+ulf7/Mq03B7N7TjrcjhCVzvvrJGq7LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bA+qV2lEFYoPp9Iu69AjVSP2qy5EzaZdUcPdkratXo6JEW0vs+JGjw8+iMYYc23fM
	 1q+XD+OQiAoXqPUt+SNO4EN8vIMpnjyGmJzBXzpAOsD6R4E7Af3t6Kj41nQGaRl1FF
	 ZqjtmUFGDbGb711xtuAdhHhshwO3ewqD7oYkFKa5hVE7kIMng/SqM+rHuY2Qu2IIV2
	 9+qx0GETe8Dzig8eLh/CnqdYDs3iAKmrjiXDmVyJPyDkJD/nGy4hYo7BTFnWNlMz7P
	 +kdS5H3z4b/t/xl9sfsTFoOQMX8pxdt7meSgsRQDsIgW6X10OP/0HAMYcnvRXVrE/8
	 YeMvUzUq475Lw==
Received: from fedora-21.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 528B017E051A;
	Tue, 11 Aug 2026 16:56:00 +0200 (CEST)
Date: Tue, 11 Aug 2026 16:55:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: ignore CS IRQs for uninitialized slots
Message-ID: <20260811165557.431e2d2f@fedora-21.home>
In-Reply-To: <20260811143318.46446-1-osama.abdelkader@gmail.com>
References: <20260811143318.46446-1-osama.abdelkader@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 16:33:18 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> CS interrupts are reported through firmware-provided bits in the CSG
> interface. sched_process_csg_irq_locked() iterates over those bits and
> passes each CS ID to cs_slot_process_irq_locked().
> 
> panthor_fw_get_cs_iface() only bounds the CS ID against MAX_CS_PER_CSG,
> while the firmware can expose fewer CS slots. If an IRQ bit is reported
> for a slot beyond sched->cs_slot_count, the driver can fetch a
> zero-initialized interface entry and dereference cs_iface->input.
> 
> Ignore IRQs for slots that were not exposed by the firmware. The CSG IRQ
> acknowledgment is already updated from cs_irq_req before processing the
> individual CS IRQs, so ignored bits are still acknowledged.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 64749750e6ee..1e230936e99c 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1705,6 +1705,9 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
>  
>  	lockdep_assert_held(&ptdev->scheduler->lock);
>  
> +	if (cs_id >= ptdev->scheduler->cs_slot_count)

	if (drm_WARN_ON_ONCE(&ptdev->base, cs_id >= ptdev->scheduler->cs_slot_count))

Since this is certainly not supposed to happen. Looks good otherwise.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> +		return false;
> +
>  	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
>  	req = cs_iface->input->req;
>  	ack = cs_iface->output->ack;

