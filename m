Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF14A090A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881684; cv=none; b=BQlRldk07DRvPkOIVsG2V4Yxf/01OAdnZPPOkM/4WIWyDrgJ7obxGKEhbZMbHvYFFbuPaIBLpKLhFY7/q3fgzkFYgCrCOcS6BRZqsi5zMrKM50wNxYTQUiy8f/oTSce2FO25Fb/Cbi0+4WwsIh2J1Eq7EP84Lf5i92UehFxZajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881684; c=relaxed/simple;
	bh=AVpi3+P9ZEYAFfu3wTGIoS3S/Mp3SpLXwBs/pwErPcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWMeWplWl9xOwCoenDdqMYV8jP7P0WrbPgZecOw9iMHKXU+Vvp413iVXQIECGb3zWFDsvoi++EkBkIK+dLxaOoJbg5UjPjxBKcuhXSvYzzRLBsx0BbeGDHKJuSNK3lo0YiaAqLyP+RfK5ze/+gdt5nIzfu6a59uB4xWl2jK7jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E541F00A3F;
	Tue,  8 Sep 2026 15:34:37 +0000 (UTC)
Date: Tue, 8 Sep 2026 17:32:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, superm1@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd: Drop calls to restore power limit and clock
 from smu_resume()
Message-ID: <2026090831-oxygen-ecologist-a7df@gregkh>
References: <20260908135407.1640233-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908135407.1640233-1-alexander.deucher@amd.com>

On Tue, Sep 08, 2026 at 09:54:07AM -0400, Alex Deucher wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> User requested power limits and clock settings are already restored as
> part of smu_restore_dpm_user_profile(). It's unnecessary to call the
> same restore as part of smu_resume().
> 
> Revert the following commits to drop that extra restore:
> commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
> commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
> commit f9b80514a722 ("drm/amd: Only restore cached manual clock settings in restore if OD enabled")
> 
> Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 4b6ec94fdae2407d9b8e69e3ec5f879e72ad667e)

What stable tree(s) is this backport for?

thanks,

greg k-h
