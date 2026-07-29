Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA714756AC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325002; cv=none; b=Nbvll38qjOzRTQf/Yd9he/KTXKlOwFn841849+VvGC4Wd2ZGGNUoov1OnoV4bj4k0162bUeChW4H2DeNyCkiFy99QYqSrZ9Md8PLhaUPM2+Uo58Ilwxvqp3BZrwaegf8NOEVmhlyyMRTpVLEciW5+QJXUqXE0TCeXO9jk5h48fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325002; c=relaxed/simple;
	bh=InUBNHjljyH7Tko5OtxPDNqGu1LbSNpa1PX7KKmaaNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7xejue3+llFanneVa3RBO1Rp96WzKIW+BL+K8qY6TyPaagN+iu97z3gHqnNcROY3rMCKaXYwAx898fp5pSZiPMTVoAWlm1RvHZfHKGlgE2vb6Oo47uIJhIvnn9ISqjQwyX8xjNuvDB5515h2z8Akdjq410HejBbiAWIvbcQuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs7QNbxY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs7QNbxY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f71156e1aso472993f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785324999; x=1785929799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3HHsEhTl+dXCrOvrCFYw7cTGZo+aEqQqlvgUlbn4X4=;
        b=fs7QNbxYnqo+ScWQ193Q47pu0btoOb6EZ/TNcUnCsxIhMab+Ja8c5hvras8/tN6wnY
         TEXhXlft8IJLM5mRXXxc92+cCZnz8HPI5tl83lud0b48mkCk5r1c/TwEsWAuX5h3fdrJ
         W5Y73DRBVcSw7hHNjJ+MgdD8I0sQCWPcgn7PgrA5SW+CRHFsLO2B2MRcOyU25px8q5U+
         4afBwQast7r3kUpHUIXMBC9VHBzYAkedZLikG2Kf2skiMRX7WAzgDpjOKHwmcW3Piujq
         yQ8oDQXS+RWIIWGIhhsrTMDvAs7ScfDtF1SxGw9gRbIP0hz7LqHg+g9l08WkV+lbrLMR
         oorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324999; x=1785929799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A3HHsEhTl+dXCrOvrCFYw7cTGZo+aEqQqlvgUlbn4X4=;
        b=P7ausNNl4spNDXc491kOZma6F9NACmch5rdXTkxM1Nr7vVAI8jyAnIYCOGbEwEvqdF
         CLj2vsZ4xythlqlbgy6wFOSLZsCKogJKKysUCJrPebVbH+VP4RmumRMVs3fUG5SqnbSH
         vRT1zhT6UTxG4Ky9PwalIs8jJIXmKVEquLzStwPar9t/3j0v/Qbti76hdWUI2tkYEOKZ
         GihCNsjkRL0cxhCiKUkmd2HuvsIc6MRNkrWinQ4A7MtbubmJf/2jTwZIyuwYlZsy4qD8
         AjUjAbd9CX+YJdSfoilWhk0UHbNyeehcGWMxhufrFYQFxqz514wBDThDEuj+oaXgvqi/
         4BTw==
X-Forwarded-Encrypted: i=1; AHgh+RqcAFoVPhGxuXEFD5Ken/gtkpj3DG1PbzgtGIFE0wvCYYy0LAEtDFbJM0koVFxHqg8P77HOLAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2FxIOoWgbZD0ef0HHBVJsnZ1YwHpILVC1Dnndyln4HdVtEFJ
	2kHmjtK2186WVgeT6xm/zdvFm4EEsq1JwTYEp19yWkmiyM3WTGiIH/vP
X-Gm-Gg: AR+sD12NZ1hlQ4ZPIH4sROilcwJTPVlkhegTQ86aJJ3OZqQKt2m6bjoNx9WU9bCZ4Jr
	3yK6kOR7ioSItTWYfexIB63vSj1l9rhZH4z0zkcKuVkNQ2ENp5wkrLy64p9awmEFTPCio+PZyoR
	Hk3YrvqVnnl1dUy1FJfO/h6V0Ns/02gVR0BdlOTC8Rwshr7nAgjSvTGGDKN5nO6ul/Wgl/CFox4
	UcndqAVyWvHHeCBeoLhjliPH+JnFBLRNv5nSmzdFdA1w/IiR6aDn9suuCb6JWU0l+1j87BYA4fl
	6Lwu39l1X6jikEMNI+DjiNMFvH2xENOlOHWYDjB/PqP9Ykz5yhhqCRRZDPP9bBAA15cXzDmZEOU
	IPVK+XdRDweJMFa6s8Yw+neOJCzCy37NOV6FR3lv1Bb31eV9p3DePd0X1M2/AW5AlmtkO6rQX/l
	DVqVfRWjbuvmg8WA1MJ9CHVnXOaEH4RL8OaDs40Vkwiu2DoNqbm9hxdKCp3nbhXY+cIzbh77guO
	g56G35NAfWNGv5qw/6Dvyax6CiwVwV42w==
