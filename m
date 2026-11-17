Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924368;
	b=OhiVkiyHtFtrp4Xgi2Zy4u7l3dap4Mf71gBm3mbB6ygNkSWQAcx9JUPwISQwkhmequvM
	 SHmew/DEfGHUW19sRFCeR7TbVkMJb9wZSyvmF2QqDhrnp1hwx5SHdEi0/UFvcEKf+9gW5
	 RDr0tpADl/J86MO1QIgX45AYwyDYn5TySDupiC6F0huzdRWvlT+X3yawL6va9SxsPMTl0
	 UfHL10OP4btiXUY6ULA0Ng3KqBXbY2A+cidPzYf4ac5A3u157uPUOpLMyCA8MJcnX+Hxv
	 mLGJ4aa1HZMsu4ixsZe0I4KknARSrGwVqcLaRjh48N4bcp/DGluwixKQu0jBZHZK0HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=bJVwrQqa8l7JgzWCKogPwHHXJ/PZMAHNz4aWA78CpQ4=;
	b=xZgMtQxwgROhkLR1xedvzpgrPU1HscXGohQGSiS+q8CDfJRZoEDC2oZknnWCLkrbIIC4
	 3n+zMU9NVR6jB+iEOtkMyJXQTZjbqrMRkpwp9fQk+ryGqrD5CkIJHaYF6WB1h6vACU8ud
	 6vLKkMOwnaEOy6D0FxjY7He0JWLoGYcNVCBAe3es/Q34r9Mha8S2+7sr69WvWYtTfowDh
	 PtPBpl7UtpfbAsqn1o/Med71g2zFmLY+h7OczhOoOJ1CKBS5UMCbXmOqSCp8lcPbbMEeE
	 XnpKb2TgEtMEb5Y+uPTwZGvuhZ9H4HN6O//NmmueNza7qta6PEk0mhdeBME7yE1MjHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi+tKxi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F83606A31C;
	Tue, 17 Nov 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi+tKxi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955621F000C7;
	Tue, 17 Nov 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924368;
	bh=bJVwrQqa8l7JgzWCKogPwHHXJ/PZMAHNz4aWA78CpQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pi+tKxi9kmMuTZhjTUoxbJeEVUTg2VvCUhWTqFt1mB6L78yNYqlOsWqxLYARFXVoA
	 Yri51wSF7FCoK6pZok1+2vZSlPdEeE9AbaelnR16LgTyct5RGTyACpNJhzRupF235S
	 6mJDych6WLvoIYyItiTIT/dKkqOYod4KRkwiesPz19DYLHyebZLtIGTjZnXU1TJG44
	 IckbfCIDcpUHjybzvYG86Pzea+WPkZSHyHkDMryi9W6O9fE5WnDvMU03VsbJV/iHQI
	 woROMR7CJ/FU+E20NB/HaiAZW3JPcy1wknGP4C+HZ7SMp0jtfn4h7MWH7dFPxaqipT
	 Y2/2/xzvj11Ng==
Date: Tue, 17 Nov 2026 14:06:04 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, philip.radford@arm.com,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Chengyu Liu <lui2012qwq@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
Message-ID: <20261117-prodigious-limpet-of-fame-3d72e6@sudeepholla>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com>
 <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
 <avw5o7sTyriZ2ZiX@pluto>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avw5o7sTyriZ2ZiX@pluto>

On Tue, Nov 17, 2026 at 11:25:23AM +0000, Cristian Marussi wrote:
> On Mon, Nov 16, 2026 at 06:25:52PM +0000, Sudeep Holla wrote:

[...]

> > > @@ -188,13 +197,16 @@ static void scmi_forceful_work_func(struct work_struct *work)
> > >  	dwork = to_delayed_work(work);
> > >  	sc = dwork_to_sconf(dwork);
> > >  
> > > -	dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
> > >  	mutex_lock(&sc->state_mtx);
> > > -	/* avoid deadlock by unregistering reboot notifier first */
> > > -	unregister_reboot_notifier(&sc->reboot_nb);
> > > -	if (sc->state == SCMI_SYSPOWER_IN_PROGRESS)
> > > -		scmi_request_forceful_transition(sc);
> > > +	needs_forceful = sc->state == SCMI_SYSPOWER_IN_PROGRESS;
> > >  	mutex_unlock(&sc->state_mtx);
> > > +
> > > +	if (needs_forceful) {
> > > +		dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
> > > +		/* avoid deadlock by unregistering reboot notifier first */
> > > +		unregister_reboot_notifier(&sc->reboot_nb);
> > 
> > And re-evaluate needs_forceful again here after un-registration before
> > calling below forced transition ?
> >
> 
> If all of this is locked as it was originally there is no need, the two
> threads should just sync properly...
> 

Fair enough!

> Let's see what Sashiko thinks..

🤞

-- 
Regards,
Sudeep
