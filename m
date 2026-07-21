Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E2439012;
	Tue, 21 Jul 2026 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667639; cv=none; b=Nb9tOajLfsW+ur7QmJfzJQfvpfs0/ox+14JHcryLlWEXsUo86Es05JKbvOjPJt7RFUrrIoGt2buzaxpxu0nWxioVwm37MrftL5YqExLkhppNHGjnE0wURz90G5grwDfxQi4NoO+KRatnxRrJyLgraGUusDWT0OA558a97q+aUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667639; c=relaxed/simple;
	bh=wDZAdfh4YitlwM5SYpXENkwHDSLF7ZaTMaIfmd9XjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUP25WdznuQGdtj283iDg8H9cGnhSP5T9vsiEG72hM11AryLA3lKo/5VaqUSG5zuB2HT9wHV8bsIBOaoxvQbwKKJppk34PDWX1HGhuYMlm/vrV2oVUheV8rJv5WNUCrc6rOF0ELZ4XmRcbdikKpEyb/481rr2HP2vRahogNLdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THsdyW+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THsdyW+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982211F00A3A;
	Tue, 21 Jul 2026 21:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667637;
	bh=Y1Fqr3yD+eTJzYODUSrjqSjU2oxxaBaa6ty7X9vYvWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=THsdyW+1tbanf7hmz3l6Ni3GoM29oYpaQuIawLAHUbbD449orliOuz1sd4NLBMCDQ
	 fjRjv87Z3RS55EK2+M8evnsfEDovJmsrLAjZCRgipBEx8G4gTVuANQHtZPSogfmEHn
	 3pZ+0O5wobZnskkw9S6sFRRc8lfu6FmoUDlS+MMeJWA4mMTvABVIyeFL95IsfnX+/i
	 IKKPOzLqtQKrLCplk/kl8OH/JsdQKZ/40khJ3w4/Mg7Iegg62127tt2NHdmvpG6UMF
	 XgheDekd2KpIVFEc/Zt1R5TwizvSP932ubSJScLY2g/iYaQz/h7rHKiLAvJlVXKAqT
	 ++GZgbx1ayZaw==
Date: Tue, 21 Jul 2026 14:00:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mac802154: hold an interface reference across the
 scan worker
Message-ID: <20260721140037.61bf4635@kernel.org>
In-Reply-To: <20260717105810.26226-1-security@auditcode.ai>
References: <20260710140927.13228-1-security@auditcode.ai>
	<20260717105810.26226-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 12:58:09 +0200 Ibrahim Hashimov wrote:
> +	/*
> +	 * sdata->dev is dereferenced below after rcu_read_unlock() and outside
> +	 * the rtnl, and a concurrent DEL_INTERFACE / PHY teardown can free it
> +	 * asynchronously from netdev_run_todo(). Pin it with a reference taken
> +	 * while the RCU read lock is still held, and drop it at every exit.
> +	 */
> +	dev_hold(sdata->dev);

Please use netdev_hold() with a tracker on the stack.
Please don't post new versions in reply to old ones.
