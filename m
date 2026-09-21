Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAD4AC142;
	Mon, 21 Sep 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003427; cv=none; b=ClAIWfJ+D1icP9mxp5i54JskZoo9XzuUmMQ9+pMz9FHP/w1L9DGdr1tNehqlEZKF88zd0YfDiOqcdEz+FPLInojt34ZYek/+ZGG2T80SZzKux2Ysl6RMwIsIB3jadJJdHykxg+SqceZqlZFQojwQW8NoSY4AunVtxw6b+rzK9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003427; c=relaxed/simple;
	bh=Ib+Qh8ORlDDCdZsS7BwH7LaX9Xj4VQLNze4+U/RZEx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtWf/9reeLP7xrZCehNd+IKSFLVLoRwH3tcWzYSCfZxNFqjrvBSB0j7TubO+XvwkVJn5rRHYRmkx2IeWp6K8i35flPDL0R75IcMRAT+rOzrTN42s9oWSRHx2BfIWnKlC1hz9p+QhYLZ8aXOl7C5nfy9g8MURttkliUMHqtk4CCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzrK8ImN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzrK8ImN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566471F000FF;
	Mon, 21 Sep 2026 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003426;
	bh=7J60WjR8ZiZoP8MIhOK/ME0rM6FOmnZtVQtbJTUj+RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FzrK8ImNHGUge0aBlL7OjNPSTGdqRpBjSME0gBLaksiN76AB+VtA+v+65Q3mPiRdh
	 5dcyLrcCrEgaaqfmtGsfeahdd6hz9m7IflnN3tj5oxEhsKVVlrfy1jR6+WynW9QxBi
	 9NQkuP7L3iMf6FplmPmkdBjT78Juz2gyoYgp8Ix2dFotmcceX2UXjyDNXeWoRPVXYx
	 ZhgzJ+bKzwBTfMR+H2eOzHPjagDfzM72G2cKx7Qogt4xHMga0ubL+Lsccsx8Y96IZe
	 ET+xMULfHudHUhvN0jRte7D5nVOnSSWyAN0gCcrN9KQ38bXYtxOodlAtiUNL/aQ4Zt
	 ZtQ7J+WZfyMTw==
Date: Mon, 21 Sep 2026 17:10:20 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: garmin_gps: validate packet data length
 in nat_receive()
Message-ID: <arFI23YXe84v95DK@quoll>
References: <20260919112819.3885778-1-benquike@gmail.com>
 <2026092059-hacking-coveting-c629@gregkh>
 <20260921030236.1040858-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921030236.1040858-1-benquike@gmail.com>


On Mon, 21 Sep 2026 03:02:36 +0000, Hui Peng wrote:
> In nat_receive() (called from garmin_write() when userspace writes to
> /dev/ttyUSBn in MODE_NATIVE mode), while garmin_data_p->insize is less
> than GARMIN_PKTHDR_LENGTH (12), the loop copies up to 12 bytes into
> garmin_data_p->inbuffer. Once garmin_data_p->insize reaches
> GARMIN_PKTHDR_LENGTH, nat_receive() computes the total packet size as:
> 
>   len = GARMIN_PKTHDR_LENGTH + getDataLength(garmin_data_p->inbuffer);
> 
> Because getDataLength() returns a signed int from __le32_to_cpup(), a
> 12-byte header with a negative 32-bit length field (such as 0xfffffff5,
> i.e., -11) causes len to underflow to a small positive value (12 + (-11)
> = 1) without any bounds check at that point. Then garmin_data_p->insize
> >= len (12 >= 1) evaluates to true and nat_receive() calls
> garmin_write_bulk(port, inbuffer, 1, 0), which allocates a 1-byte slab
> buffer via kmemdup() and immediately reads 4 bytes from it in
> getLayerId(buffer) (and again in garmin_write_bulk_callback() when the
> URB completes):
> 
>   BUG: KASAN: slab-out-of-bounds in garmin_write_bulk.constprop.0+0x3eb/0x500
>   Read of size 4 at addr ffff888002cc0ba0 by task init/1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    garmin_write_bulk.constprop.0+0x3eb/0x500
>    garmin_write+0x60f/0x1450
>    serial_write+0x123/0x200
>    n_tty_write+0x8ea/0xeb0
>    file_tty_write.isra.0+0x44f/0x7a0
>    vfs_write+0x671/0xd20
> 
> Validate the unsigned 32-bit data length (dlen >= GPS_IN_BUFSIZ -
> GARMIN_PKTHDR_LENGTH, matching the existing len >= GPS_IN_BUFSIZ bound)
> in nat_receive() as soon as the 12-byte header is present, resetting
> insize and returning -EINVPKT on invalid lengths so garmin_write_bulk()
> is only ever called with a full valid packet header (12 <= len <
> GPS_IN_BUFSIZ).
> 
> Tested in QEMU against Linux 7.3.0-rc3 by emulating a Garmin USB GPS
> device (091e:0003) via dummy_hcd + raw-gadget, switching /dev/ttyUSB0
> to MODE_NATIVE via PRIV_PKTID_SET_MODE, and writing a 12-byte native
> packet with data length 0xfffffff5: on the unfixed kernel this triggers
> KASAN slab-out-of-bounds reads in garmin_write_bulk() and
> garmin_write_bulk_callback(), whereas on the fixed kernel nat_receive()
> rejects the packet with -EINVPKT and 0 KASAN faults.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v4:
> - Kept the fix strictly inside nat_receive() and dropped the other hunks
>   from v3 (garmin_write_bulk_callback(), gsp_send(), and changing the
>   return type of getDataLength() / getPacketId()) per Greg
>   Kroah-Hartman:
>   1. Assigning u32 dlen = getDataLength(garmin_data_p->inbuffer) locally
>      in nat_receive() and rejecting dlen >= GPS_IN_BUFSIZ -
>      GARMIN_PKTHDR_LENGTH (matching the existing len >= GPS_IN_BUFSIZ
>      check at the top of the loop) prevents both negative/underflowed
>      lengths (< 12 bytes) and oversized lengths without needing to touch
>      getDataLength() across the file.
>   2. The out-of-bounds read in garmin_write_bulk() and
>      garmin_write_bulk_callback() was only reachable because
>      nat_receive() allowed len to underflow below GARMIN_PKTHDR_LENGTH
>      (12 bytes). All other callers of garmin_write_bulk() always pass at
>      least GARMIN_PKTHDR_LENGTH bytes, making a separate length check in
>      garmin_write_bulk_callback() redundant.
>   3. In MODE_GARMIN_SERIAL, gsp_receive() already bounds insize to
>      MAX_SERIAL_PKT_SIZ + 2 before calling gsp_send(), so the extra
>      bounds check in gsp_send() was an unrelated defensive check.
> - Added Cc: stable@vger.kernel.org and QEMU reproduction details.
> 
>  drivers/usb/serial/garmin_gps.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



