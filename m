Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483164;
	b=IRPUm7OhLZfbMYvLWv1Duqd6Aefnx1YaAn9D065PKQ2V7XWuPiJCslHU3qRxahi4rLJj
	 XI2zr6M9uk+6luV4ZZbK6fLPBP+Ox77G7tLOCrlBxwo02dXUfpufJX2fEXBtigk55vu+H
	 V2xTSb82Yv+YcqKSgZFgWM03tkRzkPeaYpXG3FC+P9M5+K964364LHES2TXrqJCEKbaf2
	 HUCh3/boYOpWHWV+x9fb2+knJd7PH+1Pv0SfdOJH4K+7XxEG2Wy4jh6DoYNaqCs5uNlPc
	 sLjbQqP3EaE+SIjdi4pmLodPdyXuM93PMBnkUsiPVB8Sja6YBrI4baa5Yg/6QSiN2ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483164;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8cC4QJi5qQ7UiYXlnci9YUO582OttEU/b+y84GEos4o=;
	b=Vihh8tQfvi+dSS5xJI/5lk6zJc0LAqNOo3M5Wtt1YLbkIBtRjSt4D3JKjSdu8H07z4cJ
	 i+2ajciWryeusL3AGsFfhBZf1BnSi+b93dfdc7sXAgPqdKFgzCyocYdYkMWYQhjQN4gWQ
	 yhpbLfhVNU1YqihZYeHiPlPJJ2X2qAhy+TxNfPLUadpkK4gfxxZSWwzNU2ixY1OT8pvhg
	 jE+dSiGNbiJ81JFB8xHZgIcRSsAGY0pN1XW490oa6++6fbv1CF/5izO9rAJY8eNO4xlQJ
	 yjwD5jIrg6lk7/DmOVw22EarRjLRpwOHFYC/bM/T1FU1SSr31QwlG0EDLv94ylqKOcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E4aSCSxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13A606A319;
	Tue, 20 Oct 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E4aSCSxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF91F000C4;
	Tue, 20 Oct 2026 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792483163;
	bh=8cC4QJi5qQ7UiYXlnci9YUO582OttEU/b+y84GEos4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E4aSCSxzk4px2ZLNOscdSGFluayf3W/2+DbIG6SVGNmN+JNFlOEBSkx3PvZR109AP
	 DlSBCC/9LWdr7ovIV48BB9TjC2o9j1583yXfEIpyuWwYYPDUWMzLSeiedJS4X4eQDs
	 n2y38QA3KFjmSUopDRwjWJWfOrDzBJ8LHuEkb6bU=
Date: Tue, 20 Oct 2026 09:59:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: co+0ea1ac045375cf05@bugs.sh, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be
 present in __vlan_insert_inner_tag()
Message-ID: <2026102010-hazy-clear-1f06@gregkh>
References: <20261012163331.45783-1-alexevgmart@gmail.com>
 <20261020074534.277692-1-alexevgmart@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020074534.277692-1-alexevgmart@gmail.com>

On Tue, Oct 20, 2026 at 10:45:33AM +0300, Alexander Martyniuk wrote:
> just a friendly reminder
> 

Of what?

There's no context here...