X-Received: by 2002:a05:600c:4e8c:b0:495:4730:15b2 with SMTP id 5b1f17b1804b1-496c6571ea4mr64839705e9.31.1785324998773;
        Wed, 29 Jul 2026 04:36:38 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:2975:f35a:5252:318b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44af19bsm145526535e9.3.2026.07.29.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:36:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:36:35 +0200
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
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
Message-ID: <amnlw_HGWX0YHMWV@osama>
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
 <amjG9WVZrb6v92_h@e142607>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjG9WVZrb6v92_h@e142607>

On Tue, Jul 28, 2026 at 04:12:53PM +0100, Liviu Dudau wrote:
> On Mon, Jul 20, 2026 at 03:44:35PM +0200, Osama Abdelkader wrote:
> > panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
> > control interface offsets with 32-bit arithmetic and the size of the host
> > wrapper structures. The offsets are derived from firmware-provided strides,
> > so the arithmetic can wrap before the bounds check, and the host wrapper
> > size is not the size of the firmware control interface being mapped.
> 
> How can the offsets wrap with the firmware-provided strides? It's not like
> the firmware provides arbitrarily large strides.
>

Thanks for the review. Yes, It's unlikely to happen but good to have,
these patches actually address issues reported by sashiko while reviewing
the first two patches regarding firmware sections with oversized data and
truncated firmware.

> > 
> > Use 64-bit arithmetic for the computed offsets and validate against the
> > actual firmware control interface structure sizes with subtraction-based
> > bounds checks. Also validate that the shared section is large enough for
> > the global control interface before using it.
> > 
> > Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index eee2bc7e8541..e2fcbd639c3c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -897,15 +897,16 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
> >  	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_idx);
> >  	struct panthor_fw_cs_iface *cs_iface = &ptdev->fw->iface.streams[csg_idx][cs_idx];
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> > -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> > -			   (csg_idx * glb_iface->control->group_stride) +
> > +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> > +			   ((u64)csg_idx * glb_iface->control->group_stride) +
> >  			   CSF_STREAM_CONTROL_OFFSET +
> > -			   (cs_idx * csg_iface->control->stream_stride);
> > +			   ((u64)cs_idx * csg_iface->control->stream_stride);
> >  	struct panthor_fw_cs_iface *first_cs_iface =
> >  		panthor_fw_get_cs_iface(ptdev, 0, 0);
> >  
> > -	if (iface_offset + sizeof(*cs_iface) >= shared_section_sz)
> > +	if (iface_offset > shared_section_sz ||
> > +	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
> >  		return -EINVAL;
> >  
> >  	spin_lock_init(&cs_iface->lock);
> >  	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> > @@ -955,11 +956,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
> >  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> >  	struct panthor_fw_csg_iface *csg_iface = &ptdev->fw->iface.groups[csg_idx];
> >  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> > -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET + (csg_idx * glb_iface->control->group_stride);
> > +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> > +			   ((u64)csg_idx * glb_iface->control->group_stride);
> >  	unsigned int i;
> >  
> > -	if (iface_offset + sizeof(*csg_iface) >= shared_section_sz)
> > +	if (iface_offset > shared_section_sz ||
> > +	    sizeof(*csg_iface->control) > shared_section_sz - iface_offset)
> >  		return -EINVAL;
> >  
> >  	spin_lock_init(&csg_iface->lock);
> >  	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> > @@ -1011,12 +1014,16 @@ static u32 panthor_get_instr_features(struct panthor_device *ptdev)
> >  static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
> >  {
> >  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
> > +	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> >  	unsigned int i;
> >  
> >  	if (!ptdev->fw->shared_section->mem->kmap)
> >  		return -EINVAL;
> >  
> > +	if (sizeof(*glb_iface->control) > shared_section_sz)
> > +		return -EINVAL;
> > +
> >  	spin_lock_init(&glb_iface->lock);
> >  	glb_iface->control = ptdev->fw->shared_section->mem->kmap;
> >  
> >  	if (!glb_iface->control->version) {
> > -- 
> > 2.43.0
> > 
> 
> I'm OK with the general content of the patch, so:
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 
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

Thank you.
Best regards,
Osama
