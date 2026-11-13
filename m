Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604257;
	b=UKpRdtvmKE+KQuTAH3Hei26PU0Grk1wk7J21KHjMQ5P/RHPmebPkYKD9ImFxjEY9BTxa
	 4bQv5YIbHOG/WLx3rI5/PhL6vnK21t35/2b3u5hmW1CrkkDhx16KQ+VYNB1p5HTWaCVwT
	 i9ttydj/smIQRQ3ZjHAEtwDMrEW3NW4e2v6FDEizV01PLt3WZrbEnkFtrERvMT9xqMMCt
	 AkLqNTp+X75lLZUhOLR0Ktr855twGg1aKnTlS8haEKubvXslei07VmnAXbqVeN0/tLf0U
	 1V867x72OHrRtf5OQ2E1hbwqpqymuorBdaXCEC4V7772rn/aVUDHJ0W5m1ue+MjzonQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=woAy0d8eRRcTuv2sX9SO2fVmGylcnK0pSyo3soQzkhs=;
	b=Qnmq3388n1daJmkSYuJPyXqz8J3GxoJUUAe+hSwnYyd031Vl2QlbSLR8p1FjU//r4Q0U
	 LoqR5Gx//4YW/m6r31p6RYtNSEDNLPtavHoIX5IK66GQQdQGRf/OUK8kSPEnjnVZo6s5i
	 EvC5zvNfUraQ6dxKsLXnC4RapqiC4d0UV9XzmWWo9WwOOusrdV8kXXRQQcHY4L9jMY2vH
	 s6/wv5mex/OQtU8wKVx7ExzgIHyqoNkMf6p3SepaGFupuYKQ6IlzDeQYz5ZT/rLhWB8pC
	 +a79YEdV2X+REjVfnGmwm8CdTu/TC+vx6EoH8uLEYYfehmuMuwWyhsNFb4A5GZGyZng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpgNN4Up;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE6606A330;
	Fri, 13 Nov 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpgNN4Up
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9791F000C5;
	Fri, 13 Nov 2026 21:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604257;
	bh=woAy0d8eRRcTuv2sX9SO2fVmGylcnK0pSyo3soQzkhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fpgNN4UprwXgj/HxHbTVI/comjJrFyYaY1gAJjVko+aaQStJXe6gZ6xdtXsX7QKNv
	 ckbQO122b2CDerOrdG8MCuTM70zSzP3rsutrkoQ6cqUH4b/u5s5c/MmLrux5jG+HRc
	 5uyB6WAuTBizeTvbFfqT0QU+JnAXw0ZqUFh/7QI/uQ4UTQBvQEigzA/JuDo8iG8/gI
	 tO+2TUlQWL0CjRNdndg7xQooNKdwX/UgyWFonLENlUAXujlNRe5uOo6vOpNj1JQgJk
	 Jn8+16Qcnrc7FBJ2HcyxXAVcUrum3pbsVxDZvzpJrUicauqflHOwgIgHxCsep1Aiq1
	 z0vvlHVANazKQ==
Date: Fri, 13 Nov 2026 21:10:51 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
Message-ID: <avd8raDA-DooZ2gL@gremlin>
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
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
In-Reply-To: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>

On Fri, Nov 13, 2026 at 09:04:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> v2:
> * Updated to just zap everything as per David + Tal.

Sorry, forgot to mention that I had to drop the tags because of the new
approach.

Would appreciate people looking at the v2 fresh :)

Thanks!

>
> v1:
> https://lore.kernel.org/r/20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org

--
Cheers, Lorenzo
