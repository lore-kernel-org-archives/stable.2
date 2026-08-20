Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E41387371;
	Thu, 20 Aug 2026 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209090; cv=none; b=WgYKdIckXcnj9OYIGG3MpDri3+Ht+by8519bilt0LZ/B5JxIwDiLbJohj83pKzC34l4BKcd8D+BOXjt48Ua6xZPUi5hEEpHMQxnj+xOzR7GBENbjsykQnBXu0KlAUn6Cl26uXHp/nr7gu/G0qdEMuINZ48mODaGIEzeJL+0wqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209090; c=relaxed/simple;
	bh=H0fmMK0pckrAl4rGvSPyiWo/IQIfUDB+DNdHRk8SYec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfSH2nyymxOU1oHRIKbrJY5dER+qjIbj08+5KUXfZHTAG8Npo2muEL1zTbUb+iUmma3gbB2efpIdhNqafJvVQdL3kfqjwsYSiJ59OckNOQ52yVrBOXlWWECTuXrrrtN2ezA3xJxRI3N43HXpPiMaxFHp0Ai1F+X7RB3nYZubjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Jf1k6kp8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Jf1k6kp8"
Received: from ideasonboard.com (mob-109-113-29-237.net.vodafone.it [109.113.29.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61944AB4;
	Thu, 20 Aug 2026 08:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787209004;
	bh=H0fmMK0pckrAl4rGvSPyiWo/IQIfUDB+DNdHRk8SYec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jf1k6kp8iK/wkjCvYvC/wjKCtEZy/20eR91464mbC3iwI/Qrwadh6NbqcF5CNPyN2
	 xq6ArWdtE03oFhs4a5rXdxZ71vuIqFN4kE5G0Oc1UhuN8BWq6icLwgqq5DbjwoiMYY
	 mTZZgzq0Tim0UjNE1nDbvhxkN6toJ52ODXr6fOJg=
Date: Thu, 20 Aug 2026 08:58:01 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aoakuPV8X6-eneo0@zed>
References: <20260818105642.65381-1-devnexen@gmail.com>
 <20260819213459.1220894-1-devnexen@gmail.com>
 <CA+XhMqwXp4VVHJuY3dmBDLjJTyzwY=B9TEvZ9mVk=1Z5fqEogw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+XhMqwXp4VVHJuY3dmBDLjJTyzwY=B9TEvZ9mVk=1Z5fqEogw@mail.gmail.com>

Hi David

On Wed, Aug 19, 2026 at 10:41:27PM +0100, David CARLIER wrote:
> Oupsie, sent with the wrong subject prefix and without its

The subject seems right to me ?

More than this, you sent v3 in reply to v2 which I think possibly
confuses tooling (not patchwork though, which correctly identifies
this one as a separate series [1])

Would you like to resend as a separate thread ? Sorry for bothering

[1] https://patchwork.linuxtv.org/project/linux-media/patch/20260819213459.1220894-1-devnexen@gmail.com/

> changelog. It has:
>
> v3:
> - reject a block whose type info entry is empty instead of skipping it,
>   so an unimplemented type does not become unconstrained uAPI
>
> Let me know if you want it resent properly labelled.
>
> Cheers.
>
