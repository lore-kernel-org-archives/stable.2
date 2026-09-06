Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F843BFE4C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701616; cv=none; b=V3aqS8NVUDeQ66auP9saNYKzPOiwOda4NbuznAAB2RukxqWZQ1CsQuwGFFR8l4uTi2ka/cYrhCVkxYqtkcvQoyBUYKU60Oxf/eL3k8v0knxTd26hjVK60GA+tNkLU3W2p6sG9Q/AOGK+GWtzzZeBZb7cl8pkJ9Udu37GO8ZZSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701616; c=relaxed/simple;
	bh=YvxFFFH+eFe3+hZtCohrS2aMqVVylH8vOEvJumq2FaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN1tqo/zWZE1RzgfDmcr2E5vsK9RN+R4BtWU6Kj8m+ZU0D+xRIpyAiFsEtAE85mw7tuMrxik0xNUhof1gpgIhbWxvl5kaA3AdHo/mg/Yonq9g1a0XMZGg4VnWuVzV3/8qGA4IaKGCyxtPb2OBupbQGcZTiSB1ZeyUoftKtBMmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP4tCwC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP4tCwC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A061F00A3E;
	Sun,  6 Sep 2026 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701614;
	bh=2PvzaMjOflff0ESwvWv2OrRbn/fIk1NcTa2aL3lK0Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VP4tCwC1PBWU2kD7G02Ba511U2b76pEMnSBn9wqQcRtUWr7wbAvl7BpjAl+lAHPVk
	 Ven82CCKkK4vum4QC7cPgkCRegKyVeL9hW436z6n9JZLQZgW7g31/ps/Bxox9CL8Nh
	 96Vf9mvjwGaK7kM+tcN1iry5fM4RbD8sKjf4GBEC3hozYTrUY3MrQ15lpJ7i6ZdV1v
	 tMZ+6Cgz3eD9gVSxOWvHk/UIyqmfX27oTQepxrOSnvVXSurUIJE/iuVVfh1GIaVag9
	 hecbu3qX5eIwSMPbLYHEy6AlZS0zEZRIAO8PS9R54u0ALOxCwU9VsOHOATZ+DUuh0e
	 nCUESW99N72FA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 5.10.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:40 -0400
Message-ID: <2026-09-05-daily-reply-0010-skb-zerocopy-source-skb-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904090912.1809399-1-i.maximets@ovn.org>
References: <20260904090912.1809399-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> skb_zerocopy() copies frags from @from into @to. On an
> skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
> operation on the source skb the copy helper does not own. That completes
> @from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
> SKBFL_SHARED_FRAG page-ownership marker.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
