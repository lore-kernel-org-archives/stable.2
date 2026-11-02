Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657611;
	b=fTS8tNzK3z+Z5dply4iyo3kcRx+SCC897y3S+x2c38izCbyiFVYxL02/kRVLxgJ0By32
	 UtMFys7B9GbLusMDxZ0Y4n9h24C4L93ENt5+eJH3Tyod8iFvpR/RZdfOjcqx2uwXxCf2J
	 mVKzVaQTlpW1VIHzkeOX9dk2W/vDI8n9KnQUCCEWFgPrGn0W34PjqYChO0zYoK5mqQ4Bp
	 Y6nYLTvlhREkru6A3ZxwQX5FhEP0wBigMDJqFGkmE724Yk+0nMx5CCI8qLCcpQtw30L6F
	 Pw8vVWjCRVeoTxPWYsOF+TSPLd3sqGDJzte+4fgaDqLGhrhlpVwFv9ZEiwfelATQ5NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=v4BmZuWiHx0Rl4kjelsiqmQf1Hb7QwnreUWudT7/uTY=;
	b=g27adxri+dBGGOFkIoW6vWg/FdoByqlJO9wi+i6Wy1I4Xty2YxQkjGx3oGDbScVIjA74
	 5GhItuiF2F0ij8oYS47GnHlHsC5pgj7nZ4vgNcv1+w5xqq/niscBg3K1cdfboxKuytHIs
	 abvPOzsR2StFlM0s6Bw03qW6ERporDpkqtgpderQSESCJw6TLKduh63AY/GRgl6iinjpP
	 ll+ScOKur/AXOTIgMJ3Qz06Xwl91baJ5steEk/QN3/F94c7iu7NSb+DebcVcK0daEBm9f
	 1wyjz79nmPinNQPwv06DiPHHU9Tjo+WFah9HZl/1SwNQ2uJDop783Ufk5QZ7ehLqmtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cc0cOTHc;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4B606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FA4B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Cc0cOTHc
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b09e07e149so28733157b3.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793657609; x=1794262409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v4BmZuWiHx0Rl4kjelsiqmQf1Hb7QwnreUWudT7/uTY=;
        b=Cc0cOTHc+/eb2bci7+FGVWlQ7sSuL7reQBhV6GypDHg91AcIXSlcufAN65IKE0oPXc
         /cUEgIR0pand+a0Z380iozt3Ikh+hCByjnqEDXV+IvBuSgSto5DCf4FMg+kl392Aa7es
         EJHgWZ+Msc4LRZYE++9Y20RIDfdSR98WUl3a6deh2rNj5YGAcgDFnBaKhwWVtw2WyrVQ
         N5NpnptIH/tbOkFljzc5wBLP9w9p6RpH8Tqu2g/HqGGzqPTyvV4Zy2MR+1+Mzf80PUXl
         EuUkQH5BbKquYgeQXrSRVFdJN3O3yPHo/rUX4fntIO+QSF5jf+ytqfK08rhs/IcindTX
         9gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657609; x=1794262409;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v4BmZuWiHx0Rl4kjelsiqmQf1Hb7QwnreUWudT7/uTY=;
        b=KWGOZAbdouw8o2BXmbGNqDPwGUWPLjQmYgGNx46KuNbUCJNVO7qM5uQuetMiUECMmW
         jqWnM5Wmh0ORB45BtfOhi33epJKdnBnRDyVWOKvxarQJR7ka89JqWJizDupxLBNnBki+
         dkq3wuCt1vXQbzfx8p++WE8siOsrGya8Jc349bb04ZRvcx/p/TNh78Ccu8XZXBfu/k4V
         Y2vfs+JtmKFmXO6w8PXKaccvk3AiS9bYlR3C/km3zTV/73LlA6RC8eayXUx2yA3sufof
         4GwC6x1YEjHhB5vEoP6Zg8zptvDxZwRE1LOFhE4S8D6gIeDG/54/pH1+8Io++7+vrMBw
         sZ9A==
X-Forwarded-Encrypted: i=1; AKwUvBz7yrvO//Pgt/0gcG0bxyodi9uJGcHXzw+QAg1jcn1Jk8yF6cKAzg4Ye1h3CatlpyyhM7Vcs4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vXXUa1LkarXfDrdA5uJqOfM2VrJUCcxqJK6Uo5KhuhQtOIZG7
	uYPbiBnuYjqgeuHc2Jezvnpdk/1F9PIyu/xE8NbtsjWdflVT9/oTSjdeN9384tFldC8uBbHhuk/
	7fHY0Mi8=
X-Gm-Gg: AYBFou0J0HYI/M74SfFhNnmx9uR82TWpQOKUj/4eJS+GsLq5d6Ne4iBgoaYosNUTef6
	oZFPw+t0pQbmcu3i0ERz4HdFU2nPli6DErhWjcD/cmAArNtJcviCDjk6Fqlb6UaKD8aTUlQOqnK
	+TNgBax1tNUmX4kuVr21zIXJ87YZeZGpEvHlmKR6Yr7nkXvRsTCYQDq9kwYS5PfTssYsVKDWnr4
	2I/ojW6vhpmnUfLrmHNvqIR/i7LCs/X9eOmcXNKA1TYJCZ62TkLFEYIb/Ch4QjsgfoYSUyKJElM
	RGlX5Sj6C9DobUiUrfA5j+1DvSQxdRW/fn36DvojnvYwOK9TOWpmZ66rG0S84FO93RpT4zXTst/
	vhNniVG0DSCDp1n7qzmIbMfY2vL/T0DH24qleLyB6xmY2ejptT1Bvu/avCWHvlOR77cu9NjJkrq
	8v4wy9KgK24hupR2a+hTkuknwkmNITmpo1L/61+O3Nfi7bkOj4Shh91prrZXXf1kIFpwIRKQRwJ
	gPcxMdgNYb5bjXpiNSbWE34ITTHUwvLaCMFTjD35yvQQzXP3AU1aCw52S237+KR/xB/OziMOw68
	aeeym/o4YJFb/6dxojWtkvLLtmug2YkgpxSyY9kIQyHtD0pXY+R5cXRzSQd9QxG8Hp6OPYoJaS3
	rTMNM2FZ8tRIAbDlqYFZyqUrwGc4epnBncbRpmEYPH6JNovWk4yYPlVWLzpN6jX4OotmMRgdjbK
	nxPqK1T3hyNyNFH2Cw
