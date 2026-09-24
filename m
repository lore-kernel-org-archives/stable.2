Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569F415B76;
	Thu, 24 Sep 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270952; cv=none; b=HkWwQX3kRr2Z+tdyuGOT/12cVX7y7F537XVnmlVFBE9kq/GZlBFOYnUveVRX1ecl0c/3WlfEJe0CYllAGRCv8k0L1z/JpszFMipUmtxMJQjBQXxyiavyag6eVv8qRFVRG+HpKC52DKOA2OGEVW15nW2Y5fvM3Oj/8ZhQW4GMxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270952; c=relaxed/simple;
	bh=2gv8kLBW9SVyay1G5opQjJimEfQR9TY8I0YqxyfPupU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKx2xzTdxu1gE145x4S0I23Gx3F7to9EDoTixTnGmqHGnZ5JW4psxmTK5JAzOCbfn4iwFi1IKiN1ZAE/37MpBeqQ5KnYdSsJefcrwYXWHiOzzTr7CsWEdBDvGdrk9G5rWMlcPptN7UENJifFTkzFL1z3o293kBL144xKk+8xusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daYPQflU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daYPQflU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6C21F000FF;
	Thu, 24 Sep 2026 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270951;
	bh=D4hYFv6SRlJplIdtSS3eB5FFK6xtOtWwojufnunZOk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=daYPQflUu+VBQKTdfYUgJrVnNzbyQ4xTbPErEtq+YY2F/HT4s4v4VPZOSWcbm1Y5Z
	 OoS5JzGl77jWmwqGH+c1PZvvD22Bc0dgJRmLy5h19c1mPNoKZjM5jpOZ8QgQ4EhHyg
	 LUANR/Hkxcnyg7/X4esCYHlnnBhQcKRLgtZIZ2DPsCtCw32l4lhZyxmeUOfZq3oCcK
	 gzhiDUgChqV4OzZ4vlOoeSw1qBB93KEcEDRsRb77HOM2CXjKjkZe+IZGRvMWT3cV64
	 W8bcjKqve4XS5ec377wsM3VZijETPx1uczUz8S1BP+57rFXKWHoKneLtEi1izp+sqf
	 P2QJSJC5c7ZPA==
Date: Thu, 24 Sep 2026 10:29:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, hybris <hybris@mojatatu.ai>,
 sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net/sched: act_api: reject duplicate actions in
 a batch
Message-ID: <20260924102910.09e9c601@kernel.org>
In-Reply-To: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
References: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 07:50:54 -0400 Jamal Hadi Salim wrote:
> Subject: [PATCH net 1/2] net/sched: act_api: reject duplicate actions in a batch

missing patch 2/2 here ?
-- 
pw-bot: cr
