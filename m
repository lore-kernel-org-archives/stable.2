Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1E3783DE;
	Thu,  9 Jul 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614242; cv=pass; b=i7NIw8g7KxNvXxT3+N+yu6R3KWWkAEBvXQPtdyxy0YW8KgOCGdn43CApbdLo10YHElYX6q+z0l6lk93saHA9h14WhDdY9blQtBmFVxE+IEl/uf+NVrGfjJhHs3Zvt5exzViWI8A2+IWTzM0IQkosdCZPn0wUIbN0du5yvWDk82U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614242; c=relaxed/simple;
	bh=BBApX0PqsAOuNnIS3W4g8ASQYn99wRqfx5cOW2l60EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUZcfNn8koJPaQWXvIw0uzfKDnpnYwR7F3sDvitPamcEVVljHwLY6VjVCt3R3wuTu5GBFuUB8QvBaeCUqJX8qUq7TF2F4lkQ/XhuMxtIIBK6T9Xagqsm+hdXibUvBZEo0thq6BQd33qQnYInSkSdLtkT6NeIiuGxnAULqvW3VFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=h+la/lxc; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="h+la/lxc"
ARC-Seal: i=1; a=rsa-sha256; t=1783614229; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=niRRZPQrz7T9Zk4CpSbMjy+G5SmXE5ukVbQBZlG3yh0LAInb4W6FvVV42AP0kic6et8FZXRpxFsVRWv8uszXkotC9VwF4Uwvo+G+wuXw1iBou49xRF82hIx6RPxtfZUnH4QkBR2qiX6UNUveDb1SY8TngvyUcazqs/uPWovAwJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783614229; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=epF0rxB7lKg2IRD6abbcyUE44UYIuJo/f9yIkc845WQ=; 
	b=bbSCRqrpBlFFMjDXzJ8WiCam4UjId+wp6Ynyl1nQa5/6f2QCzXbvEyA/ecwKPbpzFu9C9iXR07XVkGU6yjPer7s+fTJe4u+LyFynh+iARgjFi9QHLJib+uPypXvEtlPBd32KWAxoYbcJX8VSVpH8Je7RAKKkYAvgX/uwOuphRr8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783614229;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=epF0rxB7lKg2IRD6abbcyUE44UYIuJo/f9yIkc845WQ=;
	b=h+la/lxcm6pcWpmugBmcJ7E9CK/fnTfWZKbbKZqHNRAfjau2jof0kwhT5lwbd+YZ
	v3n4GiIXt/y5atyn/5ZGDSfO8DaJCoaajTc8qqNnJ/1AXOKYBZltWOu5ehS2FHKwZqD
	n7c7djpnQqpcP1GivxvtIchSyLO1/GT7/IMD3uJQ=
Received: by mx.zohomail.com with SMTPS id 1783614227917726.9600571528584;
	Thu, 9 Jul 2026 09:23:47 -0700 (PDT)
Message-ID: <e9d5c9ee-88b1-4e9c-9999-74edbb2c59f3@collabora.com>
Date: Thu, 9 Jul 2026 19:23:43 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Yiwei Zhang <zzyiwei@google.com>
Cc: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625170828.3335431-1-natsu@google.com>
 <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
 <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/7/26 22:01, Yiwei Zhang wrote:
> On Mon, Jun 29, 2026 at 2:39 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Hi,
>>
>> On 6/25/26 20:08, Jason Macnak wrote:
>>> Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
>>> Don't attach GEM to a non-created context in gem_object_open()")
>>> to virtio_gpu_gem_object_close() to avoid trying to detach
>>> a resource that was never attached due to a context
>>> never being created when context_init is supported.
>>>
>>> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
>>> Cc: <stable@vger.kernel.org> # v6.14+
>>> Signed-off-by: Jason Macnak <natsu@google.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
>>> index 435d37d36034..66c3f6f74e9c 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
>>> @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>>>       if (!vgdev->has_virgl_3d)
>>>               return;
>>>
>>> -     objs = virtio_gpu_array_alloc(1);
>>> -     if (!objs)
>>> -             return;
>>> -     virtio_gpu_array_add_obj(objs, obj);
>>> +     if (vfpriv->context_created) {
>>> +             objs = virtio_gpu_array_alloc(1);
>>> +             if (!objs)
>>> +                     return;
>>> +             virtio_gpu_array_add_obj(objs, obj);
>>>
>>> -     virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
>>> -                                            objs);
>>> +             virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
>>> +                                                    objs);
>>> +     }
>>>       virtio_gpu_notify(vgdev);
>>>  }
>>
>> The following scenario still will be troubling:
>>
>> 1. vgdev->has_context_init = true
>> 2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to ctx
>> 3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
>> = true
>> 4. virtio_gpu_gem_object_close() will detach resource that wasn't attached
>>
>> Add obj->ctx_attached member to struct virtio_gpu_object. See
>> virtio_gpu_object_attach() that uses obj->attached, do the same for
>> virtio_gpu_cmd_context_attach_resource().
>>
>> --
>> Best regards,
>> Dmitry
> 
> Hi Dmitry,
> 
> WIth context_init, resource attach/detach is per-context based. So a
> simple obj->ctx_attached won't work. One would have to track in the
> guest context_init ctx for whether a bo has been attached or not.
> 
> Another option is to accept this patch and live with the case you
> mentioned. We can consider that "invalid" user behavior.

Indeed, obj->ctx_attached shouldn't work for a shared/exported BO. Will
think on it for a couple days more and then merge this version if no
better ideas will appear.

-- 
Best regards,
Dmitry
