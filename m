Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D33B5F5D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565852; cv=none; b=MppWqcU2KGkrjj82tFCcCCs/lyheQIpQzHOcmVyu0kpNWl4QtUB/ZFRbiM197UFwFn8jbGB1QqPWIaAisVs0MB8lxcgbc2kLnlKA9HgkPG6GDgO9a7NgcvQVhVAe3vksVWGjPBp0bDHJLRaXJBYA+sseiBprkkDLjDhN2d5GPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565852; c=relaxed/simple;
	bh=xcusaZT+f0kgxUODqiIU3wNX/h0PnvZqZAIDhGpOjiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3T5tm1BHx39giwyHywkQXIipTKh4JeUXKV3blh0uEZJqd5olXEmTUhDseRkuzOSUe0fXiTik0r4QKlY0qBkZn02in0HgyW4gsOaog41yKfrF51UIk3GOa/P30tcD5T34nGMwP+HeuvJOQSH8Hqn+5aEeT01YukAJTpS63PKfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ReInik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ReInik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C571F000FF;
	Fri,  9 Oct 2026 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565851;
	bh=4ss1EYUh1IFJv5uyUAWVk+hvH+oeAnjq++x2yxOwzWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3ReInikw//10j4WdDjDU7SlLCF1gkttUDNLvOxSWgjiQt6cpk3iEMvye6JcB0xks
	 edYy+PWRIsqi72Mddai4TXlpTJ2sDV5V1HONsI1cVlEoQ0ZE9CWYcduKR/B2zkLX8L
	 LMuOaInFlOWF6+OcyUaqjH69LNie51wdPuwY+qk0bDdfd1MknHTw9vWXColMFjpqEe
	 +q1grnGJsJwInKZ2ez0ajV7QO4qxfiCnleHXyJqMbEyCWO0l8ysur2FSQkTcfzQPrp
	 /lQaWh+5mXggPYXrt8Yy3Kk72k44vXaQefeyM2gCW5KYz6S7T2ci2+Ta9zzML7GFzb
	 5sAG6+0QYLq6A==
From: Sasha Levin <sashal@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y 1/3] net: mana: check xdp_rxq registration before unreg in mana_destroy_rxq()
Date: Fri,  9 Oct 2026 13:09:53 -0400
Message-ID: <2026-10-09-1-daily-reply-0016-mana-rxq-error-path@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100718-handful-other-11d0@gregkh>
References: <2026100718-handful-other-11d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series needs to go to 6.12.y and 6.18.y first, right?
>
> Please provide those backports first.

Queued for 6.18, 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
