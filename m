Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC093B47F4;
	Sat, 17 Oct 2026 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206031; cv=none; b=PBOhsSxL39fRV7UHCQ+OAx28cMO5b3TKOgIOe/LskXF6Xus7opWDyu34GYt7EQv3GsdiOQ4SCuxR0yVrMSHSjoVfI2smLHOZNFVikx+8as7eM5iK2tnX6E3uEm7lroNcCuhtmodGi83Dw+B8ILIfdqw5jYO21XE6kfuSI30OAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206031; c=relaxed/simple;
	bh=ebAY2FmJZvAR5sJP4QHSNbr3A/bPEYK+iV2/xZsXWUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr1lsAWNW40KInpKeRa65fdT0E2Mk+jIF5dXrPXXMQ58dIb0C8pI2kgRWhG9rWdLpX2OkcTH0Btu6DhNlf8FagMRWfObGrCHQSHpDGuLOKknrPcr4tIbVnVX2gijLkuvFtf7YkRdcAB3YH8lm25ycG3n4LP56GkG93Zc556JefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWus85Fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWus85Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F481F000CA;
	Sat, 17 Oct 2026 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206027;
	bh=WDDbTNOv3ghOUWBdPIb47D+4HPLKbFgHhqWH/xLJ78I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWus85Fe/ChbftnQyB9LqP8y/nvvtd1cqrGOc9nR48oiA2eU22d70gX60a0MTqjaB
	 X1eRgtxg4vkEUop7fj9IlnnCEZ0ZEEyQAf0TSQ/hUTKv54B677o1OLv+i9TQ4vH0rK
	 LJhA+063d9rivtjFh0nmUIzWgyHb9SVixtRUWQbc5iNXan33KjZjOD8rcyeEHnw2g2
	 Yx1GJrG5U1eeyprQ+HE7+R7MuVhgTzbut/xtp7FJXEuRk+WrnTLu8qcTBF1fv7lYri
	 E5HG0eqSkG3busq4Bza+Sx1kfiFSN0nNGVBKjnrJJrz1vJMjCHtV/XD7v8lx3M02zR
	 qVu1F0yMbspGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"Jakub Sitnicki," <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Martin Luther ETOUMAN <m.etouman@rhinostone.com>
Subject: Re: Request: 04af4efde58a ("bpf, sockmap: Account for receive queue in FIONREAD without a verdict program") for 6.12.y
Date: Fri, 16 Oct 2026 23:00:07 -0400
Message-ID: <2026-10-16-1-daily-reply-0002-bpf-sockmap-fionread-6-18-6-12-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d8f91886-6b07-4dfb-8d9f-a1424fe8c572@rhinostone.com>
References: <d8f91886-6b07-4dfb-8d9f-a1424fe8c572@rhinostone.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider commit 04af4efde58a ("bpf, sockmap: Account for receive
> queue in FIONREAD without a verdict program"), merged for v7.2, for the
> 6.12.y stable tree.

Queued for 6.18, 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
