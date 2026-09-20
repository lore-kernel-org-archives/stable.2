Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E66443C27;
	Sun, 20 Sep 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928469; cv=pass; b=m+ec+46aFlhMlovDAs8mu08yO+Cy1mLuVpf3jQ3l14gYl2aZvHbuPD/+S36uSxgFU4JrhgJgWgXKh2izmPY1CEI5Kydiehkzty6wL+GLSHguOG0BQ/TAsKmLuBWmibR1hmy6d6H5EaipL9w9EUFlUEtPgAyOqgqjJ2KY662rPo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928469; c=relaxed/simple;
	bh=JKk9nH0AZSCoNsSgcwKVlqeiDd7CGrOESdmwFRboQoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc6QoraWKl5fpnCdq6lBd8Z0Ll5hKPFAdB5IezD2v6WyeVsTUJvH6ZjIJg7qMTq4SJ3eycZTc49bMibTcDZan3bRrpqyn/KyjTmLkhxfjbhhCXlE9G2Wq9neoGm/y4zsS2IlinjWobXlcQ2jsxf8WDnq36hVUHSJWEAcOybT0go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=hG2y/l2g; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="hG2y/l2g"
ARC-Seal: i=1; a=rsa-sha256; t=1789928445; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HtnRs1y3PVC3nJ/S7EkfV3+bm6BSytV4ghO3Kpvhpi2FRK2x0qE4aMaKtAIsEk+NFQghnIYY2fRbqIqKi8P8UaLhd0yLjyl8fYwwY3WCOiTgcQbGHY7QlwphOym1KC3QyTABLWZ6OuZtCP+E+ygdMNIhsWKWJrQrTTM2OV163C8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789928445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9X5uA/lhuubN5xoKegOzpl+E+IObiUHG4eckQZgitoo=; 
	b=GiqB12mraYdY0y1DCky6RnIG0Z8wac4ZZhCnSIdn+abha8XzYVLj9TFi0jvbEEo6tnoW28S4ewEtWd4DqUPvK/ZOzMg5vet8oIxTHLV0rujy0msmbEjrp5gTV3PCTlC3EjE4pErXNUwKOozjo7WHYU5gTEjCIrMfw2yl4bdsUUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789928445;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9X5uA/lhuubN5xoKegOzpl+E+IObiUHG4eckQZgitoo=;
	b=hG2y/l2gzpznDt6WdvYiuTlMQrMMohSZdxJkzLwEMzdFeK533/EY4GmseN+s5Jk4
	skzFGUBT/S7IAi/52eEklKdM3yTy43rj6zN68UAh1nUfPQqRryvl5wFKDM1dik0fWE8
	2t6E2wH1p10iHrRNyhKRuxmqpxNryi+/ePln8kyU=
Received: by smtp.zohomail.com with SMTPS id 1789928444328269.1472253389609;
	Sun, 20 Sep 2026 11:20:44 -0700 (PDT)
