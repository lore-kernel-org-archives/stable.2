Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB04718E5;
	Thu,  8 Oct 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495098; cv=none; b=NN9X7IH6FXZoiRtPCYZYrc026wd3Qs+uJDkcHU21+htZq9T7VMZqUChNcxu5Cr41XPu/6snIHjCPDHA1Lzf8Q6kbPyC/95gGhmk72T3h+ivaVhubT4sXTOeja+R9YATfQxspcpffvC+IBsKRVnhTgrj9fhpLf8GNdGfCI/azGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495098; c=relaxed/simple;
	bh=TVe28LHzQfjbQVRJhm1xQ9aiwBzofB8V7E080+nv6fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCnYHExRkOjpXZlzT/aMimNri6uRN7idseR/NU/E8wKDNBDQ7q1VZZgR1QqSJ5+gIWKD0xnytOsSMEBoooKp4h4fdszdHhIRNtOG60EDkmXqAEIiuy+qP0QrIIf/NJfcnfJ+8CwZVEk85nqtnlKoqGaUYHbLDqqln3CWy52KWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OfW+ck+y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OfW+ck+y"
Received: from mac.lan (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F3D820B7166;
	Thu,  8 Oct 2026 14:30:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F3D820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791495039;
	bh=TVe28LHzQfjbQVRJhm1xQ9aiwBzofB8V7E080+nv6fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfW+ck+yQNya9Wy/bLyTDJiInaDSlBXjrRCUA7CEYdAa+ZHqXdohWh+Ml1rOLYF5Y
	 gdQlUAzyvo9nJsnwIDcxI79nGOoxB/2Hz+NNwZfNicxL+JgYwmWJZ/VJ0F5ZhsrbJh
	 2kDqCmVGibM5Nq1uE+m/6ndEcR/i1yEBetRmXw/c=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: edumazet@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	cenzhang@linux.microsoft.com,
	davem@davemloft.net,
	david@readahead.eu,
	enrico.pozzobon@dissecto.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	jlayton@kernel.org,
	kees@kernel.org,
	kexinsun@smail.nju.edu.cn,
	kuba@kernel.org,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nicolas.dichtel@6wind.com,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] netlink: do not copy to user space under netlink_lock_table()
Date: Thu,  8 Oct 2026 17:31:10 -0400
Message-ID: <20261008213110.88812-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAL4Wiir+CBGE=hXxHEBkyk0Au9B6G3=AdHFd5botrC-FF5BM5w@mail.gmail.com>
References: <CAL4Wiir+CBGE=hXxHEBkyk0Au9B6G3=AdHFd5botrC-FF5BM5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Thanks for your time and the detailed explanation. I withdraw the patch,
and will take the points you raised into account when validating future
findings.

Thanks again, and sorry for the noise.

Cen
