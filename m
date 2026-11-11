Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387016;
	b=qmG4k8ZfSixg36diKcvDJ0foNOUSpL346VaAAER6WNqMcERugo45vsU/1hz19OsG2oO7
	 DkQ5S1Yxd2shTTHIRLYUY6vpDdvcyvcmRJTRKvJPuxGFlWynSfYaKMoTCaZHyC39gY1NS
	 ii8X4LwJIPHFtvcpMz8FPYrGXyzBdwY6i9JBudA1zYt8O6MBt8hNFsySHBpNB30YfafUk
	 7AwfIbEV9Poe/d630jCfd2VHZKWcbI/6bNAlgQJAAFY284OPq/IIoHDiKvs7kPsFUKEP6
	 e7DuQy7HQpTfwBprn4xE7kfU4eiN8i+8GKkmPUw7PZXd0QxQdioo3pq8HBKC/i9Bkuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387016;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dyi44XrPNZ+h4KSieqNDltLyYDUp+MK/l2iG04ch2ZY=;
	b=3QbZ8ZrVVmu+z59ZIwWGd5t8f8g5NdHVItg1jqK8PsZ+g79rSZSHoW4DgS/1PYIC+jIZ
	 Dh4z5/AYdzM2Xu2vluW8M1sBmPqL5kYQn+pUziWZBpFRt5taICRmGmKyZi6xIUr0cHVWK
	 tVhUK5NkjbEA8jCtCtpeey76NUA44qSPXGg5kq+VtwUA+IVBUtBzlgTgfAaJ8R1vvjcNa
	 i2nTi8EDKEgvncK7h9zx1CfOjwelB5xcq1C2KlAzCtJeHJmWZWzYTNKoM2gN2Gf8M78Sz
	 FIZSc1cQGTo0wJfNQKDvTGMoN0jpe2KMxTCly68e3faMfQaeUnUA46rW+eOC7C2sQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36B606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD36B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e5d51c96ddac11f19a56ed5b684f684d-20261111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:70de7592-74cc-407f-a7ce-20aa329763cf,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:1a2a5734b3bf66cc1711c3c22ae16d56,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:11|94|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e5d51c96ddac11f19a56ed5b684f684d-20261111
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1586439326; Wed, 11 Nov 2026 16:50:08 +0800
Message-ID: <656d0e00-01a6-4e90-a924-4ad2329c3d74@kylinos.cn>
Date: Wed, 11 Nov 2026 16:50:05 +0800
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
Subject: Re: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device
 removal
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-2-mszeredi@redhat.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <20261105150943.86650-2-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 05/11/2026 23:09, Miklos Szeredi wrote:
> The virtio_fs object is refcounted via its kobject, so a mount can keep it
> alive well beyond the lifetime of the virtio device binding.  The tag
> string, however, was allocated with devm_kmalloc() and is therefore freed
> by devres_release_all() as soon as the device is unbound, i.e. right after
> virtio_fs_remove() returns (see device_unbind_cleanup() in
> drivers/base/dd.c).
> 
> virtio_fs_get_tree() looks up the instance, takes a kobject reference and
> then drops virtio_fs_mutex before doing the sleepable part of the mount
> (allocations, fuse_conn_init(), sget_fc()).  A concurrent device removal
> can complete in that window:
> 
>   CPU 0 (mount)                         CPU 1 (remove)
>   -------------                         --------------
>   virtio_fs_get_tree()
>     virtio_fs_find_instance()
>     // reference taken, mutex dropped
>                                         virtio_fs_remove()
>                                           list_del_init(&fs->list);
>                                         // driver core unbinds device
>                                         // devres frees fs->tag
>   virtio_fs_fill_super()
>     mutex_lock(&virtio_fs_mutex);
>     if (list_empty(&fs->list))
>             pr_info(... fs->tag);   <-- use-after-free
> 
> The virtio_fs object itself is still valid here, only its tag has been
> freed behind its back.
> 
> Fix the lifetime mismatch at the source: allocate the tag with kmalloc()
> and free it from virtio_fs_ktype_release(), so that it lives exactly as
> long as the object embedding it.  All probe error paths already drop the
> final kobject reference, so they are covered.  Merely dropping the tag
> from the error message would paper over this instance while leaving a
> devres pointer embedded in an object that routinely outlives its device.
> 
> The other readers of fs->tag are unaffected: tag_show() is fenced off by
> the kobject_del() in virtio_fs_remove(), the automatic KOBJ_REMOVE uevent
> is emitted from __kobject_del() while the device is still bound, and both
> virtio_fs_add_instance() and virtio_fs_find_instance() only walk instances
> still on virtio_fs_instances.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: <stable@vger.kernel.org>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-0328b3a1-043b-468e-8425-6a613d91b5ef
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index ba8d79c4bcac..ef58bedc3941 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> ...
> -/* Read filesystem name from virtio config into fs->tag (must kfree()). */
> +/*
> + * Read filesystem name from virtio config into fs->tag.  Freed by
> + * virtio_fs_ktype_release() so that it stays valid for as long as the
> + * virtio_fs object itself, which may outlive the virtio device.
> + */
>  static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
>  {
>  	char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
> @@ -505,7 +510,7 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
>  		end = &tag_buf[sizeof(tag_buf)];
>  
>  	len = end - tag_buf;
> -	fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
> +	fs->tag = kmalloc(len + 1, GFP_KERNEL);

The fix for the UAF issue regarding fs->tag looks good to me.

However, while looking at this, I happened to notice another similar potential issue: when the DAX mode 
is enabled for file read/write, the DAX window is mapped via devm_memremap_pages and unmapped when the device 
is unbound. Although as far as I know, the corresponding QEMU changes for DAX mode don't seem to have landed 
in QEMU upstream, fs->window_kaddr and other established page table mappings still point to this memory region.
Perhaps we should also look into cleaning them up?

Reviewed-by: Li Wang <liwang@kylinos.cn>

