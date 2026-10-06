Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E43F3DDB04
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322601; cv=none; b=YlIvotT9R0l/eo3kOGp4P1X7PtLXnD1GSE9mb8RJocHwYgG1ZDWkPTEe0PRUAa2F67WEdO1XTmeiBAM3lMo/r6sMEyjouxR086JAM11z69YBDeifj5qvRvlHg4pfthNqmcCTIfmlFnzpsY7Piqo3l6k+IpkXpZPV7yQ7e724dfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322601; c=relaxed/simple;
	bh=ZpIHXtVseWNFHHUSVelJpw+1IhQb66W375ETm9Bbv5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stbQdiRU5BL0sVTwlA/QIrCZUeCJJ/RZT7tJxM+vSEtKNQ4zPpIP7zd0CvF6cblpL7E1RvNzqfSpEWr58ljvs99fSdEKchbnaI6QrzHRT6t1AgVK0TDHAPgKZqBwQ+Qrrr89C2qDjjh1W5IPWzTRE4aEzIR3M0AniptM5uZz7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQJKqehR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQJKqehR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3711F0089C;
	Tue,  6 Oct 2026 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322599;
	bh=X3wxRwcB96ePnjtSL1ZonlLvHtwvTCZQop5wJN5DuI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQJKqehRY/ZpUziqPtPQBDl8C/4nEBvN7NYEVZYGVmBQb7yXo2zfAz3G5QZ+DNl6s
	 f298hAZ8KCC5jcPIndAl20FmRmqaXEcd5Qgdb2p8w3nenQp6oDZWEVbFLn4juSYaAa
	 g1CjSCMgu1LqXKlRWv87gam57RDTUN8tQvPt5Pks0irDAGXxRbVQfrU/z4aFwKjw4h
	 i9zBAoEN/Tmp822m6gqhOyPmg4+W4B4CZefLdlf1kNdWvEycY7mIgXgnoIGQ7xnfMB
	 +j9HUi+pP18AUqSMHH3koSM21+70FUN+U2rYwR/74kvcxgYXDSimpHfC0552hQzfiM
	 NaewUOkp87g0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Frank Sorenson <sorenson@redhat.com>
Subject: Re: [PATCH 5.10.y] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Tue,  6 Oct 2026 17:35:50 -0400
Message-ID: <2026-10-06-1-daily-reply-0018-smb-cifsfileinfo-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005175231.3953493-1-sorenson@redhat.com>
References: <20261005175231.3953493-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446 ]

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
