Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E53DAAD4;
	Fri, 24 Jul 2026 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930325; cv=none; b=Yq3EVc1ze3MPlgdHcoL1GXwta/HbBsxE3Oh/cno2pM3be+c8nim+GzOIzMGAECkxWpEHT3tvmbwcg16L/uj1MSvKETHqIcP9Hx7HMtPB35kK81K84VGio3Vm3+jIpKwnKSLbkJPuSFTO8R47gse1Ia2UvrTAlmuXZtCEywtHPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930325; c=relaxed/simple;
	bh=o9kGb540YenJrByyQX9PxC30FbVDYnlT8RdZtkEkdsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvyBky8PDLGuEQVdxsva3jP7qGU3Yr1i/vvS5Msm6Q5uyHWag5WM6axxHfdjFyE+4kxJeDa0gZql25L5vxZiueZFMyjagK3Qkklgi/nNn98owe98s0IesN2X4xjHWysnvgWVXMT3pcBW03NHR04KG06i5KhcWYaUGWilDEXUqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7jXfd/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7jXfd/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D211F000E9;
	Fri, 24 Jul 2026 21:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784930315;
	bh=o9kGb540YenJrByyQX9PxC30FbVDYnlT8RdZtkEkdsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S7jXfd/Z5EKxkNaOxsh5P7GgnV/QMQmwJc84c+ASOL3leovskt/e5f4oFy3g7Al5c
	 gaPxToilAQEkU7O5h3Vl3caNC8FQlgpfxFQgTsy9nYBjhGjA2OmTxL5xw+NREytBWL
	 uGQ+uqsSUDS129ee//2vaZrorPWx2E8iC1Hqa/kk249eTefxn3FRPOk7snbQI8X0pQ
	 35rwVf1OKlD6pWr7dmoqRjEbKolHUgI1BkCpznGQXvdEVsW5tj7sdIWzzOsHotg5RD
	 yBaMu54pa9XS/5e+ds2kFbpJ6cb24BNwjRSz+pySy4pT9J0Qio/QFbYC/7rzjHXXxQ
	 SdvPw4q37Nu4w==
Date: Fri, 24 Jul 2026 14:58:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, horms@kernel.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: lock rx_mac_cmd_list and drain it
 before freeing sdata
Message-ID: <20260724145834.3e0485e6@kernel.org>
In-Reply-To: <20260722101608.37744-1-security@auditcode.ai>
References: <20260722101608.37744-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 12:16:08 +0200 Ibrahim Hashimov wrote:
> rx_mac_cmd_list has no locking. The RX softirq producer in
> ieee802154_subif_frame() list_add_tail()s while the mac_wq worker
> list_del()s, and the worker dereferences mac_pkt->sdata with no
> liveness check.

Both sashikos complain about races:
https://sashiko.dev/#/patchset/20260722101608.37744-1-security@auditcode.ai
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260722101608.37744-1-security@auditcode.ai
