Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9B271471
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617628; cv=none; b=ERpzIv7hx4KuD2Dh9dbbK+ehIdfAbIfQWiDLESd2Sj0Zw6ljt3JxN1sz0npgoAz7paPzcDvQmLfgDtQjDi1riG1PlUuIk0QQ2Dk5V6FYCs1lFRa3JLy3hbA4jaEOIP/QiXOLa9npgK3hqvkctqMjjQFUZiNDOu3U2z11eCucYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617628; c=relaxed/simple;
	bh=T9eX0HoxMQTegFtqEjtBtcRKf2ITUsBnNuu9jlNcLTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X70jvGo4l903wBazyZKMhJSlLi6NRVZrQjuunx74Lg5XESMZen+6+pri62dDghBn28wEvHuDedF5Oxm75AcDkl2Q7GLvHA3CyYSwrfLqf0I5r2/ZECjGFfMTKfkrokJKUY5bAQDqHPOqBg9vGgz7vZ6V6fXz14KkfvJLwjMQWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ornF/Gqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ornF/Gqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D541F00A3E;
	Sun, 28 Jun 2026 03:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617627;
	bh=T9eX0HoxMQTegFtqEjtBtcRKf2ITUsBnNuu9jlNcLTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ornF/GqxO3uKVQoouCrfc4fpDJYOU3KR4m3JbLZr4BzK629HakolNggJHCx+9nZpt
	 rGnctcmdAQj4/KUBkffwCFJuVcOSEnfvFy2GwiVZC2LhjM4QRJErZ3YHgb6aXqtz6B
	 qskzV8+/2rp7fWDx0qRTI4GAY3tVg5qn35ZfRFjeDUjFfrH2Vf7a7l6r3Tj7aa1ZcJ
	 ikArhYbaok0OSZRmYBYdJsL7G6dTOWfvI+SNB2hotVoL5WERju99d80B83gQ4yz3pU
	 m4iYGo4NClEDmv3zA4DreT0v7iEePWP9xRZZkjIDzept56r5TmsgOPAVj/CEE9LxoY
	 m2Sq8GoH1JwWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.6 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:35 -0400
Message-ID: <20260628032401.0005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:11:14PM +0200, Sven Eckelmann wrote:
> [PATCH 6.6 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 6.6, thanks.

--
Thanks,
Sasha
