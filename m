Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657141A4FE;
	Wed, 12 Aug 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528288; cv=none; b=TapEgB2SKFW/NzIPI/y2axEnxFHOVkWbJSvOW7q7Age6MGgTK6bMabykow/61GiRuvUMEN2JUmTaFZ5Cy4gNAfk6eSfPYoiJsLD6aaG6YzOxA+7+ix8nyf6sfa5Vl/tSVZsTBygmk7LM0uRgRPquGY89WgbMpzCO1cxXvYjKx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528288; c=relaxed/simple;
	bh=6e0PbF6YXiTK0vtHWdzePjNYGqU6fdtZgcPCjDRQqvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQqZBWTBQLVI9tokEpgIZSDR5POemiV7+anl3+a7gUoWXy25dONIibs2VboWO7cYPBcZ+vrdE7djVwA7V4iED6Ddc7Te+AydgMtOUXSmDayoO/ZE5rPaDw9p5TlJL0Pxa31YZ/5I9iSsHcRNCpS/+WfY6U9pe025/cpIruYU7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHrYA48G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHrYA48G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9381F000E9;
	Wed, 12 Aug 2026 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528287;
	bh=qQ46ywu3kTNDLFT+jQQ87fTZhvSQH5n+X8XdHSB6bo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FHrYA48GX/Hq4ZOwuW8IjjDsgZb6B84w3WP4dF8FtEPmTsWrpol7UIyFMUpCGGxe+
	 xl+DOjdx2TnNM+UwV6JFzhsU/pQxewVXJ+enGwfOg8VA24LqKiLNFOFNnLZ5UzZD6B
	 uJ3mBB92x7yQ2u9dzvLoIQ6ed4tgNUXGm29jdLN+as7E5qvV54FPRX2bhSlAVvxySq
	 LQwCfoqyWw7LU6trBM4Whnr5iQF2qgKjUguWX1aCJbTno9f94JzGmAeVY9b+b3s5C5
	 uPETEwdoSAqlks+T/34DLVux9XUwVKOogjOMq6fuIhDZQAhWfE4/Mf1f8vtOCb0PMX
	 tRd7lBOAElMDQ==
Date: Wed, 12 Aug 2026 11:51:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nbd@other.debian.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
Message-ID: <20260812-weckt-allesamt-lehrinhalt-b9b85bf7445c@brauner>
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>

On Thu, Aug 06, 2026 at 12:36:56PM +0200, Daan De Meyer via B4 Relay wrote:
> Commit 267ec4d7223a ("loop: fix partition scan race between udev and
> loop_reread_partitions()") stopped disk_force_media_change() from setting
> GD_NEED_PART_SCAN. The caller audit in that commit only considered the bit
> as a request to rescan partitions, but it did more than that:
> bdev_disk_changed() drops every entry in disk->part_tbl before it consults
> disk_has_partscan(), and only the re-adding half is gated on partition
> scanning being enabled. The lazy scan on the next open was therefore also
> the only thing removing partitions from a device that has partitions but
> no partition scanning.
> 
> Loop devices without LO_FLAGS_PARTSCAN are exactly such devices, and they
> are not unusual. bdev_add_partition() only rejects GENHD_FL_NO_PART disks,
> so BLKPG_ADD_PARTITION works while GD_SUPPRESS_PART_SCAN is set, and
> parted, libfdisk and systemd all fall back to BLKPG when BLKRRPART fails
> with -EINVAL, which is what a loop device without LO_FLAGS_PARTSCAN
> returns.
> 
> Commit c4f4c0fc551c ("loop: remove manually added partitions on detach")
> fixed the detach path after this was reported as loop devices picking up
> partition devices from a previously built image:
> 
>   https://bugs.debian.org/1141434
> 
> These two patches fix the two remaining places that relied on the same
> lazy cleanup, LOOP_CHANGE_FD and NBD_CLEAR_SOCK.
> 
> Both were tested with the blktests loop and nbd groups on 7.2-rc5. New
> cases covering the two paths fail without these patches and pass with
> them; they will be submitted to blktests separately.
> 
> Signed-off-by: Daan De Meyer <daan@amutable.com>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
