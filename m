Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6553E024F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647388; cv=none; b=D5iluOmES94M6nJT9IUtpIrmNz+bkIn6KNO3dbTep7yweJpQCZQ7fhlgW6PmiMPXQ3mrYU8fGDatifVbdYS8ilOhPGSkiNY2ouQ/6/gZLHftmvTZvFE2jdEvJhhcPTZhBOmLigElkbnzBlmyPU3/wjcn7ZJK+Q7aIpM5Vr2PqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647388; c=relaxed/simple;
	bh=28scDQzKucQL6DiEcKJupVj0en3+wJoei3BCEmBoCKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNNN7I8IFo3ov0271rPdc5LN09xYiOjW8Pix1FHTUhXL//c8Xb41YxCBCXrYDcLzEBh0NMilK2hCaAhXi9OkY3pUgsQCneUtoMkiqonZicDLhTXGyTeR7NSiCtO4qfhrcvXemMmsGWBG/u1PQK9OOcsIFcY7v2w1vVSev31VPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NmLwgL0m; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NmLwgL0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787647384; x=1787906584;
	bh=HOvGvpBL6vKX/Gy/8vu8P6+iSfQ3ZvawAvrRVtwgKpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NmLwgL0mYtc0/WRKBglhDItbnKtDRKlAEAJ0O94GaedDAPKTHqbSg533Totd84AJ/
	 kpk4mFRwAoaIuqR4jDLN988LHcUlp6RJei4uSz3q9kC+rP0Rv/uowOautYKJS5q7Qn
	 nDxxygqeTNeMM39xW3Gd/gjdegZ+5vH6kc3o4YYvCp7bsHJPTLFDhgoEEa8Eip5xCp
	 mfHVVVx7fooxIbb6jxKd0udGAAs7CyiwWnREosQQ//gQocwBF2l56dr2ek+CjEVWEV
	 nBexEYJ/CLdmgK8NWMeoSmm+7LT49DL/B9O2nqtePXujuuhfUVJ5VI9OfLeU2rtRKF
	 kvsSpBTRR8ZNw==
X-Pm-Submission-Id: 4hThBH0Lrsz1DDXG
From: Esben Haabendal <esben@geanix.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: <dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>,  "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
In-Reply-To: <ee366627-a286-46b8-b343-7f88064a25de@web.de> (Markus Elfring's
	message of "Wed, 19 Aug 2026 13:57:39 +0200")
References: <20260810-ti-sn65dsi83-fixes-v4-3-ae9c95c8d162@geanix.com>
	<huX-KL5X5hbADDAlY_Y7yetpfIUeuL1vJ_SZtUhasR8lpLs_KDmmoZ-AkbNOVjguhsSV2OmyrlT-j2dZj0UrUA==@protonmail.internalid>
	<ee366627-a286-46b8-b343-7f88064a25de@web.de>
Date: Tue, 25 Aug 2026 10:43:02 +0200
Message-ID: <87wlteoajt.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Markus Elfring" <Markus.Elfring@web.de> writes:

>> This adds support for =E2=80=A6
>
>   Add support for?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.2#n94

Thanks, changed for v5.

/Esben
