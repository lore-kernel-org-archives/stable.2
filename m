Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384734E741;
	Tue,  8 Sep 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861691; cv=none; b=ApZtIr9a7/j3eCUA8AQwave8YN0DdF+dCTJ8GXO2G6D+3muCarJw3DvZAuJuo1+keA2OLCGL9Sy6nz1P0OO4iMBlRksZt36h8GE7lelXzSrgNxumZdpHLKuijdemnbA+OHsIz0KNQXt4FYtAi2yiW20TwUWNGmmL64nqG2JivNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861691; c=relaxed/simple;
	bh=LXbSDYsjkNm8cedG4AwDLbzDsF4yDyqkcWvKzBxsQMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM3jEqzabtI44wTbKs8XuSyoQQuh7Qs3ySYgLB87oJKbVFYT1NrrETVZM5dCWi9w6Ei3Cyd4FIUgwwY7FKYVU4xSdPjthl6rL5ZiCi7qcfpisZPskNwhdoIzEtpI7FPOZzVz0K4z45biyKTLPWcKdpiICR4XDqHI5PTKPwu7ViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYs/vCiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYs/vCiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6F71F00A3A;
	Tue,  8 Sep 2026 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788861690;
	bh=LXbSDYsjkNm8cedG4AwDLbzDsF4yDyqkcWvKzBxsQMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYs/vCiQ6VztJSFWja4EifGNBXEgJcn6i9LeOxbNuZ7YPVs8bKCPOBWKznPtGHFeX
	 ggQU/V2yLb9hct/R54BI6siGgFtrJhwg/bz6zR72hZ9RxuVpgsXHSv2AwFSXMWhoIF
	 Uzs7OLyVUc3s9UJ5G65/ZWy7J3sSqDnSUBcjFvsU=
Date: Tue, 8 Sep 2026 12:01:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: HE =?utf-8?B?V0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds write in
 ni_create_attr_list()
Message-ID: <2026090804-parted-manly-afd0@gregkh>
References: <20260625031932.9412-1-skyexpoc@gmail.com>
 <CAOC0qyLj55itFPEurfNddWpzzcPJ4j3bvDxfWBRev_GzPLL+mw@mail.gmail.com>
 <74bcba1c-6bf4-43b0-bbb5-ef2f0490e3f7@paragon-software.com>
 <CAOC0qyKG=RG=7Nf0OpTYLQ5QZLhjNUMd2=YGQc4+S_SCoRBbcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOC0qyKG=RG=7Nf0OpTYLQ5QZLhjNUMd2=YGQc4+S_SCoRBbcQ@mail.gmail.com>

On Tue, Sep 08, 2026 at 05:52:20PM +0900, HE WEI（ギカク） wrote:
> Thanks for clarifying. Since the upstream commit did not carry the
> stable tag, could the stable team please consider backporting commit
> 7c4841e2a627 to the applicable supported stable trees? This fixes an
> attacker-controlled on-disk slab-out-of-bounds write. My v2 carried
> Cc: stable@vger.kernel.org, but the functionally identical v1 was the
> version merged upstream.

Now queued up for only one tree, as there was conflicts with the others.

thanks,

greg k-h
