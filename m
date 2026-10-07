Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E1418A36
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359024; cv=none; b=B9ZhOI2MtKtMJEygy8ShowM6XZ40OWSS7avQGqY6AtUsvX73ugRgYWQj5dnFPbUfL7ARay8H9BJ2lDsNps35FzxtcXIGhmXU3hlOtM38oamDTfeQZ6BvzKnJ3U6VbRGy2DbtvNKWq5ylFKWyh0sJ+wVvoT3zpfnFvCqvs/9xu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359024; c=relaxed/simple;
	bh=v3zE8BK3Zz6jqBFdVmUbELCBSt6bNUgzEtIjKD6mfx4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NTQN5qtb8csJ5rc1cTTOZOBzLtL2YUj8ELeOIsLy450neErZMburEwZN9ehTUBggZJYhE+hX8q0nwr1yuTIck3fR+oC6v4ufBAC+Bs7gcloChPR3sbIkiPGpMUZPAzQIgomfso/8HRlssnl6SJZehmb6tpCUIBruwBkX4oASonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=Dcn7f580; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="Dcn7f580"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a8a63785a1so258968a91.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1791359019; x=1791963819; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GQicjEcdlh1TnS/6Ie/91AXB9eJFWVr14slz4D5RAfI=;
        b=Dcn7f580/tezpEauzZyhQF3dV4U7j9V2Fv6oSQCRJLJDw08UZ7dRT3LY4D8rVoAzfA
         B4Efao2l/E83+3VIegy9IaLQggDV9G72DLYG3t4WaWO8AnaxS7I8IawOVyLMm5BM41Xl
         2NsGfc00yhJoDQPqnlPJCp0hIAjalLsQu2SD61YSLPbdAFUpW6sC08RYZoiA7oJytCrU
         fh90HhZ/eGKlCGYXUIrFDLB/ueKu8tPUVrMcEbCTpVMYBebmdoj450J5zLtZkPAEzLnJ
         8lnWt4UNtFA3zPnTaAC+oz0AAoJRq5kpMBLlCWpr2spEgBwhYWoi2YiuPtI5CQQ8OOrk
         lKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791359019; x=1791963819;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQicjEcdlh1TnS/6Ie/91AXB9eJFWVr14slz4D5RAfI=;
        b=IMgSGuvnuvpgOo9Jsf+ncnCRqgx+NGe9PrD0yVTihbzUrBwin0n1DVuOrnGLN54OjP
         UsO1/yGf7ZnO7eUFr4FvPSC8449wqpKt9ukqgP5Zg6Q6thkRW4ksR6tJAFUZH1QqreG+
         QFz24dkq7cVECqZ7MBwWcmrZTZQkb6swnXHnP708L9RC2P0k4vb9Vu5bWQjgLJdyy4v2
         CCecWqUQ4SGJqucS3OlYo6c1Ad+lq7boP1PR/wZxtDPrrl6uEp/DxLUAAuCgNHfQ3+kv
         X+PtcWxyq3Re2KU/8C5k38Phu9+xw0GKBQoGkZ29S+NjJyhfXnJdJwewAYUxpEY7YHSw
         7/qQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmsO4IvVzf+2qkI4Yh8iO/2wtkipYrvx0s+4fv0M3AOPP+YFXynmKb++F5fmT6AqM19pR3JAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ1+mqKgpwmOLq2r9pfMTQz3PcRkWDBmLM/nCMmYdmkco0KBhj
	qFoNNQZZ8Si89pwk8Jn2ebtMtj+MiZagGIP6DXGZ2mLnHvIPtIiC4tLbJqNigyge5d0=