X-Received: by 2002:a05:690c:a:b0:8b0:7900:1405 with SMTP id 00721157ae682-8b2b676b88dmr74523687b3.81.1793657609069;
        Mon, 02 Nov 2026 14:13:29 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:2f9f:a96f:bcb:6021? ([2600:1700:6476:1430:2f9f:a96f:bcb:6021])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71240bcsm59820517b3.9.2026.11.02.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:13:28 -0800 (PST)
Message-ID: <fe42fc7c1a7b357d614947b844698c5a0abb78f4.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fall back to buffered I/O for direct writes
 past phys_size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 14:13:26 -0800
In-Reply-To: <20261030043252.4163173-1-hengyul@cs.unc.edu>
References: <20261030043252.4163173-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-30 at 00:32 -0400, Hengyu Liang wrote:
> hfsplus_direct_IO() passes direct writes to blockdev_direct_IO(),
> which
> does not go through hfsplus_write_begin(). phys_size only grows by
> the
> block size when hfsplus_get_block() allocates a new block. It starts
> at
> i_size when the inode is read, which does not have to be block
> aligned,
> so after a direct write past the end of the file phys_size is smaller
> than i_size.
>=20
> However, at the last close, hfsplus_file_truncate() sees i_size
> larger
> than phys_size and calls hfsplus_write_begin() at i_size, which
> zeroes
> the file from phys_size up to i_size. As of now, part of the data
> that
> a direct write has just written past the old end of the file is lost,
> and fsck reports no error. Commit 5f63ac80aef2 ("hfsplus: fix issue
> of
> direct writes beyond end-of-file") avoids this only for writes that
> start past the end of the file.
>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 32M hfsplus.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus hfsplus.img
> =C2=A0=C2=A0=C2=A0 mount -o loop hfsplus.img /mnt
> =C2=A0=C2=A0=C2=A0 printf 'A%.0s' $(seq 100) > /mnt/f
> =C2=A0=C2=A0=C2=A0 umount /mnt
> =C2=A0=C2=A0=C2=A0 mount -o loop hfsplus.img /mnt
> =C2=A0=C2=A0=C2=A0 xfs_io -d -c 'pwrite -S 0x42 0 1024' /mnt/f
> =C2=A0=C2=A0=C2=A0 umount /mnt
> =C2=A0=C2=A0=C2=A0 mount -o loop hfsplus.img /mnt
> =C2=A0=C2=A0=C2=A0 od -An -tx1 -j 100 -N 924 /mnt/f
>=20
> Bytes 100 to 1023 read back as zeros instead of 0x42.
>=20
> This patch will make the other direct writes that end past phys_size
> fall back to a buffered write, as fat_direct_IO() and
> affs_direct_IO()
> do.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Slava, you mentioned that you are rebuilding the HFS+ direct I/O path
> [1]. This patch fixes the current code, also for stable, and may
> conflict with that work.
>=20
> Writes that start past EOF still expand the file first, as in
> 5f63ac80aef2. Only the other writes that end past phys_size fall
> back.
>=20
> Tested in KVM with KASAN: the reproducer above, and all 805 fstests
> on
> HFS+: 10 failures without the patch, 7 with it (generic/521, 617 and
> 760 now pass), no new failures.
>=20
> [1]
> https://lore.kernel.org/linux-fsdevel/161fab786f919adb384fbf22dc19f3289bf=
5f24d.camel@dubeyko.com/
>=20
> =C2=A0fs/hfsplus/inode.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index aed0866499b2..70c13dcdcd8e 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -169,6 +169,15 @@ static ssize_t hfsplus_direct_IO(struct kiocb
> *iocb, struct iov_iter *iter)
> =C2=A0		end_page =3D end_off >> PAGE_SHIFT;
> =C2=A0
> =C2=A0		invalidate_inode_pages2_range(mapping, start_page,
> end_page);
> +	} else if (iov_iter_rw(iter) =3D=3D WRITE &&
> +		=C2=A0=C2=A0 end > HFSPLUS_I(inode)->phys_size) {
> +		/*
> +		 * blockdev_direct_IO() does not go through -
> >write_begin(),
> +		 * so it neither zeroes the file from phys_size up
> to the
> +		 * write nor keeps phys_size in step with i_size.
> Return 0,
> +		 * so that the write falls back to a buffered write.
> +		 */
> +		return 0;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D blockdev_direct_IO(iocb, inode, iter,
> hfsplus_get_block);
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

I think this modification will be wiped out by my pathset [1] because
hfsplus_direct_IO() will be completely removed. I am going to renew my
work on this pathset now because 7.4-rc1 has been released already. So,
thanks a lot for the patch but I assume that this issue is already
fixed in the patchset. If not, then let's double check it after my
pathset has been finished.

Thanks,
Slava.

[1]
https://lore.kernel.org/linux-fsdevel/20260914233941.2966421-1-slava@dubeyk=
o.com/
