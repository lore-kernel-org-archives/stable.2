Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678150;
	b=3qm7+/EWIbvpCy3nBpD11jkDI+v4cXxnz1qYJ1pxpRTPV0Pnmi1llz3162ns/bcZB40b
	 N6azxXZO6FawZeMqrDqoSU6p+9PjCpWKFEhB2Uat7Az2lR/2Te7/r11si1tcXmPHL2EbC
	 Lmsvsnjl7LSjZW3bbTAkT7s1+SSE4LTj9KuA3MSb5J+xeZdgf61g5jOf+3r+ABxqUHTHv
	 f05z+hgsJnegKJWYDQ+L4U4yR1eyJqMH8UdpMgf0QA2utfYNu8Yvl+IdIs2osHp3v8nmm
	 uNPOwXdkPs+02aaQYP+enyRAeTdUToD+6fBS16OTV/vbCpGqW1XSEQVuO6LP3IFmYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678150;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tjJIn53SeRgzticjhYcZt/S8hFkKcBKo2OoOcabCRpQ=;
	b=wz9YBmysY9amcV4InI3AF4u70t65qh4BhXXADEVcLiAB5rlHhADYibpmSbRRQkndbWhS
	 ItcRO75ysNMneMA+21ZTSNiHAr18cP6f/hP5ubiWWYwzM6ZPhakHwIdfXkfeo+3yq+2ZQ
	 OFHB7t0aItovQGDN3KHzyOFIw4fu/2bngFznK8a/rT4U6zsTMY8FwDQjRNBqIRUdKOBSm
	 CN1iqmgjb7n2VLmKJgVuT/awVsIlx33QjeMg4OoNy51XoMj6ezesy3vTBX+/CuBdKKhoE
	 iNq3cvP75rbCY/QrQjvBWSTXfo3GELMiJrQ4vaESOqKaot1anhjuGZp7R+D+CFJP8vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ2dBoAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524F606A339
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ2dBoAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B2D1F000C4;
	Sat, 14 Nov 2026 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678150;
	bh=tjJIn53SeRgzticjhYcZt/S8hFkKcBKo2OoOcabCRpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJ2dBoAqHjz8/F786o5/Y9CxzV/REJRQXL1k3pFncNgkbmUqedE3l0e/jM++X+NTl
	 Pt29Mv5LRzK27RHetlvk/ObF/ncrvB9KYyZdjG6bzQILHFuMYsgiNfRr6pNhK/95BZ
	 uYInsRkigTMZzjJaZaVTobUGxK3tOTip8PAZdepdciJki8yG1lpYGURS/msAXqzqr5
	 umyf57nTxokDHt77JNAB/xUvX8+XQ9nmUsZKItNCnO4u3G1lmBTdlFof75X8rGz8FA
	 fKfolLzEXLX2csrxk76WFMMp32kCqaI4vGabv/1xyfbPYiMxGCoO79OgjOwJvoLMSf
	 vU1mqXNaWJWEw==
From: Sasha Levin <sashal@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 6.12.y] khugepaged: fix readahead lock inversion in collapse_file()
Date: Sat, 14 Nov 2026 12:42:16 -0500
Message-ID: <draft-agent5-0005-re-khugepaged-readahead-lock@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a849043e-8421-473f-a7de-8030482bd5b5@linux.dev>
References: <a849043e-8421-473f-a7de-8030482bd5b5@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-14, Lance Yang <lance.yang@linux.dev> wrote:
> > This additional change to address the same deadlock makes sense to me.
> >
> > Acked-by: Zi Yan <ziy@nvidia.com>
>
> Much appreciated, thanks!

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
