Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812936896D
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925672; cv=none; b=o+L2EYv0k3I9wRfB5xuof5Qtgu0UrwhAcEiCC1JG9Nh/HJFOxBz67ZecuNJKVTwzKQ7Q/RbOAjlLrZZ5twcc1U6ZhDKAQbgm81MDPA4yMsoZjqWA9IX8q9MTGv1UBJofJEZbyrQapFos2wbKM4i7NisP44WA2gQohlJF5OqHaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925672; c=relaxed/simple;
	bh=yIs4xAeu+mwzhPBdB9m/ZElgntT4cp/LRfpFSpKwiXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvfLB6Dy8MQalI2htPdy5FLGzmKlVUzdzjQoMaLKSJOi+CJFkFIjRSUlsVCKhcmvG0x8XDbS/ZAyolZOdSiCSY5gcgPt4KT/a16Fk69hi1NSh7ZwmCkJCmECXxZpdwx1aq4VT3a/9Ov/0jvy06YzFAax88WjD1IiInYXp7SVdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsuNWpxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nsuNWpxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5351F000E9;
	Mon, 13 Jul 2026 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783925670;
	bh=yIs4xAeu+mwzhPBdB9m/ZElgntT4cp/LRfpFSpKwiXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nsuNWpxyK4+X8KKpP5NUBQyIRjdlinLa0qo4CEdCwJDG0NV/E/Ad4NvVXRoC/r3hS
	 E/4+jE47+zcoNYLvKq96i7AJITQ4xzzyrOSJbLIHiFbNyaUUTh9G6WLD4Z7exTS9NX
	 MpRrg2lL4em9LPQ3CjK10N5oq4mDkpLbzP6aouuY=
Date: Mon, 13 Jul 2026 08:53:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] exfat: bail prematurely from
 exfat_extend_valid_size() upon fatal signal
Message-ID: <2026071352-bunkmate-anymore-0962@gregkh>
References: <20260713061954.19557-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713061954.19557-1-dxdt@dev.snart.me>

On Mon, Jul 13, 2026 at 03:19:54PM +0900, David Timber wrote:
> commit 82a81a7352bcf5f2756ac33d47ee0582737e9a85 upstream.

No this is not :(

confused,

gre gk-h
