Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE147ACED
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326409; cv=none; b=GOonMcPic+NNKbtoxbwYkoyfbshXdcRJzwhJxDiwUImI6cjL3802bSGHfK19SjY5+EpiYMtxlBaz7EWPh/waq2Tb4XGMoDt92tIo3Y17GNn3OguhT7gIDwMfLC/+y4Bknr3GJyq9YqXTsFNJ/v+l+FE9RcD8usq4+r4+uO/f6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326409; c=relaxed/simple;
	bh=Eq69fdX/8dGGHINc2ZvvHromymtSuqL4urGEZc//r3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUWcNh/vzO9NH+okbZHYoQDKFoIgitmlPVnLWDLtEV7XDebkbhxM+612D70dvYx4OZCRoCy4K7bna8qm8UnUHqC19tMvZoanG2pQHJpaQ7Xnh4BUKn/8bivKDcNqbNiSH81QplNZeZNp8KnhLtm7p7DAS1YVBL84ggiumRAeCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEwrRsTd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEwrRsTd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso7601985e9.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326406; x=1785931206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGpSfzW/n1QG6/cG+kMOZnSU/466r29fscAgjtbrJJw=;
        b=TEwrRsTdXGwPwZssgU811ZF9jlchBzl7j/Fo9k+xvIEly2GqFdojpX5YlMgUzhKsbK
         twHbxmKmeEsVm3vlV9e8mv+6qmAd2l9sQz/Li+2WKOGqda7UAFPxGNUqGOj4DoU84sQh
         qjv+QLeNWBIUxIqc66Un+DEwuThbCU2KbUoUS1Acdjt/ppXI2ouVDAw1BXuXzKhf3hGC
         BCPJXNUevwFgWKUkOzxLlXoZz75qyRzbXCKF5Tk6PO5Otj4fVJ4R2VU9MA51RyCXQz8c
         gK6rI7hRVxwSXdGjNaBpcgdo9oyP9SAYggkCvKgpV+xqCloTWHe0aqUmt6qGwfRecDFB
         yOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326406; x=1785931206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eGpSfzW/n1QG6/cG+kMOZnSU/466r29fscAgjtbrJJw=;
        b=jhp0JQoN8nLX6DmjCcCyDqQba+bx820j8fD4o3vQOAsIjUVKntYYnY63Ekw93lhTyV
         HBb5UxayxkkT8kx+qNMN4r4WprKRNlNbHO3QDI/Gv4plkGETQ7oBOdaRzhySpyeVVmwy
         enE7l8XSFVXCTNbJ3PE1vr2V2nlNWsAsEylKOOpz/NbTYYIEPlV2fECqXXTHo/+guFF/
         TP708C1Jamley7TjNpp7jWRktDyqpocIEpAAm/qUKPX5zMp7xh4EXf+Km7hXY+ycUODx
         g+ovuYRBICYidgv+zxghc+UM6iYHO4SRAhGjThkvcUBsfRhayYkfFfww87MratBN5aMP
         vR7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrlmI0iVAj6ZDF97AtD0d2mBEAdrXX4KuXELe9sitXvzoYNIXyejGo6Za8g9FaesvicTWMnS20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42724lIlPTilrY3gCDxhT5yn7v42bbQhLKvxmqa2YA2l+vtp8
	umGxChCMqrcoXYyBWBr4CIeZlUTZ+7JOEC4bP10AeYYXNtN4KpKqqSBK
