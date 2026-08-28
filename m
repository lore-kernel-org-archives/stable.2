Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3393F105D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881609; cv=none; b=nsGvUwThTgSx+CjSwd43IvXk/J4qoQ2hFpRXajOH9B/xfSorSBKZIekjyzqun8xG7z6cIxsHjJmy/DcVmLnMTlS43da18CPxWRcV5BTaso0BUtFEcrT8/9CFkgrS5GDJrGW/+xTzOkv+YlXJmpTmUcLosjsC1jbMrbddsDArd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881609; c=relaxed/simple;
	bh=LqeEhgQJU6fA0sE39LUqPbRr4QU4lXMU4ZGx9sx8Oo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw6z9lhZK7hpYUzqH3QN3JzYxc/gNAUDY9nhjbG4G9jCY2Vct5sOJdoarTa382wPE8ZBLiAy/fsIDVqOY6k88EbY4PHw9Iz42Ndgqq4FfxmJYuNd62lJL8Sexc7uAI0BebAfMLwuNHm3K/iHL4ZD+wyptp+3KYPMErs7CeCzAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnFoaf/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnFoaf/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E8F1F00A3E;
	Fri, 28 Aug 2026 01:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881603;
	bh=YU9cSeyuqeAw2cu/4kQRCTCgGFVtZ1e/c7+7NbIK8hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dnFoaf/ELY1eSVbPNP/HfOIIVFqwJ+lB64P7hc4RF8AbevgpzG/l+asYOe8EgnL3g
	 RmfcqpzvEbuQg32V8frNGyivEoifIq0Vl4PcUJTWGzU442n0TcmUVKkoWtGgq0XwDb
	 cFPTOL6naFYjvHxxwRJQIlUscvl7A/+tEddGsCd5f7xLfU7LqfYsQv4TjWACzSUSei
	 nvyZavZM5z2yBYfuNS7mBm6IbRHhaB9nbk5BnZNryPjLog/qm5WLulRrGczLdzo8H/
	 VNSVf1fPPX997O9lnoFM3zjHeSbl8Ho7NNOGm7t2SgzHHg8BZOrsUXqztYAFSt31vX
	 TxZsVahzTxUhw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 5.10.y] s390/vfio_ccw: Implement a crw lock
Date: Thu, 27 Aug 2026 21:46:27 -0400
Message-ID: <20260827-stable-daily-0014-vfio-ccw-crw-lock@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082504-prewashed-juggle-c0c8@gregkh>
References: <2026082504-prewashed-juggle-c0c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does not apply to the queue :(

Right. It collided with 87d569cb35a5 ("s390/vfio_ccw: Cancel existing
workqueues"), which was still only queued when I sent this. That has now
shipped in v5.10.267, so I will rebase and resend.

-- 
Thanks,
Sasha