Message-ID: <1454c304-7a12-48ce-a662-b1c7d2b76356@collabora.com>
Date: Sun, 20 Sep 2026 21:20:39 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fix NULL pointer dereference on fence
 allocation failure
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, airlied@redhat.com,
 kraxel@redhat.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux.dev, gurchetansingh@chromium.org,
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de
References: <00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/9/26 12:11, Peiyang He wrote:
> virtio_gpu_fence_alloc() can fail due to memory pressure and return NULL,
> but its caller like virtio_gpu_init_submit() never checks it. Later,
> virtio_gpu_init_submit() passes the NULL fence to
> virtio_gpu_fence_event_create(), which unconditionally dereferences it.
> 
> Found when fuzzing the virtio driver with Syzkaller:
> 
> 	Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN NOPTI
> 	KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> 	CPU: 1 UID: 0 PID: 9991 Comm: syz.0.121 Not tainted 7.2.0 #4 PREEMPT(full) 
> 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> 	RIP: 0010:virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:295 [inline]
> 	RIP: 0010:virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
> 	RIP: 0010:virtio_gpu_execbuffer_ioctl+0xc78/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
> 	Code: 85 ed 0f 85 21 09 00 00 e8 05 5a c9 fb 48 8b 44 24 10 48 8d b8 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9a 0d 00 00 48 8b 44 24 10 4c 89 b0 90 00 00 00
> 	RSP: 0018:ffffc900039dfad0 EFLAGS: 00010216
> 	RAX: dffffc0000000000 RBX: ffffc900039dfdd8 RCX: ffffffff85f6fd3d
> 	RDX: 0000000000000012 RSI: ffffffff85f6fd4b RDI: 0000000000000090
> 	RBP: 0000000000000000 R0virtio_gpu_virgl_process_cmd: ctrl 0x102, error 0x1203
> 	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880132c4000
> 	R13: 0000000000000000 R14: ffff888073b6c700 R15: 000000000000003b
> 	FS:  00007fab480b96c0(0000) GS:ffff8880eb6e9000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: 00007effbf5e55a8 CR3: 0000000048d19000 CR4: 0000000000350ef0
> 	Call Trace:
> 	<TASK>
> 	drm_ioctl_kernel+0x1f4/0x3e0 drivers/gpu/drm/drm_ioctl.c:817
> 	drm_ioctl+0x5f4/0xc70 drivers/gpu/drm/drm_ioctl.c:914
> 	vfs_ioctl fs/ioctl.c:51 [inline]
> 	__do_sys_ioctl fs/ioctl.c:597 [inline]
> 	__se_sys_ioctl fs/ioctl.c:583 [inline]
> 	__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> 	do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> 	do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
> 	entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 	RIP: 0033:0x7fab471a82bd
> 	Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> 	RSP: 002b:00007fab480b9018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	RAX: ffffffffffffffda RBX: 00007fab47435fa0 RCX: 00007fab471a82bd
> 	RDX: 00002000000000c0 RSI: 00000000c0406442 RDI: 0000000000000003
> 	RBP: 00007fab480b9080 R08: 0000000000000000 R09: 0000000000000000
> 	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> 	R13: 00007fab47436038 R14: 00007fab47435fa0 R15: 00007ffe85ab0740
> 	</TASK>
> 	Modules linked in:
> 	---[ end trace 0000000000000000 ]---
> 	RIP: 0010:virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:295 [inline]
> 	RIP: 0010:virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
> 	RIP: 0010:virtio_gpu_execbuffer_ioctl+0xc78/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
> 	Code: 85 ed 0f 85 21 09 00 00 e8 05 5a c9 fb 48 8b 44 24 10 48 8d b8 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9a 0d 00 00 48 8b 44 24 10 4c 89 b0 90 00 00 00
> 	RSP: 0018:ffffc900039dfad0 EFLAGS: 00010216
> 	RAX: dffffc0000000000 RBX: ffffc900039dfdd8 RCX: ffffffff85f6fd3d
> 	RDX: 0000000000000012 RSI: ffffffff85f6fd4b RDI: 0000000000000090
> 	RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> 	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880132c4000
> 	R13: 0000000000000000 R14: ffff888073b6c700 R15: 000000000000003b
> 	FS:  00007fab480b96c0(0000) GS:ffff888098ae9000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: 00007f24c3759000 CR3: 0000000048d19000 CR4: 0000000000350ef0
> 	----------------
> 	Code disassembly (best guess):
> 	0:	85 ed                	test   %ebp,%ebp
> 	2:	0f 85 21 09 00 00    	jne    0x929
> 	8:	e8 05 5a c9 fb       	call   0xfbc95a12
> 	d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
> 	12:	48 8d b8 90 00 00 00 	lea    0x90(%rax),%rdi
> 	19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
> 	20:	fc ff df
> 	23:	48 89 fa             	mov    %rdi,%rdx
> 	26:	48 c1 ea 03          	shr    $0x3,%rdx
> 	* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
> 	2e:	0f 85 9a 0d 00 00    	jne    0xdce
> 	34:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
> 	39:	4c 89 b0 90 00 00 00 	mov    %r14,0x90(%rax)
> 
> Fix by checking virtio_gpu_fence_alloc() in virtio_gpu_init_submit() and
> returning -ENOMEM before any later code can dereference the NULL fence.
> 
> Fixes: 70d1ace56db6 ("drm/virtio: Conditionally allocate virtio_gpu_fence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.5
> ---
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
> index 32cb1e4aa425..857ed5c5f2a8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -389,10 +389,13 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
>  	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
>  	    exbuf->num_out_syncobjs ||
>  	    exbuf->num_bo_handles ||
> -	    drm_fence_event)
> +	    drm_fence_event) {
>  		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
> -	else
> +		if (!out_fence)
> +			return -ENOMEM;
> +	} else {
>  		out_fence = NULL;
> +	}
>  
>  	if (drm_fence_event) {
>  		err = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
