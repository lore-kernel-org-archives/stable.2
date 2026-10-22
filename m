Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670634;
	b=1GzpfoKpCwYylZE6dhV3I+GszJJUEWPKJ9rFQ4rqQnlBbpB3TGVthtovZpaWqshkTjO4
	 b02Rf5o1nScHgRgv2P4hQ/8zhqQDNy4AZt8NjjU7agLVB6++9st/9vNob+vPW6Aw1OEpF
	 QiMEjfhAixhgOaz/hEr8soGi+55EV/rOB9gNWLImuIFJGAQ53cT3GUAFbd/lNMB/wrmyG
	 sKEMESkusZRc4bchPRTRcQb/vvTmB6hQ5ARHdA/EqRIZw+J0d6qIcepR4J/xdB1toVZBW
	 FsWy0nSUGqquk8gaqvXZTP8TmhnBg9QrIZpmiOMPinZTaoM41tFw+rW99K04JJJmipw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670634;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HTkYvjH/eg6Y4u8UNH22t61nK2fExsGDmz5qdjJ3SY4=;
	b=vpc75MQdaopqV1aLMynj358gNFoIylQ7J63reRFmcCIag4RCyQIFUzkpb74jHZ+Wg6iL
	 AfoZKV5F4kAkwaFQ8rrK9A0GLYA4TG+WPDj3UBKay0EUSKuY+vwdMIJ7ZsV3k+6fTSeRZ
	 HM8XWDQ/p7bPf6tCtP5zPIxCY3XMz8dj/jHAi0QwTiAVi6aKCdlWDVOraOQEDvhMOWvIi
	 WdhkC5WH+BvHt6aOID5KPgPYWgQ20rYidGQmDGXYH4Hyurlc4xlTzO/ciJzoT07/j257h
	 8v2Md2ENhDFtHC+zFnKoc0ALnCRn9/PTExJySywpW3auX2W4UlUW60pt5bW8UQdBtvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8J42vcZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A2606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8J42vcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB331F000C5
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670633;
	bh=HTkYvjH/eg6Y4u8UNH22t61nK2fExsGDmz5qdjJ3SY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q8J42vcZEBAJR/Aq0EeoG2EzBcVELQPZ7r3T8wR6ksyYIANb27Xv4Ui/hv7NkkNFX
	 H88mChGuPo9j/83nNYqWzSIikZz2rEmXTLFKL/6B8z4jJ73br74Fmm67OkeKFPAIs0
	 uKOkvFKg5OAIeuw3y+6SbwH2HnesCc/vOwUEj4q8MRi93qhAXs/qnkwoqV/lcGqlsG
	 YqUDL5U3z1DR2m5ke4HpOhfFiGYzQl4vtFq4hwKAgRHhUHL+Vd3JE1kni78AFtlQVZ
	 HY9mOXNAODQx4qse/31nI2sGSR5KHVr4liV3HfzEa6IrNqUilfT/J3vbcda3sBv2Tx
	 cc9zGObeF6R6w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2889718a12.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:03:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwiv/W0p/3jpaXmDwtrEN1i2Z1xb7kbONOEC5EEa9mErigJCq0UVs9MXmZtkMLOzZDT0For8KI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJc7bDxwJaU3muRXhOnl+sfg1PU9nPq1/V0yfhWyMD3kk/RiFcp
	avUqgKPhDt2pnkxlwTjXRtuhLF98Qp9nAKeAs5+cub0zoUwtJ0RGPtRrQapvyB2S33o/u6p1lTt
	QGmv97QA4NXenjmevtjHmrZTHChbCWIY=
X-Received: by 2002:a17:906:9f86:b0:c41:8e21:4d58 with SMTP id
 a640c23a62f3a-c46791020fcmr489905166b.5.1792670632514; Thu, 22 Oct 2026
 05:03:52 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022041216.8988-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20261022041216.8988-1-cenzhang@linux.microsoft.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Oct 2026 21:03:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-L4r5UrN=KLFt-KKyhu0YRVBvng_SVd1EayKyJOwn6NA@mail.gmail.com>
X-Gm-Features: AclHuK-Ppyr0JUuKDRqFVubdAOIszbgUxUTitaBxk1NgW5OZRcRX_CpjZZgiKZg
Message-ID: <CAKYAXd-L4r5UrN=KLFt-KKyhu0YRVBvng_SVd1EayKyJOwn6NA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix parent dentry lifetime in directory enumeration
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Steve French <stfrench@microsoft.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 1:12=E2=80=AFPM Cen Zhang (Microsoft)
<cenzhang@linux.microsoft.com> wrote:
>
> ksmbd_populate_dot_dotdot_entries() builds the ".." entry from
> the open directory's d_parent and passes that pointer to
> ksmbd_vfs_fill_dentry_attrs() without taking a reference. That pointer
> is only valid while the directory stays under this parent. If a
> concurrent rename moves the directory elsewhere, the old parent loses
> its last reference; a following rmdir then turns it into a negative
> dentry with d_inode cleared, and after the RCU grace period the dentry
> itself is freed. The worker still holds the raw pointer and
> dereferences d_inode through vfs_getattr() and vfs_getxattr().
>
> A remote SMB client, authenticated or guest, triggers this by listing
> a directory while that directory is moved under a new parent and the
> old parent is deleted. It can be done by the client itself with write
> access or by other concurrent writers, triggering null-ptr-deref and
> slab-use-after-free on a KASAN build.
>
>   KASAN: null-ptr-deref in range
>       [0x0000000000000000-0x0000000000000007]
>   Workqueue: ksmbd-io handle_ksmbd_work
>   RIP: 0010:xattr_permission+0x9d/0x160
>   Call Trace:
>    vfs_getxattr+0x9c/0x1b0
>    ksmbd_vfs_getxattr+0x82/0x100
>    ksmbd_vfs_get_dos_attrib_xattr+0x7f/0x130
>    ksmbd_vfs_fill_dentry_attrs+0x435/0x650
>    ksmbd_populate_dot_dotdot_entries+0x25e/0x630
>    smb2_query_dir+0xcf9/0x1a20
>    handle_ksmbd_work+0x5f1/0x1c80
>    process_one_work+0x90b/0x19d0
>
> Fix by using the dentry reference counting APIs: take the parent with
> dget_parent(), take a matching dget() on ".", and dput() the dentry
> once ksmbd_vfs_fill_dentry_attrs() has returned or the pattern does
> not match.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Cc: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Applied it to #ksmbd-for-next.
Thanks!
