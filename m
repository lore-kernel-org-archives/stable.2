Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2263A875E;
	Fri, 26 Jun 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=coM7fRm7AYOxX2zQ+1+TrrdETQKKxCaksQb6QNltuIDBwIUeVHF8Z6CncUBe3cLI8Pa2DetxMaUaCRlJ9jQTbhgQAm4Xkq4+b5absTYaMYZk3GxQFBY1m+i2XA8k3xvIv8wLgw9MGzNrKv41sRGqIpP6KaeDkRYmPImMFi9ONDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=ELn6h1ttvxAzFvKTNdapUccR6fHKmg4v6a7+fl96r8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkK2C4wUw+Ndt72+GOkt5FKAn75c4seLOrgR7f6xY5/ShHoRzb5rZdzimgj33HmrgH/Poenaq5qBUJV2WozluvxlKty3HlrKwji41rmL2hvtDmKslKsM2f7nxKXUQIr/fVAx1I5cI0wR8RVBzSpeLkIGl0BWTlSNloFftcm/FY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw+x5j6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw+x5j6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5601F000E9;
	Fri, 26 Jun 2026 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496493;
	bh=U0DKzD8W+ahTP+aPFWbRrVUufFzDa49I31URXMIcIrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aw+x5j6+lEx8uy/y3YHpBud6tE5zThmfob/uKV36hXdmCkEZFc4GZvmeB6SaBvifm
	 ba4632iXzze/7eIiPjxhxGQb+zpMkW/ei4bA8QexJvDGFo0wi9jdQobcJujH5gM946
	 turysGATKSa12EiEFgkZu3OOQcZaoDRWPwwXCf7eP8Ban0Kqs53EzVE5GrPsKev3pQ
	 YWIVNjWahTinVJXB5dwLMmZe9CWwWx3rxWJAeTjUbbviOa/MBGmUlNdoC0g+5TLLXn
	 +DcLAC6FgfSWms8tA8Nlte6q7TCZnoLTjuZp0x6xepORtNZRWYT2awwSogMLVztuSV
	 wZqhedw1DDW/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:24 -0400
Message-ID: <stable-reply-item006-role-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112437.1777775-1-pbonzini@redhat.com>
References: <20260626112437.1777775-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
