Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1B3603D3
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701609; cv=none; b=F+1FK1gP3ckvam+iOCExIV/17pfi87ZOUGXLvimHl1+SEtaPdd6/5ANHqya9UtIPIHNdA3PqMiL86CgJ4HAYn8X04wi6+Umy0Kwu2Ygh01YyaJmoPgN/5QF8aoSNTdd0rf7d+133+XrT81ZCdyAKRPny7ghDbFpbYJBllYp3Jrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701609; c=relaxed/simple;
	bh=lfrC94tckRMaHbBfFiyvVoDAMsBo2dW50W3Tlw3ynoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW67rd40mutc6J91UDULoW10srWfw8GX4tQh9qV4bLunicNvDJWCmq5zpzPO6RrldCiispRCJbBBNYn/MD1cRsxsv8KvTEMKbR7VDUcPBpE8GJxwJ2fFLjP2YFOnL60Xr1bkENiIxBi0VoyaNg/01/cbiWu0s6l6KwD/8pt2Neo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk0xfER/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk0xfER/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460361F00A3D;
	Sun,  6 Sep 2026 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701608;
	bh=3i3cnxsjgXj1Ry5tYLWzwR60/JfIgsrk+wBYGzFihAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jk0xfER/e2WbaOLlhWfDPYZgN6T1zG12XCytRkHsDNEXdfibxiOcC3UDZmsywY8Lb
	 zQHs+fOWxH7BxEEGP+FEVeOXVacG/v4+OKc46AhxVo0WMiOrGligvPN1PV+S9MG5fF
	 8lQ19+NiHfos5AuDZVXFplZaaG/xaqu58sOXJXH5F6w2mS6zdqKeLZ4C+LoFsh0AQX
	 O3TnFNaPBhLNT95Wh1m8LeyVp2N1Vazy/No8j4uO+pkKCbCKPgNawFmnFkq7XsaEsn
	 jMQLvpDkIflvOw8aieb07Wzz6oOKW2AzqvkZuUqfCft52D6Y4VFeF4vovYsDPW9rxU
	 MSzcSArHbKqMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jongmin Jang <payload.jang@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 5.10.y] net: skbuff: don't touch shared zerocopy state in skb_tx_error()
Date: Sun,  6 Sep 2026 09:32:33 -0400
Message-ID: <2026-09-05-daily-reply-0003-skbuff-tx-error-shared-zerocopy-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084540.1802837-1-i.maximets@ovn.org>
References: <20260904084540.1802837-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> skb_tx_error() completes the zerocopy uarg and clears
> SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
> SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
> shares, while the caller only owns the reference it is about to drop.
> Through a clone it tells the producer its pages are free and drops

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
