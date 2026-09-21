Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DB4BB27C;
	Mon, 21 Sep 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003778; cv=none; b=S9p+zR/XPa2dHMUzvXHreVuuVlCODc/IQySfKxcUK+Cog441pQgGsPAesJRt1KTWC5Jv1uSpnhdvprXpyfuH/tRbodZXEhRdzPyWUVF3ucO8G8kbkWzxKjRevrOD1cR/ahNINCmVZlYGHsNEejFdhi5zPiA6qZbGzgME0Lpp5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003778; c=relaxed/simple;
	bh=V4GSK/qWf5Ms9CYfyWjabIOgvNVwdzUU8y253T8SmUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBnLYik6BvnuHtBXq5QDfBKvdrzRBS1i59ENXANEzvq+ZhPdZvsIUZElxIuyPZ0MuuGdyyJ1D7ywGXMe8Mps2eGlvZQkQSugvXu3DJS6riCCw76mKDpJCr60aSSg7lkxPgq5TvOnJdmFdtJeOfUB64mAukdXCz4NedoxBWUq7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCwelQrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCwelQrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AACF1F000FF;
	Mon, 21 Sep 2026 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003777;
	bh=veKrzBYwtqkZ5uAl4Bsq3wYfjpPB5wJHOcq0fU9d+Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCwelQrMjozQ6vbdqphQolPQ972BZtLd7CKLuPTQUNeazNWIu/tlwZauW66zWBY74
	 gb0awoGuIFOmP74/VRZv2cJ59MsMaoZJN/Ugm2WRM7ABnJOCn1llTHwhhfqmu77Tda
	 Ef4gcOGoudHJg3ycT1XeCNY6Dx7HvbHEq15Xj+ZQ6431UQ3zeAPxIFO/zjUsNbQc9v
	 dZmv8MQgQbVVWmoQrYG0fCVNGfz9ltIiVP+nu3RcWx1vlFL/hedcZzKTq8lkyyzccJ
	 4nCwgo14Z34v/N2uelH5+0O5HyY1dDy74Jwnvpos8bFjHysTMDl76l7Fg47EbXFGkH
	 8jpIrWkd3ICHA==
Date: Mon, 21 Sep 2026 17:16:13 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: garmin_gps: validate packet data length
 in nat_receive()
Message-ID: <arFKNFtH4e81GtXm@quoll>
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



