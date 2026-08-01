Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7E2F25F3;
	Sat,  1 Aug 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622417; cv=none; b=D7Eqi9GzQl9tURllTphbOfHxGGTr+IT9ejZSekhHVmJU5KoMOnepcNYP88KhYwtCm+KSdc2Y1kXDJhVyWpfqUx2Z+VaJIt12Lm6VC0IShy3LTX7IRQd9fmtFrtxrHha5K301JbBQKqn7Xs0KWeUaOoHn5sSjMJaNl1ZV/qQRMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622417; c=relaxed/simple;
	bh=9NtXCL9IDnkAUFgkjurTIrGesbn+7uONAG5dpUVy4T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOPJ5zON4cdwywtI8uiF/4FKGE0e6cFoyRxMGl2XaNfnjuNW8RMz7T/lDhwCyQfk1R5agdPIJASNCQkV4DkZjdbJ9lTclzRlWXIRPNTs5GAQX0V0RCXm37gKLrSrgz/Q5PFXfc3Qlak4aJ8Bgso7gj+tK3hmXK6TJKBp+iYz95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHQ48hiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHQ48hiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9911F00AC4;
	Sat,  1 Aug 2026 22:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785622416;
	bh=bJlf7pM8cQ9k6pN6Z+iBJo1RCv8LUiKgdv4RzZxWTG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHQ48hiKz+BNyDU9fHVDIqIZJBlkiqkPt3/uELYYIKbkaopRQfFBYqWNa+05oNCIZ
	 mQ4Zb8k7kQpZu5WPzZ8uD6pj/F6KDOp5920KZ8TffbSRNfxkntwgW+FQMG0CkOH47+
	 bwLyVViqoXPP789cIg7+UXQXiRv82IFQDAxr9UVFf4yFqDGAnM2h2ehQWTuXxK2IQg
	 lWZN+Ffkbyf4Wcn0smhekHkZKU5ueE7vAGqsymLDY10vekONWsNxbmG1+uOyR4ulQl
	 ARiaix8HMFzOKo2ev3Wyeyp5rRTcyVEAiKrCioYf34fuqxhxjlHn6VgYkguvFOnYTW
	 Nbl3iWOKrgEnA==
From: Sasha Levin <sashal@kernel.org>
To: Danielle Costantino <dcostantino@meta.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [7.1.y 0/3] mm/slab: fix unbounded recursion in free path with memalloc profiling
Date: Sat,  1 Aug 2026 18:13:26 -0400
Message-ID: <20260801154223.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801122533.319272-1-harry@kernel.org>
References: <20260801122533.319272-1-harry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 01, 2026 at 12:25:30PM +0000, Harry Yoo wrote:
> This is backport of "mm/slab: fix unbounded recursion in free path with
> memalloc profiling" series [1] for 7.1.
>
> The last patch has a slight functional difference compared to mainline
> due to lack of SLAB_ALLOC_* flags. I described those subtlties in the
> backporting notes in detail.

Queued the series for 7.1, thanks.

-- 
Thanks,
Sasha
