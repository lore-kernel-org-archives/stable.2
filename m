Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603979;
	b=rOE73vX3W8uVe4GWEwDkUFnbjhBkwAXaHdKmLpHVm3WNoxst3xpaohzoOStf94WFVOOg
	 8s43hEwt8+VrNx11BGH/29iLFeSarIJh/oLjytXqAlym5sC2DViwH2oVbRNQ4bilT1Ga9
	 RLLi12kKCkv8NhsVPTLgfGl/7WZLGw8xAaLjVtv3KSr8wNNpSv8Fw4EUUfzfbvxYg169y
	 omj/ghOGeBs6rH6pDRIC5DcEytaq3OvrO8tkVHPOGhvDVX9PvGVBxEndbkBXWD+LHsgMi
	 vxr7fkSdcORJBjDP9m/jA9G8x8s3xGTwY2ImqnK/C+jxsqw9oRh3916IkLNp8ih2bAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=S9vYTzzEPb4qcH4RBv7tjSynh4XscZFtvZPI332k8MF5ZnSamWEwuV1FqoBKgQ1ZKvIM
	 CkGz45aq1WQFAms5dkR/Uz7E6aiZlDrRaeMNIqyiXBQtxCdMXHevOXO9Lgh54PSvu2W+w
	 DPSICd0MR/cbFBBW0KV6fTinhApok23pxme6/DYy3Rx0YNpMun2KcHcSXkezlmqtSet9F
	 /8Ya6Su7v/ITX7qPUfKcrU9abwtUmilrapvYPZggbLphyOZOfDKSyDDwrQgD6IvpfEbTR
	 cVFRXWX8l0avc11gBBzfbjt10FvZVDtxd4eZoJJvmaAbg8+ntermSBxDl5dRpbGFBgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGr6Zg1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A59606A324;
	Mon,  2 Nov 2026 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGr6Zg1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5F21F00919;
	Mon,  2 Nov 2026 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793603979;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGr6Zg1xktbK4WkACZ7DPOhrZHzy/piMgTcXlN6dtZpyhnOW8gSDaFsap9nYImWIN
	 g4MncaPbc+SouxQ3DAHCd7u8UAa6eZDxgzjdwPDFq1Djeso7MV1TXATnoEDlDDAyx/
	 HNh6imPBkaYywPBBfS1+8ANeDbAw8ZKG5LqPUyzN6HQ6Jl2FYI6Fx8eYD8Wd/6cqD7
	 J49h3cv+K+X2zhWXoADHy28igLyXV3tLjFeXVOJg7kACa6vmZR691jryvRjWYeuQbH
	 79bJex1t9kfDwbloEmkWgDLsG+J6KCIHvFlmvjQzxC/QiW8D+XIGTBu9C1JU77G/iK
	 5C1TPxnd259zw==
From: netdev-bot+sinfo@kernel.org
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: fix port cleanup on probe errors
Date: Mon, 02 Nov 2026 07:19:38 +0000
Message-ID: <179360397824.3286.4472427559775465393@kernel.org>
In-Reply-To: <20261102071310.3004332-1-lee@jaeyeong.cc>
References: <20261102071310.3004332-1-lee@jaeyeong.cc>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
