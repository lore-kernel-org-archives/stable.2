Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43C3911A2;
	Tue, 15 Sep 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489460; cv=none; b=t1qQoSrcfCH2u97Mta/3iHzgYQtcvwDVqfUydYKiEP5mc7/wi0tmPW2vGQcWD6csWA4U7dNc05dDnQaaUxgEx0xugwzLEMPd57JXJj7/XUgMbXUViYsc6l2yR3BN38GVlmaw7yYVN9ng89xafc9YHyMy/D8HEZaSpk1mJmAYItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489460; c=relaxed/simple;
	bh=3XhvcrePAsjOkJbcs/niA+W2eQhZAo60bcemQHy+ulw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHJ8zWYO63GSx0bOYG5/A7JL+FGGNxuxGsGPmyeGufzncFofQYy2k6D++g90wENxanG5SH7SRMgKdMyOjpfSAVplGzf3cULpKgFN0eTQNmQSb0CDitCZAuooMImzasCqBfGf+GIcuiS/EBZGCeYwVeKtn4i1iw5XcoR3TATFRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8masCky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8masCky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9211F000FF;
	Tue, 15 Sep 2026 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789489459;
	bh=3XhvcrePAsjOkJbcs/niA+W2eQhZAo60bcemQHy+ulw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b8masCkyOCB+7meRWmTmfetMyecmbtWBSMlufRsJWotqxG/oFO+GZzZpS8TcIqagx
	 yyzUAwOaK6GaUwvwS7OzJUZEoB+IrAOK0jdVxnLpkmbwH1b2eNbM+UUBCP27F2GGbX
	 RycTFXP4YNd6Eb+M+D6TZAEsjqZ46MYOzziD57/htzNd9v1xPIxdHb66NNcYwLPqXg
	 r2KrOnTUbNIowdtt3hpaRAY0ldoyWrOKo7me34SRcT7pzH2QLs9ojK4oQW10qNUuBl
	 o2ItfuQxnNut8Tg77MlKcw7KVO7ja0uwfpaw0OT9uw4aOCXrc8pXmJuCqfJyhAhF7Z
	 3ppQNE5ePLKQw==
Date: Tue, 15 Sep 2026 09:24:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 rafal.romanowski@intel.com, sdf@fomichev.me, stable@vger.kernel.org
Subject: Re: [PATCH net 1/4] iavf: return EBUSY if reset in progress or not
 ready during MAC change
Message-ID: <20260915092418.0aafd079@kernel.org>
In-Reply-To: <20260915081222.13970-1-jtornosm@redhat.com>
References: <20260824190145.2714480-1-kuba@kernel.org>
	<20260915081222.13970-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 10:12:19 +0200 Jose Ignacio Tornos Martinez wrote:
> All the comments below fall into pre-existing issues, concerns already
> addressed in previous versions and comments, out-of-scope items, or extreme
> edge cases.

You're not fully fixing the issue, and sprinkle in EBUSY returns to user
space instead of waiting. I'm afraid that below the bar.
