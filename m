Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6953BFE59;
	Thu, 23 Jul 2026 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833065; cv=pass; b=uSRHmaaGelCcpKRZsnFkdsbAOUSyxm0/t8mYPXdbbdjtRz2d4pPAMX06ya+u6M8teJOcvwgc3bxzltFtdDn7RmxAveqHVP7X+ORdxZ+lm1V0P+GZ6cDeI3btkBZVx8aJuWeDIZLzRFuM5jnWZJatN1LiNlKCfmdTw/eEY5hDKV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833065; c=relaxed/simple;
	bh=o/TIRscDRaEiq+bOuIRUS6DVeAf9lC+wxgeWY1wsJUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0TWfzzdxWhO+w8a0TFgp0xsZq8hgIiaGWzaBcNqAgKvM11ow2kwKLCiCslgs2TZv7AubVTIDz+jHJPOWGJAS/oVt3Wo4KrpAX7/hu4MHlPCcuolpgSRYhmj+Q84SQEw20kzkEzcwVyz623UA8EGWjA+81QUAQLZ9zPqV4+sIzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=YamoZPMd; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="YamoZPMd"
ARC-Seal: i=1; a=rsa-sha256; t=1784833018; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CJIbD8yOleAUy9bEhZcO/zZqgSaP61T7VfkuW6rIX0kUCfWqAwzWRaEnqd499o8QExH1n9C+OLF/ZXHQBCg/GsLhjatkcIkkpKOj9llQiOjk2jrHEqGyBcDAVC4SU+p69oYhc32E2hdJvlgQumxbnDtwKCEruTNKK6tp6Klk+dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784833018; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3iaYVEsIVCyK0ND5jM1y+PZ+xDP3CS2E9BUMZ4Up2Oo=; 
	b=HXviSh6rM0PX/IgdSe7SqmrRqy2MY/G1i8UoHtCvRBAg1oeltqGu6XDIYB3l0a86tMwgCbV6zNMzT9nAmCdj8JjGt1QEbvYg8E0zYl1VF5Ts6DIzMYSiyHqHABOwy0XIGCtRQJ6Sk8ijF0DCdSW/l4jGnvSephUoZLiWYU+2OfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784833018;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3iaYVEsIVCyK0ND5jM1y+PZ+xDP3CS2E9BUMZ4Up2Oo=;
	b=YamoZPMdaXhYXYKEpapZW9MZ51OlN7/5lzOhIWIGJ8h5vL8d8itbArwecTr5VIOf
	2at1Mifxi1JOv0cws94u7QMcQTrKrfX4zh3Z/11cKr+fxjNboP3RBcaPj3JcM+K5pRA
	4n0YBtmne91ZEZqpULB/77poNQuzEgNQFD9GZYWg=
Received: by mx.zohomail.com with SMTPS id 1784833016441800.3413712097565;
	Thu, 23 Jul 2026 11:56:56 -0700 (PDT)
Message-ID: <d425f956-ab89-4381-a655-176bd6d7e8da@collabora.com>
Date: Thu, 23 Jul 2026 21:56:50 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by
 removing hotplug from dequeue worker
To: Mikko Rapeli <mikko.rapeli@linaro.org>, stable@vger.kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
 <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>
 <amG_T7Kb7DW3VTxm@nuoska>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <amG_T7Kb7DW3VTxm@nuoska>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/23/26 10:14, Mikko Rapeli wrote:
> Hi, adding stable@vger.kernel.org
> 
> In Yocto distro, this change released in v7.2-rc4 seems to fix quite severe qemu
> boot hangs seen with 6.18 stable kernels. Details in
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=16217
> 
> Please apply this to to 6.18 and other stable trees.

The patch will be auto-applied to all stable kernel versions covered by
the `fixes` tag in the commit message, including 6.18. Thanks for
letting know that it fixes a practical problem.

-- 
Best regards,
Dmitry