X-Gm-Gg: AR+sD13bnJ+sElAmCQY+HHl8LU+T8JQqMu8487ciqZnfcHzsQMklB7GnbxTWDZxrOMp
	VD4UmC3/FD2IZjam2H+B0Y8xB40rwnVHi4n8Q282njDvFuIudWAS8sZ2ZBYdCP49t1b7+khvCfF
	4FD1jQkwnjjdwnOX1+DCm3s6e985wlpvtMBLwyDmlVmX7iu93aq4GvX5ryygQv4fwKwBhgqT92q
	3Q0vltBoM7+ElF7IAr+pyICjld0BXzWYisoWpCMts8cXwvrLk23mpikVIrPOesiqVc1UqyjurrL
	Tu9yYVbaazUdOrqYRNqb+5PWAtMnFWwzGrHWBy7ImhgEEjVPN803gOweD9qkYjfGHPNFPU70KZX
	szNZ/bGrDnZ8jUpJtj5IVBXIYgLqCamzFFQsB5Bop9GnmO0cnfOK8OOTaPUDary/ZzcwayBSBH4
	uH1XR0XofDi8MmAxsfy6fmvsT7Kl2eDO4cdhPU8Yhe84RX43vtVuhk0XE2lDILkN1s3m2v0pSU1
	OmBN6rPTGYJs3hRP1KQsho=
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-496c6590745mr70182755e9.18.1785326405419;
        Wed, 29 Jul 2026 05:00:05 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:2975:f35a:5252:318b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c462512dsm142592625e9.13.2026.07.29.05.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:00:04 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:00:02 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: snapshot firmware interface counts before
 loops
Message-ID: <amnrQq-IJzIB_kgF@osama>
References: <20260720135518.17927-1-osama.abdelkader@gmail.com>
 <amjH-v6-2POzmj1q@e142607>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjH-v6-2POzmj1q@e142607>

On Tue, Jul 28, 2026 at 04:17:14PM +0100, Liviu Dudau wrote:
> On Mon, Jul 20, 2026 at 03:55:18PM +0200, Osama Abdelkader wrote:
> > The firmware exposes the global group count and per-group stream count in
> > the shared control interface. These values are validated before being used
> > as loop bounds, but the memory is shared with the MCU firmware and can be
> > changed after validation.
> 
> Again, you're making statements that need to be proven here. How is MCU
> firmware going to change the content of the memory shared with the driver?
> 

Thanks for the review. yes, this was flagged by Sashiko while reviewing the 
previous patch, but I agree the commit message shouldn't present it as a proven
firmware mutation bug.

The useful part here is just making the validated count the same value used
as the loop bound. since It's an optimisation, should I send v2 without Fixes
and Cc stable tags?

> > 
> > Read each count once with READ_ONCE() and use the validated snapshot as the
> > loop bound. This keeps the loop bounds consistent with the validation and
> > prevents the compiler from reloading a firmware-controlled count during
> > iteration.
> 
> As an optimisation I'm fine with it, so:
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 

Best regards,
Osama
> > 
> > Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index e2fcbd639c3c..6e6da98d795e 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -959,6 +959,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> >  	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> >  			   ((u64)csg_idx * glb_iface->control->group_stride);
> > +	u32 stream_num;
> >  	unsigned int i;
> >  
> >  	if (iface_offset > shared_section_sz ||
> > @@ -972,8 +973,8 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
> >  						 sizeof(*csg_iface->output));
> >  
> > -	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
> > -	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
> > +	stream_num = READ_ONCE(csg_iface->control->stream_num);
> > +	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
> >  		return -EINVAL;
> >  
> >  	if (!csg_iface->input || !csg_iface->output) {
> > @@ -990,7 +991,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  		}
> >  	}
> >  
> > -	for (i = 0; i < csg_iface->control->stream_num; i++) {
> > +	for (i = 0; i < stream_num; i++) {
> >  		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
> >  
> >  		if (ret)
> > @@ -1015,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
> >  {
> >  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> > +	u32 group_num;
> >  	unsigned int i;
> >  
> >  	if (!ptdev->fw->shared_section->mem->kmap)
> > @@ -1034,17 +1036,17 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (glb_iface->control->group_num > MAX_CSGS ||
> > -	    glb_iface->control->group_num < MIN_CSGS) {
> > +	group_num = READ_ONCE(glb_iface->control->group_num);
> > +	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
> >  		drm_err(&ptdev->base, "Invalid number of control groups");
> >  		return -EINVAL;
> >  	}
> >  
> > -	for (i = 0; i < glb_iface->control->group_num; i++) {
> > +	for (i = 0; i < group_num; i++) {
> >  		int ret = panthor_init_csg_iface(ptdev, i);
> >  
> >  		if (ret)
> >  			return ret;
> >  	}
> >  
> >  	drm_info(&ptdev->base, "CSF FW using interface v%d.%d.%d, Features %#x Instrumentation features %#x",
> > -- 
> > 2.43.0
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
