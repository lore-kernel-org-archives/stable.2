Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F518349B0D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788140380; cv=none; b=Zl+tUPrSPMXnKXRPtWhA0VrOjJ4bN3cIdikjJNRAE0OCFBvJNIqToDDIlL4frpQvMoLPw/oaLIcstdbOCx7jbWtFiUwSSZDhE2pClzTpkueOiXK/7sRl/Z8ojNARq7YFqKWOqj4xZ2GJitP7kjmZq/44nx5ysPmRXhn2uOb80wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788140380; c=relaxed/simple;
	bh=qer3XcIZQhwvqTDyp68i4vGXsH5xlZPHoAPpnIg/Ecw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joJhH1EMVgJ99vpXNO68ibxd/ydUDTnVXtWT+OEWBgZRQtQavZrpWKaQqchuuhVa/TFs9o+EkFW9kQry29I/ACpzvn6RYsQ0fPK4M+5yNU5bkFRWiwBT3cXyc25AVY5XvprFEM/3ups1WN9Zwv2j0f7Nu2a2Ht93CLXrpilTNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkV6YM1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkV6YM1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C64A1F00A3D;
	Mon, 31 Aug 2026 01:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788140379;
	bh=X22xG7UQR2rjUByXqlVSCiBh3Nd8V7LAxMpa+2+XGUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HkV6YM1uFJsVvClzHx+IBJG2hx/o8jKsVZkGu0b6RG3O6RiZbNc/N8mfXxJjndpE1
	 9+pzrqa8E3mX0xccuss6fs8TFEM/kTSPBMeottLlB7ZiXaf1J3upGgc5s11pUwnZAJ
	 /wXCKTDOH4R0P5656Wjz/rkiUPPIdSvA/YtUzYE/OUnJE3jq+XJPphhiI/uvHjjORS
	 abw4jMhMR5qqZTCowQF+ghiGtqPhdlf0tU/3msBGpZRWmVsRL5gWGjIq29IIcOXJbU
	 xv+iEZFQOElj6f1zyrntoA2uglVmMitBawn+i/q/2erwyRtmXPUsSKCOqQ6kLGWY4t
	 N7oL9qqAOAILg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Daniel Pereira <danielmaraboo@gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: ISO: ensure no dangling hcon references in iso_conn
Date: Sun, 30 Aug 2026 21:39:20 -0400
Message-ID: <20260830195900.0015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830045801.212389-1-danielmaraboo@gmail.com>
References: <20260830045801.212389-1-danielmaraboo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit aa9f7cb2bd3a2be998ceb739fc9a2f986eba43eb upstream.
>
> After iso_conn_del(), ISO sockets should not dereference the hcon any
> more. Currently, clearing iso_conn::hcon relies on iso_conn_del()
> releasing the last reference to the iso_conn.

Thanks, but this doesn't do anything on 6.1.y. iso_conn isn't
kref-refcounted there yet - dc26097bdb86 came later - so iso_conn_del()
kfree()s conn two statements after your `conn->hcon = NULL`, and
nothing can observe the store.

-- 
Thanks,
Sasha
