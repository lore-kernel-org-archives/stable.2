Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120570;
	b=I75yckw3hoJ2p89Dh1XUR+stIWj+STJCuMV4ig2OGm73fkK4cfL5/pON1qyq/XANSGhv
	 if/eSebXSAsJjCeJj5moHebRr624efs4iQO8oxyJElwbGmkvSmZwsKp9V+EkaI3/uc3PG
	 6Bo1sEw+Vk01Fnz/cxHeQVvJZCYkYXB0iDas+wL8G5VqifH/3OdzkNIyzIh5lnVCWOXK0
	 2iF7L/o/5A0D02MTKZb+CDWUrPMQ0B9vpPv57DjdaAyJqFVSLQr0siQqRi6b/bgVaSFJe
	 OvGBxfh0VTUDjFxrZCYSHVgIcD6yUXhKVrRDbnApDQr0wsthfibKuZcv1c4g7TyVdCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120570;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=mbLu0l4ce4k/l9SHeyflrpsIii9N0bc0DUvSyRh0YOs=;
	b=q6TEs0mXR+tzXrEzm37tF6ybsG1f2NEFbIdEZb5Nj644QXJeYENhq0PJbHfEG++eTihS
	 +MR3ph6PFoYqDo73mtT39D+Z6UFiE15epSkO3XYaJ26w1hYrbvRXcSIdE3LQAduwDk+/q
	 /n3KPNSb+jv/zuudf2WGvLyCzN9sEWLT/OJ6UxSzPH7eeue6BRjAuBeSA8ShKE05lg9cq
	 vcLPQlCUNOhzJVBi8a3B4Jl8Nz6/GfvwJE35ZaCXC87qHbx9+KlnI4MSZ17mFlK+zxPB4
	 iLXaTtFZN+AFuGEAFEBGcoUbdnYYpl7zINcDL3iqaC9kDBaoBd9xyc6sqMZci7h5vkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK79q1fV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693A60A5BE7;
	Thu, 19 Nov 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK79q1fV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D021F000C0;
	Thu, 19 Nov 2026 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120569;
	bh=mbLu0l4ce4k/l9SHeyflrpsIii9N0bc0DUvSyRh0YOs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QK79q1fVvF4BG5iRv4ps0cgF9/AWmDeLmiCTPfTCMLGFYFmdCwET1u2Jm+bG+ahdD
	 9VxW7Oo1l0zG4W35ykAFdemNP7RE0DEe2MjfSdk1OS7SgIeuE4G/95LTBw3Q5Telnv
	 uu9UKAZH0bEJay44a0yRm3YQLLE8TzLqzt/Shjp0Uk1OdIeV2ZNewjsr+/sCbI8csc
	 NzFkx9PAjlkY0lXkstd69NfOhW1aRs2cqWidRuLvI4vQlEimOhfe9sNeDDZPjElH4i
	 X3KqGWgu2ZNBr0tzAuKSEy5NQFgoAax3TOnM5g5Mft0P05oLyDPQHakFhpYLg2O9K9
	 4bXwiE2hpdRuA==
Date: Thu, 19 Nov 2026 21:36:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
In-Reply-To: <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
Message-ID: <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet> <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Nov 2026, Jiri Kosina wrote:

> > Wow, what an endeavor. Thanks for looking into all this.
> > 
> > I've finally got to processing it. I've applied 1-14 to 
> > for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.
> 
> Ok, now I see that you will be respinning. So I am dropping it for now and 
> will wait for respin.

Are you planning the respin to contain differences only around the 22/23 
patches?
If so, I'd prefer to still take the first 14 through upstream-fixes, so 
split the series.

Thanks,

-- 
Jiri Kosina
SUSE Labs

