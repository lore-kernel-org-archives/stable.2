Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A045D1A4;
	Tue, 25 Aug 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668130; cv=none; b=SYEhiMa3JUVSO4Ohei8hMO/o9iRId34ihJJjDIp7VCVGSQ3CJdOWFCLGjxzKDS0zQDh8ccQoFZ9kDqLnjcGZvzWlR9cJUFVVoTWVs8Hn9vdcOyafGjKYGwjUinQIIHBUxNHhgXuZnKVcbxTNGXcEsYEuS7PpZWQUu1fttx/6hjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668130; c=relaxed/simple;
	bh=XFuYZnxVO5460vD3ePEI9emdXXL44pUnHZe0CjT5EZQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ssGHMnxo3e65v9niqRvjgzkR2rEli57iULXhWmZpqXPdOI5HPHTt6JNM86lpCIsxONYES20yECr8G+OC+UM6Bifh5KMl131QQpOM9vAMvN2EAbdQyK/Wh+M2Kv4RhQU0oxtJYqV8TZKLdHDs1F5BaWiP7u4az/POiQzFesmrHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R52U+wJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R52U+wJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172781F000E9;
	Tue, 25 Aug 2026 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787668128;
	bh=dlz7XUkj8qDNfzcilR7Ut2+kq050uSM6VT4JRk29JOQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=R52U+wJSbiTZho8aJN8vv4JWp1jVCyp2ZCGr3lCpvAkkIQ9ERvoNfjwFQ7sK/grfR
	 FcL1yOqTRNTAv29w3bPiss2jMys/m5DgpD3cZfCzVbTxxiXi4/w9dN3XpjF9MuqJ29
	 pRYD7BXi7i3rmsRx7EaQ/b8nQHfpNdkq2BEZu3XBLs+MqAq5mNWdC0BydR2OTQYPRf
	 Hhcq94IUxMb6/TFL4tSMIiJYJcreFzGvv4XP8jfkbzipye9JhgGgHRnvwrAYaxdi5Y
	 tFkWGi/Bx8JB79eooGVCJ8lokGZk01LU3HMAPAP754W5+Piqm2osgNPM0oMJwxKqlP
	 6vV7GvxGFHZWg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fs: don't return -EINVAL for successful nested thaw
From: Christian Brauner <brauner@kernel.org>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260821085451.65206-1-moritz.tanner@linbit.com>
References: <20260821085451.65206-1-moritz.tanner@linbit.com>
Date: Tue, 25 Aug 2026 16:28:44 +0200
Message-Id: <20260825-indiz-umfassen-gastspiel-863421e05099@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2730; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XFuYZnxVO5460vD3ePEI9emdXXL44pUnHZe0CjT5EZQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1Lpun57helXHmNBa7pmnRT7dPmetUYdekmJsxbaFzf
 8euyM9zO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy9SIjw/Nb88U5eK/cqDE6
 1/IwPcpb8fB0jw0Mcke/GCXMPvc+8wAjw3ul7wqHPkj9s5eceXODd+m5kCfnDu7UltXT3S+Zl27
 /nB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-08-21 10:54 +0200, Moritz Tanner wrote:
> Commit 7366f8b6fc6a ("fs: handle freezing from multiple devices")
> replaced the freeze_holders bitmask with per-holder counters to allow
> nested freezes. In the bitmask version, a thaw that released a shared
> hold while another holder remained returned 0. Since the rework,
> thaw_super_locked() drops the freeze reference via freeze_dec() but
> then returns -EINVAL when other freezers remain, misinforming the
> caller: the thaw did succeed, the superblock just stays frozen for the
> remaining holders.
> 
> This breaks bdev-initiated freezing. When a filesystem is frozen with
> FIFREEZE and additionally frozen via bdev_freeze() -- which nests by
> design, see fs_bdev_freeze() -- the subsequent bdev_thaw() receives
> -EINVAL from the holder op although its freeze reference was dropped,
> and therefore keeps bd_fsfreeze_count elevated. Then device-mapper's
> unlock_fs() ignores bdev_thaw()'s return value, so nothing rebalances
> the count. After the user's FITHAW and umount, the block device can
> never be mounted again:
> 
>     dm-1: Can't mount, blockdev is frozen
> 
> There is no way for userspace to drop the leaked count; only
> destroying the block device (or a reboot) recovers the device.
> 
> Reproducer (any kernel since v6.8):
> 
>     dmsetup create dut --table "0 $(blockdev --getsz "$DEV") linear $DEV 0"
>     mkfs.ext4 /dev/mapper/dut
>     mount /dev/mapper/dut /mnt
>     fsfreeze --freeze /mnt      # freeze_ucount == 1
>     dmsetup suspend dut         # bd_fsfreeze_count == 1, ucount == 2
>     dmsetup resume dut          # ucount 2 -> 1, but thaw_super()
>                                 # returns -EINVAL, so bdev_thaw()
>                                 # keeps bd_fsfreeze_count at 1
>     fsfreeze --unfreeze /mnt    # filesystem thaws fine
>     umount /mnt
>     mount /dev/mapper/dut /mnt  # EBUSY, forever
> 
> The same happens with fsfreeze held across an LVM snapshot of the
> origin volume.
> 
> fs_bdev_thaw()'s documentation already describes the intended
> semantics: "If this function returns zero it doesn't mean that the
> filesystem is unfrozen as it may have been frozen multiple times".
> Restore them by returning 0 when a nested thaw drops its hold while
> other freezers remain. Thawing without holding a freeze still fails
> with -EINVAL as may_unfreeze() rejects that case before the reference
> count is touched.

This was contentions when we discussed this back then because you can
also run into situations where userspace thinks it's safe to access the
filesystem because they think the thaw succeeded. But anyway, I think we
can try this change at least.

