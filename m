Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465930;
	b=ZF9O0rBg+Gwx+9jQxNNH7vLLE9esh/XOPgH0nu5lqWgrujECeAIuw3pJ1c5mntABn8uA
	 ftW2AiAMnrbljxhwDvtD+qiaG6XVGXTNS8v2znmUXD074AelJN0rITqVftOsOsN505kae
	 v5Dhdpk2E3JKBLOc34V1+yBlDRdznD3hzdqKOfpqlRaIyWhF+hqi8KNcICxSYtpihCUgX
	 T0WIO8MwU4FF1UxKPn2cWRMC04tEkHq26ioC3Yfuy/d0+Is+yR2ujAEbE+v3p++mtTFzL
	 8NmumazTD/VY1RBTec8irMl7gi8KTMRFsKdu25aixK7HtrJNERtdu+usIyZtdxqeZvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465930;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9rH+QHGG1hI3dNzLf5B98rCFYXMdN76eY5FQVLDUIlw=;
	b=v7mivpJWiLmgPiDs+tRoYbL4/ULq26GxA+Ten5wv0rZVsDUnnVkRvEbyp16SYpmXNVni
	 6Phg4CgzDoja2dKXUYjkN3KS8dKouHlAyFlDjeag5yndkvsfU0qrAckuhO3TLbGzT7B9M
	 aie/+U3Q3Z0OUU9u7xYpafczmoKKDI7IcKtZ/kCv/quq083mEmcgq6pxxuC8mxWcM6avk
	 Qj5DLY4HHUEy+Kl9Hk2xZlCteMIzvuK74bOgv6AHa/0kGgw4y9tHaX+DHaGzQu44DCYhc
	 PRqTWQoMYco2lkYn3yoRyplyZGAV2aMjjcIVYquSEFv5eD28LW5dQgBlnNO6hohEMGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7F606A888;
	Thu, 12 Nov 2026 06:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A7F606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a09ee23ede6411f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3e25d55a-35bc-44a9-a24c-fb5988da5f1e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ef66694e734ea29c88e66421930224fb,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a09ee23ede6411f19a56ed5b684f684d-20261112
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1954828798; Thu, 12 Nov 2026 14:45:19 +0800
Message-ID: <ce113884-82ae-4f3d-8f0e-c4499b8f1dfd@kylinos.cn>
Date: Thu, 12 Nov 2026 14:45:17 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: Don't use request timeouts on virtiofs
To: Yuho Choi <oss.patchbox@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, fuse-devel@lists.linux.dev,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261112052208.1248312-2-oss.patchbox@gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261112052208.1248312-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yuho,

On 12/11/2026 13:21, Yuho Choi wrote:
> virtiofs cannot abort a request once it has been added to a virtqueue,
> because the device owns its buffers until it returns them on the used
> ring. This is why virtiofs sets no_control and no_force_umount; see
> commit 15c8e72e88e0 ("fuse: allow skipping control interface and
> forced unmount"), which says that "virtio-fs does not support aborting
> requests which are being processed".
> 
> The request timeout added by commit 0f6439f61a6e ("fuse: add
> kernel-enforced timeout option for requests") aborts them anyway. When
> a request takes longer than the timeout, fuse_check_timeout() calls
> fuse_chan_abort(), which moves the requests on each virtqueue's
> fpq->processing list to its end list and ends them, so they are freed.
> The device can then still write the reply into the freed request and
> its pages, and virtio_fs_requests_done_work() later gets the freed
> request back from virtqueue_get_buf().
> 
> The timeout is armed when the server sets FUSE_REQUEST_TIMEOUT in its
> INIT reply, or when the fs.fuse.default_request_timeout or
> fs.fuse.max_request_timeout sysctl is set, for example for other FUSE
> mounts on the same system. A slow host is then enough to hit it.
> 
> Don't arm the request timeout, and don't offer FUSE_REQUEST_TIMEOUT, on
> connections that set no_force_umount.
> 
> Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ...
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1341b681d0ed..f1aae9b5475c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1451,7 +1451,14 @@ static void process_init_reply(struct fuse_args *args, int error)
>  			fc->no_flock = 1;
>  		}
>  
> -		fuse_init_server_timeout(fc->chan, timeout);
> +		/*
> +		 * A request timeout aborts the connection, which ends the
> +		 * requests that are still in flight. A transport that cannot
> +		 * take back requests it has handed to the device, such as
> +		 * virtiofs, sets no_force_umount for the same reason.
> +		 */
> +		if (!fc->no_force_umount)
> +			fuse_init_server_timeout(fc->chan, timeout);
>  
>  		fm->sb->s_bdi->ra_pages =
>  				min(fm->sb->s_bdi->ra_pages, ra_pages);
> @@ -1502,8 +1509,10 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
>  		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
>  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> -		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
> -		FUSE_REQUEST_TIMEOUT;
> +		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
> +	/* See process_init_reply() */
> +	if (!fm->fc->no_force_umount)
> +		flags |= FUSE_REQUEST_TIMEOUT;
>  #ifdef CONFIG_FUSE_VDAX
>  	if (fm->fc->vdax)
>  		flags |= FUSE_MAP_ALIGNMENT;

Miklos has already posted a patch addressing the same issue [1]. Personally, 
I feel it would be better to introduce a separate parameter to avoid semantic 
confusion with whether forced unmount is allowed.

[1] https://lore.kernel.org/fuse-devel/16a0bf8f-8c30-415e-a35e-9551c78b8dcc@
    kylinos.cn/T/#m34d62acd7887a86ec32e9091145e4b19fdbb3fc3

Thanks,
Li Wang

