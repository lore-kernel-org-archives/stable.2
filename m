Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522850;
	b=WHT+qbCGvq5CtrQBGpIxx8MHCtmFJVqD4cE7tx5gxdcVnINw+57qNViaLD1ncNztXReV
	 VdvV4GLY1Pkp0TdCXa/MFe06VZi8CbL2yTMwdDEpzE6FWU7oew+wtrekKH11v5L4U/75i
	 5NyLncDUv3Rk2qCKYA89gCfVX+xvERcsgBLL4I5q7e+RIq9wjczdjrs0swIkfSTqIDoQB
	 zwwRqWCB+uf3LGlSdZkvJFl0GyreCdswT8CumYsuGZWcFw7hnKd1fTzxE3ZbJnMNU3mbI
	 ISDCHCZ4x+gDHzlcX8vxUhBUpv58xoM8yps7vjPdKggZPdLTEG4WAm+Z8atOPpmKUtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522850;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L54BL4DHIvMAW1f3YiW+oYF8hYcaZJufQX76TBLYLdU=;
	b=e5YwatbTE3EZc8oGg+h2hNMzGc9I4RRTGXIVj6KUWB6PfxSofMLRgN1NMnmX/6XUJN+P
	 3EUB/p+fHUuZTag3QgybkCdiDKUk5zF1YAWAkb+p1V0Z8WJbtowhFSS3HtxgQ7Uz8iKdv
	 SiersVAZgoucHtBMVd8SvBFOHfvmYo5bhDwi5Q+629rxrbor5oHQw59NTu2sQGj8nk0Ej
	 eMHauU4i5lvm25oyO9ylF6DW85lgCr4mvNMfEdsEGsXakhREgNV7oEwC5xy4Scldfm0oW
	 tlIStOGoCkFOGW9Dbhn8sw9uOWO3oYn3+maMZybqFNu7INwbN1mVQyLkjpt50sxdCjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9e8HYMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42819606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9e8HYMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49CD1F000C9
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522849;
	bh=L54BL4DHIvMAW1f3YiW+oYF8hYcaZJufQX76TBLYLdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A9e8HYMhL/MXe6XFiIjGo91IahCUBDY79sWROivBJ3A9v79Kt0O18i3JSIyQNP4AL
	 tK6kIpbRnpVtepFEh+cK1xEGUEAK3Wix/qc4sHOQJAB3o1xHPWJZzMkm+2+p9704QW
	 nJzJjpiRvVsu39HO1yIgnHGwPriRFAfvToc/VG9MbypyiTd5Ho4MkeqGPLXaGDs3mo
	 v6IfCTF7XbzAyfXjlZH/+wimyy+T7z/V8SvjLOp5x5j8zKYDytzOYJ6zrF8ZIuJQMM
	 4r6/1BzSUiqm0hVZFCrqSdzEmLFNWIslasOBO7VeYQ+XAO5+cA7HSHHzxwlBxr6GX1
	 BSOWrJQd+4gIA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d30639709so48740866b.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:34:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHp3a54jSnM3vFdpbq58+XRKeNONHFhH/k0TbJ0UipAsxFKOk/epwX/295IV/GtvTnfNOVnbPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uLeVRjZBxy39VmT8yjFP0LFgtN1fYhjZyuBLgYgpcCq9E/AzH
	6dq8UxW89dy/qJCv1X0Nn//38CeCNk/LwrkzYKehK1/HwWo5dihX6YXHjluDcJfjkIRPaPt4O1m
	/LLAlpsrw8AiALhuf6Mgi/YwcOpJD7EQ=
X-Received: by 2002:a17:907:8691:b0:c40:4965:72bd with SMTP id
 a640c23a62f3a-c509640bfcbmr53255166b.19.1794522848652; Thu, 12 Nov 2026
 14:34:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112183607.1660070-1-icb@fastmail.org>
In-Reply-To: <20261112183607.1660070-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Nov 2026 07:33:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_BhzKwYCy6GDJt0UzWQe9yraU=txbNpMo6knCMnMdB=w@mail.gmail.com>
X-Gm-Features: AclHuK81xXH_-OPmQs1rrhBNOCj9FNwZiuS9DtIXUEAS2tO0Y36wabUvT3pnOSE
Message-ID: <CAKYAXd_BhzKwYCy6GDJt0UzWQe9yraU=txbNpMo6knCMnMdB=w@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: ignore the allocation size create context on a
 read-only share
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:36=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> On a read-only share, ksmbd refuses writes over SMB, even from a user
> whose account could write the files in the underlying filesystem. Such
> a user can still open an existing file for write on the share, but the
> WRITE requests that follow are refused.
>
> If the open carries an SMB2_CREATE_ALLOCATION_SIZE create context,
> smb2_open() still calls vfs_fallocate() on the file, and the filesystem
> allows it because of the user's write permission. The user can thereby
> reserve any amount of disk space through the read-only share, up to
> filling the filesystem. The file's size and data do not change.
>
> Ignore the context on read-only shares. It requests space for a file
> being created or overwritten, and such a share permits neither.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
