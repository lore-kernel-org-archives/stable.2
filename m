Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07A8635D
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592912; cv=none; b=dwNHCJMhlPuCAFhNu69lKT6zpXSH8D4pJLOZlW8ytzXLgGRHD0TssonBchfyfl9KGjQYEFWnSMFnB/umVF/2HLmUCNdXdWfiEgVOQDNdMuX8wT6IdbpyajMwtVhfmrRDYOGhVllQspuHGrMKpHg9MulCUdXaflDkop6br2j9FO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592912; c=relaxed/simple;
	bh=OSWThRm2vBAxCkWJG8g/gU8ZVz29W3H1kZ5XIYhH/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8no6baRlJmpCxJtjDteEWaMHQi4geyJSw7uz9GNA23yCXR61ntjXvvWI7xCxowHLSuNaaVOwohZOIH53f/LL3ZdN5PfYaqMdBMK9qSt9G92PoCipfcutiBju+6byDwI4B9dHhaochYG6HECzID6c3SMFI0lBexG/IKLJI0NX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+X7Fd5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+X7Fd5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B8A1F000E9;
	Tue, 16 Jun 2026 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781592910;
	bh=zAG40Q9Ze50z+6ILAlRQbM5+7IqVmWpSAyElEov8uOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+X7Fd5IkVhh8b8lqMpWLQRjMS1VR0+uadcpdyK446obA97bjyeZVSwReDwjlMOgy
	 Jw14o2SX4gmkTKnhvjctoENA02Y2hLrhkX/nl+DVgAyw1agay9Z5aivwWyFubMcboB
	 5VaR40W2hwwC5JVJkMIpptZIaFphzPShFPzVpQZo=
Date: Tue, 16 Jun 2026 12:24:05 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] batman-adv: tp_meter: fix tp_num leak on
 kmalloc failure" failed to apply to 6.1-stable tree
Message-ID: <2026061640-citable-dreamily-8662@gregkh>
References: <2026051520-obnoxious-editor-0139@gregkh>
 <3081197.VdNmn5OnKV@sven-l14>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3081197.VdNmn5OnKV@sven-l14>

On Fri, May 15, 2026 at 11:10:30AM +0200, Sven Eckelmann wrote:
> On Friday, 15 May 2026 10:45:20 CEST gregkh@linuxfoundation.org wrote:
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> @Greg, I will take care of backporting the failed batman-adv patches in an 
> hour or so. The steps you provide in the mail are always super helpful to stay 
> focused and do everything step by step. 
> 
> But I've noticed that on a shell with "extended_glob" enabled, the shell tries 
> to match the last parameter because it sees the '^' character. Maybe you could 
> also quote it too:
> 
> -git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> +git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-obnoxious-editor-0139@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'
> 
> Btw. I've just disabled it here on my shell. But maybe this is still 
> interesting for others

Ah nice catch, I'll go update my script to put the '' in there, thanks.

greg k-h
