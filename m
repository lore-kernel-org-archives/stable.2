Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE530EF6C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787030429; cv=none; b=p187eqqyFHIQ1fqJzPCqoldMPal60fc8YehQ4WQYwO2OMeMDZUGh7S8ViVMNXHXRXhOcaEJGQPWbXWOU0BJ5MNXFfOuDv95kUglVSsqwkXyHqA7ARCjH9OvWm4mrjGhB3s9WuzqI/rJwjk5OJ7LITMtoX5BDqir039UoCzYWHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787030429; c=relaxed/simple;
	bh=H/zOlGcY83fmIIgH5EXSWiy0LGwiarK4zHNCO9l+iUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDUH8Ne2hgJmj8A/gzZpEmvvNy7Rda2FMHDZGWcqX2/4uL9TUNk7pyuTMKwlRuFIW6OzmklXCoZASG9NkTzxUnYXvmTfIsr0iZXX13ZA6rO1NjGwfHRNvukOHW4vJyECDfogYFPqNsv0BQGtWXegZGPJRnYNwDe6/OEIMG4eDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDUk/LaN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDUk/LaN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4638292b3a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787030427; x=1787635227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guhfkRusufvBWD8H2or6jNYjgUQNUVh/3Ni9l2mmIoM=;
        b=lDUk/LaNP85ZQHPwh3yhZnIyAIK2qwpQDuiwHUi6pPpUBJrI8jlKHZ61Wn1avakq5Y
         syXI/33gY0uPb12SuAQF/Beu7WG3aUUkVFgpdJJJIgiDjAA2J4t4y8RuepBl4jGXUBY/
         FFNbtjzJG0QYl7I6Az9FjsxQ9VvzXm2XynpnM1x/GX9gsvd9ADPSdQ85NSRWXQefCDJ+
         HhKHjuMdiB3g0In4BzzZZeCgauNYkpsSzX6zK7TV47r+do3uxDrG3CoKOa7UjNircvbM
         Iim8bLeG1lIORaNMcxdfy5FXrk5UV1No6t+oJnvhIxl5YixyZtlVXQbL4ZRBU3bhI0Nm
         Iurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787030427; x=1787635227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=guhfkRusufvBWD8H2or6jNYjgUQNUVh/3Ni9l2mmIoM=;
        b=cvXmBWAqFZRVk0bL92yJ2rWApSIOPQPBkWMHNxxaZAZp5eMuPdhQge3W6AMR2g2AmX
         sBYbrMWjCXqOm2jrNsu8xSQ+a0hFc5Cq/hteo0svAs1Zmd0BhomXQV1/k8NROWxTw0oN
         O8fT73IE4K60tAWqubJ0NYCmfqpEOPcHiu1DLeAQO6Cvn6oXEeVepIiVJFvMsbn2Z8A2
         zi0u8A/pohmb04kSKVdyYGq3k0Eh7y+r9G46f2H/AnpP5eBgbGYNnyZUp13K3gQwQ2tc
         vEW5zt7+5pS/EghAvnV05+IOxYCcxUEwTm4FT9JA4XtUWeaESQsjUGed/onvsdwC9GsQ
         u3Aw==
X-Forwarded-Encrypted: i=1; AHgh+RqKxIHLbVyYOUASXGn6fF/4m+4/W+5nELxSb+jLWOAVa1R9uMpKyLzJkVbf3cs7S0YAfnMhlkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGL/UUYVIfcDONeJQeqaZKomxrV2BqingPIFJnK5ZOaLCXiOEc
	7v4DD9Yx3YucfJc6Q+PTYnCMEmGQxvQGRFu3IjrgzsfcPMoKkBWHI1Zv
X-Gm-Gg: AR+sD10B+ND2xhty6d2AzRz1K1+683h974W3gsy047rDTUVd1IXICcqHEpfvb9ShiWb
	qdJgVmOFyvVA2RZ/G9Y3NxumE4/FP37rOea8ZZ2dC7KXkAB7R400RUTfO9pcOk+5igncdOVE633
	QaS1IIEhrMRxp0NkdgZV14xtkvRGqrleHIBojvd2pDrGwII6NglHZRKh2WK5ZYFxZBDPyfBNOSi
	KfrzyMW6JeZxl8L93fGzgdnUS3/3q6+U8P0fHmKYoUS17UKzaBo2XNANMb/1dSOnawufmwOK/sV
	93ydRE9AW2QdKnNz35OL1buopuCBAkz8RZYCbaOxRiFRHhcxNAZT7Bl99oqwD/HjzV26R36Wfzu
	DziG4UH9ruahD8FnSNTSyjsQGSloLqHjA9OYUpKMg9KIEk7s5ktCDpmVOFofWmYOEQa/xqaGtCt
	vr1dz4NWm2jrdfDrKe9jLpu/qYY6LnwrcdSkxqv9z8vReRin9VXskGlyv+3uUUKkEeaYTWHhxbK
	A==
X-Received: by 2002:a05:6a00:4ac3:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-84fde001affmr34125452b3a.13.1787030427076;
        Mon, 17 Aug 2026 22:20:27 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6ff0e3csm1046621b3a.60.2026.08.17.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:20:26 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: properly account locked pages
Date: Tue, 18 Aug 2026 14:20:06 +0900
Message-ID: <20260818052006.2387242-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the patch.

I tested this v1 on its stated base with an x86_64 KASAN kernel. The supplied
selftest passed 6/6 in three boots. Additional fork/unmap and inherited-VMA
mremap tests also passed.

One question: the inode stores the creator's user_struct, but the fault path
uses the current task's RLIMIT_MEMLOCK.

  secretmem_init_inode_priv():
    state->user = get_uid(current_user());
  __secretmem_account_pages():
    page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;

With A limited to one page and B to four, A created the fd and passed it to B.
B faulted four pages, after which A got SIGBUS faulting one page on a new fd:

  CROSS_PRINCIPAL receiver_pages=4 creator_fresh_page=0

This seems to charge A's locked_vm using B's limit. Is that intended?

Thanks,
Daehyeon
