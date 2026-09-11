Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57947253B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129808; cv=none; b=N3vszwr5Nl7l7k+ELcx+ay/GjJI5uWH2yB1hpRzK3EHWOwOfcj0bJA0mgjqFISu2h6Y3V7F6ufvW+mFpJi355Pw4f0anjDAoL64UAv/Fs9+70IhKFEPlMJxXG55tVsyWgdH7YhkN3hvDTwZkWKmrfGzAUSekwAuK149No8G4Jaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129808; c=relaxed/simple;
	bh=4D7Whw1c8RNymLayOeDEJynJlq115YLouoFboh6KcMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrqDYFL15KdHNmrQ6Vczrnfms8Cfu8TIfJyZuAWjMZFS9IEIkQ5FZOzyBTG0A9XfCrh938Rj3zYx6FcIPDXP3clhMPIjzeukuF1/k4cqL5B8Q7vwNgPQzJqPoCz2L4OVOeA9eeRLM9WQPFBVjcNPoLI3SIKNpiGYmavio2ggK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uw66/N3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uw66/N3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744261F000FF;
	Fri, 11 Sep 2026 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789129803;
	bh=Dgjle527QyEInV84KwmJW19HbjlErNLhEH4foSpJI1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uw66/N3aBLXwoQrgCafMRJMTKdyuJ7rxrJsr1iyneiHQO+EobJflDOEgbPKd/zMLR
	 kvWRfXdiSsptOsaiJwRh8V7rBKPs8rh8s1u2yXkKc11QBkl7zzAE2ZUdVdTDkc8To5
	 1NC2+gSShWmaYPZJs89Pxt6XNS13cUViwT06hk5Q=
Date: Fri, 11 Sep 2026 14:29:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Roman.Li@amd.com, alex.hung@amd.com, alexander.deucher@amd.com,
	daniel.wheeler@amd.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Set gpuvm min page size
 to 4K on dcn35/36" failed to apply to 6.18-stable tree
Message-ID: <2026091133-darkroom-guzzler-66c1@gregkh>
References: <2026090953-attire-untidy-c602@gregkh>
 <b2f45802-99cb-42ae-9da8-93b36c6dcc9c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2f45802-99cb-42ae-9da8-93b36c6dcc9c@amd.com>

On Wed, Sep 09, 2026 at 12:00:21PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/9/26 06:52, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9ce3169430f1db035d491481086e2fae2552569c
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-attire-untidy-c602@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> > 
> > Possible dependencies:
> > 
> > 
> 
> I'm not sure why this fails to cherry pick here.  I just tried on my side
> and it works:
> 
> ╰─❯ git reset --hard
> HEAD is now at 1c732c6b94f0f Linux 6.18.49
> ╰─❯ git cherry-pick -x 9ce3169430f1db035d491481086e2fae2552569c
> Auto-merging drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
> [linux-6.18.y 40ba5915f3a5f] drm/amd/display: Set gpuvm min page size to 4K
> on dcn35/36
>  Author: Roman Li <Roman.Li@amd.com>
>  Date: Fri Aug 14 18:03:17 2026 -0400
>  1 file changed, 1 insertion(+)
> ╰─❯ git log --oneline -3
> 40ba5915f3a5f (HEAD -> linux-6.18.y) drm/amd/display: Set gpuvm min page
> size to 4K on dcn35/36
> 1c732c6b94f0f (tag: v6.18.49, gregkh/linux-6.18.y) Linux 6.18.49
> 5f08c45bdcfd2 usb: usbfs: fix use-after-free of usb_device in
> usbdev_release()
> 
> And then I tried to compile amdgpu.ko and it compiled just fine.
> 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> >  From 9ce3169430f1db035d491481086e2fae2552569c Mon Sep 17 00:00:00 2001
> > From: Roman Li <Roman.Li@amd.com>
> > Date: Fri, 14 Aug 2026 18:03:17 -0400
> > Subject: [PATCH] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
> > 
> > [WHY]
> > Splash screen corruption on some 8K monitors.
> > 
> > [HOW]
> > Set GPUVM min page size to 4K for DCN35/36 to use the correct DML2
> > calculations, avoiding the corruption path observed during splash.
> > 
> > Fixes: 115009d11ccf ("drm/amd/display: Add DCN35 DML2 support")
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Reviewed-by: Alex Hung <alex.hung@amd.com>
> > Signed-off-by: Roman Li <Roman.Li@amd.com>
> > Signed-off-by: Alex Hung <alex.hung@amd.com>
> > Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > (cherry picked from commit 2cbfb03dead5088a7bdfe2ce392a5caa3d1b3719)
> > Cc: stable@vger.kernel.org
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
> > index 166f10b8862f..c82886323a51 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
> > @@ -301,6 +301,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
> >   		out->smn_latency_us = 2;
> >   		out->dispclk_dppclk_vco_speed_mhz = 3600;
> >   		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
> > +		out->gpuvm_min_page_size_kbytes = 4;
> >   		break;
> 

Can you send the patch that it results in, perhaps there was a rename
that a normal 'quilt apply' does not handle.

thanks,

greg k-h
