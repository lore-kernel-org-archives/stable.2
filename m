Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F437C91C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577170; cv=none; b=SY7mzX/OmHRYzQ6FBQuHDDqQaHsBEhMvbpWNz5+fAGLqTFgUKA7o2PgRsbPQk73Rz8EqXznWFAfFDWaI5DnYI+VvDkbDiA8Rtqb8FJeoKwniuiS34ve41d+9bA6Dfj59jZa/Ey27xKZ5NPuFwhTVjqDM07kdeAtKh/2YcqdTtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577170; c=relaxed/simple;
	bh=NIEyluO9LXfnOY4nAceRJA9kyFCz4XS25tyL5ZJP5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX0XYCHfLmuyFD/K7ugGMm24/BYuFr7X1pkgIOD1UF2yotA7doLHdc08ZSfweLjw09z0KrCa/OZSVWby6TR1RCf/VJaB7QcI/qX50JePp00cEWctvwxrxraIvtLF23Z1CUSh+vP9sU2V4aKrehHXYaEGY3peF91CjBHD4s3cCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDP4zQ2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDP4zQ2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977AE1F000E9;
	Tue, 16 Jun 2026 02:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781577168;
	bh=/FIkSap4UptszD4NKdK20ykLQ4FNBw5jihrk3CVRDFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EDP4zQ2qDSh9nAOVyyeXUplp5VJZTXHqTtZvsy8P26MfotREsBM2L04MGTi2KMj+o
	 aqntZIUSPBLYaa6j/6ONxSJqIw84eaKvEbnKggEBzqvpS+mV/i1NH+uSMsZJHW4lVF
	 0HJx7XU8qobJmzDr8S+XGi+b7VtCg5E4glQkFLxM=
Date: Tue, 16 Jun 2026 08:01:43 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Rio Liu <rio@r26.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [stable request 6.18+] wifi: mac80211: skip
 ieee80211_verify_sta_ht_mcs_support check in non-strict mode
Message-ID: <2026061636-falsify-handprint-8c46@gregkh>
References: <mCC83on9NUv38GIhB5hQoC8aXh1aZOeWWXh2010h2l8b0-rPJJKWIJvfPu4AZyATnaJuANDDndSZtpVC7_aQeArt435TQjshtrw9PUL2o5k=@r26.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mCC83on9NUv38GIhB5hQoC8aXh1aZOeWWXh2010h2l8b0-rPJJKWIJvfPu4AZyATnaJuANDDndSZtpVC7_aQeArt435TQjshtrw9PUL2o5k=@r26.me>

On Tue, Jun 16, 2026 at 12:00:47AM +0000, Rio Liu wrote:
> Hello,
> 
> I'd like to include the following two commits to v6.18 and above:
> 
> 711a9c018ad2 ("wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode")
> 0cfff13c94cb ("wifi: mac80211: tests: mark HT check strict")
> 
> There was some recent changes in Xfinity router firmware that limits wifi
> bandwidth in some cases. The patches add a workaround to get back full speed
> against these routers. I forgot to CC stable in the initial patch submission
> but I see no reason why the fix be limited to the latest kernel.
> 
> Verified these two cherry-picks succesfully against v6.18.35 and v7.0.12.

Now queued up, thanks.

greg k-h
