Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531861;
	b=QW4wgPrEDAQBHOsjQzbLFadkas5kxsnatqbog8zAXcYTeZUcorirG0I3BVBvUtoqC1se
	 PNnZyaw4B54e19SVv9holsKKAATvrJB4ZHArEI71vzYgsIpWTX8wObXrHnJHEXgiBOUwf
	 ye5X5haiIiDSGg8rqFIe53qzkL85p+p6dN1VvgCu2HUNNvDjtZjOpoc8fSLMs9+dsGgvg
	 RwsyEeo+Rf6QTs3WIIzSsxgCS0FjO6rotksGSJemH+IQq/n7+gpLuSpamA95wYzydYdzD
	 0zwFJ3RznRZDRTVSFZrGOJv4PkyI4gGln0C/3oy5LuOVJKhEYMFcUo2oTAcfrawGZYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vNYAoGa6keu+c87+JeUW1e0MXecgIgjnhz1d5+n9qVM=;
	b=pM057vegx2+uQqjCZEHuEd6gEcoKl9WfF2AY+tfHk4SV9ILyb225aFKpSU9s8MrnlceC
	 HvRkJybhndMvz/CWc1tZvs4qJO8h6zwWP2BOSoWLVdgxG6PW3b9UjozmObXaRA+TO1YDR
	 Sdk+BiRAJu9p4F5P5VyXj2V11m971cNboeeiRoezBqxp13fgPWTrG/uPleP0QaqQPvQK0
	 ny8pVhupBK6FsGrtQQE5P+DHnQnmlOKfrZU2fkt/0kTZubRQBXi+MclJXfM3RMTq1q85F
	 Pv/3JzppPhqsTNPtbNDuonhg/dr4AQh9CDp7LvnwkeduhQDIpAQxyh9l/gsByhL/q3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ak7ATe0x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9DE606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ak7ATe0x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D8D1F000C0;
	Tue, 24 Nov 2026 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531861;
	bh=vNYAoGa6keu+c87+JeUW1e0MXecgIgjnhz1d5+n9qVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ak7ATe0x/ifk0XiymifYLZyacB81MK+hoINq00lJ+210z5DGaRxaBfSFzXf85DTsb
	 pwnu5eAuyXyouKvzmbNydh9asQoFfcGhlV78Pz/IYxgx3KgO2eER00ym1OBMMdHwDk
	 VGqrA2jTl8XwYDimeXFZwjSKmidzxq80kVT0JB0gmWxUdVAeloarqn8dOq9pupoRhd
	 nPZ+i2ULhmlDO8JzKFoSodFBNj0re/RADN0xa/6JEsJl9Pk+Ki6a+cySgcWGnNX9Cs
	 safUrnH/NglaeR+uEOt9fy2RRneDvFus31Dk81t5WJWe19kAJR178s85n5Ri7DHZ3P
	 EOCUQn0sppDLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	bvanassche@acm.org,
	hulianqin@vivo.com,
	Yi Xu <xuyi0562@gmail.com>
Subject: Re: [PATCH 5.10.y] scsi: sd: Mark the disk dead if runtime resume fails in sd_remove()
Date: Tue, 24 Nov 2026 09:50:54 -0500
Message-ID: <2026-11-24-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124032722.102378-1-xuyi0562@gmail.com>
References: <20261124032722.102378-1-xuyi0562@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 085bb18a0b91007f04ddca13af30277c78040157 ]

This is only in 7.3 so far. 6.18, 6.12, 6.6, 6.1 and 5.15 need it
before 5.10 can take it, so please send backports for those trees too.
On 6.18 through 6.1 it is only a context adjustment in sd_remove(),
which still has the old "static int sd_remove(struct device *dev)" form.

5.15 also needs 7e9a46004b47 ("block: set QUEUE_FLAG_DYING unconditionally in
blk_mark_disk_dead()") first. Without it, blk_mark_disk_dead() there does not
set QUEUE_FLAG_DYING and del_gendisk() leaves the queue frozen, so
sd_shutdown() can block forever in blk_queue_enter() when the autopm get fails
on a still-active device.

> [The upstream fix calls blk_mark_disk_dead(), introduced by
> commit 6f8191fdf41d ("block: simplify disk shutdown"). That

blk_mark_disk_dead() was added by 7a5428dcb790 ("block: fix surprise
removal for drivers calling blk_set_queue_dying"), not 6f8191fdf41d.

> blk_queue_enter() (the counterpart of the upstream
> __bio_queue_enter()) releases waiters on QUEUE_FLAG_DYING, and
> del_gendisk() itself marks the queue dying later via
> blk_unregister_queue(); this fix only moves that point ahead of

On 5.10 del_gendisk() does not mark the queue dying through
blk_unregister_queue(). That happens in blk_cleanup_queue() from
__scsi_remove_device(), after sd_remove() returns.

> The fix builds cleanly on v5.10.274.

Did you reproduce the hang on 5.10 and test the fix there, or only
build it?

Please send a v3.

-- 
Thanks,
Sasha