X-Gm-Gg: AYBFou1nljjuc7WWXgEgJ8xGAkPPL4cthhAYjM3az8nDctpi1AdyqKoOf7LgETrFX1N
	83ZpTrOJ/ugNeIVbqWIPtoUv5LgDB2AmG7ivsVfxp1t/0MzqFsXp4GSn/vauMEv4LHxx+9h70Qc
	k6cFvpOq7h3zv3609FchnnVwbAjdnoYo935J0cMioogx++d6zleFCmXaXWTl+ZIpolUpoCr6+aN
	e0ycJHtaK0E4Ylo6SXno1vHDLS7P2/fwKsZuJmKLkNS8iP9L4am5sJMzvl6KP7o8J2PYaD5ireL
	wxvkxhlt/hphlBxDkO87ZUA4esDp7Ey6sGRpY5G80QIlZIvj82p4W/s5Zmuu/A0CzZuScq9dchC
	2Ow1JE3U1DSDJgBC3Wm/9CKplwsv8FtwlFkCnciXBE14zraQ9N3OJrXJ0TSLbosrMzFOaG3zVJw
	djhMJiePgCqqmE518kaTRfQcpVr7qoH6+Cuzo/Ye0ly3fUbK+QOqYRZ9/59kcrWQH9yOo0VUa06
	A7T6+lroCkbk+CW4kS4KM/F6bVZA2BIN7I2PcrCsNa7I0gM08Tj9Q==
X-Received: by 2002:a17:90b:1345:b0:3a6:d94d:e147 with SMTP id 98e67ed59e1d1-3a8a0845138mr867138a91.15.1791359018649;
        Wed, 07 Oct 2026 00:43:38 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [24.64.171.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm9993693a91.2.2026.10.07.00.43.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 00:43:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH] ext4: do not accept rec_len 0 for block sizes below 64k
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <qvaeibtro3i7xxpxbgomjmsvnaejtlo5if57lp5aeowl42e6v2@x3ckk5ovep4s>
Date: Wed, 7 Oct 2026 01:43:26 -0600
Cc: hengyul@cs.unc.edu,
 tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 libaokun@linux.alibaba.com,
 ojaswin@linux.ibm.com,
 ritesh.list@gmail.com,
 yi.zhang@huawei.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E54F7146-77CB-4E75-832B-F760E289584E@dilger.ca>
References: <20261006111546.3252481-1-hengyul@cs.unc.edu>
 <qvaeibtro3i7xxpxbgomjmsvnaejtlo5if57lp5aeowl42e6v2@x3ckk5ovep4s>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

On Oct 6, 2026, at 10:16, Jan Kara <jack@suse.cz> wrote:
>=20
> On Tue 06-10-26 07:15:46, hengyul@cs.unc.edu wrote:
>> From: Hengyu Liang <hengyul@cs.unc.edu>
>>=20
>> Commit afa6d5a16bf2 ("ext4: remove PAGE_SIZE checks for rec_len
>> conversion") made ext4_rec_len_from_disk() read a rec_len of 0 as =
"this
>> entry covers the whole block" for every block size.
>>=20
>> However, this special value only exists for block sizes of 64k and
>> more. With smaller blocks, a rec_len of 0 means that the directory
>> block is corrupted. As of now, a directory block that has been
>> overwritten with zeroes is treated as an empty block. The kernel no
>> longer reports the corruption and can store new entries in that =
block,
>> while e2fsck still reports the block as corrupted.
>>=20
>> The issue can be reproduced on a file system without metadata_csum:
>>=20
>>    mke2fs -q -t ext4 -b 1024 -O ^metadata_csum,^dir_index img 8M
>>    mount -o loop img /mnt
>>    mkdir /mnt/d
>>    for i in $(seq 100); do touch /mnt/d/file_with_a_long_name_$i; =
done
>>    umount /mnt
>>    dd if=3D/dev/zero of=3Dimg bs=3D1024 count=3D1 conv=3Dnotrunc \
>>        seek=3D$(debugfs -R "bmap d 1" img)
>>    mount -o loop img /mnt
>>    touch /mnt/d/new
>>=20
>> Before commit afa6d5a16bf2 ("ext4: remove PAGE_SIZE checks for =
rec_len
>> conversion"), the last command fails with "Structure needs cleaning".
>> After that commit, it succeeds.
>>=20
>> This patch makes ext4_rec_len_from_disk() return the on-disk value
>> unchanged when the block size is below 64k, as e2fsprogs does.
>>=20
>> Fixes: afa6d5a16bf2 ("ext4: remove PAGE_SIZE checks for rec_len =
conversion")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
>=20
> Makes sense. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> BTW, the kernel never allowed larger than 64k block size so I'm kind =
of at
> loss why we have that strange code trying to accommodate upto 256k
> blocksize here. I'd just delete that code (not really related to your
> chnage). Ted?
>=20
> Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

I think Fujitsu was using 256KiB blocksize on SPARC servers?  Something
like that, but I never saw any patches for it.

Cheers, Andreas





